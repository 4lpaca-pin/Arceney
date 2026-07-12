--[[
	Drawing library
]]

local Core = (gethui and gethui()) or game:FindFirstChild("CoreGui") or game:GetService('Players').LocalPlayer.PlayerGui;
local DrawingBase = Instance.new('ScreenGui');
local enc = game:GetService('EncodingService');

local camera = workspace.CurrentCamera;
local cache = {};

if isfolder and makefolder then
	if not isfolder("drawing") then
		makefolder("drawing");
	end;
end;

DrawingBase.IgnoreGuiInset = true;
DrawingBase.ZIndexBehavior = Enum.ZIndexBehavior.Global;
DrawingBase.Parent = Core;

local cache_custom = {}
local dw = {
	Fonts = {
		UI = Enum.Font.SourceSans,
		System = Enum.Font.Arial,
		Bodoni = Enum.Font.Bodoni,
		Gotham = Enum.Font.Gotham,
		GothamBold = Enum.Font.GothamBold,
		GothamMedium = Enum.Font.GothamMedium,
		Highway = Enum.Font.Highway,
	}	
};

local getfiletype = function(ds)
	local b1, b2, b3, b4 = string.byte(ds, 1, 4)
	
	if b1 == 137 and b2 == 80 and b3 == 78 and b4 == 71 then
		return "PNG"
	elseif b1 == 255 and b2 == 216 and b3 == 255 then
		return "JPEG"
	elseif b1 == 71 and b2 == 73 and b3 == 70 then
		return "GIF"
	end;
end;

dw.items = {
	Line = function()
		local line = Instance.new('Frame',DrawingBase);
		local l,r = Vector2.zero,Vector2.zero;
		local tk = 2;

		local ca_index = #cache + 1;
		cache[ca_index] = line;

		line.Visible = false;
		line.AnchorPoint = Vector2.new(0.5, 0.5)
		line.BorderSizePixel = 0;

		local load = function()
			local delta = r - l;
			local dist = delta.Magnitude;
			local angle = math.deg(math.atan2(delta.Y, delta.X));
			local ct = (l + r) / 2;

			line.Position = UDim2.new(0, ct.X, 0, ct.Y);
			line.Size = UDim2.new(0, tk, 0, dist);
			line.Rotation = angle + 90;
		end;

		local delete = function()
			table.remove(cache,ca_index)
			line:Destroy();
		end;

		local meta = setmetatable({},{
			__newindex = function(_,i,v)
				if i == "Thickness" then
					tk = v;
					line.Size = UDim2.fromOffset(tk or v , line.AbsoluteSize.Y);
				elseif i == "From" then
					l = v;
					load()
				elseif i == "To" then
					r = v;
					load()
				elseif i == "Visible" then
					line.Visible = v;
				elseif i == "Transparency" then
					line.Transparency = 1 - v;
				elseif i == "Color" then
					line.BackgroundColor3 = v;
				end;
			end,
			__index = function(_,v)
				if v=="Destroy" then
					return delete
				end;
			end,
		});

		return meta;
	end,
	Text = function()
		local text = Instance.new('TextLabel');
		text.Text = "";
		text.Visible = false;
		text.Parent = DrawingBase;

		local ca_index = #cache + 1;
		cache[ca_index] = text;

		local delete = function()
			table.remove(cache,ca_index)
			text:Destroy();
		end;

		local meta = setmetatable({},{
			__newindex = function(_,i,v)
				if i == "Text" then
					text.Text = v;
				elseif i == "Size" then
					text.TextSize = v;
				elseif i == "Center" then

					text.TextXAlignment = (v and Enum.TextXAlignment.Center) or Enum.TextXAlignment.Left;

				elseif i == "Outline" then
					text.TextStrokeTransparency = (v and 0) or 1;
				elseif i == "OutlineColor" then
					text.TextStrokeColor3 = v;
				elseif i == "Position" then
					text.Position = UDim2.fromOffset(v.X,v.Y);
				elseif i == "TextBounds" then
					text.Size = UDim2.fromOffset(v.X,v.Y);
				elseif i == "Font" then
					text.Font = v;
				elseif i == "Color" then
					text.TextColor3 = v;
				elseif i == "Transparency" then
					text.Transparency = 1 - v;
				elseif i == "Visible" then
					text.Visible = v;
				end;
			end,
			__index = function(_,v)
				if v=="Destroy" then
					return delete
				end;
			end,
		});

		return meta;
	end,
	Image = function()
		local ImageLabel = Instance.new('ImageLabel');
		ImageLabel.Image = "";
		ImageLabel.Visible = false;
		ImageLabel.Parent = DrawingBase;
		ImageLabel.BorderSizePixel = 0;

		local ca_index = #cache + 1;
		cache[ca_index] = ImageLabel;

		local delete = function()
			table.remove(cache,ca_index)
			ImageLabel:Destroy();
		end;

		local meta = setmetatable({},{
			__newindex = function(_,i,v)
				if i == "Data" then
					local data = string.sub(v,1,4);
					
					if data ~= "rbxa" and #v > 32 then
						if isfile and writefile and getcustomasset then
							local file_name = enc:ComputeStringHash(v , Enum.HashAlgorithm.Md5);
							local f_type = getfiletype(v) or "PNG"
							local path = "drawing/"..file_name..'.'..string.lower(f_type);
							
							if not isfile(path) then
								writefile(path,v);
								cache_custom[path] = getcustomasset(path);
							else
								cache_custom[path] = cache_custom[path] or getcustomasset(path);
								ImageLabel.Image = cache_custom[path];
							end;
						end;
					else
						ImageLabel.Image = v;
					end;
				elseif i == "Size" then
					ImageLabel.Size = UDim2.fromOffset(v.X,v.Y);
				elseif i == "Position" then
					ImageLabel.Position = UDim2.fromOffset(v.X,v.Y);
				elseif i == "Transparency" then
					ImageLabel.ImageTransparency = 1 - v;
				elseif i == "Visible" then
					ImageLabel.Visible = v;
				end;
			end,
			__index = function(_,v)
				if v=="Destroy" then
					return delete
				end;
			end,
		});

		return meta;
	end,
	Circle = function()
		local Frame = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		
		Frame.Visible = false;
		Frame.Parent = DrawingBase
		Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Frame.BackgroundTransparency = 1.000
		Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Frame.BorderSizePixel = 0
		Frame.Position = UDim2.new(0.27897352, 0, 0.508838356, 0)
		Frame.Size = UDim2.new(0, 100, 0, 100)

		UICorner.CornerRadius = UDim.new(1, 0)
		UICorner.Parent = Frame

		UIStroke.Parent = Frame
		UIStroke.Transparency = 1;
		
		local ca_index = #cache + 1;
		cache[ca_index] = Frame;

		local delete = function()
			table.remove(cache,ca_index)
			Frame:Destroy();
		end;
		
		local filled = false;
		local meta = setmetatable({},{
			__newindex = function(_,i,v)
				if i == "Thickness" then
					UIStroke.Thickness = v;
				elseif i == "Radius" then
					Frame.Size = UDim2.fromOffset(v,v);
				elseif i == "Filled" then
					filled = v;
					Frame.BackgroundTransparency = (filled and UIStroke.Transparency) or 1;
				elseif i == "Color" then
					UIStroke.Color = v;
					Frame.BackgroundColor3 = v;
				elseif i == "Position" then
					Frame.Position = UDim2.fromOffset(v.X,v.Y);
				elseif i == "Transparency" then
					UIStroke.Transparency = 1 - v;
					Frame.BackgroundTransparency = (filled and UIStroke.Transparency) or 1;
				elseif i == "Visible" then
					Frame.Visible = v;
				end;
			end,
			__index = function(_,v)
				if v == "Destroy" then
					return delete
				end;
			end,
		});

		return meta;
	end,
	Square = function()
		local frame = Instance.new('Frame');
		
		frame.Parent = DrawingBase
		frame.Visible = false;
		frame.BackgroundTransparency = 1;
		
		local fil = Instance.new('UIStroke',frame);
		
		local ca_index = #cache + 1;
		cache[ca_index] = frame;

		local delete = function()
			table.remove(cache,ca_index)
			frame:Destroy();
		end;

		local filled = false;
		local meta = setmetatable({},{
			__newindex = function(_,i,v)
				if i == "Size" then
					frame.Size = UDim2.fromOffset(v.X,v.Y);
				elseif i == "Thickness" then
					fil.Thickness = v;
				elseif i == "Color" then
					fil.Color = v;
					frame.BackgroundColor3 = v;
				elseif i == "Filled" then
					filled = v;
					frame.BackgroundTransparency = (filled and fil.Transparency) or 1;
				elseif i == "Position" then
					frame.Position = UDim2.fromOffset(v.X,v.Y);
				elseif i == "Transparency" then
					fil.Transparency = 1 - v;
					frame.BackgroundTransparency = (filled and fil.Transparency) or 1;
				elseif i == "Visible" then
					frame.Visible = v;
				end;
			end,
			__index = function(_,v)
				if v == "Destroy" then
					return delete
				end;
			end,
		});

		return meta;
	end,
};


function dw.new(name)
	return dw.items[name]();
end;

function dw.clear()
	for i,v in next , cache do
		v:Destroy();
		table.remove(cache,i);
	end;
end;

dw.Clear = dw.clear;

(getfenv or getgenv)().Drawing = dw;
(getfenv or getgenv)().cleardrawcache = dw.clear;
(getfenv or getgenv)().clear_draw_cache = dw.clear;

return dw;
