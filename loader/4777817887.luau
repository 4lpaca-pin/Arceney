getupvalues = getupvalues or debug.getupvalues
getconstants = getconstants or debug.getconstants
getrawmetatable = getrawmetatable or debug.getrawmetatable

if not getgc then
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/4lpaca-pin/Arceney/refs/heads/main/modules/fatal-error.luau"))()
end;


local a = "https://api.luarmor.net/files/v3/loaders/490997958adf82e81ac160016a0ef119.lua"

local b = function(c)
    if not c or not c:byte() then
        return false
    end

    local d = loadstring(game:HttpGet("https://sdkapi-public.luarmor.net/library.lua"))()
    d.script_id = "490997958adf82e81ac160016a0ef119"
    local e = d.check_key(c)

    if e then
        if e.code == "KEY_VALID" then
            return true
        end
    end
end

if not script_key then
    local f = Instance.new("ScreenGui")
    local g = Instance.new("Frame")
    local h = Instance.new("UICorner")
    local i = Instance.new("UIStroke")
    local j = Instance.new("TextLabel")
    local k = Instance.new("TextLabel")
    local l = Instance.new("TextBox")
    local m = Instance.new("UIStroke")
    local n = Instance.new("UICorner")
    local o = Instance.new("TextButton")
    local c = Instance.new("UIStroke")
    local p = Instance.new("UICorner")
    local q = Instance.new("TextButton")
    local r = Instance.new("UIStroke")
    local s = Instance.new("UICorner")
    g.Parent =
        gethui and gethui() or cloneref(game:GetService("CoreGui") or game:GetService("Players").LocalPlayer.PlayerGui)
    g.AnchorPoint = Vector2.new(0.5, 0.5)
    g.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
    g.BorderColor3 = Color3.fromRGB(0, 0, 0)
    g.BorderSizePixel = 0
    g.ClipsDescendants = true
    g.Position = UDim2.new(0.5, 0, 0.5, 0)
    g.Size = UDim2.new(0, 290, 0, 75)
    g.Name = "Frame"
    h.CornerRadius = UDim.new(0, 4)
    h.Parent = g
    i.Thickness = 4.600
    i.Transparency = 0.930
    i.Parent = g
    j.Parent = g
    j.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    j.BackgroundTransparency = 1.000
    j.BorderColor3 = Color3.fromRGB(0, 0, 0)
    j.BorderSizePixel = 0
    j.Position = UDim2.new(0, 10, 0, 5)
    j.Size = UDim2.new(1, -10, 0, 25)
    j.Font = Enum.Font.GothamBold
    j.Text = "Key System"
    j.TextColor3 = Color3.fromRGB(255, 255, 255)
    j.TextSize = 14.000
    j.TextXAlignment = Enum.TextXAlignment.Left
    k.Parent = g
    k.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    k.BackgroundTransparency = 1.000
    k.BorderColor3 = Color3.fromRGB(0, 0, 0)
    k.BorderSizePixel = 0
    k.Position = UDim2.new(0, 10, 0, 10)
    k.Size = UDim2.new(1, -20, 0, 15)
    k.Font = Enum.Font.GothamBold
    k.Text = "RIVAL"
    k.TextColor3 = Color3.fromRGB(255, 255, 255)
    k.TextSize = 12.000
    k.TextTransparency = 0.500
    k.TextXAlignment = Enum.TextXAlignment.Right
    l.Parent = g
    l.AnchorPoint = Vector2.new(0, 1)
    l.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    l.BorderColor3 = Color3.fromRGB(0, 0, 0)
    l.BorderSizePixel = 0
    l.ClipsDescendants = true
    l.Position = UDim2.new(0, 10, 1, -10)
    l.Size = UDim2.new(1, -115, 0, 25)
    l.ZIndex = 4
    l.ClearTextOnFocus = false
    l.Font = Enum.Font.Gotham
    l.PlaceholderText = "License Key"
    l.Text = ""
    l.TextColor3 = Color3.fromRGB(157, 157, 157)
    l.TextSize = 12.000
    l.TextXAlignment = Enum.TextXAlignment.Left
    m.Thickness = 3.200
    m.Transparency = 0.730
    m.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    m.Parent = l
    n.CornerRadius = UDim.new(0, 1)
    n.Parent = l
    o.Name = "TextButton"
    o.Parent = g
    o.AnchorPoint = Vector2.new(1, 1)
    o.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    o.BorderColor3 = Color3.fromRGB(0, 0, 0)
    o.BorderSizePixel = 0
    o.Position = UDim2.new(1, -55, 1, -10)
    o.Size = UDim2.new(0, 40, 0, 25)
    o.ZIndex = 5
    o.Font = Enum.Font.GothamBold
    o.Text = "Load"
    o.TextColor3 = Color3.fromRGB(255, 255, 255)
    o.TextSize = 14.000
    o.TextTransparency = 0.300
    c.Thickness = 3.200
    c.Transparency = 0.730
    c.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    c.Parent = o
    p.CornerRadius = UDim.new(0, 1)
    p.Parent = o
    q.Name = "TextButton"
    q.Parent = g
    q.AnchorPoint = Vector2.new(1, 1)
    q.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    q.BorderColor3 = Color3.fromRGB(0, 0, 0)
    q.BorderSizePixel = 0
    q.Position = UDim2.new(1, -10, 1, -10)
    q.Size = UDim2.new(0, 35, 0, 25)
    q.ZIndex = 5
    q.Font = Enum.Font.GothamBold
    q.Text = "Link"
    q.TextColor3 = Color3.fromRGB(255, 255, 255)
    q.TextSize = 14.000
    q.TextTransparency = 0.300
    r.Thickness = 3.200
    r.Transparency = 0.730
    r.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    r.Parent = q
    s.CornerRadius = UDim.new(0, 1)
    s.Parent = q
    o.MouseButton1Click:Connect(
        function()
            if b(l.Text) then
                writefile("Arceney.license", l.Text)
                getgenv().script_key = l.Text
                getfenv().script_key = l.Text
                script_key = l.Text
            else
                l.Text = ""
                l.PlaceholderText = "Invalid Key"
                task.delay(
                    1,
                    function()
                        l.PlaceholderText = "License Key"
                    end
                )
            end
        end
    )
    q.MouseButton1Click:Connect(
        function()
            setclipboard("https://ads.luarmor.net/get_key?for=KNClinkvertise-NyZRHgKYOfty")
        end
    )
    pcall(
        function()
            if isfile("Arceney.license") then
                local t = readfile("Arceney.license")
                if b(t) then
                    writefile("Arceney.license", t)
                    getgenv().script_key = t
                    getfenv().script_key = t
                    script_key = t
                else
                    delfile("Arceney.license")
                end
            end
        end
    )
    repeat
        task.wait()
    until script_key
    g:Destroy()
end

loadstring(game:HttpGet(a))()
