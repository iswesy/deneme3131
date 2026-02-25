-- BLOX FRUITS BAŞLANGIÇ AUTO FARM
-- SADECE 1-10 LEVEL ARASI ÇALIŞIR (DENEME AMAÇLI)
-- KULLANIRSAN HESABIN BANLANIR! SORUMLULUK SENDE!

-- Basit menü oluştur
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ToggleBtn = Instance.new("TextButton")
local StatusText = Instance.new("TextLabel")
local CloseBtn = Instance.new("TextButton")

-- Menü ayarları
ScreenGui.Parent = game.CoreGui
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
Frame.Position = UDim2.new(0.7, 0, 0.3, 0)
Frame.Size = UDim2.new(0, 200, 0, 150)
Frame.Active = true
Frame.Draggable = true

-- Başlık
Title.Parent = Frame
Title.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "🚀 AUTO FARM 1-10"
Title.TextColor3 = Color3.new(1, 1, 0)
Title.TextScaled = true

-- Aç/Kapa butonu
ToggleBtn.Parent = Frame
ToggleBtn.BackgroundColor3 = Color3.new(0, 0.5, 0)
ToggleBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
ToggleBtn.Size = UDim2.new(0.8, 0, 0, 40)
ToggleBtn.Text = "BAŞLAT"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.TextScaled = true

-- Durum yazısı
StatusText.Parent = Frame
StatusText.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
StatusText.Position = UDim2.new(0.1, 0, 0.6, 0)
StatusText.Size = UDim2.new(0.8, 0, 0, 30)
StatusText.Text = "Durum: Bekliyor"
StatusText.TextColor3 = Color3.new(1, 1, 1)
StatusText.TextScaled = true

-- Kapat butonu
CloseBtn.Parent = Frame
CloseBtn.BackgroundColor3 = Color3.new(0.8, 0, 0)
CloseBtn.Position = UDim2.new(0.8, 0, 0, 0)
CloseBtn.Size = UDim2.new(0, 40, 0, 30)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.TextScaled = true

-- Değişkenler
local farmAktif = false
local farmLoop = nil

-- Kapat butonu işlevi
CloseBtn.MouseButton1Click:Connect(function()
    farmAktif = false
    ScreenGui:Destroy()
end)

-- Buton rengini değiştir
local function updateButtonColor()
    if farmAktif then
        ToggleBtn.BackgroundColor3 = Color3.new(0.8, 0, 0)
        ToggleBtn.Text = "DURDUR"
        StatusText.Text = "Durum: Farm aktif"
    else
        ToggleBtn.BackgroundColor3 = Color3.new(0, 0.5, 0)
        ToggleBtn.Text = "BAŞLAT"
        StatusText.Text = "Durum: Bekliyor"
    end
end

-- FARM FONKSİYONU (1-10 LEVEL)
local function startFarming()
    while farmAktif do
        wait(1) -- Her saniye kontrol et
        
        -- Oyuncu bilgilerini al
        local player = game:GetService("Players").LocalPlayer
        local character = player.Character
        
        if not character then
            wait(1)
            -- Karakter yoksa bekle
            StatusText.Text = "Durum: Karakter bekleniyor..."
            goto continue
        end
        
        -- Seviye kontrolü
        local level = player.Data.Level.Value
        StatusText.Text = "Durum: Farm aktif (Level " .. level .. ")"
        
        -- 10 level olduysa dur
        if level >= 10 then
            farmAktif = false
            updateButtonColor()
            StatusText.Text = "Durum: Level 10 oldun! Farm durdu."
            break
        end
        
        -- Seviyeye göre NPC seç (1-10 arası)
        local hedefNPC = "Bandit"
        
        -- Bandit'leri bul ve kes
        local npcBulundu = false
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and obj.Name:find("Bandit") and obj:FindFirstChild("Humanoid") then
                local humanoid = obj.Humanoid
                if humanoid.Health > 0 then
                    npcBulundu = true
                    
                    -- NPC'ye git
                    if obj:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("HumanoidRootPart") then
                        character.HumanoidRootPart.CFrame = obj.HumanoidRootPart.CFrame + Vector3.new(0, 0, 3)
                        wait(0.3)
                        
                        -- Vurma dene
                        local tool = character:FindFirstChildOfClass("Tool")
                        if tool then
                            tool:Activate()
                        end
                        
                        -- Ölene kadar bekle
                        repeat 
                            wait(0.5) 
                            if tool then tool:Activate() end
                        until humanoid.Health <= 0 or not farmAktif
                    end
                end
            end
        end
        
        -- NPC yoksa bekle ve dolaş
        if not npcBulundu then
            StatusText.Text = "Durum: NPC aranıyor..."
            -- Rastgele dolaş
            if character and character:FindFirstChild("HumanoidRootPart") then
                local randomPos = Vector3.new(
                    math.random(-50, 50),
                    50,
                    math.random(-50, 50)
                )
                character.HumanoidRootPart.CFrame = CFrame.new(randomPos)
                wait(2)
            end
        end
        
        ::continue::
    end
end

-- Butona tıklanınca
ToggleBtn.MouseButton1Click:Connect(function()
    farmAktif = not farmAktif
    updateButtonColor()
    
    if farmAktif then
        -- Farm başlat
        StatusText.Text = "Durum: Farm başlıyor..."
        spawn(function()
            startFarming()
        end)
    end
end)

-- Menüyü göster
print("✅ Auto Farm 1-10 yüklendi!")
print("⚠️ Sorumluluk tamamen sende!")
