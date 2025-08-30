local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingyan777/roblox/refs/heads/main/main.lua"))()

local Confirmed = false

WindUI:Popup({
    Title = "XLAv1.0",
    Icon = "rbxassetid://129260712070622",
    IconThemed = true,
    Content = "欢迎使用XLA的脚本 - 设备: " .. (isMobile and "手机" or "电脑"),
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

-- 创建指定的大类（作为标签页）
local Tabs = {
    Main = Window:Tab({ Title = "主页", Icon = "rbxassetid://6026568198" }),
    tonyon = Window:Tab({ Title = "通用", Icon = "rbxassetid://94462465090724" }),
    Combat = Window:Tab({ Title = "死铁轨", Icon = "swords" }),
    Player = Window:Tab({ Title = "99夜", Icon = "user" }),
    Misc = Window:Tab({ Title = "最强战场", Icon = "settings" }),
    Exploit = Window:Tab({ Title = "音乐", Icon = "code" }),
}

Window:SelectTab(1)

-- 主页面内容
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


-- 用于存储滑块最后值和通知计时器
local lastFlySpeed = 1
local lastWalkSpeed = 16
local lastJumpPower = 100
local notifyCooldown = 0
local NOTIFY_DELAY = 0.5 -- 0.5秒后显示通知
local flyToggle = Tabs.Movement:Toggle({
    Title = "开启绘制",
    Desc = "启用人物绘制",
    Callback = function(state)
        ESP.Enabled = state
        if state then
            WindUI:Notify({
                Title = "绘制已启用",
                Desc = "ESP人物绘制已启用",
                Duration = 3
            })
        else
            WindUI:Notify({
                Title = "绘制已禁用",
                Desc = "ESP人物绘制已禁用",
                Duration = 3
            })
        end
    end
})

-- 添加ESP配置选项
Tabs.Movement:Toggle({
    Title = "显示方框",
    Desc = "显示玩家周围的方框",
    Default = true,
    Callback = function(state)
        ESP.ShowBoxes = state
    end
})

Tabs.Movement:Toggle({
    Title = "显示名字",
    Desc = "显示玩家名字",
    Default = true,
    Callback = function(state)
        ESP.ShowNames = state
    end
})

Tabs.Movement:Toggle({
    Title = "显示追踪线",
    Desc = "显示从屏幕底部到玩家的线",
    Default = true,
    Callback = function(state)
        ESP.ShowTracers = state
    end
})

Tabs.Movement:Toggle({
    Title = "显示血量",
    Desc = "显示玩家血量信息",
    Default = true,
    Callback = function(state)
        ESP.ShowHealth = state
    end
})

Tabs.Movement:Toggle({
    Title = "彩虹模式",
    Desc = "启用彩虹色效果",
    Callback = function(state)
        if state then
            ESP.Color = nil -- 设置为nil以使用彩虹色
        else
            ESP.Color = Color3.new(1, 1, 1) -- 设置为白色
        end
    end
})
-- Movement 标签页
local flyToggle = Tabs.Movement:Toggle({
    Title = "飞行模式",
    Desc = "启用高级飞行功能，使用WASD控制方向",
    Callback = function(state)
        if state then
            if enableFlight() then
                WindUI:Notify({
                    Title = "飞行模式已启用",
                    Desc = "高级飞行已启用！使用WASD控制方向",
                    Duration = 3
                })
            else
                flyToggle:Set(false)
                WindUI:Notify({
                    Title = "错误",
                    Desc = "无法启用飞行，请确保角色存在",
                    Duration = 3
                })
            end
        else
            disableFlight()
            WindUI:Notify({
                Title = "飞行已禁用",
                Desc = "飞行已禁用",
                Duration = 3
            })
        end
    end
})

-- 飞行速度滑块（只在停止调节后显示通知）
Tabs.Movement:Slider({
    Title = "飞行速度",
    Desc = "调整飞行移动速度 (1-200)",
    Value = {
        Min = 1,
        Max = 200,
        Default = 1,
    },
    Callback = function(value)
        flySpeed = value
        lastFlySpeed = value
        maxspeed = value * 10 -- 映射到飞行系统的速度
        
        -- 清除之前的计时器
        if flySpeedNotify then
            flySpeedNotify:Disconnect()
        end
        
        -- 设置新的计时器，停止调节0.5秒后显示通知
        flySpeedNotify = game:GetService("RunService").Heartbeat:Connect(function()
            if tick() - notifyCooldown > NOTIFY_DELAY then
                WindUI:Notify({
                    Title = "飞行速度设置为: " .. lastFlySpeed,
                    Desc = "飞行速度设置为: " .. lastFlySpeed,
                    Duration = 2
                })
                flySpeedNotify:Disconnect()
            end
        end)
        
        notifyCooldown = tick()
    end
})

local speedToggle = Tabs.Movement:Toggle({
    Title = "超级速度",
    Desc = "大幅增加地面移动速度",
    Callback = function(state)
        speedBoostEnabled = state
        updateWalkSpeed()
        if state then
            WindUI:Notify({
                Title = "超级速度已启用，速度: " .. walkSpeed,
                Desc = "已启用，速度: " .. walkSpeed,
                Duration = 3
            })
        else
            WindUI:Notify({
                Title = "超级速度已禁用",
                Desc = "已禁用",
                Duration = 3
            })
        end
    end
})

-- 速度值滑块（只在停止调节后显示通知）
Tabs.Movement:Slider({
    Title = "速度值",
    Desc = "设置超级速度的大小 (16-10000)",
    Value = {
        Min = 16,
        Max = 10000,
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
        walkSpeedNotify = game:GetService("RunService").Heartbeat:Connect(function()
            if tick() - notifyCooldown > NOTIFY_DELAY then
                WindUI:Notify({
                    Title = "速度值设置为: " .. lastWalkSpeed,
                    Desc = "速度值设置为: " .. lastWalkSpeed,
                    Duration = 2
                })
                walkSpeedNotify:Disconnect()
            end
        end)
        
        notifyCooldown = tick()
    end
})

local jumpToggle = Tabs.Movement:Toggle({
    Title = "超级跳跃",
    Desc = "增加跳跃高度",
    Callback = function(state)
        superJumpEnabled = state
        updateJumpPower()
        if state then
            WindUI:Notify({
                Title = "超级跳跃已启用，跳跃高度: " .. jumpPower,
                Desc = "已启用，跳跃高度: " .. jumpPower,
                Duration = 3
            })
        else
            WindUI:Notify({
                Title = "超级跳跃已禁用",
                Desc = "已禁用",
                Duration = 3
            })
        end
    end
})

-- 跳跃高度滑块（只在停止调节后显示通知）
Tabs.Movement:Slider({
    Title = "跳跃高度",
    Desc = "设置跳跃高度 (50-1000)",
    Value = {
        Min = 50,
        Max = 1000,
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
        jumpPowerNotify = game:GetService("RunService").Heartbeat:Connect(function()
            if tick() - notifyCooldown > NOTIFY_DELAY then
                WindUI:Notify({
                    Title = "跳跃高度设置为: " .. lastJumpPower,
                    Desc = "跳跃高度设置为: " .. lastJumpPower,
                    Duration = 2
                })
                jumpPowerNotify:Disconnect()
            end
        end)
        
        notifyCooldown = tick()
    end
})

local noclipToggle = Tabs.Movement:Toggle({
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
                Desc = "已禁用",
                Duration = 3
            })
        end
    end
})

Tabs.Movement:Button({
    Title = "传送到重生点",
    Desc = "将你的角色传送到重生点",
    Callback = function()
        local character = localPlayer.Character
        if character then
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                local spawns = workspace:FindFirstChild("SpawnLocation") or workspace:FindFirstChild("Spawn")
                if spawns then
                    humanoidRootPart.CFrame = spawns.CFrame + Vector3.new(0, 5, 0)
                    WindUI:Notify({
                        Title = "已传送到重生点",
                        Desc = "已传送到重生点",
                        Duration = 3
                    })
                else
                    humanoidRootPart.CFrame = CFrame.new(0, 50, 0)
                    WindUI:Notify({
                        Title = "已传送到地图中心",
                        Desc = "已传送到地图中心",
                        Duration = 3
                    })
                end
            end
        end
    end
})

local nightVisionToggle = Tabs.Movement:Toggle({
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

local infiniteJumpToggle = Tabs.Movement:Toggle({
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

local universalEspToggle = Tabs.Movement:Button({
    Title = "通用ESP",
    Desc = "启用通用ESP功能，显示玩家位置",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Lucasfin000/SpaceHub/main/UESP'))()
        WindUI:Notify({
            Title = "通用ESP已启用",
            Desc = "通用ESP功能已激活",
            Duration = 3
        })
    end
})
local suicideButton = Tabs.Movement:Button({
    Title = "无敌",
    Desc = "角色生命设置为999999999999",
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.Health = 999999999999
        WindUI:Notify({
            Title = "无敌执行",
            Desc = "角色生命值已9999999999999",
            Duration = 3
        })
    end
})
-- 自杀功能
local suicideButton = Tabs.Movement:Button({
    Title = "自杀",
    Desc = "立即结束当前角色生命",
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.Health = 0
        WindUI:Notify({
            Title = "自杀执行",
            Desc = "角色生命值已归零",
            Duration = 3
        })
    end
})

-- 反挂机功能
local antiAfkButton = Tabs.Movement:Button({
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
    
    -- 如果飞行是开启状态，重新启用飞行
    if flyEnabled then
        disableFlight() -- 先清理可能存在的旧状态
        task.wait(0.5)
        enableFlight()
    end
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

-- 输入处理（WASD控制飞行）
UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and flyEnabled then
        if input.KeyCode == Enum.KeyCode.W then
            ctrl.f = 1
        elseif input.KeyCode == Enum.KeyCode.S then
            ctrl.b = 1
        elseif input.KeyCode == Enum.KeyCode.A then
            ctrl.l = 1
        elseif input.KeyCode == Enum.KeyCode.D then
            ctrl.r = 1
        end
    end
end)

UserInputService.InputEnded:Connect(function(input, processed)
    if not processed and flyEnabled then
        if input.KeyCode == Enum.KeyCode.W then
            ctrl.f = 0
        elseif input.KeyCode == Enum.KeyCode.S then
            ctrl.b = 0
        elseif input.KeyCode == Enum.KeyCode.A then
            ctrl.l = 0
        elseif input.KeyCode == Enum.KeyCode.D then
            ctrl.r = 0
        end
    end
end)

-- 初始化完成提示
WindUI:Notify({
    Title = "系统加载完成",
    Desc = "移动增强功能已就绪！设备: " .. (isMobile and "手机" or "电脑"),
    Duration = 5
})

-- 清理连接
game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(char)
    wait(0.7)
    if bg then bg:Destroy() bg = nil end
    if bv then bv:Destroy() bv = nil end
    flyEnabled = false
    nowe = false
end)
