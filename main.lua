-- BASİT AUTO FARM 1-10 LEVEL
-- ÇALIŞMA GARANTİSİ YOK, DENE YAPMAZSA BİLMEM

local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Menü oluşturma
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ToggleButton = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")

ScreenGui.Parent = game.CoreGui
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Size = UDim2.new(0, 250, 0, 150)
MainFrame.Position = UDim2.new(0.7, 0, 0.3, 0)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "AUTO FARM 1-10"
Title.TextColor3 = Color3.fromRGB(255, 255, 0)
Title.TextScaled = true

ToggleButton.Parent = MainFrame
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
ToggleButton.Size = UDim2.new(0.8, 0, 0, 40)
ToggleButton.Position = UDim2.new(0.1, 0, 0.3, 0)
ToggleButton.Text = "BAŞLAT"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextScaled = true

StatusLabel.Parent = MainFrame
StatusLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
StatusLabel.Size = UDim2.new(0.8, 0, 0, 30)
StatusLabel.Position = UDim2.new(0.1, 0, 0.7, 0)
StatusLabel.Text = "Durum: Bekliyor"
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.TextScaled = true

local farming = false

-- NPC bulma fonksiyonu
local function findNearestNPC()
    local npcList = {}
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") then
            if obj.Name:find("Bandit") or obj.Name:find("Monkey") then
                table.insert(npcList, obj)
            end
        end
    end
    return npcList
end

-- Farm fonksiyonu
local function startFarming()
    while farming do
        wait(1)
        
        -- Level kontrolü
        local currentLevel = player.Data.Level.Value
        StatusLabel.Text = "Durum: Farm (Level " .. currentLevel .. ")"
        
        if currentLevel >= 10 then
            farming = false
            ToggleButton.Text = "BAŞLAT"
            ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            StatusLabel.Text = "Durum: Level 10 oldu!"
            break
        end
        
        -- NPC bul ve kes
        local npcs = findNearestNPC()
        for _, npc in ipairs(npcs) do
            if farming and npc and npc:FindFirstChild("Humanoid") then
                local npcHumanoid = npc.Humanoid
                if npcHumanoid.Health > 0 then
                    -- NPC'ye git
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        character.HumanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame + Vector3.new(0, 0, 5)
                        wait(0.3)
                        
                        -- Saldır
                        local tool = character:FindFirstChildOfClass("Tool")
                        if tool then
                            tool:Activate()
                        end
                        
                        -- Ölene kadar vur
                        repeat
                            wait(0.3)
                            if tool then tool:Activate() end
                        until npcHumanoid.Health <= 0 or not farming
                    end
                end
            end
        end
    end
end

-- Butona tıklama
ToggleButton.MouseButton1Click:Connect(function()
    farming = not farming
    if farming then
        ToggleButton.Text = "DURDUR"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        StatusLabel.Text = "Durum: Farm başlıyor..."
        spawn(startFarming)
    else
        ToggleButton.Text = "BAŞLAT"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        StatusLabel.Text = "Durum: Durduruldu"
    end
end)

print("Auto Farm 1-10 yüklendi! Menü sağ üstte.")
