-- UI Kütüphanesini Yükle (Rayfield gibi popüler bir kütüphane kullanıyoruz)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Kendi Özel Scriptim",
   LoadingTitle = "Yükleniyor...",
   LoadingSubtitle = "Blox Fruits Test",
   ConfigurationSaving = { Enabled = true, Folder = "ScriptAyarlari" }
})

-- DEĞİŞKENLER (Özelliklerin çalışması için)
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")
local flying = false
local autoFarm = false

-- SEKMELER
local MainTab = Window:CreateTab("Genel Özellikler", 4483362458) -- İkon ID
local FarmTab = Window:CreateTab("Auto Farm", 4483362458)
local TeleportTab = Window:CreateTab("Teleport", 4483362458)

-- FLY (UÇMA) ÖZELLİĞİ
MainTab:CreateToggle({
   Name = "Fly (Uçma)",
   CurrentValue = false,
   Callback = function(Value)
      flying = Value
      if flying then
         local bv = Instance.new("BodyVelocity", root)
         bv.Name = "FlyVel"
         bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
         bv.Velocity = Vector3.new(0,0,0)
         
         task.spawn(function()
            while flying do
               bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 100
               task.wait()
            end
            bv:Destroy()
         end)
      end
   end,
})

-- HIZ AYARI (WalkSpeed)
MainTab:CreateSlider({
   Name = "Yürüme Hızı",
   Range = {16, 500},
   Increment = 10,
   CurrentValue = 16,
   Callback = function(Value)
      player.Character.Humanoid.WalkSpeed = Value
   end,
})

-- AUTO FARM ÖZELLİĞİ
FarmTab:CreateToggle({
   Name = "Auto Farm Level",
   CurrentValue = false,
   Callback = function(Value)
      autoFarm = Value
      task.spawn(function()
         while autoFarm do
            task.wait(0.1)
            -- En yakın düşmanı bul ve ona git (Basit mantık)
            pcall(function()
                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        root.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                        local tool = player.Character:FindFirstChildOfClass("Tool")
                        if tool then tool:Activate() end
                        break
                    end
                end
            end)
         end
      end)
   end,
})

-- TELEPORT (IŞINLANMA) ÖZELLİĞİ
TeleportTab:CreateButton({
   Name = "Başlangıç Adasına Git",
   Callback = function()
      root.CFrame = CFrame.new(1054, 16, -1436) -- Örnek koordinat
   end,
})

TeleportTab:CreateButton({
   Name = "Orta Kasabaya Git",
   Callback = function()
      root.CFrame = CFrame.new(-390, 73, 386) -- Örnek koordinat
   end,
})

Rayfield:Notify({
   Title = "Başarılı!",
   Content = "Script başarıyla yüklendi ve kullanıma hazır.",
   Duration = 5,
})
