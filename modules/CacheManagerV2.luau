--[[
			Arceney.cc
	Url Cache Manager by 4lpaca.lol
]]

getgenv = getgenv or getfenv;

local GetHash = function(str: string)
	local hex = #str;
	
	string.gsub(str,'.',function(byte)
		hex += byte:byte() + #str;
	end);
	
	return tostring(math.round(hex + 15));
end;

local lib = {
	directory = "Arceney-Cache",
};

function lib.init()
	if not isfolder(lib.directory) then
		makefolder(lib.directory);
	end;
end;

local fetch = function(url: string)
	local x,p = pcall(function()
		return game:HttpGet(url);
	end);
	
	if x then
		return p;
	end;
	
	task.wait(1)
	
	return "-- Failed to fetch\nlocal LuaContent = \""..GetHash(tostring(math.random())..tostring(math.random())..tostring(math.random())).."\";"
end;

function lib.get_url(url: string, cache_time: number)
	local path = lib.directory.."/".."URL-"..GetHash(url).."_cache";
	local timerequest = tick();
	
	local onload = function()
		local content = fetch(url);
		
		if not isfolder(path) then
			makefolder(path);
		end;
		
		local config = {
			cache_time = tick(),
			duration = cache_time
		};
		
		writefile(path.."/config.json" , game:GetService('HttpService'):JSONEncode(config));
		writefile(path.."/source.txt" , content);
		
		return content;
	end;
	
	if isfolder(path) and isfile(path.."/config.json") and isfile(path.."/source.txt") and readfile(path.."/config.json") and readfile(path.."/source.txt") then
		local cfg = game:GetService('HttpService'):JSONDecode(readfile(path.."/config.json"));
		local source = readfile(path.."/source.txt");
		
		if (tick() - cfg.cache_time) > cfg.duration then
			return onload() , "false" , (tick() - timerequest);
		else
			return source , "true" , (tick() - timerequest);
		end;
	end;
	
	return onload() , "false" , (tick() - timerequest);
end;

function lib.clear_cache(url: string)
	local path = lib.directory.."/".."URL-"..GetHash(url).."_cache";
	
	if isfolder(path) then
		delfolder(path);
		return true;
	end;
	
	return false;
end;

return lib;
