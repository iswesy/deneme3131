local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")

_G.AutoFarm = true -- Bunu false yaparsan durur

-- En yakın düşmanı bulan fonksiyon
function getClosestEnemy()
    local closest = nil
    local dist = math.huge
    for _, v in pairs(workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
            local magnitude = (player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
            if magnitude < dist then
                dist = magnitude
                closest = v
            end
        end
    end
    return closest
end

-- Ana Döngü
task.spawn(function()
    while _G.AutoFarm do
        task.wait()
        pcall(function()
            local target = getClosestEnemy()
            if target then
                -- Düşmanın 5 birim üstüne ışınlan (Vurulmamak için)
                player.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                
                -- Otomatik Vuruş Sinyali Gönder
                game:GetService("VirtualUser"):CaptureController()
                game:GetService("VirtualUser"):ClickButton1(Vector2.new(851, 158), game.Workspace.CurrentCamera.CFrame)
            end
        end)
    end
end)
