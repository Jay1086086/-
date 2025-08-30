local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- 添加欢迎弹窗
WindUI:Popup({
    Title = "欢迎使用JAYhub",
    Icon = "sparkles",
    Content = "1.8版本JAY",
    Buttons = {
        {
            Title = "JAYhub",
            Icon = "arrow-right",
            Variant = "Primary",
            Callback = function() 
                print("进入脚本")
                -- 创建主窗口
                createMainWindow()
            end
        }
    }
})

function createMainWindow()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hum = Character:WaitForChild("HumanoidRootPart")
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

    local Window = WindUI:CreateWindow({
        Title = "JAYhub<font color='#00FF00'>1.8</font>",
        Icon = "rbxassetid://4483362748",
        IconTransparency = 0.5,
        IconThemed = true,
        Author = "作者:冷情",
        Folder = "CloudHub",
        Size = UDim2.fromOffset(400, 300),
        Transparent = true,
        Theme = "Dark",
        User = {
            Enabled = true,
            Callback = function() print("clicked") end,
            Anonymous = false
        },
        SideBarWidth = 200,
        ScrollBarEnabled = true,
        Background = "rbxassetid://73416826039813"
    })
    
    -- Rainbow effect & Time 
task.spawn(function()
	while true do
		local now = os.date("*t")
		local hours = string.format("%02d", now.hour)
		local minutes = string.format("%02d", now.min)
		
		hue = (hue + 0.01) % 1
		local color = Color3.fromHSV(hue, 1, 1)
		
		TimeTag:SetTitle(hours .. ":" .. minutes)
		--TimeTag:SetColor(color)

		task.wait(0.06)
	end
end)
    
    Window:Tag({
        Title = "v1.8",
        Color = Color3.fromHex("#30ff6a")
    })

    Window:EditOpenButton({
        Title = "JAY脚本中心",
        Icon = "crown",
        CornerRadius = UDim.new(0,16),
        StrokeThickness = 2,
        Color = ColorSequence.new(
            Color3.fromHex("FF0F7B"), 
            Color3.fromHex("F89B29")
        ),
        Draggable = true,
    })
    
    -- 添加彩虹边框效果
    Window:EditOpenButton({
        StrokeColor = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),     -- 红色
            ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 165, 0)), -- 橙色
            ColorSequenceKeypoint.new(0.4, Color3.fromRGB(255, 255, 0)), -- 黄色
            ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 0)),   -- 绿色
            ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)),   -- 蓝色
            ColorSequenceKeypoint.new(1, Color3.fromRGB(128, 0, 128))    -- 紫色
        }),
        StrokeThickness = 3,  -- 增加边框厚度
    })
    
local Tabs = {
    Main = Window:Tab({ Title = "主页", Icon = "rbxassetid://6026568198" }),
    CnmicTab = Window:Tab({ Title = "通用", Icon = "rbxassetid://94462465090724" }),
    JaobeneTab = Window:Tab({ Title = "脚本中心", Icon = "swords" })
    
    MainTab:Paragraph({
        Title = "欢迎使用JAYhub",
        Desc = "QQ群1049557594",
        Image = "rbxassetid://图片ID128052899764125",
        ImageSize = 42,
        Thumbnail = "rbxassetid://图片ID98991054648205",
        ThumbnailSize = 120
        })
        Tabs.ParagraphTab:Paragraph({
    Title = "感谢牢汤.WM.风之子.的支持",
    Desc = "当前服务器ID: " .. game.PlaceId, -- 显示服务器ID
})
Tabs.MainTab:Paragraph({
    Title = "您的注入器",
    Desc = ": " .. identifyexecutor(), -- 显示注入器ID
    })
    
    local CnmicTab = Window:Tab({
        Title = "通用",
        Icon = "zap",
        Locked = false,
    })
    
    Tabs.CnmicTab:Slider({
    Title = "跳跃",
    Desc = "大小为 (50-200)",
    Value = {
        Min = 50,
        Max = 200,
        Default = 50,
    },
    Increment = 1,
    Callback = function(value)
        if game.Players.LocalPlayer.Character then
            local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.JumpPower = value
            end
        end
    end
})

Tabs.CnmicTab:Slider({
    Title = "移速",
    Desc = "大小为 (16-400)",
    Value = {
        Min = 16,
        Max = 400,
        Default = 16,
    },
    Increment = 1,
    Callback = function(value)
        if game.Players.LocalPlayer.Character then
            local humanoid = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = value
            end
        end
    end
})

Tabs.CnmicTab:Slider({
    Title = "重力",
    Desc = "大小为 (？-500.0)",
    Value = {
        Min = 0.1,
        Max = 500.0,
        Default = 196.2,
    },
    Step = 0.1,
    Callback = function(value)
        game.Workspace.Gravity = value
    end
})

local originalAmbient
Tabs.CnmicTabTab:Toggle({
    Title = "夜视",
    Value = false,
    Callback = function(state)
        if state then
            originalAmbient = game.Lighting.Ambient
            game.Lighting.Ambient = Color3.new(1, 1, 1)  
        else
            game.Lighting.Ambient = originalAmbient or Color3.new(0, 0, 0)
        end
    end
})

local Noclip = false
local NoclipConnection
Tabs.CnmicTab:Toggle({
    Title = "穿墙",
    Value = false,
    Callback = function(state)
        if state then
            Noclip = true
            if NoclipConnection then
                NoclipConnection:Disconnect()
            end
            NoclipConnection = game:GetService("RunService").Stepped:Connect(function()
                if Noclip and game.Players.LocalPlayer.Character then
                    for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            Noclip = false
            if NoclipConnection then
                NoclipConnection:Disconnect()
                NoclipConnection = nil
            end
        end
    end
})

Tabs.CnmicTab:Button({
    Title = "点击传送工具",
    Callback = function()
        local mouse = game.Players.LocalPlayer:GetMouse() 
        local tool = Instance.new("Tool") 
        tool.RequiresHandle = false 
        tool.Name = "点击传送" 
        tool.Activated:Connect(function() 
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local pos = mouse.Hit + Vector3.new(0, 2.5, 0)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos.X, pos.Y, pos.Z)
            end
        end) 
        tool.Parent = game.Players.LocalPlayer.Backpack
    end
})

Tabs.CnmicTab:Button({
    Title = "肘击",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/0Ben1/fe/main/obf_5wpM7bBcOPspmX7lQ3m75SrYNWqxZ858ai3tJdEAId6jSI05IOUB224FQ0VSAswH.lua.txt', true))()
    end
})

Tabs.CnmicTab:Button({
    Title = "玩家实时数据",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E5%AE%9E%E6%97%B6%E6%95%B0%E6%8D%AE.txt", true))()
    end
})

Tabs.CnmicTab:Button({
    Title = "vapev4",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))()
    end
})

Tabs.CnmicTab:Button({
    Title = "查看别人物品栏",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E7%9C%8B%E7%89%A9%E5%93%81%E6%A0%8F.txt", true))()
    end
})

Tabs.CnmicTab:Button({
    Title = "别人可见音效",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Brookhaven-RP-Audio-Player-Script-Brookhaven-RP-33531", true))()
    end
})

Tabs.CnmicTab:Button({
    Title = "隐身",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/vP6CrQJj", true))()
    end
})

Tabs.CnmicTab:Button({
    Title = "蜘蛛侠",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingyan777/roblox/refs/heads/main/%E8%9C%98%E8%9B%9B%E4%BE%A0.txt", true))()
    end
})

Tabs.CnmicTab:Button({
    Title = "拥抱",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ExploitFin/Animations/refs/heads/main/Front%20and%20Back%20Hug%20Tool", true))()
    end
})

Tabs.CnmicTab:Button({
    Title = "隐身2",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/3Rnd9rHf", true))()
    end
})

Tabs.CnmicTab:Button({
    Title = "失重",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Rawbr10/Roblox-Scripts/refs/heads/main/0%20Graviy%20Trip%20Universal", true))()
    end
})

Tabs.CnmicTab:Button({
    Title = "跳墙",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ScpGuest666/Random-Roblox-script/refs/heads/main/Roblox%20WallHop%20V4%20script", true))()
    end
})

Tabs.CnmicTab:Button({
    Title = "前后空翻",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingyan777/roblox/refs/heads/main/%E6%97%8B%E8%BD%AC.txt", true))()
    end
})

Tabs.JaobeneTab:Button({
    Title = "DHJB脚本卡密",
    Callback = function()
        setclipboard("wjbhd")
    end
})

Tabs.JaobeneTab:Button({
    Title = "DHJB脚本",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/1.3.txt", true))()
    end
})

Tabs.JaobeneTab:Button({
    Title = "XK脚本",
    Callback = function()
        loadstring(game:HttpGet('https://github.com/devslopo/DVES/raw/main/XK%20Hub', true))()
    end
})

Tabs.JaobeneTab:Button({
    Title = "小月脚本",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Syndromehsh/bypass-Script/refs/heads/main/xiaoyue/Main%20Script.lua", true))()
    end
})

Tabs.JaobeneTab:Button({
    Title = "殺脚本",
    Callback = function()
        FengYu_HUB = "殺脚本"
        loadstring(game:HttpGet("https://raw.githubusercontent.com/FengYu-3/FengYu/refs/heads/main/QQ1926190957.lua", true))()
    end
})
end