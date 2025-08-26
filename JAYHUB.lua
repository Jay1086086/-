--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
-- Load UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jay1086086/-/44ab5e1a4715c032f688d94def0b1a3abd86dde7/untitled.lua"))()

-- Create Main Window
local Window = Library:Window({
    Title = "JAY HUB",
    Desc = "感谢支持",
    Icon = 105059922903197,
    Theme = "Dark",
    Config = {
        Keybind = Enum.KeyCode.LeftControl,
        Size = UDim2.new(0, 500, 0, 350)
    },
    CloseUIButton = {
        Enabled = true,
        Text = "打开/关闭"
    }
})

-- Sidebar Vertical Separator
local SidebarLine = Instance.new("Frame")
SidebarLine.Size = UDim2.new(0, 1, 1, 0)
SidebarLine.Position = UDim2.new(0, 140, 0, 0) -- adjust if needed
SidebarLine.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SidebarLine.BorderSizePixel = 0
SidebarLine.ZIndex = 5
SidebarLine.Name = "SidebarLine"
SidebarLine.Parent = game:GetService("CoreGui") -- Or Window.Gui if accessible

-- Tab
local Tab = Window:Tab({Title = "主页", Icon = "star"}) do
    -- Section
    Tab:Section({Title = "By JAY\n免费脚本.禁止倒卖"})

    -- Button
     Tab:Button({
        Title = "感谢牢汤.风之子.WM的支持",
        Desc = "也感谢其他赞助商",
        Callback = function()
        print("Button clicked!")
            Window:Notify({
                Title = "你老点啥🤓",
                Desc = "",
                Time = 1
            })
        end
    })

    -- Slider
    Tab:Slider({
        Title = "划着玩",
        Min = 0,
        Max = 100,
        Rounding = 0,
        Value = 25,
        Callback = function(val)
            print("Slider:", val)
        end
    })

    -- Code Display
    local CodeBlock = Tab:Code({
        Title = "下方QQ群",
        Code = "-- 1049557594\n玩Jay进QQ群')"
    })

    -- Simulate update
    task.delay(5, function()
            CodeBlock:SetCode("请加入QQ群\n1049557594")
    end)
end

-- Line Separator
Window:Line()

local InkGameTab = Window:Tab({Title = "通用功能", Icon = "wrench"})
do
    
    InkGameTab:Slider({
        Title = "设置速度",
        Min = 0,
        Max = 100,
        Rounding = 0,
        Value = 25,
        Callback = function(val)
            local player = game.Players.LocalPlayer
            
            local character = player.Character or player.CharacterAdded:Wait()
            
            local humanoid = character:WaitForChild("Humanoid", 10)
            
            if humanoid then
                humanoid.WalkSpeed = val
                print("人物行走速度已设置为:", val)
            else
                warn("10秒内未找到 Humanoid 对象，无法设置速度")
            end
        end
    })
end

    InkGameTab:Slider({
    Title = "设置跳跃高度",
    Min = 0,
    Max = 200, -- 跳跃力量的合理范围，可根据需要调整
    Rounding = 0,
    Value = 50, -- 初始跳跃力量，Roblox 默认一般是 50 左右
    Callback = function(val)
        -- 获取本地玩家的人物
        local player = game.Players.LocalPlayer
        local character = player.Character
        if not character then
            character = player.CharacterAdded:Wait() -- 等待人物加载
        end
        -- 获取人类oid对象
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            -- 设置人类oid的跳跃力量，从而改变跳跃高度
            humanoid.JumpPower = val
            print("人物跳跃力量已设置为:", val)
        else
            print("未找到人类oid对象，无法设置跳跃高度")
        end
    end
})

    InkGameTab:Button({
    Title = "透视",
    Desc = "单击开启玩家透视",
    Callback = function()
       local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        
        local highlight = Instance.new("Highlight")
        highlight.Name = "Highlight"
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop -- 保证透视高亮始终可见

        -- 为已有玩家添加透视和小尺寸名字
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                repeat task.wait() until player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                local humanoidRootPart = player.Character.HumanoidRootPart
                
                -- 添加/维护透视高亮
                if not humanoidRootPart:FindFirstChild("Highlight") then
                    local highlightClone = highlight:Clone()
                    highlightClone.Adornee = player.Character
                    highlightClone.Parent = humanoidRootPart
                end

                if not humanoidRootPart:FindFirstChild("PlayerNameDisplay") then
                    local billboardGui = Instance.new("BillboardGui")
                    billboardGui.Name = "PlayerNameDisplay"
                    billboardGui.Adornee = humanoidRootPart
                    billboardGui.Size = UDim2.new(0, 150, 0, 20)
                    billboardGui.StudsOffset = Vector3.new(0, 2.8, 0)
                    billboardGui.AlwaysOnTop = true

                    local textLabel = Instance.new("TextLabel")
                    textLabel.Parent = billboardGui
                    textLabel.Size = UDim2.new(1, 0, 1, 0)
                    textLabel.BackgroundTransparency = 1
                    textLabel.Text = player.Name
                    textLabel.TextColor3 = Color3.new(1, 1, 1)
                    textLabel.TextSize = 9
                    textLabel.TextScaled = false

                    billboardGui.Parent = humanoidRootPart
                end
            end
        end

        -- 新玩家加入时添加透视和名字
        game.Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function(character)
                repeat task.wait() until character:FindFirstChild("HumanoidRootPart")
                local humanoidRootPart = character.HumanoidRootPart
                
                -- 透视高亮
                if not humanoidRootPart:FindFirstChild("Highlight") then
                    local highlightClone = highlight:Clone()
                    highlightClone.Adornee = character
                    highlightClone.Parent = humanoidRootPart
                end

                -- 小尺寸名字
                local billboardGui = Instance.new("BillboardGui")
                billboardGui.Name = "PlayerNameDisplay"
                billboardGui.Adornee = humanoidRootPart
                billboardGui.Size = UDim2.new(0, 150, 0, 20)
                billboardGui.StudsOffset = Vector3.new(0, 2.8, 0)
                billboardGui.AlwaysOnTop = true

                local textLabel = Instance.new("TextLabel")
                textLabel.Parent = billboardGui
                textLabel.Size = UDim2.new(1, 0, 1, 0)
                textLabel.BackgroundTransparency = 1
                textLabel.Text = player.Name
                textLabel.TextColor3 = Color3.new(1, 1, 1)
                textLabel.TextSize = 9 -- 名字缩小到9
                textLabel.TextScaled = false

                billboardGui.Parent = humanoidRootPart
            end)
        end)

        -- 玩家离开时清理资源
        game.Players.PlayerRemoving:Connect(function(player)
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local humanoidRootPart = player.Character.HumanoidRootPart
                if humanoidRootPart:FindFirstChild("Highlight") then
                    humanoidRootPart.Highlight:Destroy()
                end
                if humanoidRootPart:FindFirstChild("PlayerNameDisplay") then
                    humanoidRootPart.PlayerNameDisplay:Destroy()
                end
            end
        end)

        -- 每帧维护透视和名字显示
        RunService.Heartbeat:Connect(function()
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer and player.Character then
                    local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
                    if humanoidRootPart then
                        -- 维护透视
                        if not humanoidRootPart:FindFirstChild("Highlight") then
                            local highlightClone = highlight:Clone()
                            highlightClone.Adornee = player.Character
                            highlightClone.Parent = humanoidRootPart
                            task.wait()
                        end

                        -- 维护小尺寸名字
                        if not humanoidRootPart:FindFirstChild("PlayerNameDisplay") then
                            local billboardGui = Instance.new("BillboardGui")
                            billboardGui.Name = "PlayerNameDisplay"
                            billboardGui.Adornee = humanoidRootPart
                            billboardGui.Size = UDim2.new(0, 150, 0, 20)
                            billboardGui.StudsOffset = Vector3.new(0, 2.8, 0)
                            billboardGui.AlwaysOnTop = true

                            local textLabel = Instance.new("TextLabel")
                            textLabel.Parent = billboardGui
                            textLabel.Size = UDim2.new(1, 0, 1, 0)
                            textLabel.BackgroundTransparency = 1
                            textLabel.Text = player.Name
                            textLabel.TextColor3 = Color3.new(1, 1, 1)
                            textLabel.TextSize = 9 -- 名字缩小到9
                            textLabel.TextScaled = false

                            billboardGui.Parent = humanoidRootPart
                            task.wait()
                        end
                    end
                end
            end
        end)
    end
})

    InkGameTab:Button({
    Title = "飞行脚本",
    Description = "从GitHub加载并执行飞行脚本",
    Callback = function()
        -- 从指定URL加载并执行飞行脚本
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Jay907692/Jay/8b94c47bd5969608438fa1ee57f34b1350789caa/飞行脚本", true))()
        print("飞行脚本已加载并执行")
    end
})

    InkGameTab:Toggle({
    Title = "穿墙",
    Flag = "NoClip", -- 用于标识该 Toggle 的状态，需确保 UI 库支持 Flag 参数
    Default = false,
    Callback = function(NC)
        -- 定义全局变量（或在合适作用域）存储连接和状态，避免多次触发重复创建
        if not _G.Stepped then
            _G.Stepped = nil
        end
        if not _G.Clipon then
            _G.Clipon = false
        end
        
        local Workspace = game:GetService("Workspace")
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        if NC then
            _G.Clipon = true
            -- 如果之前有连接，先断开，避免重复
            if _G.Stepped then
                _G.Stepped:Disconnect()
            end
            _G.Stepped = game:GetService("RunService").Stepped:Connect(function()
                if _G.Clipon then
                    local character = LocalPlayer.Character
                    if character then
                        for _, v in pairs(character:GetChildren()) do
                            if v:IsA("BasePart") then
                                v.CanCollide = false
                            end
                        end
                    end
                else
                    if _G.Stepped then
                        _G.Stepped:Disconnect()
                        _G.Stepped = nil
                    end
                end
            end)
        else
            _G.Clipon = false
            -- 断开连接，恢复碰撞
            if _G.Stepped then
                _G.Stepped:Disconnect()
                _G.Stepped = nil
            end
            local character = LocalPlayer.Character
            if character then
                for _, v in pairs(character:GetChildren()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = true
                    end
                end
            end
        end
    end
})

    InkGameTab:Button({
    Title = "无限跳",
    Description = "从GitHub加载并执行无限跳脚本",
    Callback = function()
        -- 从指定URL加载并执行飞行脚本
        loadstring(game:HttpGet("https://pastebin.com/raw/V5PQy3y0", true))()
        print("无限跳脚本已加载并执行")
    end
})

-- Another Tab Example
local InkGameTab = Window:Tab({Title = "墨水游戏", Icon = "skull"})do
    InkGameTab:Section({Title = "英文防封", Icon = "wrench"})
    InkGameTab:Button({
        Title = "AX",
        Desc = "单击以执行",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/TexRBLX/Roblox-stuff/refs/heads/main/ink-game/script.lua"))()
        end
    })
end

    InkGameTab:Button({
    Title = "LT",
    Desc = "单击以执行",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/wefwef127382/inkgames.github.io/refs/heads/main/ringta.lua"))()
    end
})

InkGameTab:Section({Title = "中文不知道防不防封", Icon = "wrench"})
InkGameTab:Button({
    Title = "AX中文",
    Desc = "单击以执行",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/refs/heads/main/Games/墨水游戏.lua"))()
    end
})
local Extra = Window:Tab({Title = "死铁轨", Icon = "knife"})do
    Extra:Section({Title = "英文"})
    Extra:Button({
        Title = "JAY",
        Desc = "单击以执行",
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/wefwef127382/DEADRAILS.github.io/refs/heads/main/mainringta.lua"))()
        end
    })
end

-- Final Notification
Window:Notify({
    Title = "JAY HUB",
    Desc = "感谢您的游玩",
    Time = 5
})
-- 连接脚本的 Destroying 信号，当脚本即将被销毁时触发回调
script.Destroying:Connect(function()
    Window:Notify({
        Title = "JAY HUB",
        Desc = "关闭",
        Time = 5
    })
end)
