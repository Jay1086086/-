-- 1. 加载UI框架并初始化（保留原逻辑，增加错误捕获）
local success, WindUI = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/Syndromehsh/Lua/refs/heads/main/AlienX/AlienX%20Wind%203.0%20UI.txt"))()
end)
if not success then
    warn("UI框架加载失败: " .. WindUI)
    return
end

-- 2. 通知和玩家对象初始化（增加空值判断）
WindUI:Notify({
    Title = "JAY hub",
    Content = "被遗弃",
    Duration = 4
})
local player = game.Players.LocalPlayer
if not player then
    warn("无法获取本地玩家")
    return
end

-- 3. 创建窗口（修正标题特殊字符，完善参数）
local Window = WindUI:CreateWindow({
    Title = "JAYhub<font color='#00FF00'>1.8</font>",  -- 移除无效特殊字符""
    Icon = "rbxassetid://4483362748",
    IconTransparency = 0.5,
    Author = "JAY hub",
    Folder = "JAY hub",
    Size = UDim2.fromOffset(500, 400),  -- 修正原过小尺寸（100x150无法显示内容）
    Transparent = true,
    Theme = "Dark",
    UserEnabled = true,
    SideBarWidth = 145,
    HasOutline = true,
    User = {
        Enabled = true,
        Anonymous = false,
        Username = player.Name,
        DisplayName = player.DisplayName,
        UserId = player.UserId,
        Thumbnail = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=420&height=420&format=png",
        Callback = function()
            WindUI:Notify({
                Title = "用户信息",
                Content = "玩家: " .. player.Name .. " (" .. player.DisplayName .. ")",
                Duration = 3
            })
        end
    }
})

-- 4. 编辑打开按钮（保留原逻辑）
Window:EditOpenButton({
    Title = "JAY",
    Icon = "monitor",
    CornerRadius = UDim.new(1,10),
    StrokeThickness = 2,
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromHex("FF0000")),
        ColorSequenceKeypoint.new(0.16, Color3.fromHex("FF7F00")),
        ColorSequenceKeypoint.new(0.33, Color3.fromHex("FFFF00")),
        ColorSequenceKeypoint.new(0.5, Color3.fromHex("00FF00")),
        ColorSequenceKeypoint.new(0.66, Color3.fromHex("0000FF")),
        ColorSequenceKeypoint.new(0.83, Color3.fromHex("4B0082")),
        ColorSequenceKeypoint.new(1, Color3.fromHex("9400D3"))
    }),
    Draggable = true,
})

-- 5. 修复标签页创建（核心错误：原代码直接使用Tabs.Main，需从Window获取）
local Tabs = Window:CreateTabs()  -- 从Window创建标签容器，而非依赖外部Tabs
local TabHandles = {
    Elements = Tabs:Tab({ Title = "通用功能" }),  -- 修正：Tabs:Tab() 而非 Tabs.Main:Tab()
    Player = Tabs:Tab({ Title = "死铁轨" }),
    ESP = Tabs:Tab({ Title = "墨水游戏" }),
    Other = Tabs:Tab({ Title = "GB" }),
    Anti = Tabs:Tab({ Title = "最强战场" })
}
Window:SelectTab(1)

-- 6. 全局变量初始化
_G.REP = 1.8
_G.BTE = false

-- 7. 修复Section和Slider创建（.Section → :Section，补充Slider必要参数）
local chineseSection = TabHandles.Elements:Section({  -- 核心修复：方法调用需用:
    Title = "中文"
})
local repairSlider = chineseSection:Slider({
    Title = "JAY旧UI新版功能不完全",
    Min = 1,  -- 补充必要参数
    Max = 10,
    Default = 5,
    Callback = function(value)
        -- 【高危警告】禁止执行远程脚本，可能导致盗号/封号！
        -- loadstring(game:HttpGet("https://raw.githubusercontent.com/Jay1086086/-/ab504d2014a3e5ea12968f48fd5b575ed91d74ca/AlienX%20%E8%A2%AB%E9%81%97%E5%BC%83(1).lua"))()
    end
})

-- 8. 自动修电箱Toggle（保留原逻辑，增加空值判断）
local repairToggle = TabHandles.Elements:Toggle({
    Title = "自动修电箱",
    Default = false,
    Callback = function(state)
        _G.BTE = state
        local function RepairGenerators()
            local map = workspace:FindFirstChild("Map")
            if not map then return end  -- 增加空值判断
            local ingame = map:FindFirstChild("Ingame")
            if not ingame then return end
            local currentMap = ingame:FindFirstChild("Map")
            if not currentMap then return end
            
            for _, obj in ipairs(currentMap:GetChildren()) do
                if obj.Name == "Generator" then
                    local progress = obj:FindFirstChild("Progress")
                    local remotes = obj:FindFirstChild("Remotes")
                    if progress and remotes and progress.Value < 100 then
                        local remote = remotes:FindFirstChild("RE")
                        if remote then
                            remote:FireServer()
                        end
                    end
                end
            end
        end
        if state then
            task.spawn(function()
                while _G.BTE do
                    RepairGenerators()
                    task.wait(_G.REP or 1.8) 
                end
            end)
        end
    end
})

-- 9. 无限体力模块（修复重复定义，增加错误捕获）
local sprintModule
local isStaminaDrainDisabled = false
local staminaMonitorConnection = nil
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local function modifyStaminaSettings()
    pcall(function()
        if not sprintModule then
            local success, module = pcall(require, ReplicatedStorage:FindFirstChild("Systems", true) and ReplicatedStorage.Systems.Character.Game.Sprinting)
            if success and module then
                sprintModule = module
                return
            end
        end
        if sprintModule and sprintModule.StaminaLossDisabled ~= nil then
             sprintModule.StaminaLossDisabled = isStaminaDrainDisabled
        end
    end)
end

local function monitorAndReapplyStamina()
    if staminaMonitorConnection then
        staminaMonitorConnection:Disconnect()
    end
    staminaMonitorConnection = RunService.Heartbeat:Connect(function()
        if isStaminaDrainDisabled then
            modifyStaminaSettings()
        else
            if staminaMonitorConnection then
                staminaMonitorConnection:Disconnect()
                staminaMonitorConnection = nil
            end
        end
    end)
end

local infiniteStaminaToggle = TabHandles.Elements:Toggle({
    Title = "无限体力",
    Default = false,
    Callback = function(state)
        isStaminaDrainDisabled = state
        modifyStaminaSettings()
        
        if state then
            monitorAndReapplyStamina()
        else
            if staminaMonitorConnection then
                staminaMonitorConnection:Disconnect()
                staminaMonitorConnection = nil
            end
            if sprintModule and sprintModule.StaminaLossDisabled ~= nil then
                sprintModule.StaminaLossDisabled = false 
            end
        end
    end
})

-- 10. 恢复体力按钮（修复重复定义ReplicatedStorage）
local function restoreStamina()
    pcall(function()
        local sprintingPath = ReplicatedStorage:FindFirstChild("Systems", true)
        if not sprintingPath then return end
        local SprintingModule = sprintingPath:FindFirstChild("Character", true)
        SprintingModule = SprintingModule and SprintingModule:FindFirstChild("Game", true)
        SprintingModule = SprintingModule and SprintingModule:FindFirstChild("Sprinting")
        if not SprintingModule then return end
        
        local sprintModule = require(SprintingModule)
        if sprintModule and sprintModule.SetStamina then
            sprintModule.SetStamina(sprintModule.MaxStamina or 100)
        end
    end)
end

TabHandles.Elements:Button({
    Title = "恢复体力",
    Callback = function()
        restoreStamina()
    end
})

-- 11. Shedletsky幸存者模块（保留原逻辑，增加空值判断）
TabHandles.Elements:Section({ Title = "Shedletsky幸存者" })
local autoSlashEnabled = false
local slashConnection = nil

local function checkAndSlash()
    if not player or not player.Character then return end
    local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local killersFolder = workspace:FindFirstChild("Players")
    if not killersFolder then return end
    local killers = killersFolder:FindFirstChild("Killers")
    if not killers then return end
    
    local playerPosition = humanoidRootPart.Position
    for _, killer in ipairs(killers:GetChildren()) do
        local killerRoot = killer:FindFirstChild("HumanoidRootPart")
        if killerRoot then
            local distance = (playerPosition - killerRoot.Position).Magnitude
            if distance <= 10 then
                local remoteEvent = ReplicatedStorage:FindFirstChild("Modules", true)
                remoteEvent = remoteEvent and remoteEvent:FindFirstChild("Network", true)
                remoteEvent = remoteEvent and remoteEvent:FindFirstChild("RemoteEvent")
                if remoteEvent then
                    remoteEvent:FireServer("UseActorAbility", "Slash")  -- 简化参数传递
                end
                break
            end
        end
    end
end

local autoSlashToggle = TabHandles.Elements:Toggle({
    Title = "自动斩击(被动)",
    Default = false,
    Callback = function(state)
        autoSlashEnabled = state
        if state then
            if slashConnection then slashConnection:Disconnect() end
            slashConnection = RunService.Heartbeat:Connect(checkAndSlash)
        else
            if slashConnection then
                slashConnection:Disconnect()
                slashConnection = nil
            end
        end
    end
})

-- 12. Shedletsky自动瞄准（增加角色判断空值）
local shedletskyAimbotEnabled = false
local shedloop = nil

local function shedletskyAimbot(state)
    shedletskyAimbotEnabled = state
    if state then
        if not player.Character or player.Character.Name ~= "Shedletsky" then
            WindUI:Notify({ Title = "错误", Content = "角色不是Shedletsky", Duration = 2 })
            return
        end
        local sword = player.Character:FindFirstChild("Sword")
        if not sword then
            WindUI:Notify({ Title = "错误", Content = "未找到Sword", Duration = 2 })
            return
        end
        shedloop = sword.ChildAdded:Connect(function(child)
            if not shedletskyAimbotEnabled or not child:IsA("Sound") then return end
            local soundIds = { "12222225", "83851356262523" }
            local childId = child.Name:match("%d+") or child.Name
            if not table.find(soundIds, childId) then return end
            
            local killersFolder = workspace.Players:FindFirstChild("Killers")
            if not killersFolder then return end
            local killer = killersFolder:FindFirstChildOfClass("Model")
            if not killer then return end
            local killerHRP = killer:FindFirstChild("HumanoidRootPart")
            local playerHRP = player.Character:FindFirstChild("HumanoidRootPart")
            if not killerHRP or not playerHRP then return end
            
            local distance = (killerHRP.Position - playerHRP.Position).Magnitude
            if distance <= 30 then
                local num = 1
                local maxIterations = 100
                while num <= maxIterations and shedletskyAimbotEnabled do
                    task.wait(0.01)
                    num = num + 1
                    local camera = workspace.CurrentCamera
                    if camera then
                        camera.CFrame = CFrame.new(camera.CFrame.Position, killerHRP.Position)
                    end
                    playerHRP.CFrame = CFrame.lookAt(playerHRP.Position, killerHRP.Position)
                end
            end
        end)
    else
        if shedloop then
            shedloop:Disconnect()
            shedloop = nil
        end
    end
end

local shedAimbotToggle = TabHandles.Elements:Toggle({
    Title = "自动瞄准",
    Default = false,
    Callback = shedletskyAimbot  -- 简化回调传递
})

-- 13. Chance幸存者模块（修复重复定义，增加空值判断）
TabHandles.Elements:Section({ Title = "Chance幸存者" })
local LocalPlayer = game.Players.LocalPlayer
local PredictionAim = {
    Enabled = false,
    Prediction = 1,
    Duration = 1.7,
    MaxDistance = 50, 
    Targets = { "Jason", "c00lkidd", "JohnDoe", "1x1x1x1", "Noli" },
    TrackedAnimations = {
        ["103601716322988"] = true, ["133491532453922"] = true, ["86371356500204"] = true,
        ["76649505662612"] = true, ["81698196845041"] = true
    },
    Humanoid = nil,
    HRP = nil,
    LastTriggerTime = 0,
    IsAiming = false,
    OriginalState = nil
}

local function setupCharacter(char)
    if not char then return end
    PredictionAim.Humanoid = char:WaitForChild("Humanoid", 5)  -- 增加超时
    PredictionAim.HRP = char:WaitForChild("HumanoidRootPart", 5)
end

local function getValidTarget()
    local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
    if not killersFolder or not PredictionAim.HRP then return nil end
    
    for _, name in ipairs(PredictionAim.Targets) do
        local target = killersFolder:FindFirstChild(name)
        if target then
            local targetHRP = target:FindFirstChild("HumanoidRootPart")
            if targetHRP then
                local distance = (PredictionAim.HRP.Position - targetHRP.Position).Magnitude
                if distance <= PredictionAim.MaxDistance then
                    return targetHRP
                end
            end
        end
    end
    return nil
end

local function getPlayingAnimationIds()
    local ids = {}
    if not PredictionAim.Humanoid then return ids end
    for _, track in ipairs(PredictionAim.Humanoid:GetPlayingAnimationTracks()) do
        if track.Animation and track.Animation.AnimationId then
            local id = track.Animation.AnimationId:match("%d+")
            if id then ids[id] = true end
        end
    end
    return ids
end

local function OnRenderStep()
    if not PredictionAim.Enabled or not PredictionAim.Humanoid or not PredictionAim.HRP then return end
    local playing = getPlayingAnimationIds()
    local triggered = false
    for id in pairs(PredictionAim.TrackedAnimations) do
        if playing[id] then triggered = true; break end
    end
    
    if triggered then
        PredictionAim.LastTriggerTime = tick()
        PredictionAim.IsAiming = true
    end
    
    if PredictionAim.IsAiming then
        local timeElapsed = tick() - PredictionAim.LastTriggerTime
        if timeElapsed <= PredictionAim.Duration then
            if not PredictionAim.OriginalState then
                PredictionAim.OriginalState = {
                    WalkSpeed = PredictionAim.Humanoid.WalkSpeed,
                    JumpPower = PredictionAim.Humanoid.JumpPower,
                    AutoRotate = PredictionAim.Humanoid.AutoRotate
                }
                PredictionAim.Humanoid.AutoRotate = false
                PredictionAim.HRP.AssemblyAngularVelocity = Vector3.zero
