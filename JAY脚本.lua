local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingyan777/roblox/refs/heads/main/main.lua"))()

function gradient(text, startColor, endColor)
    local result = ""
    local length = #text

    for i = 1, length do
        local t = (i - 1) / math.max(length - 1, 1)
        local r = math.floor((startColor.R + (endColor.R - startColor.R) * t) * 255)
        local g = math.floor((startColor.G + (endColor.G - startColor.G) * t) * 255)
        local b = math.floor((startColor.B + (endColor.B - startColor.B) * t) * 255)

        local char = text:sub(i, i)
        result = result .. "<font color=\"rgb(" .. r ..", " .. g .. ", " .. b .. ")\">" .. char .. "</font>"
    end

    return result
end

local Confirmed = false

WindUI:Popup({
    Title = "JAYHUB",
    IconThemed = sparkles,
    Content = "1.8版本",
    Buttons = {
        {
            Title = "退出",
            Callback = function() end,
            Variant = "Secondary",
        },
        {
            Title = "进入",
            Icon = "arrow-right",
            Callback = function() Confirmed = true end,
            Variant = "Primary",
        }
    }
})

repeat task.wait() until Confirmed

local Window = WindUI:CreateWindow({
    Title = "JAYhub",
    Icon = "rbxassetid://129260712070622",
    IconThemed = true,
    Folder = "XYScript",
    Size = UDim2.fromOffset(400, 300),
    Transparent = true,
    Theme = "Dark",
    User = { Enabled = true },
    SideBarWidth = 200,
    ScrollBarEnabled = true,
    Background = "rbxassetid://96035938131302"
})

Window:Tag({
    Title = "1.8",
    Color = Color3.fromHex("#30ff6a")
})

Window:EditOpenButton({
    Title = "JAY脚本中心",
    Icon = "crown",
    CornerRadius = UDim.new(0,16),
    Size = UDim2.fromOffset(580, 340),
    StrokeThickness = 2,
    Color = ColorSequence.new(
        Color3.fromHex("FF0F7B"), 
        Color3.fromHex("F89B29")
    ),
    Draggable = true,
})

local Tabs = {}
local ElementsSection = Window:Section({Title = "脚本如下", Side = "Left"})

Tabs.ParagraphTab = ElementsSection:Tab({ Title = "主页", Icon = "type" })
Tabs.ButtonTab = ElementsSection:Tab({ Title = "通用", Icon = "mouse-pointer-2" })
Tabs.BeiyiqiTab = ElementsSection:Tab({ Title = "被遗弃", Icon = "type" })
Tabs.N99nightTab = ElementsSection:Tab({ Title = "99夜", Icon = "type" })
Tabs.JaobeneTab = ElementsSection:Tab({ Title = "脚本中心", Icon = "type" })

Window:SelectTab(1)

Tabs.ParagraphTab:Paragraph({
    Title = "JAYhub",
    Desc = "Q群1049557594",
    Image = "https://i.postimg.cc/nL97SYHB/20250722-07083338.jpg",
    ImageSize = 42,
    Thumbnail = "https://i.postimg.cc/fLmB0Qp3/IMG-20250821-130711.jpg",
    ThumbnailSize = 120
})

Tabs.ParagraphTab:Paragraph({
    Title = "欢迎",
    Desc = "需要时开启反挂机作者:JAY\n脚本免费, 倒卖撕妈",
})

Tabs.ParagraphTab:Paragraph({
    Title = "感谢牢汤.WM.风之子.的支持",
    Desc = "当前服务器ID: " .. game.PlaceId, -- 显示服务器ID
})
Tabs.ParagraphTab:Paragraph({
    Title = "您的注入器",
    Desc = ": " .. identifyexecutor(), -- 显示注入器ID
})

Tabs.ButtonTab:Slider({
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

Tabs.ButtonTab:Slider({
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

Tabs.ButtonTab:Slider({
    Title = "重力",
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
Tabs.ButtonTab:Toggle({
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
Tabs.ButtonTab:Toggle({
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

Tabs.ButtonTab:Button({
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

Tabs.ButtonTab:Button({
    Title = "飞行v3",
    Desc = "冷情汉化",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Jay907692/Jay/8b94c47bd5969608438fa1ee57f34b1350789caa/飞行脚本", true))()
    end
})

Tabs.ButtonTab:Button({
    Title = "玩家实时数据",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E5%AE%9E%E6%97%B6%E6%95%B0%E6%8D%AE.txt", true))()
    end
})

Tabs.ButtonTab:Button({
    Title = "vapev4",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))()
    end
})

Tabs.ButtonTab:Button({
    Title = "查看别人物品栏",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E7%9C%8B%E7%89%A9%E5%93%81%E6%A0%8F.txt", true))()
    end
})

Tabs.ButtonTab:Button({
    Title = "别人可见音效",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Brookhaven-RP-Audio-Player-Script-Brookhaven-RP-33531", true))()
    end
})

Tabs.ButtonTab:Button({
    Title = "隐身",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/vP6CrQJj", true))()
    end
})

Tabs.ButtonTab:Button({
    Title = "蜘蛛侠",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingyan777/roblox/refs/heads/main/%E8%9C%98%E8%9B%9B%E4%BE%A0.txt", true))()
    end
})

Tabs.ButtonTab:Button({
    Title = "拥抱",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ExploitFin/Animations/refs/heads/main/Front%20and%20Back%20Hug%20Tool", true))()
    end
})

Tabs.ButtonTab:Button({
    Title = "隐身2",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/3Rnd9rHf", true))()
    end
})

Tabs.ButtonTab:Button({
    Title = "失重",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Rawbr10/Roblox-Scripts/refs/heads/main/0%20Graviy%20Trip%20Universal", true))()
    end
})

Tabs.ButtonTab:Button({
    Title = "跳墙",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ScpGuest666/Random-Roblox-script/refs/heads/main/Roblox%20WallHop%20V4%20script", true))()
    end
})

Tabs.ButtonTab:Button({
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

Tabs.JaobeneTab:Button({
    Title = "情云脚本",
    Callback = function()
        loadstring(utf8.char((function() return table.unpack({108,111,97,100,115,116,114,105,110,103,40,103,97,109,101,58,72,116,116,112,71,101,116,40,34,104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,67,104,105,110,97,81,89,47,45,47,97,69,54,37,56,51,37,56,53,37,69,52,37,66,65,37,57,49,34,41,41,40,41})end)()))()
    end
})

Tabs.ButtonTab:Button({
    Title = "http spy",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Best-HTTP-SPY-38448", true))()
    end
})

Tabs.ButtonTab:Button({
    Title = "汉化dex",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingyan777/roblox/refs/heads/main/bex.lua", true))()
    end
})

Tabs.ButtonTab:Button({
    Title = "simple say",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/refs/heads/main/Tools/SimpleSpy.lua", true))()
    end
})

Tabs.ButtonTab:Button({
    Title = "Sigma-Spy",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/depthso/Sigma-Spy/refs/heads/main/Main.lua", true))()
    end
})

Tabs.ButtonTab:Button({
    Title = "光影",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/MZEEN2424/Graphics/main/Graphics.xml", true))()
    end
})

Tabs.ButtonTab:Button({
    Title = "提高画质",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/main/Content/HighQuality", true))()
    end
})

Tabs.ButtonTab:Button({
    Title = "芦管r6",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw", true))()
    end
})

Tabs.ButtonTab:Button({
    Title = "芦管r15",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw", true))()
    end
})

Tabs.ButtonTab:Button({
    Title = "TSB动作脚本",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/NotEnoughJack/socializehub/refs/heads/main/script.lua", true))()
    end
})

Tabs.BeiyiqiTab:Button({
    Title = "情云被遗弃",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ChinaQY/Scripts/Main/Forsaken"))()
    end
})

Window:OnClose(function()
    print("UI closed.")
    if NoclipConnection then
        NoclipConnection:Disconnect()
    end
    -- 恢复原始环境光设置
    if originalAmbient then
        game.Lighting.Ambient = originalAmbient
    end
end)