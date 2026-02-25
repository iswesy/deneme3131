-- BASİT MENÜ SCRIPTİ
-- SADECE MENÜ OLUŞTURUR, HİÇBİR İŞLEVİ YOK

-- Ana menü oluştur
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local Tab1 = Instance.new("TextButton")
local Tab2 = Instance.new("TextButton")
local ContentFrame = Instance.new("Frame")
local StatusText = Instance.new("TextLabel")

-- Menü ayarları
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "BasitMenu"

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(0, 255, 0)
MainFrame.Position = UDim2.new(0.7, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 300, 0, 250)
MainFrame.Active = true
MainFrame.Draggable = true

-- Başlık
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Text = "BASİT MENÜ"
Title.TextColor3 = Color3.fromRGB(0, 255, 0)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold

-- Kapat butonu
CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.Position = UDim2.new(0.9, 0, 0, 0)
CloseButton.Size = UDim2.new(0, 30, 0, 35)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextScaled = true
CloseButton.Font = Enum.Font.GothamBold

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Sekme 1
Tab1.Parent = MainFrame
Tab1.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Tab1.Position = UDim2.new(0.05, 0, 0.15, 0)
Tab1.Size = UDim2.new(0.4, 0, 0, 40)
Tab1.Text = "FARM"
Tab1.TextColor3 = Color3.fromRGB(255, 255, 255)
Tab1.TextScaled = true

-- Sekme 2
Tab2.Parent = MainFrame
Tab2.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Tab2.Position = UDim2.new(0.55, 0, 0.15, 0)
Tab2.Size = UDim2.new(0.4, 0, 0, 40)
Tab2.Text = "TELEPORT"
Tab2.TextColor3 = Color3.fromRGB(255, 255, 255)
Tab2.TextScaled = true

-- İçerik çerçevesi
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ContentFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
ContentFrame.Size = UDim2.new(0.9, 0, 0.6, 0)

-- Durum yazısı
StatusText.Parent = ContentFrame
StatusText.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
StatusText.Size = UDim2.new(1, 0, 1, 0)
StatusText.Text = "Menü hazır!\nFarm veya Teleport sekmelerine tıkla"
StatusText.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusText.TextScaled = true
StatusText.TextWrapped = true

-- Sekme 1'e tıklanınca
Tab1.MouseButton1Click:Connect(function()
    StatusText.Text = "FARM SEKME\n\nAuto Farm butonu buraya gelecek\nAma bu sadece menü, işlev yok"
    Tab1.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
    Tab2.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
end)

-- Sekme 2'ye tıklanınca
Tab2.MouseButton1Click:Connect(function()
    StatusText.Text = "TELEPORT SEKME\n\nAda isimleri buraya gelecek\nAma bu sadece menü, işlev yok"
    Tab2.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
    Tab1.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
end)

print("✅ Basit menü yüklendi! Sağ üstte.")
print("⚠️ Bu sadece menü, hiçbir işlevi yok!")
