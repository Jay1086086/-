--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
-- Load UI Library（修复：补充 HttpGet 安全参数 true，避免加载警告）
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jay1086086/-/44ab5e1a4715c032f688d94def0b1a3abd86dde7/untitled.lua", true))()

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

-- Sidebar Vertical Separator（修复：优先挂载到窗口UI，避免 CoreGui 权限问题）
local SidebarLine = Instance.new("Frame")
SidebarLine.Size = UDim2.new(0, 1, 1, 0)
SidebarLine.Position = UDim2.new(0, 140, 0, 0) -- adjust if needed
SidebarLine.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SidebarLine.BorderSizePixel = 0
SidebarLine.ZIndex = 5
SidebarLine.Name = "SidebarLine"
SidebarLine.Parent = Window.Gui or game:GetService("CoreGui")

-- 主页选项卡（原代码括号位置错误，已修正代码块包裹逻辑）
local MainTab = Window:Tab({Title = "主页", Icon = "star"})
do
    -- Section
    MainTab:Section({Title = "By JAY\n免费脚本.禁止倒卖"})
    
    -- 感谢按钮（修复：缩进混乱，统一代码格式）
    MainTab:Button({
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
    
    -- 测试滑块
    MainTab:Slider({
        Title = "划着玩",
        Min = 0,
        Max = 100,
        Rounding = 0,
        Value = 25,
        Callback = function(val)
            print("Slider:", val)
        end
    })
    
    -- QQ群代码显示（修复：原代码多一个右括号，导致语法错误）
    local CodeBlock = MainTab:Code({
        Title = "下方QQ群",
        Code = "-- 1049557594\n玩Jay进QQ群"
    })
    
    -- 5秒后更新群号显示
    task.delay(5, function()
        CodeBlock:SetCode("请加入QQ群\n1049557594")
    end)
end

-- 分隔线
Window:Line()

-- 通用功能选项卡（原代码与“墨水游戏”选项卡重名，已保留独立命名）
local GeneralTab = Window:Tab({Title = "通用功能", Icon = "wrench"})
do
    -- 行走速度设置
    GeneralTab:Slider({
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

-- 跳跃高度设置
GeneralTab:Slider({
    Title = "设置跳跃高度",
    Min = 0,
    Max = 200, -- 跳跃力量合理范围
    Rounding = 0,
    Value = 50, -- Roblox 默认跳跃力量
    Callback = function(val)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        
        if humanoid then
            humanoid.JumpPower = val
            print("人物跳跃力量已设置为:", val)
        else
            print("未找到人类oid对象，无法设置跳跃高度")
        end
    end
})

-- 透视功能（修复：原代码 task.wait() 可能导致卡顿，优化为单次检测）
GeneralTab:Button({
    Title = "透视",
    Desc = "单击开启玩家透视",
    Callback = function()
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        
        -- 透视高亮模板（统一样式，避免重复创建）
        local highlightTemplate = Instance.new("Highlight")
        highlightTemplate.Name = "PlayerHighlight"
        highlightTemplate.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlightTemplate.FillColor = Color3.fromRGB(255, 0, 0)
        highlightTemplate.OutlineColor = Color3.fromRGB(255, 255, 255)
        
        -- 通用函数：为玩家添加透视和名字标签
        local function setupPlayerView(player)
            if player == game.Players.LocalPlayer then return end
            -- 等待人物和根部件加载（添加超时保护）
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 10)
            if not humanoidRootPart then
                warn("未找到玩家 " .. player.Name .. " 的 HumanoidRootPart，跳过透视设置")
                return
            end
            
            -- 添加透视高亮
            if not humanoidRootPart:FindFirstChild("PlayerHighlight") then
                local highlight = highlightTemplate:Clone()
                highlight.Adornee = character
                highlight.Parent = humanoidRootPart
            end
            
            -- 添加小尺寸名字标签
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
        
        -- 为已有玩家初始化透视
        for _, player in ipairs(Players:GetPlayers()) do
            setupPlayerView(player)
        end
        
        -- 新玩家加入时初始化
        Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function()
                setupPlayerView(player)
            end)
        end)
        
        -- 玩家离开时清理资源
        Players.PlayerRemoving:Connect(function(player)
            local character = player.Character
            if not character then return end
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                if humanoidRootPart:FindFirstChild("PlayerHighlight") then
                    humanoidRootPart.PlayerHighlight:Destroy()
                end
                if humanoidRootPart:FindFirstChild("PlayerNameDisplay") then
                    humanoidRootPart.PlayerNameDisplay:Destroy()
                end
            end
        end)
        
        -- 每帧维护透视状态（防止部件被销毁后失效）
        RunService.Heartbeat:Connect(function()
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer and player.Character then
                    setupPlayerView(player)
                end
            end
        end)
    end
})

-- 飞行脚本（修复：补充错误捕获，避免加载失败导致脚本崩溃）
GeneralTab:Button({
    Title = "飞行脚本",
    Description = "从GitHub加载并执行飞行脚本",
    Callback = function()
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Jay907692/Jay/8b94c47bd5969608438fa1ee57f34b1350789caa/飞行脚本", true))()
        end)
        if success then
            print("飞行脚本已加载并执行")
            Window:Notify({Title = "成功", Desc = "飞行脚本加载完成", Time = 3})
        else
            warn("飞行脚本加载失败:", err)
            Window:Notify({Title = "失败", Desc = "飞行脚本加载出错", Time = 3})
        end
    end
})

-- 穿墙功能（修复：全局变量命名更清晰，避免冲突）
GeneralTab:Toggle({
    Title = "穿墙",
    Flag = "NoClip",
    Default = false,
    Callback = function(isEnabled)
        -- 初始化全局状态（避免重复创建 RunService 连接）
        _G.NoClipState = _G.NoClipState or {
            SteppedConn = nil,
            IsActive = false
        }
        
        local LocalPlayer = game.Players.LocalPlayer
        
        if isEnabled then
            _G.NoClipState.IsActive = true
            -- 断开旧连接，防止重复监听
            if _G.NoClipState.SteppedConn then
                _G.NoClipState.SteppedConn:Disconnect()
            end
            -- 每帧设置碰撞关闭
            _G.NoClipState.SteppedConn = game:GetService("RunService").Stepped:Connect(function()
                local character = LocalPlayer.Character
                if not character or not _G.NoClipState.IsActive then return end
                for _, part in pairs(character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end)
        else
            _G.NoClipState.IsActive = false
            -- 断开连接，恢复碰撞
            if _G.NoClipState.SteppedConn then
                _G.NoClipState.SteppedConn:Disconnect()
                _G.NoClipState.SteppedConn = nil
            end
            local character = LocalPlayer.Character
            if character then
                for _, part in pairs(character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
    end
})

-- 无限跳脚本（修复：补充安全加载参数和错误捕获）
GeneralTab:Button({
    Title = "无限跳",
    Description = "加载并执行无限跳脚本",
    Callback = function()
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://pastebin.com/raw/V5PQy3y0", true))()
        end)
        if success then
            print("无限跳脚本已加载并执行")
            Window:Notify({Title = "成功", Desc = "无限跳已启用", Time = 3})
        else
            warn("无限跳脚本加载失败:", err)
            Window:Notify({Title = "失败", Desc = "无限跳加载出错", Time = 3})
        end
    end
})

-- 夜视功能（修复：初始化原始光照参数，避免关闭时恢复失败）
local nightVisionData = {
    pointLight = nil,
    changedConn = nil,
    originalAmbient = nil,
    originalBrightness = nil,
    originalFogEnd = nil
}
GeneralTab:Toggle({
    Title = "夜视",
    Default = false,
    Callback = function(isEnabled)
        local Lighting = game:GetService("Lighting")
        local LocalPlayer = game.Players.LocalPlayer
        
        if isEnabled then
            pcall(function()
                -- 仅首次开启时保存原始光照设置
                if not nightVisionData.originalAmbient then
                    nightVisionData.originalAmbient = Lighting.Ambient
                    nightVisionData.originalBrightness = Lighting.Brightness
                    nightVisionData.originalFogEnd = Lighting.FogEnd
                end
                -- 设置夜视参数（优化亮度，避免过亮刺眼）
                Lighting.Ambient = Color3.fromRGB(150, 150, 150)
                Lighting.Brightness = 0.8
                Lighting.FogEnd = 1e10
                
                -- 禁用影响夜视的特效
                for _, effect in pairs(Lighting:GetDescendants()) do
                    local disableTypes = {"BloomEffect", "BlurEffect", "ColorCorrectionEffect", "SunRaysEffect"}
                    for _, typ in ipairs(disableTypes) do
                        if effect:IsA(typ) then
                            effect.Enabled = false
                        end
                    end
                end
                
                -- 监听光照变化，防止参数被覆盖
                if nightVisionData.changedConn then
                    nightVisionData.changedConn:Disconnect()
                end
                nightVisionData.changedConn = Lighting.Changed:Connect(function()
                    Lighting.Ambient = Color3.fromRGB(150, 150, 150)
                    Lighting.Brightness = 0.8
                    Lighting.FogEnd = 1e10
                end)
                
                -- 给角色头部添加光源（原代码挂载到根部件，改为挂载到头部更合理）
                spawn(function()
                    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local head = character:WaitForChild("Head", 10)
                    if not head then return end
                    if not head:FindFirstChild("NightVisionLight") then
                        local headLight = Instance.new("PointLight")
                        headLight.Name = "NightVisionLight"
                        headLight.Parent = head
                        headLight.Brightness = 0.5
                        headLight.Range = 40
                        headLight.Color = Color3.fromRGB(200, 200, 200)
                        nightVisionData.pointLight = headLight
                    end
                end)
            end)
        else
            -- 恢复原始光照设置
            if nightVisionData.originalAmbient then
                Lighting.Ambient = nightVisionData.originalAmbient
            end
            if nightVisionData.originalBrightness then
                Lighting.Brightness = nightVisionData.originalBrightness
            end
            if nightVisionData.originalFogEnd then
                Lighting.FogEnd = nightVisionData.originalFogEnd
            end
            -- 断开光照监听
            if nightVisionData.changedConn then
                nightVisionData.changedConn:Disconnect()
                nightVisionData.changedConn = nil
            end
            -- 销毁头部光源
            if nightVisionData.pointLight and nightVisionData.pointLight.Parent then
                nightVisionData.pointLight:Destroy()
                nightVisionData.pointLight = nil
            end
        end
    end
})

-- 爬墙功能（修复：补充安全加载参数，修正按钮标题特殊字符）
GeneralTab:Button({
    Title = "爬墙（无法关闭）",
    Description = "加载并执行爬墙脚本",
    Callback = function()
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r", true))()
        end)
        if success then
            print("爬墙脚本已加载并执行")
            Window:Notify({Title = "成功", Desc = "爬墙功能已启用", Time = 3})
        else
            warn("爬墙脚本加载失败:", err)
            Window:Notify({Title = "失败", Desc = "爬墙脚本加载出错", Time = 3})
        end
    end
})

-- 墨水游戏选项卡（修复：代码块括号不匹配，统一按钮挂载目标）
local InkGameTab = Window:Tab({Title = "墨水游戏", Icon = "skull"})
do
    -- 英文防封部分
    InkGameTab:Section({Title = "英文防封", Icon = "wrench"})
    InkGameTab:Button({
        Title = "AX",
        Desc = "单击以执行",
        Callback = function()
            local success, err = pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/TexRBLX/Roblox-stuff/refs/heads/main/ink-game/
