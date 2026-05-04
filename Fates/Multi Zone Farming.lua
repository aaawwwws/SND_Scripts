--[=====[
[[SND Metadata]]
author: 'pot0to || Updated by: Minnu'
version: 2.1.0
description: Multi Zone Farming - Companion script for Fate Farming
plugin_dependencies:
- Lifestream
- vnavmesh
- TextAdvance
configs:
  FateMacro:
    description: Name of the primary fate macro script.

[[End Metadata]]
--]=====]

--[[

********************************************************************************
*                             Multi Zone Farming                               *
*                                Version 2.1.0                                 *
********************************************************************************

Multi zone farming script meant to be used with `Fate Farming.lua`. This will go
down the list of zones and farm fates until there are no eligible fates left,
then teleport to the next zone and restart the fate farming script.

Created by: pot0to (https://ko-fi.com/pot0to)
Updated by: Minnu

    -> 2.1.0    Added per-zone and session efficiency tracking (gems/hour).
    -> 2.0.0    Updated for Latest SnD
    -> 1.0.1    Added check for death and unexpected combat
                First release

--#region Settings

--[[
********************************************************************************
*                                   Settings                                   *
********************************************************************************
]]

FateMacro  = Config.Get("FateMacro")

ZonesToFarm = {
    { zoneName = "Urqopacha",       zoneId = 1187 },
    { zoneName = "Kozama'uka",      zoneId = 1188 },
    { zoneName = "Yak T'el",        zoneId = 1189 },
    { zoneName = "Shaaloani",       zoneId = 1190 },
    { zoneName = "Heritage Found",  zoneId = 1191 },
    { zoneName = "Living Memory",   zoneId = 1192 }
}

--#endregion Settings

------------------------------------------------------------------------------------------------------------------------------------------------------

--[[
**************************************************************
*  Code: Don't touch this unless you know what you're doing  *
**************************************************************
]]

CharacterCondition = {
    dead          =  2,
    inCombat      = 26,
    casting       = 27,
    betweenAreas  = 45
}

function OnChatMessage()
    local message = TriggerData.message
    local patternToMatch = "%[Fate%] Loop Ended !!"

    if message and message:find(patternToMatch) then
        Dalamud.Log("[MultiZone] OnChatMessage triggered")
        FateMacroRunning = false
        Dalamud.Log("[MultiZone] FateMacro has stopped")
    end
end

function TeleportTo(aetheryteName)
    yield("/tp " .. aetheryteName)
    yield("/wait 1")
    while Svc.Condition[CharacterCondition.casting] do
        yield("/wait 1")
    end
    yield("/wait 1")
    while Svc.Condition[CharacterCondition.betweenAreas] do
        yield("/wait 1")
    end
    yield("/wait 1")
end

function GetAetheryteName(ZoneID)
    local territoryData = Excel.GetRow("TerritoryType", ZoneID)

    if territoryData and territoryData.Aetheryte and territoryData.Aetheryte.PlaceName then
        return tostring(territoryData.Aetheryte.PlaceName.Name)
    end
end

function FormatDuration(totalSeconds)
    totalSeconds = math.max(0, math.floor(totalSeconds or 0))
    local hours = math.floor(totalSeconds / 3600)
    local minutes = math.floor((totalSeconds % 3600) / 60)
    local seconds = totalSeconds % 60

    if hours > 0 then
        return string.format("%dh %02dm %02ds", hours, minutes, seconds)
    end

    return string.format("%dm %02ds", minutes, seconds)
end

function RatePerHour(amount, seconds)
    if not seconds or seconds <= 0 then
        return 0
    end
    return (amount * 3600) / seconds
end

function GetZoneStats(zoneIndex)
    if ZoneStats[zoneIndex] == nil then
        ZoneStats[zoneIndex] = {
            loops = 0,
            productiveLoops = 0,
            totalSeconds = 0,
            totalGems = 0
        }
    end
    return ZoneStats[zoneIndex]
end

function LogZoneEfficiency(zoneIndex, loopSeconds, gemDelta)
    local zone = ZonesToFarm[zoneIndex]
    local stats = GetZoneStats(zoneIndex)
    local loopRate = RatePerHour(gemDelta, loopSeconds)

    stats.loops = stats.loops + 1
    stats.totalSeconds = stats.totalSeconds + loopSeconds
    stats.totalGems = stats.totalGems + gemDelta
    if gemDelta > 0 then
        stats.productiveLoops = stats.productiveLoops + 1
    end

    local avgRate = RatePerHour(stats.totalGems, stats.totalSeconds)
    local productiveRate = (stats.productiveLoops / stats.loops) * 100

    Dalamud.Log(string.format(
        "[MultiZone][Efficiency] %s | Loop #%d: %+d gems in %s (%.1f gems/h) | Zone Avg: %+d gems in %s (%.1f gems/h, %.0f%% productive)",
        zone.zoneName,
        stats.loops,
        gemDelta,
        FormatDuration(loopSeconds),
        loopRate,
        stats.totalGems,
        FormatDuration(stats.totalSeconds),
        avgRate,
        productiveRate
    ))
end

function LogSessionEfficiency()
    local elapsed = os.time() - SessionStartTime
    local sessionRate = RatePerHour(SessionGemDelta, elapsed)

    Dalamud.Log(string.format(
        "[MultiZone][Efficiency] Session: %+d gems in %s (%.1f gems/h) across %d loops.",
        SessionGemDelta,
        FormatDuration(elapsed),
        sessionRate,
        LoopCount
    ))
end

FarmingZoneIndex = 1
LoopCount = 0
SessionStartTime = os.time()
SessionGemDelta = 0
ZoneStats = {}

while true do
    if Player == nil then
        local msg = "ERROR: Global 'Player' object not found. Please ensure you are using SomethingNeedDoing [Expanded Edition]."
        yield("/echo [MultiZone] " .. msg)
        Dalamud.Log("[MultiZone] " .. msg)
        break
    end

    if not Player.IsBusy and not FateMacroRunning then
        if Svc.Condition[CharacterCondition.dead] or Svc.Condition[CharacterCondition.inCombat] or Svc.ClientState.TerritoryType == ZonesToFarm[FarmingZoneIndex].zoneId then
            local loopStartTime = os.time()
            local oldBicolorGemCount = Inventory.GetItemCount(26807)

            Dalamud.Log("[MultiZone] Starting FateMacro")
            yield("/snd run " .. FateMacro)
            FateMacroRunning = true

            while FateMacroRunning do
                yield("/wait 3")
            end

            Dalamud.Log("[MultiZone] FateMacro has stopped")
            local loopEndTime = os.time()
            local newBicolorGemCount = Inventory.GetItemCount(26807)
            local loopSeconds = loopEndTime - loopStartTime
            local loopGemDelta = newBicolorGemCount - oldBicolorGemCount

            LoopCount = LoopCount + 1
            SessionGemDelta = SessionGemDelta + loopGemDelta

            LogZoneEfficiency(FarmingZoneIndex, loopSeconds, loopGemDelta)
            if LoopCount % 5 == 0 then
                LogSessionEfficiency()
            end

            if newBicolorGemCount == oldBicolorGemCount then
                FarmingZoneIndex  = (FarmingZoneIndex % #ZonesToFarm) + 1
            end
        else
            Dalamud.Log("[MultiZone] Teleporting to " .. ZonesToFarm[FarmingZoneIndex].zoneName)
            local aetheryteName = GetAetheryteName(ZonesToFarm[FarmingZoneIndex].zoneId)

            if aetheryteName then
                TeleportTo(aetheryteName)
            end
        end
    end
    yield("/wait 1")
end
