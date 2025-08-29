local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

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
    Title = "JAYhub",
    IconThemed = true,
    Content = "1.8" .. gradient("版本", Color3.fromHex("#00FF87"), Color3.fromHex("#60EFFF")) .. "",
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

Window:EditOpenButton({
    Title = "JAYhub",
    Icon = "crown",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new(
        Color3.fromHex("FF0F7B"), 
        Color3.fromHex("F89B29")
    ),
    Draggable = true,
})

local Tabs = {}

do
    Tabs.ElementsSection = Window:Section({
        Title = "脚本",
        Opened = true,
    })
    
    Tabs.OtherSection = Window:Section({
        Title = "其它",
        Opened = true,
    })
    
    Tabs.WindowSection = Window:Section({
        Title = "窗口管理",
        Icon = "app-window-mac",
        Opened = true,
    })

    Tabs.ParagraphTab = Tabs.ElementsSection:Tab({ Title = "主页", Icon = "zap" })
    Tabs.ButtonTab = Tabs.ElementsSection:Tab({ Title = "脚本", Icon = "mouse-pointer-2", Desc = "Contains interactive buttons for various actions." })
    Tabs.FE1Tab = Tabs.ElementsSection:Tab({ Title = "FE脚本", Icon = "paintbrush", Desc = "Choose and customize colors easily." })
    Tabs.otherTab = Tabs.ElementsSection:Tab({ Title = "其它脚本中心", Icon = "toggle-left", Desc = "Switch settings on and off." })
    
    Tabs.WindowTab = Tabs.WindowSection:Tab({ 
        Title = "窗口和文件配置", 
        Icon = "settings", 
        Desc = "管理窗口设置和文件配置。", 
        ShowTabTitle = true 
    })
    Tabs.CreateThemeTab = Tabs.WindowSection:Tab({ Title = "创建主题", Icon = "palette", Desc = "设计和应用自定义主题。" })
    
    Tabs.LongTab = Tabs.OtherSection:Tab({ 
        Title = "长而空的选项卡。带有自定义图标", 
        Icon = "rbxassetid://129260712070622", 
        IconThemed = true, 
        Desc = "详细描述" 
    })
    Tabs.LockedTab = Tabs.OtherSection:Tab({ Title = "锁定选项卡", Icon = "lock", Desc = "此选项卡已锁定", Locked = true })
    Tabs.TabWithoutIcon = Tabs.OtherSection:Tab({ Title = "无图标选项卡", ShowTabTitle = true })
    Tabs.Tests = Tabs.OtherSection:Tab({ Title = "测试", Icon = "https://raw.githubusercontent.com/Footagesus/WindUI/main/docs/ui.png", ShowTabTitle = true })
    
    Tabs.LastSection = Window:Section({
        Title = "没有制表符的部分",
    })
    
    Tabs.ConfigTab = Window:Tab({ Title = "配置", Icon = "file-cog" })
end

Window:SelectTab(1)

Tabs.ParagraphTab:Paragraph({
    Title = "JAYhub",
    Desc = "Q群1049557594",
    Image = "https://i.postimg.cc/nL97SYHB/20250722-07083338.jpg",
    ImageSize = 42,
    Thumbnail = "https://i.postimg.cc/fLmB0Qp3/IMG-20250821-130711.jpg",
    ThumbnailSize = 120
})

-- 通用功能
Tabs.ButtonTab:Slider({
    Title = "跳跃设置",
    Value = {
        Min = 50,
        Max = 200,
        Default = 50,
    },
    Increment = 1,
    Callback = function(value)
        if game.Players.LocalPlayer.Character then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
        end
    end
})

Tabs.ButtonTab:Slider({
    Title = "移速设置",
    Value = {
        Min = 16,
        Max = 100,
        Default = 16,
    },
    Increment = 1,
    Callback = function(value)
        if game.Players.LocalPlayer.Character then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
        end
    end
})

Tabs.ButtonTab:Slider({
    Title = "重力设置",
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

Tabs.ButtonTab:Toggle({
    Title = "夜视",
    Value = false,
    Callback = function(state)
        if state then
            game.Lighting.Ambient = Color3.new(1, 1, 1)  
        else
            game.Lighting.Ambient = Color3.new(0, 0, 0) 
        end
    end
})

Tabs.ButtonTab:Toggle({
    Title = "穿墙",
    Value = false,
    Callback = function(state)
        if state then
            local Noclip = true
            local Stepped = game:GetService("RunService").Stepped:Connect(function()
                if Noclip then
                    local character = game.Players.LocalPlayer.Character
                    if character then
                        for _, part in pairs(character:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CanCollide = false
                            end
                        end
                    end
                else
                    Stepped:Disconnect()
                end
            end)
        else
            Noclip = false
        end
    end
})

Tabs.ButtonTab:Button({
    Title = "无限跳",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/V5PQy3y0", true))()
    end
})

Tabs.ButtonTab:Button({
    Title = "反挂机",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/9fFu43FF"))()
    end
})

Tabs.ButtonTab:Button({
    Title = "键盘",
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/RedZenXYZ/4d80bfd70ee27000660e4bfa7509c667/raw/da903c570249ab3c0c1a74f3467260972c3d87e6/KeyBoard%2520From%2520Ohio%2520Fr%2520Fr"))()
    end
})

Tabs.ButtonTab:Button({
    Title = "聊天框画画",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ocfi/_/refs/heads/main/a"))()
    end
})

-- FE脚本
Tabs.FE1Tab:Button({
    Title = "汉化dex",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingyan777/roblox/refs/heads/main/bex.lua"))()
    end
})

Tabs.FE1Tab:Button({
    Title = "TSB动作脚本",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/NotEnoughJack/socializehub/refs/heads/main/script.lua"))()
    end
})

Tabs.FE1Tab:Button({
    Title = "强行装备丢弃",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingyan777/roblox/refs/heads/main/%E5%BC%BA%E8%A1%8C%E8%A3%85%E5%A4%87%E6%88%96%E4%B8%A2%E5%BC%83%E7%89%A9%E5%93%81.txt"))()
    end
})

Tabs.FE1Tab:Button({
    Title = "心灵牵引",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E7%BF%BB%E8%AF%91.txt"))()
    end
})

Tabs.FE1Tab:Button({
    Title = "AC6放音乐",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FE-Ac6-Music-Vulnerability-25536"))()
    end
})

Tabs.FE1Tab:Button({
    Title = "VR",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/Qwerty/refs/heads/main/qwerty45.lua"))()
    end
})

Tabs.FE1Tab:Button({
    Title = "egor",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/RENZXW/RENZXW-SCRIPTS/main/fakeLAGRENZXW.txt"))()
    end
})

Tabs.FE1Tab:Button({
    Title = "燃尽脚本",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DROID-cell-sys/ANTI-UTTP-SCRIPTT/refs/heads/main/EGOR%20SCRIPT%20BY%20ANTI-UTTP"))()
    end
})

Tabs.FE1Tab:Button({
    Title = "UGC表情",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/1nJD7PkH",true))()
    end
})

Tabs.FE1Tab:Button({
    Title = "头部宠物",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/randomstring0/Qwerty/refs/heads/main/qwerty40.lua"))()
    end
})

Tabs.FE1Tab:Button({
    Title = "车",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FE-SILLY-CAR-V1-48227"))()
    end
})

Tabs.FE1Tab:Button({
    Title = "蜘蛛侠",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E8%9C%98%E8%9B%9B%E4%BE%A0.txt"))()
    end
})

Tabs.FE1Tab:Button({
    Title = "前后空翻",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E5%89%8D%E5%90%8E%E7%A9%BA%E7%BF%BB.txt"))()
    end
})

-- 其它脚本
Tabs.otherTab:Button({
    Title = "DHJB脚本卡密",
    Callback = function()
        setclipboard("wjbhd")
    end
})

Tabs.otherTab:Button({
    Title = "DHJB脚本",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/DHJB1.2.txt"))()
    end
})

Tabs.otherTab:Button({
    Title = "XA Hub",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/h8nC0fLb", true))()
    end
})

Tabs.otherTab:Button({
    Title = "退休v2",
    Callback = function()
        TX = "脚本群:160369111"
        Script = "Free永久免费"
        loadstring(game:HttpGet("https://raw.githubusercontent.com/JsYb666/TX-Free-YYDS/refs/heads/main/FREE-TX-TEAM"))()
    end
})

Tabs.otherTab:Button({
    Title = "禁漫中心",
    Callback = function()
        getgenv().LS="禁漫中心" 
        loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/ng/main/jmlllllllIIIIlllllII.lua"))()
    end
})

Tabs.otherTab:Button({
    Title = "落叶中心",
    Callback = function()
        getgenv().LS="落叶中心" 
        loadstring(game:HttpGet("https://raw.githubusercontent.com/krlpl/Deciduous-center-LS/main/%E8%90%BD%E5%8F%B6%E4%B8%AD%E5%BF%83%E6%B7%B7%E6%B7%86.txt"))()
    end
})

Tabs.otherTab:Button({
    Title = "皮脚本",
    Callback = function()
        getgenv().XiaoPi="皮脚本QQ群1002100032" 
        loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))()
    end
})

-- 窗口配置
local HttpService = game:GetService("HttpService")

local folderPath = "WindUI"
makefolder(folderPath)

local function SaveFile(fileName, data)
    local filePath = folderPath .. "/" .. fileName .. ".json"
    local jsonData = HttpService:JSONEncode(data)
    writefile(filePath, jsonData)
end

local function LoadFile(fileName)
    local filePath = folderPath .. "/" .. fileName .. ".json"
    if isfile(filePath) then
        local jsonData = readfile(filePath)
        return HttpService:JSONDecode(jsonData)
    end
end

local function ListFiles()
    local files = {}
    for _, file in ipairs(listfiles(folderPath)) do
        local fileName = file:match("([^/]+)%.json$")
        if fileName then
            table.insert(files, fileName)
        end
    end
    return files
end

Tabs.WindowTab:Section({ Title = "窗口", Icon = "app-window-mac" })

local themeValues = {}
for name, _ in pairs(WindUI:GetThemes()) do
    table.insert(themeValues, name)
end

local themeDropdown = Tabs.WindowTab:Dropdown({
    Title = "选择主题",
    Multi = false,
    AllowNone = false,
    Value = nil,
    Values = themeValues,
    Callback = function(theme)
        WindUI:SetTheme(theme)
    end
})
themeDropdown:Select(WindUI:GetCurrentTheme())

local ToggleTransparency = Tabs.WindowTab:Toggle({
    Title = "切换窗口透明度",
    Callback = function(e)
        Window:ToggleTransparency(e)
    end,
    Value = WindUI:GetTransparency()
})

Tabs.WindowTab:Section({ Title = "保存" })

local fileNameInput = ""
Tabs.WindowTab:Input({
    Title = "写入文件名",
    PlaceholderText = "Enter file name",
    Callback = function(text)
        fileNameInput = text
    end
})

Tabs.WindowTab:Button({
    Title = "保存文件",
    Callback = function()
        if fileNameInput ~= "" then
            SaveFile(fileNameInput, { Transparent = WindUI:GetTransparency(), Theme = WindUI:GetCurrentTheme() })
        end
    end
})

Tabs.WindowTab:Section({ Title = "加载" })

local filesDropdown
local files = ListFiles()

filesDropdown = Tabs.WindowTab:Dropdown({
    Title = "选择文件",
    Multi = false,
    AllowNone = true,
    Values = files,
    Callback = function(selectedFile)
        fileNameInput = selectedFile
    end
})

Tabs.WindowTab:Button({
    Title = "加载文件",
    Callback = function()
        if fileNameInput ~= "" then
            local data = LoadFile(fileNameInput)
            if data then
                WindUI:Notify({
                    Title = "文件已加载",
                    Content = "Loaded data: " .. HttpService:JSONEncode(data),
                    Duration = 5,
                })
                if data.Transparent then 
                    Window:ToggleTransparency(data.Transparent)
                    ToggleTransparency:SetValue(data.Transparent)
                end
                if data.Theme then WindUI:SetTheme(data.Theme) end
            end
        end
    end
})

Tabs.WindowTab:Button({
    Title = "覆盖文件",
    Callback = function()
        if fileNameInput ~= "" then
            SaveFile(fileNameInput, { Transparent = WindUI:GetTransparency(), Theme = WindUI:GetCurrentTheme() })
        end
    end
})

Tabs.WindowTab:Button({
    Title = "刷新列表",
    Callback = function()
        filesDropdown:Refresh(ListFiles())
    end
})

local currentThemeName = WindUI:GetCurrentTheme()
local themes = WindUI:GetThemes()

local ThemeAccent = themes[currentThemeName].Accent
local ThemeOutline = themes[currentThemeName].Outline
local ThemeText = themes[currentThemeName].Text
local ThemePlaceholderText = themes[currentThemeName].Placeholder

function updateTheme()
    WindUI:AddTheme({
        Name = currentThemeName,
        Accent = ThemeAccent,
        Outline = ThemeOutline,
        Text = ThemeText,
        Placeholder = ThemePlaceholderText
    })
    WindUI:SetTheme(currentThemeName)
end

local CreateInput = Tabs.CreateThemeTab:Input({
    Title = "主题名称",
    Value = currentThemeName,
    Callback = function(name)
        currentThemeName = name
    end
})

Tabs.CreateThemeTab:Colorpicker({
    Title = "背景颜色",
    Default = Color3.fromHex(ThemeAccent),
    Callback = function(color)
        ThemeAccent = color:ToHex()
    end
})

Tabs.CreateThemeTab:Colorpicker({
    Title = "轮廓颜色",
    Default = Color3.fromHex(ThemeOutline),
    Callback = function(color)
        ThemeOutline = color:ToHex()
    end
})

Tabs.CreateThemeTab:Colorpicker({
    Title = "文本颜色",
    Default = Color3.fromHex(ThemeText),
    Callback = function(color)
        ThemeText = color:ToHex()
    end
})

Tabs.CreateThemeTab:Colorpicker({
    Title = "占位符文本颜色",
    Default = Color3.fromHex(ThemePlaceholderText),
    Callback = function(color)
        ThemePlaceholderText = color:ToHex()
    end
})

Tabs.CreateThemeTab:Button({
    Title = "更新主题",
    Callback = function()
        updateTheme()
    end
})

Window:OnClose(function()
    print("UI closed.")
end)
