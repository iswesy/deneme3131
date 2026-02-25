-- AYARLAR
_G.AutoFarm = true -- Durdurmak için false yap
local WeaponName = "Combat" -- Elindeki silahın tam adını yaz (Katana, Combat vb.)

local player = game.Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")

-- Görev Alma Fonksiyonu (Başlangıç Adası - Banditler için)
function getQuest()
    local args = {
        [1] = "StartQuest",
        [2] = "BanditQuest1",
        [3] = 1
    }
    RS.Remotes.CommF_:InvokeServer(unpack(args))
end

-- En Yakın Düşmanı Bulma
function getEnemy()
    for _, v in pairs(workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            return v
        end
    end
    return nil
end

-- ANA DÖNGÜ
task.spawn(function()
    while _G.AutoFarm do
        task.wait(0.1)
        pcall(function()
            -- Karakter ve Silah Kontrolü
            local char = player.Character
            local root = char:WaitForChild("HumanoidRootPart")
            
            -- Silahı Elime Al
            if not char:FindFirstChild(WeaponName) then
                local tool = player.Backpack:FindFirstChild(WeaponName)
                if tool then
                    tool.Parent = char
                end
            end

            -- Eğer Görev Yoksa Görev Al
            if not player.PlayerGui.Main.Quest.Visible then
                getQuest()
            end

            local enemy = getEnemy()
            if enemy then
                -- Düşmanın tam üstüne ışınlan (Vurulmamak için)
                root.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                
                -- Vuruş Yap
                char[WeaponName]:Activate()
            else
                -- Düşman yoksa spawn noktasına git (Düşmanları bekle)
                root.CFrame = workspace.EnemySpawns["Bandit"].CFrame
            end
        end)
    end
end)
