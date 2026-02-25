-- 🚀 BASİT UÇMA SCRİPTİ
local player = game.GetService(game, "Players").LocalPlayer
local mouse = player:GetMouse()

local flying = false
local speed = 50 -- Burayı değiştirerek hızlanabilirsin

mouse.KeyDown:Connect(function(key)
    if key:lower() == "f" then -- Açıp kapatmak için klavyeden 'F' tuşuna bas
        flying = not flying

        local char = player.Character
        local hum = char:FindFirstChildOfClass("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")

        if flying then
            -- Uçmayı Başlat
            hum.PlatformStand = true
            local bg = Instance.new("BodyGyro", root)
            bg.P = 9e4
            bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            bg.CFrame = root.CFrame

            local bv = Instance.new("BodyVelocity", root)
            bv.Velocity = Vector3.new(0, 0, 0)
            bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)

            -- Hareket Kontrolü
            task.spawn(function()
                while flying do
                    bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * speed
                    bg.CFrame = workspace.CurrentCamera.CFrame
                    task.wait()
                end
                bg:Destroy()
                bv:Destroy()
                hum.PlatformStand = false
            end)
        end
    end
end)

print("Uçma aktif! Açmak/Kapatmak için 'F' tuşuna basın.")
