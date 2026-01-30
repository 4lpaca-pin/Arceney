local ExternalReplace = {
	['a2b4136acfe7328bf71a79e09208f9c5'] = "4af3140e536e9af460d157d2f5edba9a", -- replace blox fruit
};

local GameClientData = {
	[994732206] = "a2b4136acfe7328bf71a79e09208f9c5", -- "Blox Frutis"
	[7671049560] = "8762b53221422e176971bae378599918", -- "The Forge"
	[6035872082] = "193a44402c272c03566192865fd844ef", -- "Rivals"
	[5750914919] = "33aed7d464e90ab9943d58f21cd24d00", -- "Fisch"
	[4777817887] = "490997958adf82e81ac160016a0ef119", -- "Blade Ball"
	[115797356] = "fa807cf60ed10c3e0e43f0acd8e7b6d5", -- "Counter Blox"
	[9363735110] = "5272dda0f4c8a44af59cf11f83ce8a5c", -- "Tsunami Brainrot"
};

cloneref = cloneref or function(s) return s; end;
clonefunction = clonefunction or function(f) return f; end;
identifyexecutor = identifyexecutor or getexecutorname or function()
	return "Seliware", 0.1;
end;
getgenv = getgenv or getfenv;
cloneref = cloneref or function(i) return i end;
getconstant = getconstant or debug.getconstant;
getconstants = getconstants or debug.getconstants;
getupvalue = getupvalue or debug.getupvalue;
getupvalues = getupvalues or debug.getupvalues;
setclipboard = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set);
request = request or http_request or (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request);
sethiddenproperty = sethiddenproperty or set_hidden_property or set_hidden_prop;
gethiddenproperty = gethiddenproperty or get_hidden_property or get_hidden_prop;
gethui = gethui or get_hidden_gui;
getcustomasset = getcustomasset or getsynasset or function(f) return "" end;
_G = _G or getgenv();
isfolder = isfolder or function() end;
makefolder = makefolder or function() end;
delfolder = delfolder or function() end;
listfiles = listfiles or function() end;
writefile = writefile or function() end;
readfile = readfile or function() end;
appendfile = appendfile or function() end;
isfile = isfile or function() end;

if Drawing then
	if setreadonly then
		setreadonly(Drawing,false);
	end;

	pcall(function()
		Drawing.clear = Drawing.clear or Drawing.Clear or cleardrawcache or cleardawcache or clear_draw_cache;
	end)
end;

if WebSocket then
	if setreadonly then
		setreadonly(WebSocket,false);
	end;

	pcall(function()
		WebSocket.Connect = (WebSocket and WebSocket.connect) or (WebSocket and WebSocket.Connect) or (WebSocket and WebSocket.New);
	end);
end;

if not isfolder("Arceney.cc") then
	makefolder("Arceney.cc");
end;

if not isfolder("Arceney-bin") then
	makefolder("Arceney-bin");
end;

if not isfolder("Arceney-Cache") then
	makefolder("Arceney-Cache");
end;

local Loader = {};

local LocalPlayer = game:GetService('Players').LocalPlayer;
local LuarmorAPI;
	
xpcall(function()
	LuarmorAPI = loadstring(game:HttpGet("https://sdkapi-public.luarmor.net/library.lua"))();
end,function()
	LuarmorAPI = {}
end)

local LicenseKeyPath = "Arceney.env";

Loader.CoreGui = (gethui and gethui()) or game:FindFirstChild('CoreGui') or LocalPlayer.PlayerGui;

if not GameClientData[game.GameId] then
	if not game:GetService('RunService'):IsStudio() then
		return LocalPlayer:Kick("Arceney\nKicked for Security Reasons");
	end;
end;

Loader.Is_Key_Valid = function(data)
	if not data or not string.byte(data) then
		return false , 'KEY_INVALID';
	end;

	local status = LuarmorAPI.check_key(data);

	if status.code == "KEY_VALID" then

		writefile(LicenseKeyPath , data);

		return data , status.code;
	end;

	return false , status.code;
end;

local IsUseExt = isfile('arceney_use_legacy') or false;

Loader.Render = function(defaulk)
	local ScreenGui = Instance.new("ScreenGui")
	local Frame = Instance.new("Frame")
	local BxDFrame = Instance.new("Frame")
	local RainbowFrame = Instance.new("Frame")
	local UIGradient = Instance.new("UIGradient")
	local UIStroke = Instance.new("UIStroke")
	local TextLabel = Instance.new("TextLabel")
	local LicenseFrame = Instance.new("Frame")
	local UIStroke_2 = Instance.new("UIStroke")
	local TextBox = Instance.new("TextBox")
	local LogInButton = Instance.new("TextButton")
	local UIStroke_3 = Instance.new("UIStroke")
	local GetKeyButton = Instance.new("TextButton")
	local UIStroke_4 = Instance.new("UIStroke")
	local UIStroke_5 = Instance.new("UIStroke")

	ScreenGui.Parent = Loader.CoreGui;
	ScreenGui.ResetOnSpawn = false
	ScreenGui.IgnoreGuiInset = true;
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global;
	
	local SwitchVersion = Instance.new("TextButton")
	local UIStroke = Instance.new("UIStroke")

	SwitchVersion.Name = "SwitchVersion"
	SwitchVersion.Parent = Frame
	SwitchVersion.AnchorPoint = Vector2.new(0.5, 0)
	SwitchVersion.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
	SwitchVersion.BorderColor3 = Color3.fromRGB(11, 11, 11)
	SwitchVersion.BorderSizePixel = 2
	SwitchVersion.Position = UDim2.new(0.5, 0, 0, 100)
	SwitchVersion.Size = UDim2.new(0, 200, 0, 30)
	SwitchVersion.ZIndex = 8
	SwitchVersion.Font = Enum.Font.Code
	SwitchVersion.Text = "Change Version: Default"
	SwitchVersion.TextColor3 = Color3.fromRGB(255, 255, 255)
	SwitchVersion.TextSize = 14.000

	UIStroke.Transparency = 0.250
	UIStroke.Color = Color3.fromRGB(59, 59, 59)
	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke.Parent = SwitchVersion
	
	SwitchVersion.MouseButton1Click:Connect(function()
		IsUseExt = not IsUseExt;
		
		if IsUseExt then
			SwitchVersion.Text = "Change Version: Legacy"
		else
			SwitchVersion.Text = "Change Version: Default"
		end;
	end);

	if IsUseExt then
		SwitchVersion.Text = "Change Version: Legacy"
	else
		SwitchVersion.Text = "Change Version: Default"
	end;
	
	Frame.Parent = ScreenGui
	Frame.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	Frame.BorderColor3 = Color3.fromRGB(25, 25, 25)
	Frame.BorderSizePixel = 3
	Frame.ClipsDescendants = true
	Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
	Frame.Size = UDim2.new(0, 400, 0, 285)

	BxDFrame.Name = "\0"
	BxDFrame.Parent = Frame
	BxDFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	BxDFrame.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
	BxDFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BxDFrame.BorderSizePixel = 0
	BxDFrame.ClipsDescendants = true
	BxDFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	BxDFrame.Size = UDim2.new(1, -10, 1, -10)
	BxDFrame.ZIndex = 3

	RainbowFrame.Name = "\0"
	RainbowFrame.Parent = BxDFrame
	RainbowFrame.AnchorPoint = Vector2.new(0.5, 0)
	RainbowFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	RainbowFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	RainbowFrame.BorderSizePixel = 0
	RainbowFrame.Position = UDim2.new(0.5, 0, 0, 0)
	RainbowFrame.Size = UDim2.new(1.5, 0, 0, 2)
	RainbowFrame.ZIndex = 4

	UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.10, Color3.fromRGB(255, 153, 0)), ColorSequenceKeypoint.new(0.20, Color3.fromRGB(203, 255, 0)), ColorSequenceKeypoint.new(0.30, Color3.fromRGB(50, 255, 0)), ColorSequenceKeypoint.new(0.40, Color3.fromRGB(0, 255, 102)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 101, 255)), ColorSequenceKeypoint.new(0.70, Color3.fromRGB(50, 0, 255)), ColorSequenceKeypoint.new(0.80, Color3.fromRGB(204, 0, 255)), ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 0, 153)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))}
	UIGradient.Rotation = -180
	UIGradient.Parent = RainbowFrame

	UIStroke.Color = Color3.fromRGB(59, 59, 59)
	UIStroke.Parent = BxDFrame

	TextLabel.Parent = BxDFrame
	TextLabel.AnchorPoint = Vector2.new(0, 1)
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.BackgroundTransparency = 1.000
	TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel.BorderSizePixel = 0
	TextLabel.Position = UDim2.new(0, 5, 1, -5)
	TextLabel.Size = UDim2.new(0, 200, 0, 12)
	TextLabel.ZIndex = 4
	TextLabel.Font = Enum.Font.Code
	TextLabel.Text = "You must be logged-in to access the script."
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.TextSize = 12.000
	TextLabel.TextTransparency = 0.675
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left

	LicenseFrame.Name = "\0"
	LicenseFrame.Parent = BxDFrame
	LicenseFrame.AnchorPoint = Vector2.new(0.5, 0)
	LicenseFrame.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
	LicenseFrame.BorderColor3 = Color3.fromRGB(11, 11, 11)
	LicenseFrame.BorderSizePixel = 2
	LicenseFrame.ClipsDescendants = true
	LicenseFrame.Position = UDim2.new(0.5, 0, 0, 55)
	LicenseFrame.Size = UDim2.new(0, 200, 0, 30)
	LicenseFrame.ZIndex = 5

	UIStroke_2.Transparency = 0.500
	UIStroke_2.Color = Color3.fromRGB(59, 59, 59)
	UIStroke_2.Parent = LicenseFrame

	TextBox.Parent = LicenseFrame
	TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
	TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextBox.BackgroundTransparency = 1.000
	TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextBox.BorderSizePixel = 0
	TextBox.Position = UDim2.new(0.5, 0, 0.5, 0)
	TextBox.Size = UDim2.new(1, -10, 1, -5)
	TextBox.ZIndex = 6
	TextBox.ClearTextOnFocus = false
	TextBox.Font = Enum.Font.Code
	TextBox.PlaceholderColor3 = Color3.fromRGB(102, 102, 102)
	TextBox.PlaceholderText = "License Key"
	TextBox.Text = (defaulk and tostring(defaulk)) or ""
	TextBox.TextColor3 = Color3.fromRGB(213, 213, 213)
	TextBox.TextSize = 13.000
	TextBox.TextStrokeTransparency = 0.300
	TextBox.TextXAlignment = Enum.TextXAlignment.Left

	LogInButton.Name = "\0"
	LogInButton.Parent = BxDFrame
	LogInButton.AnchorPoint = Vector2.new(0.5, 0)
	LogInButton.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
	LogInButton.BorderColor3 = Color3.fromRGB(11, 11, 11)
	LogInButton.BorderSizePixel = 2
	LogInButton.Position = UDim2.new(0.5, 0, 0, 135)
	LogInButton.Size = UDim2.new(0, 200, 0, 30)
	LogInButton.ZIndex = 8
	LogInButton.Font = Enum.Font.Code
	LogInButton.Text = "Login"
	LogInButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	LogInButton.TextSize = 14.000

	UIStroke_3.Transparency = 0.250
	UIStroke_3.Color = Color3.fromRGB(59, 59, 59)
	UIStroke_3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke_3.Parent = LogInButton

	GetKeyButton.Name = "\0"
	GetKeyButton.Parent = BxDFrame
	GetKeyButton.AnchorPoint = Vector2.new(0.5, 0)
	GetKeyButton.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
	GetKeyButton.BorderColor3 = Color3.fromRGB(11, 11, 11)
	GetKeyButton.BorderSizePixel = 2
	GetKeyButton.Position = UDim2.new(0.5, 0, 0, 180)
	GetKeyButton.Size = UDim2.new(0, 200, 0, 30)
	GetKeyButton.ZIndex = 8
	GetKeyButton.Font = Enum.Font.Code
	GetKeyButton.Text = "Get Key"
	GetKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	GetKeyButton.TextSize = 14.000

	UIStroke_4.Transparency = 0.250
	UIStroke_4.Color = Color3.fromRGB(59, 59, 59)
	UIStroke_4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStroke_4.Parent = GetKeyButton

	UIStroke_5.Color = Color3.fromRGB(59, 59, 59)
	UIStroke_5.Parent = Frame

	GetKeyButton.MouseButton1Click:Connect(function()
		setclipboard("https://arceney.win/#plans");
	end);

	local Await = Instance.new('BindableEvent',ScreenGui);
	local RateLimit = false;

	LogInButton.MouseButton1Click:Connect(function()
		if RateLimit then
			return;
		end

		RateLimit = true

		local fixer = TextBox.Text:gsub(' ','');
		local correct = Loader.Is_Key_Valid(fixer);

		if correct then
			return Await:Fire(fixer);
		end;

		TextBox.Text = "";

		RateLimit = false;
	end);

	local c = Await.Event:Wait();

	ScreenGui:Destroy();

	return c;
end;

local is_external = function()
	if debug.info(writefile,'s') ~= '[C]' or debug.info(readfile,'s') ~= '[C]' or debug.info(isfile,'s') ~= '[C]' then
		return true;
	end;

	if not hookmetamethod then
		return true;
	end;
end;

local ProcessLoad = function(key)
	local Id = GameClientData[game.GameId];

	if IsUseExt and ExternalReplace[Id] then
		writefile("arceney_use_legacy",'true');
		
		Id = ExternalReplace[Id];
		LuarmorAPI.script_id = Id;
	else
		if identifyexecutor() == "Xeno" then
			return game:GetService('Players').LocalPlayer:Kick("Sorry!\nXeno is out of support.\nplease use solara or other executor in weao.gg");
		end;

		if isfile("arceney_use_legacy") then
			delfile("arceney_use_legacy");
		end;
	end;

	local LoaderCode = string.format("https://api.luarmor.net/files/v3/loaders/%s.lua",Id);

	getgenv().script_key = key;
	getfenv().script_key = key;
	script_key = key;

	return loadstring(game:HttpGet(LoaderCode))();
end;

LuarmorAPI.script_id = tostring(GameClientData[game.GameId]);

script_key = script_key or (isfile(LicenseKeyPath) and readfile(LicenseKeyPath)) or (isfile("Arceney.license") and readfile("Arceney.license"));

if script_key and Loader.Is_Key_Valid(tostring(script_key)) and not isfile("arceney_use_legacy") then
	ProcessLoad(script_key);
else
	local license = Loader.Render(script_key);

	ProcessLoad(license);
end;
