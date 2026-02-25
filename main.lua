-- BLOX FRUITS AUTO FARM SCRIPT
-- TÜM SORUMLULUK KULLANICIYA AİTTİR!
-- Eğitim amaçlıdır, çalışacağının garantisi yok.

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Blox Fruits Auto Farm", "DarkTheme")

-- AUTO FARM TAB
local FarmTab = Window:NewTab("Auto Farm")
local FarmSection = FarmTab:NewSection("Farm Kontrolleri")

-- Değişkenler
_G.AutoFarm = false
_G.AutoQuest = false
_G.AutoKill = false

-- AUTO FARM TOGGLE (Ana açma/kapama)
FarmSection:NewToggle("Auto Farm (AÇ/KAPA)", "Tüm farm sistemini açar/kapatır", function(state)
    _G.AutoFarm = state
    print("Auto Farm: " .. tostring(state))
    
    if _G.AutoFarm then
        -- Farm döngüsünü başlat
        spawn(function()
            while _G.AutoFarm do
                wait(2) -- 2 saniye bekle (fazla zorlama)
                
                -- Seviyeye göre işlem yap
                local player = game.Players.LocalPlayer
                local level = player.Data.Level.Value
                
                -- Seviyeye göre NPC seç
                local targetNPC = nil
                local questGiver = nil
                
                if level < 10 then
                    -- Bandit NPC
                    questGiver = "BanditQuestGiver"
                    targetNPC = "Bandit"
                elseif level < 30 then
                    -- Monkey NPC
                    questGiver = "MonkeyQuestGiver"
                    targetNPC = "Monkey"
                elseif level < 60 then
                    -- Pirate NPC
                    questGiver = "PirateQuestGiver"
                    targetNPC = "Pirate"
                elseif level < 90 then
                    -- Gorilla NPC
                    questGiver = "GorillaQuestGiver"
                    targetNPC = "Gorilla"
                else
                    -- Daha yüksek seviye NPC'ler
                    questGiver = "FishmanQuestGiver"
                    targetNPC = "Fishman"
                end
                
                print("Hedef: " .. targetNPC .. " (Seviye: " .. level .. ")")
                
                -- Görev al (Auto Quest)
                if _G.AutoQuest and questGiver then
                    -- Görev alma kodları
                    takeQuest(questGiver)
                end
                
                -- NPC kes (Auto Kill)
                if _G.AutoKill and targetNPC then
                    -- NPC kesme kodları
                    killNPC(targetNPC)
                end
            end
        end)
    end
end)

-- GÖREV AL TOGGLE
FarmSection:NewToggle("Auto Quest (Görev Al)", "Otomatik görev alır", function(state)
    _G.AutoQuest = state
    print("Auto Quest: " .. tostring(state))
end)

-- NPC KES TOGGLE
FarmSection:NewToggle("Auto Kill (NPC Kes)", "Otomatik NPC keser", function(state)
    _G.AutoKill = state
    print("Auto Kill: " .. tostring(state))
end)

-- GÖREV ALMA FONKSİYONU (ÖRNEK)
function takeQuest(questGiverName)
    local player = game.Players.LocalPlayer
    local character = player.Character
    
    -- Quest vericiyi bul
    local questGiver = workspace:FindFirstChild(questGiverName)
    if questGiver and questGiver:FindFirstChild("HumanoidRootPart") then
        -- Quest vericiye git
        character.HumanoidRootPart.CFrame = questGiver.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
        wait(1)
        
        -- Quest al (bu kısım çalışmayabilir)
        -- Gerçek quest alma için RemoteEvent'leri bulmak gerek
    end
end

-- NPC KESME FONKSİYONU (ÖRNEK)
function killNPC(npcName)
    local player = game.Players.LocalPlayer
    local character = player.Character
    
    -- NPC'leri bul
    for _, npc in pairs(workspace:GetDescendants()) do
        if npc:IsA("Model") and npc.Name:find(npcName) and npc:FindFirstChild("Humanoid") then
            local humanoid = npc.Humanoid
            if humanoid.Health > 0 then
                -- NPC'ye git
                if npc:FindFirstChild("HumanoidRootPart") then
                    character.HumanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame + Vector3.new(0, 5, 5)
                    wait(0.5)
                    
                    -- Saldır (bu kısım çalışmayabilir)
                    -- Gerçek saldırı için tool kullanımı gerek
                    local tool = character:FindFirstChildOfClass("Tool")
                    if tool then
                        tool:Activate()
                    end
                end
            end
        end
    end
end

-- HIZLI BİLGİ
local InfoTab = Window:NewTab("Bilgi")
local InfoSection = InfoTab:NewSection("Oyuncu Bilgisi")

InfoSection:NewLabel("Oyuncu: " .. game.Players.LocalPlayer.Name)
InfoSection:NewLabel("Seviye: " .. game.Players.LocalPlayer.Data.Level.Value)
InfoSection:NewButton("Seviye Yenile", "Seviyeyi günceller", function()
    InfoSection:NewLabel("Seviye: " .. game.Players.LocalPlayer.Data.Level.Value)
end)

-- UYARI
local WarningTab = Window:NewTab("⚠️ UYARI")
local WarningSection = WarningTab:NewSection("OKUMADAN KULLANMA!")

WarningSection:NewLabel("1. Bu script çalışmayabilir!")
WarningSection:NewLabel("2. Hesabın BANLANABİLİR!")
WarningSection:NewLabel("3. Tüm sorumluluk SENDE!")
WarningSection:NewLabel("4. Güncel scriptler pastebin'de")
WarningSection:NewLabel("5. Virüs riski VAR!")

print("Script yüklendi! AÇ/KAPA butonu ile kontrol et.")
