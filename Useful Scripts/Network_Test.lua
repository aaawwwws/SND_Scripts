--[[
    Network_Test.lua
    SND (Something Need Doing) でのネットワーク接続テスト

    機能:
    1. 外部サイト (httpbin.org) にアクセスしてデータを取得する (GET)
    2. Discord Webhook にメッセージを送信する (POST)

    使用方法:
    そのまま実行すれば、GETリクエストのテストが行われます。
    Discord通知を試す場合は、下部の `discord_webhook_url` 変数を書き換えてください。
]]

-- C#のSystem.Net.WebClientクラスをインポート
-- これがSNDでネットワーク通信を行うための鍵です
luanet.load_assembly("System")
local WebClient = luanet.import_type("System.Net.WebClient")
local Encoding = luanet.import_type("System.Text.Encoding")

-- ヘルパー: ログ出力
local function Log(msg, is_data)
    -- データそのものはコンソール(F11 -> Log)にのみ出す
    if is_data then
        Dalamud.Log("[NetworkTest Data] " .. tostring(msg))
        yield("/echo [NetworkTest] データを受信しました。詳細はコンソールを確認してください。")
    else
        Dalamud.Log("[NetworkTest] " .. tostring(msg))
        yield("/echo [NetworkTest] " .. tostring(msg))
    end
end

-- 1. GETリクエストのテスト (データ取得)
local function TestGetRequest()
    Log("GETリクエストをテスト中...", false)

    local client = WebClient()
    -- 文字化け防止のためUTF-8を指定
    client.Encoding = Encoding.UTF8

    -- 安全なパブリックAPIにアクセス (IPアドレスやUserAgentを返すテストサイト)
    local status, result = pcall(function()
        return client:DownloadString("https://httpbin.org/json")
    end)

    client:Dispose()

    if status then
        Log("成功しました！", false)
        -- 結果(JSON)はチャットに出さず、フラグを立ててログのみにする
        Log(result, true)
    else
        Log("失敗しました: " .. tostring(result), false)
    end
end

-- 2. POSTリクエストのテスト (Discord Webhook)
local function SendDiscordMessage(url, message)
    if url == "" or url == "YOUR_WEBHOOK_URL_HERE" then
        Log("Discord Webhook URLが設定されていません。")
        return
    end

    Log("Discordにメッセージを送信中...")

    local client = WebClient()
    client.Encoding = Encoding.UTF8
    client.Headers:Add("Content-Type", "application/json")

    -- JSONペイロードの作成 (簡易的)
    local payload = string.format('{"content": "%s", "username": "SND Bot"}', message)

    local status, result = pcall(function()
        return client:UploadString(url, "POST", payload)
    end)

    client:Dispose()

    if status then
        Log("Discordへの送信に成功しました！")
    else
        Log("Discordへの送信に失敗しました: " .. tostring(result))
    end
end

-- ==========================================
-- メイン処理
-- ==========================================

-- テスト1: 外部サイトへの接続確認
TestGetRequest()

-- テスト2: Discord通知 (試す場合はここを書き換えてください)
local discord_webhook_url =
"https://discord.com/api/webhooks/1464191905742065901/Xo13NZGx-070ENn2Ci9TgflzYWFicgegzVRKsOS8tHvx2sHMhaVJVauURgGTUN5C7rM0" -- 例: "https://discord.com/api/webhooks/..."
local test_message = "SNDスクリプトからのネットワークテストです。"

if discord_webhook_url ~= "" then
    SendDiscordMessage(discord_webhook_url, test_message)
end
