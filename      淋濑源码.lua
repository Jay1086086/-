local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingyan777/roblox/refs/heads/main/main.lua"))()

local Confirmed = false

WindUI:Popup({
    Title = "XLAv1.0",
    Icon = "rbxassetid://129260712070622",
    IconThemed = true,
    Content = "欢迎使用JAYhub1.8"
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

-- 跳跃高度滑块（只在停止调节后显示通知）
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

local suicideButton = Tabs.tonyon:Button({
    Title = "飞行V3",
    Desc = "冷情汉化飞行",
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
local suicideButton = Tabs.tonyon:Button({
    Title = "自杀",
    Desc = "单机变成残渣",
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
