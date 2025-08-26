--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
-- Load UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jay1086086/JAY-/de008b0645c31b8ec1ad609aab4abb3909eb8c0b/untitled.lua"))()

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
        Title = "传送到极速传奇",
        Desc = "感谢支持",
        Callback = function()
        print("Button clicked!")
            Window:Notify({
                Title = "正在运行",
                Desc = "",
                Time = 1
            })
        end
    })

    -- Slider
    Tab:Slider({
        Title = "设置速度",
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

-- Another Tab Example
local Extra = Window:Tab({Title = "极速传奇", Icon = "wrench"}) do
    Extra:Section({Title = "传送", Icon = "wrench"})
    Extra:Button({
        Title = "城市",
        Desc = "单击以执行",
        Callback = function()
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
            humanoidRootPart.CFrame = CFrame.new(-534.38, 4.07, 437.75)
            Window:Notify({
                Title = "通知",
                Desc = "传送成功",
                Time = 1
            })
        end
    })
end

    Extra:Button({
        Title = "神秘洞穴",
        Desc = "单击以执行",
        Callback = function()
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
            humanoidRootPart.CFrame = CFrame.new(-9683.05, 59.25, 3136.63)
            Window:Notify({
                Title = "通知",
                Desc = "传送成功",
                Time = 1
            })
        end
    })
        
local Extra = Window:Tab({Title = "力量传奇", Icon = "wrench"}) do
    Extra:Section({Title = "传送"})
    Extra:Button({
        Title = "出生点",
        Desc = "单击以执行",
        Callback = function()
            Window:Notify({
                Title = "通知",
                Desc = "传送成功",
                Time = 1
            })
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
