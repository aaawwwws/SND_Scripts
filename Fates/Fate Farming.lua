--[=====[
[[SND Metadata]]
author: baanderson40 || orginially pot0to
version: 3.1.10
description: |
  Support via https://ko-fi.com/baanderson40
  Fate farming script with the following features:
  - Can purchase Bicolor Gemstone Vouchers (both old and new) when your gemstones are almost capped
  - Priority system for Fate selection: distance w/ teleport > most progress > is bonus fate > least time left > distance
  - Will prioritize Forlorns when they show up during Fate
  - Can do all fates, including NPC collection fates
  - Revives upon death and gets back to fate farming
  - Attempts to change instances when there are no fates left in the zone
  - Can process your retainers and Grand Company turn ins, then get back to fate farming
  - Autobuys gysahl greens and grade 8 dark matter when you run out
plugin_dependencies:
- Lifestream
- vnavmesh
- TextAdvance
configs:
  Rotation Plugin:
    description: 使用する回しプラグインを選択します。
    default: "Wrath"
    is_choice: true
    choices: ["Any", "Wrath", "RotationSolver","BossMod", "BossModReborn"]
  Dodging Plugin:
    description: 使用する回避プラグインを選択します。Rotation Plugin が BMR/VBM の場合はそちらが優先されます。
    default: "BossModReborn"
    is_choice: true
    choices: ["Any", "BossMod", "BossModReborn", "None"]
  BMR/VBM Specific settings:
    description: "--- Rotation Plugin に BMR/VBM を使う場合の専用設定 ---"
    default: false
  Single Target Rotation:
    description: 単体用プリセット名（主にフォーローン用）。このプリセットでは自動ターゲットをOFFにしてください。
    default: ""
  AoE Rotation:
    description: 範囲攻撃とバフ運用を含むプリセット名。
    default: ""
  Hold Buff Rotation:
    description: 指定進捗以上で2分バーストを温存するためのプリセット名。
    default: ""
  BossMod AI Preset:
    description: BossMod（無印）使用時に有効化するAIプリセット名。空欄の場合は "VBM Multibox" を使用します。
    default: "VBM Multibox"
  Percentage to Hold Buff:
    description: バフを温存し始める進捗%。70%以上にすると進行が速いFATEで数秒分のロスが出る場合があります。
    default: 65
  Food:
    description: 食事を使わない場合は空欄。HQ品は名前の後ろに <hq> を付けてください（例：Baked Eggplant <hq>）。
    default: ""
  Potion:
    description: 薬品を使わない場合は空欄。HQ品は名前の後ろに <hq> を付けてください（例：Superior Spiritbond Potion <hq>）。
    default: ""
  Tank Gearset for Level Sync:
    description: レベルシンクが必要なFATEに参加する際に自動で着替えるタンクのギアセット名または番号。空欄の場合は着替えません。
    default: "tank"
  Normal FATE Gearset:
    description: 通常FATE（レベルシンク不要）で自動で着替えるギアセット名または番号。空欄の場合はメインクラスのギアセットのままです。
    default: "dps"
  Initial setup teleport zone:
    description: 開始時にテレポートするゾーンのエーテライト名（例：リビング・メモリー）。空欄で無効。
    default: "リビング・メモリー"
  Summon chocobo on start?:
    description: 開始時にチョコボ召喚を試行します。
    default: true
  Switch to normal gearset on start?:
    description: 開始時にNormal FATE Gearsetに着替えます。
    default: true
  Max melee distance:
    description: 近接ジョブ時の目標戦闘距離です。
    default: 2.5
    min: 0
    max: 30
  Max ranged distance:
    description: 遠隔ジョブ時の目標戦闘距離です。
    default: 20
    min: 0
    max: 30
  Ignore FATE if progress is over (%):
    description: この進捗%以上のFATEは対象外にします。
    default: 80
    min: 0
    max: 100
  Ignore FATE if duration is less than (mins):
    description: 残り時間がこの分数未満のFATEは対象外にします。
    default: 3
    min: 0
    max: 100
  Ignore boss FATEs until progress is at least (%):
    description: ボスFATEは進捗がこの値以上になるまで参加しません。
    default: 0
    min: 0
    max: 100
  Ignore Special FATEs until progress is at least (%):
    description: 特殊FATEは進捗がこの値以上になるまで参加しません。
    default: 20
    min: 0
    max: 100
  Do collection FATEs?:
    description: 収集系FATEにも参加します。
    default: false
  Do other NPC FATEs?:
    description: OFFにすると、NPCへの会話が必要なFATEを無視します 。
    default: false
  Summon Chocobo?:
    description: ギサールの野菜を使ってバディチョコボを自動で召喚します。
    default: true
  Party Play Mode:
    description: PTプレイ時の動作を有効にします。PTメンバーがいる場合に自動で切り替えることもできます。
    default: true
  Auto Detect Party Members:
    description: PTメンバーがいる場合に自動でPTプレイモードに切り替えます（Party Play Mode OFF時も有効）。
    default: true
  Prioritize Party Member Targets:
    description: PTプレイ時、PTメンバーが戦っている敵を優先的にターゲットします。
    default: true
  Prioritize FATEs with Party Members:
    description: PTプレイ時、PTメンバーが参加中のFATEを優先的に選択します。
    default: true
  Disable Chocobo in Party:
    description: PTに参加している場合にチョコボ召喚を自動で無効にします。
    default: false
  Follow Party Members:
    description: PTプレイ時、PTメンバーが60y以上離れている場合に自動で追従します。
    default: true
  Follow Party Leader Zone?:
    description: PTリーダーが別ゾーンに移動した際、自動でそのゾーンの最寄りエーテライトへテレポートします。テレポ勧誘も自動承諾します。
    default: true
  Auto-buy Gysahl Greens?:
    description: ギサールの野菜が切れた際、リムサ・ロミンサで購入します。
    default: false
  Save active FATE data?:
    description: 出現中FATEの情報をJSONLに保存する
    default: true
  FATE data log interval (secs):
    description: 連続保存の最小間隔
    default: 30
    min: 5
    max: 600
  FATE data log path:
    description: 保存先(相対パスはSNDスクリプト基準)
    default: "Fates/fates_active.jsonl"
  Do only bonus FATEs?:
    description: ボーナスFATEのみ参加し、通常FATEは無視します。
    default: false
  No combat teleport timeout (secs):
    description: FATE到着後に戦闘が始まらない場合、この秒数経過で次のゾーンへ移動します。0で無効。
    default: 30
    min: 0
    max: 600
  No movement teleport timeout (secs):
    description: Ready待機中にこの秒数の間移動していない場合、次のゾーンへ移動します。0で無効。
    default: 30
    min: 0
    max: 600
  Prefer dense mob pulls?:
    description: 範囲攻撃効率を上げるため、周囲に敵が多い対象を優先して狙います。
    default: true
  Target engaged enemies?:
    description: 他のプレイヤーが既に戦っている敵もターゲットにします。
    default: true
  Dense pull cluster radius:
    description: 密集対象を選ぶ際に「近くの敵」を数える半径です。
    default: 30
    min: 3
    max: 30
  Aggressive pulling?:
    description: 遠距離攻撃で積極的に敵を引き寄せ、大人数の集団戦を作ります。
    default: true
  Max pull count:
    description: 1回のFATEで引き寄せる最大敵数です。高いほどAoE効率が上がります。
    default: 10
    min: 1
    max: 30
  Dense pull minimum enemies:
    description: 近距離優先から密集優先に切り替える最小敵数です。2以上にするとAoEで処理しやすい複数体のクラスタを優先します。
    default: 2
    min: 1
    max: 20
  Active pull enabled?:
    description: 戦闘中に未戦闘の敵へ遠距離攻撃でpullし、複数の敵を引き寄せます。
    default: true
  Active pull interval (secs):
    description: pullを試行する間隔です。短いほど多くの敵を引き寄せます。
    default: 1.0
    min: 0.5
    max: 10
  Active pull max targets:
    description: 1サイクルでpullする最大敵数です。
    default: 5
    min: 1
    max: 10
  Active pull max range:
    description: pull対象の最大距離です。spawn地点から離れすぎるとリセットされるので控えめに。
    default: 25
    min: 5
    max: 25
  Optimize movement to mob clusters?:
    description: FATE移動中に敵の密集地点を優先して経由し、範囲狩りしやすい位置取りを行います。
    default: true
  Cluster movement radius:
    description: 密集地点を判定する半径です。
    default: 40
    min: 5
    max: 40
  Cluster movement minimum enemies:
    description: 密集地点として採用する最小敵数です。2以上にするとAoE射線が通りやすい複数体の密集地を経由します。
    default: 2
    min: 2
    max: 30
  Cluster movement refresh (secs):
    description: 密集地点の再計算間隔です。短いほど追従性が上がり、長いほど安定します。
    default: 1
    min: 1
    max: 20
  Dynamic AoE switch?:
    description: 周囲の敵数に応じてAoE/単体モードを自動切替します（フォーローン優先時を除く）。
    default: true
  Dynamic AoE enemy count:
    description: この数以上の敵が近くにいるとAoEモードを優先します。
    default: 1
    min: 1
    max: 20
  Dynamic AoE same-name enemy count:
    description: 現在ターゲットと同名の敵がこの数以上いる時のみAoEを許可します。1で同名チェック無効。
    default: 1
    min: 1
    max: 20
  Dynamic AoE check radius:
    description: 動的AoE判定で周囲敵数を数える半径です。
    default: 30
    min: 3
    max: 30
  Fast combat pacing?:
    description: 戦闘中の待機時間を短縮してテンポを上げます。OFFで従来の安全寄り待機に戻します。
    default: true
  Staged anti-stuck recovery?:
    description: 移動詰まり時に段階的復帰（再経路探索→最寄りエーテ退避→ゾーン切替）を行います。
    default: true
  Stuck check interval (secs):
    description: スタック判定を行う間隔です。
    default: 10
    min: 3
    max: 60
  Stuck movement threshold:
    description: この距離未満しか動いていないとスタックとみなします。
    default: 3
    min: 0
    max: 20
  Print session summary?:
    description: 停止時に周回統計（時間・完了数・失敗数・時給など）を出力します。
    default: true
  Forlorns:
    description: 攻撃対象にするフォーローンの種類を選択します。
    default: "All"
    is_choice: true
    choices: ["All", "Small", "None"]
  Change instances if no FATEs?:
    description: 対象FATEがない場合に同マップ内でインスタンス変更を試みます。
    default: false
  Teleport to next zone if no FATEs?:
    description: 対象FATEが無くなったら、次の黄金エリアへ順番に移動します。
    default: true
  Stay on current map only?:
    description: 他マップへは移動せず、現在マップのみで周回します（インスタンス移動は発生する場合があります）。
    default: false
  Exchange bicolor gemstones for:
    description: バイカラージェムで交換するアイテムを選択します。消費したくない場合は None を選択。
    default: "Bicolor Gemstone Voucher"
    is_choice: true
    choices: ["None",
        "Bicolor Gemstone Voucher",
        "Turali Bicolor Gemstone Voucher"]
  Self repair?:
    description: ONで自分で修理を試みます。OFFならリムサの修理NPCへ移動します。
    default: true
  Pause for retainers?:
    description: リテイナー処理のために一時的にFATE周回を中断します。
    default: false
  Dump extra gear at GC?:
    description: リテイナー運用時、持ち帰り品で所持品が圧迫された場合にGC納品で整理します。
    default: false
  Return on death?:
    description: 戦闘不能時、ホームポイントへ戻る確認を自動承諾します。
    default: true
  Echo logs:
    description: ログ出力レベルを選択します。
    default: "Gems"
    is_choice: true
    choices: ["All", "Gems", "None"]
  Companion Script Mode:
    description: メインの Fate Farming と companion スクリプトを併用するモードです。
    default: false
  Blacklist:
    description: 除外したいFATE名をカンマ区切りで入力します（例：FATE名1,FATE名2,FATE名3）。
    default: "空飛ぶ鍋奉行「ペルペルイーター」,怪力の大食漢「マイティ・マイプ」,踊る山火「ラカクウルク」,薬屋のひと仕事,血濡れの爪「ミユールル」,種の期限,恐怖！ キノコ魔物,落ち石拾い,メモリーズ,人鳥細工,モグラ退治,マイカ・ザ・ムー：大団円,人生がときめく片づけの技法,気まぐれロボット,道を視る青年,カナルタウンでやすらかに,逃走テレメトリー,ブロークンボットダイアリー,マイカ・ザ・ムー：出発進行,人狼伝説,コーヒーを巡る冒険,巨獣めざめる,ポゼッション,水の迷宮の夢,我々の貢物,千年の孤独,不死の人"
  Discord Webhook URL:
    description: スクリプト停止時やエラー時の通知先Webhook URL。空欄で無効。
    default: ""
[[End Metadata]]
--]=====]
--[[

********************************************************************************
*                                  Changelog                                   *
********************************************************************************
    -> 3.1.10   修正: /mount と /action コマンドの閉じ引用符不足を修正。
                修正: HasContinuation チェックの論理ミスとスペルミスを修正。
                改善: math.randomseed で乱数を初期化。
    -> 3.1.9    修正: タンクスタンス付与中に /ac 実行して解除されるリスクを軽減（2回確認＋1回限りのリトライ）。
                修正: FATE境界での1pxちらつき移動を軽減（境界バッファ拡大＋移動コマンドのデッドゾーン追加）。
    -> 3.1.8    追加: PTプレイモード（Party Play Mode）。PTメンバー検知・ターゲット優先・FATE優先・チョコボ自動抑制。
    -> 3.1.7    追加: 出現中FATEの名前とNPC名をJSONLに保存
    -> 3.1.6    修正: セルフ修理OFF時でもボーナスバフ中に修理移動するように変更
    -> 3.1.5    Added HW fate definitions
    -> 3.1.4    Modified VBM/BMR combat commands to use IPCs
    -> 3.1.3    Companion script echo logic changed to true only
    -> 3.1.2    Fix VBM/BMR hold buff rotation setting issue
    -> 3.1.1    Reverted RSR auto to just 'on'
    -> 3.1.0    Updated to support companion scripts by Minnu

********************************************************************************
    -> 3.0.21   Updated meta data config settings
    -> 3.0.20   Fixed unexptected combat while moving
    -> 3.0.19   Fixed random pathing to mob target
    -> 3.0.18   Fixed Mender and Darkmatter npc positions
    -> 3.0.17   Removed types from config settings
    -> 3.0.16   Corrected Bossmod Reborn spelling for dodging plugin
    -> 3.0.15   Added none as a purchase option to disable purchases
    -> 3.0.14   Fixed setting issue with Percentage to hold buff
    -> 3.0.13   Added list for settings
    -> 3.0.12   Fixed TextAdvance enabling
    -> 3.0.11   Revision rollup
                Fixed Gysahl Greens purchases
                Blacklisted "Plumbers Don't Fear Slimes" due to script crashing
    -> 3.0.10   By baanderson40
            a   Max melee distance fix.
            b   WaitingForFateRewards fix.
            c   Removed HasPlugin and implemented IPC.IsInstalled from SND **reversed**.
            d   Removed Deliveroo and implemented AutoReainter GC Delievery.
            e   Swapped echo yields for yield.
            f   Added settions to config settings.
            g   Fixed unexpected Combat.
            h   Removed the remaining yields except for waits.
            i   Ready function optimized and refactord.
            j   Reworked Rotation and Dodging pluings.
            k   Fixed Materia Extraction
            l   Updated Config settings for BMR/VMR rotations
            m   Added option to move to random location after fate if none are eligible.
            n   Actually fixed WaitingForFateRewards & instance hopping.
    -> 3.0.9    By Allison.
                Fix standing in place after fate finishes bug.
                Add config options for Rotation Plugin and Dodging Plugin (Fixed bug when multiple solvers present at once)
                Update description to more accurately reflect script.
                Cleaned up metadata + changed description to more accurately reflect script.
                Small change to combat related distance to target checks to more accurately reflect how FFXIV determines if abilities are usable (no height). Hopefully fixes some max distance checks during combat.
                Small Bugfixes.
    -> 3.0.6    Adding metadata
    -> 3.0.5    Fixed repair function
    -> 3.0.4    Remove noisy logging
    -> 3.0.2    Fixed HasPlugin check
    -> 3.0.1    Fixed typo causing it to crash
    -> 3.0.0    Updated for SND2

********************************************************************************
*                               Required Plugins                               *
********************************************************************************

Plugins that are needed for it to work:

    -> Something Need Doing [Expanded Edition] : (Main Plugin for everything to work)   https://puni.sh/api/repository/croizat
    -> VNavmesh :   (for Pathing/Moving)    https://puni.sh/api/repository/veyn
    -> Some form of rotation plugin for attacking enemies. Options are:
        -> RotationSolver Reborn: https://raw.githubusercontent.com/FFXIV-CombatReborn/CombatRebornRepo/main/pluginmaster.json
        -> BossMod Reborn: https://raw.githubusercontent.com/FFXIV-CombatReborn/CombatRebornRepo/main/pluginmaster.json
        -> Veyns BossMod: https://puni.sh/api/repository/veyn
        -> Wrath Combo: https://love.puni.sh/ment.json
    -> Some form of AI dodging. Options are:
        -> BossMod Reborn: https://raw.githubusercontent.com/FFXIV-CombatReborn/CombatRebornRepo/main/pluginmaster.json
        -> Veyns BossMod: https://puni.sh/api/repository/veyn
    -> TextAdvance: (for interacting with Fate NPCs) https://github.com/NightmareXIV/MyDalamudPlugins/raw/main/pluginmaster.json
    -> Lifestream :  (for changing Instances [ChangeInstance][Exchange]) https://raw.githubusercontent.com/NightmareXIV/MyDalamudPlugins/main/pluginmaster.json

********************************************************************************
*                                Optional Plugins                              *
********************************************************************************

This Plugins are Optional and not needed unless you have it enabled in the settings:

    -> AutoRetainer : (for Retainers [Retainers])   https://love.puni.sh/ment.json
    -> Deliveroo : (for gc turn ins [TurnIn])   https://plugins.carvel.li/
    -> YesAlready : (for extracting materia)

--------------------------------------------------------------------------------------------------------------------------------------------------------------
]]

-- Initialize global services for better reliability
Svc = Svc or Dalamud
ClientState = ClientState or (Svc and Svc.ClientState)
Player = Player or (ClientState and ClientState.LocalPlayer)

local FateFarming = {}
FateFarming.__index = FateFarming

-- Load .NET assemblies for Discord notifications
luanet.load_assembly("System")
local WebClient = luanet.import_type("System.Net.WebClient")
local Encoding = luanet.import_type("System.Text.Encoding")

Dalamud.Log("[FATE-FIXED] Script initialized with resilient detection.")

function FateFarming:new()
    return setmetatable({}, FateFarming)
end

local function SendDiscordMessage(message)
    if DiscordWebhookUrl == nil or DiscordWebhookUrl == "" then
        return
    end

    local client = WebClient()
    client.Encoding = Encoding.UTF8
    client.Headers:Add("Content-Type", "application/json")

    local payload = string.format('{"content": "%s", "username": "SND Fate Bot"}', message)

    -- Use pcall to prevent script crash if network fails
    local status, err = pcall(function()
        client:UploadString(DiscordWebhookUrl, "POST", payload)
    end)

    client:Dispose()

    if not status then
        Dalamud.Log("[FATE] Failed to send Discord notification: " .. tostring(err))
    else
        Dalamud.Log("[FATE] Sent Discord notification: " .. message)
    end
end

local
    AcceptNPCFateOrRejectOtherYesno,
    AcceptTeleportOfferLocation,
    ARRetainersWaitingToBeProcessed,
    AttemptToTargetClosestFateEnemy,
    BuildFateTable,
    BuildZoneData,
    ChangeInstance,
    ChangeInstanceDismount,
    ClearTarget,
    CollectionsFateTurnIn,
    Dismount,
    DistanceBetween,
    DistanceBetweenFlat,
    DistanceFromClosestAetheryteToPoint,
    DoFate,
    EorzeaTimeToUnixTime,
    ExecuteBicolorExchange,
    ExtractMateria,
    find,
    FlyBackToAetheryte,
    FoodCheck,
    GetAetheryteName,
    GetAetherytesInZone,
    GetAetheryteInZoneByName,
    GetClassJobTableFromName,
    GetClosestAetheryte,
    GetClosestAetheryteInZoneToPoint,
    GetClosestAetheryteToPoint,
    GetDistanceToPoint,
    GetDistanceToPointFlat,
    GetDistanceToPointWithAetheryteTravel,
    GetDistanceToTarget,
    GetDistanceToTargetFlat,
    GetFateNpcName,
    GetLangTable,
    GetNextDawntrailZoneId,
    GetNodeText,
    GetPlayerHitboxRadius,
    GetPlayerPosition,
    GetTargetHitboxRadius,
    GetTargetName,
    GetDenseFateClusterCenter,
    GetPreferredFateMovePosition,
    GetZoneInstance,
    GrandCompanyTurnIn,
    HandleDeath,
    HandleMovementStuck,
    HandleExchangeMovementStuck,
    HandleUnexpectedCombat,
    HasPlugin,
    HasStatusId,
    BuildFateSnapshot,
    BuildFateSnapshotSignature,
    EncodeJsonValue,
    IsArray,
    JsonEscape,
    MaybeLogActiveFates,
    InActiveFate,
    includes,
    InteractWithFateNpc,
    IsBlacklistedFate,
    IsBossFate,
    IsCollectionsFate,
    IsFateActive,
    IsLiteralBlackList,
    IsOtherNpcFate,
    IsSpecialFate,
    IsUserInputBlackListedFate,
    load_type,
    MiddleOfFateDismount,
    Mount,
    MountState,
    MoveToFate,
    MoveToNPC,
    MoveToRandomNearbySpot,
    MoveToTargetHitbox,
    NeedsLevelSyncForFate,
    IsLevelSyncPendingForCurrentFate,
    IsCurrentFateInSyncRange,
    GetCurrentFateMoveBoundaryBuffer,
    GetCurrentFateHardBoundaryBuffer,
    GetCurrentFateTargetRadiusPadding,
    IsPositionInsideCurrentFateBounds,
    ClampPositionToCurrentFateBounds,
    IsCurrentTargetInsideCurrentFateBounds,
    mysplit,
    Normalize,
    NpcDismount,
    PotionCheck,
    CanUseConsumableNow,
    ProcessRetainers,
    PrintSessionSummary,
    RandomAdjustCoordinates,
    Ready,
    Repair,
    SelectNextDawntrailZone,
    SelectNextFate,
    SelectNextFateHelper,
    GetBestAvailableNextFate,
    TryPrefetchNextFate,
    SelectNextZone,
    SetMapFlag,
    SetMaxDistance,
    GetLeashSafeRetargetRadius,
    ShouldSkipCollectionsFate,
    ShouldSkipOtherNpcFate,
    split,
    TeleportTo,
    TeleportToClosestAetheryteToFate,
    TurnOffAoes,
    TurnOffCombatMods,
    TurnOffRaidBuffs,
    TurnOnAoes,
    TurnOnCombatMods,
    UpdateCombatModeByNearbyEnemies,
    WaitForContinuation,
    ResetMovementStuckState,
    ResetExchangeMovementStuckState,
    SetExchangeMovementStuckGrace,
    SetStopReason,
    IsLifestreamBusySafe,
    ValidateRequiredIpc,
    IsVnavmeshReadySafe,
    IsVnavmeshMovingSafe

-- Party Play related globals (moved out of local limit)
GetPartyMemberCount = nil
GetPartyMemberNames = nil
GetPartyMemberTargetObjects = nil
IsPartyMemberInFate = nil
GetPartyPlayActive = nil
IsPartyMemberObject = nil
GetPartyLeaderZoneId = nil
FollowPartyLeaderToZone = nil

-- 出現中FATEデータ保存用の設定/状態
FateDataLogEnabled = nil
FateDataLogIntervalSeconds = nil
FateDataLogPath = nil
FateDataLogResolvedPath = nil
FateDataLogLastTime = nil
FateDataLogLastSignature = nil
FateDataLogError = nil
FateDataLogLastOpenErrorAt = nil

-- 納品証交換時の移動スタック検知用
ExchangeMoveLastCheckTime = nil
ExchangeMoveLastPosition = nil
ExchangeMoveStuckCount = nil
ExchangeMoveLastDistanceToShop = nil
ExchangeMoveGraceUntil = nil

-- 通常移動時のスタック検知用
MoveStuckLastCheckTime = nil
MoveStuckLastPosition = nil
MoveStuckCount = nil
MoveStuckLastDistanceToTarget = nil

-- セッション統計
SessionStartClock = nil
SessionStartGemCount = nil
SessionFatesStarted = nil
SessionFatesCompleted = nil
SessionFatesFailed = nil
SessionStuckRepathCount = nil
SessionStuckAetheryteCount = nil
SessionStuckZoneSwitchCount = nil
SessionStopReason = nil
FoodAutoUseDisabled = nil
PotionAutoUseDisabled = nil
TankStanceAcAttemptedForFate = nil
LifestreamBusyWarned = nil
VnavReadyCheckWarned = nil
NativeItemCommandDisabled = nil
NativeItemCommandWarned = nil
TeleportFailureByDestination = nil
TeleportFailureWarnedAt = nil

-- MoveToTargetHitbox のちらつき防止用
MoveToTargetLastPos = nil
MoveToTargetLastAt = nil
MoveToTargetLastTargetPos = nil

-- 密集移動のキャッシュ
ClusterMoveLastRefresh = nil
ClusterMoveCachedFateId = nil
ClusterMoveCachedPosition = nil

--[[
********************************************************************************
*           Code: Dont touch this unless you know what youre doing           *
********************************************************************************
]]

import("System.Numerics")
--#region Data

CharacterCondition = {
    dead = 2,
    mounted = 4,
    inCombat = 26,
    casting = 27,
    occupiedInEvent = 31,
    occupiedInQuestEvent = 32,
    occupied = 33,
    boundByDuty34 = 34,
    occupiedMateriaExtractionAndRepair = 39,
    betweenAreas = 45,
    jumping48 = 48,
    jumping61 = 61,
    occupiedSummoningBell = 50,
    betweenAreasForDuty = 51,
    boundByDuty56 = 56,
    mounting57 = 57,
    mounting64 = 64,
    beingMoved = 70,
    flying = 77
}

ClassList =
{
    gla = { classId = 1, className = "Gladiator", isMelee = true, isTank = true },
    pgl = { classId = 2, className = "Pugilist", isMelee = true, isTank = false },
    mrd = { classId = 3, className = "Marauder", isMelee = true, isTank = true },
    lnc = { classId = 4, className = "Lancer", isMelee = true, isTank = false },
    arc = { classId = 5, className = "Archer", isMelee = false, isTank = false },
    cnj = { classId = 6, className = "Conjurer", isMelee = false, isTank = false },
    thm = { classId = 7, className = "Thaumaturge", isMelee = false, isTank = false },
    pld = { classId = 19, className = "Paladin", isMelee = true, isTank = true },
    mnk = { classId = 20, className = "Monk", isMelee = true, isTank = false },
    war = { classId = 21, className = "Warrior", isMelee = true, isTank = true },
    drg = { classId = 22, className = "Dragoon", isMelee = true, isTank = false },
    brd = { classId = 23, className = "Bard", isMelee = false, isTank = false },
    whm = { classId = 24, className = "White Mage", isMelee = false, isTank = false },
    blm = { classId = 25, className = "Black Mage", isMelee = false, isTank = false },
    acn = { classId = 26, className = "Arcanist", isMelee = false, isTank = false },
    smn = { classId = 27, className = "Summoner", isMelee = false, isTank = false },
    sch = { classId = 28, className = "Scholar", isMelee = false, isTank = false },
    rog = { classId = 29, className = "Rogue", isMelee = false, isTank = false },
    nin = { classId = 30, className = "Ninja", isMelee = true, isTank = false },
    mch = { classId = 31, className = "Machinist", isMelee = false, isTank = false },
    drk = { classId = 32, className = "Dark Knight", isMelee = true, isTank = true },
    ast = { classId = 33, className = "Astrologian", isMelee = false, isTank = false },
    sam = { classId = 34, className = "Samurai", isMelee = true, isTank = false },
    rdm = { classId = 35, className = "Red Mage", isMelee = false, isTank = false },
    blu = { classId = 36, className = "Blue Mage", isMelee = false, isTank = false },
    gnb = { classId = 37, className = "Gunbreaker", isMelee = true, isTank = true },
    dnc = { classId = 38, className = "Dancer", isMelee = false, isTank = false },
    rpr = { classId = 39, className = "Reaper", isMelee = true, isTank = false },
    sge = { classId = 40, className = "Sage", isMelee = false, isTank = false },
    vpr = { classId = 41, className = "Viper", isMelee = true, isTank = false },
    pct = { classId = 42, className = "Pictomancer", isMelee = false, isTank = false }
}



FatesData = {
    {
        zoneName = "Middle La Noscea",
        zoneId = 134,
        fatesList = {
            collectionsFates = {},
            otherNpcFates = {
                { fateName = "Thwack-a-Mole",             npcName = "Troubled Tiller" },
                { fateName = "Yellow-bellied Greenbacks", npcName = "Yellowjacket Drill Sergeant" },
                { fateName = "The Orange Boxes",          npcName = "Farmer in Need" }
            },
            fatesWithContinuations = {},
            blacklistedFates = {}
        }
    },
    {
        zoneName = "Lower La Noscea",
        zoneId = 135,
        fatesList = {
            collectionsFates = {},
            otherNpcFates = {
                { fateName = "Away in a Bilge Hold", npcName = "Yellowjacket Veteran" },
                { fateName = "Fight the Flower",     npcName = "Furious Farmer" }
            },
            fatesWithContinuations = {},
            blacklistedFates = {}
        }
    },
    {
        zoneName = "Central Thanalan",
        zoneId = 141,
        fatesList = {
            collectionsFates = {
                { fateName = "Let them Eat Cactus", npcName = "Hungry Hobbledehoy" },
            },
            otherNpcFates = {
                { fateName = "A Few Arrows Short of a Quiver", npcName = "Crestfallen Merchant" },
                { fateName = "Wrecked Rats",                   npcName = "Coffer & Coffin Heavy" },
                { fateName = "Something to Prove",             npcName = "Cowardly Challenger" }
            },
            fatesWithContinuations = {},
            blacklistedFates = {}
        }
    },
    {
        zoneName = "Eastern Thanalan",
        zoneId = 145,
        fatesList = {
            collectionsFates = {},
            otherNpcFates = {
                { fateName = "Attack on Highbridge: Denouement", npcName = "Brass Blade" }
            },
            fatesWithContinuations = {},
            blacklistedFates = {}
        }
    },
    {
        zoneName = "Southern Thanalan",
        zoneId = 146,
        fatesList = {
            collectionsFates = {},
            otherNpcFates = {},
            fatesWithContinuations = {},
            blacklistedFates = {}
        },
        flying = false
    },
    {
        zoneName = "Outer La Noscea",
        zoneId = 180,
        fatesList = {
            collectionsFates = {},
            otherNpcFates = {},
            fatesWithContinuations = {},
            blacklistedFates = {}
        },
        flying = false
    },
    {
        zoneName = "Coerthas Central Highlands",
        zoneId = 155,
        fatesList = {
            collectionsFates = {},
            otherNpcFates = {},
            fatesWithContinuations = {},
            specialFates = {
                "He Taketh It with His Eyes" --behemoth
            },
            blacklistedFates = {}
        }
    },
    {
        zoneName = "Coerthas Western Highlands",
        zoneId = 397,
        fatesList = {
            collectionsFates = {},
            otherNpcFates = {
                { fateName = "A Dung Deal",            npcName = "Garrison Knight" },
                { fateName = "Dishonored",             npcName = "Beaudonet the Blunt" },
                { fateName = "No Ifs, Ands, or Butts", npcName = "Convictor Knight" },
            },
            fatesWithContinuations = {},
            specialFates = {
                "We Fought a Dzu", --Dzu, long boss fight.
            },
            blacklistedFates = {}
        }
    },
    {
        zoneName = "Mor Dhona",
        zoneId = 156,
        fatesList = {
            collectionsFates = {},
            otherNpcFates = {},
            fatesWithContinuations = {},
            blacklistedFates = {}
        }
    },
    {
        zoneName = "The Sea of Clouds",
        zoneId = 401,
        fatesList = {
            collectionsFates = {
                { fateName = "Obey their Thirst", npcName = "Nat'leii Zundu" },
            },
            otherNpcFates = {
                { fateName = "Mint Condition", npcName = "Rose Knight" },
            },
            fatesWithContinuations = {},
            specialFates = {
                "On Dangerous Ground", --Groundseater
            },
            blacklistedFates = {
                "The Fugitive", --Escort
            }
        }
    },
    {
        zoneName = "Azys Lla",
        zoneId = 402,
        fatesList = {
            collectionsFates = {},
            otherNpcFates = {},
            fatesWithContinuations = {
                { fateName = "A Bug's Death", npcName = "Verification Node" },
            },
            specialFates = {
                "Prey Online", --Noctilucale
            },
            blacklistedFates = {}
        }
    },
    {
        zoneName = "The Dravanian Forelands",
        zoneId = 398,
        fatesList = {
            collectionsFates = {
                { fateName = "Birds of a Feather", npcName = "Tailfeather Hunter" },
            },
            otherNpcFates = {
                { fateName = "Who's the Moss", npcName = "Mossy Peak" },
            },
            fatesWithContinuations = {},
            specialFates = {
                "Coeurls Chase Boys Chase Coeurls", --coeurlregina
                "Special Tarasque Force ",          --Tarasque
            },
            blacklistedFates = {}
        }
    },
    {
        zoneName = "The Dravanian Hinterlands",
        zoneId = 399,
        tpZoneId = 478,
        fatesList = {
            collectionsFates = {},
            otherNpcFates = {},
            fatesWithContinuations = {
                { fateName = "Metal Gears Rising", npcName = "Slicktrix the Gobnanimous" },
                { fateName = "Tome Raider",        npcName = "Browfix Turnalot" },
            },
            specialFates = {
                "Metal Gears Revengeance 2", --Boss fight
            },
            blacklistedFates = {
                "Poroggo Stuck", --Escort quest
            }
        }
    },
    {
        zoneName = "The Churning Mists",
        zoneId = 400,
        fatesList = {
            collectionsFates = {},
            otherNpcFates = {
                { fateName = "Corporal Punishment",         npcName = "Mogpo the Magnificent" },
                { fateName = "End of the Rainbow",          npcName = "Zenith Dragonling" },
                { fateName = "Infamous",                    npcName = "Zenith Dragonling" },
                { fateName = "The Nuts",                    npcName = "Mogoosh the Misbehaving" },
                { fateName = "It's the Moogle, Reinvented", npcName = "Mouthing-off Moogle" },
                { fateName = "Coin Toss",                   npcName = "Modish Moogle" },
                { fateName = "Waiting for Fjalar to Stall", npcName = "Fjalar" },
            },
            fatesWithContinuations = {},
            blacklistedFates = {}
        }
    },
    {
        zoneName = "The Fringes",
        zoneId = 612,
        fatesList = {
            collectionsFates = {
                { fateName = "Showing The Recruits What For", npcName = "Storm Commander Bharbennsyn" },
                { fateName = "Get Sharp",                     npcName = "M Tribe Youth" },
            },
            otherNpcFates = {
                { fateName = "The Mail Must Get Through", npcName = "Storm Herald" },
                { fateName = "The Antlion's Share",       npcName = "M Tribe Ranger" },
                { fateName = "Double Dhara",              npcName = "Resistence Fighter" },
                { fateName = "Keeping the Peace",         npcName = "Resistence Fighter" }
            },
            fatesWithContinuations = {},
            blacklistedFates = {}
        }
    },
    {
        zoneName = "The Peaks",
        zoneId = 620,
        fatesList = {
            collectionsFates = {
                { fateName = "Fletching Returns", npcName = "Sorry Sutler" }
            },
            otherNpcFates = {
                { fateName = "Resist, Die, Repeat",       npcName = "Wounded Fighter" },
                { fateName = "And the Bandits Played On", npcName = "Frightened Villager" },
                { fateName = "Forget-me-not",             npcName = "Coldhearth Resident" },
                { fateName = "Of Mice and Men",           npcName = "Furious Farmer" }
            },
            fatesWithContinuations = {},
            blacklistedFates = {
                "The Magitek Is Back", --escort
                "A New Leaf"           --escort
            }
        }
    },
    {
        zoneName = "The Lochs",
        zoneId = 621,
        fatesList = {
            collectionsFates = {},
            otherNpcFates = {},
            fatesWithContinuations = {},
            specialFates = {
                "A Horse Outside" --ixion
            },
            blacklistedFates = {}
        }
    },
    {
        zoneName = "The Ruby Sea",
        zoneId = 613,
        fatesList = {
            collectionsFates = {
                { fateName = "Treasure Island",       npcName = "Blue Avenger" },
                { fateName = "The Coral High Ground", npcName = "Busy Beachcomber" }
            },
            otherNpcFates = {
                { fateName = "Another One Bites The Dust", npcName = "Pirate Youth" },
                { fateName = "Ray Band",                   npcName = "Wounded Confederate" },
                { fateName = "Bilge-hold Jin",             npcName = "Green Confederate" }
            },
            fatesWithContinuations = {},
            blacklistedFates = {}
        }
    },
    {
        zoneName = "Yanxia",
        zoneId = 614,
        fatesList = {
            collectionsFates = {
                { fateName = "Rice and Shine", npcName = "Flabbergasted Farmwife" },
                { fateName = "More to Offer",  npcName = "Ginko" }
            },
            otherNpcFates = {
                { fateName = "Freedom Flies",      npcName = "Kinko" },
                { fateName = "A Tisket, a Tasket", npcName = "Gyogun of the Most Bountiful Catch" }
            },
            specialFates = {
                "Foxy Lady" --foxyyy
            },
            fatesWithContinuations = {},
            blacklistedFates = {}
        }
    },
    {
        zoneName = "The Azim Steppe",
        zoneId = 622,
        fatesList = {
            collectionsFates = {
                { fateName = "The Dataqi Chronicles: Duty", npcName = "Altani" }
            },
            otherNpcFates = {
                { fateName = "Rock for Food",       npcName = "Oroniri Youth" },
                { fateName = "Killing Dzo",         npcName = "Olkund Dzotamer" },
                { fateName = "They Shall Not Want", npcName = "Mol Shepherd" },
                { fateName = "A Good Day to Die",   npcName = "Qestiri Merchant" }
            },
            fatesWithContinuations = {},
            blacklistedFates = {}
        }
    },
    {
        zoneName = "Lakeland",
        zoneId = 813,
        fatesList = {
            collectionsFates = {
                { fateName = "Pick-up Sticks", npcName = "Crystarium Botanist" }
            },
            otherNpcFates = {
                { fateName = "Subtle Nightshade", npcName = "Artless Dodger" },
                { fateName = "Economic Peril",    npcName = "Jobb Guard" }
            },
            fatesWithContinuations = {
                "Behind Anemone Lines"
            },
            blacklistedFates = {}
        }
    },
    {
        zoneName = "Kholusia",
        zoneId = 814,
        fatesList = {
            collectionsFates = {
                { fateName = "Ironbeard Builders - Rebuilt", npcName = "Tholl Engineer" }
            },
            otherNpcFates = {},
            fatesWithContinuations = {},
            specialFates = {
                "A Finale Most Formidable" --formidable
            },
            blacklistedFates = {}
        }
    },
    {
        zoneName = "Amh Araeng",
        zoneId = 815,
        fatesList = {
            collectionsFates = {},
            otherNpcFates = {},
            fatesWithContinuations = {},
            blacklistedFates = {
                "Tolba No. 1", -- pathing is really bad to enemies
            }
        }
    },
    {
        zoneName = "Il Mheg",
        zoneId = 816,
        fatesList = {
            collectionsFates = {
                { fateName = "Twice Upon a Time", npcName = "Nectar-seeking Pixie" }
            },
            otherNpcFates = {
                { fateName = "Once Upon a Time", npcName = "Nectar-seeking Pixie" },
            },
            fatesWithContinuations = {},
            blacklistedFates = {}
        }
    },
    {
        zoneName = "The Rak'tika Greatwood",
        zoneId = 817,
        fatesList = {
            collectionsFates = {
                { fateName = "Picking up the Pieces", npcName = "Night's Blessed Missionary" },
                { fateName = "Pluck of the Draw",     npcName = "Myalna Bowsing" },
                { fateName = "Monkeying Around",      npcName = "Fanow Warder" }
            },
            otherNpcFates = {
                { fateName = "Queen of the Harpies",  npcName = "Fanow Huntress" },
                { fateName = "Shot Through the Hart", npcName = "Qilmet Redspear" },
            },
            fatesWithContinuations = {},
            blacklistedFates = {}
        }
    },
    {
        zoneName = "The Tempest",
        zoneId = 818,
        fatesList = {
            collectionsFates = {
                { fateName = "Low Coral Fiber", npcName = "Teushs Ooan" },
                { fateName = "Pearls Apart",    npcName = "Ondo Spearfisher" }
            },
            otherNpcFates = {
                { fateName = "Where has the Dagon",       npcName = "Teushs Ooan" },
                { fateName = "Ondo of Blood",             npcName = "Teushs Ooan" },
                { fateName = "Lookin' Back on the Track", npcName = "Teushs Ooan" },
            },
            fatesWithContinuations = {},
            specialFates = {
                "The Head, the Tail, the Whole Damned Thing" --archaeotania
            },
            blacklistedFates = {
                "Coral Support",          -- escort fate
                "The Seashells He Sells", -- escort fate
            }
        }
    },
    {
        zoneName = "Labyrinthos",
        zoneId = 956,
        fatesList = {
            collectionsFates = {
                { fateName = "Sheaves on the Wind", npcName = "Vexed Researcher" },
                { fateName = "Moisture Farming",    npcName = "Well-moisturized Researcher" }
            },
            otherNpcFates = {},
            fatesWithContinuations = {},
            blacklistedFates = {}
        }
    },
    {
        zoneName = "Thavnair",
        zoneId = 957,
        fatesList = {
            collectionsFates = {
                { fateName = "Full Petal Alchemist: Perilous Pickings", npcName = "Sajabaht" }
            },
            otherNpcFates = {},
            specialFates = {
                "Devout Pilgrims vs. Daivadipa" --daveeeeee
            },
            fatesWithContinuations = {},
            blacklistedFates = {}
        }
    },
    {
        zoneName = "Garlemald",
        zoneId = 958,
        fatesList = {
            collectionsFates = {
                { fateName = "Parts Unknown", npcName = "Displaced Engineer" }
            },
            otherNpcFates = {
                { fateName = "Artificial Malevolence: 15 Minutes to Comply",     npcName = "Keltlona" },
                { fateName = "Artificial Malevolence: The Drone Army",           npcName = "Ebrelnaux" },
                { fateName = "Artificial Malevolence: Unmanned Aerial Villains", npcName = "Keltlona" },
                { fateName = "Amazing Crates",                                   npcName = "Hardy Refugee" }
            },
            fatesWithContinuations = {},
            blacklistedFates = {}
        }
    },
    {
        zoneName = "Mare Lamentorum",
        zoneId = 959,
        fatesList = {
            collectionsFates = {
                { fateName = "What a Thrill", npcName = "Thrillingway" }
            },
            otherNpcFates = {
                { fateName = "Lepus Lamentorum: Dynamite Disaster",   npcName = "Warringway" },
                { fateName = "Lepus Lamentorum: Cleaner Catastrophe", npcName = "Fallingway" },
            },
            fatesWithContinuations = {},
            blacklistedFates = {
                "Hunger Strikes", --really bad line of sight with rocks, get stuck not doing anything quite often
            }
        }
    },
    {
        zoneName = "Ultima Thule",
        zoneId = 960,
        fatesList = {
            collectionsFates = {
                { fateName = "Omicron Recall: Comms Expansion", npcName = "N-6205" }
            },
            otherNpcFates = {
                { fateName = "Wings of Glory",                    npcName = "Ahl Ein's Kin" },
                { fateName = "Omicron Recall: Secure Connection", npcName = "N-6205" },
                { fateName = "Only Just Begun",                   npcName = "Myhk Nehr" }
            },
            specialFates = {
                "Omicron Recall: Killing Order" --chi
            },
            fatesWithContinuations = {},
            blacklistedFates = {}
        }
    },
    {
        zoneName = "Elpis",
        zoneId = 961,
        fatesList = {
            collectionsFates = {
                { fateName = "So Sorry, Sokles", npcName = "Flora Overseer" }
            },
            otherNpcFates = {
                { fateName = "Grand Designs: Unknown Execution", npcName = "Meletos the Inscrutable" },
                { fateName = "Grand Designs: Aigokeros",         npcName = "Meletos the Inscrutable" },
                { fateName = "Nature's Staunch Protector",       npcName = "Monoceros Monitor" },
            },
            fatesWithContinuations = {},
            blacklistedFates = {}
        }
    },
    {
        zoneName = "Urqopacha",
        zoneId = 1187,
        fatesList = {
            collectionsFates = {},
            otherNpcFates = {
                { fateName = "Pasture Expiration Date", npcName = "Tsivli Stoutstrider" },
                { fateName = "Gust Stop Already",       npcName = "Mourning Yok Huy" },
                { fateName = "Lay Off the Horns",       npcName = "Yok Huy Vigilkeeper" },
                { fateName = "Birds Up",                npcName = "Coffee Farmer" },
                { fateName = "Salty Showdown",          npcName = "Chirwagur Sabreur" },
                { fateName = "Fire Suppression",        npcName = "Tsivli Stoutstrider" },
                { fateName = "Panaq Attack",            npcName = "Pelupelu Peddler" }
            },
            fatesWithContinuations = {
                { fateName = "Salty Showdown", continuationIsBoss = true }
            },
            blacklistedFates = {
                "Young Volcanoes",
                "Wolf Parade", -- multiple Pelupelu Peddler npcs, rng whether it tries to talk to the right one
                "Panaq Attack" -- multiple Pelupleu Peddler npcs
            }
        }
    },
    {
        zoneName = "Kozama'uka",
        zoneId = 1188,
        fatesList = {
            collectionsFates = {
                { fateName = "Borne on the Backs of Burrowers", npcName = "Moblin Forager" },
                { fateName = "Combing the Area",                npcName = "Hanuhanu Combmaker" },

            },
            otherNpcFates = {
                { fateName = "There's Always a Bigger Beast", npcName = "Hanuhanu Angler" },
                { fateName = "Toucalibri at That Game",       npcName = "Hanuhanu Windscryer" },
                { fateName = "Putting the Fun in Fungicide",  npcName = "Bagnobrok Craftythoughts" },
                { fateName = "Reeds in Need",                 npcName = "Hanuhanu Farmer" },
                { fateName = "Tax Dodging",                   npcName = "Pelupelu Peddler" },

            },
            fatesWithContinuations = {},
            blacklistedFates = {
                "Mole Patrol",
                "Tax Dodging" -- multiple Pelupelu Peddlers
            }
        }
    },
    {
        zoneName = "Yak T'el",
        zoneId = 1189,
        fatesList = {
            collectionsFates = {
                { fateName = "Escape Shroom", npcName = "Hoobigo Forager" }
            },
            otherNpcFates = {
                --{ fateName=, npcName="Xbr'aal Hunter" }, 2 npcs names same thing....
                { fateName = "La Selva se lo Llevó",         npcName = "Xbr'aal Hunter" },
                { fateName = "Stabbing Gutward",             npcName = "Doppro Spearbrother" },
                { fateName = "Porting is Such Sweet Sorrow", npcName = "Hoobigo Porter" }
                -- { fateName="Stick it to the Mantis", npcName="Xbr'aal Sentry" }, -- 2 npcs named same thing.....
            },
            fatesWithContinuations = {
                "Stabbing Gutward"
            },
            blacklistedFates = {
                "The Departed"
            }
        }
    },
    {
        zoneName = "Shaaloani",
        zoneId = 1190,
        fatesList = {
            collectionsFates = {
                { fateName = "Gonna Have Me Some Fur", npcName = "Tonawawtan Trapper" },
                { fateName = "The Serpentlord Sires",  npcName = "Br'uk Vaw of the Setting Sun" }
            },
            otherNpcFates = {
                { fateName = "The Dead Never Die",       npcName = "Tonawawtan Worker" }, --22 boss
                { fateName = "Ain't What I Herd",        npcName = "Hhetsarro Herder" },  --23 normal
                { fateName = "Helms off to the Bull",    npcName = "Hhetsarro Herder" },  --22 boss
                { fateName = "A Raptor Runs Through It", npcName = "Hhetsarro Angler" },  --24 tower defense
                { fateName = "The Serpentlord Suffers",  npcName = "Br'uk Vaw of the Setting Sun" },
                { fateName = "That's Me and the Porter", npcName = "Pelupelu Peddler" },
            },
            fatesWithContinuations = {
                "The Serpentlord Sires"
            },
            specialFates = {
                "The Serpentlord Seethes" -- big snake fate
            },
            blacklistedFates = { "死せる悪漢「デッドマン・ダーテカ」", "ロネークと人の大地", "嘆きの猛進「ウィデキ」", "リバー・ランズ・スルー・イット", "毛狩りの季節", "トクローネ：狩猟の下準備", "トクローネ：荒野の死闘", "恐竜怪鳥の伝説" }
        }
    },
    {
        zoneName = "Heritage Found",
        zoneId = 1191,
        fatesList = {
            collectionsFates = {
                { fateName = "License to Dill",      npcName = "Tonawawtan Provider" },
                { fateName = "When It's So Salvage", npcName = "Refined Reforger" }
            },
            otherNpcFates = {
                { fateName = "It's Super Defective",     npcName = "Novice Hunter" },
                { fateName = "Running of the Katobleps", npcName = "Novice Hunter" },
                { fateName = "Ware the Wolves",          npcName = "Imperiled Hunter" },
                { fateName = "Domo Arigato",             npcName = "Perplexed Reforger" },
                { fateName = "Old Stampeding Grounds",   npcName = "Driftdowns Reforger" },
                { fateName = "Pulling the Wool",         npcName = "Panicked Courier" }
            },
            fatesWithContinuations = {
                { fateName = "Domo Arigato", continuationIsBoss = false }
            },
            blacklistedFates = {
                "When It's So Salvage", -- terrain is terrible
            }
        }
    },
    {
        zoneName = "Living Memory",
        zoneId = 1192,
        fatesList = {
            collectionsFates = {
                { fateName = "Seeds of Tomorrow",  npcName = "Unlost Sentry GX" },
                { fateName = "Scattered Memories", npcName = "Unlost Sentry GX" }
            },
            otherNpcFates = {
                { fateName = "Canal Carnage", npcName = "Unlost Sentry GX" },
                { fateName = "Mascot March",  npcName = "The Grand Marshal" }
            },
            fatesWithContinuations =
            {
                { fateName = "Plumbers Don't Fear Slimes", continuationIsBoss = true },
                { fateName = "Mascot March",               continuationIsBoss = true }
            },
            specialFates =
            {
                "Mascot Murder"
            },
            blacklistedFates = {
                "Plumbers Don't Fear Slimes", --Causing Script to crash
            }
        }
    }
}

SolutionNineWaypoints = {
    { name = "Center", position = Vector3(-150, 0, -50) },
    { name = "North", position = Vector3(-150, 0, -120) },
    { name = "South", position = Vector3(-150, 0, 20) },
    { name = "East", position = Vector3(-80, 0, -50) },
    { name = "West", position = Vector3(-220, 0, -50) },
    { name = "Aetheryte", position = Vector3(-198, 0, -7) },
    { name = "NexusArcade", position = Vector3(-158, 0, -10) },
}

function GetSolutionNineWaypoint(targetPos)
    if targetPos == nil or SolutionNineWaypoints == nil then
        return nil
    end
    
    local closest = nil
    local closestDist = math.maxinteger
    for _, wp in ipairs(SolutionNineWaypoints) do
        local dist = DistanceBetweenFlat(wp.position, targetPos)
        if dist < closestDist then
            closestDist = dist
            closest = wp
        end
    end
    
    return closest
end

function find(array, f)
    for _, v in ipairs(array) do
        if not f(v) then
            return v
        end
    end
    return nil
end

function includes(array, searchStr)
    for _, value in ipairs(array) do
        local trimmed = tostring(value or ""):match("^%s*(.-)%s*$")
        if trimmed ~= "" and trimmed == searchStr then
            return true
        end
    end
    return false
end

function split(str, ts)
    -- 引数がないときは空tableを返す
    if ts == nil then return {} end

    local t = {}
    local i = 1
    for s in string.gmatch(str, "([^" .. ts .. "]+)") do
        t[i] = s
        i = i + 1
    end

    return t
end

function GetLangTable(lang)
    local langTables = {
        Japanese = {
            actions = {
                ["Gysahl Greens"] = "ギサールの野菜",
                ["mount roulette"] = "マウント・ルーレット",
                ["dismount"] = "降りる",
                ["repair"] = "修理",
                ["aetheryte"] = "エーテライト",
                ["extract materia"] = "マテリア精製",
                ["teleport"] = "テレポート",
                ["sprint"] = "スプリント",
                ["Shield Lob"] = "シールドロブ",
                ["Tomahawk"] = "トマホーク",
                ["Unmend"] = "アンメンド",
                ["Unleash"] = "アンリーシュ",
                ["Lightning Shot"] = "サンダーバレット",
                ["Fast Blade"] = "ファストブレード",
                ["Heavy Swing"] = "ヘヴィスウィング",
                ["Hard Slash"] = "ハードスラッシュ",
                ["Keen Edge"] = "キーンエッジ",
                ["Flying Sardine"] = "フライングサーディン",
                ["Heavy Shot"] = "ヘヴィショット",
                ["Split Shot"] = "スプリットショット",
                ["Cascade"] = "カスケード",
                ["Piercing Talon"] = "ピアシングタロン",
                ["Throwing Dagger"] = "投刃",
                ["Enpi"] = "燕飛",
                ["Harpe"] = "ハルパー",
                ["Ruin"] = "ルイン",
                ["Blizzard"] = "ブリザド",
                ["Jolt"] = "ジョル",
                ["Wrath's Sting"] = "飛蛇の尾",
                ["Fire in Red"] = "レッドファイア",
                ["Dosis"] = "ドシス",
                ["Stone"] = "ストーン",
                ["Glare"] = "グレア",
                ["Malefic"] = "マレフィク",
                ["Intervene"] = "インターヴィーン",
                ["Onslaught"] = "オンスロート",
                ["Shadowstride"] = "シャドウストライド",
                ["Trajectory"] = "トラジェクトリー",
                ["Iron Will"] = "アイアンウィル",
                ["Defiance"] = "ディフェンダー",
                ["Grit"] = "グリットスタンス",
                ["Royal Guard"] = "ロイヤルガード",
                ["Winged Glide"] = "ウィンググライド",
                ["Thunderclap"] = "抜重歩法",
                ["Hissatsu: Gyoten"] = "必殺剣・暁天",
                ["Meditation"] = "黙想",
                ["Hakaze"] = "刃風",
                ["True Thrust"] = "トゥルースラスト",
                ["Bootshine"] = "ブートシャイン",
                ["Spinning Edge"] = "スピニングエッジ",
                ["Slice"] = "スライス",
                ["Steel Fangs"] = "スティールファングス",
                ["Hell's Ingress"] = "ヘルズイングレス",
                ["Plunge"] = "プランジカット",
                ["Rough Divide"] = "ラフディバイド",
                ["Spineshatter Dive"] = "スパインダイブ"
            },
            bitColorExchangeData = {
                {
                    shopKeepName = "広域交易商 ガドフリッド",
                    zoneName = "オールド・シャーレアン",
                    zoneId = 962,
                    aetheryteName = "オールド・シャーレアン",
                    position = Vector3(78, 5, -37),
                    shopItems = {
                        ["Bicolor Gemstone Voucher"] = { itemName = "バイカラージェム納品書", itemIndex = 8, price = 100 },
                    }
                },
                {
                    shopKeepName = "広域交易商 ベリル",
                    zoneName = "ソリューション・ナイン",
                    zoneId = 1186,
                    aetheryteName = "ソリューション・ナイン",
                    miniAethernet = { name = "ネクサスアーケード" },
                    position = Vector3(-198.655, 0.922, -6.678),
                    shopItems = {
                        ["Turali Bicolor Gemstone Voucher"] = { itemName = "バイカラージェム納品証【黄金】", itemIndex = 6, price = 100 },
                    }
                }
            }
        },
        English = {
            actions = {
                ["Gysahl Greens"] = "Gysahl Greens",
                ["mount roulette"] = "Mount Roulette",
                ["dismount"] = "dismount",
                ["repair"] = "Repair",
                ["aetheryte"] = "aetheryte",
                ["extract materia"] = "Materia Extraction",
                ["teleport"] = "Teleport",
                ["sprint"] = "Sprint",
                ["Shield Lob"] = "Shield Lob",
                ["Tomahawk"] = "Tomahawk",
                ["Unmend"] = "Unmend",
                ["Lightning Shot"] = "Lightning Shot",
                ["Fast Blade"] = "Fast Blade",
                ["Heavy Swing"] = "Heavy Swing",
                ["Hard Slash"] = "Hard Slash",
                ["Keen Edge"] = "Keen Edge",
                ["Flying Sardine"] = "Flying Sardine",
                ["Heavy Shot"] = "Heavy Shot",
                ["Split Shot"] = "Split Shot",
                ["Cascade"] = "Cascade",
                ["Piercing Talon"] = "Piercing Talon",
                ["Throwing Dagger"] = "Throwing Dagger",
                ["Enpi"] = "Enpi",
                ["Harpe"] = "Harpe",
                ["Ruin"] = "Ruin",
                ["Blizzard"] = "Blizzard",
                ["Jolt"] = "Jolt",
                ["Wrath's Sting"] = "Wrath's Sting",
                ["Fire in Red"] = "Fire in Red",
                ["Dosis"] = "Dosis",
                ["Stone"] = "Stone",
                ["Glare"] = "Glare",
                ["Malefic"] = "Malefic",
                ["Intervene"] = "Intervene",
                ["Onslaught"] = "Onslaught",
                ["Shadowstride"] = "Shadowstride",
                ["Trajectory"] = "Trajectory",
                ["Iron Will"] = "Iron Will",
                ["Defiance"] = "Defiance",
                ["Grit"] = "Grit",
                ["Royal Guard"] = "Royal Guard",
                ["Winged Glide"] = "Winged Glide",
                ["Thunderclap"] = "Thunderclap",
                ["Hissatsu: Gyoten"] = "Hissatsu: Gyoten",
                ["Meditation"] = "Meditation",
                ["Hakaze"] = "Hakaze",
                ["True Thrust"] = "True Thrust",
                ["Bootshine"] = "Bootshine",
                ["Spinning Edge"] = "Spinning Edge",
                ["Slice"] = "Slice",
                ["Steel Fangs"] = "Steel Fangs",
                ["Hell's Ingress"] = "Hell's Ingress",
                ["Plunge"] = "Plunge",
                ["Rough Divide"] = "Rough Divide",
                ["Spineshatter Dive"] = "Spineshatter Dive"
            },
            bitColorExchangeData = {
                {
                    shopKeepName = "Gadfrid",
                    zoneName = "Old Sharlayan",
                    zoneId = 962,
                    aetheryteName = "Old Sharlayan",
                    position = Vector3(78, 5, -37),
                    shopItems = {
                        ["Bicolor Gemstone Voucher"] = { itemName = "Bicolor Gemstone Voucher", itemIndex = 7, price = 100 },
                    }
                },
                {
                    shopKeepName = "Beryl",
                    zoneName = "Solution Nine",
                    zoneId = 1186,
                    aetheryteName = "Solution Nine",
                    miniAethernet = { name = "Nexus Arcade" },
                    position = Vector3(-198.655, 0.922, -6.678),
                    shopItems = {
                        ["Turali Bicolor Gemstone Voucher"] = { itemName = "Turali Bicolor Gemstone Voucher", itemIndex = 7, price = 100 },
                        ["バイカラージェム納品証【黄金】"] = { itemName = "Turali Bicolor Gemstone Voucher", itemIndex = 7, price = 100 },
                    }
                }
            }
        }
    }

    return langTables[lang] or langTables["English"]
end

-- 言語設定の初期化
GameLanguage = Svc.ClientState.ClientLanguage:ToString()
Lang = GetLangTable(GameLanguage)
BicolorExchangeData = Lang.bitColorExchangeData

--#endregion Data

--#region Utils
function mysplit(inputstr)
    for str in string.gmatch(inputstr, "[^%.]+") do
        return str
    end
end

function load_type(type_path)
    local assembly = mysplit(type_path)
    luanet.load_assembly(assembly)
    local type_var = luanet.import_type(type_path)
    return type_var
end

EntityWrapper = load_type('SomethingNeedDoing.LuaMacro.Wrappers.EntityWrapper')
local SndGameUtils = nil
do
    local ok, gameUtils = pcall(function()
        return load_type('SomethingNeedDoing.Utils.Game')
    end)
    if ok then
        SndGameUtils = gameUtils
    else
        Dalamud.Log(
            "[FATE] Warning: failed to load SomethingNeedDoing.Utils.Game. Using command fallback for chocobo summon.")
    end
end

function AddonReady(addonName)
    local addon = Addons.GetAddon(addonName)
    return addon ~= nil and addon.Ready
end

function GetLocalPlayerPosition()
    if Svc and Svc.ClientState and Svc.ClientState.LocalPlayer then
        return Svc.ClientState.LocalPlayer.Position
    end
    if ClientState and ClientState.LocalPlayer then
        return ClientState.LocalPlayer.Position
    end
    if Player and Player.Available then
        if Player.Position then
            return Player.Position
        end
        local obj = Player.Object or Player.Entity
        if obj and obj.Position then
            return obj.Position
        end
    end
    return nil
end

function GetFateProgressValue(fate, fallback)
    if fate == nil or fate.fateObject == nil or fate.fateObject.Progress == nil then
        return fallback
    end
    return fate.fateObject.Progress
end

function GetFateRadiusValue(fate, fallback)
    if fate == nil or fate.fateObject == nil or fate.fateObject.Radius == nil then
        return fallback
    end
    return fate.fateObject.Radius
end

function GetFateMaxLevelValue(fate, fallback)
    if fate == nil or fate.fateObject == nil or fate.fateObject.MaxLevel == nil then
        return fallback
    end
    return fate.fateObject.MaxLevel
end

function SetMapFlag(zoneId, position)
    Dalamud.Log("[FATE] Setting map flag to zone #" .. zoneId .. ", (X: " .. position.X .. ", " .. position.Z .. " )")
    Instances.Map.Flag:SetFlagMapMarker(zoneId, position.X, position.Z)
end

function GetZoneInstance()
    return InstancedContent.PublicInstance.InstanceId
end

function GetTargetName()
    if Svc.Targets.Target == nil then
        return ""
    else
        return Svc.Targets.Target.Name:GetText()
    end
end

function IsForlornTargetName(targetName)
    if targetName == nil then
        return false
    end
    local text = tostring(targetName)
    if text == "" then
        return false
    end
    local lowerText = string.lower(text)
    if string.find(lowerText, "forlorn", 1, true) ~= nil then
        return true
    end
    if string.find(text, "フォーローン", 1, true) ~= nil then
        return true
    end
    return false
end

function IsBigForlornTargetName(targetName)
    if not IsForlornTargetName(targetName) then
        return false
    end
    local text = tostring(targetName or "")
    local lowerText = string.lower(text)
    if string.find(lowerText, "the forlorn", 1, true) ~= nil then
        return true
    end
    if string.find(text, "メイデン", 1, true) ~= nil then
        return false
    end
    if string.find(text, "フォーローン", 1, true) ~= nil then
        return true
    end
    return false
end

function TryTargetForlorn()
    if IgnoreForlorns then
        return
    end
    local targetNames = {
        "Forlorn Maiden",
        "フォーローン・メイデン",
        "フォーローンメイデン"
    }
    if not IgnoreBigForlornOnly then
        table.insert(targetNames, "The Forlorn")
        table.insert(targetNames, "フォーローン")
    end
    for _, targetName in ipairs(targetNames) do
        SafeYield("/target " .. targetName)
    end
end

function NeedsLevelSyncForFate(fate)
    if fate == nil then
        return false
    end
    local maxLevel = GetFateMaxLevelValue(fate, nil)
    if maxLevel == nil or Player.Job == nil then
        return false
    end
    if SkipLevelSyncForHighLevelFates == true then
        local bypassMinLevel = tonumber(LevelSyncBypassMinFateLevel) or 96
        if maxLevel >= bypassMinLevel then
            return false
        end
    end
    return maxLevel < Player.Job.Level
end

function IsHighPriorityFateLevel(fate)
    local currentZoneId = SelectedZone and SelectedZone.zoneId or Svc.ClientState.TerritoryType
    if currentZoneId == 1191 or currentZoneId == 1192 then
        return true
    end
    local maxLevel = GetFateMaxLevelValue(fate, nil)
    if maxLevel == nil then
        return false
    end
    local minPriorityLevel = tonumber(HighLevelFatePriorityMinLevel) or 96
    return maxLevel >= minPriorityLevel
end

function GetCurrentFateMoveBoundaryBuffer()
    if NeedsLevelSyncForFate(CurrentFate) then
        return FateLevelSyncBoundaryBuffer or 0.5
    end
    return FateMoveBoundaryBuffer or 4
end

function GetCurrentFateHardBoundaryBuffer()
    if NeedsLevelSyncForFate(CurrentFate) then
        return FateLevelSyncHardBoundaryBuffer or 2.5
    end
    return FateHardBoundaryBuffer or 14
end

function GetCurrentFateTargetRadiusPadding()
    if NeedsLevelSyncForFate(CurrentFate) then
        return FateLevelSyncTargetRadiusPadding or 0.5
    end
    return FateTargetRadiusPadding or 3
end

function IsLevelSyncPendingForCurrentFate()
    if CurrentFate == nil then
        return false
    end
    return NeedsLevelSyncForFate(CurrentFate) and Player.IsLevelSynced ~= true
end

function IsCurrentFateInSyncRange()
    if CurrentFate == nil or CurrentFate.fateObject == nil then
        return false
    end
    if not IsFateActive(CurrentFate.fateObject) then
        return false
    end
    if InActiveFate() then
        return true
    end
    local radius = GetFateRadiusValue(CurrentFate, nil)
    if radius == nil then
        return false
    end
    local distanceToFateCenter = GetDistanceToPoint(CurrentFate.position)
    if distanceToFateCenter == nil then
        return false
    end
    local syncRangeBuffer = LevelSyncInRangeBuffer or 1.5
    return distanceToFateCenter <= (radius + syncRangeBuffer)
end

function IsPositionInsideCurrentFateBounds(position, margin)
    if position == nil or CurrentFate == nil or CurrentFate.position == nil then
        return true
    end
    local fateRadius = GetFateRadiusValue(CurrentFate, nil)
    if fateRadius == nil or fateRadius <= 0 then
        return true
    end
    local effectiveMargin = margin
    if effectiveMargin == nil then
        effectiveMargin = GetCurrentFateMoveBoundaryBuffer()
    end
    return DistanceBetweenFlat(CurrentFate.position, position) <= (fateRadius + effectiveMargin)
end

function ClampPositionToCurrentFateBounds(position, margin)
    if position == nil or CurrentFate == nil or CurrentFate.position == nil then
        return position
    end
    local fateRadius = GetFateRadiusValue(CurrentFate, nil)
    if fateRadius == nil or fateRadius <= 0 then
        return position
    end
    local effectiveMargin = margin
    if effectiveMargin == nil then
        effectiveMargin = GetCurrentFateMoveBoundaryBuffer()
    end
    local maxRadius = fateRadius + effectiveMargin
    local offset = position - CurrentFate.position
    local flatLength = math.sqrt((offset.X * offset.X) + (offset.Z * offset.Z))
    if flatLength <= maxRadius or flatLength <= 0 then
        return position
    end
    local scale = maxRadius / flatLength
    return Vector3(
        CurrentFate.position.X + (offset.X * scale),
        position.Y,
        CurrentFate.position.Z + (offset.Z * scale)
    )
end

function IsCurrentTargetInsideCurrentFateBounds(margin)
    if Svc.Targets.Target == nil then
        return false
    end
    return IsPositionInsideCurrentFateBounds(Svc.Targets.Target.Position, margin)
end

function CollectFateEnemyCandidates(fateIdFilter, onlyUnengaged, maxDistance, ignoreFateRadiusFilter)
    local playerPos = GetLocalPlayerPosition()
    if playerPos == nil then
        return {}, nil
    end

    local candidates = {}
    for i = 0, Svc.Objects.Length - 1 do
        local obj = Svc.Objects[i]
        if obj ~= nil and obj.IsTargetable and obj:IsHostile() and not obj.IsDead then
            local wrappedObj = EntityWrapper(obj)
            local objFateId = wrappedObj.FateId
            if objFateId > 0 and (fateIdFilter == 0 or objFateId == fateIdFilter) then
                local dist = DistanceBetween(playerPos, obj.Position)
                local isUnengaged = not wrappedObj.IsInCombat
                local passesCombatFilter = (onlyUnengaged ~= true) or isUnengaged
                local passesDistanceFilter = (maxDistance == nil) or (dist <= maxDistance)
                local passesFateRadiusFilter = true
                if not ignoreFateRadiusFilter and CurrentFate ~= nil and CurrentFate.fateId == objFateId and CurrentFate.position ~= nil then
                    local fateRadius = GetFateRadiusValue(CurrentFate, nil)
                    if fateRadius ~= nil and fateRadius > 0 then
                        local fatePadding = GetCurrentFateTargetRadiusPadding()
                        passesFateRadiusFilter =
                            DistanceBetweenFlat(CurrentFate.position, obj.Position) <= (fateRadius + fatePadding)
                    end
                end
                if passesCombatFilter and passesDistanceFilter and passesFateRadiusFilter then
                    table.insert(candidates, {
                        obj = obj,
                        dist = dist
                    })
                end
            end
        end
    end

    return candidates, playerPos
end

function GetBestDenseCluster(candidates, clusterRadius)
    local bestTarget = nil
    local bestClusterSize = -1
    local bestTargetDistance = math.maxinteger
    local bestCenter = nil

    for _, candidate in ipairs(candidates) do
        local clusterSize = 0
        local sumX = 0
        local sumY = 0
        local sumZ = 0

        for _, other in ipairs(candidates) do
            if DistanceBetweenFlat(candidate.obj.Position, other.obj.Position) <= clusterRadius then
                clusterSize = clusterSize + 1
                sumX = sumX + other.obj.Position.X
                sumY = sumY + other.obj.Position.Y
                sumZ = sumZ + other.obj.Position.Z
            end
        end

        local center = candidate.obj.Position
        if clusterSize > 0 then
            center = Vector3(sumX / clusterSize, sumY / clusterSize, sumZ / clusterSize)
        end

        if clusterSize > bestClusterSize or (clusterSize == bestClusterSize and candidate.dist < bestTargetDistance) then
            bestClusterSize = clusterSize
            bestTargetDistance = candidate.dist
            bestTarget = candidate.obj
            bestCenter = center
        end
    end

    return bestTarget, bestClusterSize, bestCenter
end

function AttemptToTargetClosestFateEnemy(onlyUnengaged, maxDistance, allowFallbackToAny)
    local fateIdFilter = CurrentFate and CurrentFate.fateId or 0
    local unengagedOnly = (onlyUnengaged == true) and (PreferUnengagedFateTargets == true)
    if allowFallbackToAny == nil then
        allowFallbackToAny = true
    end

    -- Party Play: prioritize targets that party members are fighting
    if PrioritizePartyMemberTargets == true and GetPartyPlayActive() then
        local partyTargets = GetPartyMemberTargetObjects()
        for _, ptTarget in ipairs(partyTargets) do
            if ptTarget ~= nil and not ptTarget.IsDead then
                local validFate = true
                if fateIdFilter ~= 0 then
                    local wrappedOk, wrapped = pcall(function() return EntityWrapper(ptTarget) end)
                    if wrappedOk and wrapped ~= nil then
                        validFate = (wrapped.FateId == fateIdFilter)
                    end
                end
                local validDist = true
                if maxDistance ~= nil then
                    local playerPos = GetPlayerPosition()
                    if playerPos ~= nil then
                        validDist = DistanceBetween(playerPos, ptTarget.Position) <= maxDistance
                    end
                end
                if validFate and validDist then
                    Svc.Targets.Target = ptTarget
                    return true
                end
            end
        end
    end

    local candidates = CollectFateEnemyCandidates(fateIdFilter, unengagedOnly, maxDistance)
    if #candidates == 0 and unengagedOnly and allowFallbackToAny then
        candidates = CollectFateEnemyCandidates(fateIdFilter, false, maxDistance)
    end
    if #candidates == 0 and allowFallbackToAny then
        candidates = CollectFateEnemyCandidates(fateIdFilter, unengagedOnly, maxDistance, true)
        if #candidates == 0 and unengagedOnly then
            candidates = CollectFateEnemyCandidates(fateIdFilter, false, maxDistance, true)
        end
    end
    if #candidates == 0 then
        return false
    end

    local closestTarget = nil
    local closestTargetDistance = math.maxinteger
    for _, candidate in ipairs(candidates) do
        if candidate.dist < closestTargetDistance then
            closestTargetDistance = candidate.dist
            closestTarget = candidate.obj
        end
    end

    local useDensePulls = PreferDensePulls ~= false
    local clusterRadius = DensePullClusterRadius or 30
    local minClusterEnemies = DensePullMinimumEnemies or 1

    if not useDensePulls or #candidates == 1 then
        Svc.Targets.Target = closestTarget
        return true
    end

    local bestTarget, bestClusterSize = GetBestDenseCluster(candidates, clusterRadius)

    if bestTarget ~= nil and bestClusterSize >= minClusterEnemies then
        Svc.Targets.Target = bestTarget
        return true
    elseif closestTarget ~= nil then
        Svc.Targets.Target = closestTarget
        return true
    end

    return false
end

function AttemptToTargetLowestHpFateEnemy(maxDistance)
    local fateIdFilter = CurrentFate and CurrentFate.fateId or 0
    if fateIdFilter == 0 then
        return false
    end

    local candidates = CollectFateEnemyCandidates(fateIdFilter, false, maxDistance)
    if #candidates == 0 then
        candidates = CollectFateEnemyCandidates(fateIdFilter, false, maxDistance, true)
    end
    if #candidates == 0 then
        return false
    end

    local bestTarget = nil
    local bestCurrentHp = nil
    local bestHpRatio = nil
    local bestDist = nil

    for _, candidate in ipairs(candidates) do
        local obj = candidate.obj
        local currentHp = obj and obj.CurrentHp or nil
        if currentHp ~= nil and currentHp > 0 then
            local maxHp = obj.MaxHp
            local hpRatio = 1
            if maxHp ~= nil and maxHp > 0 then
                hpRatio = currentHp / maxHp
            end

            local betterTarget = false
            if bestTarget == nil then
                betterTarget = true
            elseif currentHp < bestCurrentHp then
                betterTarget = true
            elseif currentHp == bestCurrentHp and hpRatio < bestHpRatio then
                betterTarget = true
            elseif currentHp == bestCurrentHp and hpRatio == bestHpRatio and candidate.dist < bestDist then
                betterTarget = true
            end

            if betterTarget then
                bestTarget = obj
                bestCurrentHp = currentHp
                bestHpRatio = hpRatio
                bestDist = candidate.dist
            end
        end
    end

    if bestTarget == nil then
        return false
    end

    Svc.Targets.Target = bestTarget
    return true
end

function GetDenseFateClusterCenter(fateIdFilter, clusterRadius, minClusterEnemies)
    local candidates = CollectFateEnemyCandidates(fateIdFilter)
    if #candidates == 0 then
        return nil, 0
    end

    local _, bestClusterSize, bestCenter = GetBestDenseCluster(candidates, clusterRadius)
    if bestCenter ~= nil and bestClusterSize >= minClusterEnemies then
        local onFloor = IPC.vnavmesh.PointOnFloor(bestCenter, true, 30)
        return onFloor or bestCenter, bestClusterSize
    end

    return nil, bestClusterSize
end

function CountNearbyFateEnemies(radius, fateIdFilter)
    local candidates, playerPos = CollectFateEnemyCandidates(fateIdFilter)
    if playerPos == nil then
        return 0
    end

    local count = 0
    for _, candidate in ipairs(candidates) do
        if DistanceBetweenFlat(playerPos, candidate.obj.Position) <= radius then
            count = count + 1
        end
    end
    return count
end

function CountNearbyFateEnemiesWithName(radius, fateIdFilter, nameToMatch)
    if nameToMatch == nil or nameToMatch == "" then
        return 0
    end

    local candidates, playerPos = CollectFateEnemyCandidates(fateIdFilter)
    if playerPos == nil then
        return 0
    end

    local count = 0
    for _, candidate in ipairs(candidates) do
        if DistanceBetweenFlat(playerPos, candidate.obj.Position) <= radius then
            local objName = candidate.obj.Name:GetText()
            if objName == nameToMatch then
                count = count + 1
            end
        end
    end
    return count
end

function GetPreferredFateMovePosition(fate)
    if fate == nil or fate.position == nil then
        return nil
    end

    if fate.isCollectionsFate or fate.isOtherNpcFate then
        return ClampPositionToCurrentFateBounds(fate.position, 0)
    end

    if OptimizeClusterMovement ~= true then
        return ClampPositionToCurrentFateBounds(fate.position, 0)
    end

    local now = os.clock()
    if ClusterMoveCachedPosition ~= nil
        and ClusterMoveCachedFateId == fate.fateId
        and ClusterMoveLastRefresh ~= nil
        and now - ClusterMoveLastRefresh < ClusterMoveRefreshSeconds
    then
        return ClampPositionToCurrentFateBounds(ClusterMoveCachedPosition, 0)
    end

    local center = GetDenseFateClusterCenter(
        fate.fateId,
        ClusterMoveRadius,
        ClusterMoveMinimumEnemies
    )

    ClusterMoveLastRefresh = now
    ClusterMoveCachedFateId = fate.fateId
    if center ~= nil then
        -- Ignore tiny cluster-center shifts to avoid 1px pathing jitter.
        local snappedCenter = center
        if ClusterMoveCachedPosition ~= nil
            and DistanceBetweenFlat(ClusterMoveCachedPosition, center) < 2.0
        then
            snappedCenter = ClusterMoveCachedPosition
        end
        ClusterMoveCachedPosition = ClampPositionToCurrentFateBounds(snappedCenter, 0)
        return ClusterMoveCachedPosition
    end

    ClusterMoveCachedPosition = ClampPositionToCurrentFateBounds(fate.position, 0)
    return ClusterMoveCachedPosition
end

function UpdateCombatModeByNearbyEnemies()
    if DynamicAoeSwitch ~= true or CurrentFate == nil then
        ResetDynamicAoeSwitchState()
        RsrDynamicSingleApplied = false
        TurnOnAoes()
        return
    end

    local enemyCount = CountNearbyFateEnemies(DynamicAoeCheckRadius, CurrentFate.fateId)
    local shouldUseAoe = enemyCount >= DynamicAoeEnemyCount

    local sameNameRequired = DynamicAoeSameNameEnemyCount or 2
    local sameNameBlockedAoe = false
    if shouldUseAoe and sameNameRequired > 1 and Svc.Targets.Target ~= nil then
        local currentTargetName = GetTargetName()
        local sameNameEnemyCount = CountNearbyFateEnemiesWithName(
            DynamicAoeCheckRadius,
            CurrentFate.fateId,
            currentTargetName
        )
        if sameNameEnemyCount < sameNameRequired then
            shouldUseAoe = false
            sameNameBlockedAoe = true
        end
    end

    if sameNameBlockedAoe and enemyCount >= (DynamicAoeMixedPackMinimumEnemies or 2) then
        shouldUseAoe = true
    end

    local desiredMode = shouldUseAoe and "aoe" or "single"
    if DynamicAoeDecisionMode ~= desiredMode then
        DynamicAoeDecisionMode = desiredMode
        DynamicAoeDecisionCount = 1
    else
        DynamicAoeDecisionCount = (DynamicAoeDecisionCount or 0) + 1
    end

    local requiredStable = desiredMode == "aoe"
        and (DynamicAoeEnableStableSamples or 2)
        or (DynamicAoeDisableStableSamples or 3)
    if (DynamicAoeDecisionCount or 0) < requiredStable then
        return
    end

    local now = os.clock()
    local switchCooldown = DynamicAoeSwitchCooldownSeconds or 1.6
    if (now - (DynamicAoeLastSwitchAt or 0)) < switchCooldown then
        return
    end

    if desiredMode == "aoe" then
        if not AoesOn or RsrDynamicSingleApplied then
            RsrDynamicSingleApplied = false
            TurnOnAoes()
            DynamicAoeLastSwitchAt = now
        end
        return
    end

    if RotationPlugin == "RSR" then
        if not RsrDynamicSingleApplied then
            SafeYield("/rotation on")
            SafeYield("/rotation settings aoetype 1")
            RsrDynamicSingleApplied = true
            DynamicAoeLastSwitchAt = now
        end
        AoesOn = false
    elseif RotationPlugin == "BMR" or RotationPlugin == "VBM" then
        RsrDynamicSingleApplied = false
        if AoesOn then
            TurnOffAoes()
            DynamicAoeLastSwitchAt = now
        end
    else
        RsrDynamicSingleApplied = false
        if not AoesOn then
            TurnOnAoes()
            DynamicAoeLastSwitchAt = now
        end
    end
end

function Normalize(v)
    local len = v:Length()
    if len == 0 then return v end
    return v / len
end

function MoveToTargetHitbox()
    --Dalamud.Log("[FATE] Move to Target Hit Box")
    if Svc.Targets.Target == nil then
        return
    end
    if not IsCurrentTargetInsideCurrentFateBounds(GetCurrentFateMoveBoundaryBuffer()) then
        ClearTarget()
        return
    end

    local playerPos = GetLocalPlayerPosition()
    if playerPos == nil then
        return
    end

    local targetPos = Svc.Targets.Target.Position
    local distance = GetDistanceToTarget()
    if distance == 0 then return end

    local desiredRange = math.max(0.1, GetTargetHitboxRadius() + GetPlayerHitboxRadius() + MaxDistance)
    local STOP_EPS = 0.5
    if distance <= (desiredRange + STOP_EPS) then return end
    local dir = Normalize(playerPos - targetPos)
    if dir:Length() == 0 then return end
    local ideal = targetPos + (dir * desiredRange)
    local boundedIdeal = ClampPositionToCurrentFateBounds(ideal, GetCurrentFateMoveBoundaryBuffer())
    local newPos = IPC.vnavmesh.PointOnFloor(boundedIdeal, false, 1.5) or boundedIdeal

    -- Avoid reissuing tiny movement commands that cause 1px jitter at fate edges.
    local now = os.clock()
    local posDeadzone = 0.5
    local timeDeadzone = FastCombatPacing and 0.35 or 1.0
    local targetMicroMoved = true
    if MoveToTargetLastTargetPos ~= nil then
        targetMicroMoved = DistanceBetweenFlat(MoveToTargetLastTargetPos, targetPos) >= 0.3
    end
    if not targetMicroMoved and MoveToTargetLastPos ~= nil and MoveToTargetLastAt ~= nil
        and now - MoveToTargetLastAt < timeDeadzone
        and DistanceBetweenFlat(MoveToTargetLastPos, newPos) < posDeadzone
    then
        return
    end

    MoveToTargetLastTargetPos = targetPos
    MoveToTargetLastPos = newPos
    MoveToTargetLastAt = now
    IPC.vnavmesh.PathfindAndMoveTo(newPos, false)
end

function HasPlugin(name)
    for plugin in luanet.each(Svc.PluginInterface.InstalledPlugins) do
        if plugin.InternalName == name and plugin.IsLoaded then
            return true
        end
    end
    return false
end

--#endregion Utils

--#region Fate Functions
function IsCollectionsFate(fateName)
    for i, collectionsFate in ipairs(SelectedZone.fatesList.collectionsFates) do
        if collectionsFate.fateName == fateName then
            return true
        end
    end
    return false
end

function IsBossFate(fate)
    if fate == nil then
        return false
    end
    return fate.IconId == 60722
end

function IsOtherNpcFate(fateName)
    for i, otherNpcFate in ipairs(SelectedZone.fatesList.otherNpcFates) do
        if otherNpcFate.fateName == fateName then
            return true
        end
    end
    return false
end

function IsSpecialFate(fateName)
    if SelectedZone.fatesList.specialFates == nil then
        return false
    end
    for i, specialFate in ipairs(SelectedZone.fatesList.specialFates) do
        if specialFate == fateName then
            return true
        end
    end
end

function ShouldSkipCollectionsFate(fateName)
    if not JoinCollectionsFates then
        for i, collectionsFate in ipairs(SelectedZone.fatesList.collectionsFates) do
            if collectionsFate.fateName == fateName then
                return true
            end
        end
    end
    return false
end

function ShouldSkipOtherNpcFate(fateName)
    if not JoinOtherNpcFates then
        for i, otherNpcFate in ipairs(SelectedZone.fatesList.otherNpcFates) do
            if otherNpcFate.fateName == fateName then
                return true
            end
        end
    end
    return false
end

function IsUserInputBlackListedFate(fateName)
    local array = split(Config.Get("Blacklist"), ',')
    return includes(array, fateName)
end

function IsLiteralBlackList(fateName)
    for i, blacklistedFate in ipairs(SelectedZone.fatesList.blacklistedFates) do
        if blacklistedFate == fateName then
            return true
        end
    end
    return false
end

function IsBlacklistedFate(fateName)
    return IsLiteralBlackList(fateName)
        or IsUserInputBlackListedFate(fateName)
        or ShouldSkipCollectionsFate(fateName)
        or ShouldSkipOtherNpcFate(fateName)
end

function GetFateNpcName(fateName)
    for i, fate in ipairs(SelectedZone.fatesList.otherNpcFates) do
        if fate.fateName == fateName then
            return fate.npcName
        end
    end
    for i, fate in ipairs(SelectedZone.fatesList.collectionsFates) do
        if fate.fateName == fateName then
            return fate.npcName
        end
    end
end

-- 出現中FATEの情報をJSONLで保存する
function JsonEscape(value)
    local str = tostring(value)
    str = str:gsub("\\", "\\\\")
    str = str:gsub("\"", "\\\"")
    str = str:gsub("\r", "\\r")
    str = str:gsub("\n", "\\n")
    str = str:gsub("\t", "\\t")
    return str
end

function IsArray(value)
    if type(value) ~= "table" then
        return false
    end
    local count = 0
    local maxIndex = 0
    for k, _ in pairs(value) do
        if type(k) ~= "number" or k % 1 ~= 0 then
            return false
        end
        if k > maxIndex then
            maxIndex = k
        end
        count = count + 1
    end
    return maxIndex == count
end

function EncodeJsonValue(value)
    local valueType = type(value)
    if value == nil then
        return "null"
    end
    if valueType == "string" then
        return "\"" .. JsonEscape(value) .. "\""
    end
    if valueType == "number" then
        return tostring(value)
    end
    if valueType == "boolean" then
        return value and "true" or "false"
    end
    if valueType == "table" then
        if IsArray(value) then
            local parts = {}
            for i = 1, #value do
                parts[#parts + 1] = EncodeJsonValue(value[i])
            end
            return "[" .. table.concat(parts, ",") .. "]"
        end
        local keys = {}
        for k, _ in pairs(value) do
            keys[#keys + 1] = k
        end
        table.sort(keys, function(a, b) return tostring(a) < tostring(b) end)
        local parts = {}
        for i = 1, #keys do
            local key = keys[i]
            parts[#parts + 1] = "\"" .. JsonEscape(key) .. "\":" .. EncodeJsonValue(value[key])
        end
        return "{" .. table.concat(parts, ",") .. "}"
    end
    return "\"\""
end

function BuildFateSnapshot()
    local activeFates = Fates.GetActiveFates()
    if activeFates == nil then
        return nil
    end

    local fateList = {}
    for i = 0, activeFates.Count - 1 do
        local fateObj = activeFates[i]
        local fateName = fateObj.Name or ""
        local npcName = nil
        if SelectedZone ~= nil and SelectedZone.fatesList ~= nil then
            npcName = GetFateNpcName(fateName)
        end
        fateList[#fateList + 1] = {
            id = fateObj.Id,
            name = fateName,
            npcName = npcName
        }
    end

    table.sort(fateList, function(a, b)
        return (a.id or 0) < (b.id or 0)
    end)

    return {
        timestamp = os.time(),
        clientLanguage = GameLanguage or "",
        zoneId = Svc.ClientState.TerritoryType,
        zoneName = SelectedZone and SelectedZone.zoneName or "",
        fates = fateList
    }
end

function BuildFateSnapshotSignature(snapshot)
    if snapshot == nil or snapshot.fates == nil then
        return ""
    end
    local parts = { tostring(snapshot.zoneId or "") }
    for i = 1, #snapshot.fates do
        local fate = snapshot.fates[i]
        parts[#parts + 1] = tostring(fate.id or "") .. "|" ..
            tostring(fate.name or "") .. "|" ..
            tostring(fate.npcName or "")
    end
    return table.concat(parts, "||")
end

function GetFateTypeCategory(fateData)
    if fateData == nil then
        return "unknown", "不明"
    end

    local isCollection = fateData.isCollectionsFate == true
    local isBoss = fateData.isBossFate == true
    if not isBoss and fateData.fateObject ~= nil and fateData.fateObject.IconId ~= nil then
        isBoss = fateData.fateObject.IconId == 60722
    end

    if isCollection then
        return "collection", "収集"
    end
    if isBoss then
        return "boss", "ボス"
    end
    return "combat", "討伐"
end

function EnsureFateTimingEntry(fateData)
    if fateData == nil or fateData.fateId == nil then
        return nil
    end
    if FateTimingById == nil then
        FateTimingById = {}
    end

    local entry = FateTimingById[fateData.fateId]
    if entry ~= nil then
        return entry
    end

    local fateType, fateTypeLabel = GetFateTypeCategory(fateData)
    entry = {
        fateId = fateData.fateId,
        fateName = fateData.fateName or "",
        fateType = fateType,
        fateTypeLabel = fateTypeLabel,
        zoneId = Svc.ClientState.TerritoryType,
        zoneName = SelectedZone and SelectedZone.zoneName or "",
        trackingStartAt = os.time(),
        combatStartAt = nil,
        logged = false
    }
    FateTimingById[fateData.fateId] = entry
    return entry
end

function NoteFateCombatStart(fateData)
    if fateData == nil or not Svc.Condition[CharacterCondition.inCombat] then
        return
    end
    local entry = EnsureFateTimingEntry(fateData)
    if entry == nil or entry.combatStartAt ~= nil then
        return
    end
    entry.combatStartAt = os.time()
    Dalamud.Log(string.format("[FATE] Combat start tracked for fate #%s %s", tostring(entry.fateId),
        tostring(entry.fateName)))
end

function AppendFateResultLogLine(line)
    if line == nil or line == "" then
        return
    end

    local logPath = NormalizeFateLogValue(FateResultLogResolvedPath)
    if logPath == "" then
        logPath = NormalizeFateLogValue(FateResultLogPath)
    end
    if logPath == "" then
        logPath = "fates_results.jsonl"
    end

    local file, err = io.open(logPath, "a")
    if not file then
        local fallbackPath, _ = ResolveWritableFateLogPath(logPath)
        if fallbackPath ~= nil and fallbackPath ~= "" and fallbackPath ~= logPath then
            local fallbackFile, fallbackErr = io.open(fallbackPath, "a")
            if fallbackFile ~= nil then
                file = fallbackFile
                logPath = fallbackPath
                FateResultLogResolvedPath = fallbackPath
            else
                err = fallbackErr
            end
        end
    end

    if not file then
        local now = os.time()
        if FateResultLogLastOpenErrorAt == nil or (now - FateResultLogLastOpenErrorAt) >= 30 then
            FateResultLogLastOpenErrorAt = now
            FateResultLogError = true
            Dalamud.Log("[FATE] Failed to open fate results log file: " .. tostring(err))
        end
        return
    end

    file:write(line .. "\n")
    file:close()
end

function FinalizeFateTimingLog(fateData, finalState)
    if fateData == nil or fateData.fateId == nil then
        return
    end
    local entry = EnsureFateTimingEntry(fateData)
    if entry == nil or entry.logged == true then
        return
    end

    local now = os.time()
    local fateType, fateTypeLabel = GetFateTypeCategory(fateData)
    local combatStarted = entry.combatStartAt ~= nil and entry.combatStartAt > 0
    local combatDurationSec = 0
    if combatStarted then
        combatDurationSec = math.max(0, now - entry.combatStartAt)
    end
    local trackedDurationSec = math.max(0, now - (entry.trackingStartAt or now))

    local result = "unknown"
    local completed = false
    local failed = false
    if finalState == FateState.Ended then
        result = "completed"
        completed = true
    elseif finalState == FateState.Failed then
        result = "failed"
        failed = true
    end

    local record = {
        timestamp = now,
        zoneId = entry.zoneId,
        zoneName = entry.zoneName,
        fateId = entry.fateId,
        fateName = entry.fateName,
        fateType = fateType,
        fateTypeLabel = fateTypeLabel,
        result = result,
        completed = completed,
        failed = failed,
        combatStarted = combatStarted,
        trackingStartAt = entry.trackingStartAt,
        combatStartAt = entry.combatStartAt,
        endAt = now,
        combatDurationSec = combatDurationSec,
        trackingDurationSec = trackedDurationSec
    }
    RecordZoneFateOutcome(entry.zoneId, completed, failed, combatDurationSec)

    local ok, line = pcall(EncodeJsonValue, record)
    if not ok then
        FateResultLogError = true
        Dalamud.Log("[FATE] Failed to encode fate results log JSON: " .. tostring(line))
        return
    end

    AppendFateResultLogLine(line)
    UpdateFateResultSummaryFromRecord(record)
    WriteFateResultSummaryCsv(false)
    entry.logged = true
    if FateTimingById ~= nil then
        FateTimingById[entry.fateId] = nil
    end
end

function EnsureFateResultSummaryEntry(record)
    if record == nil then
        return nil
    end
    if FateResultSummaryByKey == nil then
        FateResultSummaryByKey = {}
    end
    local key = tostring(record.zoneId or 0) .. ":" .. tostring(record.fateId or 0)
    local entry = FateResultSummaryByKey[key]
    if entry == nil then
        entry = {
            zoneId = record.zoneId or 0,
            zoneName = record.zoneName or "",
            fateId = record.fateId or 0,
            fateName = record.fateName or "",
            fateType = record.fateType or "",
            fateTypeLabel = record.fateTypeLabel or "",
            totalRuns = 0,
            completed = 0,
            failed = 0,
            combatSamples = 0,
            totalCombatSec = 0,
            minCombatSec = nil,
            maxCombatSec = nil,
            lastEndAt = 0
        }
        FateResultSummaryByKey[key] = entry
    end
    return entry
end

function UpdateFateResultSummaryFromRecord(record)
    local entry = EnsureFateResultSummaryEntry(record)
    if entry == nil then
        return
    end

    entry.zoneName = record.zoneName or entry.zoneName
    entry.fateName = record.fateName or entry.fateName
    entry.fateType = record.fateType or entry.fateType
    entry.fateTypeLabel = record.fateTypeLabel or entry.fateTypeLabel
    entry.totalRuns = (entry.totalRuns or 0) + 1
    if record.completed == true then
        entry.completed = (entry.completed or 0) + 1
    elseif record.failed == true then
        entry.failed = (entry.failed or 0) + 1
    end

    local combatSec = tonumber(record.combatDurationSec) or 0
    if combatSec > 0 then
        entry.combatSamples = (entry.combatSamples or 0) + 1
        entry.totalCombatSec = (entry.totalCombatSec or 0) + combatSec
        if entry.minCombatSec == nil or combatSec < entry.minCombatSec then
            entry.minCombatSec = combatSec
        end
        if entry.maxCombatSec == nil or combatSec > entry.maxCombatSec then
            entry.maxCombatSec = combatSec
        end
    end
    entry.lastEndAt = record.endAt or os.time()
    FateResultSummaryDirty = true
end

function ParseResultLogFieldString(line, key)
    if line == nil or key == nil then
        return nil
    end
    local value = line:match('"' .. key .. '":"(.-)"')
    if value == nil then
        return nil
    end
    value = value:gsub('\\"', '"')
    value = value:gsub("\\\\", "\\")
    return value
end

function ParseResultLogFieldNumber(line, key)
    if line == nil or key == nil then
        return nil
    end
    local raw = line:match('"' .. key .. '":(-?%d+%.?%d*)')
    if raw == nil then
        return nil
    end
    return tonumber(raw)
end

function ParseResultLogFieldBool(line, key)
    if line == nil or key == nil then
        return nil
    end
    local truePattern = '"' .. key .. '":true'
    if line:match(truePattern) ~= nil then
        return true
    end
    local falsePattern = '"' .. key .. '":false'
    if line:match(falsePattern) ~= nil then
        return false
    end
    return nil
end

function LoadFateResultSummaryFromLog()
    FateResultSummaryByKey = {}
    local logPath = NormalizeFateLogValue(FateResultLogResolvedPath)
    if logPath == "" then
        logPath = NormalizeFateLogValue(FateResultLogPath)
    end
    if logPath == "" then
        logPath = "fates_results.jsonl"
    end

    local file = io.open(logPath, "r")
    if file == nil then
        return
    end

    local lineCount = 0
    for line in file:lines() do
        local fateId = ParseResultLogFieldNumber(line, "fateId")
        local zoneId = ParseResultLogFieldNumber(line, "zoneId")
        if fateId ~= nil and zoneId ~= nil then
            local record = {
                zoneId = zoneId,
                zoneName = ParseResultLogFieldString(line, "zoneName") or "",
                fateId = fateId,
                fateName = ParseResultLogFieldString(line, "fateName") or "",
                fateType = ParseResultLogFieldString(line, "fateType") or "",
                fateTypeLabel = ParseResultLogFieldString(line, "fateTypeLabel") or "",
                completed = ParseResultLogFieldBool(line, "completed") == true,
                failed = ParseResultLogFieldBool(line, "failed") == true,
                combatDurationSec = ParseResultLogFieldNumber(line, "combatDurationSec") or 0,
                endAt = ParseResultLogFieldNumber(line, "endAt") or 0
            }
            UpdateFateResultSummaryFromRecord(record)
            RecordZoneFateOutcome(
                zoneId,
                record.completed == true,
                record.failed == true,
                record.combatDurationSec or 0
            )
            lineCount = lineCount + 1
        end
    end
    file:close()
    FateResultSummaryDirty = true
    Dalamud.Log("[FATE] Loaded fate result summary seed entries: " .. tostring(lineCount))
end

function EscapeCsvCell(value)
    local text = tostring(value or "")
    if string.find(text, '"', 1, true) then
        text = text:gsub('"', '""')
    end
    if string.find(text, ",", 1, true) or string.find(text, "\n", 1, true) then
        text = '"' .. text .. '"'
    end
    return text
end

function WriteFateResultSummaryCsv(forceWrite)
    local force = forceWrite == true
    local now = os.time()
    if FateResultSummaryByKey == nil then
        return
    end
    if not force then
        if FateResultSummaryDirty ~= true then
            return
        end
        if now - (FateResultSummaryLastWriteAt or 0) < (FateResultSummaryWriteIntervalSeconds or 30) then
            return
        end
    end

    local csvPath = NormalizeFateLogValue(FateResultSummaryCsvResolvedPath)
    if csvPath == "" then
        csvPath = NormalizeFateLogValue(FateResultSummaryCsvPath)
    end
    if csvPath == "" then
        csvPath = "fates_results_summary.csv"
    end

    local file, err = io.open(csvPath, "w")
    if file == nil then
        local fallbackPath, _ = ResolveWritableSummaryLogPath(csvPath)
        if fallbackPath ~= nil and fallbackPath ~= "" and fallbackPath ~= csvPath then
            local fallbackFile, fallbackErr = io.open(fallbackPath, "w")
            if fallbackFile ~= nil then
                file = fallbackFile
                csvPath = fallbackPath
                FateResultSummaryCsvResolvedPath = fallbackPath
            else
                err = fallbackErr
            end
        end
    end

    if file == nil then
        if FateResultSummaryLastOpenErrorAt == nil or (now - FateResultSummaryLastOpenErrorAt) >= 30 then
            FateResultSummaryLastOpenErrorAt = now
            Dalamud.Log("[FATE] Failed to write fate result summary CSV: " .. tostring(err))
        end
        return
    end

    file:write(
        "zoneId,zoneName,fateId,fateName,fateType,totalRuns,completed,failed,completionRate,avgCombatSec,minCombatSec,maxCombatSec,lastEndAt\n")
    local rows = {}
    for _, entry in pairs(FateResultSummaryByKey) do
        rows[#rows + 1] = entry
    end
    table.sort(rows, function(a, b)
        if (a.zoneId or 0) == (b.zoneId or 0) then
            return (a.fateId or 0) < (b.fateId or 0)
        end
        return (a.zoneId or 0) < (b.zoneId or 0)
    end)

    for _, entry in ipairs(rows) do
        local totalRuns = entry.totalRuns or 0
        local completionRate = totalRuns > 0 and ((entry.completed or 0) / totalRuns) or 0
        local avgCombatSec = (entry.combatSamples or 0) > 0 and ((entry.totalCombatSec or 0) / entry.combatSamples) or 0
        local line = table.concat({
            tostring(entry.zoneId or 0),
            EscapeCsvCell(entry.zoneName or ""),
            tostring(entry.fateId or 0),
            EscapeCsvCell(entry.fateName or ""),
            EscapeCsvCell(entry.fateTypeLabel or entry.fateType or ""),
            tostring(totalRuns),
            tostring(entry.completed or 0),
            tostring(entry.failed or 0),
            string.format("%.3f", completionRate),
            string.format("%.2f", avgCombatSec),
            tostring(entry.minCombatSec or ""),
            tostring(entry.maxCombatSec or ""),
            tostring(entry.lastEndAt or 0)
        }, ",")
        file:write(line .. "\n")
    end
    file:close()
    FateResultSummaryLastWriteAt = now
    FateResultSummaryDirty = false
end

function NormalizeFateLogValue(value)
    if value == nil then
        return ""
    end
    local text = tostring(value)
    text = text:gsub("^%s+", "")
    text = text:gsub("%s+$", "")
    return text
end

local function ParseBool(value, defaultValue)
    if type(value) == "boolean" then
        return value
    end
    if type(value) == "number" then
        return value ~= 0
    end
    if type(value) == "string" then
        local lower = string.lower(NormalizeFateLogValue(value))
        if lower == "true" or lower == "1" or lower == "yes" then
            return true
        end
        if lower == "false" or lower == "0" or lower == "no" then
            return false
        end
    end
    return defaultValue
end

function ResolveWritableFateLogPath(configuredPath)
    local candidates = {}
    local function addCandidate(path)
        local normalized = NormalizeFateLogValue(path)
        if normalized == "" then
            return
        end
        for _, existing in ipairs(candidates) do
            if existing == normalized then
                return
            end
        end
        candidates[#candidates + 1] = normalized
    end

    addCandidate(configuredPath)
    addCandidate("Fates/fates_active.jsonl")
    addCandidate("fates_active.jsonl")
    local appData = os.getenv("APPDATA")
    if appData ~= nil and appData ~= "" then
        addCandidate(appData .. "/XIVLauncher/pluginConfigs/SomethingNeedDoing/fates_active.jsonl")
    end

    local lastError = nil
    for _, candidate in ipairs(candidates) do
        local probe, err = io.open(candidate, "a")
        if probe ~= nil then
            probe:close()
            return candidate, nil
        end
        lastError = tostring(err)
    end

    return NormalizeFateLogValue(configuredPath), lastError
end

function ResolveWritableSummaryLogPath(configuredPath)
    local candidates = {}
    local function addCandidate(path)
        local normalized = NormalizeFateLogValue(path)
        if normalized == "" then
            return
        end
        for _, existing in ipairs(candidates) do
            if existing == normalized then
                return
            end
        end
        candidates[#candidates + 1] = normalized
    end

    addCandidate(configuredPath)
    addCandidate("Fates/fates_results_summary.csv")
    addCandidate("fates_results_summary.csv")
    local appData = os.getenv("APPDATA")
    if appData ~= nil and appData ~= "" then
        addCandidate(appData .. "/XIVLauncher/pluginConfigs/SomethingNeedDoing/fates_results_summary.csv")
    end

    local lastError = nil
    for _, candidate in ipairs(candidates) do
        local probe, err = io.open(candidate, "a")
        if probe ~= nil then
            probe:close()
            return candidate, nil
        end
        lastError = tostring(err)
    end

    return NormalizeFateLogValue(configuredPath), lastError
end

function MaybeLogActiveFates()
    if not FateDataLogEnabled then
        return
    end
    local now = os.time()
    if now - FateDataLogLastTime < FateDataLogIntervalSeconds then
        return
    end

    local snapshot = BuildFateSnapshot()
    if snapshot == nil then
        return
    end
    local activeCount = snapshot.fates and #snapshot.fates or 0
    RecordZoneActivitySample(snapshot.zoneId, activeCount)

    FateDataLogLastTime = now
    local signature = BuildFateSnapshotSignature(snapshot)
    if signature == FateDataLogLastSignature then
        return
    end
    FateDataLogLastSignature = signature

    local ok, line = pcall(EncodeJsonValue, snapshot)
    if not ok then
        FateDataLogError = true
        Dalamud.Log("[FATE] Failed to encode fate data log JSON: " .. tostring(line))
        return
    end

    local logPath = NormalizeFateLogValue(FateDataLogResolvedPath)
    if logPath == "" then
        logPath = NormalizeFateLogValue(FateDataLogPath)
    end
    if logPath == "" then
        logPath = "fates_active.jsonl"
    end

    local file, err = io.open(logPath, "a")
    if not file then
        local fallbackPath, _ = ResolveWritableFateLogPath(logPath)
        if fallbackPath ~= nil and fallbackPath ~= "" and fallbackPath ~= logPath then
            local fallbackFile, fallbackErr = io.open(fallbackPath, "a")
            if fallbackFile ~= nil then
                file = fallbackFile
                logPath = fallbackPath
                FateDataLogResolvedPath = fallbackPath
            else
                err = fallbackErr
            end
        end
    end
    if not file then
        local now = os.time()
        if FateDataLogLastOpenErrorAt == nil or (now - FateDataLogLastOpenErrorAt) >= 30 then
            FateDataLogLastOpenErrorAt = now
            Dalamud.Log("[FATE] Failed to open fate data log file: " .. tostring(err))
        end
        return
    end
    file:write(line .. "\n")
    file:close()
end

function IsFateActive(fate)
    if fate == nil or fate.State == nil then
        return false
    else
        return fate.State ~= FateState.Ending and fate.State ~= FateState.Ended and fate.State ~= FateState.Failed
    end
end

function InActiveFate()
    local activeFates = Fates.GetActiveFates()
    for i = 0, activeFates.Count - 1 do
        if activeFates[i].InFate == true and IsFateActive(activeFates[i]) then
            return true
        end
    end
    return false
end

function BuildZoneData(zoneId)
    local nextZone = nil

    for i, zone in ipairs(FatesData) do
        if zoneId == zone.zoneId then
            nextZone = zone
        end
    end
    if nextZone == nil then
        yield("/echo [FATE] Current zone is only partially supported. No data on npc fates.")
        nextZone = {
            zoneName = "",
            zoneId = zoneId,
            fatesList = {
                collectionsFates = {},
                otherNpcFates = {},
                bossFates = {},
                blacklistedFates = {},
                fatesWithContinuations = {}
            }
        }
    end

    nextZone.zoneName = nextZone.zoneName
    nextZone.aetheryteList = {}
    local aetherytes = GetAetherytesInZone(zoneId)
    for _, aetheryte in ipairs(aetherytes) do
        local aetherytePos = Instances.Telepo:GetAetherytePosition(aetheryte.AetheryteId)
        local aetheryteTable = {
            aetheryteName = GetAetheryteName(aetheryte),
            aetheryteId = aetheryte.AetheryteId,
            position = aetherytePos,
            aetheryteObj = aetheryte
        }
        table.insert(nextZone.aetheryteList, aetheryteTable)
    end

    if nextZone.flying == nil then
        nextZone.flying = true
    end

    return nextZone
end

function SelectNextZone()
    return BuildZoneData(Svc.ClientState.TerritoryType)
end

function EnsureZonePerformanceEntry(zoneId)
    if zoneId == nil then
        return nil
    end
    if ZonePerformanceById == nil then
        ZonePerformanceById = {}
    end
    local entry = ZonePerformanceById[zoneId]
    if entry == nil then
        entry = {
            activeEma = 0,
            completed = 0,
            failed = 0,
            avgCombatSec = 0,
            combatSamples = 0,
            unresponsiveCount = 0,
            unresponsiveEma = 0,
            noEligibleCount = 0,
            blockedUntil = 0,
            lastActiveAt = 0
        }
        ZonePerformanceById[zoneId] = entry
    end
    return entry
end

function RecordZoneActivitySample(zoneId, activeFateCount)
    local entry = EnsureZonePerformanceEntry(zoneId)
    if entry == nil then
        return
    end
    local count = tonumber(activeFateCount) or 0
    if count < 0 then
        count = 0
    end
    entry.activeEma = (entry.activeEma or 0) * 0.75 + count * 0.25
    entry.unresponsiveEma = math.max(0, (entry.unresponsiveEma or 0) * 0.98)
    if count > 0 then
        entry.lastActiveAt = os.time()
        entry.noEligibleCount = 0
        entry.unresponsiveEma = math.max(0, entry.unresponsiveEma * 0.92)
    end
end

function RecordZoneNoEligibleFates(zoneId)
    local entry = EnsureZonePerformanceEntry(zoneId)
    if entry == nil then
        return
    end
    local now = os.clock()
    entry.noEligibleCount = (entry.noEligibleCount or 0) + 1
    if entry.noEligibleCount >= 2 then
        entry.blockedUntil = now + (ZoneNoFateBlockSeconds or 180)
    end
end

function RecordZoneFateOutcome(zoneId, completed, failed, combatDurationSec)
    local entry = EnsureZonePerformanceEntry(zoneId)
    if entry == nil then
        return
    end
    if completed == true then
        entry.completed = (entry.completed or 0) + 1
        entry.unresponsiveEma = math.max(0, (entry.unresponsiveEma or 0) * 0.8)
    elseif failed == true then
        entry.failed = (entry.failed or 0) + 1
        entry.unresponsiveEma = math.max(0, (entry.unresponsiveEma or 0) * 0.95)
    end

    local combatSec = tonumber(combatDurationSec) or 0
    if combatSec > 0 then
        if entry.avgCombatSec == nil or entry.avgCombatSec <= 0 then
            entry.avgCombatSec = combatSec
        else
            entry.avgCombatSec = entry.avgCombatSec * 0.75 + combatSec * 0.25
        end
        entry.combatSamples = (entry.combatSamples or 0) + 1
    end
end

function RecordZoneUnresponsiveSkip(zoneId, reason)
    local entry = EnsureZonePerformanceEntry(zoneId)
    if entry == nil then
        return
    end
    entry.unresponsiveCount = (entry.unresponsiveCount or 0) + 1
    entry.unresponsiveEma = (entry.unresponsiveEma or 0) * 0.7 + 1
    if reason ~= nil then
        entry.lastUnresponsiveReason = tostring(reason)
    end
end

local function GetPreferredHighLevelZoneBonusWeight(zoneId)
    if zoneId == 1191 or zoneId == 1192 then -- Heritage Found / Living Memory
        return 1.0
    end
    if zoneId == 1190 then -- Shaaloani (lower than the two guaranteed 96+ maps)
        return 0.5
    end
    return 0
end

function GetBestDawntrailZoneId(currentZoneId)
    if DynamicZoneSelectionEnabled ~= true then
        return nil
    end
    local order = { 1187, 1188, 1189, 1190, 1191, 1192 }
    local now = os.clock()
    local bestZoneId = nil
    local bestScore = -999999
    local currentIndex = nil
    for idx, zoneId in ipairs(order) do
        if zoneId == currentZoneId then
            currentIndex = idx
            break
        end
    end

    for idx, zoneId in ipairs(order) do
        local entry = EnsureZonePerformanceEntry(zoneId)
        local score = 0
        if entry ~= nil then
            if (entry.blockedUntil or 0) > now then
                score = score - 100
            else
                local activityScore = (entry.activeEma or 0) * 5.0
                local runCount = (entry.completed or 0) + (entry.failed or 0)
                local completionRate = runCount > 0 and ((entry.completed or 0) / runCount) or 0.65
                local completionConfidence = math.min(1, runCount / 8)
                local completionScore = completionRate * (7 + (completionConfidence * 3))
                local speedScore = 0
                if (entry.avgCombatSec or 0) > 0 then
                    -- FATE HP scales with nearby players, so keep combat-time influence intentionally tiny.
                    speedScore = math.max(0.1, math.min(1.2, 180 / entry.avgCombatSec)) * 0.25
                end
                local recencyBonus = 0
                local lastActiveAt = entry.lastActiveAt or 0
                if lastActiveAt > 0 and (os.time() - lastActiveAt) <= 300 then
                    recencyBonus = 2
                end
                local noEligiblePenalty = (entry.noEligibleCount or 0) * 1.5
                local unresponsivePenalty = ((entry.unresponsiveEma or 0) * 6.5) +
                    ((entry.unresponsiveCount or 0) * 0.35)
                score = activityScore + completionScore + speedScore + recencyBonus - noEligiblePenalty -
                    unresponsivePenalty
            end
        end

        local highLevelWeight = GetPreferredHighLevelZoneBonusWeight(zoneId)
        if PreferredHighLevelZoneBiasEnabled == true and highLevelWeight > 0 then
            local bonus = (tonumber(PreferredHighLevelZoneScoreBonus) or 2.4) * highLevelWeight
            if entry ~= nil then
                local noEligibleCount = entry.noEligibleCount or 0
                if noEligibleCount > 0 then
                    local decay = tonumber(PreferredHighLevelZonePenaltyDecay) or 0.6
                    bonus = bonus * math.max(0.2, decay ^ noEligibleCount)
                end
            end
            score = score + bonus
        end

        if zoneId == currentZoneId then
            score = score - 8
        elseif currentIndex ~= nil then
            local step = idx - currentIndex
            if step <= 0 then
                step = step + #order
            end
            if step == 1 then
                score = score + 1.2
            else
                score = score + math.max(0, 0.8 - (step * 0.15))
            end
        end

        if score > bestScore then
            bestScore = score
            bestZoneId = zoneId
        end
    end

    return bestZoneId
end

function GetNextDawntrailZoneId(currentZoneId)
    local dawntrailZoneOrder = { 1187, 1188, 1189, 1190, 1191, 1192 }
    for i, zoneId in ipairs(dawntrailZoneOrder) do
        if currentZoneId == zoneId then
            return dawntrailZoneOrder[(i % #dawntrailZoneOrder) + 1]
        end
    end
    return dawntrailZoneOrder[1]
end

function SelectNextDawntrailZone()
    local currentZoneId = Svc.ClientState.TerritoryType
    RecordZoneNoEligibleFates(currentZoneId)
    local nextZoneId = GetNextDawntrailZoneId(currentZoneId)
    local bestZoneId = GetBestDawntrailZoneId(currentZoneId)
    if bestZoneId ~= nil then
        nextZoneId = bestZoneId
    end
    ZoneSelectionLastSwitchAt = os.clock()
    SelectedZone = BuildZoneData(nextZoneId)
    SuccessiveInstanceChanges = 0
    CurrentFate = nil
    NextFate = nil
    PrefetchedNextFateId = nil
    PrefetchedNextFateAt = 0
    FatePrefetchLastAttemptAt = 0
    CombatStartBoostUntil = 0
    CombatStartBoostFateId = nil
    TeleportDecisionLastFateId = nil
    TeleportDecisionPreferAetheryte = false
    ResetNoCombatRecoveryState()
    ResetMeleeEngageRecoveryState()
    ResetPreAcquireState()
    ResetDynamicAoeSwitchState()
    ResetMiddleDismountState()
    Dalamud.Log("[FATE] No eligible fates. Switching to zone: " .. (SelectedZone.zoneName or ""))
end

function BuildFateTable(fateObj)
    Dalamud.Log("[FATE] Enter->BuildFateTable")
    if fateObj == nil then
        Dalamud.Log("[FATE] BuildFateTable called with nil fate object.")
        return nil
    end

    local fateTable = {
        fateObject = fateObj,
        fateId = fateObj.Id,
        fateName = fateObj.Name,
        duration = fateObj.Duration,
        startTime = fateObj.StartTimeEpoch,
        position = fateObj.Location,
        isBonusFate = fateObj.IsBonus,
    }

    if fateTable.position == nil then
        Dalamud.Log("[FATE] Warning: fate #" .. tostring(fateTable.fateId) .. " has nil position (Location)")
    end

    fateTable.npcName = GetFateNpcName(fateTable.fateName)

    local currentTime = EorzeaTimeToUnixTime(Instances.Framework.EorzeaTime)
    if fateTable.startTime == 0 then
        fateTable.timeLeft = 900
    else
        fateTable.timeElapsed = currentTime - fateTable.startTime
        fateTable.timeLeft = fateTable.duration - fateTable.timeElapsed
    end

    fateTable.isCollectionsFate = IsCollectionsFate(fateTable.fateName)
    fateTable.isBossFate = IsBossFate(fateTable.fateObject)
    fateTable.isOtherNpcFate = IsOtherNpcFate(fateTable.fateName)
    fateTable.isSpecialFate = IsSpecialFate(fateTable.fateName)
    fateTable.isBlacklistedFate = IsBlacklistedFate(fateTable.fateName, IsUserInputBlackListedFate)

    fateTable.continuationIsBoss = false
    fateTable.hasContinuation = false
    for _, continuationFate in ipairs(SelectedZone.fatesList.fatesWithContinuations) do
        if fateTable.fateName == continuationFate.fateName then
            fateTable.hasContinuation = true
            fateTable.continuationIsBoss = continuationFate.continuationIsBoss
        end
    end

    return fateTable
end

local function Clamp(value, minValue, maxValue)
    if value < minValue then
        return minValue
    end
    if value > maxValue then
        return maxValue
    end
    return value
end

local function EnsureFateSelectionMetrics(fate)
    if fate == nil then
        return
    end
    if fate.selectionMetricsComputed == true then
        return
    end

    local progress = GetFateProgressValue(fate, 0) or 0
    local timeLeft = tonumber(fate.timeLeft) or 0
    local travelDistance = GetDistanceToPointWithAetheryteTravel(fate.position)
    local travelSeconds = travelDistance / 7.0
    local arrivalSlackSeconds = timeLeft - travelSeconds

    local bonusScore = fate.isBonusFate and 120 or 0
    local specialScore = fate.isSpecialFate and 35 or 0
    local combatTypeBonus = (not fate.isBossFate and not fate.isCollectionsFate and not fate.isOtherNpcFate)
        and (CombatFateSelectionBonus or 0) or 0
    local bossTypePenalty = (fate.isBossFate and not fate.isSpecialFate) and (BossFateSelectionPenalty or 0) or 0
    local startedScore = (fate.startTime and fate.startTime > 0) and 20 or 0
    local progressScore = progress * 2.1
    local urgencyBonus = progress >= 70 and ((progress - 70) * 1.6) or 0
    local remainingTimeScore = (Clamp(timeLeft, 0, 900) / 900) * 60
    local travelPenalty = travelDistance * 0.5
    local missPenalty = arrivalSlackSeconds < 0 and (math.abs(arrivalSlackSeconds) * 1.2) or 0

    fate.selectionTravelDistance = travelDistance
    fate.selectionExpectedScore = bonusScore + specialScore + combatTypeBonus - bossTypePenalty +
        startedScore + progressScore + urgencyBonus +
        remainingTimeScore - travelPenalty - missPenalty
    fate.selectionMetricsComputed = true
end

local function GetActiveFateObjectById(fateId)
    if fateId == nil then
        return nil
    end
    local activeFates = Fates.GetActiveFates()
    if activeFates == nil then
        return nil
    end
    for i = 0, activeFates.Count - 1 do
        local fateObj = activeFates[i]
        if fateObj ~= nil and fateObj.Id == fateId and IsFateActive(fateObj) then
            return fateObj
        end
    end
    return nil
end

local function GetBestAvailableNextFate(usePrefetch)
    if usePrefetch == true and PrefetchedNextFateId ~= nil then
        local now = os.clock()
        local isExpired = PrefetchedNextFateAt == nil or (now - PrefetchedNextFateAt) > (FatePrefetchTtlSeconds or 20)
        if isExpired then
            PrefetchedNextFateId = nil
            PrefetchedNextFateAt = 0
        else
            local prefetchedObj = GetActiveFateObjectById(PrefetchedNextFateId)
            if prefetchedObj ~= nil then
                local prefetchedFate = BuildFateTable(prefetchedObj)
                if prefetchedFate ~= nil then
                    return prefetchedFate
                end
            end
            PrefetchedNextFateId = nil
            PrefetchedNextFateAt = 0
        end
    end
    return SelectNextFate()
end

local function TryPrefetchNextFate()
    if FatePrefetchProgressThreshold == nil or FatePrefetchProgressThreshold <= 0 then
        return
    end
    if CurrentFate == nil or CurrentFate.fateObject == nil then
        return
    end
    if not IsFateActive(CurrentFate.fateObject) then
        return
    end
    local progress = GetFateProgressValue(CurrentFate, nil)
    if progress == nil or progress < FatePrefetchProgressThreshold then
        return
    end
    if Svc.Condition[CharacterCondition.mounted]
        or Svc.Condition[CharacterCondition.betweenAreas]
        or Svc.Condition[CharacterCondition.betweenAreasForDuty]
        or IsLifestreamBusySafe()
    then
        return
    end

    local now = os.clock()
    if FatePrefetchLastAttemptAt ~= nil and now - FatePrefetchLastAttemptAt < (FatePrefetchIntervalSeconds or 8) then
        return
    end
    FatePrefetchLastAttemptAt = now

    local candidate = SelectNextFate()
    if candidate ~= nil and candidate.fateId ~= nil and (CurrentFate == nil or candidate.fateId ~= CurrentFate.fateId) then
        PrefetchedNextFateId = candidate.fateId
        PrefetchedNextFateAt = now
        Dalamud.Log("[FATE] Prefetched next fate #" .. tostring(candidate.fateId) .. " " .. tostring(candidate.fateName))
    end
end

--[[
    Selects the better fate based on the priority order defined in FatePriority.
    Default Priority order is "DistanceTeleport" -> "Progress" -> "Bonus" -> "TimeLeft" -> "Distance"
]]
function SelectNextFateHelper(tempFate, nextFate)
    if nextFate == nil then
        Dalamud.Log("[FATE] nextFate is nil")
        return tempFate
    elseif BonusFatesOnly then
        Dalamud.Log("[FATE] only doing bonus fates")
        --Check if WaitForBonusIfBonusBuff is true, and have eithe buff, then set BonusFatesOnlyTemp to true
        if not tempFate.isBonusFate and nextFate ~= nil and nextFate.isBonusFate then
            return nextFate
        elseif tempFate.isBonusFate and (nextFate == nil or not nextFate.isBonusFate) then
            return tempFate
        elseif not tempFate.isBonusFate and (nextFate == nil or not nextFate.isBonusFate) then
            return nil
        end
        -- if both are bonus fates, go through the regular fate selection process
    end

    -- Party Play: prioritize FATEs where party members are present
    if PrioritizeFatesWithPartyMembers == true and GetPartyPlayActive() then
        local tempHasParty = IsPartyMemberInFate(tempFate)
        local nextHasParty = IsPartyMemberInFate(nextFate)
        if tempHasParty and not nextHasParty then
            Dalamud.Log("[FATE] Prioritizing fate #" .. tempFate.fateId .. " because party member is present.")
            return tempFate
        elseif nextHasParty and not tempHasParty then
            Dalamud.Log("[FATE] Prioritizing fate #" .. nextFate.fateId .. " because party member is present.")
            return nextFate
        end
        -- if both have party members (or neither), continue with normal selection
    end

    local tempProgress = GetFateProgressValue(tempFate, 0)
    local nextProgress = GetFateProgressValue(nextFate, 0)
    if tempFate.timeLeft <= MinTimeLeftToIgnoreFate or tempProgress > CompletionToIgnoreFate then
        Dalamud.Log("[FATE] Ignoring fate #" .. tempFate.fateId .. " due to insufficient time or high completion.")
        return nextFate
    elseif nextFate == nil then
        Dalamud.Log("[FATE] Selecting #" .. tempFate.fateId .. " because no other options so far.")
        return tempFate
    elseif nextFate.timeLeft <= MinTimeLeftToIgnoreFate or nextProgress > CompletionToIgnoreFate then
        Dalamud.Log("[FATE] Ignoring fate #" .. nextFate.fateId .. " due to insufficient time or high completion.")
        return tempFate
    end

    if FateExpectedScoreEnabled ~= false then
        EnsureFateSelectionMetrics(tempFate)
        EnsureFateSelectionMetrics(nextFate)
        local tempScore = tempFate.selectionExpectedScore or 0
        local nextScore = nextFate.selectionExpectedScore or 0
        local scoreDelta = tempScore - nextScore
        if math.abs(scoreDelta) >= 2 then
            Dalamud.Log(string.format(
                "[FATE] Expected score compare: #%s %.2f vs #%s %.2f",
                tostring(tempFate.fateId),
                tempScore,
                tostring(nextFate.fateId),
                nextScore
            ))
            if scoreDelta > 0 then
                return tempFate
            else
                return nextFate
            end
        end
    end

    -- Evaluate based on priority (Loop through list return first non-equal priority)
    for _, criteria in ipairs(FatePriority) do
        if criteria == "HighLevel" then
            local tempIsHighLevel = IsHighPriorityFateLevel(tempFate)
            local nextIsHighLevel = IsHighPriorityFateLevel(nextFate)
            if tempIsHighLevel and not nextIsHighLevel then return tempFate end
            if nextIsHighLevel and not tempIsHighLevel then return nextFate end
        elseif criteria == "Progress" then
            Dalamud.Log("[FATE] Comparing progress: " ..
                tostring(tempProgress) .. " vs " .. tostring(nextProgress))
            if tempProgress > nextProgress then return tempFate end
            if tempProgress < nextProgress then return nextFate end
        elseif criteria == "Bonus" then
            Dalamud.Log("[FATE] Checking bonus status: " ..
                tostring(tempFate.isBonusFate) .. " vs " .. tostring(nextFate.isBonusFate))
            if tempFate.isBonusFate and not nextFate.isBonusFate then return tempFate end
            if nextFate.isBonusFate and not tempFate.isBonusFate then return nextFate end
        elseif criteria == "TimeLeft" then
            Dalamud.Log("[FATE] Comparing time left: " .. tempFate.timeLeft .. " vs " .. nextFate.timeLeft)
            if tempFate.timeLeft > nextFate.timeLeft then return tempFate end
            if tempFate.timeLeft < nextFate.timeLeft then return nextFate end
        elseif criteria == "Distance" then
            local tempDist = tempFate.selectionDirectDistance
            if tempDist == nil then
                tempDist = GetDistanceToPoint(tempFate.position)
                tempFate.selectionDirectDistance = tempDist
            end
            local nextDist = nextFate.selectionDirectDistance
            if nextDist == nil then
                nextDist = GetDistanceToPoint(nextFate.position)
                nextFate.selectionDirectDistance = nextDist
            end
            Dalamud.Log("[FATE] Comparing distance: " .. tempDist .. " vs " .. nextDist)
            if tempDist < nextDist then return tempFate end
            if tempDist > nextDist then return nextFate end
        elseif criteria == "DistanceTeleport" then
            EnsureFateSelectionMetrics(tempFate)
            EnsureFateSelectionMetrics(nextFate)
            local tempDist = tempFate.selectionTravelDistance or GetDistanceToPointWithAetheryteTravel(tempFate.position)
            local nextDist = nextFate.selectionTravelDistance or GetDistanceToPointWithAetheryteTravel(nextFate.position)
            Dalamud.Log("[FATE] Comparing distance: " .. tempDist .. " vs " .. nextDist)
            if tempDist < nextDist then return tempFate end
            if tempDist > nextDist then return nextFate end
        end
    end

    -- Fallback: Select fate with the lower ID
    Dalamud.Log("[FATE] Selecting lower ID fate: " .. tempFate.fateId .. " vs " .. nextFate.fateId)
    return (tempFate.fateId < nextFate.fateId) and tempFate or nextFate
end

--Gets the Location of the next Fate. Prioritizes anything with progress above 0, then by shortest time left
function SelectNextFate()
    local fates = Fates.GetActiveFates()
    if fates == nil then
        return
    end

    local nextFate = nil
    local fallbackFate = nil
    local fallbackDistance = math.maxinteger
    for i = 0, fates.Count - 1 do
        Dalamud.Log("[FATE] Building fate table")
        local tempFate = BuildFateTable(fates[i])
        Dalamud.Log("[FATE] Considering fate #" .. tempFate.fateId .. " " .. tempFate.fateName)
        Dalamud.Log("[FATE] Time left on fate #:" ..
            tempFate.fateId .. ": " .. math.floor(tempFate.timeLeft // 60) .. "min, " ..
            math.floor(tempFate.timeLeft % 60) .. "s")

        if tempFate.position == nil then
            Dalamud.Log("[FATE] FATE position is nil, skipping fate #" .. tostring(tempFate.fateId))
        elseif not (tempFate.position.X == 0 and tempFate.position.Z == 0)
            and not tempFate.isBlacklistedFate
            and (tempFate.duration ~= 0 or tempFate.isOtherNpcFate or tempFate.isCollectionsFate)
        then
            local tempDist = GetDistanceToPoint(tempFate.position)
            if tempDist < fallbackDistance then
                fallbackDistance = tempDist
                fallbackFate = tempFate
            end
        end

        if tempFate.position ~= nil and not (tempFate.position.X == 0 and tempFate.position.Z == 0) then -- sometimes game doesnt send the correct coords
            if not tempFate.isBlacklistedFate then                          -- check fate is not blacklisted for any reason
                if tempFate.isBossFate then
                    Dalamud.Log("[FATE] Is a boss fate")
                    local tempProgress = GetFateProgressValue(tempFate, 0)
                    if (tempFate.isSpecialFate and tempProgress >= CompletionToJoinSpecialBossFates) or
                        (not tempFate.isSpecialFate and tempProgress >= CompletionToJoinBossFate) then
                        nextFate = SelectNextFateHelper(tempFate, nextFate)
                    else
                        Dalamud.Log("[FATE] Skipping fate #" ..
                            tempFate.fateId .. " " .. tempFate.fateName .. " due to boss fate with not enough progress.")
                    end
                elseif (tempFate.isOtherNpcFate or tempFate.isCollectionsFate) and tempFate.startTime == 0 then
                    Dalamud.Log("[FATE] Is an unopened npc or collections fate")
                    if nextFate == nil then -- pick this if theres nothing else
                        Dalamud.Log("[FATE] Selecting this fate because there's nothing else so far")
                        nextFate = tempFate
                    elseif tempFate.isBonusFate then
                        Dalamud.Log("[FATE] tempFate.isBonusFate")
                        nextFate = SelectNextFateHelper(tempFate, nextFate)
                    elseif nextFate.startTime == 0 then -- both fates are unopened npc fates
                        Dalamud.Log("[FATE] Both fates are unopened npc fates")
                        nextFate = SelectNextFateHelper(tempFate, nextFate)
                    else
                        Dalamud.Log("[FATE] else")
                    end
                elseif tempFate.duration ~= 0
                    or (IsFateActive(tempFate.fateObject) and not tempFate.isOtherNpcFate and not tempFate.isCollectionsFate) then -- else is normal fate. avoid unlisted talk to npc fates
                    Dalamud.Log("[FATE] Normal fate")
                    nextFate = SelectNextFateHelper(tempFate, nextFate)
                else
                    local tempProgress = GetFateProgressValue(tempFate, nil)
                    local startedButUnusual = (tempFate.startTime or 0) > 0
                    local progressingButUnusual = tempProgress ~= nil and tempProgress > 0 and tempProgress < 100
                    if startedButUnusual or progressingButUnusual then
                        Dalamud.Log("[FATE] Fate duration was zero, but fate is active. Treating as normal fate.")
                        nextFate = SelectNextFateHelper(tempFate, nextFate)
                    else
                        Dalamud.Log("[FATE] Fate duration was zero.")
                    end
                end
                Dalamud.Log("[FATE] Finished considering fate #" .. tempFate.fateId .. " " .. tempFate.fateName)
            else
                Dalamud.Log("[FATE] Skipping fate #" .. tempFate.fateId .. " " .. tempFate.fateName ..
                    " due to blacklist.")
            end
        else
            Dalamud.Log("[FATE] FATE coords were zeroed out")
        end
    end

    Dalamud.Log("[FATE] Finished considering all fates")
    if nextFate == nil then
        if fallbackFate ~= nil then
            nextFate = fallbackFate
            Dalamud.Log("[FATE] Fallback selected fate #" .. nextFate.fateId .. " " .. nextFate.fateName ..
                " (strict filters yielded none).")
            return nextFate
        end
        local playerPos = GetPlayerPosition()
        if playerPos ~= nil then
            Dalamud.Log("[FATE] No fates found. Player position: X=" ..
                playerPos.X .. ", Y=" .. playerPos.Y .. ", Z=" .. playerPos.Z)
        else
            Dalamud.Log("[FATE] No fates found. Player position is nil.")
        end
        --TeleportTo("メワヘイゾーン")
        if Echo == "all" then
            yield("/echo [FATE] No eligible fates found.")
        end
    else
        Dalamud.Log("[FATE] Final selected fate #" .. nextFate.fateId .. " " .. nextFate.fateName)
    end
    yield("/wait " .. tostring(FastCombatPacing and 0.02 or 0.211))
    return nextFate
end

function AcceptNPCFateOrRejectOtherYesno()
    if AddonReady("SelectYesno") then
        local dialogBox = GetNodeText("SelectYesno", 1, 2)
        if type(dialogBox) == "string" and dialogBox:find("The recommended level for this FATE is") then
            SafeYield("/callback SelectYesno true 0") --accept fate
        else
            SafeYield("/callback SelectYesno true 1") --decline all other boxes
        end
    end
end

--#endregion Fate Functions

--#region Movement Functions

function GetPlayerPosition()
    return GetLocalPlayerPosition()
end

function DistanceBetween(pos1, pos2)
    if pos1 == nil or pos2 == nil then
        Dalamud.Log("[FATE] Warning: DistanceBetween called with nil position")
        return 0
    end
    local dx = pos1.X - pos2.X
    local dy = pos1.Y - pos2.Y
    local dz = pos1.Z - pos2.Z
    return math.sqrt(dx * dx + dy * dy + dz * dz)
end

function GetDistanceToPoint(vec3)
    if vec3 == nil then
        Dalamud.Log("[FATE] Warning: GetDistanceToPoint called with nil vec3")
        return 0
    end
    if type(vec3) ~= "userdata" then
        Dalamud.Log("[FATE] Warning: GetDistanceToPoint called with non-Vector3: " .. type(vec3))
        return 0
    end
    local playerPos = GetLocalPlayerPosition()
    if playerPos == nil then
        return math.maxinteger
    end
    return DistanceBetween(playerPos, vec3)
end

function GetDistanceToTarget()
    if Svc.Targets.Target ~= nil then
        return GetDistanceToPoint(Svc.Targets.Target.Position)
    else
        return math.maxinteger
    end
end

function GetDistanceToTargetFlat()
    if Svc.Targets.Target ~= nil then
        return GetDistanceToPointFlat(Svc.Targets.Target.Position)
    else
        return math.maxinteger
    end
end

function GetDistanceToPointFlat(vec3)
    local playerPos = GetLocalPlayerPosition()
    if playerPos == nil then
        return math.maxinteger
    end
    return DistanceBetweenFlat(playerPos, vec3)
end

function DistanceBetweenFlat(pos1, pos2)
    if pos1 == nil or pos2 == nil then
        Dalamud.Log("[FATE] Warning: DistanceBetweenFlat called with nil position")
        return 0
    end
    local dx = pos1.X - pos2.X
    local dz = pos1.Z - pos2.Z
    return math.sqrt(dx * dx + dz * dz)
end

-- Wrap yield() so a single command failure doesn't kill the whole macro.
-- SND-level macro errors may still abort the current temporary macro, but
-- this catches Lua-level errors and lets the main loop retry next frame.
function SafeYield(command)
    if command == nil or command == "" then
        return true
    end
    local ok, err = pcall(function() yield(command) end)
    if not ok then
        Dalamud.Log("[FATE] SafeYield failed for: " .. tostring(command) .. " error: " .. tostring(err))
    end
    return ok
end

function TargetNearestAttackingEnemy()
    local playerOk, player = pcall(function() return Svc.ClientState.LocalPlayer end)
    if not playerOk or player == nil then
        return false
    end
    local playerPos = player.Position
    local bestObj = nil
    local bestDist = 9999
    local maxIndex = math.min(Svc.Objects.Length - 1, 300)
    for i = 0, maxIndex do
        local objOk, obj = pcall(function() return Svc.Objects[i] end)
        if objOk and obj then
            local kindOk, kind = pcall(function() return obj.ObjectKind end)
            local posOk, pos = pcall(function() return obj.Position end)
            local deadOk, isDead = pcall(function() return obj.IsDead end)
            local hpOk, hp = pcall(function() return obj.CurrentHp end)
            if kindOk and posOk and deadOk and hpOk and kind == 2 and not isDead and hp > 0 then
                local dist = DistanceBetweenFlat(playerPos, pos)
                if dist < bestDist then
                    bestDist = dist
                    bestObj = obj
                end
            end
        end
    end
    if bestObj ~= nil then
        local setOk = pcall(function() Svc.Targets.Target = bestObj end)
        if setOk then
            return true
        end
    end
    return false
end

function RandomAdjustCoordinates(position, maxDistance)
    local angle = math.random() * 2 * math.pi
    local x_adjust = maxDistance * math.random()
    local z_adjust = maxDistance * math.random()

    local randomX = position.X + (x_adjust * math.cos(angle))
    local randomY = position.Y + maxDistance
    local randomZ = position.Z + (z_adjust * math.sin(angle))

    return Vector3(randomX, randomY, randomZ)
end

function TryReadAetheryteBoolean(aetheryte, memberName)
    if aetheryte == nil or memberName == nil or memberName == "" then
        return nil
    end

    local okValue, value = pcall(function()
        return aetheryte[memberName]
    end)
    if okValue and type(value) == "boolean" then
        return value
    end

    if okValue and type(value) == "function" then
        local okCallDirect, callDirect = pcall(function()
            return value()
        end)
        if okCallDirect and type(callDirect) == "boolean" then
            return callDirect
        end
        local okCallSelf, callSelf = pcall(function()
            return value(aetheryte)
        end)
        if okCallSelf and type(callSelf) == "boolean" then
            return callSelf
        end
    end

    local okProp, prop = pcall(function()
        local objType = aetheryte.GetType and aetheryte:GetType() or nil
        if objType == nil then
            return nil
        end
        return objType:GetProperty(memberName)
    end)
    if okProp and prop ~= nil then
        local okPropValue, propValue = pcall(function()
            return prop:GetValue(aetheryte, nil)
        end)
        if okPropValue and type(propValue) == "boolean" then
            return propValue
        end
    end

    return nil
end

function IsAetheryteAttunedSafe(aetheryte)
    local candidateMembers = {
        "IsAetheryteUnlocked",
        "IsAttuned",
        "IsUnlocked",
        "Unlocked"
    }
    for _, memberName in ipairs(candidateMembers) do
        local value = TryReadAetheryteBoolean(aetheryte, memberName)
        if value ~= nil then
            return value == true
        end
    end
    -- Unknown object shape: keep legacy behavior.
    return true
end

function GetAetherytesInZone(zoneId)
    local aetherytesInZone = {}
    for _, aetheryte in ipairs(Svc.AetheryteList) do
        if aetheryte.TerritoryId == zoneId and IsAetheryteAttunedSafe(aetheryte) then
            table.insert(aetherytesInZone, aetheryte)
        end
    end
    return aetherytesInZone
end

function GetAetheryteName(aetheryte)
    local name = aetheryte.AetheryteData.Value.PlaceName.Value.Name:GetText()
    if name == nil then
        return ""
    else
        return name
    end
end

function GetAetheryteInZoneByName(zoneId, aetheryteName)
    local aetherytesInZone = GetAetherytesInZone(zoneId)
    for _, aetheryte in ipairs(aetherytesInZone) do
        local name = GetAetheryteName(aetheryte)
        if name == aetheryteName or string.lower(name) == string.lower(aetheryteName) then
            return {
                name = name,
                position = Instances.Telepo:GetAetherytePosition(aetheryte.AetheryteId),
                aetheryteId = aetheryte.AetheryteId
            }
        end
    end
    return nil
end

function GetZoneIdByAetheryteName(aetheryteName)
    if aetheryteName == nil or aetheryteName == "" then
        return nil
    end
    for _, zone in ipairs(FatesData) do
        local match = GetAetheryteInZoneByName(zone.zoneId, aetheryteName)
        if match ~= nil then
            return zone.zoneId
        end
    end
    return nil
end

function DistanceFromClosestAetheryteToPoint(vec3, teleportTimePenalty)
    local closestAetheryte = nil
    local closestTravelDistance = math.maxinteger
    for _, aetheryte in ipairs(SelectedZone.aetheryteList) do
        local distanceAetheryteToFate = DistanceBetween(aetheryte.position, vec3)
        local comparisonDistance = distanceAetheryteToFate + teleportTimePenalty
        Dalamud.Log("[FATE] Distance via " ..
            aetheryte.aetheryteName .. " adjusted for tp penalty is " .. tostring(comparisonDistance))

        if comparisonDistance < closestTravelDistance then
            Dalamud.Log("[FATE] Updating closest aetheryte to " .. aetheryte.aetheryteName)
            closestTravelDistance = comparisonDistance
            closestAetheryte = aetheryte
        end
    end

    return closestTravelDistance
end

function GetDistanceToPointWithAetheryteTravel(vec3)
    -- Get the direct flight distance (no aetheryte)
    local directFlightDistance = GetDistanceToPoint(vec3)
    Dalamud.Log("[FATE] Direct flight distance is: " .. directFlightDistance)

    -- Get the distance to the closest aetheryte, including teleportation penalty
    local distanceToAetheryte = DistanceFromClosestAetheryteToPoint(vec3, 200)
    Dalamud.Log("[FATE] Distance via closest Aetheryte is: " .. (distanceToAetheryte or "nil"))

    -- Return the minimum distance, either via direct flight or via the closest aetheryte travel
    if distanceToAetheryte == nil then
        return directFlightDistance
    else
        return math.min(directFlightDistance, distanceToAetheryte)
    end
end

function GetClosestAetheryte(position, teleportTimePenalty)
    local closestAetheryte = nil
    local closestTravelDistance = math.maxinteger
    for _, aetheryte in ipairs(SelectedZone.aetheryteList) do
        Dalamud.Log("[FATE] Considering aetheryte " .. aetheryte.aetheryteName)
        local distanceAetheryteToFate = DistanceBetween(aetheryte.position, position)
        local comparisonDistance = distanceAetheryteToFate + teleportTimePenalty
        Dalamud.Log("[FATE] Distance via " ..
            aetheryte.aetheryteName .. " adjusted for tp penalty is " .. tostring(comparisonDistance))

        if comparisonDistance < closestTravelDistance then
            Dalamud.Log("[FATE] Updating closest aetheryte to " .. aetheryte.aetheryteName)
            closestTravelDistance = comparisonDistance
            closestAetheryte = aetheryte
        end
    end
    if closestAetheryte ~= nil then
        Dalamud.Log("[FATE] Final selected aetheryte is: " .. closestAetheryte.aetheryteName)
    else
        Dalamud.Log("[FATE] Closest aetheryte is nil")
    end

    return closestAetheryte
end

function GetClosestAetheryteInZoneToPoint(zoneId, position)
    local aetherytes = GetAetherytesInZone(zoneId)
    local closestAetheryte = nil
    local closestDistance = math.maxinteger

    for _, aetheryte in ipairs(aetherytes) do
        local aetherytePos = Instances.Telepo:GetAetherytePosition(aetheryte.AetheryteId)
        if aetherytePos ~= nil then
            local distance = DistanceBetween(position, aetherytePos)
            if distance < closestDistance then
                closestDistance = distance
                closestAetheryte = {
                    name = GetAetheryteName(aetheryte),
                    position = aetherytePos,
                    aetheryteId = aetheryte.AetheryteId
                }
            end
        end
    end

    return closestAetheryte
end

function GetClosestAetheryteToPoint(position, teleportTimePenalty, fateId)
    local directFlightDistance = GetDistanceToPoint(position)
    if directFlightDistance == math.maxinteger then
        Dalamud.Log("[FATE] Skipping GetClosestAetheryteToPoint: player position not available")
        return nil
    end
    Dalamud.Log("[FATE] Direct flight distance is: " .. directFlightDistance)
    local closestAetheryte = GetClosestAetheryte(position, teleportTimePenalty)
    if closestAetheryte ~= nil then
        local closestAetheryteDistance = DistanceBetween(position, closestAetheryte.position) + teleportTimePenalty
        local gain = directFlightDistance - closestAetheryteDistance
        local enterGain = TeleportHysteresisEnterGain or 70
        local exitGain = TeleportHysteresisExitGain or 25
        local previousPrefer = false
        if fateId ~= nil and TeleportDecisionLastFateId == fateId and TeleportDecisionPreferAetheryte == true then
            previousPrefer = true
        end
        local preferAetheryte = previousPrefer and gain > exitGain or gain > enterGain

        if fateId ~= nil then
            if TeleportDecisionLastFateId ~= fateId or TeleportDecisionPreferAetheryte ~= preferAetheryte then
                Dalamud.Log(string.format(
                    "[FATE] Teleport hysteresis decision for fate #%s: gain=%.2f, preferAetheryte=%s",
                    tostring(fateId),
                    gain,
                    tostring(preferAetheryte)
                ))
            end
            TeleportDecisionLastFateId = fateId
            TeleportDecisionPreferAetheryte = preferAetheryte
        end

        if preferAetheryte then
            return closestAetheryte
        end
    end
    if fateId ~= nil and TeleportDecisionLastFateId == fateId then
        TeleportDecisionPreferAetheryte = false
    end
    return nil
end

function TeleportToClosestAetheryteToFate(nextFate)
    local aetheryteForClosestFate = GetClosestAetheryteToPoint(nextFate.position, 200,
        nextFate and nextFate.fateId or nil)
    if aetheryteForClosestFate ~= nil then
        local teleported = TeleportTo(aetheryteForClosestFate.aetheryteName)
        return teleported == true
    end
    return false
end

function AcceptTeleportOfferLocation(destinationAetheryte)
    local destinationText = tostring(destinationAetheryte or "")
    local function compact(value)
        local normalized = string.lower(tostring(value or ""))
        normalized = normalized:gsub('"', "")
        normalized = normalized:gsub("%s+", "")
        normalized = normalized:gsub("　", "")
        normalized = normalized:gsub("・", "")
        normalized = normalized:gsub("%-", "")
        normalized = normalized:gsub("'", "")
        normalized = normalized:gsub("’", "")
        return normalized
    end

    if AddonReady("_NotificationTelepo") then
        local location = GetNodeText("_NotificationTelepo", 3, 4)
        if type(location) == "string" then
            SafeYield("/callback _Notification true 0 16 " .. location)
        else
            Dalamud.Log("[FATE] Warning: location is not a string, got: " .. tostring(type(location)))
        end
        yield("/wait 1")
    end

    if AddonReady("SelectYesno") then
        local teleportOfferMessage = GetNodeText("SelectYesno", 1, 2)
        Dalamud.Log("[FATE] Teleport offer message: " .. tostring(teleportOfferMessage))
        if type(teleportOfferMessage) == "string" then
            -- English pattern
            local teleportOfferLocation = teleportOfferMessage:match("Accept Teleport to (.+)%?")
            -- Japanese pattern: 「レイノード・ウィンド」へのテレポ勧誘を受けますか？
            if not teleportOfferLocation then
                teleportOfferLocation = teleportOfferMessage:match("「(.+)」へのテレポ")
            end
            local shouldAccept = false
            if destinationText ~= "" then
                local destinationCompact = compact(destinationText)
                if teleportOfferLocation ~= nil then
                    shouldAccept = compact(teleportOfferLocation) == destinationCompact
                end
                if not shouldAccept then
                    local messageCompact = compact(teleportOfferMessage)
                    shouldAccept = (teleportOfferMessage:find(destinationText, 1, true) ~= nil)
                        or (destinationCompact ~= "" and messageCompact:find(destinationCompact, 1, true) ~= nil)
                end
            else
                local lowerMsg = string.lower(teleportOfferMessage)
                shouldAccept = lowerMsg:find("teleport", 1, true) ~= nil
                    or teleportOfferMessage:find("テレポ", 1, true) ~= nil
                    or teleportOfferMessage:find("勧誘", 1, true) ~= nil
            end

            Dalamud.Log("[FATE] Teleport offer shouldAccept=" ..
                tostring(shouldAccept) .. " location=" .. tostring(teleportOfferLocation))
            if shouldAccept then
                SafeYield("/callback SelectYesno true 0") -- accept teleport
                return
            end
        end
    end
end

local function NormalizeTeleportName(name)
    if name == nil then
        return ""
    end
    local normalized = string.lower(tostring(name))
    normalized = normalized:gsub("%s+", "")
    normalized = normalized:gsub("　", "")
    normalized = normalized:gsub("・", "")
    normalized = normalized:gsub("%-", "")
    normalized = normalized:gsub("'", "")
    normalized = normalized:gsub("’", "")
    return normalized
end

local function BuildTeleportNameCandidates(name)
    local candidates = {}
    local function addCandidate(candidate)
        if candidate == nil then
            return
        end
        local value = tostring(candidate)
        if value == "" then
            return
        end
        for _, existing in ipairs(candidates) do
            if existing == value then
                return
            end
        end
        table.insert(candidates, value)
    end

    local original = tostring(name or "")
    local normalizedOriginal = NormalizeTeleportName(original)
    addCandidate(original)
    addCandidate(original:gsub("・", ""))
    addCandidate(original:gsub(" ", ""))
    addCandidate(original:gsub("　", ""))
    local aliasGroups = {
        { "Limsa Lominsa Lower Decks", "リムサ・ロミンサ下甲板層", "リムサロミンサ下甲板層" },
        { "Old Sharlayan", "オールド・シャーレアン", "オールドシャーレアン" },
        { "Solution Nine", "ソリューション・ナイン", "ソリューションナイン" },
        { "Tuliyollal", "トライヨラ" },
        { "Urqopacha", "ウルコパチャ" },
        { "Kozama'uka", "Kozamauka", "コザマル・カ", "コザマルカ" },
        { "Yak T'el", "Yak Tel", "ヤクテル", "ヤク・テル" },
        { "Shaaloani", "シャーローニ荒野", "シャーローニ" },
        { "Heritage Found", "ヘリテージ・ファウンド", "ヘリテージファウンド" },
        { "Living Memory", "リビング・メモリー", "リビングメモリー" }
    }
    for _, aliasGroup in ipairs(aliasGroups) do
        local matched = false
        for _, aliasName in ipairs(aliasGroup) do
            local normalizedAlias = NormalizeTeleportName(aliasName)
            if normalizedAlias ~= "" and (
                    normalizedOriginal == normalizedAlias
                    or (#normalizedOriginal >= 6 and string.find(normalizedOriginal, normalizedAlias, 1, true) ~= nil)
                    or (#normalizedAlias >= 6 and string.find(normalizedAlias, normalizedOriginal, 1, true) ~= nil)
                )
            then
                matched = true
                break
            end
        end
        if matched then
            for _, aliasName in ipairs(aliasGroup) do
                addCandidate(aliasName)
            end
        end
    end
    return candidates
end

local function ResolveTeleportDestination(name)
    local candidates = BuildTeleportNameCandidates(name)
    local normalizedCandidates = {}
    for _, candidate in ipairs(candidates) do
        normalizedCandidates[NormalizeTeleportName(candidate)] = true
    end

    for _, aetheryte in ipairs(Svc.AetheryteList) do
        if IsAetheryteAttunedSafe(aetheryte) == true then
            local aetheryteName = GetAetheryteName(aetheryte)
            if normalizedCandidates[NormalizeTeleportName(aetheryteName)] then
                return aetheryteName, aetheryte.AetheryteId
            end
        end
    end

    for _, aetheryte in ipairs(Svc.AetheryteList) do
        if IsAetheryteAttunedSafe(aetheryte) == true then
            local aetheryteName = GetAetheryteName(aetheryte)
            local normalizedAetheryteName = NormalizeTeleportName(aetheryteName)
            for normalizedCandidate, _ in pairs(normalizedCandidates) do
                if normalizedAetheryteName ~= "" and normalizedCandidate ~= "" and (
                        string.find(normalizedAetheryteName, normalizedCandidate, 1, true)
                        or string.find(normalizedCandidate, normalizedAetheryteName, 1, true)
                    )
                then
                    return aetheryteName, aetheryte.AetheryteId
                end
            end
        end
    end

    return tostring(name or ""), nil
end

local function WaitForTeleportStart(timeoutSeconds, destinationName)
    local startWait = os.clock()
    local timeout = tonumber(timeoutSeconds) or 2
    while os.clock() - startWait < timeout do
        AcceptTeleportOfferLocation(destinationName)
        if Svc.Condition[CharacterCondition.casting] or Svc.Condition[CharacterCondition.betweenAreas] then
            return true
        end
        yield("/wait 0.1")
    end
    return false
end

local function WaitForLifestreamBusyClear(timeoutSeconds)
    local timeout = tonumber(timeoutSeconds) or 8
    local startWait = os.clock()
    while os.clock() - startWait < timeout do
        if not IsLifestreamBusySafe() then
            return true
        end
        if Svc.Condition[CharacterCondition.casting] or Svc.Condition[CharacterCondition.betweenAreas] then
            return true
        end
        yield("/wait 0.1")
    end
    return false
end

function WaitUntilTeleportUsable(timeoutSeconds)
    local startWait = os.clock()
    local timeout = tonumber(timeoutSeconds) or 6
    while os.clock() - startWait < timeout do
        local blocked = Svc.Condition[CharacterCondition.dead]
            or Svc.Condition[CharacterCondition.inCombat]
            or Svc.Condition[CharacterCondition.casting]
            or Svc.Condition[CharacterCondition.betweenAreas]
            or Svc.Condition[CharacterCondition.betweenAreasForDuty]
            or Svc.Condition[CharacterCondition.boundByDuty34]
            or Svc.Condition[CharacterCondition.boundByDuty56]
            or Svc.Condition[CharacterCondition.occupied]
            or Svc.Condition[CharacterCondition.occupiedInEvent]
            or Svc.Condition[CharacterCondition.occupiedInQuestEvent]
            or Svc.Condition[CharacterCondition.beingMoved]
        if not blocked then
            return true
        end
        yield("/wait 0.2")
    end
    return false
end

local function TryLocalAetheryteShortcut(destinationName)
    if destinationName == nil or destinationName == "" then
        return false
    end
    if IPC ~= nil and IPC.Lifestream ~= nil and type(IPC.Lifestream.AethernetTeleport) == "function" then
        for _, candidateName in ipairs(BuildTeleportNameCandidates(destinationName)) do
            local ok, result = pcall(function()
                return IPC.Lifestream.AethernetTeleport(candidateName)
            end)
            if ok and result == true then
                return WaitForTeleportStart(3.5, candidateName)
            end
        end
    end
    return false
end

local function TryLifestreamTeleportByPlaceName(destinationName)
    if destinationName == nil or destinationName == "" then
        return false
    end
    local escapedName = tostring(destinationName):gsub('"', "")
    escapedName = escapedName:gsub("^%s+", "")
    escapedName = escapedName:gsub("%s+$", "")
    escapedName = escapedName:gsub("^　+", "")
    escapedName = escapedName:gsub("　+$", "")
    if escapedName == "" then
        return false
    end

    local liCommand = "/li tp " .. escapedName
    local attempts = 2
    local startTimeout = FastCombatPacing and 5.0 or 6.5
    for _ = 1, attempts do
        yield(liCommand)
        if WaitForTeleportStart(startTimeout, escapedName) then
            return true
        end
        if IsLifestreamBusySafe() then
            WaitForLifestreamBusyClear(8)
            if Svc.Condition[CharacterCondition.casting] or Svc.Condition[CharacterCondition.betweenAreas] then
                return true
            end
        end
        yield("/wait 0.25")
    end

    return false
end

function TryNativeTeleportById(destinationId, destinationName)
    if destinationId == nil then
        return false
    end
    if Actions == nil or type(Actions.Teleport) ~= "function" then
        return false
    end
    local ok = pcall(function()
        Actions.Teleport(destinationId)
    end)
    if not ok then
        return false
    end
    local startTimeout = FastCombatPacing and 4.5 or 6.0
    return WaitForTeleportStart(startTimeout, destinationName)
end

local function GetTeleportFailureEntry(destinationName)
    if TeleportFailureByDestination == nil then
        TeleportFailureByDestination = {}
    end
    local key = NormalizeTeleportName(destinationName)
    if key == "" then
        key = "__unknown__"
    end
    if TeleportFailureByDestination[key] == nil then
        TeleportFailureByDestination[key] = {
            count = 0,
            lastFailedAt = 0,
            blockedUntil = 0
        }
    end
    return TeleportFailureByDestination[key]
end

local function IsTeleportDestinationBlocked(destinationName)
    local entry = GetTeleportFailureEntry(destinationName)
    return entry.blockedUntil ~= nil and entry.blockedUntil > os.clock(), entry
end

local function MarkTeleportSuccess(destinationName)
    local entry = GetTeleportFailureEntry(destinationName)
    entry.count = 0
    entry.lastFailedAt = 0
    entry.blockedUntil = 0
end

local function MarkTeleportFailure(destinationName)
    local now = os.clock()
    local entry = GetTeleportFailureEntry(destinationName)
    if now - (entry.lastFailedAt or 0) > 120 then
        entry.count = 0
    end
    entry.count = (entry.count or 0) + 1
    entry.lastFailedAt = now
    if entry.count >= 3 then
        entry.blockedUntil = now + 45
    end
    return entry
end

function TeleportTo(aetheryteName)
    AcceptTeleportOfferLocation(aetheryteName)
    if IPC ~= nil and IPC.vnavmesh ~= nil and (IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning()) then
        SafeYield("/vnav stop")
        yield("/wait 0.2")
    end
    WaitUntilTeleportUsable(6)
    local blocked, blockEntry = IsTeleportDestinationBlocked(aetheryteName)
    if blocked then
        local now = os.clock()
        if (TeleportFailureWarnedAt or 0) + 6 < now then
            local waitSeconds = math.max(1, math.floor((blockEntry.blockedUntil or now) - now))
            local msg = string.format(
                "[FATE] Teleport temporarily paused for %s (%ds) after repeated failures.",
                tostring(aetheryteName),
                waitSeconds
            )
            Dalamud.Log(msg)
            yield("/echo " .. msg)
            TeleportFailureWarnedAt = now
        end
        yield("/wait 2")
        return false
    end
    local start = os.clock()

    while EorzeaTimeToUnixTime(Instances.Framework.EorzeaTime) - LastTeleportTimeStamp < 5 do
        Dalamud.Log("[FATE] Too soon since last teleport. Waiting...")
        yield("/wait 5.001")
        if os.clock() - start > 30 then
            yield("/echo [FATE] Teleport failed: Timeout waiting before cast.")
            return false
        end
    end

    local resolvedName, resolvedId = ResolveTeleportDestination(aetheryteName)
    local teleportStarted = false
    local attemptedById = false
    local attemptedByActionId = false
    local attemptedByLiName = false

    if resolvedId ~= nil and IPC ~= nil and IPC.Lifestream ~= nil and type(IPC.Lifestream.Teleport) == "function" then
        attemptedById = true
        local ok = pcall(function()
            IPC.Lifestream.Teleport(resolvedId, 0)
        end)
        if ok then
            local startTimeout = FastCombatPacing and 4.5 or 6.0
            teleportStarted = WaitForTeleportStart(startTimeout, (resolvedName ~= "" and resolvedName) or aetheryteName)
        end
    end

    if not teleportStarted and resolvedId ~= nil then
        attemptedByActionId = true
        teleportStarted = TryNativeTeleportById(resolvedId, (resolvedName ~= "" and resolvedName) or aetheryteName)
    end

    if not teleportStarted then
        for _, candidateName in ipairs(BuildTeleportNameCandidates((resolvedName ~= "" and resolvedName) or aetheryteName)) do
            attemptedByLiName = true
            if TryLifestreamTeleportByPlaceName(candidateName) then
                teleportStarted = true
                break
            end
        end
    end

    if not teleportStarted then
        local failureEntry = MarkTeleportFailure(aetheryteName)
        local msg = "[FATE] Teleport failed: destination not found or cast did not start (" ..
            tostring(aetheryteName) .. ")"
        msg = msg .. " | paths id/action/li = " ..
            tostring(attemptedById) .. "/" .. tostring(attemptedByActionId) .. "/" .. tostring(attemptedByLiName)
        if failureEntry ~= nil and failureEntry.count ~= nil and failureEntry.count >= 3 then
            local blockedFor = math.max(1, math.floor((failureEntry.blockedUntil or os.clock()) - os.clock()))
            msg = msg .. " | too many failures, blocking for " .. tostring(blockedFor) .. "s"
        end
        Dalamud.Log(msg)
        yield("/echo " .. msg)
        yield("/wait 3")
        return false
    end

    while Svc.Condition[CharacterCondition.casting] do
        Dalamud.Log("[FATE] Casting teleport...")
        yield("/wait 1")
        if os.clock() - start > 60 then
            yield("/echo [FATE] Teleport failed: Timeout during cast.")
            return false
        end
    end
    yield("/wait 1")
    while Svc.Condition[CharacterCondition.betweenAreas] do
        Dalamud.Log("[FATE] Teleporting...")
        yield("/wait 1")
        if os.clock() - start > 120 then
            yield("/echo [FATE] Teleport failed: Timeout during zone transition.")
            return false
        end
    end
    yield("/wait 1")
    LastTeleportTimeStamp = EorzeaTimeToUnixTime(Instances.Framework.EorzeaTime)
    MarkTeleportSuccess(aetheryteName)
    HasFlownUpYet = false
    return true
end

local function TeleportToSelectedZoneAetheryte()
    if SelectedZone == nil or SelectedZone.aetheryteList == nil then
        return false, {}
    end

    local attemptedNames = {}
    local attemptedLookup = {}
    for _, aetheryte in ipairs(SelectedZone.aetheryteList) do
        local aetheryteName = aetheryte and aetheryte.aetheryteName or nil
        if type(aetheryteName) == "string" and aetheryteName ~= "" and attemptedLookup[aetheryteName] ~= true then
            attemptedLookup[aetheryteName] = true
            table.insert(attemptedNames, aetheryteName)
            if TeleportTo(aetheryteName) == true then
                return true, attemptedNames
            end
        end
    end

    return false, attemptedNames
end

function ChangeInstance()
    if SuccessiveInstanceChanges >= NumberOfInstances then
        if CompanionScriptMode then
            local shouldWaitForBonusBuff = WaitIfBonusBuff and HasTwistOfFateBuff()
            if WaitingForFateRewards == nil and not shouldWaitForBonusBuff then
                SetStopReason("Companion mode: no rewards/buff while instance cycling")
                StopScript = true
            else
                Dalamud.Log("[Fate Farming] Waiting for buff or fate rewards")
                yield("/wait 3")
            end
        else
            yield("/wait 10")
            SuccessiveInstanceChanges = 0
        end
        return
    end
    SafeYield("/target " .. LANG.actions["aetheryte"])                                    -- search for nearby aetheryte
    yield("/wait 1")                                                                  -- search for nearby aetheryte
    if Svc.Targets.Target == nil or GetTargetName() ~= LANG.actions["aetheryte"] then -- if no aetheryte within targeting range, teleport to it
        Dalamud.Log("[FATE] Aetheryte not within targetable range")
        local closestAetheryte = nil
        local closestAetheryteDistance = math.maxinteger
        for i, aetheryte in ipairs(SelectedZone.aetheryteList) do
            -- GetDistanceToPoint is implemented with raw distance instead of distance squared
            local distanceToAetheryte = GetDistanceToPoint(aetheryte.position)
            if distanceToAetheryte < closestAetheryteDistance then
                closestAetheryte = aetheryte
                closestAetheryteDistance = distanceToAetheryte
            end
        end
        if closestAetheryte ~= nil then
            TeleportTo(closestAetheryte.aetheryteName)
        end
        return
    end

    if WaitingForFateRewards ~= nil then
        yield("/wait 10")
        return
    end

    if GetDistanceToTarget() > 10 then
        Dalamud.Log("[FATE] Targeting aetheryte, but greater than 10 distance")
        if not (IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning()) then
            if Player.CanFly and SelectedZone.flying then
                SafeYield("/vnav flytarget")
            else
                SafeYield("/vnav movetarget")
            end
        elseif GetDistanceToTarget() > 20 and not Svc.Condition[CharacterCondition.mounted] then
            State = CharacterState.mounting
            Dalamud.Log("[FATE] State Change: Mounting")
        end
        return
    end

    Dalamud.Log("[FATE] Within 10 distance")
    if IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning() then
        SafeYield("/vnav stop")
        return
    end

    if Svc.Condition[CharacterCondition.mounted] then
        State = CharacterState.changeInstanceDismount
        Dalamud.Log("[FATE] State Change: ChangeInstanceDismount")
        return
    end

    Dalamud.Log("[FATE] Transferring to next instance")
    local nextInstance = math.ceil((GetZoneInstance() % NumberOfInstances) + 1)
    yield("/li " .. nextInstance) -- start instance transfer
    yield("/wait 1")              -- wait for instance transfer to register
    State = CharacterState.ready
    SuccessiveInstanceChanges = SuccessiveInstanceChanges + 1
    Dalamud.Log("[FATE] State Change: Ready")
end

function FindNearbyActiveFate(centerPos, radius, excludeFateId)
    if centerPos == nil then
        return nil
    end
    local activeFates = Fates.GetActiveFates()
    if activeFates == nil then
        return nil
    end
    local bestFate = nil
    local bestDist = radius
    for i = 0, activeFates.Count - 1 do
        local fateObj = activeFates[i]
        if fateObj ~= nil
            and IsFateActive(fateObj)
            and (excludeFateId == nil or fateObj.Id ~= excludeFateId)
        then
            local fatePos = fateObj.Position
            if fatePos ~= nil then
                local dist = DistanceBetween(centerPos, fatePos)
                if dist <= bestDist then
                    local builtFate = BuildFateTable(fateObj)
                    if builtFate ~= nil then
                        bestFate = builtFate
                        bestDist = dist
                    end
                end
            end
        end
    end
    return bestFate
end

function WaitForContinuation()
    if CurrentFate == nil or CurrentFate.fateObject == nil then
        Dalamud.Log("[FATE] WaitForContinuation: CurrentFate missing, returning to Ready.")
        State = CharacterState.ready
        return
    end

    -- Distance-based early detection: InActiveFate() depends on the game's
    -- Fate.InFate flag, which can lag by a frame when a new FATE spawns on
    -- top of the player. Without this fallback, a FATE that pops up at the
    -- player's location after Part 1 ends (or after a non-continuation FATE
    -- with hasContinuation=true) would only be detected up to 30s later,
    -- when WaitForContinuation aborts and falls back to Ready.
    local playerPos = GetLocalPlayerPosition()
    local nearbyNewFate = FindNearbyActiveFate(playerPos, 30, CurrentFate.fateId)
    if nearbyNewFate ~= nil then
        CurrentFate = nearbyNewFate
        State = CharacterState.doFate
        Dalamud.Log("[FATE] State Change: DoFate (early continuation, fateId=" .. tostring(CurrentFate.fateId) .. ")")
        return
    end

    if InActiveFate() then
        Dalamud.Log("WaitForContinuation IsInFate")
        local nextFate = Fates.GetNearestFate()
        if nextFate ~= nil then
            local isNewFate = nextFate.Id ~= CurrentFate.fateId
                or not IsFateActive(CurrentFate.fateObject)
            if isNewFate and IsFateActive(nextFate) then
                local builtFate = BuildFateTable(nextFate)
                if builtFate ~= nil then
                    CurrentFate = builtFate
                    State = CharacterState.doFate
                    Dalamud.Log("[FATE] State Change: DoFate (continuation, fateId=" .. tostring(builtFate.fateId) .. ")")
                end
            end
        else
            yield("/wait 1")
        end
    elseif os.clock() - LastFateEndTime > 30 then
        Dalamud.Log("WaitForContinuation Abort")
        Dalamud.Log("Over 30s since end of last fate. Giving up on part 2.")
        TurnOffCombatMods()
        State = CharacterState.ready
        Dalamud.Log("State Change: Ready")
    else
        Dalamud.Log("WaitForContinuation Else")
        local desired = MainClass and MainClass.Name or nil
        if CurrentFate.continuationIsBoss and BossFatesClass ~= nil then
            desired = BossFatesClass.className
        elseif LevelSyncTankGearset ~= nil and LevelSyncTankGearset ~= "" and NeedsLevelSyncForFate(CurrentFate) then
            desired = LevelSyncTankGearset
        elseif NormalFateGearset ~= nil and NormalFateGearset ~= "" then
            desired = NormalFateGearset
        end
        if not Player.IsPlayerOccupied and desired ~= nil and CurrentlyEquippedGearset ~= desired then
            Dalamud.Log("WaitForContinuation switch to " .. desired)
            local ok = SafeYield("/gs change " .. desired)
            yield("/wait 1.5")
            if ok then
                CurrentlyEquippedGearset = desired
            end
        end

        yield("/wait 1")
    end
end

function FlyBackToAetheryte()
    NextFate = SelectNextFate()
    if NextFate ~= nil then
        SafeYield("/vnav stop")
        State = CharacterState.ready
        Dalamud.Log("[FATE] State Change: Ready")
        return
    end

    local playerPos = GetLocalPlayerPosition()
    if playerPos == nil then
        return
    end
    local closestAetheryte = GetClosestAetheryte(playerPos, 0)
    if closestAetheryte == nil then
        DownTimeWaitAtNearestAetheryte = false
        yield("/echo Could not find aetheryte in the area. Turning off feature to fly back to aetheryte.")
        return
    end
    -- if you get any sort of error while flying back, then just abort and tp back
    if AddonReady("_TextError") and GetNodeText("_TextError", 1) == "Your mount can fly no higher." then
        SafeYield("/vnav stop")
        TeleportTo(closestAetheryte.aetheryteName)
        return
    end

    SafeYield("/target " .. LANG.actions["aetheryte"])

    if Svc.Targets.Target ~= nil and GetTargetName() == "aetheryte" and GetDistanceToTarget() <= 20 then
        if IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning() then
            SafeYield("/vnav stop")
        end

        if Svc.Condition[CharacterCondition.flying] then
            SafeYield("/ac " .. LANG.actions["dismount"]) -- land but dont actually dismount, to avoid running chocobo timer
        elseif Svc.Condition[CharacterCondition.mounted] then
            State = CharacterState.ready
            Dalamud.Log("[FATE] State Change: Ready")
        else
            if MountToUse == "mount roulette" then
                yield('/action "' .. LANG.actions["mount roulette"] .. '"')
            else
                SafeYield('/mount "' .. MountToUse .. '"')
            end
        end
        return
    end

    if not (IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning()) then
        Dalamud.Log("[FATE] ClosestAetheryte.y: " .. closestAetheryte.position.Y)
        if closestAetheryte ~= nil then
            SetMapFlag(SelectedZone.zoneId, closestAetheryte.position)
            IPC.vnavmesh.PathfindAndMoveTo(closestAetheryte.position,
                Player.CanFly and SelectedZone.flying)
        end
    end

    if not Svc.Condition[CharacterCondition.mounted] then
        Mount()
        return
    end
end

HasFlownUpYet = false
function MoveToRandomNearbySpot(minDist, maxDist)
    local playerPos = GetLocalPlayerPosition()
    if playerPos == nil then
        return
    end
    local angle = math.random() * 2 * math.pi
    local distance = minDist + math.random() * (maxDist - minDist)
    local dx = math.cos(angle) * distance
    local dz = math.sin(angle) * distance
    local yOffset = 0
    if not HasFlownUpYet then
        -- Always fly upward significantly the first time
        yOffset = 25 + math.random() * 15 -- +25 to +40
        HasFlownUpYet = true
    else
        yOffset = (math.random() * 30) - 15 -- -15 to +15
    end
    local targetPos = Vector3(playerPos.X + dx, playerPos.Y + yOffset, playerPos.Z + dz)
    if not Svc.Condition[CharacterCondition.mounted] then
        Mount()
        local randomMoveMountWait = FastCombatPacing and 0.35 or 2
        yield("/wait " .. tostring(randomMoveMountWait))
    end
    IPC.vnavmesh.PathfindAndMoveTo(targetPos, true)
    yield("/echo [FATE] Moving to a random location while waiting...")
end

function Mount()
    local now = os.clock()
    local mountRetryCooldown = MountRetryCooldownSeconds or 1.2
    local mountToggleCooldown = MountToggleCooldownSeconds or 2.2

    if Svc.Condition[CharacterCondition.mounted]
        or Svc.Condition[CharacterCondition.mounting57]
        or Svc.Condition[CharacterCondition.mounting64]
    then
        return
    end
    if Svc.Condition[CharacterCondition.inCombat]
        or Svc.Condition[CharacterCondition.casting]
        or Svc.Condition[CharacterCondition.occupied]
        or Svc.Condition[CharacterCondition.occupiedInEvent]
        or Svc.Condition[CharacterCondition.occupiedInQuestEvent]
        or Svc.Condition[CharacterCondition.betweenAreas]
        or Svc.Condition[CharacterCondition.betweenAreasForDuty]
    then
        return
    end
    if LastMountCommandAt ~= nil and now - LastMountCommandAt < mountRetryCooldown then
        return
    end
    if LastDismountCommandAt ~= nil and now - LastDismountCommandAt < mountToggleCooldown then
        return
    end

    LastMountCommandAt = now
    if MountToUse == "mount roulette" then
        SafeYield('/action "' .. LANG.actions["mount roulette"] .. '"')
    else
        SafeYield('/mount "' .. MountToUse .. '"')
    end
    local mountCommandSettleWait = FastCombatPacing and 0.2 or 0.5
    yield("/wait " .. tostring(mountCommandSettleWait))
end

function MountState()
    if Svc.Condition[CharacterCondition.mounted] then
        -- Start flying immediately after mounting
        if CurrentFate ~= nil then
            local targetPos = GetPreferredFateMovePosition(CurrentFate) or CurrentFate.position
            local playerCanFly = Player.CanFly == true
            local zoneAllowsFlying = SelectedZone ~= nil and SelectedZone.flying ~= false
            local useFlying = playerCanFly and zoneAllowsFlying
            Dalamud.Log(string.format("[FATE] Mount decision: playerCanFly=%s zoneAllowsFlying=%s useFlying=%s",
                tostring(playerCanFly), tostring(zoneAllowsFlying), tostring(useFlying)))
            if useFlying then
                IPC.vnavmesh.PathfindAndMoveTo(targetPos, true)
                Dalamud.Log("[FATE] Mounted - starting flight to destination")
            else
                IPC.vnavmesh.PathfindAndMoveTo(targetPos, false)
                Dalamud.Log("[FATE] Mounted - starting ground movement to destination")
            end
        end
        State = CharacterState.moveToFate
        Dalamud.Log("[FATE] State Change: MoveToFate")
    else
        -- Attempt to mount (Mount() handles retry cooldown internally)
        Mount()
    end
end

function InitialSetup()
    -- 1. Switch to normal FATE gearset first.
    if SwitchToNormalGearsetOnStart and NormalFateGearset ~= nil and NormalFateGearset ~= ""
        and CurrentlyEquippedGearset ~= NormalFateGearset then
        if Player.IsBusy then
            Dalamud.Log("[FATE] Initial setup: waiting for player to be idle")
            return
        end
        Dalamud.Log("[FATE] Initial setup: switching to normal gearset")
        local ok = SafeYield("/gs change " .. NormalFateGearset)
        yield("/wait 1.5")
        if ok then
            CurrentlyEquippedGearset = NormalFateGearset
            Dalamud.Log("[FATE] Initial setup: switched to normal gearset")
        else
            Dalamud.Log("[FATE] Initial setup: gearset switch failed, continuing")
        end
        return
    end

    -- 2. Teleport to configured starting zone.
    if InitialSetupTeleportZone ~= nil and InitialSetupTeleportZone ~= "" and not InitialSetupTeleportDone then
        if InitialSetupTeleportStartAt == nil then
            InitialSetupTeleportStartAt = os.clock()
            InitialSetupLastTerritoryType = Svc.ClientState.TerritoryType
            Dalamud.Log("[FATE] Initial setup: teleporting to " .. InitialSetupTeleportZone)
            TeleportTo(InitialSetupTeleportZone)
            return
        end

        -- Wait for the teleport cast/travel to finish.
        if Svc.Condition[CharacterCondition.betweenAreas] then
            return
        end

        -- Some clients update TerritoryType very slowly after a teleport. Use a
        -- short grace period and then assume arrival rather than looping forever.
        local elapsed = os.clock() - InitialSetupTeleportStartAt
        if elapsed < 3 then
            return
        end

        Dalamud.Log("[FATE] Initial setup: teleport grace period elapsed, assuming arrival")
        InitialSetupTeleportStartAt = nil
        InitialSetupLastTerritoryType = nil
        InitialSetupTeleportDone = true

        -- Align SelectedZone with the initial setup zone so zone-dependent
        -- checks (like chocobo summon) pass after teleporting.
        local setupZoneId = GetZoneIdByAetheryteName(InitialSetupTeleportZone)
        if setupZoneId ~= nil and (SelectedZone == nil or SelectedZone.zoneId ~= setupZoneId) then
            SelectedZone = BuildZoneData(setupZoneId)
            Dalamud.Log("[FATE] Initial setup: aligned selected zone to " .. InitialSetupTeleportZone)
        end
    end

    -- 3. Summon chocobo.
    Dalamud.Log("[FATE] Initial setup: SummonChocoboOnStart=" .. tostring(SummonChocoboOnStart) ..
        " SummonChocobo=" .. tostring(SummonChocobo))
    if SummonChocoboOnStart and SummonChocobo then
        Dalamud.Log("[FATE] Initial setup: attempting chocobo summon")
        ChocoboCheck()
    end

    -- 4. Done.
    Dalamud.Log("[FATE] Initial setup complete")
    State = CharacterState.ready
end

function Dismount(force)
    local now = os.clock()
    local dismountRetryCooldown = DismountRetryCooldownSeconds or 0.8
    local mountToggleCooldown = MountToggleCooldownSeconds or 2.2
    local bypassToggleCooldown = force == true

    if Svc.Condition[CharacterCondition.mounting57] or Svc.Condition[CharacterCondition.mounting64] then
        return
    end
    if LastDismountCommandAt ~= nil and now - LastDismountCommandAt < dismountRetryCooldown then
        return
    end
    if not bypassToggleCooldown and LastMountCommandAt ~= nil and now - LastMountCommandAt < mountToggleCooldown then
        return
    end

    if Svc.Condition[CharacterCondition.flying] then
        LastDismountCommandAt = now
        SafeYield("/ac " .. LANG.actions["dismount"])

        local checkNow = os.clock()
        if checkNow - LastStuckCheckTime > 1 then
            if Svc.Condition[CharacterCondition.flying] and GetDistanceToPoint(LastStuckCheckPosition) < 2 then
                Dalamud.Log("[FATE] Unable to dismount here. Moving to another spot.")
                local playerPos = GetLocalPlayerPosition()
                if playerPos == nil then
                    return
                end
                local random = RandomAdjustCoordinates(playerPos, 10)
                local nearestFloor = IPC.vnavmesh.PointOnFloor(random, true, 100)
                if nearestFloor ~= nil then
                    IPC.vnavmesh.PathfindAndMoveTo(nearestFloor,
                        Player.CanFly and SelectedZone.flying)
                    yield("/wait 1")
                end
            end

            LastStuckCheckTime = checkNow
            local playerPos = GetLocalPlayerPosition()
            if playerPos ~= nil then
                LastStuckCheckPosition = playerPos
            end
        end
    elseif Svc.Condition[CharacterCondition.mounted] then
        LastDismountCommandAt = now
        SafeYield("/ac " .. LANG.actions["dismount"])
    end
end

function MiddleOfFateDismount()
    if CurrentFate == nil or CurrentFate.fateObject == nil then
        ResetMiddleDismountState()
        State = CharacterState.ready
        Dalamud.Log("[FATE] State Change: Ready")
        return
    end

    if not IsFateActive(CurrentFate.fateObject) then
        ResetMiddleDismountState()
        State = CharacterState.ready
        Dalamud.Log("[FATE] State Change: Ready")
        return
    end

    if Svc.Condition[CharacterCondition.mounted] then
        if IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning() then
            SafeYield("/vnav stop")
        end
        Dismount(true)
        return
    end

    ResetMiddleDismountState()

    -- Wait for dismount to finish before applying stance/summon checks.
    local dismountWaitStart = os.clock()
    while Svc.Condition[CharacterCondition.mounted]
        and os.clock() - dismountWaitStart < 3 do
        yield("/wait 0.2")
    end

    -- Apply tank stance once before combat actually starts.
    TankStanceCheck()
    -- Try to summon chocobo while we are dismounted and before combat starts.
    if SummonChocobo and not ChocoboSummonDisabled then
        ChocoboCheck()
    end
    State = CharacterState.doFate
    Dalamud.Log("[FATE] State Change: DoFate")
end

function NpcDismount()
    if Svc.Condition[CharacterCondition.mounted] then
        Dismount(true)
    else
        State = CharacterState.interactWithNpc
        Dalamud.Log("[FATE] State Change: InteractWithFateNpc")
    end
end

function ChangeInstanceDismount()
    if Svc.Condition[CharacterCondition.mounted] then
        Dismount(true)
    else
        State = CharacterState.changingInstances
        Dalamud.Log("[FATE] State Change: ChangingInstance")
    end
end

--Paths to the Fate NPC Starter
function MoveToNPC()
    if CurrentFate.npcName == nil or CurrentFate.npcName == "" then
        Dalamud.Log("[FATE] MoveToNPC: npcName is nil or empty, skipping")
        return
    end
    SafeYield("/target " .. CurrentFate.npcName)
    if Svc.Targets.Target ~= nil and GetTargetName() == CurrentFate.npcName then
        if GetDistanceToTarget() > 5 then
            SafeYield("/vnav movetarget")
        end
    end
end

--Paths to the Fate. CurrentFate is set here to allow MovetoFate to change its mind,
--so CurrentFate is possibly nil.
function MoveToFate()
    SuccessiveInstanceChanges = 0

    local lp = (ClientState ~= nil and ClientState.LocalPlayer) or
        (Svc ~= nil and Svc.ClientState ~= nil and Svc.ClientState.LocalPlayer) or
        (Player ~= nil and Player.Available == true and Player)
    if lp == nil or type(lp) ~= "table" then
        return
    end

    -- Reset gearset tracking when the target fate changes so we don't skip
    -- switching to the normal/boss/tank gearset.
    local currentFateId = CurrentFate ~= nil and CurrentFate.fateId or nil
    if currentFateId ~= LastMoveToFateId then
        LastMoveToFateId = currentFateId
        CurrentlyEquippedGearset = nil
        Dalamud.Log("[FATE] Target fate changed, resetting gearset tracking")
    end

    if CurrentFate ~= nil and not IsFateActive(CurrentFate.fateObject) then
        Dalamud.Log("[FATE] Next Fate is dead, selecting new Fate.")
        SafeYield("/vnav stop")
        MovingAnnouncementLock = false
        State = CharacterState.ready
        Dalamud.Log("[FATE] State Change: Ready")
        return
    elseif CurrentFate ~= nil and CurrentFate.fateId == 0 then
        Dalamud.Log("[FATE] CurrentFate is set to 0, selecting new Fate.")
        CurrentFate = nil
    end

    NextFate = GetBestAvailableNextFate(true)
    if NextFate == nil then -- when moving to next fate, CurrentFate == NextFate
        SafeYield("/vnav stop")
        MovingAnnouncementLock = false
        State = CharacterState.ready
        Dalamud.Log("[FATE] State Change: Ready")
        return
    elseif CurrentFate == nil or NextFate.fateId ~= CurrentFate.fateId then
        local shouldSwitchFate = true
        if CurrentFate ~= nil and IsFateActive(CurrentFate.fateObject) then
            local currentProgress = GetFateProgressValue(CurrentFate, 0) or 0
            local nextProgress = GetFateProgressValue(NextFate, 0) or 0
            local currentStarted = (CurrentFate.startTime or 0) > 0
            local currentInProgress = currentProgress > 0 and currentProgress < 100
            local currentDist = GetDistanceToPoint(CurrentFate.position)
            local lockCurrentFate = InActiveFate()
                or Svc.Condition[CharacterCondition.inCombat]
                or currentStarted
                or currentInProgress
                or (currentDist < 60)
            if lockCurrentFate then
                shouldSwitchFate = false
                NextFate = CurrentFate
                Dalamud.Log(string.format(
                    "[FATE] Keeping current target fate #%s; active/in-progress or proximity switch blocked.",
                    tostring(CurrentFate.fateId or 0)
                ))
            else
                local currentDist = GetDistanceToPoint(CurrentFate.position)
                local nextDist = GetDistanceToPoint(NextFate.position)
                local currentBonus = CurrentFate.isBonusFate == true
                local nextBonus = NextFate.isBonusFate == true
                local progressGain = nextProgress - currentProgress
                local distanceGain = currentDist - nextDist
                local switchForBonus = nextBonus and not currentBonus
                local switchForProgress = progressGain >= 20
                local switchForDistance = distanceGain >= 65
                shouldSwitchFate = switchForBonus or switchForProgress or switchForDistance
                if not shouldSwitchFate then
                    Dalamud.Log(string.format(
                        "[FATE] Keeping current target fate #%s; candidate #%s not better enough (progress %+0.1f, distance %+0.1f).",
                        tostring(CurrentFate.fateId or 0),
                        tostring(NextFate.fateId or 0),
                        progressGain,
                        distanceGain
                    ))
                    NextFate = CurrentFate
                end
            end
        end
        if shouldSwitchFate then
            SafeYield("/vnav stop")
            CurrentFate = NextFate
            ResetNoCombatRecoveryState()
            ResetMeleeEngageRecoveryState()
            ResetPreAcquireState()
            ResetDynamicAoeSwitchState()
            ResetMiddleDismountState()
            if PrefetchedNextFateId ~= nil and CurrentFate ~= nil and PrefetchedNextFateId == CurrentFate.fateId then
                PrefetchedNextFateId = nil
                PrefetchedNextFateAt = 0
            end
            local mappedPosition = GetPreferredFateMovePosition(CurrentFate) or CurrentFate.position
            SetMapFlag(SelectedZone.zoneId, mappedPosition)
            return
        end
    end

    -- Gearset handling (level-sync tank, normal gearset, boss class, main class)
    if EnsureCorrectGearsetForFate(CurrentFate) then
        return
    end

    local preferredMovePos = GetPreferredFateMovePosition(CurrentFate) or CurrentFate.position
    local distanceToPreferredMovePos = GetDistanceToPoint(preferredMovePos)
    local levelSyncPending = IsLevelSyncPendingForCurrentFate()

    if IsSolutionNineZone() and not Svc.Condition[CharacterCondition.mounted] then
        local closestWaypoint = GetSolutionNineWaypoint(preferredMovePos)
        if closestWaypoint ~= nil then
            local distToWaypoint = DistanceBetweenFlat(GetLocalPlayerPosition(), closestWaypoint.position)
            local distWaypointToFate = DistanceBetweenFlat(closestWaypoint.position, preferredMovePos)
            if distToWaypoint > 10 and distWaypointToFate > 10 then
                if not (IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning()) then
                    Dalamud.Log("[FATE] Solution Nine: Using waypoint " .. closestWaypoint.name)
                    IPC.vnavmesh.PathfindAndMoveTo(closestWaypoint.position, false)
                end
                return
            end
        end
    end

    if not (CurrentFate.isOtherNpcFate or CurrentFate.isCollectionsFate)
        and not levelSyncPending
        and distanceToPreferredMovePos <= (PreAcquireDistance or 130)
        and distanceToPreferredMovePos > 60
    then
        if PreAcquireFateId ~= CurrentFate.fateId then
            PreAcquireFateId = CurrentFate.fateId
            PreAcquireLastAttemptAt = 0
        end
        local now = os.clock()
        local attemptInterval = PreAcquireAttemptIntervalSeconds or 1.2
        if now - (PreAcquireLastAttemptAt or 0) >= attemptInterval then
            PreAcquireLastAttemptAt = now
            local fateRadius = GetFateRadiusValue(CurrentFate, nil) or 0
            local preAcquireRadius = math.max(
                (DynamicAoeCheckRadius or 30) + 30,
                (ClusterMoveRadius or 40) + 20,
                fateRadius + 40
            )
            local gotPreTarget = AttemptToTargetClosestFateEnemy(true, preAcquireRadius, true)
            if gotPreTarget then
                Dalamud.Log("[FATE] Pre-acquired target before arrival.")
            end
        end
    end

    -- upon approaching fate, pick a target and switch to pathing towards target
    if distanceToPreferredMovePos < 60 then
        -- Do not dismount until we are close to the FLAG position.
        local distanceToFlag = GetDistanceToPoint(CurrentFate.position)
        if distanceToFlag > 15 then
            if Svc.Condition[CharacterCondition.mounted]
                and not (IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning()) then
                IPC.vnavmesh.PathfindAndMoveTo(CurrentFate.position, Player.CanFly and SelectedZone.flying)
            end
            return
        end

        if levelSyncPending then
            if Svc.Targets.Target ~= nil then
                ClearTarget()
            end
            local center = GetPreferredFateMovePosition(CurrentFate) or CurrentFate.position
            if center ~= nil
                and not (IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning())
                and not IsCurrentFateInSyncRange()
            then
                IPC.vnavmesh.PathfindAndMoveTo(center, Player.CanFly and SelectedZone.flying)
            end
            State = CharacterState.MiddleOfFateDismount
            return
        end

        if Svc.Targets.Target ~= nil then
            if not IsCurrentTargetInsideCurrentFateBounds(GetCurrentFateMoveBoundaryBuffer()) then
                ClearTarget()
                local center = GetPreferredFateMovePosition(CurrentFate) or CurrentFate.position
                if center ~= nil and not (IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning()) then
                    IPC.vnavmesh.PathfindAndMoveTo(center, Player.CanFly and SelectedZone.flying)
                end
                return
            end
            Dalamud.Log("[FATE] Found FATE target, immediate rerouting")
            yield("/wait 0.1")
            MoveToTargetHitbox()
            if (CurrentFate.isOtherNpcFate or CurrentFate.isCollectionsFate) then
                State = CharacterState.interactWithNpc
                Dalamud.Log("[FATE] State Change: Interact with npc")
                -- if GetTargetName() == CurrentFate.npcName then
                --     State = CharacterState.interactWithNpc
                -- elseif GetTargetFateID() == CurrentFate.fateId then
                --     State = CharacterState.middleOfFateDismount
                --     Dalamud.Log("[FATE] State Change: MiddleOfFateDismount")
            else
                State = CharacterState.MiddleOfFateDismount
                Dalamud.Log("[FATE] State Change: MiddleOfFateDismount")
            end
            return
        else
            if (CurrentFate.isOtherNpcFate or CurrentFate.isCollectionsFate) and not InActiveFate() then
                SafeYield("/target " .. CurrentFate.npcName)
            else
                local gotTarget = AttemptToTargetClosestFateEnemy(true, nil, true)
                if not gotTarget
                    and IsFateActive(CurrentFate.fateObject)
                    and distanceToFlag <= 15
                then
                    -- InActiveFate() can briefly return false right after a FATE
                    -- spawns on top of the player (Fate.InFate lags by a frame),
                    -- so use FATE-active + close-to-flag as a more reliable
                    -- dismount signal and avoid dropping the attack window.
                    State = CharacterState.MiddleOfFateDismount
                    Dalamud.Log("[FATE] State Change: MiddleOfFateDismount (no target, in fate area)")
                    return
                end
                if Svc.Targets.Target == nil and OptimizeClusterMovement == true then
                    local center = GetPreferredFateMovePosition(CurrentFate)
                    if center ~= nil and GetDistanceToPointFlat(center) > 15 then
                        IPC.vnavmesh.PathfindAndMoveTo(center,
                            Player.CanFly and SelectedZone.flying)
                    end
                end
            end
            yield("/wait " .. tostring(FastCombatPacing and 0.15 or 0.5)) -- give it a moment to make sure the target sticks
            return
        end
    end

    -- check for stuck (staged recovery)
    if (IPC.vnavmesh.IsRunning() or IPC.vnavmesh.PathfindInProgress()) and Svc.Condition[CharacterCondition.mounted] then
        if HandleMovementStuck(preferredMovePos) then
            return
        end
        return
    end
    ResetMovementStuckState()

    if not MovingAnnouncementLock then
        Dalamud.Log("[FATE] Moving to fate #" .. CurrentFate.fateId .. " " .. CurrentFate.fateName)
        MovingAnnouncementLock = true
        if Echo == "all" then
            yield("/echo [FATE] Moving to fate #" .. CurrentFate.fateId .. " " .. CurrentFate.fateName)
        end
    end

    if TeleportToClosestAetheryteToFate(CurrentFate) then
        Dalamud.Log("Executed teleport to closer aetheryte")
        return
    end

    local nearestFloor = preferredMovePos
    if nearestFloor == nil then
        nearestFloor = CurrentFate.position
    elseif not (CurrentFate.isCollectionsFate or CurrentFate.isOtherNpcFate) and OptimizeClusterMovement ~= true then
        nearestFloor = RandomAdjustCoordinates(nearestFloor, 3)
        nearestFloor = ClampPositionToCurrentFateBounds(nearestFloor, 0)
    end

    -- Always mount toward the FLAG position (CurrentFate.position).
    -- After dismounting at the flag, we'll walk to the optimal spot (nearestFloor).
    local distanceToFlag = GetDistanceToPoint(CurrentFate.position)
    if distanceToFlag > 3 then
        local mountDistanceThreshold = MountTravelMinDistance or 24
        local shouldMountForTravel = distanceToFlag >= mountDistanceThreshold
        if not Svc.Condition[CharacterCondition.mounted] then
            if shouldMountForTravel then
                State = CharacterState.mounting
                Dalamud.Log("[FATE] State Change: Mounting")
                return
            elseif not IPC.vnavmesh.PathfindInProgress() and not IPC.vnavmesh.IsRunning() then
                -- Move toward the FLAG position specifically
                IPC.vnavmesh.PathfindAndMoveTo(CurrentFate.position, Player.CanFly and SelectedZone.flying)
            end
        else
            -- Mounted: always fly/move toward destination
            local useFlying = Player.CanFly and SelectedZone.flying
            if useFlying then
                IPC.vnavmesh.PathfindAndMoveTo(CurrentFate.position, true)
            else
                IPC.vnavmesh.PathfindAndMoveTo(CurrentFate.position, false)
            end
        end
    else
        -- Close to flag: stop nav and transition to dismount
        if IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning() then
            SafeYield("/vnav stop")
        end
        State = CharacterState.MiddleOfFateDismount
    end
end

function InteractWithFateNpc()
    if InActiveFate() or CurrentFate.startTime > 0 then
        SafeYield("/vnav stop")
        State = CharacterState.doFate
        Dalamud.Log("[FATE] State Change: DoFate")
        yield("/wait 1") -- give the fate a second to register before dofate and lsync
    elseif not IsFateActive(CurrentFate.fateObject) then
        State = CharacterState.ready
        Dalamud.Log("[FATE] State Change: Ready")
    elseif IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning() then
        if Svc.Targets.Target ~= nil and GetTargetName() == CurrentFate.npcName and GetDistanceToTarget() < (5 * math.random()) then
            SafeYield("/vnav stop")
        end
        return
    else
        -- if target is already selected earlier during pathing, avoids having to target and move again
        if (Svc.Targets.Target == nil or GetTargetName() ~= CurrentFate.npcName) then
            SafeYield("/target " .. CurrentFate.npcName)
            return
        end

        if Svc.Condition[CharacterCondition.mounted] then
            State = CharacterState.npcDismount
            Dalamud.Log("[FATE] State Change: NPCDismount")
            return
        end

        if GetDistanceToPoint(Svc.Targets.Target.Position) > 5 then
            MoveToNPC()
            return
        end

        if AddonReady("SelectYesno") then
            AcceptNPCFateOrRejectOtherYesno()
        elseif not Svc.Condition[CharacterCondition.occupied] then
            yield("/interact")
        end
    end
end

function CollectionsFateTurnIn()
    AcceptNPCFateOrRejectOtherYesno()

    if CurrentFate ~= nil and not IsFateActive(CurrentFate.fateObject) then
        CurrentFate = nil
        State = CharacterState.ready
        Dalamud.Log("[FATE] State Change: Ready")
        return
    end

    if (Svc.Targets.Target == nil or GetTargetName() ~= CurrentFate.npcName) then
        TurnOffCombatMods()
        SafeYield("/target " .. CurrentFate.npcName)
        yield("/wait 1")

        -- if too far from npc to target, then head towards center of fate
        local progress = GetFateProgressValue(CurrentFate, nil)
        if (Svc.Targets.Target == nil or GetTargetName() ~= CurrentFate.npcName and progress ~= nil and progress < 100) then
            if not IPC.vnavmesh.PathfindInProgress() and not IPC.vnavmesh.IsRunning() then
                IPC.vnavmesh.PathfindAndMoveTo(CurrentFate.position, false)
            end
        else
            SafeYield("/vnav stop")
        end
        return
    end

    if GetDistanceToTarget() > 5 then
        if not (IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning()) then
            MoveToNPC()
        end
    else
        if Inventory.GetItemCount(CurrentFate.fateObject.EventItem) >= 7 then
            GotCollectionsFullCredit = true
        end

        SafeYield("/vnav stop")
        yield("/interact")
        yield("/wait 3")

        local progress = GetFateProgressValue(CurrentFate, nil)
        if progress ~= nil and progress < 100 then
            TurnOnCombatMods()
            State = CharacterState.doFate
            Dalamud.Log("[FATE] State Change: DoFate")
        else
            if GotCollectionsFullCredit then
                GotCollectionsFullCredit = false
                State = CharacterState.unexpectedCombat
                Dalamud.Log("[FATE] State Change: UnexpectedCombat")
            end
        end

        if CurrentFate ~= nil and CurrentFate.npcName ~= nil and GetTargetName() == CurrentFate.npcName then
            Dalamud.Log("[FATE] Attempting to clear target.")
            ClearTarget()
            yield("/wait 1")
        end
    end
    GotCollectionsFullCredit = false
end

--#endregion movement

--#region Combat Functions

function GetClassJobTableFromName(classString)
    if classString == nil or classString == "" then
        return nil
    end

    for classJobId = 1, 42 do
        local job = Player.GetJob(classJobId)
        if job.Name == classString then
            return job
        end
    end

    Dalamud.Log("[FATE] Cannot recognize combat job for boss fates.")
    return nil
end

function ClearTarget()
    Svc.Targets.Target = nil
end

function GetTargetHitboxRadius()
    if Svc.Targets.Target ~= nil then
        return Svc.Targets.Target.HitboxRadius
    else
        return 0
    end
end

function GetPlayerHitboxRadius()
    local lp = (Svc and Svc.ClientState and Svc.ClientState.LocalPlayer) or (ClientState and ClientState.LocalPlayer)
    if lp ~= nil and type(lp) == "table" and lp.HitboxRadius ~= nil then
        return lp.HitboxRadius
    else
        return 0.5
    end
end

function TryUseActionOnTarget(actionName)
    if actionName == nil or actionName == "" then
        return false
    end
    if Svc.Targets.Target == nil or Svc.Targets.Target.IsDead then
        return false
    end

    local actionText = tostring(actionName)
    local cmd = '/ac "' .. actionText .. '"'
    yield(cmd)
    return true
end

function GetCombatOpenActionCandidates()
    if Player.Job == nil then
        return {}
    end

    local jobId = Player.Job.Id
    if jobId == ClassList.pld.classId then
        return {
            LANG.actions["Shield Lob"] or "Shield Lob",
            LANG.actions["Fast Blade"] or "Fast Blade"
        }
    elseif jobId == ClassList.war.classId then
        return {
            LANG.actions["Tomahawk"] or "Tomahawk",
            LANG.actions["Heavy Swing"] or "Heavy Swing"
        }
    elseif jobId == ClassList.drk.classId then
        return {
            LANG.actions["Unleash"] or "Unleash",
            LANG.actions["Hard Slash"] or "Hard Slash"
        }
    elseif jobId == ClassList.gnb.classId then
        return {
            LANG.actions["Lightning Shot"] or "Lightning Shot",
            LANG.actions["Keen Edge"] or "Keen Edge"
        }
    elseif jobId == ClassList.blu.classId then
        return {
            LANG.actions["Flying Sardine"] or "Flying Sardine"
        }
    elseif jobId == ClassList.brd.classId or jobId == ClassList.arc.classId then
        return {
            LANG.actions["Heavy Shot"] or "Heavy Shot"
        }
    elseif jobId == ClassList.mch.classId then
        return {
            LANG.actions["Split Shot"] or "Split Shot"
        }
    elseif jobId == ClassList.dnc.classId then
        return {
            LANG.actions["Cascade"] or "Cascade"
        }
    elseif jobId == ClassList.drg.classId or jobId == ClassList.lnc.classId then
        return {
            LANG.actions["Piercing Talon"] or "Piercing Talon",
            LANG.actions["Winged Glide"] or "Winged Glide",
            LANG.actions["True Thrust"] or "True Thrust"
        }
    elseif jobId == ClassList.nin.classId or jobId == ClassList.rog.classId then
        return {
            LANG.actions["Throwing Dagger"] or "Throwing Dagger",
            LANG.actions["Spinning Edge"] or "Spinning Edge"
        }
    elseif jobId == ClassList.sam.classId then
        return {
            LANG.actions["Enpi"] or "Enpi",
            LANG.actions["Hissatsu: Gyoten"] or "Hissatsu: Gyoten",
            LANG.actions["Hakaze"] or "Hakaze"
        }
    elseif jobId == ClassList.rpr.classId then
        return {
            LANG.actions["Harpe"] or "Harpe",
            LANG.actions["Slice"] or "Slice"
        }
    elseif jobId == ClassList.smn.classId or jobId == ClassList.acn.classId then
        return {
            LANG.actions["Ruin"] or "Ruin"
        }
    elseif jobId == ClassList.blm.classId or jobId == ClassList.thm.classId then
        return {
            LANG.actions["Blizzard"] or "Blizzard"
        }
    elseif jobId == ClassList.rdm.classId then
        return {
            LANG.actions["Jolt"] or "Jolt"
        }
    elseif jobId == ClassList.vpr.classId then
        return {
            LANG.actions["Steel Fangs"] or "Steel Fangs"
        }
    elseif jobId == ClassList.pct.classId then
        return {
            LANG.actions["Fire in Red"] or "Fire in Red"
        }
    elseif Player.Job.IsHealer then
        local healerId = Player.Job.Id
        if healerId == ClassList.whm.classId or healerId == ClassList.cnj.classId then
            return {
                LANG.actions["Glare"] or "Glare",
                LANG.actions["Stone"] or "Stone"
            }
        elseif healerId == ClassList.sch.classId then
            return {
                LANG.actions["Ruin"] or "Ruin"
            }
        elseif healerId == ClassList.ast.classId then
            return {
                LANG.actions["Malefic"] or "Malefic"
            }
        elseif healerId == ClassList.sge.classId then
            return {
                LANG.actions["Dosis"] or "Dosis"
            }
        end
        return {
            "Ruin", "Malefic", "Diagnosis", "Eurekan Ruin" -- general fallbacks
        }
    end

    return {}
end

function GetSamuraiKenki()
    local gauge = Player.Job and Player.Job.Gauge
    if gauge == nil then
        return 0
    end
    local ok, kenki = pcall(function() return gauge.Kenki end)
    if ok and type(kenki) == "number" then
        return kenki
    end
    return 0
end

function TryActivePullNearbyEnemies(now)
    if ActivePullEnabled == false then
        return false
    end
    if CurrentFate == nil or CurrentFate.isCollectionsFate or CurrentFate.isOtherNpcFate then
        return false
    end
    if Svc.Condition[CharacterCondition.casting]
        or Svc.Condition[CharacterCondition.mounted]
        or Svc.Condition[CharacterCondition.flying]
        or Svc.Condition[CharacterCondition.occupied]
    then
        return false
    end

    -- Skip active pull if FATE is nearly finished (95%+).
    -- The current target(s) alone are likely enough; pulling more is wasteful.
    local fateProgress = GetFateProgressValue(CurrentFate, nil)
    if fateProgress ~= nil and fateProgress >= 95 then
        Dalamud.Log("[FATE] Active pull skipped: FATE progress at " ..
            string.format("%.1f", fateProgress) .. "%, no need to pull more enemies.")
        return false
    end

    local pullInterval = ActivePullIntervalSeconds or 2.0
    if now - (ActivePullLastAttemptAt or 0) < pullInterval then
        return false
    end
    ActivePullLastAttemptAt = now

    -- SAM: build Kenki before pulling so Enpi/Hissatsu: Gyoten are available.
    if Player.Job and Player.Job.Id == ClassList.sam.classId then
        local kenki = GetSamuraiKenki()
        if kenki < 25 then
            Dalamud.Log("[FATE] SAM low Kenki (" .. tostring(kenki) .. "); using Meditation before active pull.")
            local meditationName = LANG.actions["Meditation"] or "Meditation"
            for i = 1, 3 do
                SafeYield('/ac "' .. meditationName .. '"')
            end
            yield("/wait 1.5")
        end
    end

    local pullRange = ActivePullMaxRange or 25
    local maxTargets = ActivePullMaxTargets or 3
    local fateIdFilter = CurrentFate.fateId
    local candidates = CollectFateEnemyCandidates(fateIdFilter, true, pullRange)

    if #candidates == 0 then
        candidates = CollectFateEnemyCandidates(fateIdFilter, true, pullRange, true)
    end
    if #candidates == 0 then
        candidates = CollectFateEnemyCandidates(fateIdFilter, false, pullRange, true)
    end
    if #candidates == 0 then
        return false
    end

    local validCandidates = {}
    for _, candidate in ipairs(candidates) do
        if IsPositionInsideCurrentFateBounds(candidate.obj.Position, GetCurrentFateMoveBoundaryBuffer()) then
            table.insert(validCandidates, candidate)
        end
    end

    if #validCandidates == 0 then
        return false
    end

    local actionCandidates = GetCombatOpenActionCandidates()
    local pullAction = nil
    if #actionCandidates > 0 then
        pullAction = actionCandidates[1]
    end

    if pullAction == nil then
        return false
    end

    -- Sort candidates by distance from the *current target* rather than the player.
    -- This pulls enemies toward the main target, making AoE/clustering much more
    -- effective for melee jobs.
    local currentTarget = Svc.Targets.Target
    local currentTargetPos = currentTarget ~= nil and currentTarget.Position or nil
    table.sort(validCandidates, function(a, b)
        if currentTargetPos == nil then
            return a.dist < b.dist
        end
        local distA = DistanceBetweenFlat(currentTargetPos, a.obj.Position)
        local distB = DistanceBetweenFlat(currentTargetPos, b.obj.Position)
        return distA < distB
    end)

    local pullCount = math.min(maxTargets, #validCandidates)
    local pulledAny = false

    for i = 1, pullCount do
        local targetObj = validCandidates[i].obj
        if targetObj ~= nil and not targetObj.IsDead and targetObj.IsTargetable then
            Svc.Targets.Target = targetObj
            yield("/wait 0.2")
            -- Cycle through available pull actions so ranged gap-closers are
            -- used first, then fall back to melee basic attacks for nearby targets.
            local actionToUse = actionCandidates[((i - 1) % #actionCandidates) + 1]
            local used = TryUseActionOnTarget(actionToUse)
            if used then
                Dalamud.Log("[FATE] Active pull " ..
                    i ..
                    "/" .. pullCount .. " on " .. tostring(targetObj.Name:GetText()) .. " with " .. tostring(actionToUse))
                pulledAny = true
                yield("/wait 0.3")
            end
        end
    end

    -- Restore the original target so BMR/RSR don't chase a pulled mob away from
    -- the pack. The pulled enemies have aggro and will follow the player.
    if currentTarget ~= nil and not currentTarget.IsDead then
        Svc.Targets.Target = currentTarget
    end

    return pulledAny
end

function TryForceCombatOpenOnTarget(now, targetDistanceFlat)
    if CurrentFate == nil or Svc.Condition[CharacterCondition.inCombat] then
        return false
    end
    if Svc.Condition[CharacterCondition.casting]
        or Svc.Condition[CharacterCondition.mounted]
        or Svc.Condition[CharacterCondition.flying]
    then
        return false
    end
    if Svc.Targets.Target == nil or Svc.Targets.Target.IsDead then
        return false
    end
    if not IsCurrentTargetInsideCurrentFateBounds(GetCurrentFateMoveBoundaryBuffer()) then
        return false
    end

    local openRange = CombatOpenActionMaxRange or 20.5
    if targetDistanceFlat == nil or targetDistanceFlat > openRange then
        return false
    end
    if now - (CombatOpenLastActionAt or 0) < (CombatOpenActionRetrySeconds or 0.65) then
        return false
    end

    local candidates = GetCombatOpenActionCandidates()
    if #candidates == 0 then
        return false
    end

    local sequence = (CombatOpenActionSequence or 0) + 1
    CombatOpenActionSequence = sequence
    local index = ((sequence - 1) % #candidates) + 1
    local selectedAction = candidates[index]
    if selectedAction == nil or selectedAction == "" then
        return false
    end

    local used = TryUseActionOnTarget(selectedAction)
    if used then
        CombatOpenLastActionAt = now
        Dalamud.Log("[FATE] Combat opener attempted: " .. tostring(selectedAction))
    end
    return used
end

function TryGapCloserOnTarget(distance)
    if Svc.Condition[CharacterCondition.mounted] or Svc.Condition[CharacterCondition.casting] then
        return false
    end
    if distance == nil or distance < 8 or distance > 20 then
        return false
    end

    local job = Player.Job
    local gapCloser = nil
    if job.Id == ClassList.pld.classId then
        gapCloser = LANG.actions["Intervene"] or "Intervene"
    elseif job.Id == ClassList.war.classId then
        gapCloser = LANG.actions["Onslaught"] or "Onslaught"
    elseif job.Id == ClassList.drk.classId then
        gapCloser = LANG.actions["Shadowstride"] or "Shadowstride"
    elseif job.Id == ClassList.gnb.classId then
        gapCloser = LANG.actions["Trajectory"] or "Trajectory"
    elseif job.Id == ClassList.drg.classId then
        gapCloser = LANG.actions["Winged Glide"] or "Winged Glide"
    elseif job.Id == ClassList.mnk.classId then
        gapCloser = LANG.actions["Thunderclap"] or "Thunderclap"
    elseif job.Id == ClassList.sam.classId then
        gapCloser = LANG.actions["Hissatsu: Gyoten"] or "Hissatsu: Gyoten"
    elseif job.Id == ClassList.rpr.classId then
        gapCloser = LANG.actions["Hell's Ingress"] or "Hell's Ingress"
    end

    if gapCloser then
        SafeYield("/ac \"" .. gapCloser .. "\"")
        -- Fallback for pre-90 characters or old skill names
        if job.Id == ClassList.drk.classId then
            SafeYield("/ac \"" .. (LANG.actions["Plunge"] or "Plunge") .. "\"")
        elseif job.Id == ClassList.gnb.classId then
            SafeYield("/ac \"" .. (LANG.actions["Rough Divide"] or "Rough Divide") .. "\"")
        end
        return true
    end
    return false
end

function NormalizePresetName(name)
    local value = tostring(name or "")
    value = value:gsub("^%s+", "")
    value = value:gsub("%s+$", "")
    return value
end

function SelectPresetName(primary, fallback1, fallback2)
    local candidates = { primary, fallback1, fallback2 }
    for _, candidate in ipairs(candidates) do
        local normalized = NormalizePresetName(candidate)
        if normalized ~= "" then
            return normalized
        end
    end
    return ""
end

function ActivateBossModPreset(primary, fallback1, fallback2, reason)
    local selectedPreset = SelectPresetName(primary, fallback1, fallback2)
    if selectedPreset == "" then
        if BossModPresetMissingWarned ~= true then
            BossModPresetMissingWarned = true
            Dalamud.Log(
                "[FATE] Warning: No valid BMR/VBM preset configured (AoE/Single/Hold are empty). Preset switch skipped.")
            yield("/echo [FATE] Warning: BMR/VBM preset is empty. Set AoE/Single/Hold presets in config.")
        end
        return false
    end
    local ok = pcall(function()
        IPC.BossMod.SetActive(selectedPreset)
    end)
    if not ok then
        Dalamud.Log("[FATE] Failed to apply BMR/VBM preset for " .. tostring(reason) .. ": " .. selectedPreset)
        return false
    end
    -- Preset switching can occasionally turn BMR/VBM AI off. Re-enable it
    -- explicitly so AoE dodging stays active.
    if DodgingPlugin == "BMR" then
        SafeYield("/bmrai on")
    elseif DodgingPlugin == "VBM" then
        SafeYield("/vbm ai on")
    end
    return true
end

function TurnOnAoes()
    if not AoesOn then
        if RotationPlugin == "RSR" then
            SafeYield("/rotation off")
            SafeYield("/rotation on")
            Dalamud.Log("[FATE] TurnOnAoes /rotation auto on")

            if RSRAoeType == "Off" then
                SafeYield("/rotation settings aoetype 0")
            elseif RSRAoeType == "Cleave" then
                SafeYield("/rotation settings aoetype 1")
            elseif RSRAoeType == "Full" then
                SafeYield("/rotation settings aoetype 2")
            end
        elseif RotationPlugin == "BMR" then
            ActivateBossModPreset(RotationAoePreset, RotationSingleTargetPreset, RotationHoldBuffPreset, "aoe")
        elseif RotationPlugin == "VBM" then
            ActivateBossModPreset(RotationAoePreset, RotationSingleTargetPreset, RotationHoldBuffPreset, "aoe")
        end
        AoesOn = true
        RsrDynamicSingleApplied = false
    end
end

function TurnOffAoes()
    if AoesOn then
        if RotationPlugin == "RSR" then
            -- Keep RSR auto casting active while forcing single-target behavior.
            SafeYield("/rotation settings aoetype 1")
            SafeYield("/rotation on")
            Dalamud.Log("[FATE] TurnOffAoes /rotation on")
        elseif RotationPlugin == "BMR" then
            ActivateBossModPreset(RotationSingleTargetPreset, RotationAoePreset, RotationHoldBuffPreset, "single")
        elseif RotationPlugin == "VBM" then
            ActivateBossModPreset(RotationSingleTargetPreset, RotationAoePreset, RotationHoldBuffPreset, "single")
        end
        AoesOn = false
        RsrDynamicSingleApplied = false
    end
end

function TurnOffRaidBuffs()
    if RotationPlugin == "BMR" then
        ActivateBossModPreset(RotationHoldBuffPreset, RotationSingleTargetPreset, RotationAoePreset, "hold-buffs")
    elseif RotationPlugin == "VBM" then
        ActivateBossModPreset(RotationHoldBuffPreset, RotationSingleTargetPreset, RotationAoePreset, "hold-buffs")
    end
end

function SetMaxDistance()
    -- Determine role from ClassList instead of relying solely on
    -- Player.Job.IsMeleeDPS / IsTank, which may not be reliable in all
    -- SND/ClientState environments. Using the wrong distance causes BMR/VBM
    -- to stay at ranged range even on melee jobs.
    local jobId = Player.Job and Player.Job.Id
    local classData = nil
    if jobId ~= nil then
        for _, data in pairs(ClassList) do
            if data.classId == jobId then
                classData = data
                break
            end
        end
    end

    if classData ~= nil and (classData.isMelee or classData.isTank) then
        MaxDistance = MeleeDist
        MoveToMob = true
        Dalamud.Log("[FATE] Setting max distance to " .. tostring(MeleeDist) ..
            " (melee/tank, jobId=" .. tostring(jobId) .. ")")
    else
        MoveToMob = false
        MaxDistance = RangedDist
        Dalamud.Log("[FATE] Setting max distance to " .. tostring(RangedDist) ..
            " (ranged/caster, jobId=" .. tostring(jobId) .. ")")
    end
end

function GetLeashSafeRetargetRadius()
    local currentMax = MaxDistance or 25
    local roleMin = 42
    if Player.Job and (Player.Job.IsMeleeDPS or Player.Job.IsTank) then
        roleMin = 28
    end
    local buffer = LeashSafeRetargetBuffer or 18
    return math.max(roleMin, currentMax + buffer)
end

function ResetWrathKeepAliveState()
    WrathKeepAliveLastPulseAt = 0
    WrathKeepAliveNoCastSince = 0
    WrathKeepAliveLastTargetSignature = nil
    WrathKeepAliveFateId = nil
end

function MarkWrathAutoPulse(nowValue)
    local pulseAt = nowValue or os.clock()
    WrathKeepAliveLastPulseAt = pulseAt
    WrathKeepAliveNoCastSince = pulseAt
end

function MaybeRearmWrathAuto()
    if RotationPlugin ~= "Wrath" or WrathKeepAliveEnabled ~= true then
        return
    end

    if CurrentFate == nil or not Svc.Condition[CharacterCondition.inCombat] then
        WrathKeepAliveNoCastSince = 0
        WrathKeepAliveLastTargetSignature = nil
        return
    end

    if Svc.Condition[CharacterCondition.mounted]
        or Svc.Condition[CharacterCondition.flying]
        or Svc.Condition[CharacterCondition.betweenAreas]
        or Svc.Condition[CharacterCondition.betweenAreasForDuty]
        or IsLifestreamBusySafe()
    then
        return
    end

    local now = os.clock()
    if WrathKeepAliveFateId ~= CurrentFate.fateId then
        WrathKeepAliveFateId = CurrentFate.fateId
        WrathKeepAliveLastTargetSignature = nil
        MarkWrathAutoPulse(now)
    end

    local target = Svc.Targets.Target
    if target == nil or target.IsDead then
        WrathKeepAliveNoCastSince = 0
        WrathKeepAliveLastTargetSignature = nil
        return
    end

    local targetPos = target.Position
    local targetSignature = tostring(target.DataId or 0) .. ":" ..
        tostring(math.floor(targetPos.X)) .. ":" ..
        tostring(math.floor(targetPos.Z))
    if WrathKeepAliveLastTargetSignature ~= targetSignature then
        WrathKeepAliveLastTargetSignature = targetSignature
        WrathKeepAliveNoCastSince = now
    end

    if Svc.Condition[CharacterCondition.casting] then
        WrathKeepAliveNoCastSince = now
        return
    end

    if (WrathKeepAliveNoCastSince or 0) <= 0 then
        WrathKeepAliveNoCastSince = now
    end

    local pulseInterval = WrathKeepAliveIntervalSeconds or 2.5
    local stallSeconds = WrathStallRecoverySeconds or (pulseInterval + 1.5)
    local sincePulse = now - (WrathKeepAliveLastPulseAt or 0)
    local sinceNoCast = now - (WrathKeepAliveNoCastSince or now)
    local shouldPulse = sincePulse >= pulseInterval
    local stalled = sinceNoCast >= stallSeconds
    if not shouldPulse and not stalled then
        return
    end

    -- /wrath auto is toggle-only in this environment, so avoid pulsing commands here.
    MarkWrathAutoPulse(now)
    if stalled then
        Dalamud.Log(string.format("[FATE] Wrath keepalive observed stall: no cast for %.1fs.", sinceNoCast))
    end
end

function TurnOnCombatMods(rotationMode)
    if not CombatModsOn then
        CombatModsOn = true
        -- turn on RSR in case you have the RSR 30 second out of combat timer set
        if RotationPlugin == "RSR" then
            if rotationMode == "manual" then
                SafeYield("/rotation manual")
                Dalamud.Log("[FATE] TurnOnCombatMods /rotation manual")
            else
                SafeYield("/rotation off")
                SafeYield("/rotation on")
                Dalamud.Log("[FATE] TurnOnCombatMods /rotation auto on")
            end
        elseif RotationPlugin == "BMR" then
            ActivateBossModPreset(RotationAoePreset, RotationSingleTargetPreset, RotationHoldBuffPreset, "combat-on")
        elseif RotationPlugin == "VBM" then
            ActivateBossModPreset(RotationAoePreset, RotationSingleTargetPreset, RotationHoldBuffPreset, "combat-on")
        elseif RotationPlugin == "Wrath" then
            if WrathAutoEnabled ~= true then
                SafeYield("/wrath auto")
                WrathAutoEnabled = true
            end
            MarkWrathAutoPulse(os.clock())
        end

        if not AiDodgingOn then
            SetMaxDistance()

            if DodgingPlugin == "BMR" then
                SafeYield("/bmrai on")
                SafeYield("/bmrai maxdistancetarget " .. MaxDistance)
                if MoveToMob == true then
                    -- Melee/tank: let BMR stick to target so it can sidestep/front-aoe dodge and re-engage faster.
                    SafeYield("/bmrai followtarget on")
                    SafeYield("/bmrai followcombat on")
                    SafeYield("/bmrai followoutofcombat on")
                else
                    SafeYield("/bmrai followtarget off")
                    SafeYield("/bmrai followcombat off")
                    SafeYield("/bmrai followoutofcombat off")
                end
            elseif DodgingPlugin == "VBM" then
                SafeYield("/vbm ai on")
                --[[vbm ai doesn't support these options
                SafeYield("/vbmai followtarget on") -- overrides navmesh path and runs into walls sometimes
                SafeYield("/vbmai followcombat on")
                SafeYield("/vbmai maxdistancetarget " .. MaxDistance)
                if MoveToMob == true then
                    SafeYield("/vbmai followoutofcombat on")
                end
                if RotationPlugin ~= "VBM" then
                    SafeYield("/vbmai ForbidActions on") --This Disables VBM AI Auto-Target
                end]]
            end
            AiDodgingOn = true
        end
    end
end

function TurnOffCombatMods()
    if CombatModsOn then
        Dalamud.Log("[FATE] Turning off combat mods")
        CombatModsOn = false

        if RotationPlugin == "RSR" then
            SafeYield("/rotation off")
            Dalamud.Log("[FATE] TurnOffCombatMods /rotation off")
        elseif RotationPlugin == "BMR" then
            IPC.BossMod.ClearActive()
        elseif RotationPlugin == "VBM" then
            IPC.BossMod.ClearActive()
        elseif RotationPlugin == "Wrath" then
            -- /wrath auto is toggle-only; do not toggle here to avoid accidental OFF.
            ResetWrathKeepAliveState()
        end

        -- turn off BMR so you dont start following other mobs
        if AiDodgingOn then
            if DodgingPlugin == "BMR" then
                SafeYield("/bmrai off")
                SafeYield("/bmrai followtarget off")
                SafeYield("/bmrai followcombat off")
                SafeYield("/bmrai followoutofcombat off")
            elseif DodgingPlugin == "VBM" then
                SafeYield("/vbm ai off")
                --[[vbm ai doesn't support these options.
                SafeYield("/vbmai followtarget off")
                SafeYield("/vbmai followcombat off")
                SafeYield("/vbmai followoutofcombat off")
                if RotationPlugin ~= "VBM" then
                    SafeYield("/vbmai ForbidActions off") --This Enables VBM AI Auto-Target
                end]]
            end
            AiDodgingOn = false
        end
    end
end

function GetDesiredGearsetForFate(fate)
    if fate == nil then
        return MainClass and MainClass.Name or nil
    end
    local needsLevelSync = NeedsLevelSyncForFate(fate)
    if needsLevelSync and LevelSyncTankGearset ~= nil and LevelSyncTankGearset ~= "" then
        return LevelSyncTankGearset
    end
    if fate.isBossFate and BossFatesClass ~= nil then
        return BossFatesClass.className
    end
    if NormalFateGearset ~= nil and NormalFateGearset ~= "" then
        return NormalFateGearset
    end
    return MainClass and MainClass.Name or nil
end

function EnsureCorrectGearsetForFate(fate)
    local desired = GetDesiredGearsetForFate(fate)
    if desired == nil or desired == "" then
        desired = MainClass and MainClass.Name or nil
    end
    if desired == nil or CurrentlyEquippedGearset == desired then
        GearsetSwitchRetryCount = 0
        return false
    end
    if Player.IsBusy then
        GearsetSwitchRetryCount = (GearsetSwitchRetryCount or 0) + 1
        if GearsetSwitchRetryCount == 10 then
            Dalamud.Log("[FATE] Gearset switch delayed 10 times, player still busy")
        end
        return false
    end
    local ok = SafeYield("/gs change " .. desired)
    yield("/wait 1.5")
    if ok then
        CurrentlyEquippedGearset = desired
        GearsetSwitchRetryCount = 0
        Dalamud.Log("[FATE] Switched to gearset: " .. desired)
        -- If we just switched to the tank gearset, dismount so we can apply
        -- tank stance and summon chocobo before re-mounting.
        if desired == LevelSyncTankGearset and Svc.Condition[CharacterCondition.mounted] then
            Dismount(true)
            yield("/wait 1.0")
            TankStanceCheck()
            if SummonChocobo and not ChocoboSummonDisabled then
                ChocoboCheck()
            end
        end
        return true
    else
        GearsetSwitchRetryCount = (GearsetSwitchRetryCount or 0) + 1
        if GearsetSwitchRetryCount >= 5 then
            Dalamud.Log("[FATE] Gearset switch failed 5 times for " .. desired .. ", giving up")
            -- Do not mark as equipped; we will retry when the target fate changes.
            GearsetSwitchRetryCount = 0
        end
        return false
    end
end

function HandleUnexpectedCombat()
    Dalamud.Log("[FATE] HandleUnexpectedCombat entered. inCombat=" ..
        tostring(Svc.Condition[CharacterCondition.inCombat]) ..
        " mounted=" .. tostring(Svc.Condition[CharacterCondition.mounted]) ..
        " flying=" .. tostring(Svc.Condition[CharacterCondition.flying]))

    -- Stay mounted when targeted while flying/riding; let vnavmesh keep moving
    -- rather than dismounting and engaging every overworld mob.
    if Svc.Condition[CharacterCondition.mounted] or Svc.Condition[CharacterCondition.flying] then
        Dalamud.Log("[FATE] UnexpectedCombat: staying mounted, resuming movement")
        State = CharacterState.moveToFate
        return
    end
    TurnOnCombatMods("manual")
    yield("/wait 0.3")

    local nearestFate = Fates.GetNearestFate()
    local nearestProgress = nearestFate and nearestFate.Progress or nil
    if InActiveFate() and nearestProgress ~= nil and nearestProgress < 100 then
        CurrentFate = BuildFateTable(nearestFate)
        State = CharacterState.doFate
        Dalamud.Log("[FATE] State Change: DoFate")
        return
    elseif not Svc.Condition[CharacterCondition.inCombat] then
        if Svc.Targets.Target ~= nil and not Svc.Targets.Target.IsDead then
            -- The inCombat condition can flicker; if we still have a live target,
            -- keep fighting instead of dropping back to ready.
            Dalamud.Log("[FATE] UnexpectedCombat: inCombat flag dropped, but target still present")
        else
            SafeYield("/vnav stop")
            ClearTarget()
            TurnOffCombatMods()
            State = CharacterState.ready
            Dalamud.Log("[FATE] State Change: Ready")
            local randomWait = GetPostFateWaitSeconds()
            yield("/wait " .. randomWait)
            return
        end
    end

    -- if Svc.Condition[CharacterCondition.mounted] then
    --     if not (IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning()) then
    --         IPC.vnavmesh.PathfindAndMoveTo(Svc.ClientState.Location, true)
    --     end
    --     yield("/wait 10")
    --     return
    -- end

    -- targets whatever is trying to kill you
    if Svc.Targets.Target == nil then
        Dalamud.Log("[FATE] UnexpectedCombat: no target, attempting acquisition")
        if not TargetNearestAttackingEnemy() then
            SafeYield("/battletarget")
            yield("/wait 0.3")
        end
        if Svc.Targets.Target == nil then
            SafeYield("/targetenemy")
            yield("/wait 0.3")
        end
    end
    Dalamud.Log("[FATE] UnexpectedCombat: target=" ..
        tostring(Svc.Targets.Target and Svc.Targets.Target.Name or "nil") ..
        " distance=" .. tostring(GetDistanceToTargetFlat()))

    -- pathfind closer if enemies are too far
    if Svc.Targets.Target ~= nil then
        if GetDistanceToTargetFlat() > (MaxDistance + GetTargetHitboxRadius() + GetPlayerHitboxRadius()) then
            if not (IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning()) then
                MoveToTargetHitbox()
            end
        else
            if IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning() then
                SafeYield("/vnav stop")
            elseif not Svc.Condition[CharacterCondition.inCombat] then
                --inch closer 3 seconds
                MoveToTargetHitbox()
                yield("/wait 3")
            end
        end
    end
    yield("/wait 1")
end

function DoFate()
    Dalamud.Log("[FATE] DoFate")
    if CurrentFate == nil or CurrentFate.fateObject == nil then
        Dalamud.Log("[FATE] DoFate: CurrentFate is invalid, returning to Ready.")
        State = CharacterState.ready
        return
    end
    if WaitingForFateRewards ~= nil and WaitingForFateRewards.fateId ~= CurrentFate.fateId then
        FinalizeFateTimingLog(WaitingForFateRewards, nil)
    end
    if WaitingForFateRewards == nil or WaitingForFateRewards.fateId ~= CurrentFate.fateId then
        WaitingForFateRewards = CurrentFate
        SessionFatesStarted = SessionFatesStarted + 1
        Dalamud.Log("[FATE] WaitingForFateRewards DoFate: " .. tostring(WaitingForFateRewards.fateId))
    end
    EnsureFateTimingEntry(CurrentFate)
    NoteFateCombatStart(CurrentFate)

    -- Gearset handling (level-sync tank, normal gearset, boss class, main class)
    if EnsureCorrectGearsetForFate(CurrentFate) then
        TurnOffCombatMods()
        return
    end

    local doFateNow = os.clock()
    if CombatStartBoostFateId ~= CurrentFate.fateId then
        CombatStartBoostFateId = CurrentFate.fateId
        CombatStartBoostUntil = doFateNow + (CombatStartBoostDurationSeconds or 12)
    end
    local combatStartBoostActive = CombatStartBoostFateId == CurrentFate.fateId
        and doFateNow < (CombatStartBoostUntil or 0)
    local shouldPreserveBonusBuff = ShouldPreserveBonusBuffForZoneSwitch(true)

    local maxLevel = GetFateMaxLevelValue(CurrentFate, nil)
    local inCurrentFate = InActiveFate()
    local needsLevelSync = NeedsLevelSyncForFate(CurrentFate) and not Player.IsLevelSynced
    if needsLevelSync then
        local radius = GetFateRadiusValue(CurrentFate, nil)
        local distanceToFateCenter = GetDistanceToPoint(CurrentFate.position)
        local syncRangeBuffer = LevelSyncInRangeBuffer or 1.5
        local inSyncRange = IsFateActive(CurrentFate.fateObject)
            and ((radius ~= nil and distanceToFateCenter <= radius + syncRangeBuffer) or inCurrentFate)
        local now = os.clock()
        local navBusy = IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning()
        if LevelSyncWaitFateId ~= CurrentFate.fateId then
            LevelSyncWaitFateId = CurrentFate.fateId
            LevelSyncWaitStartedAt = now
            LastLevelSyncAttemptAt = 0
            LevelSyncFailureCount = 0
            LevelSyncNextAttemptAt = 0
            LevelSyncHardCooldownUntil = 0
            LevelSyncWasInRange = false
            LevelSyncReentryAttemptPending = false
            LevelSyncOutOfRangeNoProgressSince = nil
            LevelSyncOutOfRangeLastDistance = nil
        end

        if inSyncRange then
            if LevelSyncWasInRange ~= true then
                LevelSyncWasInRange = true
                LevelSyncReentryAttemptPending = true
            end
            LevelSyncOutOfRangeNoProgressSince = nil
            LevelSyncOutOfRangeLastDistance = nil
        else
            LevelSyncWasInRange = false
            LevelSyncReentryAttemptPending = false
            local distanceToFateCenter = GetDistanceToPoint(CurrentFate.position)
            if distanceToFateCenter ~= nil then
                if LevelSyncOutOfRangeLastDistance == nil
                    or (LevelSyncOutOfRangeLastDistance - distanceToFateCenter) >= 2
                then
                    LevelSyncOutOfRangeNoProgressSince = now
                    LevelSyncOutOfRangeLastDistance = distanceToFateCenter
                elseif LevelSyncOutOfRangeNoProgressSince == nil then
                    LevelSyncOutOfRangeNoProgressSince = now
                    LevelSyncOutOfRangeLastDistance = distanceToFateCenter
                end
            end
        end

        if inSyncRange and (Svc.Condition[CharacterCondition.mounted] or Svc.Condition[CharacterCondition.flying]) then
            Dismount(true)
            TurnOnCombatMods("auto")
            return
        end

        if not inSyncRange then
            local syncMoveTarget = GetPreferredFateMovePosition(CurrentFate) or CurrentFate.position
            if HandleMovementStuck(syncMoveTarget) then
                TurnOnCombatMods("auto")
                return
            end

            local noProgressElapsed = now - (LevelSyncOutOfRangeNoProgressSince or now)
            if navBusy and noProgressElapsed >= (LevelSyncOutOfRangeForceRepathSeconds or 7) then
                Dalamud.Log("[FATE] Outside sync range without approach progress. Repathing to fate center.")
                if IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning() then
                    SafeYield("/vnav stop")
                    yield("/wait 0.2")
                end
                IPC.vnavmesh.PathfindAndMoveTo(syncMoveTarget, Player.CanFly and SelectedZone.flying)
                LevelSyncOutOfRangeNoProgressSince = now
                LevelSyncOutOfRangeLastDistance = GetDistanceToPoint(CurrentFate.position)
                TurnOnCombatMods("auto")
                return
            end
        end

        -- While waiting for level sync, avoid chasing distant/invalid targets and wall-running.
        if Svc.Targets.Target ~= nil then
            local wrappedSyncTarget = EntityWrapper(Svc.Targets.Target)
            local invalidTarget = wrappedSyncTarget == nil or wrappedSyncTarget.FateId ~= CurrentFate.fateId
            local outsideBounds = not IsCurrentTargetInsideCurrentFateBounds(GetCurrentFateMoveBoundaryBuffer())
            if invalidTarget or outsideBounds or not inSyncRange then
                ClearTarget()
            end
        end
        if inSyncRange and navBusy then
            SafeYield("/vnav stop")
        end

        local forceReentryAttempt = LevelSyncReentryAttemptPending == true
        local canAttemptLevelSync = inSyncRange
            and not Svc.Condition[CharacterCondition.mounted]
            and not Svc.Condition[CharacterCondition.flying]
            and not Svc.Condition[CharacterCondition.casting]
            and not Svc.Condition[CharacterCondition.jumping48]
            and not Svc.Condition[CharacterCondition.jumping61]
            and not Svc.Condition[CharacterCondition.beingMoved]
            and not Svc.Condition[CharacterCondition.betweenAreas]
            and not Svc.Condition[CharacterCondition.betweenAreasForDuty]
            and not Svc.Condition[CharacterCondition.occupied]
            and not Svc.Condition[CharacterCondition.occupiedInEvent]
            and not Svc.Condition[CharacterCondition.occupiedInQuestEvent]
            and not Svc.Condition[CharacterCondition.occupiedMateriaExtractionAndRepair]
            and not IsLifestreamBusySafe()
            and (forceReentryAttempt
                or ((LevelSyncHardCooldownUntil == nil or now >= LevelSyncHardCooldownUntil)
                    and (LevelSyncNextAttemptAt == nil or now >= LevelSyncNextAttemptAt)
                    and (LastLevelSyncAttemptAt == nil or now - LastLevelSyncAttemptAt >= 1.5)))
        if canAttemptLevelSync then
            LevelSyncReentryAttemptPending = false
            LastLevelSyncAttemptAt = now
            SafeYield("/lsync")
            yield("/wait " .. tostring(FastCombatPacing and 0.25 or 0.5)) -- give it a moment to register
            if Player.IsLevelSynced then
                LevelSyncFailureCount = 0
                LevelSyncNextAttemptAt = 0
                LevelSyncHardCooldownUntil = 0
            else
                LevelSyncFailureCount = (LevelSyncFailureCount or 0) + 1
                local backoff = math.min(20, 4 + (LevelSyncFailureCount * 3))
                LevelSyncNextAttemptAt = now + backoff

                if inSyncRange and LevelSyncFailureCount >= (LevelSyncForceCenterAfterFailures or 2) then
                    if IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning() then
                        SafeYield("/vnav stop")
                    end
                    if Svc.Targets.Target ~= nil then
                        ClearTarget()
                    end
                    local preferredSyncPos = GetPreferredFateMovePosition(CurrentFate) or CurrentFate.position
                    if preferredSyncPos ~= nil and GetDistanceToPoint(preferredSyncPos) > 4 then
                        IPC.vnavmesh.PathfindAndMoveTo(preferredSyncPos, false)
                        LevelSyncNextAttemptAt = now + (LevelSyncCenterApproachSeconds or 2.5)
                    end
                end

                if LevelSyncFailureCount >= 4 then
                    LevelSyncFailureCount = 0
                    LevelSyncHardCooldownUntil = now + 30
                    LevelSyncNextAttemptAt = LevelSyncHardCooldownUntil
                    Dalamud.Log("[FATE] Level sync unavailable repeatedly. Pausing /lsync attempts for 30s.")
                end
            end
        end

        local levelSyncWaitElapsed = now - (LevelSyncWaitStartedAt or now)
        local syncLooksBlocked = (LevelSyncHardCooldownUntil or 0) > now or (LevelSyncFailureCount or 0) >= 3
        local earlySkipWait = UnresponsiveLevelSyncEarlySkipSeconds or 16
        if inSyncRange and syncLooksBlocked and levelSyncWaitElapsed >= earlySkipWait then
            local msg = string.format(
                "[FATE] Early skip: level sync remained unavailable on fate #%s (%s) for %.1fs.",
                tostring(CurrentFate.fateId or 0),
                tostring(CurrentFate.fateName or ""),
                levelSyncWaitElapsed
            )
            Dalamud.Log(msg)
            SendDiscordMessage(msg)
            RecordZoneUnresponsiveSkip(Svc.ClientState.TerritoryType, "level_sync")
            SafeYield("/vnav stop")
            WaitingForFateRewards = nil
            ResetNoCombatRecoveryState()
            if StayOnCurrentMapOnly or shouldPreserveBonusBuff then
                if shouldPreserveBonusBuff and not StayOnCurrentMapOnly then
                    Dalamud.Log("[FATE] Preserving Twist of Fate buff: skip zone switch for level-sync recovery.")
                end
                CurrentFate = nil
                NextFate = nil
            else
                SelectNextDawntrailZone()
            end
            State = CharacterState.ready
            return
        end

        -- If already in sync range, avoid micro-repath loops; just hold position for /lsync.
        if not inSyncRange and not navBusy then
            local preferredSyncPos = GetPreferredFateMovePosition(CurrentFate) or CurrentFate.position
            IPC.vnavmesh.PathfindAndMoveTo(preferredSyncPos, Player.CanFly and SelectedZone.flying)
        end
        TurnOnCombatMods("auto")
        return
    else
        LastLevelSyncAttemptAt = 0
        LevelSyncFailureCount = 0
        LevelSyncNextAttemptAt = 0
        LevelSyncHardCooldownUntil = 0
        LevelSyncWaitFateId = nil
        LevelSyncWaitStartedAt = 0
        LevelSyncWasInRange = false
        LevelSyncReentryAttemptPending = false
        LevelSyncOutOfRangeNoProgressSince = nil
        LevelSyncOutOfRangeLastDistance = nil
    end

    if NoCombatTeleportTimeout > 0 and not CurrentFate.isCollectionsFate and not CurrentFate.isOtherNpcFate then
        local now = os.clock()
        local progress = GetFateProgressValue(CurrentFate, nil)
        local radius = GetFateRadiusValue(CurrentFate, nil)
        local inRange = IsFateActive(CurrentFate.fateObject)
            and progress ~= nil
            and progress < 100
            and radius ~= nil
            and (GetDistanceToPoint(CurrentFate.position) <= radius + 10)
        if Svc.Condition[CharacterCondition.inCombat] or not inRange then
            ResetNoCombatRecoveryState()
        else
            if NoCombatRecoveryFateId ~= CurrentFate.fateId then
                NoCombatRecoveryFateId = CurrentFate.fateId
                NoCombatRecoveryStage = 0
                NoCombatRecoveryLastActionAt = 0
                NoCombatStartTime = now
            elseif NoCombatStartTime == nil then
                NoCombatStartTime = now
            end

            local elapsed = now - (NoCombatStartTime or now)
            local stage1At = math.max(6, NoCombatTeleportTimeout * (NoCombatRecoveryRetargetRatio or 0.35))
            local stage2At = math.max(stage1At + 3, NoCombatTeleportTimeout * (NoCombatRecoveryRepositionRatio or 0.7))
            local hasValidFateTarget = false
            if Svc.Targets.Target ~= nil then
                local wrappedTarget = EntityWrapper(Svc.Targets.Target)
                hasValidFateTarget = wrappedTarget ~= nil
                    and wrappedTarget.FateId == CurrentFate.fateId
                    and not Svc.Targets.Target.IsDead
            end
            if hasValidFateTarget then
                NoCombatNoTargetSince = 0
            elseif (NoCombatNoTargetSince or 0) <= 0 then
                NoCombatNoTargetSince = now
            end
            local noTargetElapsed = (NoCombatNoTargetSince or 0) > 0 and (now - NoCombatNoTargetSince) or 0

            if NoCombatRecoveryStage < 1
                and elapsed >= stage1At
                and now - (NoCombatRecoveryLastActionAt or 0) >= 2
            then
                local reacquireRadius = math.max(
                    (DynamicAoeCheckRadius or 30) + 10,
                    (ClusterMoveRadius or 40),
                    (radius or 0) + 20
                )
                Dalamud.Log("[FATE] No-combat staged recovery #1: retarget/reacquire.")
                ClearTarget()
                local acquired = AttemptToTargetClosestFateEnemy(true, reacquireRadius, true)
                if not acquired then
                    SafeYield("/battletarget")
                end
                NoCombatRecoveryStage = 1
                NoCombatRecoveryLastActionAt = now
                return
            end

            if NoCombatRecoveryStage < 2
                and elapsed >= stage2At
                and now - (NoCombatRecoveryLastActionAt or 0) >= 3
            then
                Dalamud.Log("[FATE] No-combat staged recovery #2: reposition to fate center.")
                SafeYield("/vnav stop")
                local preferredSyncPos = GetPreferredFateMovePosition(CurrentFate) or CurrentFate.position
                IPC.vnavmesh.PathfindAndMoveTo(preferredSyncPos, false)
                NoCombatRecoveryStage = 2
                NoCombatRecoveryLastActionAt = now
                return
            end

            local earlySkipAt = math.max(10, NoCombatTeleportTimeout * (UnresponsiveSkipRatio or 0.65))
            local noTargetTooLong = noTargetElapsed >= (UnresponsiveNoTargetSkipSeconds or 10)
            if NoCombatRecoveryStage >= 2 and elapsed >= earlySkipAt and noTargetTooLong then
                local msg = string.format(
                    "[FATE] Early skip: no valid target for %.1fs after staged recovery on fate #%s (%s).",
                    noTargetElapsed,
                    tostring(CurrentFate.fateId or 0),
                    tostring(CurrentFate.fateName or "")
                )
                Dalamud.Log(msg)
                SendDiscordMessage(msg)
                RecordZoneUnresponsiveSkip(Svc.ClientState.TerritoryType, "no_target")
                ResetNoCombatRecoveryState()
                WaitingForFateRewards = nil
                SafeYield("/vnav stop")
                if StayOnCurrentMapOnly or shouldPreserveBonusBuff then
                    if shouldPreserveBonusBuff and not StayOnCurrentMapOnly then
                        Dalamud.Log("[FATE] Preserving Twist of Fate buff: skip zone switch for no-target recovery.")
                    end
                    CurrentFate = nil
                    NextFate = nil
                else
                    SelectNextDawntrailZone()
                end
                State = CharacterState.ready
                return
            end

            if elapsed >= NoCombatTeleportTimeout then
                local timedOutFateName = (CurrentFate and CurrentFate.fateName) or "Unknown FATE"
                local timedOutFateId = (CurrentFate and CurrentFate.fateId) or 0
                local timeoutMsg = string.format(
                    "[FATE] No-combat timeout triggered on FATE #%s: %s",
                    tostring(timedOutFateId),
                    tostring(timedOutFateName)
                )
                Dalamud.Log(timeoutMsg)
                SendDiscordMessage(timeoutMsg)
                RecordZoneUnresponsiveSkip(Svc.ClientState.TerritoryType, "no_combat_timeout")
                if StayOnCurrentMapOnly then
                    Dalamud.Log("[FATE] No combat started within timeout. Staying in current map due to setting.")
                else
                    Dalamud.Log("[FATE] No combat started within timeout. Switching zones.")
                end
                ResetNoCombatRecoveryState()
                WaitingForFateRewards = nil
                SafeYield("/vnav stop")
                if StayOnCurrentMapOnly or shouldPreserveBonusBuff then
                    if shouldPreserveBonusBuff and not StayOnCurrentMapOnly then
                        Dalamud.Log("[FATE] Preserving Twist of Fate buff: skip zone switch for no-combat timeout.")
                    end
                    CurrentFate = nil
                    NextFate = nil
                else
                    SelectNextDawntrailZone()
                end
                State = CharacterState.ready
                return
            end
        end
    else
        ResetNoCombatRecoveryState()
    end
    local progress = GetFateProgressValue(CurrentFate, nil)
    local radius = GetFateRadiusValue(CurrentFate, nil)
    if IsFateActive(CurrentFate.fateObject) and not InActiveFate()
        and progress ~= nil and progress < 100
        and radius ~= nil and (GetDistanceToPoint(CurrentFate.position) < radius + 10)
        and not Svc.Condition[CharacterCondition.mounted]
        and not (IPC.vnavmesh.IsRunning() or IPC.vnavmesh.PathfindInProgress()) then -- got pushed out of fate. go back
        SafeYield("/vnav stop")
        yield("/wait 1")
        Dalamud.Log("[FATE] pushed out of fate going back!")
        local fallbackPos = GetPreferredFateMovePosition(CurrentFate) or CurrentFate.position
        IPC.vnavmesh.PathfindAndMoveTo(fallbackPos,
            Player.CanFly and SelectedZone.flying)
        return
    elseif not IsFateActive(CurrentFate.fateObject) or progress == 100 then
        SafeYield("/vnav stop")
        ClearTarget()
        Dalamud.Log("[FATE] HasContinuation check")
        if CurrentFate.hasContinuation then
            LastFateEndTime = os.clock()
            State = CharacterState.waitForContinuation
            Dalamud.Log("[FATE] State Change: WaitForContinuation")
            return
        else
            DidFate = true
            Dalamud.Log("[FATE] No continuation for " .. CurrentFate.fateName)
            local randomWait = GetPostFateWaitSeconds()
            yield("/wait " .. randomWait)
            TurnOffCombatMods()
            ForlornMarked = false
            MovingAnnouncementLock = false
            ResetTargetAcquireWatchdog()

            -- If a new FATE spawned right on top of the old one, switch to it
            -- immediately instead of going back to Ready and risking it not
            -- being picked up (e.g. duration/startTime still zero).
            local nearbyNewFate = FindNearbyActiveFate(CurrentFate.position, 30, CurrentFate.fateId)
            if nearbyNewFate ~= nil then
                CurrentFate = nearbyNewFate
                NextFate = nearbyNewFate
                ResetNoCombatRecoveryState()
                State = CharacterState.doFate
                Dalamud.Log("[FATE] State Change: DoFate (same-spot new fate, fateId=" .. tostring(CurrentFate.fateId) .. ")")
            else
                CurrentFate = nil
                NextFate = nil
                State = CharacterState.ready
                Dalamud.Log("[FATE] State Change: Ready")
            end
        end
        return
    elseif Svc.Condition[CharacterCondition.mounted] then
        State = CharacterState.MiddleOfFateDismount
        Dalamud.Log("[FATE] State Change: MiddleOfFateDismount")
        return
    elseif CurrentFate.isCollectionsFate then
        yield("/wait 1") -- needs a moment after start of fate for GetFateEventItem to populate
        if Inventory.GetItemCount(CurrentFate.fateObject.EventItem) >= 7 or (GotCollectionsFullCredit and CurrentFate.fateObject.Progress == 100) then
            SafeYield("/vnav stop")
            State = CharacterState.collectionsFateTurnIn
            Dalamud.Log("[FATE] State Change: CollectionsFatesTurnIn")
        end
    end

    Dalamud.Log("[FATE] DoFate->Finished transition checks")

    -- (Removed) Force target specific enemies for continuation FATEs
    -- The hardcoded list (カナルガルパー / Canal Gulper) only matched one
    -- continuation FATE ("Pulling the Wool"). When the list did not match
    -- the current continuation FATE, the empty /target calls cleared
    -- Svc.Targets.Target and delayed the fallback acquisition. Let the
    -- AttemptToTargetClosestFateEnemy / hasValidTarget fallback below
    -- pick the first valid enemy for any continuation FATE.
    local forceTargeted = false

    -- do not target fate npc during combat
    if not forceTargeted and CurrentFate.npcName ~= nil and GetTargetName() == CurrentFate.npcName then
        Dalamud.Log("[FATE] Attempting to clear target.")
        ClearTarget()
        yield("/wait 1")
    end

    TurnOnCombatMods("auto")
    TankStanceCheck()

    GemAnnouncementLock = false
    local fateRadiusForAcquire = GetFateRadiusValue(CurrentFate, nil) or 0
    local fateProgress = GetFateProgressValue(CurrentFate, nil)
    if FinisherEstimateFateId ~= CurrentFate.fateId then
        FinisherEstimateFateId = CurrentFate.fateId
        FinisherEstimateLastProgress = fateProgress
        FinisherEstimatedSingleKillGain = nil
    elseif fateProgress ~= nil then
        local lastProgress = FinisherEstimateLastProgress
        if lastProgress ~= nil then
            if fateProgress + 0.01 < lastProgress then
                -- Same fate id can reappear later; reset sample when progress goes backward.
                FinisherEstimatedSingleKillGain = nil
            elseif fateProgress > lastProgress then
                local progressDelta = fateProgress - lastProgress
                if progressDelta > 0 and progressDelta <= (FinisherMaxSampleDelta or 25) then
                    if FinisherEstimatedSingleKillGain == nil or progressDelta < FinisherEstimatedSingleKillGain then
                        FinisherEstimatedSingleKillGain = progressDelta
                    end
                end
            end
        end
        FinisherEstimateLastProgress = fateProgress
    end
    local boostAcquireRadius = combatStartBoostActive
        and math.max((DynamicAoeCheckRadius or 30) + 20, (ClusterMoveRadius or 40) + 15, fateRadiusForAcquire + 35)
        or nil
    local remainingProgress = fateProgress ~= nil and (100 - fateProgress) or nil
    local estimatedOneKillProgress = FinisherEstimatedSingleKillGain
    local dynamicFinisherWindow = nil
    if estimatedOneKillProgress ~= nil then
        dynamicFinisherWindow = math.max(
            FinisherMinRemainingWindow or 0.8,
            estimatedOneKillProgress * (FinisherRemainingMultiplier or 1.15)
        )
    end
    local finisherFocusMode = fateProgress ~= nil
        and fateProgress < 100
        and not CurrentFate.isCollectionsFate
        and not CurrentFate.isOtherNpcFate
        and (
            (dynamicFinisherWindow ~= nil and remainingProgress ~= nil and remainingProgress <= dynamicFinisherWindow)
            or fateProgress >= (FinisherFallbackProgressThreshold or 97)
        )

    -- switches to targeting forlorns for bonus (if present)
    TryTargetForlorn()

    local activeTargetName = GetTargetName()
    local isForlornActive = IsForlornTargetName(activeTargetName) and not Svc.Targets.Target.IsDead

    if not isForlornActive then
        local now_pull = os.clock()
        TryActivePullNearbyEnemies(now_pull)
    end

    if isForlornActive then
        if IgnoreForlorns or (IgnoreBigForlornOnly and IsBigForlornTargetName(activeTargetName)) then
            ClearTarget()
        else
            if not ForlornMarked then
                yield("/mk attack1 <t>")
                if Echo == "all" then
                    yield("/echo Found Forlorn! <se.3>")
                end
                TurnOffAoes()
                ForlornMarked = true
            end
        end
    else
        UpdateCombatModeByNearbyEnemies()
    end

    -- Tanks pull enemies toward themselves; use a tighter boundary so we don't get dragged out.
    local hardBoundaryBuffer = GetCurrentFateHardBoundaryBuffer()
    if GetPartyPlayActive() and PrioritizePartyMemberTargets then
        hardBoundaryBuffer = math.min(hardBoundaryBuffer, 8)
    end
    if IsFateActive(CurrentFate.fateObject)
        and fateRadiusForAcquire > 0
        and GetDistanceToPoint(CurrentFate.position) > (fateRadiusForAcquire + hardBoundaryBuffer)
    then
        Dalamud.Log("[FATE] Outside fate boundary while in combat loop. Returning to center.")
        if IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning() then
            SafeYield("/vnav stop")
        end
        if Svc.Targets.Target ~= nil then
            ClearTarget()
        end
        local fallbackPos = GetPreferredFateMovePosition(CurrentFate) or CurrentFate.position
        IPC.vnavmesh.PathfindAndMoveTo(fallbackPos, false)
        return
    end

    if Svc.Condition[CharacterCondition.inCombat]
        and not CurrentFate.isCollectionsFate
        and not CurrentFate.isOtherNpcFate
        and not Svc.Condition[CharacterCondition.casting]
    then
        local currentTargetName = GetTargetName()
        local pullCooldownActive = (ActivePullLastAttemptAt or 0) > 0
            and (os.clock() - ActivePullLastAttemptAt) < 1.5
        local hasValidPullTarget = Svc.Targets.Target ~= nil
            and not Svc.Targets.Target.IsDead
            and IsCurrentTargetInsideCurrentFateBounds(GetCurrentFateMoveBoundaryBuffer())

        if not IsForlornTargetName(currentTargetName) and not (pullCooldownActive and hasValidPullTarget) then
            local leashSafeRadius = GetLeashSafeRetargetRadius()
            local farPullRadius = math.max((DynamicAoeCheckRadius or 30), (ClusterMoveRadius or 40),
                fateRadiusForAcquire + 15, boostAcquireRadius or 0)
            farPullRadius = math.min(farPullRadius, leashSafeRadius)
            if finisherFocusMode and AttemptToTargetLowestHpFateEnemy(farPullRadius) then
                TurnOffAoes()
            else
                AttemptToTargetClosestFateEnemy(true, farPullRadius, true)
            end
        end
    end

    -- targets whatever is trying to kill you
    if Svc.Targets.Target == nil then
        local leashSafeRadius = GetLeashSafeRetargetRadius()
        local farPullRadius = math.max((DynamicAoeCheckRadius or 30), (ClusterMoveRadius or 40),
            fateRadiusForAcquire + 15, boostAcquireRadius or 0)
        farPullRadius = math.min(farPullRadius, leashSafeRadius)
        local gotTarget = false
        if finisherFocusMode then
            gotTarget = AttemptToTargetLowestHpFateEnemy(farPullRadius)
            if gotTarget then
                TurnOffAoes()
            end
        end
        if not gotTarget then
            gotTarget = AttemptToTargetClosestFateEnemy(true, farPullRadius, true)
        end
        if not gotTarget then
            SafeYield("/battletarget")
        end
    end

    -- clears target
    if Svc.Targets.Target ~= nil then
        local wrappedTarget = EntityWrapper(Svc.Targets.Target)
        if wrappedTarget ~= nil and (wrappedTarget.FateId ~= CurrentFate.fateId
                or not IsCurrentTargetInsideCurrentFateBounds(GetCurrentFateMoveBoundaryBuffer())) then
            ClearTarget()
        end
    end

    if not CurrentFate.isCollectionsFate and not CurrentFate.isOtherNpcFate then
        local hasValidTarget = false
        if Svc.Targets.Target ~= nil and not Svc.Targets.Target.IsDead then
            local wrappedTarget = EntityWrapper(Svc.Targets.Target)
            hasValidTarget = wrappedTarget ~= nil
                and wrappedTarget.FateId == CurrentFate.fateId
                and IsCurrentTargetInsideCurrentFateBounds(GetCurrentFateMoveBoundaryBuffer())
        end

        local now = os.clock()
        if hasValidTarget then
            TargetAcquireNoTargetSince = 0
        else
            if (TargetAcquireNoTargetSince or 0) <= 0 then
                TargetAcquireNoTargetSince = now
            end

            local canForceAcquire = not Svc.Condition[CharacterCondition.casting]
                and not Svc.Condition[CharacterCondition.mounted]
                and not Svc.Condition[CharacterCondition.flying]
                and not Svc.Condition[CharacterCondition.betweenAreas]
                and not Svc.Condition[CharacterCondition.betweenAreasForDuty]
                and not Svc.Condition[CharacterCondition.occupied]
                and not Svc.Condition[CharacterCondition.occupiedInEvent]
                and not Svc.Condition[CharacterCondition.occupiedInQuestEvent]
                and not Svc.Condition[CharacterCondition.occupiedMateriaExtractionAndRepair]
                and not IsLifestreamBusySafe()
            if canForceAcquire and now - (TargetAcquireLastAttemptAt or 0) >= (TargetAcquireRetrySeconds or 0.9) then
                TargetAcquireLastAttemptAt = now
                local reacquireRadius = math.max(
                    (DynamicAoeCheckRadius or 30) + 12,
                    (ClusterMoveRadius or 40),
                    fateRadiusForAcquire + 24
                )
                local gotFallbackTarget = AttemptToTargetClosestFateEnemy(false, reacquireRadius, true)
                if not gotFallbackTarget then
                    SafeYield("/battletarget")
                end
            end

            local noTargetElapsed = now - (TargetAcquireNoTargetSince or now)
            if Svc.Targets.Target == nil
                and noTargetElapsed >= (TargetAcquireStopNavSeconds or 2.4)
                and (IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning())
            then
                SafeYield("/vnav stop")
            end

            -- If no target for a while (e.g. after continuation fate spawn), move back to center
            if Svc.Targets.Target == nil
                and noTargetElapsed >= 6
                and not (IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning())
                and not Svc.Condition[CharacterCondition.mounted]
                and not Svc.Condition[CharacterCondition.flying]
                and not Svc.Condition[CharacterCondition.casting]
            then
                local fallbackPos = GetPreferredFateMovePosition(CurrentFate) or CurrentFate.position
                if fallbackPos ~= nil and GetDistanceToPoint(fallbackPos) > 8 then
                    Dalamud.Log("[FATE] No target for " ..
                    string.format("%.1f", noTargetElapsed) .. "s, moving to fate center.")
                    IPC.vnavmesh.PathfindAndMoveTo(fallbackPos, false)
                end
            end
        end
    end

    if not CurrentFate.isCollectionsFate
        and not CurrentFate.isOtherNpcFate
        and Svc.Targets.Target ~= nil
        and not Svc.Targets.Target.IsDead
        and not Svc.Condition[CharacterCondition.inCombat]
        and not Svc.Condition[CharacterCondition.casting]
        and not Svc.Condition[CharacterCondition.mounted]
        and not Svc.Condition[CharacterCondition.flying]
    then
        local now = os.clock()
        local targetPos = Svc.Targets.Target.Position
        local targetSignature = tostring(Svc.Targets.Target.DataId or 0) .. ":" ..
            tostring(math.floor(targetPos.X)) .. ":" ..
            tostring(math.floor(targetPos.Z))
        if CombatOpenTargetSignature ~= targetSignature then
            CombatOpenTargetSignature = targetSignature
            CombatOpenTargetSince = now
            CombatOpenActionSequence = 0
        elseif (CombatOpenTargetSince or 0) <= 0 then
            CombatOpenTargetSince = now
        end

        local engageRange = math.max(2.5, MaxDistance + GetTargetHitboxRadius() + GetPlayerHitboxRadius() + 0.5)
        local targetDistanceFlat = GetDistanceToTargetFlat()
        local openActionRange = CombatOpenActionMaxRange or 20.5
        local shouldForceOpen = targetDistanceFlat <= math.max(engageRange, openActionRange)
            and now - (CombatOpenTargetSince or now) >= (CombatOpenNoCombatGraceSeconds or 1.3)
            and now - (CombatOpenLastPulseAt or 0) >= (CombatOpenPulseSeconds or 1.4)
        if shouldForceOpen then
            CombatOpenLastPulseAt = now
            if IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning() then
                SafeYield("/vnav stop")
            end
            MoveToTargetHitbox()
            if RotationPlugin == "Wrath" then
                if WrathAutoEnabled ~= true then
                    SafeYield("/wrath auto")
                    WrathAutoEnabled = true
                end
                MarkWrathAutoPulse(now)
            end
            if TryForceCombatOpenOnTarget(now, targetDistanceFlat) then
                CombatOpenTargetSince = now
            else
                TryGapCloserOnTarget(targetDistanceFlat)
            end

            local retargetAfter = CombatOpenRetargetSeconds or 2.2
            if now - (CombatOpenTargetSince or now) >= retargetAfter then
                local pullRadius = math.max(
                    (DynamicAoeCheckRadius or 30) + 10,
                    (ClusterMoveRadius or 40),
                    fateRadiusForAcquire + 25
                )
                ClearTarget()
                local retargeted = AttemptToTargetClosestFateEnemy(true, pullRadius, true)
                if not retargeted then
                    retargeted = AttemptToTargetClosestFateEnemy(false, pullRadius, true)
                end
                if not retargeted then
                    SafeYield("/battletarget")
                end
                CombatOpenTargetSignature = nil
                CombatOpenTargetSince = now
                return
            end
        end
    else
        CombatOpenTargetSignature = nil
        CombatOpenTargetSince = 0
        CombatOpenLastPulseAt = 0
        CombatOpenActionSequence = 0
    end

    local meleeOrTank = Player.Job and (Player.Job.IsMeleeDPS or Player.Job.IsTank)
    if not meleeOrTank or Svc.Targets.Target == nil then
        ResetMeleeEngageRecoveryState()
    else
        local targetName = GetTargetName()
        if targetName == nil
            or targetName == ""
            or targetName == CurrentFate.npcName
            or IsForlornTargetName(targetName)
        then
            ResetMeleeEngageRecoveryState()
        else
            local now = os.clock()
            local targetPos = Svc.Targets.Target.Position
            local targetSignature = tostring(targetName) .. ":" ..
                tostring(math.floor(targetPos.X)) .. ":" ..
                tostring(math.floor(targetPos.Z))
            if MeleeEngageTargetSignature ~= targetSignature then
                MeleeEngageTargetSignature = targetSignature
                MeleeEngageStartAt = now
            end

            local engageRange = math.max(2.5, MaxDistance + GetTargetHitboxRadius() + GetPlayerHitboxRadius() + 0.5)
            local targetDistanceFlat = GetDistanceToTargetFlat()
            if targetDistanceFlat <= engageRange then
                ResetMeleeEngageRecoveryState()
            else
                local navBusy = IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning()
                local movePulseSeconds = MeleeApproachMovePulseSeconds or 1.0
                if not navBusy
                    and not Svc.Condition[CharacterCondition.casting]
                    and not Svc.Condition[CharacterCondition.mounted]
                    and now - (MeleeEngageLastMoveAt or 0) >= movePulseSeconds
                then
                    MoveToTargetHitbox()
                    MeleeEngageLastMoveAt = now
                end

                local hardRecoverSeconds = MeleeApproachHardRecoverSeconds or 6.5
                local hardRecoverCooldown = MeleeApproachHardRecoverCooldown or 2.6
                local forceGapDistance = MeleeApproachForceGapDistance or 8
                local shouldHardRecover = (now - (MeleeEngageStartAt or now) >= hardRecoverSeconds)
                    and (targetDistanceFlat > (engageRange + forceGapDistance))
                    and (now - (MeleeEngageLastHardRecoverAt or 0) >= hardRecoverCooldown)
                if shouldHardRecover then
                    MeleeEngageLastHardRecoverAt = now
                    Dalamud.Log("[FATE] Melee hard recovery: forcing approach and target refresh.")
                    if IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning() then
                        SafeYield("/vnav stop")
                    end
                    if not Svc.Condition[CharacterCondition.casting]
                        and not Svc.Condition[CharacterCondition.mounted]
                        and not Svc.Condition[CharacterCondition.flying]
                    then
                        MoveToTargetHitbox()
                        MeleeEngageLastMoveAt = now
                    end

                    local fateRadius = GetFateRadiusValue(CurrentFate, nil) or 0
                    local retargetRadius = math.max(
                        (DynamicAoeCheckRadius or 30) + 10,
                        (ClusterMoveRadius or 40),
                        fateRadius + 18
                    )
                    ClearTarget()
                    local reacquired = AttemptToTargetClosestFateEnemy(true, retargetRadius, true)
                    if not reacquired then
                        SafeYield("/battletarget")
                    end
                    MeleeEngageStartAt = now
                    MeleeEngageNextRetargetAt = now + 2
                    return
                end

                local retargetSeconds = MeleeApproachRetargetSeconds or 5
                if now - (MeleeEngageStartAt or now) >= retargetSeconds
                    and now >= (MeleeEngageNextRetargetAt or 0)
                then
                    local fateRadius = GetFateRadiusValue(CurrentFate, nil) or 0
                    local retargetRadius = math.max(
                        (DynamicAoeCheckRadius or 30) + 10,
                        (ClusterMoveRadius or 40),
                        fateRadius + 18
                    )
                    Dalamud.Log("[FATE] Melee engage timeout. Switching to a closer target.")
                    ClearTarget()
                    local reacquired = AttemptToTargetClosestFateEnemy(true, retargetRadius, true)
                    if not reacquired then
                        SafeYield("/battletarget")
                    end
                    MeleeEngageStartAt = now
                    MeleeEngageNextRetargetAt = now + 3
                    return
                end
            end
        end
    end

    MaybeRearmWrathAuto()

    -- Prefetch next candidate while current fate is still ongoing (even in combat/cast state).
    TryPrefetchNextFate()

    -- do not interrupt casts to path towards enemies
    if Svc.Condition[CharacterCondition.casting] then
        return
    end

    --hold buff thingy
    local progress = fateProgress
    if progress ~= nil and progress >= PercentageToHoldBuff then
        TurnOffRaidBuffs()
    end

    local stopBeforeInchWait = FastCombatPacing and 0.08 or 5.002
    local inchCloserWait = FastCombatPacing and 0.08 or 1
    local preApproachWaitOutOfCombat = FastCombatPacing and 0.3 or 5.003
    local preApproachWaitInCombat = FastCombatPacing and 0.3 or 5.004
    local targetStickWait = FastCombatPacing and 0.05 or 1

    local preferredMovePos = GetPreferredFateMovePosition(CurrentFate) or CurrentFate.position
    local leashSafeRadius = GetLeashSafeRetargetRadius()

    -- pathfind closer if enemies are too far
    if not Svc.Condition[CharacterCondition.inCombat] then
        if HandleMovementStuck(preferredMovePos) then
            return
        end

        if Svc.Targets.Target ~= nil then
            if GetDistanceToTargetFlat() > (leashSafeRadius + 8) then
                ClearTarget()
                return
            end
            if GetDistanceToTargetFlat() <= (MaxDistance + GetTargetHitboxRadius() + GetPlayerHitboxRadius()) then
                if OptimizeClusterMovement == true and GetDistanceToPointFlat(preferredMovePos) > 4 then
                    local distToTargetFromPreferred = DistanceBetweenFlat(preferredMovePos, Svc.Targets.Target.Position)
                    if distToTargetFromPreferred <= (MaxDistance + GetTargetHitboxRadius() + GetPlayerHitboxRadius()) then
                        if not (IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning()) then
                            IPC.vnavmesh.PathfindAndMoveTo(preferredMovePos, false)
                        end
                        return
                    end
                end

                if IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning() then
                    SafeYield("/vnav stop")
                    yield("/wait " .. stopBeforeInchWait)                                                                                                           -- short pause before inching closer
                elseif (GetDistanceToTargetFlat() > (1 + GetTargetHitboxRadius() + GetPlayerHitboxRadius())) and not Svc.Condition[CharacterCondition.casting] then -- never move into hitbox
                    if IsCurrentTargetInsideCurrentFateBounds(GetCurrentFateMoveBoundaryBuffer()) then
                        MoveToTargetHitbox()
                        yield("/wait " .. inchCloserWait) -- inch closer briefly
                    else
                        ClearTarget()
                    end
                end
            elseif not (IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning()) then
                local meleeOrTank = Player.Job and (Player.Job.IsMeleeDPS or Player.Job.IsTank)
                if not meleeOrTank then
                    yield("/wait " .. preApproachWaitOutOfCombat)
                end
                if (Svc.Targets.Target ~= nil and not Svc.Condition[CharacterCondition.inCombat]) and not Svc.Condition[CharacterCondition.casting] then
                    MoveToTargetHitbox()
                end
            elseif Player.Job and (Player.Job.IsMeleeDPS or Player.Job.IsTank) then
                if Svc.Targets.Target ~= nil and not Svc.Condition[CharacterCondition.casting] then
                    MoveToTargetHitbox()
                end
            end
            return
        else
            local acquisitionRadius = boostAcquireRadius
            local gotTarget = false
            if finisherFocusMode then
                gotTarget = AttemptToTargetLowestHpFateEnemy(acquisitionRadius)
                if gotTarget then
                    TurnOffAoes()
                end
            end
            if not gotTarget then
                gotTarget = AttemptToTargetClosestFateEnemy(true, acquisitionRadius, true)
            end
            if not gotTarget then
                SafeYield("/battletarget")
            end
            yield("/wait " .. targetStickWait) -- short wait in case target doesnt stick
            if (Svc.Targets.Target == nil) and not Svc.Condition[CharacterCondition.casting] then
                if GetDistanceToPointFlat(preferredMovePos) > 10 then
                    if not (IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning()) then
                        IPC.vnavmesh.PathfindAndMoveTo(preferredMovePos, false)
                    end
                end
            end
        end
    else
        if Svc.Targets.Target ~= nil and GetDistanceToTargetFlat() > (leashSafeRadius + 5) then
            ClearTarget()
            local gotNearTarget = false
            if finisherFocusMode then
                gotNearTarget = AttemptToTargetLowestHpFateEnemy(leashSafeRadius)
                if gotNearTarget then
                    TurnOffAoes()
                end
            end
            if not gotNearTarget then
                gotNearTarget = AttemptToTargetClosestFateEnemy(true, leashSafeRadius, true)
            end
            if not gotNearTarget then
                SafeYield("/battletarget")
            end
            return
        end
        if Svc.Targets.Target ~= nil and (GetDistanceToTargetFlat() <= (MaxDistance + GetTargetHitboxRadius() + GetPlayerHitboxRadius())) then
            if OptimizeClusterMovement == true and GetDistanceToPointFlat(preferredMovePos) > 4 then
                local distToTargetFromPreferred = DistanceBetweenFlat(preferredMovePos, Svc.Targets.Target.Position)
                if distToTargetFromPreferred <= (MaxDistance + GetTargetHitboxRadius() + GetPlayerHitboxRadius()) then
                    if not (IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning()) then
                        IPC.vnavmesh.PathfindAndMoveTo(preferredMovePos, false)
                    end
                    return
                end
            end

            if IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning() then
                SafeYield("/vnav stop")
            end
        else
            if HandleMovementStuck(Svc.Targets.Target and Svc.Targets.Target.Position or nil) then
                return
            end
            local meleeOrTank = Player.Job and (Player.Job.IsMeleeDPS or Player.Job.IsTank)
            if not (IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning()) then
                if not meleeOrTank then
                    yield("/wait " .. preApproachWaitInCombat)
                end
                if Svc.Targets.Target ~= nil and not Svc.Condition[CharacterCondition.casting] then
                    if not IsCurrentTargetInsideCurrentFateBounds(GetCurrentFateMoveBoundaryBuffer()) then
                        ClearTarget()
                    else
                        MoveToTargetHitbox()
                    end
                end
            elseif meleeOrTank then
                if Svc.Targets.Target ~= nil and not Svc.Condition[CharacterCondition.casting] then
                    if not IsCurrentTargetInsideCurrentFateBounds(GetCurrentFateMoveBoundaryBuffer()) then
                        ClearTarget()
                    else
                        MoveToTargetHitbox()
                    end
                end
            end
        end
    end
end

--#endregion

--#region State Transition Functions

function Ready()
    if SelectedZone == nil or SelectedZone.zoneId == nil then
        local msg = "ERROR: SelectedZone is not set! Aborting."
        yield("/echo [FATE] " .. msg)
        SendDiscordMessage(msg)
        SetStopReason(msg)
        StopScript = true
        return
    end
    if StopScript then return end --Early exit before running ready checks.

    -- Party Play: auto-accept teleport offers from party leader/members
    if GetPartyPlayActive() then
        AcceptTeleportOfferLocation("")
    end

    -- Party Play: follow party leader to their zone
    if FollowPartyLeaderZone == true and GetPartyPlayActive() then
        FollowPartyLeaderToZone()
    end

    -- Party Play: follow closest party member if far away
    if FollowPartyMembers == true and GetPartyPlayActive() then
        local ptPos, ptDist = GetClosestPartyMemberPosition()
        if ptPos ~= nil and ptDist > 60 then
            if not Svc.Condition[CharacterCondition.inCombat]
                and not Svc.Condition[CharacterCondition.casting]
                and not Svc.Condition[CharacterCondition.betweenAreas]
            then
                if not (IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning()) then
                    Dalamud.Log("[FATE] Party member is " .. math.floor(ptDist) .. "y away. Moving to follow.")
                    IPC.vnavmesh.PathfindAndMoveTo(ptPos, false)
                end
            end
        end
    end

    FoodCheck()
    PotionCheck()
    ChocoboCheck()
    SprintCheck()

    -- Only reset combat-mod tracking when the state changes. Resetting it every
    -- frame made TurnOnCombatMods run every frame, which continuously re-sent
    -- BMR/VBM preset/AI commands and could interrupt AoE dodging.
    if LastProcessedState ~= State then
        CombatModsOn = false
        LastProcessedState = State
    end

    local shouldWaitForBonusBuff = WaitIfBonusBuff and HasTwistOfFateBuff()
    local needsRepair = Inventory.GetItemsInNeedOfRepairs(RemainingDurabilityToRepair)
    local spiritbonded = Inventory.GetSpiritbondedItems()

    if not GemAnnouncementLock and (Echo == "all" or Echo == "gems") then
        GemAnnouncementLock = true
        if BicolorGemCount >= BicolorGemExchangeThreshold then
            yield("/echo [FATE] You're almost capped with " .. tostring(BicolorGemCount) .. "/1500 gems! <se.3>")
            if ShouldExchangeBicolorGemstones and not shouldWaitForBonusBuff and Player.IsLevelSynced ~= true then
                State = CharacterState.exchangingVouchers
                Dalamud.Log("[FATE] State Change: ExchangingVouchers")
                return
            end
        else
            yield("/echo [FATE] Gems: " .. tostring(BicolorGemCount) .. "/1500")
        end
    end

    -- 修正: セルフ修理OFFのときはボーナスバフ中でも修理(リムサ移動)を止めない
    local bonusBuffBlocksRepair = shouldWaitForBonusBuff and SelfRepair and Inventory.GetItemCount(33916) <= 0
    if (RemainingDurabilityToRepair > 0 and needsRepair.Count > 0 and not bonusBuffBlocksRepair) or NeedsGysahlGreens then
        State = CharacterState.repair
        Dalamud.Log("[FATE] State Change: Repair (due to durability or gysahl greens)")
        return
    end

    if ShouldExtractMateria and spiritbonded.Count > 0 and Inventory.GetFreeInventorySlots() > 1 then
        State = CharacterState.extractMateria
        Dalamud.Log("[FATE] State Change: ExtractMateria")
        return
    end

    if WaitingForFateRewards == nil and Retainers and ARRetainersWaitingToBeProcessed() and Inventory.GetFreeInventorySlots() > 1 and not shouldWaitForBonusBuff then
        State = CharacterState.processRetainers
        Dalamud.Log("[FATE] State Change: ProcessingRetainers")
        return
    end

    if ShouldGrandCompanyTurnIn and Inventory.GetFreeInventorySlots() < InventorySlotsLeft and not shouldWaitForBonusBuff then
        State = CharacterState.gcTurnIn
        Dalamud.Log("[FATE] State Change: GCTurnIn")
        return
    end

    if Svc.ClientState.TerritoryType ~= SelectedZone.zoneId then
        if not SelectedZone or not SelectedZone.aetheryteList or #SelectedZone.aetheryteList == 0 then
            local msg = "ERROR: No aetheryte found for selected zone. Cannot teleport. Stopping script."
            yield("/echo [FATE] " .. msg)
            SendDiscordMessage(msg)
            SetStopReason(msg)
            StopScript = true
            return
        end
        local teleSuccess, attemptedNames = TeleportToSelectedZoneAetheryte()
        if teleSuccess == false then
            local attempted = table.concat(attemptedNames or {}, ", ")
            if attempted == "" then
                attempted = "none"
            end
            local msg = "ERROR: Teleportation failed for selected zone (attempted: " ..
                attempted .. "). Stopping script."
            yield("/echo [FATE] " .. msg)
            SendDiscordMessage(msg)
            SetStopReason(msg)
            StopScript = true
            return
        end
        Dalamud.Log("[FATE] Teleport Back to Farming Zone")
        return
    end

    if CurrentFate ~= nil and not IsFateActive(CurrentFate.fateObject) then
        CurrentFate = nil
    end
    local keepCurrentFate = false
    if CurrentFate ~= nil and IsFateActive(CurrentFate.fateObject) then
        local currentProgress = GetFateProgressValue(CurrentFate, nil)
        local progressInRange = currentProgress ~= nil and currentProgress > 0 and currentProgress < 100
        local startedButNotFinished = (CurrentFate.startTime or 0) > 0 and
            (currentProgress == nil or currentProgress < 100)
        keepCurrentFate = InActiveFate()
            or Svc.Condition[CharacterCondition.inCombat]
            or progressInRange
            or startedButNotFinished
    end
    if keepCurrentFate then
        NextFate = CurrentFate
    else
        local currentDistToFate = (CurrentFate ~= nil and CurrentFate.position ~= nil) and
            GetDistanceToPointFlat(CurrentFate.position) or math.maxinteger
        if currentDistToFate < 60 then
            keepCurrentFate = true
            NextFate = CurrentFate
        else
            NextFate = GetBestAvailableNextFate(true)
        end
    end

    if NextFate ~= nil then
        ResetBonusBuffHoldWindow()
    end

    if NextFate == nil then
        local shouldPreserveBonusBuffForSwitch = ShouldPreserveBonusBuffForZoneSwitch(true)
        local hasInstances = GetZoneInstance() > 0
        local canAutoSwitchZone = AutoTeleportToNextZone
            and not StayOnCurrentMapOnly
            and not shouldPreserveBonusBuffForSwitch
            and not CompanionScriptMode
        local preferFastZoneSwitch = canAutoSwitchZone and FastCombatPacing == true
        if preferFastZoneSwitch then
            local cooldown = FastNoFateZoneSwitchCooldownSeconds or 1.2
            local switchedRecently = ZoneSelectionLastSwitchAt ~= nil and
                (os.clock() - ZoneSelectionLastSwitchAt) < cooldown
            if not switchedRecently then
                Dalamud.Log("[FATE] No eligible fates. Fast pacing enabled, switching zone immediately.")
                SelectNextDawntrailZone()
                return
            end
        end
        if canAutoSwitchZone then
            if EnableChangeInstance and hasInstances and SuccessiveInstanceChanges < NumberOfInstances then
                State = CharacterState.changingInstances
                Dalamud.Log("[FATE] State Change: ChangingInstances")
                return
            end
            if not hasInstances or not EnableChangeInstance or SuccessiveInstanceChanges >= NumberOfInstances then
                SelectNextDawntrailZone()
                return
            end
        end
        if EnableChangeInstance and hasInstances and not shouldPreserveBonusBuffForSwitch then
            State = CharacterState.changingInstances
            Dalamud.Log("[FATE] State Change: ChangingInstances")
            return
        end
        if CompanionScriptMode and not shouldWaitForBonusBuff then
            if WaitingForFateRewards == nil then
                SetStopReason("Companion mode: no eligible fate and no pending rewards")
                StopScript = true
                Dalamud.Log("[FATE] StopScript: Ready")
            else
                Dalamud.Log("[FATE] Waiting for fate rewards")
            end
            return
        end
        if DownTimeWaitAtNearestAetheryte and (Svc.Targets.Target == nil or GetTargetName() ~= "aetheryte" or GetDistanceToTarget() > 20) then
            State = CharacterState.flyBackToAetheryte
            Dalamud.Log("[FATE] State Change: FlyBackToAetheryte")
            return
        end
        if MoveToRandomSpot then
            MoveToRandomNearbySpot(50, 75)
            yield("/wait " .. tostring(FastCombatPacing and 1 or 10))
        end
        return
    end


    if NextFate == nil and ShouldPreserveBonusBuffForZoneSwitch(true) and DownTimeWaitAtNearestAetheryte then
        if Svc.Targets.Target == nil or GetTargetName() ~= "aetheryte" or GetDistanceToTarget() > 20 then
            State = CharacterState.flyBackToAetheryte
            Dalamud.Log("[FATE] State Change: FlyBackToAetheryte")
        else
            yield("/wait " .. tostring(FastCombatPacing and 1 or 10))
        end
        return
    end

    if CompanionScriptMode and DidFate and not shouldWaitForBonusBuff then
        if WaitingForFateRewards == nil then
            SetStopReason("Companion mode: finished one fate")
            StopScript = true
            Dalamud.Log("[FATE] StopScript: DidFate")
        else
            Dalamud.Log("[FATE] Waiting for fate rewards")
        end
        return
    end

    local lp = (ClientState ~= nil and ClientState.LocalPlayer) or
        (Svc ~= nil and Svc.ClientState ~= nil and Svc.ClientState.LocalPlayer) or
        (Player ~= nil and Player.Available == true and Player)
    if lp == nil or type(lp) ~= "table" then
        return
    end

    CurrentFate = NextFate
    ResetNoCombatRecoveryState()
    ResetMeleeEngageRecoveryState()
    ResetPreAcquireState()
    ResetDynamicAoeSwitchState()
    ResetMiddleDismountState()
    ResetTargetAcquireWatchdog()
    if PrefetchedNextFateId ~= nil and CurrentFate ~= nil and PrefetchedNextFateId == CurrentFate.fateId then
        PrefetchedNextFateId = nil
        PrefetchedNextFateAt = 0
    end
    HasFlownUpYet = false
    local mappedPosition = GetPreferredFateMovePosition(CurrentFate) or CurrentFate.position
    SetMapFlag(SelectedZone.zoneId, mappedPosition)
    State = CharacterState.moveToFate
    local fateDisplayName = (CurrentFate ~= nil and CurrentFate.fateName ~= nil) and CurrentFate.fateName
        or ("FATE #" .. tostring(CurrentFate and CurrentFate.fateId or 0))
    Dalamud.Log("[FATE] State Change: MovingtoFate " .. fateDisplayName)
    yield("/echo [FATE] Moving to: " .. fateDisplayName)
end

function HandleDeath()
    CurrentFate = nil
    ResetTargetAcquireWatchdog()

    if CombatModsOn then
        TurnOffCombatMods()
    end

    if IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning() then
        SafeYield("/vnav stop")
    end

    if Svc.Condition[CharacterCondition.dead] then --Condition Dead
        if ReturnOnDeath then
            if Echo and not DeathAnnouncementLock then
                DeathAnnouncementLock = true
                if Echo == "all" then
                    yield("/echo [FATE] You have died. Returning to home aetheryte.")
                end
            end

            if AddonReady("SelectYesno") then --rez addon yes
                SafeYield("/callback SelectYesno true 0")
                yield("/wait 0.1")
            end
        else
            if Echo and not DeathAnnouncementLock then
                DeathAnnouncementLock = true
                if Echo == "all" then
                    yield("/echo [FATE] You have died. Waiting until script detects you're alive again...")
                end
            end
            yield("/wait 1")
        end
    else
        State = CharacterState.ready
        Dalamud.Log("[FATE] State Change: Ready")
        DeathAnnouncementLock = false
        HasFlownUpYet = false
    end
end

function ResetNoCombatRecoveryState()
    NoCombatStartTime = nil
    NoCombatRecoveryStage = 0
    NoCombatRecoveryFateId = nil
    NoCombatRecoveryLastActionAt = 0
    NoCombatNoTargetSince = 0
end

function ResetMeleeEngageRecoveryState()
    MeleeEngageTargetSignature = nil
    MeleeEngageStartAt = 0
    MeleeEngageLastMoveAt = 0
    MeleeEngageNextRetargetAt = 0
    MeleeEngageLastHardRecoverAt = 0
end

function ResetPreAcquireState()
    PreAcquireFateId = nil
    PreAcquireLastAttemptAt = 0
end

function ResetDynamicAoeSwitchState()
    DynamicAoeDecisionMode = nil
    DynamicAoeDecisionCount = 0
    DynamicAoeLastSwitchAt = 0
end

function ResetMiddleDismountState()
    MiddleDismountFateId = nil
    MiddleDismountStartedAt = 0
    MiddleDismountNoTargetSince = 0
end

function ResetTargetAcquireWatchdog()
    TargetAcquireNoTargetSince = 0
    TargetAcquireLastAttemptAt = 0
    CombatOpenTargetSignature = nil
    CombatOpenTargetSince = 0
    CombatOpenLastPulseAt = 0
    CombatOpenLastActionAt = 0
    CombatOpenActionSequence = 0
end

function ResetMovementStuckState()
    MoveStuckLastCheckTime = 0
    MoveStuckLastPosition = nil
    MoveStuckCount = 0
    MoveStuckLastDistanceToTarget = nil
end

function IsSolutionNineZone()
    return Svc.ClientState.TerritoryType == 1186
end

function HandleMovementStuck(targetPosition)
    if EnableStagedAntiStuck ~= true then
        return false
    end

    if not (IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning()) then
        ResetMovementStuckState()
        return false
    end

    local isSolutionNine = IsSolutionNineZone()
    local stuckCheckInterval = isSolutionNine and 5 or StuckCheckIntervalSeconds
    local stuckThreshold = isSolutionNine and 2 or StuckMovementThreshold

    local now = os.clock()
    if now - MoveStuckLastCheckTime < stuckCheckInterval then
        return false
    end
    MoveStuckLastCheckTime = now

    local playerPos = GetLocalPlayerPosition()
    if playerPos == nil then
        return false
    end

    local effectiveTarget = targetPosition
    if effectiveTarget == nil and CurrentFate ~= nil then
        effectiveTarget = GetPreferredFateMovePosition(CurrentFate) or CurrentFate.position
    end

    local distanceToTarget = nil
    if effectiveTarget ~= nil then
        distanceToTarget = DistanceBetweenFlat(playerPos, effectiveTarget)
        if distanceToTarget <= math.max(5, stuckThreshold * 1.5) then
            MoveStuckCount = 0
            MoveStuckLastPosition = playerPos
            MoveStuckLastDistanceToTarget = distanceToTarget
            return false
        end
    end

    local movedEnough = true
    local horizontalDistance = 0
    local verticalDistance = 0
    if MoveStuckLastPosition ~= nil then
        horizontalDistance = DistanceBetweenFlat(playerPos, MoveStuckLastPosition)
        verticalDistance = math.abs(playerPos.Y - MoveStuckLastPosition.Y)
        movedEnough = horizontalDistance >= stuckThreshold
    end

    -- Detect Z-axis only movement (e.g. hopping against a wall or floating in place).
    -- This is usually not real progress, so treat it as stuck and skip the gentle
    -- sidestep recovery, going straight to teleport/zoneswitch.
    local zAxisOnlyMovement = (MoveStuckLastPosition ~= nil)
        and (horizontalDistance < stuckThreshold)
        and (verticalDistance > stuckThreshold * 1.5)

    local madeTargetProgress = false
    if distanceToTarget ~= nil and MoveStuckLastDistanceToTarget ~= nil then
        madeTargetProgress = (MoveStuckLastDistanceToTarget - distanceToTarget) >=
            math.max(0.8, stuckThreshold * 0.25)
    end

    if movedEnough or madeTargetProgress then
        MoveStuckCount = 0
        MoveStuckLastPosition = playerPos
        MoveStuckLastDistanceToTarget = distanceToTarget
        return false
    end

    MoveStuckCount = MoveStuckCount + 1
    if zAxisOnlyMovement then
        Dalamud.Log("[FATE] Z-axis only movement detected. Accelerating stuck recovery.")
        MoveStuckCount = math.max(MoveStuckCount, 2)
    end
    Dalamud.Log("[FATE] Movement stuck detected. Stage #" .. tostring(MoveStuckCount) .. (isSolutionNine and " (Solution Nine)" or ""))

    SafeYield("/vnav stop")
    yield("/wait 0.2")

    if MoveStuckCount == 1 then
        local sidestepTarget = RandomAdjustCoordinates(playerPos, 8)
        local sidestepFloor = IPC.vnavmesh.PointOnFloor(sidestepTarget, true, 20)
        if sidestepFloor ~= nil then
            IPC.vnavmesh.PathfindAndMoveTo(sidestepFloor, Player.CanFly and SelectedZone.flying)
            yield("/wait 0.35")
            SafeYield("/vnav stop")
            yield("/wait 0.15")
        end

        local retryTarget = targetPosition
        if retryTarget == nil and CurrentFate ~= nil then
            retryTarget = GetPreferredFateMovePosition(CurrentFate) or CurrentFate.position
        end
        if retryTarget == nil then
            retryTarget = playerPos
        end
        local nearestFloor = IPC.vnavmesh.PointOnFloor(retryTarget, true, 30)
        if nearestFloor ~= nil then
            retryTarget = nearestFloor
        end
        IPC.vnavmesh.PathfindAndMoveTo(retryTarget, Player.CanFly and SelectedZone.flying)
        SessionStuckRepathCount = SessionStuckRepathCount + 1
    elseif MoveStuckCount == 2 then
        if isSolutionNine then
            local closestAetheryte = GetClosestAetheryteInZoneToPoint(Svc.ClientState.TerritoryType, playerPos)
            if closestAetheryte ~= nil then
                local teleported = TeleportTo(closestAetheryte.name)
                if teleported ~= false then
                    SessionStuckAetheryteCount = SessionStuckAetheryteCount + 1
                    Dalamud.Log("[FATE] Solution Nine: Teleported to aetheryte after stuck")
                end
            end
        else
            local closestAetheryte = GetClosestAetheryteInZoneToPoint(Svc.ClientState.TerritoryType, playerPos)
            if closestAetheryte ~= nil then
                local teleported = TeleportTo(closestAetheryte.name)
                if teleported ~= false then
                    SessionStuckAetheryteCount = SessionStuckAetheryteCount + 1
                end
            end
        end
        CurrentFate = nil
        NextFate = nil
        State = CharacterState.ready
    else
        if not StayOnCurrentMapOnly then
            SelectNextDawntrailZone()
            SessionStuckZoneSwitchCount = SessionStuckZoneSwitchCount + 1
        else
            CurrentFate = nil
            NextFate = nil
        end
        State = CharacterState.ready
        ResetMovementStuckState()
    end

    MoveStuckLastPosition = playerPos
    MoveStuckLastDistanceToTarget = distanceToTarget
    return true
end

function ResetExchangeMovementStuckState()
    ExchangeMoveLastCheckTime = 0
    ExchangeMoveLastPosition = nil
    ExchangeMoveStuckCount = 0
    ExchangeMoveLastDistanceToShop = nil
    ExchangeMoveGraceUntil = 0
end

function SetExchangeMovementStuckGrace(seconds)
    local graceSeconds = tonumber(seconds) or 0
    if graceSeconds < 0 then
        graceSeconds = 0
    end
    ExchangeMoveGraceUntil = os.clock() + graceSeconds
    ExchangeMoveLastCheckTime = 0
    ExchangeMoveLastPosition = GetLocalPlayerPosition()
    ExchangeMoveStuckCount = 0
    ExchangeMoveLastDistanceToShop = nil
end

function HandleExchangeMovementStuck()
    if not (IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning()) then
        return
    end

    local isSolutionNineRoute = SelectedBicolorExchangeData ~= nil
        and SelectedBicolorExchangeData.zoneId == 1186
        and Svc.ClientState.TerritoryType == 1186
    local stuckCheckInterval = isSolutionNineRoute and 3 or 3
    local stuckMoveThreshold = isSolutionNineRoute and 0.5 or 1.5
    local shopProgressThreshold = isSolutionNineRoute and 0.3 or 0.8
    local repathSpread = isSolutionNineRoute and 10 or 3
    local maxRepathAttempts = isSolutionNineRoute and 2 or 5

    local now = os.clock()
    if now - ExchangeMoveLastCheckTime < stuckCheckInterval then
        return
    end
    ExchangeMoveLastCheckTime = now

    local playerPos = GetLocalPlayerPosition()
    if playerPos == nil then
        return
    end

    local distanceToShop = GetDistanceToPoint(SelectedBicolorExchangeData.position)
    if ExchangeMoveGraceUntil ~= nil and now < ExchangeMoveGraceUntil then
        ExchangeMoveLastPosition = playerPos
        ExchangeMoveLastDistanceToShop = distanceToShop
        return
    end

    local movedDistance = math.maxinteger
    if ExchangeMoveLastPosition ~= nil then
        movedDistance = DistanceBetween(playerPos, ExchangeMoveLastPosition)
    end

    local madeShopProgress = false
    if ExchangeMoveLastDistanceToShop ~= nil then
        madeShopProgress = (ExchangeMoveLastDistanceToShop - distanceToShop) >= shopProgressThreshold
    end

    if ExchangeMoveLastPosition ~= nil and movedDistance < stuckMoveThreshold and not madeShopProgress then
        ExchangeMoveStuckCount = ExchangeMoveStuckCount + 1
        Dalamud.Log("[FATE] Exchange pathing stuck. Repath attempt #" .. tostring(ExchangeMoveStuckCount))
        SafeYield("/vnav stop")
        yield("/wait 0.3")

        local retryTarget
        if isSolutionNineRoute then
            retryTarget = SelectedBicolorExchangeData.position
        else
            retryTarget = RandomAdjustCoordinates(SelectedBicolorExchangeData.position, repathSpread)
        end
        local nearestFloor = IPC.vnavmesh.PointOnFloor(retryTarget, true, 30)
        if nearestFloor ~= nil then
            retryTarget = nearestFloor
        else
            retryTarget = SelectedBicolorExchangeData.position
        end
        IPC.vnavmesh.PathfindAndMoveTo(retryTarget, false)

        if ExchangeMoveStuckCount >= maxRepathAttempts then
            Dalamud.Log("[FATE] Exchange pathing still stuck. Returning to aetheryte and retrying.")
            SafeYield("/vnav stop")
            ResetExchangeMovementStuckState()
            SetExchangeMovementStuckGrace(15)
            if SelectedBicolorExchangeData.miniAethernet ~= nil then
                local movedByMiniAetheryte = TryLocalAetheryteShortcut(SelectedBicolorExchangeData.miniAethernet.name)
                if not movedByMiniAetheryte then
                    Dalamud.Log("[FATE] Mini aetheryte shortcut failed. Disabling it for this session.")
                    SelectedBicolorExchangeData.miniAethernet = nil
                    TeleportTo(SelectedBicolorExchangeData.aetheryteName)
                end
            else
                TeleportTo(SelectedBicolorExchangeData.aetheryteName)
            end
            return
        end
    else
        ExchangeMoveStuckCount = 0
    end

    ExchangeMoveLastPosition = playerPos
    ExchangeMoveLastDistanceToShop = distanceToShop
end

function ExecuteBicolorExchange()
    CurrentFate = nil

    if BicolorGemCount >= BicolorGemExchangeThreshold then
        if AddonReady("SelectYesno") then
            SafeYield("/callback SelectYesno true 0")
            return
        end

        if AddonReady("ShopExchangeCurrency") then
            SafeYield("/callback ShopExchangeCurrency false 0 " ..
                SelectedBicolorExchangeData.item.itemIndex .. " " ..
                (BicolorGemCount // SelectedBicolorExchangeData.item.price))
            return
        end

        if Svc.ClientState.TerritoryType ~= SelectedBicolorExchangeData.zoneId then
            ResetExchangeMovementStuckState()
            SetExchangeMovementStuckGrace(20)
            TeleportTo(SelectedBicolorExchangeData.aetheryteName)
            return
        end

        if SelectedBicolorExchangeData.miniAethernet ~= nil then
            local distanceToShop = GetDistanceToPoint(SelectedBicolorExchangeData.position)
            local miniToShopDistance = DistanceBetween(
                SelectedBicolorExchangeData.miniAethernet.position,
                SelectedBicolorExchangeData.position
            )
            local shouldUseMiniAethernet = distanceToShop > (miniToShopDistance + 10)
            local solutionNineThreshold = 25
            if SelectedBicolorExchangeData.zoneId == 1186 and distanceToShop > solutionNineThreshold then
                shouldUseMiniAethernet = true
            end
            if shouldUseMiniAethernet then
                Dalamud.Log("[FATE] Exchange route: using aetheryte first, then pathfinding.")
                ResetExchangeMovementStuckState()
                SetExchangeMovementStuckGrace(15)
                local movedByMiniAetheryte = TryLocalAetheryteShortcut(SelectedBicolorExchangeData.miniAethernet.name)
                if not movedByMiniAetheryte then
                    Dalamud.Log("[FATE] Mini aetheryte shortcut failed. Disabling it for this session.")
                    SelectedBicolorExchangeData.miniAethernet = nil
                end
                return
            end
        end

        if AddonReady("TelepotTown") then
            Dalamud.Log("TelepotTown open")
            SafeYield("/callback TelepotTown false -1")
        elseif GetDistanceToPoint(SelectedBicolorExchangeData.position) > 5 then
            Dalamud.Log("Distance to shopkeep is too far. Calculating route from current position.")
            if not (IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning()) then
                local flyOk, canFly = pcall(function()
                    return Player.CanFly and SelectedZone ~= nil and SelectedZone.flying
                end)
                IPC.vnavmesh.PathfindAndMoveTo(SelectedBicolorExchangeData.position, flyOk and canFly)
            end
            HandleExchangeMovementStuck()
        else
            ResetExchangeMovementStuckState()
            Dalamud.Log("[FATE] Arrived at Shopkeep")
            if IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning() then
                SafeYield("/vnav stop")
            end

            if Svc.Targets.Target == nil or GetTargetName() ~= SelectedBicolorExchangeData.shopKeepName then
                SafeYield("/target " .. SelectedBicolorExchangeData.shopKeepName)
                yield("/wait 0.5")
            elseif not Svc.Condition[CharacterCondition.occupiedInQuestEvent] then
                yield("/interact")
            end
        end
    else
        ResetExchangeMovementStuckState()
        if AddonReady("ShopExchangeCurrency") then
            Dalamud.Log("[FATE] Attemping to close shop window")
            SafeYield("/callback ShopExchangeCurrency true -1")
            return
        elseif Svc.Condition[CharacterCondition.occupiedInEvent] then
            Dalamud.Log("[FATE] Character still occupied talking to shopkeeper")
            yield("/wait 0.5")
            return
        end

        State = CharacterState.ready
        Dalamud.Log("[FATE] State Change: Ready")
    end
end

function ProcessRetainers()
    CurrentFate = nil

    Dalamud.Log("[FATE] Handling retainers...")
    if ARRetainersWaitingToBeProcessed() and Inventory.GetFreeInventorySlots() > 1 then
        if IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning() then
            return
        end

        if Svc.ClientState.TerritoryType ~= 129 then
            SafeYield("/vnav stop")
            TeleportTo("Limsa Lominsa Lower Decks")
            return
        end

        local summoningBell = {
            name = "Summoning Bell",
            position = Vector3(-122.72, 18.00, 20.39)
        }
        if GetDistanceToPoint(summoningBell.position) > 4.5 then
            IPC.vnavmesh.PathfindAndMoveTo(summoningBell.position, false)
            return
        end

        if Svc.Targets.Target == nil or GetTargetName() ~= summoningBell.name then
            SafeYield("/target " .. summoningBell.name)
            return
        end

        if not Svc.Condition[CharacterCondition.occupiedSummoningBell] then
            yield("/interact")
            if AddonReady("RetainerList") then
                yield("/ays e")
                if Echo == "all" then
                    yield("/echo [FATE] Processing retainers")
                end
                yield("/wait 1")
            end
        end
    else
        if AddonReady("RetainerList") then
            SafeYield("/callback RetainerList true -1")
        elseif not Svc.Condition[CharacterCondition.occupiedSummoningBell] then
            State = CharacterState.ready
            Dalamud.Log("[FATE] State Change: Ready")
        end
    end
end

function GrandCompanyTurnIn()
    if Inventory.GetFreeInventorySlots() <= InventorySlotsLeft then
        if IPC.Lifestream and IPC.Lifestream.ExecuteCommand then
            IPC.Lifestream.ExecuteCommand("gc")
            Dalamud.Log("[FATE] Executed Lifestream teleport to GC.")
        else
            yield("/echo [FATE] Lifestream IPC not available! Cannot teleport to GC.")
            return
        end
        yield("/wait 1")
        while IsLifestreamBusySafe()
            or Svc.Condition[CharacterCondition.betweenAreas] do
            yield("/wait 0.5")
        end
        Dalamud.Log("[FATE] Lifestream complete, standing at GC NPC.")
        if IPC.AutoRetainer and IPC.AutoRetainer.EnqueueInitiation then
            IPC.AutoRetainer.EnqueueInitiation()
            Dalamud.Log("[FATE] Called AutoRetainer.EnqueueInitiation() for GC handin.")
        else
            yield("/echo [FATE] AutoRetainer IPC not available! Cannot process GC turnin.")
        end
    else
        State = CharacterState.ready
        Dalamud.Log("State Change: Ready")
    end
end

function Repair()
    local needsRepair = Inventory.GetItemsInNeedOfRepairs(RemainingDurabilityToRepair)
    local needsRepairCount = 0
    if needsRepair ~= nil then
        -- Try direct property access first (works for C# List<> and arrays in NLua)
        local count = needsRepair.Count
        if type(count) == "number" then
            needsRepairCount = count
        else
            -- Fallback for plain Lua tables or arrays
            local len = #needsRepair
            if type(len) == "number" then
                needsRepairCount = len
            end
        end
    end
    Dalamud.Log("[FATE] Repair check: needsRepairCount=" ..
    tostring(needsRepairCount) ..
    ", type=" ..
    type(needsRepair) ..
    ", SelfRepair=" .. tostring(SelfRepair) .. ", DarkMatter=" .. tostring(Inventory.GetItemCount(33916)))

    if AddonReady("SelectYesno") then
        SafeYield("/callback SelectYesno true 0")
        return
    end

    if AddonReady("SelectIconString") then
        SafeYield("/callback SelectIconString true 0")
        return
    end

    if AddonReady("SelectString") then
        SafeYield("/callback SelectString true 0")
        return
    end

    if AddonReady("Repair") then
        if needsRepairCount == 0 then
            SafeYield("/callback Repair true -1") -- if you dont need repair anymore, close the menu
        else
            SafeYield("/callback Repair true 0")  -- select repair
        end
        return
    end

    -- if occupied by repair, then just wait
    if Svc.Condition[CharacterCondition.occupiedMateriaExtractionAndRepair] then
        Dalamud.Log("[FATE] Repairing...")
        yield("/wait 1")
        return
    end

    local hawkersAlleyAethernetShard = { position = Vector3(-213.95, 15.99, 49.35) }
    if SelfRepair then
        if Inventory.GetItemCount(33916) > 0 and needsRepairCount > 0 then
            if AddonReady("Shop") then
                SafeYield("/callback Shop true -1")
                return
            end

            -- Self-repair can be done anywhere; no need to teleport back to farming zone
            if Svc.Condition[CharacterCondition.mounted] then
                Dismount()
                Dalamud.Log("[FATE] State Change: Dismounting")
                return
            end

            if not AddonReady("Repair") then
                Dalamud.Log("[FATE] Opening repair menu...")
                yield("/generalaction " .. LANG.actions["repair"])
            end
        elseif (needsRepairCount > 0 and ShouldAutoBuyDarkMatter) or NeedsGysahlGreens then
            if Inventory.GetItemCount(4868) > 0 then
                NeedsGysahlGreens = false
            end
            if Svc.ClientState.TerritoryType ~= 129 then
                if Echo == "all" then
                    local itemType = NeedsGysahlGreens and "Gysahl Greens" or "Dark Matter"
                    yield("/echo Out of " .. itemType .. "! Purchasing more from Limsa Lominsa.")
                end
                TeleportTo("Limsa Lominsa Lower Decks")
                return
            end

            local vendor = NeedsGysahlGreens
                and { npcName = "Bango Zango", position = Vector3(-242.45, 16.19, 41.69), wait = 0.08 }
                or { npcName = "Unsynrael", position = Vector3(-257.71, 16.19, 50.11), wait = 0.08 }

            if GetDistanceToPoint(vendor.position) > (DistanceBetween(hawkersAlleyAethernetShard.position, vendor.position) + 10) then
                if not TryLocalAetheryteShortcut("Hawkers' Alley") then
                    Dalamud.Log("[FATE] Hawkers' Alley aethernet shortcut failed. Walking to vendor.")
                end
            elseif AddonReady("TelepotTown") then
                SafeYield("/callback TelepotTown false -1")
            elseif GetDistanceToPoint(vendor.position) > 5 then
                if not (IPC.vnavmesh.IsRunning() or IPC.vnavmesh.PathfindInProgress()) then
                    IPC.vnavmesh.PathfindAndMoveTo(vendor.position, false)
                end
            else
                if Svc.Targets.Target == nil or GetTargetName() ~= vendor.npcName then
                    SafeYield("/target " .. vendor.npcName)
                elseif not Svc.Condition[CharacterCondition.occupiedInQuestEvent] then
                    yield("/interact")
                elseif AddonReady("SelectYesno") then
                    SafeYield("/callback SelectYesno true 0")
                elseif Addons.GetAddon("Shop") then
                    if NeedsGysahlGreens then
                        SafeYield("/callback Shop true 0 0 99")  -- Buying Gysahl Greens (assuming index 0)
                    else
                        SafeYield("/callback Shop true 0 40 99") -- Buying Dark Matter
                    end
                end
            end
        else
            if Echo == "all" then
                yield(
                "/echo [FATE] Self-repair unavailable (no dark matter or no items to repair). Falling back to Limsa mender.")
            end
            -- Do NOT overwrite SelfRepair globally; just fall back to NPC mender for this cycle
            if needsRepairCount > 0 then
                if Svc.ClientState.TerritoryType ~= 129 then
                    TeleportTo("Limsa Lominsa Lower Decks")
                    return
                end

                local mender = { npcName = "Alistair", position = Vector3(-246.87, 16.19, 49.83) }
                if GetDistanceToPoint(mender.position) > (DistanceBetween(hawkersAlleyAethernetShard.position, mender.position) + 10) then
                    if not TryLocalAetheryteShortcut("Hawkers' Alley") then
                        Dalamud.Log("[FATE] Hawkers' Alley aethernet shortcut failed. Walking to mender.")
                    end
                elseif AddonReady("TelepotTown") then
                    SafeYield("/callback TelepotTown false -1")
                elseif GetDistanceToPoint(mender.position) > 5 then
                    if not (IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning()) then
                        IPC.vnavmesh.PathfindAndMoveTo(mender.position, false)
                    end
                else
                    if Svc.Targets.Target == nil or GetTargetName() ~= mender.npcName then
                        SafeYield("/target " .. mender.npcName)
                    elseif not Svc.Condition[CharacterCondition.occupiedInQuestEvent] then
                        yield("/interact")
                    end
                end
            else
                State = CharacterState.ready
                Dalamud.Log("[FATE] State Change: Ready")
            end
        end
    else
        if needsRepairCount > 0 then
            if Svc.ClientState.TerritoryType ~= 129 then
                TeleportTo("Limsa Lominsa Lower Decks")
                return
            end

            local mender = { npcName = "Alistair", position = Vector3(-246.87, 16.19, 49.83) }
            if GetDistanceToPoint(mender.position) > (DistanceBetween(hawkersAlleyAethernetShard.position, mender.position) + 10) then
                if not TryLocalAetheryteShortcut("Hawkers' Alley") then
                    Dalamud.Log("[FATE] Hawkers' Alley aethernet shortcut failed. Walking to mender.")
                end
            elseif AddonReady("TelepotTown") then
                SafeYield("/callback TelepotTown false -1")
            elseif GetDistanceToPoint(mender.position) > 5 then
                if not (IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning()) then
                    IPC.vnavmesh.PathfindAndMoveTo(mender.position, false)
                end
            else
                if Svc.Targets.Target == nil or GetTargetName() ~= mender.npcName then
                    SafeYield("/target " .. mender.npcName)
                elseif not Svc.Condition[CharacterCondition.occupiedInQuestEvent] then
                    yield("/interact")
                end
            end
        else
            State = CharacterState.ready
            Dalamud.Log("[FATE] State Change: Ready")
        end
    end
end

function ExtractMateria()
    if Svc.Condition[CharacterCondition.mounted] then
        Dismount()
        Dalamud.Log("[FATE] State Change: Dismounting")
        return
    end

    if Svc.Condition[CharacterCondition.occupiedMateriaExtractionAndRepair] then
        return
    end

    if Inventory.GetSpiritbondedItems().Count > 0 and Inventory.GetFreeInventorySlots() > 1 then
        if not AddonReady("Materialize") then
            yield("/generalaction \"" .. LANG.actions["extract materia"] .. "\"")
            yield("/wait .25")
            return
        end

        Dalamud.Log("[FATE] Extracting materia...")

        if AddonReady("MaterializeDialog") then
            SafeYield("/callback MaterializeDialog true 0")
            yield("/wait .25")
        else
            SafeYield("/callback Materialize true 2 0")
            yield("/wait .25")
        end
    else
        if AddonReady("Materialize") then
            SafeYield("/callback Materialize true -1")
            yield("/wait .25")
        else
            State = CharacterState.ready
            Dalamud.Log("[FATE] State Change: Ready")
        end
    end
end

--#endregion State Transition Functions

--#region Misc Functions

function EorzeaTimeToUnixTime(eorzeaTime)
    return eorzeaTime / (144 / 7) -- 24h Eorzea Time equals 70min IRL
end

function HasStatusId(statusId)
    local lp = (ClientState ~= nil and ClientState.LocalPlayer) or
        (Svc ~= nil and Svc.ClientState ~= nil and Svc.ClientState.LocalPlayer) or
        (Player ~= nil and Player.Available == true and Player)
    if lp == nil or type(lp) ~= "table" then
        return false
    end
    local statusList = lp.StatusList
    if statusList == nil then
        return false
    end
    for i = 0, statusList.Length - 1 do
        if statusList[i].StatusId == statusId then
            return true
        end
    end
    return false
end

function HasTwistOfFateBuff()
    return HasStatusId(1288) or HasStatusId(1289)
end

function TankStanceCheck()
    -- Never adjust stance during active combat to avoid toggle flicker.
    if Svc.Condition[CharacterCondition.inCombat] then
        return
    end

    local lp = (ClientState ~= nil and ClientState.LocalPlayer) or
        (Svc ~= nil and Svc.ClientState ~= nil and Svc.ClientState.LocalPlayer) or
        (Player ~= nil and Player.Available == true and Player)
    if lp == nil or type(lp) ~= "table" then return end

    local jobId = nil
    -- Use direct access (same pattern as GetCombatOpenActionCandidates in this script)
    if Player ~= nil and Player.Job ~= nil then
        jobId = Player.Job.Id
    end
    -- Fallback: try Svc.ClientState.LocalPlayer.ClassJob.RowId
    if jobId == nil then
        local jobOk, job = pcall(function() return lp.ClassJob end)
        if jobOk and job ~= nil then
            local rowOk, rowId = pcall(function() return job.RowId end)
            if rowOk and rowId ~= nil then jobId = rowId end
        end
    end
    if jobId == nil then return end

    local isTank = false
    for _, classData in pairs(ClassList) do
        if classData.classId == jobId and classData.isTank then
            isTank = true
            break
        end
    end
    if not isTank then return end

    local stanceSkill = nil
    local stanceStatusId = nil
    if jobId == ClassList.pld.classId then
        stanceSkill = LANG.actions["Iron Will"]
        stanceStatusId = 79
    elseif jobId == ClassList.war.classId then
        stanceSkill = LANG.actions["Defiance"]
        stanceStatusId = 91
    elseif jobId == ClassList.drk.classId then
        stanceSkill = LANG.actions["Grit"]
        stanceStatusId = 743
    elseif jobId == ClassList.gnb.classId then
        stanceSkill = LANG.actions["Royal Guard"]
        stanceStatusId = 1833
    end

    if stanceSkill == nil or stanceStatusId == nil then return end

    -- Tank stances are toggles: casting while active removes them.
    -- Keep this check lightweight: one quick re-check is enough to avoid a
    -- stale read, and we only act once per fate to prevent combat flicker.
    local function StanceIsActive()
        return HasStatusId(stanceStatusId)
    end

    if StanceIsActive() then
        return
    end

    if TankStanceAcAttemptedForFate ~= nil and CurrentFate ~= nil
        and TankStanceAcAttemptedForFate == CurrentFate.fateId then
        return
    end

    yield("/wait 0.1")
    if StanceIsActive() then
        return
    end

    if CurrentFate ~= nil then
        TankStanceAcAttemptedForFate = CurrentFate.fateId
    end

    Dalamud.Log("[FATE] Tank stance missing (" .. tostring(stanceSkill) .. "), activating.")
    local cmd = "/ac \"" .. tostring(stanceSkill) .. "\""
    local ok = pcall(function() yield(cmd) end)
    if not ok then
        Dalamud.Log("[FATE] Tank stance /ac command failed (possibly invalid action name or wrong job). Skipping.")
        return
    end
    yield("/wait 0.5")

    if StanceIsActive() then
        Dalamud.Log("[FATE] Tank stance activated for fate #" .. tostring(CurrentFate and CurrentFate.fateId) .. ".")
    else
        Dalamud.Log("[FATE] Tank stance not detected after /ac; will not retry this fate.")
    end
end

function ResetBonusBuffHoldWindow()
    BonusBuffNoEligibleSince = 0
    BonusBuffHoldWindowExpiredAnnounced = false
end

function ShouldPreserveBonusBuffForZoneSwitch(markNoEligible)
    if WaitIfBonusBuff ~= true or not HasTwistOfFateBuff() then
        ResetBonusBuffHoldWindow()
        return false
    end

    local now = os.clock()
    if markNoEligible == true then
        if (BonusBuffNoEligibleSince or 0) <= 0 then
            BonusBuffNoEligibleSince = now
            BonusBuffHoldWindowExpiredAnnounced = false
        end
    elseif (BonusBuffNoEligibleSince or 0) <= 0 then
        return true
    end

    local holdWindow = BonusBuffHoldMaxWaitSeconds or 35
    local startedAt = BonusBuffNoEligibleSince or 0
    if startedAt <= 0 then
        return true
    end

    local elapsed = now - startedAt
    if elapsed <= holdWindow then
        return true
    end

    if BonusBuffHoldWindowExpiredAnnounced ~= true then
        Dalamud.Log(string.format(
            "[FATE] Twist of Fate hold window elapsed (%.1fs >= %.1fs). Allowing zone switch.",
            elapsed,
            holdWindow
        ))
        BonusBuffHoldWindowExpiredAnnounced = true
    end

    return false
end

local function TrimString(value)
    if value == nil then
        return ""
    end
    local trimmed = tostring(value)
    trimmed = trimmed:gsub("^%s+", "")
    trimmed = trimmed:gsub("%s+$", "")
    return trimmed
end

local function BuildConsumableItemCommand(rawItemName)
    local itemName = TrimString(rawItemName)
    if itemName == "" then
        return nil
    end

    local lowerName = string.lower(itemName)
    local isHq = #lowerName >= 4 and lowerName:sub(-4) == "<hq>"
    if isHq then
        itemName = TrimString(itemName:sub(1, #itemName - 4))
    end

    if itemName == "" then
        return nil
    end

    itemName = itemName:gsub('"', "")
    if isHq then
        return string.format('/item "%s" <hq>', itemName)
    end
    return string.format('/item "%s"', itemName)
end

function IsLifestreamBusySafe()
    if IPC ~= nil and IPC.Lifestream ~= nil and type(IPC.Lifestream.IsBusy) == "function" then
        local ok, busy = pcall(function()
            return IPC.Lifestream.IsBusy()
        end)
        if ok then
            return busy == true
        end
    end
    if not LifestreamBusyWarned then
        LifestreamBusyWarned = true
        Dalamud.Log("[FATE] Lifestream IPC.IsBusy unavailable. Continuing with busy=false.")
    end
    return false
end

function ValidateRequiredIpc()
    local vnav = IPC and IPC.vnavmesh or nil
    if vnav == nil then
        return false, "vnavmesh IPC is missing"
    end

    local requiredMethods = {
        "IsRunning",
        "PathfindInProgress",
        "PathfindAndMoveTo",
        "PointOnFloor"
    }
    for _, methodName in ipairs(requiredMethods) do
        if vnav[methodName] == nil then
            return false, "vnavmesh IPC method missing: " .. methodName
        end
    end

    local okIsRunning = pcall(function()
        return vnav.IsRunning()
    end)
    if not okIsRunning then
        return false, "vnavmesh IPC method not callable: IsRunning"
    end

    local okPathfindInProgress = pcall(function()
        return vnav.PathfindInProgress()
    end)
    if not okPathfindInProgress then
        return false, "vnavmesh IPC method not callable: PathfindInProgress"
    end

    return true, nil
end

function IsVnavmeshReadySafe()
    if IPC == nil or IPC.vnavmesh == nil then
        return false
    end
    if IPC.vnavmesh.IsReady == nil then
        if not VnavReadyCheckWarned then
            VnavReadyCheckWarned = true
            Dalamud.Log("[FATE] vnavmesh IPC does not expose IsReady(); skipping readiness wait.")
        end
        return true
    end
    local ok, ready = pcall(function()
        return IPC.vnavmesh.IsReady()
    end)
    return ok and ready == true
end

function IsVnavmeshMovingSafe()
    if IPC == nil or IPC.vnavmesh == nil then
        return false
    end
    local running = false
    local pathfinding = false
    local okRunning, runningValue = pcall(function()
        return IPC.vnavmesh.IsRunning()
    end)
    if okRunning then
        running = runningValue == true
    end
    local okPathfinding, pathfindingValue = pcall(function()
        return IPC.vnavmesh.PathfindInProgress()
    end)
    if okPathfinding then
        pathfinding = pathfindingValue == true
    end
    return running or pathfinding
end

CanUseConsumableNow = function()
    local lp = (ClientState ~= nil and ClientState.LocalPlayer) or
        (Svc ~= nil and Svc.ClientState ~= nil and Svc.ClientState.LocalPlayer) or
        (Player ~= nil and Player.Available == true and Player)
    if lp == nil or type(lp) ~= "table" then
        return false
    end
    if Svc.Condition[CharacterCondition.dead]
        or Svc.Condition[CharacterCondition.inCombat]
        or Svc.Condition[CharacterCondition.casting]
        or Svc.Condition[CharacterCondition.mounted]
        or Svc.Condition[CharacterCondition.mounting57]
        or Svc.Condition[CharacterCondition.mounting64]
        or Svc.Condition[CharacterCondition.jumping48]
        or Svc.Condition[CharacterCondition.jumping61]
        or Svc.Condition[CharacterCondition.beingMoved]
        or Svc.Condition[CharacterCondition.flying]
        or Svc.Condition[CharacterCondition.betweenAreas]
        or Svc.Condition[CharacterCondition.betweenAreasForDuty]
        or Svc.Condition[CharacterCondition.boundByDuty34]
        or Svc.Condition[CharacterCondition.boundByDuty56]
        or Svc.Condition[CharacterCondition.occupied]
        or Svc.Condition[CharacterCondition.occupiedInEvent]
        or Svc.Condition[CharacterCondition.occupiedInQuestEvent]
        or Svc.Condition[CharacterCondition.occupiedMateriaExtractionAndRepair]
        or IsLifestreamBusySafe()
        or IsVnavmeshMovingSafe()
    then
        return false
    end
    return true
end

function FoodCheck()
    if FoodAutoUseDisabled then
        return
    end
    if NativeItemCommandDisabled then
        if not NativeItemCommandWarned and TrimString(Food) ~= "" then
            NativeItemCommandWarned = true
            local msg =
            "[FATE] Native /item command is disabled in safety mode. Auto food/potion use is skipped to avoid SND item crashes."
            Dalamud.Log(msg)
            yield("/echo " .. msg)
        end
        FoodAutoUseDisabled = true
        return
    end
    if HasStatusId(48) then
        return
    end
    local command = BuildConsumableItemCommand(Food)
    if command == nil or not CanUseConsumableNow() then
        return
    end

    local ok = SafeYield(command)
    if not ok then
        FoodAutoUseDisabled = true
        local msg = "[FATE] Failed to use configured Food item. Auto food use disabled for this session."
        Dalamud.Log(msg)
        yield("/echo " .. msg)
    end
end

function PotionCheck()
    if PotionAutoUseDisabled then
        return
    end
    if NativeItemCommandDisabled then
        if not NativeItemCommandWarned and TrimString(Potion) ~= "" then
            NativeItemCommandWarned = true
            local msg =
            "[FATE] Native /item command is disabled in safety mode. Auto food/potion use is skipped to avoid SND item crashes."
            Dalamud.Log(msg)
            yield("/echo " .. msg)
        end
        PotionAutoUseDisabled = true
        return
    end
    if HasStatusId(49) then
        return
    end
    local command = BuildConsumableItemCommand(Potion)
    if command == nil or not CanUseConsumableNow() then
        return
    end

    local ok = SafeYield(command)
    if not ok then
        PotionAutoUseDisabled = true
        local msg = "[FATE] Failed to use configured Potion item. Auto potion use disabled for this session."
        Dalamud.Log(msg)
        yield("/echo " .. msg)
    end
end

function GetChocoboTimeRemaining()
    local ok, time = pcall(function()
        if Svc and Svc.Buddies and Svc.Buddies.Companion then
            return Svc.Buddies.Companion.TimeLeft
        end
        return nil
    end)
    if ok and type(time) == "number" then
        return time
    end

    if SndGameUtils ~= nil then
        local ok, time = pcall(function() return SndGameUtils.GetBuddyTimeRemaining() end)
        if ok and type(time) == "number" then
            return time
        end
    end
    return -1
end

IsChocoboDebugDone = false

function IsChocoboSummoned()
    local ok, result = pcall(function()
        local now = os.clock()
        local shouldDebug = (ChocoboLastDebugAt or 0) + 30 < now
        if shouldDebug then
            ChocoboLastDebugAt = now
        end

        -- Helper: scan object table for an owned companion entity.
        -- A summoned chocobo is owned by the player. Dalamud's ObjectKind 8 is
        -- Companion; during state transitions it may briefly report as 2 or 11.
        local function CompanionObjectExists()
            if Svc and Svc.Objects then
                local playerOk, player = pcall(function() return Svc.ClientState.LocalPlayer end)
                if playerOk and player then
                    local playerPos = player.Position
                    local playerId = player.EntityId
                    local playerGoIdOk, playerGoId = pcall(function() return player.GameObjectId end)
                    if shouldDebug then
                        yield("/echo [FATE] Chocobo debug: scanning objects. mounted=" ..
                            tostring(Svc.Condition[CharacterCondition.mounted]) ..
                            " playerId=" .. tostring(playerId))
                    end
                    for i = 0, math.min(Svc.Objects.Length - 1, 300) do
                        local objOk, obj = pcall(function() return Svc.Objects[i] end)
                        if objOk and obj then
                            local ownerOk, owner = pcall(function() return obj.OwnerId end)
                            local kindOk, kind = pcall(function() return obj.ObjectKind end)
                            local nameOk, name = pcall(function() return obj.Name end)
                            local posOk, pos = pcall(function() return obj.Position end)
                            local ownerMatches = ownerOk and (owner == playerId or
                                (playerGoIdOk and owner == playerGoId))
                            local dist = (posOk and playerPos) and DistanceBetweenFlat(playerPos, pos) or nil
                            if shouldDebug and dist ~= nil and dist < 20 and kindOk and nameOk then
                                yield("/echo [FATE] Chocobo debug nearby: kind=" .. tostring(kind) ..
                                    " name=" .. tostring(name) .. " dist=" .. string.format("%.1f", dist) ..
                                    " owner=" .. tostring(owner) .. " match=" .. tostring(ownerMatches))
                            end
                            if ownerMatches and kindOk and nameOk and name and
                                string.len(tostring(name)) > 0 then
                                if kind == 8 or kind == 11 or kind == 2 then
                                    return true
                                end
                            end
                        end
                    end
                end
            end
            return false
        end

        -- Method 0: While mounted/flying the game hides the companion object and
        -- removes it from Svc.Buddies. If we have a recent cached expiration, trust
        -- it so we don't re-summon immediately after dismounting.
        if Svc.Condition[CharacterCondition.mounted]
            or Svc.Condition[CharacterCondition.flying]
            or Svc.Condition[CharacterCondition.mounting57]
            or Svc.Condition[CharacterCondition.mounting64]
        then
            if ChocoboSummonExpiresAt ~= nil then
                local remaining = ChocoboSummonExpiresAt - os.time()
                if remaining > 0 then
                    if shouldDebug then
                        yield("/echo [FATE] Chocobo debug: mounted, trusting cached expiration")
                    end
                    return true
                end
            end
        end

        -- Method 1: Svc.Buddies.Companion
        if Svc and Svc.Buddies then
            local buddyOk, hasBuddy = pcall(function() return Svc.Buddies.Companion ~= nil end)
            local timeLeftOk, timeLeft = pcall(function() return Svc.Buddies.Companion.TimeLeft end)
            if shouldDebug then
                yield("/echo [FATE] Chocobo debug: hasBuddy=" .. tostring(hasBuddy) ..
                    " timeLeft=" .. tostring(timeLeft))
            end
            if buddyOk and hasBuddy then
                if timeLeftOk and type(timeLeft) == "number" and timeLeft > 0 then
                    return true
                end
                -- Even when TimeLeft reports 0 or nil, the API can be slow/buggy.
                -- If the actual companion object is still nearby, treat it as summoned.
                if CompanionObjectExists() then
                    return true
                end
            end
        end

        -- Method 2: SndGameUtils
        if SndGameUtils ~= nil then
            local utilsOk, time = pcall(function() return SndGameUtils.GetBuddyTimeRemaining() end)
            if shouldDebug then
                yield("/echo [FATE] Chocobo debug: sndUtilsTime=" .. tostring(time))
            end
            if utilsOk and type(time) == "number" and time > 0 then
                return true
            end
            if CompanionObjectExists() then
                return true
            end
        end

        -- Method 3: cached expiration time from last successful summon
        if ChocoboSummonExpiresAt ~= nil then
            local remaining = ChocoboSummonExpiresAt - os.time()
            if shouldDebug then
                yield("/echo [FATE] Chocobo debug: cachedRemaining=" .. tostring(remaining))
            end
            if remaining > 0 then
                return true
            end
        end

        -- Method 4: Fallback to object-table scan
        if CompanionObjectExists() then
            return true
        end

        -- Method 5: Status effect fallback
        -- 1220/1221 are commonly used for Gysahl Greens / Companion presence.
        if HasStatusId(1220) or HasStatusId(1221) then
            if shouldDebug then
                yield("/echo [FATE] Chocobo debug: detected via status effect")
            end
            return true
        end

        if shouldDebug then
            yield("/echo [FATE] Chocobo debug: not summoned")
        end
        return false
    end)
    if ok then
        return result
    end
    return false
end

-- ============================================================
-- Party Play Helper Functions
-- ============================================================

function GetPartyMemberCount()
    local ok, party = pcall(function()
        if Svc and Svc.Party then
            return Svc.Party
        end
        if Svc and Svc.ClientState and Svc.ClientState.Party then
            return Svc.ClientState.Party
        end
        return nil
    end)
    if not ok or party == nil then
        return 0
    end
    local count = 0
    local lenOk, len = pcall(function() return party.Length end)
    if not lenOk or len == nil then
        lenOk, len = pcall(function() return party.Count end)
    end
    if not lenOk or len == nil then
        return 0
    end
    for i = 0, len - 1 do
        local memberOk, member = pcall(function() return party[i] end)
        if memberOk and member ~= nil then
            count = count + 1
        end
    end
    return count
end

function GetPartyMemberNames()
    local names = {}
    local ok, party = pcall(function()
        if Svc and Svc.Party then
            return Svc.Party
        end
        if Svc and Svc.ClientState and Svc.ClientState.Party then
            return Svc.ClientState.Party
        end
        return nil
    end)
    if not ok or party == nil then
        return names
    end
    local lenOk, len = pcall(function() return party.Length end)
    if not lenOk or len == nil then
        lenOk, len = pcall(function() return party.Count end)
    end
    if not lenOk or len == nil then
        return names
    end
    for i = 0, len - 1 do
        local memberOk, member = pcall(function() return party[i] end)
        if memberOk and member ~= nil then
            local nameOk, nameObj = pcall(function() return member.Name end)
            if nameOk and nameObj ~= nil then
                local textOk, text = pcall(function() return nameObj:GetText() end)
                if textOk and text ~= nil and text ~= "" then
                    table.insert(names, text)
                end
            end
        end
    end
    return names
end

function IsPartyMemberObject(obj)
    if obj == nil then return false end
    local partyNames = GetPartyMemberNames()
    if #partyNames == 0 then return false end
    local nameOk, name = pcall(function() return obj.Name end)
    if not nameOk or name == nil then return false end
    local textOk, text = pcall(function() return name:GetText() end)
    if not textOk or text == nil then return false end
    for _, partyName in ipairs(partyNames) do
        if text == partyName then
            return true
        end
    end
    return false
end

function GetPartyMemberTargetObjects()
    local targets = {}
    local partyNames = GetPartyMemberNames()
    if #partyNames == 0 then return targets end
    local nameSet = {}
    for _, n in ipairs(partyNames) do
        nameSet[n] = true
    end
    if Svc == nil or Svc.Objects == nil then return targets end
    local lenOk, len = pcall(function() return Svc.Objects.Length end)
    if not lenOk or len == nil then return targets end
    for i = 0, len - 1 do
        local objOk, obj = pcall(function() return Svc.Objects[i] end)
        if objOk and obj ~= nil then
            local nameOk, name = pcall(function() return obj.Name end)
            if nameOk and name ~= nil then
                local textOk, text = pcall(function() return name:GetText() end)
                if textOk and text ~= nil and nameSet[text] then
                    local targetOk, target = pcall(function() return obj.TargetObject end)
                    if targetOk and target ~= nil and target:IsHostile() and not target.IsDead then
                        table.insert(targets, target)
                    end
                end
            end
        end
    end
    return targets
end

function IsPartyMemberInFate(fate)
    if fate == nil or fate.position == nil then return false end
    local fateRadius = GetFateRadiusValue(fate, nil)
    if fateRadius == nil or fateRadius <= 0 then
        fateRadius = 50
    end
    local partyNames = GetPartyMemberNames()
    if #partyNames == 0 then return false end
    local nameSet = {}
    for _, n in ipairs(partyNames) do
        nameSet[n] = true
    end
    if Svc == nil or Svc.Objects == nil then return false end
    local lenOk, len = pcall(function() return Svc.Objects.Length end)
    if not lenOk or len == nil then return false end
    for i = 0, len - 1 do
        local objOk, obj = pcall(function() return Svc.Objects[i] end)
        if objOk and obj ~= nil then
            local nameOk, name = pcall(function() return obj.Name end)
            if nameOk and name ~= nil then
                local textOk, text = pcall(function() return name:GetText() end)
                if textOk and text ~= nil and nameSet[text] then
                    local posOk, pos = pcall(function() return obj.Position end)
                    if posOk and pos ~= nil then
                        if DistanceBetweenFlat(fate.position, pos) <= fateRadius then
                            return true
                        end
                    end
                end
            end
        end
    end
    return false
end

function GetPartyPlayActive()
    if PartyPlayMode == true then
        return true
    end
    if AutoDetectPartyMembers == true then
        local count = GetPartyMemberCount()
        return count > 0
    end
    return false
end

function GetPartyMemberPositions()
    local positions = {}
    local ok, party = pcall(function()
        if Svc and Svc.Party then return Svc.Party end
        if Svc and Svc.ClientState and Svc.ClientState.Party then return Svc.ClientState.Party end
        return nil
    end)
    if not ok or party == nil then return positions end
    local lenOk, len = pcall(function() return party.Length end)
    if not lenOk or len == nil then
        lenOk, len = pcall(function() return party.Count end)
    end
    if not lenOk or len == nil then return positions end
    for i = 0, len - 1 do
        local memberOk, member = pcall(function() return party[i] end)
        if memberOk and member ~= nil then
            local gameObjOk, gameObj = pcall(function() return member.GameObject end)
            if gameObjOk and gameObj ~= nil then
                local posOk, pos = pcall(function() return gameObj.Position end)
                if posOk and pos ~= nil then
                    table.insert(positions, pos)
                end
            end
        end
    end
    return positions
end

function GetClosestPartyMemberPosition()
    local playerPos = GetPlayerPosition()
    if playerPos == nil then return nil end
    local partyPositions = GetPartyMemberPositions()
    if #partyPositions == 0 then return nil end
    local closest = nil
    local closestDist = math.maxinteger
    for _, pos in ipairs(partyPositions) do
        local dist = DistanceBetween(playerPos, pos)
        if dist < closestDist then
            closestDist = dist
            closest = pos
        end
    end
    return closest, closestDist
end

function GetPartyLeaderZoneId()
    local ok, party = pcall(function()
        if Svc and Svc.Party then return Svc.Party end
        if Svc and Svc.ClientState and Svc.ClientState.Party then return Svc.ClientState.Party end
        return nil
    end)
    if not ok or party == nil then return nil end

    local lenOk, len = pcall(function() return party.Length end)
    if not lenOk or len == nil then
        lenOk, len = pcall(function() return party.Count end)
    end
    if not lenOk or len == nil or len == 0 then return nil end

    local leaderOk, leader = pcall(function() return party[0] end)
    if not leaderOk or leader == nil then return nil end

    local gameObjOk, gameObj = pcall(function() return leader.GameObject end)
    if not gameObjOk or gameObj == nil then return nil end

    local terrOk, terr = pcall(function() return gameObj.Territory end)
    if not terrOk or terr == nil then return nil end

    local typeOk, terrType = pcall(function() return terr.TerritoryType end)
    if typeOk and terrType ~= nil and terrType ~= 0 then
        return tonumber(terrType)
    end

    local rowOk, rowId = pcall(function() return terr.TerritoryTypeRowId end)
    if rowOk and rowId ~= nil and rowId ~= 0 then
        return tonumber(rowId)
    end

    return nil
end

function FollowPartyLeaderToZone()
    if FollowPartyLeaderZone ~= true then return end
    if not GetPartyPlayActive() then return end

    if Svc.Condition[CharacterCondition.inCombat]
        or Svc.Condition[CharacterCondition.casting]
        or Svc.Condition[CharacterCondition.betweenAreas]
        or Svc.Condition[CharacterCondition.mounted]
        or Svc.Condition[CharacterCondition.flying]
        or Svc.Condition[CharacterCondition.occupied]
        or Svc.Condition[CharacterCondition.dead]
    then
        return
    end

    if IsLifestreamBusySafe() then return end

    AcceptTeleportOfferLocation("")

    local leaderZoneId = GetPartyLeaderZoneId()

    local shouldTeleport = false
    local destinationZoneId = nil

    if leaderZoneId ~= nil and leaderZoneId ~= Svc.ClientState.TerritoryType then
        shouldTeleport = true
        destinationZoneId = leaderZoneId
        Dalamud.Log("[FATE] Party leader is in zone " ..
        leaderZoneId .. ", current zone is " .. Svc.ClientState.TerritoryType)
    end

    if not shouldTeleport then
        local partyPositions = GetPartyMemberPositions()
        if #partyPositions == 0 and GetPartyMemberCount() > 1 then
            if LastPartyLeaderZoneId ~= nil and LastPartyLeaderZoneId ~= Svc.ClientState.TerritoryType then
                shouldTeleport = true
                destinationZoneId = LastPartyLeaderZoneId
                Dalamud.Log("[FATE] No party members in current zone. Following leader to zone " .. destinationZoneId)
            end
        end
    end

    if not shouldTeleport or destinationZoneId == nil then
        return
    end

    if SelectedZone ~= nil and SelectedZone.zoneId == destinationZoneId then
        return
    end

    Dalamud.Log("[FATE] Teleporting to party leader's zone (zoneId: " .. destinationZoneId .. ")")

    local closestAetheryte = GetClosestAetheryteInZoneToPoint(destinationZoneId, GetPlayerPosition() or { X = 0, Y = 0, Z = 0 })
    if closestAetheryte ~= nil then
        TeleportTo(closestAetheryte.name)
    else
        local aetherytes = GetAetherytesInZone(destinationZoneId)
        if #aetherytes > 0 then
            local aetheryteName = GetAetheryteName(aetherytes[1])
            TeleportTo(aetheryteName)
        else
            Dalamud.Log("[FATE] No aetherytes found in zone " .. destinationZoneId)
        end
    end
end

-- ============================================================

function ChocoboCheck()
    local summary = "[FATE] ChocoboCheck called state=" .. tostring(State) ..
        " territory=" .. tostring(Svc.ClientState.TerritoryType) ..
        " SummonChocobo=" .. tostring(SummonChocobo) ..
        " lastAttempt=" .. tostring(ChocoboLastSummonAttemptAt)
    Dalamud.Log(summary)
    if State == CharacterState.ready or State == CharacterState.initialSetup then
        yield("/echo " .. summary)
    end

    local chocoboCheckDebugNow = os.clock()
    local shouldDebugChocoboCheck = (ChocoboLastCheckDebugAt or 0) + 30 < chocoboCheckDebugNow
    if shouldDebugChocoboCheck then
        ChocoboLastCheckDebugAt = chocoboCheckDebugNow
    end

    -- Once the 30-minute window is open, retry every 10 seconds until conditions
    -- are right, so the summon actually happens instead of waiting another 30 min.
    local now = os.clock()
    local function DeferCheck()
        if now - (ChocoboLastSummonAttemptAt or 0) >= (30 * 60) then
            ChocoboLastSummonAttemptAt = now - (30 * 60) + 10
        end
    end

    if not SummonChocobo then
        if shouldDebugChocoboCheck then Dalamud.Log("[FATE] ChocoboCheck skip: SummonChocobo=false") end
        DeferCheck()
        return
    end
    if ChocoboSummonDisabled then
        if shouldDebugChocoboCheck then Dalamud.Log("[FATE] ChocoboCheck skip: ChocoboSummonDisabled=true") end
        DeferCheck()
        return
    end
    if DisableChocoboInParty and GetPartyPlayActive() then
        if shouldDebugChocoboCheck then Dalamud.Log("[FATE] ChocoboCheck skip: party play active") end
        DeferCheck()
        return
    end
    -- Skip summoning while in town/traveling; wait until we reach the farming zone.
    if SelectedZone ~= nil and Svc.ClientState.TerritoryType ~= SelectedZone.zoneId then
        if shouldDebugChocoboCheck then Dalamud.Log("[FATE] ChocoboCheck skip: not in selected zone") end
        DeferCheck()
        return
    end
    if Svc.Condition[CharacterCondition.inCombat]
        or Svc.Condition[CharacterCondition.casting]
        or Svc.Condition[CharacterCondition.occupied]
        or Svc.Condition[CharacterCondition.betweenAreas]
        or Svc.Condition[CharacterCondition.dead]
    then
        if shouldDebugChocoboCheck then Dalamud.Log("[FATE] ChocoboCheck skip: busy/in combat/casting") end
        DeferCheck()
        return
    end

    local isSummoned = IsChocoboSummoned()
    if isSummoned then
        if shouldDebugChocoboCheck then Dalamud.Log("[FATE] ChocoboCheck skip: already summoned") end
        -- Already out; use the normal 30-minute window for the next recheck.
        ChocoboLastSummonAttemptAt = chocoboCheckDebugNow
        return
    end

    -- Detection APIs may be unreliable. To avoid wasting greens, only attempt
    -- a summon once every 30 minutes. This keeps the chocobo out as much as
    -- possible while keeping error/usage spam minimal.
    if now - (ChocoboLastSummonAttemptAt or 0) < (30 * 60) then
        if shouldDebugChocoboCheck then Dalamud.Log("[FATE] ChocoboCheck skip: on 30-minute cooldown") end
        return
    end
    ChocoboLastSummonAttemptAt = now

    -- Don't summon while mounted. Dismounting just to use greens slows down
    -- travel between fates; wait until we are on the ground at the destination.
    if Svc.Condition[CharacterCondition.mounted] then
        if shouldDebugChocoboCheck then Dalamud.Log("[FATE] ChocoboCheck skip: mounted, wait until dismounted") end
        DeferCheck()
        return
    end

    -- Don't summon while actively pathing to the next FATE.
    if State == CharacterState.moveToFate then
        local isMoving = IPC.vnavmesh ~= nil and (IPC.vnavmesh.IsRunning() or IPC.vnavmesh.PathfindInProgress())
        if isMoving then
            if shouldDebugChocoboCheck then Dalamud.Log("[FATE] ChocoboCheck skip: pathing to next FATE") end
            DeferCheck()
            return
        end
    end

    local itemCount = Inventory.GetItemCount(4868)
    if itemCount > 0 then
        -- Double-check combat state right before using item
        if Svc.Condition[CharacterCondition.inCombat]
            or Svc.Condition[CharacterCondition.casting]
            or Svc.Condition[CharacterCondition.mounted]
        then
            if shouldDebugChocoboCheck then Dalamud.Log("[FATE] ChocoboCheck skip: became busy before using item") end
            DeferCheck()
            return
        end

        Dalamud.Log("[FATE] ChocoboCheck: attempting to summon (Greens: " .. tostring(itemCount) .. ")")
        yield("/echo [FATE] Chocobo not summoned, attempting to summon... (Greens: " .. tostring(itemCount) .. ")")

        -- Wait a moment for any ongoing state transitions (dismount, combat drop,
        -- cooldown availability) to settle before using the item.
        yield("/wait 1")

        -- Re-check after waiting; the companion may have become visible or the
        -- cached expiration may now be valid.
        if IsChocoboSummoned() then
            return
        end

        -- Try to use Gysahl Greens. The localized name (e.g. "ギサールの野菜"
        -- on JP client) is what the client understands. If the native /item
        -- command fails, the item is most likely on cooldown or the chocobo is
        -- already summoned, so we don't spam fallbacks that would only add
        -- errors to the SND log.
        local function TryUseGysahlGreens()
            if Svc.Condition[CharacterCondition.inCombat]
                or Svc.Condition[CharacterCondition.casting]
                or Svc.Condition[CharacterCondition.mounted]
            then
                return false
            end

            local greens = LANG.actions["Gysahl Greens"]
            if SafeYield('/item "' .. greens .. '"') then
                return true
            end

            return false
        end

        local used = TryUseGysahlGreens()
        yield("/wait 2")

        -- Check if summoning worked
        if IsChocoboSummoned() then
            yield("/echo [FATE] Chocobo summoned successfully")
            ChocoboSummonFailureCount = 0
            -- Gysahl Greens last 30 minutes; cache the expiration to avoid
            -- re-summoning when TimeLeft APIs are slow/unreliable.
            ChocoboSummonExpiresAt = os.time() + (30 * 60)
            -- Don't attempt another summon until shortly before expiration.
            ChocoboLastSummonAttemptAt = os.clock() + (30 * 60) - 30
        else
            if used then
                -- The item command succeeded. Detection APIs can be flaky, but the
                -- 30-minute buff is almost certainly active, so don't retry until
                -- shortly before expiration.
                ChocoboSummonFailureCount = 0
                ChocoboLastSummonAttemptAt = os.clock() + (30 * 60) - 30
            else
                ChocoboSummonFailureCount = (ChocoboSummonFailureCount or 0) + 1
                if ChocoboSummonFailureCount <= 3 then
                    yield("/echo [FATE] Failed to use Gysahl Greens (attempt " ..
                        tostring(ChocoboSummonFailureCount) .. ")")
                end
                -- /item failed. This usually means the chocobo is already
                -- summoned or the item is on cooldown. Retry after 30 seconds so
                -- we re-summon quickly once the buff actually expires.
                ChocoboLastSummonAttemptAt = os.clock() + 30
                if ChocoboSummonFailureCount >= 10 then
                    ChocoboSummonDisabled = true
                    yield("/echo [FATE] Chocobo summon failed 10 times. Disabling auto-summon for this session.")
                end
            end
        end
    else
        Dalamud.Log("[FATE] ChocoboCheck skip: no Gysahl Greens (auto-buy is " ..
            tostring(ShouldAutoBuyGysahlGreens) .. ")")
        if ShouldAutoBuyGysahlGreens then
            NeedsGysahlGreens = true
        end
        DeferCheck()
    end
end

function SprintCheck()
    if Svc.Condition[CharacterCondition.mounted] or Svc.Condition[CharacterCondition.mounting57] or Svc.Condition[CharacterCondition.mounting64] or Svc.Condition[CharacterCondition.inCombat] or Svc.Condition[CharacterCondition.casting] then return end
    if HasStatusId(50) then return end

    local isMoving = false
    if IPC.vnavmesh and (IPC.vnavmesh.IsRunning() or IPC.vnavmesh.PathfindInProgress()) then
        isMoving = true
    end

    if isMoving then
        local sprint = LANG.actions["sprint"] or "Sprint"
        SafeYield("/ac \"" .. sprint .. "\"")
    end
end

function GetNodeText(addonName, nodePath, ...)
    local start = os.clock()
    local addon = Addons.GetAddon(addonName)
    while addon == nil or not addon.Ready do
        if os.clock() - start > 3 then
            Dalamud.Log("[FATE] GetNodeText timeout for addon: " .. tostring(addonName))
            return nil
        end
        yield("/wait 0.1")
        addon = Addons.GetAddon(addonName)
    end
    local node = addon:GetNode(nodePath, ...)
    if node == nil then
        Dalamud.Log("[FATE] GetNodeText node not found: addon=" .. tostring(addonName))
        return nil
    end
    return node.Text
end

function ARRetainersWaitingToBeProcessed()
    if IPC.AutoRetainer == nil
        or type(IPC.AutoRetainer.GetOfflineCharacterData) ~= "function"
        or Svc.ClientState.LocalContentId == nil
    then
        return false
    end
    local ok, offlineCharacterData = pcall(function()
        return IPC.AutoRetainer.GetOfflineCharacterData(Svc.ClientState.LocalContentId)
    end)
    if not ok or offlineCharacterData == nil or offlineCharacterData.RetainerData == nil then
        return false
    end
    for i = 0, offlineCharacterData.RetainerData.Count - 1 do
        local retainer = offlineCharacterData.RetainerData[i]
        if retainer.HasVenture and retainer.VentureEndsAt <= os.time() then
            return true
        end
    end
    return false
end

function FormatSessionDuration(totalSeconds)
    local seconds = math.max(0, math.floor(totalSeconds))
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60
    return string.format("%02d:%02d:%02d", hours, minutes, secs)
end

function SetStopReason(reason)
    if SessionStopReason == nil or SessionStopReason == "" then
        SessionStopReason = reason
    end
end

function GetPostFateWaitSeconds()
    local minWait = tonumber(MinWait) or 0
    local maxWait = tonumber(MaxWait) or minWait
    if maxWait < minWait then
        minWait, maxWait = maxWait, minWait
    end
    minWait = math.max(0, minWait)
    maxWait = math.max(0, maxWait)
    if maxWait <= minWait then
        return minWait
    end
    local roll = minWait + (math.random() * (maxWait - minWait))
    return math.floor(roll * 1000) / 1000
end

function PrintSessionSummary()
    if PrintSessionSummaryEnabled ~= true then
        return
    end

    local elapsed = os.clock() - (SessionStartClock or os.clock())
    local startGems = SessionStartGemCount or 0
    local endGems = Inventory.GetItemCount(26807)
    local gemDelta = endGems - startGems

    local completed = SessionFatesCompleted or 0
    local failed = SessionFatesFailed or 0
    local resolved = completed + failed
    local completionRate = resolved > 0 and (completed / resolved * 100) or 0
    local fatesPerHour = elapsed > 0 and (completed * 3600 / elapsed) or 0
    local gemsPerHour = elapsed > 0 and (gemDelta * 3600 / elapsed) or 0

    local summaryLine1 = string.format(
        "[FATE] Session %s | Gems %d -> %d (%+d) | Started %d / Completed %d / Failed %d",
        FormatSessionDuration(elapsed),
        startGems,
        endGems,
        gemDelta,
        SessionFatesStarted or 0,
        completed,
        failed
    )
    local summaryLine2 = string.format(
        "[FATE] Rate: %.2f FATE/h | %.1f Gems/h | Completion %.1f%%",
        fatesPerHour,
        gemsPerHour,
        completionRate
    )
    local summaryLine3 = string.format(
        "[FATE] Stuck Recoveries repath/tp/zone = %d/%d/%d | StopReason: %s",
        SessionStuckRepathCount or 0,
        SessionStuckAetheryteCount or 0,
        SessionStuckZoneSwitchCount or 0,
        SessionStopReason or "Unknown"
    )

    Dalamud.Log(summaryLine1)
    Dalamud.Log(summaryLine2)
    Dalamud.Log(summaryLine3)
    yield("/echo " .. summaryLine1)
    yield("/echo " .. summaryLine2)
    yield("/echo " .. summaryLine3)
end

--#endregion Misc Functions

--#region Main

function FateFarming:Run()
    Svc = Svc or Dalamud
    Dalamud.Log("[FATE-FIXED] Run() started.")
    local lp = (ClientState ~= nil and ClientState.LocalPlayer) or
        (Svc ~= nil and Svc.ClientState ~= nil and Svc.ClientState.LocalPlayer) or
        (Player ~= nil and Player.Available == true and Player)
    if lp == nil or type(lp) ~= "table" then
        local msg =
        "ERROR: LocalPlayer not found. Please ensure you are logged in and using SomethingNeedDoing [Expanded Edition]."
        yield("/echo [FATE] " .. msg)
        Dalamud.Log("[FATE-FIXED] " .. msg)
        return
    end

    math.randomseed(os.time())

    CharacterState = {
        ready                  = Ready,
        initialSetup           = InitialSetup,
        dead                   = HandleDeath,
        unexpectedCombat       = HandleUnexpectedCombat,
        mounting               = MountState,
        npcDismount            = NpcDismount,
        MiddleOfFateDismount   = MiddleOfFateDismount,
        moveToFate             = MoveToFate,
        interactWithNpc        = InteractWithFateNpc,
        collectionsFateTurnIn  = CollectionsFateTurnIn,
        doFate                 = DoFate,
        waitForContinuation    = WaitForContinuation,
        changingInstances      = ChangeInstance,
        changeInstanceDismount = ChangeInstanceDismount,
        flyBackToAetheryte     = FlyBackToAetheryte,
        extractMateria         = ExtractMateria,
        repair                 = Repair,
        exchangingVouchers     = ExecuteBicolorExchange,
        processRetainers       = ProcessRetainers,
        gcTurnIn               = GrandCompanyTurnIn
    }

    --- Fate state enum mapping (values confirmed from FFXIV SND)
    FateState      = {
        None      = 0, -- no state / unknown
        Preparing = 1, -- fate is setting up
        Waiting   = 2, -- waiting before spawn
        Spawning  = 3, -- mobs/NPCs spawning
        Running   = 4, -- fate active and in progress
        Ending    = 5, -- fate nearing completion
        Ended     = 6, -- fate finished successfully
        Failed    = 7  -- fate failed
    }

    -- 言語設定の初期化
    GameLanguage   = Svc.ClientState.ClientLanguage:ToString()
    LANG           = GetLangTable(GameLanguage)

    -- Settings Area
    -- Buffs
    Food           = TrimString(Config.Get("Food"))
    Potion         = TrimString(Config.Get("Potion"))

    MountToUse     = "mount roulette" --The mount youd like to use when flying between fates

    -- Retainer




    --Fate Combat
    CompletionToIgnoreFate           = Config.Get("Ignore FATE if progress is over (%)")
    MinTimeLeftToIgnoreFate          = Config.Get("Ignore FATE if duration is less than (mins)") * 60
    CompletionToJoinBossFate         = Config.Get("Ignore boss FATEs until progress is at least (%)")
    CompletionToJoinSpecialBossFates = Config.Get("Ignore Special FATEs until progress is at least (%)")
    JoinCollectionsFates             = Config.Get("Do collection FATEs?")
    JoinOtherNpcFates                = Config.Get("Do other NPC FATEs?")
    BonusFatesOnly                   = Config.Get("Do only bonus FATEs?") --If true, will only do bonus fates and ignore everything else
    NoCombatTeleportTimeout          = Config.Get("No combat teleport timeout (secs)")
    NoMovementTeleportTimeout        = Config.Get("No movement teleport timeout (secs)")
    PreferDensePulls                 = Config.Get("Prefer dense mob pulls?")
    TargetEngagedEnemies             = Config.Get("Target engaged enemies?")
    AggressivePulling                = Config.Get("Aggressive pulling?")
    MaxPullCount                     = Config.Get("Max pull count")
    DensePullClusterRadius           = Config.Get("Dense pull cluster radius")
    DensePullMinimumEnemies          = Config.Get("Dense pull minimum enemies")
    ActivePullEnabled                = Config.Get("Active pull enabled?")
    ActivePullIntervalSeconds        = Config.Get("Active pull interval (secs)")
    ActivePullMaxTargets             = Config.Get("Active pull max targets")
    ActivePullMaxRange               = Config.Get("Active pull max range")
    OptimizeClusterMovement          = Config.Get("Optimize movement to mob clusters?")
    ClusterMoveRadius                = Config.Get("Cluster movement radius")
    ClusterMoveMinimumEnemies        = Config.Get("Cluster movement minimum enemies")
    ClusterMoveRefreshSeconds        = Config.Get("Cluster movement refresh (secs)")
    DynamicAoeSwitch                 = Config.Get("Dynamic AoE switch?")
    DynamicAoeEnemyCount             = Config.Get("Dynamic AoE enemy count")
    DynamicAoeSameNameEnemyCount     = Config.Get("Dynamic AoE same-name enemy count")
    DynamicAoeCheckRadius            = Config.Get("Dynamic AoE check radius")
    FastCombatPacing                 = Config.Get("Fast combat pacing?")
    EnableStagedAntiStuck            = Config.Get("Staged anti-stuck recovery?")
    StuckCheckIntervalSeconds        = Config.Get("Stuck check interval (secs)")
    StuckMovementThreshold           = Config.Get("Stuck movement threshold")
    PrintSessionSummaryEnabled       = Config.Get("Print session summary?")
    HighLevelFatePriorityEnabled     = true
    HighLevelFatePriorityMinLevel    = 96
    if HighLevelFatePriorityEnabled then
        FatePriority = { "HighLevel", "Distance", "DistanceTeleport", "Progress", "Bonus", "TimeLeft" }
    else
        FatePriority = { "Distance", "DistanceTeleport", "Progress", "Bonus", "TimeLeft" }
    end
    MeleeDist    = Config.Get("Max melee distance")
    RangedDist   = Config.Get("Max ranged distance")
    HitboxBuffer = 0.5
    if PreferDensePulls == nil then
        PreferDensePulls = true
    end
    if DensePullClusterRadius == nil or DensePullClusterRadius < 1 then
        DensePullClusterRadius = 30
    end
    if DensePullMinimumEnemies == nil or DensePullMinimumEnemies < 1 then
        DensePullMinimumEnemies = 1
    end
    if OptimizeClusterMovement == nil then
        OptimizeClusterMovement = true
    end
    if ClusterMoveRadius == nil or ClusterMoveRadius < 1 then
        ClusterMoveRadius = 40
    end
    if ClusterMoveMinimumEnemies == nil or ClusterMoveMinimumEnemies < 1 then
        ClusterMoveMinimumEnemies = FastCombatPacing and 1 or 2
    end
    if ClusterMoveRefreshSeconds == nil or ClusterMoveRefreshSeconds < 0.2 then
        ClusterMoveRefreshSeconds = FastCombatPacing and 0.5 or 1
    end
    if DynamicAoeSwitch == nil then
        DynamicAoeSwitch = true
    end
    if DynamicAoeEnemyCount == nil or DynamicAoeEnemyCount < 1 then
        DynamicAoeEnemyCount = 1
    end
    if DynamicAoeSameNameEnemyCount == nil or DynamicAoeSameNameEnemyCount < 1 then
        DynamicAoeSameNameEnemyCount = 1
    end
    if DynamicAoeCheckRadius == nil or DynamicAoeCheckRadius < 1 then
        DynamicAoeCheckRadius = 30
    end
    if FastCombatPacing == nil then
        FastCombatPacing = true
    end
    if EnableStagedAntiStuck == nil then
        EnableStagedAntiStuck = true
    end
    if StuckCheckIntervalSeconds == nil or StuckCheckIntervalSeconds < 1 then
        StuckCheckIntervalSeconds = 10
    end
    if StuckMovementThreshold == nil or StuckMovementThreshold < 0.1 then
        StuckMovementThreshold = 3
    end
    if PrintSessionSummaryEnabled == nil then
        PrintSessionSummaryEnabled = true
    end
    FateExpectedScoreEnabled              = true
    PreferredHighLevelZoneBiasEnabled     = true
    PreferredHighLevelZoneScoreBonus      = FastCombatPacing and 2.8 or 2.4
    PreferredHighLevelZonePenaltyDecay    = 0.62
    SkipLevelSyncForHighLevelFates        = false
    LevelSyncBypassMinFateLevel           = 96
    CombatFateSelectionBonus              = FastCombatPacing and 12 or 5
    BossFateSelectionPenalty              = FastCombatPacing and 20 or 12
    FatePrefetchProgressThreshold         = FastCombatPacing and 35 or 70
    FatePrefetchIntervalSeconds           = FastCombatPacing and 0.6 or 3.5
    FatePrefetchTtlSeconds                = 30
    MainLoopWaitSeconds                   = FastCombatPacing and 0.05 or 0.25
    FastNoFateZoneSwitchCooldownSeconds   = FastCombatPacing and 0.5 or 4
    CombatStartBoostDurationSeconds       = FastCombatPacing and 8 or 12
    TeleportHysteresisEnterGain           = FastCombatPacing and 52 or 70
    TeleportHysteresisExitGain            = FastCombatPacing and 16 or 25
    NoCombatRecoveryRetargetRatio         = FastCombatPacing and 0.2 or 0.35
    NoCombatRecoveryRepositionRatio       = FastCombatPacing and 0.45 or 0.7
    MeleeApproachRetargetSeconds          = FastCombatPacing and 1.5 or 5
    MeleeApproachMovePulseSeconds         = FastCombatPacing and 0.4 or 1.0
    MountTravelMinDistance                = FastCombatPacing and 20 or 24
    MountToggleCooldownSeconds            = FastCombatPacing and 1.0 or 2.2
    MountRetryCooldownSeconds             = FastCombatPacing and 0.35 or 1.2
    DismountRetryCooldownSeconds          = FastCombatPacing and 0.25 or 0.8
    DynamicZoneSelectionEnabled           = true
    ZoneNoFateBlockSeconds                = 180
    UnresponsiveLevelSyncEarlySkipSeconds = 16
    UnresponsiveNoTargetSkipSeconds       = FastCombatPacing and 5 or 10
    UnresponsiveSkipRatio                 = 0.65
    FateResultSummaryWriteIntervalSeconds = 30
    MiddleDismountForceAfterSeconds       = 1.8
    PreAcquireDistance                    = FastCombatPacing and 250 or 130
    PreAcquireAttemptIntervalSeconds      = FastCombatPacing and 0.35 or 1.2
    FateTargetRadiusPadding               = 3
    FateMoveBoundaryBuffer                = 3
    FateHardBoundaryBuffer                = 14
    FateLevelSyncTargetRadiusPadding      = 0.5
    FateLevelSyncBoundaryBuffer           = 2
    FateLevelSyncHardBoundaryBuffer       = 2.5
    LeashSafeRetargetBuffer               = 18
    LevelSyncInRangeBuffer                = 1.5
    LevelSyncForceCenterAfterFailures     = 2
    LevelSyncCenterApproachSeconds        = 2.5
    LevelSyncOutOfRangeForceRepathSeconds = 7
    FinisherFallbackProgressThreshold     = 97
    FinisherRemainingMultiplier           = 1.15
    FinisherMinRemainingWindow            = 0.8
    FinisherMaxSampleDelta                = 25
    DynamicAoeSwitchCooldownSeconds       = FastCombatPacing and 0.8 or 1.6
    DynamicAoeEnableStableSamples         = FastCombatPacing and 1 or 2
    DynamicAoeDisableStableSamples        = FastCombatPacing and 2 or 3
    DynamicAoeMixedPackMinimumEnemies     = 2
    PreferUnengagedFateTargets            = not (TargetEngagedEnemies == true)
    TargetAcquireRetrySeconds             = FastCombatPacing and 0.15 or 0.9
    TargetAcquireStopNavSeconds           = FastCombatPacing and 0.5 or 2.4
    CombatOpenNoCombatGraceSeconds        = FastCombatPacing and 0.25 or 0.8
    CombatOpenPulseSeconds                = FastCombatPacing and 0.35 or 0.8
    CombatOpenActionRetrySeconds          = FastCombatPacing and 0.4 or 0.9
    CombatOpenActionMaxRange              = 20.5
    CombatOpenRetargetSeconds             = FastCombatPacing and 0.5 or 2.2
    MeleeApproachHardRecoverSeconds       = FastCombatPacing and 2.5 or 6.5
    MeleeApproachForceGapDistance         = FastCombatPacing and 5 or 8
    MeleeApproachHardRecoverCooldown      = FastCombatPacing and 0.8 or 2.6
    WrathKeepAliveEnabled                 = true
    WrathKeepAliveIntervalSeconds         = FastCombatPacing and 1.0 or 2.8
    WrathStallRecoverySeconds             = FastCombatPacing and 1.5 or 4.2
    --ClassForBossFates                = ""            --If you want to use a different class for boss fates, set this to the 3 letter abbreviation

    -- Variable initialzation
    StopScript                            = false
    DidFate                               = false
    NeedsGysahlGreens                     = false
    ChocoboLastSummonAttemptAt            = 0
    ChocoboSummonFailureCount             = 0
    ChocoboSummonDisabled                 = false
    ChocoboSummonExpiresAt                = nil
    ChocoboLastDebugAt                    = 0
    ChocoboLastCheckDebugAt               = 0
    RsrDynamicSingleApplied               = false
    VbmAiActive                           = false
    GemAnnouncementLock                   = false
    DeathAnnouncementLock                 = false
    MovingAnnouncementLock                = false
    SuccessiveInstanceChanges             = 0
    LastInstanceChangeTimestamp           = 0
    LastTeleportTimeStamp                 = 0
    NoCombatStartTime                     = nil
    LastMoveTimestamp                     = os.clock()
    LastMovePosition                      = nil
    GotCollectionsFullCredit              = false
    WaitingForFateRewards                 = nil
    LastFateEndTime                       = os.clock()
    LastStuckCheckTime                    = os.clock()
    local initialPosition                 = GetLocalPlayerPosition()
    LastStuckCheckPosition                = initialPosition or Vector3(0, 0, 0)
    ExchangeMoveLastCheckTime             = 0
    ExchangeMoveLastPosition              = nil
    ExchangeMoveStuckCount                = 0
    ExchangeMoveLastDistanceToShop        = nil
    ExchangeMoveGraceUntil                = 0
    MoveStuckLastCheckTime                = 0
    MoveStuckLastPosition                 = nil
    MoveStuckCount                        = 0
    MoveStuckLastDistanceToTarget         = nil
    MainClass                             = Player.Job
    BossFatesClass                        = nil
    BicolorGemExchangeThreshold           = 1400
    ClusterMoveLastRefresh                = 0
    ClusterMoveCachedFateId               = nil
    ClusterMoveCachedPosition             = nil
    SessionStartClock                     = os.clock()
    SessionStartGemCount                  = Inventory.GetItemCount(26807)
    SessionFatesStarted                   = 0
    SessionFatesCompleted                 = 0
    SessionFatesFailed                    = 0
    SessionStuckRepathCount               = 0
    SessionStuckAetheryteCount            = 0
    SessionStuckZoneSwitchCount           = 0
    SessionStopReason                     = nil
    FoodAutoUseDisabled                   = false
    PotionAutoUseDisabled                 = false
    LifestreamBusyWarned                  = false
    VnavReadyCheckWarned                  = false
    NativeItemCommandDisabled             = true
    NativeItemCommandWarned               = false
    BossModPresetMissingWarned            = false
    LastProcessedState                    = nil
    LevelSyncGearsetActive                = false
    CurrentlyEquippedGearset              = nil
    GearsetSwitchRetryCount               = 0
    LastMoveToFateId                      = nil
    InitialSetupLastTerritoryType         = nil
    InitialSetupTeleportStartAt           = nil
    InitialSetupTeleportDone              = false
    TeleportFailureByDestination          = {}
    TeleportFailureWarnedAt               = 0
    LastLevelSyncAttemptAt                = 0
    LevelSyncFailureCount                 = 0
    LevelSyncNextAttemptAt                = 0
    LevelSyncHardCooldownUntil            = 0
    LevelSyncWaitFateId                   = nil
    LevelSyncWaitStartedAt                = 0
    LevelSyncWasInRange                   = false
    LevelSyncReentryAttemptPending        = false
    LevelSyncOutOfRangeNoProgressSince    = nil
    LevelSyncOutOfRangeLastDistance       = nil
    FinisherEstimateFateId                = nil
    FinisherEstimateLastProgress          = nil
    FinisherEstimatedSingleKillGain       = nil
    PrefetchedNextFateId                  = nil
    PrefetchedNextFateAt                  = 0
    FatePrefetchLastAttemptAt             = 0
    CombatStartBoostUntil                 = 0
    CombatStartBoostFateId                = nil
    NoCombatRecoveryStage                 = 0
    NoCombatRecoveryFateId                = nil
    NoCombatRecoveryLastActionAt          = 0
    NoCombatNoTargetSince                 = 0
    TargetAcquireNoTargetSince            = 0
    TargetAcquireLastAttemptAt            = 0
    CombatOpenTargetSignature             = nil
    CombatOpenTargetSince                 = 0
    CombatOpenLastPulseAt                 = 0
    CombatOpenLastActionAt                = 0
    CombatOpenActionSequence              = 0
    MeleeEngageTargetSignature            = nil
    MeleeEngageStartAt                    = 0
    MeleeEngageLastMoveAt                 = 0
    MeleeEngageNextRetargetAt             = 0
    MeleeEngageLastHardRecoverAt          = 0
    PreAcquireFateId                      = nil
    PreAcquireLastAttemptAt               = 0
    DynamicAoeDecisionMode                = nil
    DynamicAoeDecisionCount               = 0
    DynamicAoeLastSwitchAt                = 0
    MiddleDismountFateId                  = nil
    MiddleDismountStartedAt               = 0
    MiddleDismountNoTargetSince           = 0
    WrathKeepAliveLastPulseAt             = 0
    WrathKeepAliveNoCastSince             = 0
    WrathKeepAliveLastTargetSignature     = nil
    WrathKeepAliveFateId                  = nil
    WrathAutoEnabled                      = true
    LastMountCommandAt                    = 0
    LastDismountCommandAt                 = 0
    FateTimingById                        = {}
    FateResultLogPath                     = "Fates/fates_results.jsonl"
    FateResultLogResolvedPath             = FateResultLogPath
    FateResultLogError                    = false
    FateResultLogLastOpenErrorAt          = 0
    FateResultSummaryByKey                = {}
    FateResultSummaryDirty                = false
    FateResultSummaryLastWriteAt          = 0
    FateResultSummaryCsvPath              = "Fates/fates_results_summary.csv"
    FateResultSummaryCsvResolvedPath      = FateResultSummaryCsvPath
    FateResultSummaryLastOpenErrorAt      = 0
    ZonePerformanceById                   = {}
    ZoneSelectionLastSwitchAt             = 0
    TeleportDecisionLastFateId            = nil
    TeleportDecisionPreferAetheryte       = false
    BonusBuffNoEligibleSince              = 0
    BonusBuffHoldWindowExpiredAnnounced   = false

    --Forlorns
    IgnoreForlorns                        = false
    IgnoreBigForlornOnly                  = false
    Forlorns                              = string.lower(Config.Get("Forlorns"))
    if Forlorns == "none" then
        IgnoreForlorns = true
    elseif Forlorns == "small" then
        IgnoreBigForlornOnly = true
    end
    -- Rotation plugin
    local configRotationPlugin = string.lower(Config.Get("Rotation Plugin"))
    if configRotationPlugin == "any" then
        if HasPlugin("WrathCombo") then
            RotationPlugin = "Wrath"
        elseif HasPlugin("RotationSolver") then
            RotationPlugin = "RSR"
        elseif HasPlugin("BossModReborn") then
            RotationPlugin = "BMR"
        elseif HasPlugin("BossMod") then
            RotationPlugin = "VBM"
        end
    elseif configRotationPlugin == "wrath" and HasPlugin("WrathCombo") then
        RotationPlugin = "Wrath"
    elseif configRotationPlugin == "rotationsolver" and HasPlugin("RotationSolver") then
        RotationPlugin = "RSR"
    elseif configRotationPlugin == "bossmodreborn" and HasPlugin("BossModReborn") then
        RotationPlugin = "BMR"
    elseif configRotationPlugin == "bossmod" and HasPlugin("BossMod") then
        RotationPlugin = "VBM"
    else
        local msg = "ERROR: Invalid Rotation Plugin selected or plugin not installed! Aborting."
        yield("/echo [FATE] " .. msg)
        SendDiscordMessage(msg)
        SetStopReason(msg)
        StopScript = true
    end
    RSRAoeType                 = "Full" --Options: Cleave/Full/Off

    -- For BMR/VBM/Wrath rotation plugins
    RotationSingleTargetPreset = NormalizePresetName(Config.Get("Single Target Rotation")) --Preset name with single target strategies (for forlorns). TURN OFF AUTOMATIC TARGETING FOR THIS PRESET
    RotationAoePreset          = NormalizePresetName(Config.Get("AoE Rotation"))           --Preset with AOE + Buff strategies.
    RotationHoldBuffPreset     = NormalizePresetName(Config.Get("Hold Buff Rotation"))     --Preset to hold 2min burst when progress gets to seleted %
    BossModAiPreset            = NormalizePresetName(Config.Get("BossMod AI Preset"))
    if BossModAiPreset == "" then
        BossModAiPreset = "VBM Multibox"
    end
    PercentageToHoldBuff       = Config.Get("Percentage to Hold Buff")                     --Ideally youll want to make full use of your buffs, higher than 70% will still waste a few seconds if progress is too fast.
    if RotationPlugin == "BMR" or RotationPlugin == "VBM" then
        RotationAoePreset = SelectPresetName(RotationAoePreset, RotationSingleTargetPreset, RotationHoldBuffPreset)
        RotationSingleTargetPreset = SelectPresetName(RotationSingleTargetPreset, RotationAoePreset,
            RotationHoldBuffPreset)
        RotationHoldBuffPreset = SelectPresetName(RotationHoldBuffPreset, RotationSingleTargetPreset, RotationAoePreset)
        if RotationAoePreset == "" then
            yield(
                "/echo [FATE] Warning: AoE/Single/Hold preset are all empty. BMR/VBM actions (including defensives) can become unstable.")
        end
    end

    -- Dodge plugin
    local dodgeConfig = string.lower(Config.Get("Dodging Plugin")) -- Options: Any / BossModReborn / BossMod / None

    -- Resolve "any" or specific plugin if available
    if dodgeConfig == "any" then
        if HasPlugin("BossModReborn") then
            DodgingPlugin = "BMR"
        elseif HasPlugin("BossMod") then
            DodgingPlugin = "VBM"
        else
            DodgingPlugin = "None"
        end
    elseif dodgeConfig == "bossmodreborn" and HasPlugin("BossModReborn") then
        DodgingPlugin = "BMR"
    elseif dodgeConfig == "bossmod" and HasPlugin("BossMod") then
        DodgingPlugin = "VBM"
    else
        DodgingPlugin = "None"
    end

    -- Override if RotationPlugin already uses a dodging plugin
    if RotationPlugin == "BMR" then
        DodgingPlugin = "BMR"
    elseif RotationPlugin == "VBM" then
        DodgingPlugin = "VBM"
    end

    -- Final warning if no dodging plugin is active
    if DodgingPlugin == "None" then
        yield(
            "/echo [FATE] Warning: you do not have an AI dodging plugin configured, so your character will stand in AOEs. Please install either Veyn's BossMod or BossMod Reborn")
    end

    --Post Fate Settings
    MinWait                        = FastCombatPacing and 0.01 or
        3                                  --Min number of seconds it should wait until mounting up for next fate.
    MaxWait                        = FastCombatPacing and 0.1 or
        10                                 --Max number of seconds it should wait until mounting up for next fate.
    --Actual wait time will be a randomly generated number between MinWait and MaxWait.
    DownTimeWaitAtNearestAetheryte = false --When waiting for fates to pop, should you fly to the nearest Aetheryte and wait there?
    MoveToRandomSpot               = false --Randomly fly to spot while waiting on fate.
    InventorySlotsLeft             = 5     --how much inventory space before turning in
    WaitIfBonusBuff                = true  --Dont change instances if you have the Twist of Fate bonus buff
    BonusBuffHoldMaxWaitSeconds    = FastCombatPacing and 35 or 45
    NumberOfInstances              = 3
    RemainingDurabilityToRepair    = 10   --the amount it needs to drop before Repairing (set it to 0 if you don't want it to repair)
    ShouldAutoBuyDarkMatter        = true --Automatically buys a 99 stack of Grade 8 Dark Matter from the Limsa gil vendor if you're out
    ShouldExtractMateria           = true --should it Extract Materia

    -- Config settings
    EnableChangeInstance           = Config.Get("Change instances if no FATEs?")
    AutoTeleportToNextZone         = Config.Get("Teleport to next zone if no FATEs?")
    StayOnCurrentMapOnly           = Config.Get("Stay on current map only?")
    ShouldExchangeBicolorGemstones = Config.Get("Exchange bicolor gemstones?")
    ItemToPurchase                 = Config.Get("Exchange bicolor gemstones for")
    if ItemToPurchase == "None" then
        ShouldExchangeBicolorGemstones = false
    end
    ReturnOnDeath                   = Config.Get("Return on death?")
    SelfRepair                      = Config.Get("Self repair?")
    Retainers                       = Config.Get("Pause for retainers?")
    ShouldGrandCompanyTurnIn        = Config.Get("Dump extra gear at GC?")
    Echo                            = string.lower(Config.Get("Echo logs"))
    CompanionScriptMode             = Config.Get("Companion Script Mode")
    DiscordWebhookUrl               = Config.Get("Discord Webhook URL")
    SummonChocobo                   = Config.Get("Summon Chocobo?")
    ShouldAutoBuyGysahlGreens       = Config.Get("Auto-buy Gysahl Greens?")
    LevelSyncTankGearset            = Config.Get("Tank Gearset for Level Sync")
    NormalFateGearset               = Config.Get("Normal FATE Gearset")
    InitialSetupTeleportZone        = Config.Get("Initial setup teleport zone")
    SummonChocoboOnStart            = Config.Get("Summon chocobo on start?")
    SwitchToNormalGearsetOnStart    = Config.Get("Switch to normal gearset on start?")

    -- Party Play settings
    PartyPlayMode                   = Config.Get("Party Play Mode")
    AutoDetectPartyMembers          = Config.Get("Auto Detect Party Members")
    PrioritizePartyMemberTargets    = Config.Get("Prioritize Party Member Targets")
    PrioritizeFatesWithPartyMembers = Config.Get("Prioritize FATEs with Party Members")
    DisableChocoboInParty           = Config.Get("Disable Chocobo in Party")
    FollowPartyMembers              = Config.Get("Follow Party Members")

    -- 出現中FATEデータ保存
    FateDataLogEnabled              = ParseBool(Config.Get("Save active FATE data?"), true)
    FateDataLogIntervalSeconds      = tonumber(Config.Get("FATE data log interval (secs)"))
    FateDataLogPath                 = NormalizeFateLogValue(Config.Get("FATE data log path"))
    if FateDataLogIntervalSeconds == nil or FateDataLogIntervalSeconds < 1 then
        FateDataLogIntervalSeconds = 30
    else
        FateDataLogIntervalSeconds = math.floor(FateDataLogIntervalSeconds)
    end
    if FateDataLogPath == "" then
        FateDataLogPath = "Fates/fates_active.jsonl"
    end
    FateDataLogResolvedPath, _ = ResolveWritableFateLogPath(FateDataLogPath)
    if FateDataLogResolvedPath == nil or FateDataLogResolvedPath == "" then
        FateDataLogResolvedPath = "fates_active.jsonl"
    elseif FateDataLogResolvedPath ~= FateDataLogPath then
        Dalamud.Log("[FATE] FATE data log path fallback in use: " .. tostring(FateDataLogResolvedPath))
    end
    FateDataLogLastTime = 0
    FateDataLogLastSignature = nil
    FateDataLogError = false
    FateDataLogLastOpenErrorAt = 0
    FateResultLogPath = "Fates/fates_results.jsonl"
    FateResultLogResolvedPath, _ = ResolveWritableFateLogPath(FateResultLogPath)
    if FateResultLogResolvedPath == nil or FateResultLogResolvedPath == "" then
        FateResultLogResolvedPath = "fates_results.jsonl"
    elseif FateResultLogResolvedPath ~= FateResultLogPath then
        Dalamud.Log("[FATE] FATE result log path fallback in use: " .. tostring(FateResultLogResolvedPath))
    end
    FateResultLogError = false
    FateResultLogLastOpenErrorAt = 0
    FateResultSummaryCsvPath = "Fates/fates_results_summary.csv"
    FateResultSummaryCsvResolvedPath, _ = ResolveWritableSummaryLogPath(FateResultSummaryCsvPath)
    if FateResultSummaryCsvResolvedPath == nil or FateResultSummaryCsvResolvedPath == "" then
        FateResultSummaryCsvResolvedPath = "fates_results_summary.csv"
    elseif FateResultSummaryCsvResolvedPath ~= FateResultSummaryCsvPath then
        Dalamud.Log("[FATE] FATE result summary path fallback in use: " .. tostring(FateResultSummaryCsvResolvedPath))
    end
    FateResultSummaryLastOpenErrorAt = 0
    LoadFateResultSummaryFromLog()
    WriteFateResultSummaryCsv(true)

    -- Plugin warnings
    if Retainers and not HasPlugin("AutoRetainer") then
        Retainers = false
        yield(
            "/echo [FATE] Warning: you have enabled the feature to process retainers, but you do not have AutoRetainer installed.")
    end

    if ShouldGrandCompanyTurnIn and not HasPlugin("AutoRetainer") then
        ShouldGrandCompanyTurnIn = false
        yield(
            "/echo [FATE] Warning: you have enabled the feature to process GC turn ins, but you do not have AutoRetainer installed.")
    end

    local ipcOk, ipcErr = ValidateRequiredIpc()
    if not ipcOk then
        local msg = "ERROR: Required IPC unavailable - " .. tostring(ipcErr) .. ". Stopping script."
        yield("/echo [FATE] " .. msg)
        Dalamud.Log("[FATE] " .. msg)
        SendDiscordMessage(msg)
        SetStopReason(msg)
        StopScript = true
        return
    end

    -- Enable Auto Advance plugin
    yield("/at y")

    -- Functions
    --Set combat max distance
    SetMaxDistance()

    --Set selected zone
    while SelectedZone == nil or SelectedZone.zoneId == nil or SelectedZone.zoneId == 0 do
        SelectedZone = SelectNextZone()
        if SelectedZone == nil or SelectedZone.zoneId == nil or SelectedZone.zoneId == 0 then
            Dalamud.Log("[FATE] Waiting for valid zone ID...")
            yield("/wait 1")
        end
    end

    if SelectedZone.zoneName ~= "" and Echo == "all" then
        yield("/echo [FATE] Farming " .. SelectedZone.zoneName)
    end
    Dalamud.Log("[FATE] Farming Start for " .. SelectedZone.zoneName)

    if ShouldExchangeBicolorGemstones ~= false then
        Dalamud.Log("[FATE] Looking for item: " .. ItemToPurchase)
        Dalamud.Log("[FATE] BicolorExchangeData count: " .. tostring(#BicolorExchangeData))
        for _, shop in ipairs(BicolorExchangeData) do
            if shop.shopItems[ItemToPurchase] ~= nil then
                SelectedBicolorExchangeData = {
                    shopKeepName = shop.shopKeepName,
                    zoneId = shop.zoneId,
                    aetheryteName = shop.aetheryteName,
                    miniAethernet = shop.miniAethernet,
                    position = shop.position,
                    item = shop.shopItems[ItemToPurchase]
                }
                Dalamud.Log("[FATE] Found item in shop: " .. shop.shopKeepName)
                break
            end
        end
        if SelectedBicolorExchangeData == nil then
            yield("/echo [FATE] Cannot recognize bicolor shop item " ..
                ItemToPurchase .. "! Please make sure it's in the BicolorExchangeData table!")
            SetStopReason("Unrecognized bicolor exchange item: " .. tostring(ItemToPurchase))
            StopScript = true
        elseif SelectedBicolorExchangeData.miniAethernet ~= nil and SelectedBicolorExchangeData.miniAethernet.name ~= nil and SelectedBicolorExchangeData.miniAethernet.position == nil then
            local fixedExchangeAetheryte = GetAetheryteInZoneByName(
                SelectedBicolorExchangeData.zoneId,
                SelectedBicolorExchangeData.miniAethernet.name
            )
            if fixedExchangeAetheryte ~= nil then
                SelectedBicolorExchangeData.miniAethernet = fixedExchangeAetheryte
                Dalamud.Log("[FATE] Exchange aetheryte fixed: " .. fixedExchangeAetheryte.name)
            else
                Dalamud.Log("[FATE] Exchange aetheryte fixed name not found: " ..
                    tostring(SelectedBicolorExchangeData.miniAethernet.name))
                SelectedBicolorExchangeData.miniAethernet = nil
            end
        end

        if SelectedBicolorExchangeData ~= nil and SelectedBicolorExchangeData.miniAethernet == nil then
            local closestExchangeAetheryte = GetClosestAetheryteInZoneToPoint(
                SelectedBicolorExchangeData.zoneId,
                SelectedBicolorExchangeData.position
            )
            if closestExchangeAetheryte ~= nil then
                SelectedBicolorExchangeData.miniAethernet = closestExchangeAetheryte
                Dalamud.Log("[FATE] Exchange aetheryte selected: " .. closestExchangeAetheryte.name)
            end
        end
    end

    if InActiveFate() then
        CurrentFate = BuildFateTable(Fates.GetNearestFate())
    end

    Dalamud.Log("[FATE] Starting fate farming script.")
    Dalamud.Log("[FATE] Initializing character state...")

    State = CharacterState.initialSetup
    CurrentFate = nil

    if CompanionScriptMode then
        yield("/echo The companion script will overwrite changing instances.")
        EnableChangeInstance = false
    end

    Dalamud.Log("[FATE-FIXED] Entering main loop...")
    while not StopScript do
        local lp = (ClientState ~= nil and ClientState.LocalPlayer) or
            (Svc ~= nil and Svc.ClientState ~= nil and Svc.ClientState.LocalPlayer) or
            (Player ~= nil and Player.Available == true and Player)
        local isPlayerAvailable = lp ~= nil and type(lp) == "table"

        if not isPlayerAvailable then
            if os.clock() % 10 < 0.3 then
                Dalamud.Log("[FATE-FIXED] Waiting for player to be available... (Player=" ..
                    tostring(Player) .. ", Svc=" .. tostring(Svc) .. ")")
            end
            yield("/wait 1")
        else
            SprintCheck()
            local nearestFate = Fates.GetNearestFate()
            if not IsVnavmeshReadySafe() then
                yield("/echo [FATE] Waiting for vnavmesh to build...")
                Dalamud.Log("[FATE] Waiting for vnavmesh to build...")
                local vnavWaitStart = os.clock()
                repeat
                    yield("/wait 2")
                    if os.clock() - vnavWaitStart > 10 then
                        Dalamud.Log("[FATE] Still waiting for vnavmesh to build (elapsed: " ..
                            math.floor(os.clock() - vnavWaitStart) .. "s)")
                        vnavWaitStart = os.clock()
                    end
                until IsVnavmeshReadySafe()
                Dalamud.Log("[FATE] vnavmesh is now ready.")
            end
            if NoMovementTeleportTimeout > 0 then
                local currentPos = GetLocalPlayerPosition()
                if currentPos == nil then
                    LastMovePosition = nil
                    LastMoveTimestamp = os.clock()
                else
                    if LastMovePosition == nil then
                        LastMovePosition = currentPos
                        LastMoveTimestamp = os.clock()
                    else
                        local moveDist = DistanceBetween(currentPos, LastMovePosition)
                        if moveDist > 1 then
                            LastMovePosition = currentPos
                            LastMoveTimestamp = os.clock()
                        else
                            local navBusy = IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning()
                            local stateBlocksIdleRecovery = State == CharacterState.dead
                                or State == CharacterState.initialSetup
                                or State == CharacterState.waitForContinuation
                                or State == CharacterState.collectionsFateTurnIn
                                or State == CharacterState.processRetainers
                                or State == CharacterState.repair
                                or State == CharacterState.exchangingVouchers
                                or State == CharacterState.gcTurnIn
                                or State == CharacterState.extractMateria
                                or State == CharacterState.changingInstances
                                or State == CharacterState.changeInstanceDismount
                            local shouldCheckIdle = not Svc.Condition[CharacterCondition.inCombat]
                                and not Svc.Condition[CharacterCondition.betweenAreas]
                                and not Svc.Condition[CharacterCondition.betweenAreasForDuty]
                                and not Svc.Condition[CharacterCondition.casting]
                                and not Svc.Condition[CharacterCondition.occupied]
                                and not Svc.Condition[CharacterCondition.occupiedInEvent]
                                and not Svc.Condition[CharacterCondition.occupiedInQuestEvent]
                                and not Svc.Condition[CharacterCondition.occupiedMateriaExtractionAndRepair]
                                and not Svc.Condition[CharacterCondition.occupiedSummoningBell]
                                and not stateBlocksIdleRecovery
                                and not IsLifestreamBusySafe()
                                and not navBusy
                            if shouldCheckIdle and os.clock() - LastMoveTimestamp >= NoMovementTeleportTimeout then
                                local shouldPreserveBonusBuff = ShouldPreserveBonusBuffForZoneSwitch(true)
                                local timeoutZoneName = (SelectedZone and SelectedZone.zoneName) or "Unknown Zone"
                                local timeoutMsg = string.format(
                                    "[FATE] No-movement timeout triggered in zone: %s",
                                    tostring(timeoutZoneName)
                                )
                                local currentFateStillInProgress = false
                                if CurrentFate ~= nil and IsFateActive(CurrentFate.fateObject) then
                                    local currentProgress = GetFateProgressValue(CurrentFate, nil)
                                    currentFateStillInProgress = currentProgress ~= nil and currentProgress < 100
                                end
                                Dalamud.Log(timeoutMsg)
                                SendDiscordMessage(timeoutMsg)
                                if currentFateStillInProgress then
                                    Dalamud.Log(
                                        "[FATE] No movement detected, but current fate is still active. Repathing to fate instead of switching."
                                    )
                                    LastMoveTimestamp = os.clock()
                                    LastMovePosition = currentPos
                                    SafeYield("/vnav stop")
                                    local recoveryPos = GetPreferredFateMovePosition(CurrentFate) or CurrentFate
                                        .position
                                    if recoveryPos ~= nil then
                                        IPC.vnavmesh.PathfindAndMoveTo(recoveryPos, Player.CanFly and SelectedZone
                                            .flying)
                                        State = CharacterState.moveToFate
                                    else
                                        State = CharacterState.ready
                                    end
                                else
                                    if StayOnCurrentMapOnly then
                                        Dalamud.Log(
                                            "[FATE] No movement detected. Staying in current map due to setting.")
                                    else
                                        Dalamud.Log("[FATE] No movement detected. Switching zones.")
                                    end
                                    LastMoveTimestamp = os.clock()
                                    LastMovePosition = currentPos
                                    SafeYield("/vnav stop")
                                    if StayOnCurrentMapOnly or shouldPreserveBonusBuff then
                                        if shouldPreserveBonusBuff and not StayOnCurrentMapOnly then
                                            Dalamud.Log(
                                                "[FATE] Preserving Twist of Fate buff: skip zone switch for no-movement timeout.")
                                        end
                                        CurrentFate = nil
                                        NextFate = nil
                                    else
                                        SelectNextDawntrailZone()
                                    end
                                    State = CharacterState.ready
                                end
                            end
                        end
                    end
                end
            end

            if NoCombatTeleportTimeout > 0
                and State ~= CharacterState.doFate
                and CurrentFate ~= nil
                and not CurrentFate.isCollectionsFate
                and not CurrentFate.isOtherNpcFate
            then
                local navBusy = IPC.vnavmesh.PathfindInProgress() or IPC.vnavmesh.IsRunning()
                local progress = GetFateProgressValue(CurrentFate, nil)
                local radius = GetFateRadiusValue(CurrentFate, nil)
                local inRange = IsFateActive(CurrentFate.fateObject)
                    and progress ~= nil
                    and progress < 100
                    and radius ~= nil
                    and (GetDistanceToPoint(CurrentFate.position) <= radius + 12)
                local shouldTrackNoCombat = inRange
                    and not Svc.Condition[CharacterCondition.inCombat]
                    and not Svc.Condition[CharacterCondition.betweenAreas]
                    and not Svc.Condition[CharacterCondition.betweenAreasForDuty]
                    and not Svc.Condition[CharacterCondition.casting]
                    and not Svc.Condition[CharacterCondition.occupied]
                    and not IsLifestreamBusySafe()
                    and not navBusy
                if shouldTrackNoCombat then
                    if NoCombatStartTime == nil then
                        NoCombatStartTime = os.clock()
                    elseif os.clock() - NoCombatStartTime >= NoCombatTeleportTimeout then
                        local shouldPreserveBonusBuff = ShouldPreserveBonusBuffForZoneSwitch(true)
                        local timedOutFateName = (CurrentFate and CurrentFate.fateName) or "Unknown FATE"
                        local timedOutFateId = (CurrentFate and CurrentFate.fateId) or 0
                        local timeoutMsg = string.format(
                            "[FATE] Global no-combat timeout triggered on FATE #%s: %s",
                            tostring(timedOutFateId),
                            tostring(timedOutFateName)
                        )
                        Dalamud.Log(timeoutMsg)
                        SendDiscordMessage(timeoutMsg)
                        RecordZoneUnresponsiveSkip(Svc.ClientState.TerritoryType, "global_no_combat_timeout")
                        if StayOnCurrentMapOnly then
                            Dalamud.Log(
                                "[FATE] No combat started within timeout. Staying in current map due to setting.")
                        else
                            Dalamud.Log("[FATE] No combat started within timeout. Switching zones.")
                        end
                        ResetNoCombatRecoveryState()
                        LastMoveTimestamp = os.clock()
                        LastMovePosition = GetLocalPlayerPosition()
                        SafeYield("/vnav stop")
                        if StayOnCurrentMapOnly or shouldPreserveBonusBuff then
                            if shouldPreserveBonusBuff and not StayOnCurrentMapOnly then
                                Dalamud.Log(
                                    "[FATE] Preserving Twist of Fate buff: skip zone switch for global no-combat timeout.")
                            end
                            CurrentFate = nil
                            NextFate = nil
                        else
                            SelectNextDawntrailZone()
                        end
                        State = CharacterState.ready
                    end
                elseif not inRange then
                    ResetNoCombatRecoveryState()
                end
            end

            if State ~= CharacterState.dead and Svc.Condition[CharacterCondition.dead] then
                State = CharacterState.dead
                Dalamud.Log("[FATE] State Change: Dead")
            elseif State ~= CharacterState.unexpectedCombat
                and State ~= CharacterState.doFate
                and State ~= CharacterState.waitForContinuation
                and State ~= CharacterState.collectionsFateTurnIn
                and Svc.Condition[CharacterCondition.inCombat]
                and (
                    not InActiveFate()
                    or (InActiveFate() and nearestFate ~= nil and IsCollectionsFate(nearestFate.Name) and nearestFate.Progress == 100)
                )
            then
                State = CharacterState.unexpectedCombat
                Dalamud.Log("[FATE] State Change: UnexpectedCombat")
            end

            BicolorGemCount = Inventory.GetItemCount(26807)
            MaybeLogActiveFates()
            WriteFateResultSummaryCsv(false)

            if WaitingForFateRewards ~= nil then
                NoteFateCombatStart(WaitingForFateRewards)
                local state = WaitingForFateRewards.fateObject and WaitingForFateRewards.fateObject.State or nil
                if WaitingForFateRewards.fateObject == nil
                    or state == nil
                    or state == FateState.Ended
                    or state == FateState.Failed
                then
                    if state == FateState.Ended then
                        SessionFatesCompleted = SessionFatesCompleted + 1
                    elseif state == FateState.Failed then
                        SessionFatesFailed = SessionFatesFailed + 1
                    end
                    FinalizeFateTimingLog(WaitingForFateRewards, state)
                    local msg = "[FATE] WaitingForFateRewards.fateObject is nil or fate state (" ..
                        tostring(state) ..
                        ") indicates fate is finished for fateId: " ..
                        tostring(WaitingForFateRewards.fateId) .. ". Clearing it."
                    Dalamud.Log(msg)
                    if Echo == "all" then
                        yield("/echo " .. msg)
                    end
                    WaitingForFateRewards = nil
                else
                    local now_waiting = os.clock()
                    if WaitingForFateRewardsLastEchoAt == nil or (now_waiting - WaitingForFateRewardsLastEchoAt) >= 10 then
                        WaitingForFateRewardsLastEchoAt = now_waiting
                        local msg = "[FATE] Not clearing WaitingForFateRewards: fate state=" ..
                            tostring(state) ..
                            ", expected one of [Ended: " ..
                            tostring(FateState.Ended) .. ", Failed: " .. tostring(FateState.Failed) .. "] or nil."
                        Dalamud.Log(msg)
                        if Echo == "all" then
                            yield("/echo " .. msg)
                        end
                    end
                end
            end
            if not (Svc.Condition[CharacterCondition.betweenAreas]
                    or Svc.Condition[CharacterCondition.occupiedMateriaExtractionAndRepair]
                    or IsLifestreamBusySafe())
            then
                -- Party Play: global teleport acceptance (runs regardless of state)
                if GetPartyPlayActive() and FollowPartyLeaderZone == true then
                    AcceptTeleportOfferLocation("")
                end

                local stateOk, stateErr = pcall(State)
                if not stateOk then
                    Dalamud.Log("[FATE] State handler error: " .. tostring(stateErr))
                    yield("/echo [FATE] State handler error, resetting to ready: " .. tostring(stateErr))
                    State = CharacterState.ready
                end
            end
        end
        yield("/wait " .. tostring(MainLoopWaitSeconds or 0.25))
    end
    if SessionStopReason == nil then
        SetStopReason("StopScript flag set")
    end
    SafeYield("/vnav stop")
    WriteFateResultSummaryCsv(true)
    PrintSessionSummary()

    if Player.Job.Id ~= MainClass.Id then
        SafeYield("/gs change " .. MainClass.Name)
    end

    yield("/echo [Fate] Loop Ended !!")
end

--#endregion Main

local runOk, runErr = pcall(function() FateFarming:new():Run() end)
if not runOk then
    yield("/echo [FATE] Fatal script error: " .. tostring(runErr))
end
