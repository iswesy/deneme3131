-- Ana Menü
local FarmTab = Window:NewTab("Farm")
local FarmSection = FarmTab:NewSection("Kontroller")

-- Değişkenler
_G.FarmActive = false
_G.AutoQuest = false

-- SEVİYE TABLOSU (1-100)
local questTable = {
    {min = 1, max = 10, npc = "Bandit", quest = "BanditQuestGiver", island = "Jungle"},
    {min = 10, max = 20, npc = "Monkey", quest = "MonkeyQuestGiver", island = "Jungle"},
    {min = 20, max = 30, npc = "Pirate", quest = "PirateQuestGiver", island = "PirateVillage"},
    {min = 30, max = 40, npc = "Gorilla", quest = "GorillaQuestGiver", island = "Jungle"},
    {min = 40, max = 50, npc = "Fishman", quest = "FishmanQuestGiver", island = "FishmanIsland"},
    {min = 50, max = 60, npc = "SkyBandit", quest = "SkyBanditQuestGiver", island = "Skyland"},
    {min = 60, max = 70, npc = "DarkMaster", quest = "DarkMasterQuestGiver", island = "DarkArena"},
    {min = 70, max = 80, npc = "SnowBandit", quest = "SnowBanditQuestGiver", island = "SnowIsland"},
    {min = 80, max = 90, npc = "ForestPirate", quest = "ForestPirateQuestGiver", island = "Forest"},
    {min = 90, max = 100, npc = "Marine", quest = "MarineQuestGiver", island = "MarineBase"}
}

-- AUTO FARM TOGGLE
FarmSection:NewToggle("Auto Farm AÇ/KAPA", "Farm sistemini açar/kapatır", function(state)
    _G.FarmActive = state
    print("Auto Farm: " .. tostring(state))
    
    if _G.FarmActive then
        spawn(function()
            while _G.FarmActive do
                wait(1)
                
                local player = game:GetService("Players").LocalPlayer
                local level = player.Data.Level.Value
                
                print("Seviye: " .. level)
                
                -- 100 olduysa dur
                if level >= 100 then
                    _G.FarmActive = false
                    print("Level 100 oldu! Farm durdu.")
                    break
                end
                
                -- Seviyeye uygun görev bul
                local currentQuest = nil
                for _, quest in ipairs(questTable) do
                    if level >= quest.min and level <= quest.max then
                        currentQuest = quest
                        break
                    end
                end
                
                if currentQuest then
                    -- Görev al
                    if _G.AutoQuest then
                        takeQuest(currentQuest.quest)
                        wait(0.5)
                    end
                    
                    -- NPC kes
                    killNPC(currentQuest.npc)
                end
            end
        end)
    end
end)

-- OTOMATİK GÖREV TOGGLE
FarmSection:NewToggle("Otomatik Görev AÇ/KAPA", "Görevleri otomatik alır", function(state)
    _G.AutoQuest = state
    print("Auto Quest: " .. tostring(state))
end)

-- GÖREV AL FONKSİYONU
function takeQuest(questGiverName)
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character
    
    if not character then return end
    
    local questGiver = workspace:FindFirstChild(questGiverName)
    if questGiver and questGiver:FindFirstChild("HumanoidRootPart") then
        -- Görev vericiye git
        character.HumanoidRootPart.CFrame = questGiver.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
        wait(0.5)
        
        -- Görev almayı dene
        if questGiver:FindFirstChild("Dialog") then
            -- Dialog varsa etkileşime geç
            game:GetService("ReplicatedStorage"):FindFirstChild("Dialogue"):FireServer(questGiver.Dialog)
        end
    end
end

-- NPC KES FONKSİYONU
function killNPC(npcName)
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character
    
    if not character then return end
    
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name:find(npcName) and obj:FindFirstChild("Humanoid") then
            local humanoid = obj.Humanoid
            if humanoid.Health > 0 then
                if obj:FindFirstChild("HumanoidRootPart") then
                    -- NPC'ye git
                    character.HumanoidRootPart.CFrame = obj.HumanoidRootPart.CFrame + Vector3.new(0, 0, 5)
                    wait(0.3)
                    
                    -- Saldır
                    local tool = character:FindFirstChildOfClass("Tool")
                    if tool then
                        tool:Activate()
                    end
                    
                    -- Ölene kadar bekle
                    repeat
                        wait(0.5)
                        if tool then tool:Activate() end
                    until humanoid.Health <= 0 or not _G.FarmActive
                end
            end
        end
    end
end

-- DURUM TAB
local InfoTab = Window:NewTab("Bilgi")
local InfoSection = InfoTab:NewSection("Oyuncu Bilgisi")

InfoSection:NewLabel("Oyuncu: " .. game.Players.LocalPlayer.Name)
InfoSection:NewLabel("Seviye: " .. game.Players.LocalPlayer.Data.Level.Value)
InfoSection:NewButton("Bilgileri Yenile", "", function()
    InfoSection:NewLabel("Oyuncu: " .. game.Players.LocalPlayer.Name)
    InfoSection:NewLabel("Seviye: " .. game.Players.LocalPlayer.Data.Level.Value)
end)

-- UYARI TAB
local WarningTab = Window:NewTab("⚠️ UYARI")
local WarningSection = WarningTab:NewSection("OKUMADAN KULLANMA!")

WarningSection:NewLabel("1. BU SCRIPT ÇALIŞMAYABİLİR!")
WarningSection:NewLabel("2. HESABIN BANLANABİLİR!")
WarningSection:NewLabel("3. VİRÜS RİSKİ VAR!")
WarningSection:NewLabel("4. SORUMLULUK TAMAMEN SENDE!")
WarningSection:NewLabel("5. ÇALIŞMAZSA BENİ SUÇLAMA!")
