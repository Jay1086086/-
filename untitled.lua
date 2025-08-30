local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingyan777/roblox/refs/heads/main/main.lua"))()

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

local Confirmed = false
local walkSpeed = 16
local jumpPower = 50
local lastWalkSpeed = 16
local lastJumpPower = 50
local speedBoostEnabled = false
local superJumpEnabled = false
local noclipEnabled = false
local flyEnabled = false
local notifyCooldown = 0
local NOTIFY_DELAY = 0.5
local walkSpeedNotify
local jumpPowerNotify
local isMobile = UserInputService.TouchEnabled

local function updateWalkSpeed()
    if localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid") then
        localPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = speedBoostEnabled and walkSpeed or 16
    end
end

local function updateJumpPower()
    if localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid") then
        localPlayer.Character:FindFirstChildOfClass("Humanoid").JumpPower = superJumpEnabled and jumpPower or 50
    end
end

WindUI:Popup({
    Title = "XLAv1.0",
    Icon = "rbxassetid://129260712070622",
    IconThemed = true,
    Content = "欢迎使用JAYhub1.8",
    Buttons = {
        {
            Title = "进入脚本",
            Icon = "arrow-right",
            Callback = function() Confirmed = true end,
            Variant = "Primary",
        }
    }
})

repeat wait() until Confirmed

local Window = WindUI:CreateWindow({
    Title = "JAY脚本中心",
    Icon = "crown",
    IconThemed = true,
    Author = "作者:冷情",
    Folder = "MyGUI",
    Size = UDim2.fromOffset(580, 340),
    Transparent = true,
    Theme = "Dark",
    User = { Enabled = true },
    SideBarWidth = 200,
    ScrollBarEnabled = true,
})
Window:Tag({
    Title = "1.8",
    Color = Color3.fromHex("#30ff6a")
})

local Tabs = {
    Main = Window:Tab({ Title = "主页", Icon = "rbxassetid://6026568198" }),
    tonyon = Window:Tab({ Title = "通用", Icon = "rbxassetid://94462465090724" }),
    Combat = Window:Tab({ Title = "死铁轨", Icon = "swords" }),
    Player = Window:Tab({ Title = "99夜", Icon = "user" }),
    Misc = Window:Tab({ Title = "最强战场", Icon = "settings" }),
    Exploit = Window:Tab({ Title = "音乐", Icon = "code" }),
}

Window:SelectTab(1)

Tabs.Main:Paragraph({
    Title = "JAYhub",
    Desc = "Q群1049557594",
    Image = "https://i.postimg.cc/nL97SYHB/20250722-07083338.jpg",
    ImageSize = 42,
    Thumbnail = "https://i.postimg.cc/fLmB0Qp3/IMG-20250821-130711.jpg",
    ThumbnailSize = 120
})
Tabs.Main:Paragraph({
    Title = "免费脚本，倒卖私募",
    Desc = "当前服务器ID: " .. game.PlaceId, -- 显示服务器ID
})
Tabs.Main:Paragraph({
    Title = "您的注入器",
    Desc = ": " .. identifyexecutor(), -- 显示注入器ID
})

Tabs.tonyon:Slider({
    Title = "速度值",
    Desc = "设置超级速度的大小 (16-400)",
    Value = {
        Min = 16,
        Max = 400,
        Default = 16,
    },
    Callback = function(value)
        walkSpeed = value
        lastWalkSpeed = value
        
        if speedBoostEnabled then
            updateWalkSpeed()
        end
        
        -- 清除之前的计时器
        if walkSpeedNotify then
            walkSpeedNotify:Disconnect()
        end
        
        -- 设置新的计时器，停止调节0.5秒后显示通知
        notifyCooldown = tick()
        walkSpeedNotify = RunService.Heartbeat:Connect(function()
            if tick() - notifyCooldown > NOTIFY_DELAY then
                WindUI:Notify({
                    Title = "速度值设置为: " .. lastWalkSpeed,
                    Desc = "速度值设置为: " .. lastWalkSpeed,
                    Duration = 2
                })
                walkSpeedNotify:Disconnect()
            end
        end)
    end
})

Tabs.tonyon:Slider({
    Title = "跳跃高度",
    Desc = "设置跳跃高度 (50-200)",
    Value = {
        Min = 50,
        Max = 200,
        Default = 100,
    },
    Callback = function(value)
        jumpPower = value
        lastJumpPower = value
        
        if superJumpEnabled then
            updateJumpPower()
        end
        
        -- 清除之前的计时器
        if jumpPowerNotify then
            jumpPowerNotify:Disconnect()
        end
        
        -- 设置新的计时器，停止调节0.5秒后显示通知
        notifyCooldown = tick()
        jumpPowerNotify = RunService.Heartbeat:Connect(function()
            if tick() - notifyCooldown > NOTIFY_DELAY then
                WindUI:Notify({
                    Title = "跳跃高度设置为: " .. lastJumpPower,
                    Desc = "跳跃高度设置为: " .. lastJumpPower,
                    Duration = 2
                })
                jumpPowerNotify:Disconnect()
            end
        end)
    end
})

Tabs.tonyon:Toggle({
    Title = "速度增强",
    Desc = "启用/禁用速度增强",
    Callback = function(state)
        speedBoostEnabled = state
        updateWalkSpeed()
        WindUI:Notify({
            Title = state and "速度增强已启用" or "速度增强已禁用",
            Desc = state and "速度增强已激活" or "速度增强已关闭",
            Duration = 3
        })
    end
})

-- 超级跳跃开关
Tabs.tonyon:Toggle({
    Title = "超级跳跃",
    Desc = "启用/禁用超级跳跃",
    Callback = function(state)
        superJumpEnabled = state
        updateJumpPower()
        WindUI:Notify({
            Title = state and "超级跳跃已启用" or "超级跳跃已禁用",
            Desc = state and "超级跳跃已激活" or "超级跳跃已关闭",
            Duration = 3
        })
    end
})

local noclipToggle = Tabs.tonyon:Toggle({
    Title = "穿墙模式",
    Desc = "可以穿透墙壁和障碍物",
    Callback = function(state)
        noclipEnabled = state
        if state then
            WindUI:Notify({
                Title = "穿墙模式已启用",
                Desc = "已启用",
                Duration = 3
            })
        else
            WindUI:Notify({
                Title = "穿墙模式已禁用",
                Desc = "已关闭",
                Duration = 3
            })
        end
    end
})

local nightVisionToggle = Tabs.tonyon:Toggle({
    Title = "夜视",
    Desc = "启用夜视效果，提高环境亮度",
    Callback = function(state)
        if state then
            game.Lighting.Ambient = Color3.new(1, 1, 1)
            WindUI:Notify({
                Title = "夜视已启用",
                Desc = "夜视效果已激活",
                Duration = 3
            })
        else
            game.Lighting.Ambient = Color3.new(0, 0, 0)
            WindUI:Notify({
                Title = "夜视已禁用",
                Desc = "夜视效果已关闭",
                Duration = 3
            })
        end
    end
})

local infiniteJumpToggle = Tabs.tonyon:Toggle({
    Title = "无限跳",
    Desc = "启用无限跳跃能力",
    Callback = function(state)
        if state then
            loadstring(game:HttpGet("https://pastebin.com/raw/V5PQy3y0", true))()
            WindUI:Notify({
                Title = "无限跳已启用",
                Desc = "无限跳跃功能已激活",
                Duration = 3
            })
        else
            WindUI:Notify({
                Title = "无限跳已禁用",
                Desc = "无限跳跃功能已关闭",
                Duration = 3
            })
        end
    end
})

local flyButton = Tabs.tonyon:Button({
    Title = "飞行V3",
    Desc = "冷情汉化飞行",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingyan777/roblox/refs/heads/main/fly.lua", true))()
        WindUI:Notify({
            Title = "飞行V3已启用",
            Desc = "飞行功能已激活",
            Duration = 3
        })
    end
})

-- 自杀功能
local suicideButton = Tabs.tonyon:Button({
    Title = "自杀",
    Desc = "单机变成残渣",
    Callback = function()
        if localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid") then
            localPlayer.Character:FindFirstChildOfClass("Humanoid").Health = 0
            WindUI:Notify({
                Title = "自杀执行",
                Desc = "角色生命值已归零",
                Duration = 3
            })
        end
    end
})

-- 反挂机功能
local antiAfkButton = Tabs.tonyon:Button({
    Title = "反挂机v2",
    Desc = "启用反挂机功能，防止被踢出游戏",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/9fFu43FF"))()
        WindUI:Notify({
            Title = "反挂机已启用",
            Desc = "反挂机功能v2已激活",
            Duration = 3
        })
    end
})

-- 角色重生时重新应用设置
localPlayer.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid")
    task.wait(1)
    
    updateWalkSpeed()
    updateJumpPower()
end)

-- 其他标签页内容...
Tabs.Player:Button({
    Title = "自然灾害黑洞(确认)",
    Desc = "执行自然灾害黑洞脚本 - 需要确认",
    Callback = function()
        WindUI:Popup({
            Title = "警告",
            Content = "确定要执行自然灾害黑洞脚本吗？这可能会影响游戏体验。",
            Buttons = {
                {
                    Title = "取消",
                    Callback = function()
                        WindUI:Notify({
                            Title = "已取消",
                            Desc = "操作已取消",
                            Duration = 3
                        })
                    end,
                    Variant = "Secondary"
                },
                {
                    Title = "确定执行",
                    Callback = function()
                        WindUI:Notify({
                            Title = "正在加载自然灾害黑洞脚本...",
                            Desc = "正在加载自然灾害黑洞脚本...",
                            Duration = 3
                        })
                        
                        local success, errorMessage = pcall(function()
                            loadstring(game:HttpGet("https://pastebin.com/raw/MAnXu0qv"))()
                        end)
                        
                        if success then
                            WindUI:Notify({
                                Title = "自然灾害黑洞脚本加载成功！",
                                Desc = "自然灾害黑洞脚本加载成功！",
                                Duration = 5
                            })
                        else
                            WindUI:Notify({
                                Title = "脚本加载失败: " .. tostring(errorMessage),
                                Desc = "脚本加载失败: " .. tostring(errorMessage),
                                Duration = 5
                            })
                        end
                    end,
                    Variant = "Destructive"
                }
            }
        })
    end
})

Tabs.Player:Button({
    Title = "飞车(确认)",
    Desc = "执行飞车脚本 - 需要确认",
    Callback = function()
        WindUI:Popup({
            Title = "警告",
            Content = "确定要执行飞车脚本吗？这可能会影响游戏体验。",
            Buttons = {
                {
                    Title = "取消",
                    Callback = function()
                        WindUI:Notify({
                            Title = "已取消",
                            Desc = "操作已取消",
                            Duration = 3
                        })
                    end,
                    Variant = "Secondary"
                },
                {
                    Title = "确定执行",
                    Callback = function()
                        WindUI:Notify({
                            Title = "正在加载飞车脚本...",
                            Desc = "正在加载飞车脚本...",
                            Duration = 3
                        })
                        
                        local success, errorMessage = pcall(function()
                            loadstring(game:HttpGet('https://github.com/XIAOLINLAIXLA/XLA/raw/refs/heads/main/%E9%A3%9E%E8%A1%8C'))()
                        end)
                        
                        if success then
                            WindUI:Notify({
                                Title = "飞车脚本加载成功！",
                                Desc = "飞车脚本加载成功！",
                                Duration = 5
                            })
                        else
                            WindUI:Notify({
                                Title = "错误脚本加载失败: " .. tostring(errorMessage),
                                Desc = "脚本加载失败: " .. tostring(errorMessage),
                                Duration = 5
                            })
                        end
                    end,
                    Variant = "Destructive"
                }
            }
        })
    end
})

Tabs.Player:Button({
    Title = "Xa汉化墨水游戏脚本",
    Desc = "执行Xa汉化墨水游戏脚本 - 需要确认",
    Callback = function()
        WindUI:Popup({
            Title = "警告",
            Content = "确定要执行Xa汉化墨水游戏脚本吗？这可能会影响游戏体验。",
            Buttons = {
                {
                    Title = "取消",
                    Callback = function()
                        WindUI:Notify({
                            Title = "已取消",
                            Desc = "操作已取消",
                            Duration = 3
                        })
                    end,
                    Variant = "Secondary"
                },
                {
                    Title = "确定执行",
                    Callback = function()
                        WindUI:Notify({
                            Title = "正在加载Xa汉化墨水游戏脚本...",
                            Desc = "正在加载Xa汉化墨水游戏脚本...",
                            Duration = 3
                        })
                        
                        local success, errorMessage = pcall(function()
                            loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/refs/heads/main/Games/墨水游戏.lua"))()
                        end)
                        
                        if success then
                            WindUI:Notify({
                                Title = "Xa汉化墨水游戏脚本加载成功！",
                                Desc = "Xa汉化墨水游戏脚本加载成功！",
                                Duration = 5
                            })
                        else
                            WindUI:Notify({
                                Title = "错误脚本加载失败: " .. tostring(errorMessage),
                                Desc = "脚本加载失败: " .. tostring(errorMessage),
                                Duration = 5
                            })
                        end
                    end,
                    Variant = "Destructive"
                }
            }
        })
    end
})

Tabs.Player:Button({
    Title = "TE汉化墨水游戏脚本",
    Desc = "执行TE汉化墨水游戏脚本 - 需要确认",
    Callback = function()
        WindUI:Popup({
            Title = "警告",
            Content = "确定要执行TE汉化墨水游戏脚本吗？这可能会影响游戏体验。",
            Buttons = {
                {
                    Title = "取消",
                    Callback = function()
                        WindUI:Notify({
                            Title = "已取消",
                            Desc = "操作已取消",
                            Duration = 3
                        })
                    end,
                    Variant = "Secondary"
                },
                {
                    Title = "确定执行",
                    Callback = function()
                        WindUI:Notify({
                            Title = "正在加载TE汉化墨水游戏脚本...",
                            Desc = "正在加载TE汉化墨水游戏脚本...",
                            Duration = 3
                        })
                        
                        local success, errorMessage = pcall(function()
                            loadstring(game:HttpGet("https://raw.githubusercontent.com/hdjsjjdgrhj/script-hub/refs/heads/main/TexRBLlX"))()
                        end)
                        
                        if success then
                            WindUI:Notify({
                                Title = "TE汉化墨水游戏脚本加载成功！",
                                Desc = "TE汉化墨水游戏脚本加载成功！",
                                Duration = 5
                            })
                        else
                            WindUI:Notify({
                                Title = "错误脚本加载失败: " .. tostring(errorMessage),
                                Desc = "脚本加载失败: " .. tostring(errorMessage),
                                Duration = 5
                            })
                        end
                    end,
                    Variant = "Destructive"
                }
            }
        })
    end
})

-- 初始化完成提示
WindUI:Notify({
    Title = "系统加载完成",
    Desc = "移动增强功能已就绪！设备: " .. (isMobile and "手机" or "电脑"),
    Duration = 5
})

-- 穿墙功能
local noclipConnection
if noclipToggle then
    noclipConnection = RunService.Stepped:Connect(function()
        if noclipEnabled and localPlayer.Character then
            for _, part in pairs(localPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end

-- 清理连接
game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(char)
    wait(0.7)
    flyEnabled = false
end)

-- 关闭UI时清理
Window:OnClose(function()
    if noclipConnection then
        noclipConnection:Disconnect()
    end
    if walkSpeedNotify then
        walkSpeedNotify:Disconnect()
    end
    if jumpPowerNotify then
        jumpPowerNotify:Disconnect()
    end
end)
```

主要修复内容：

1. 在Popup函数调用中添加了缺失的逗号
2. 添加了所有必要的变量声明和初始化
3. 添加了缺失的updateWalkSpeed和updateJumpPower函数
4. 修复了速度增强和超级跳跃的切换功能
5. 添加了必要的服务引用（UserInputService, RunService, Players）
6. 修复了飞行按钮的功能（替换了原来的错误代码）
7. 添加了穿墙功能的实现
8. 添加了UI关闭时的清理功能
9. 修复了条件判断和函数调用错误

这些修改应该能解决代码中的主要问题，使脚本能够正常运行。