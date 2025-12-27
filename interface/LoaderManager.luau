--[[
        Loader Manager
    Arceney.cc by 4lpaca
]]

local loader_cache = "ARCENEY_LOADER_CACHE";

local Loader = (isfile(loader_cache) and loadstring(readfile(loader_cache))());

if not isfile(loader_cache) or not Loader then
    local src = game:HttpGet("https://raw.githubusercontent.com/4lpaca-pin/Arceney/refs/heads/main/interface/loader.luau");

    writefile(loader_cache , src);

    Loader = loadstring(src)();
end;

setupvalue = setupvalue or debug.setupvalue;
getupvalue = getupvalue or debug.getupvalue;
getupvalues = getupvalues or debug.getupvalues;
getconstants = getconstants or debug.getconstants;
getrawmetatable = getrawmetatable or debug.getrawmetatable;
getscripthash = getscripthash or get_script_hash;
getcustomasset = getcustomasset or getsynasset;
getgenv = getgenv or getfenv;

return function(MainLoader , SecondLoader , SupportedExternal)
    local LoaderWindow = Loader.new("ARCENEY.WIN","LOADER");
    local LicenseKeyCache = "Arceney.license";

    LoaderWindow:AddLabel("Initializing","Success");

    if not isfolder("Arceney.cc") then
        makefolder("Arceney.cc");

        LoaderWindow:AddLabel("Created Directory \"Arceney.cc\"","Success");
    end;

    if not isfolder("Arceney-bin") then
        makefolder("Arceney-bin");

        LoaderWindow:AddLabel("Created Directory \"Arceney-bin\"","Success");
    end;

    if not isfolder("Arceney-Cache") then
        makefolder("Arceney-Cache");

        LoaderWindow:AddLabel("Created Directory \"Arceney-Cache\"","Success");
    end;

    local InternalTest = function()
    
        local result,out = pcall(function()
            return debug.info(getgc or checkcaller or clonefunction or newcclosure or hookfunction or writefile , 's') == "[C]"
        end);

        if result then
            return out;
        end;    

        return false;
    end;

    task.wait(1);

    local IsInternal = InternalTest();

    if IsInternal then
        LoaderWindow:AddLabel("Internal","Success");
    else
        LoaderWindow:AddLabel("External","Warning");

        if not SecondLoader and not SupportedExternal then
            task.wait();

            LoaderWindow:AddLabel("Unsupported Executor","Warning");

            task.delay(3, function()
                LoaderWindow:Close();
            end);

            return false;
        end;
    end;

    task.wait(1);

    local sdk_api = loadstring(game:HttpGet("https://sdkapi-public.luarmor.net/library.lua"))();
    local LoaderLink = (IsInternal and MainLoader) or SecondLoader;
    local ScriptId = string.match(LoaderLink, "https://api.luarmor.net/files/v3/loaders/(%w+).lua");

    sdk_api.script_id = ScriptId;

    local CheckKey = function(LicenseKey)
        if not LicenseKey:byte() then
            task.wait()

            return false;
        end;

        local test , message = pcall(sdk_api.check_key , tostring(LicenseKey));

        if test then
            
            if message.code == "KEY_VALID" then
                pcall(function()
                    LoaderWindow:WLWarning("Success","CONNECTING TO SERVER");
                end);

                return true;
            elseif message.code == "KEY_EXPIRED" then
                pcall(function()
                    LoaderWindow:WLWarning("Warning","License Key has expired.");
                end);
            elseif message.code == "KEY_BANNED" then
                pcall(function()
                    LoaderWindow:WLWarning("Error","You're banned");
                end);
            elseif message.code == "KEY_HWID_LOCKED" then
                pcall(function()
                    LoaderWindow:WLWarning("Error","Invalid Hardware ID");
                end);
            elseif message.code == "KEY_INCORRECT" then
                pcall(function()
                    LoaderWindow:WLWarning("Error","Incorrect key. click get key below");
                end);
            elseif message.code == "KEY_INVALID" then
                pcall(function()
                    LoaderWindow:WLWarning("Error","Invalid License Key");
                end);
            end;

            return false;
        end;

        LoaderWindow:WLWarning("Error","AN ERROR: "..tostring(message.code));

        return false;
    end;

    local LoadKeySystem = function()
        if _G.NoKeySystem then
                return
        end;
        local RateLimit = false;

        LoaderWindow:AddLabel("Key System","Success");

        LoaderWindow:Whitelist({
            {
                Text = "Get Key",
                Callback = function()
                    (setclipboard or toclipboard)("https://arceney.cc/key")
                end,
            },
            {
                Text = "Log-In",
                Callback = function(LicenseKey)
                    if RateLimit then
                        return;
                    end;

                    RateLimit = true;

                    if CheckKey(tostring(LicenseKey)) then
                        getgenv().script_key = tostring(LicenseKey);
                        getfenv().script_key = tostring(LicenseKey);

                        script_key = LicenseKey;

                        writefile(LicenseKeyCache , LicenseKey);

                        task.wait(0.5);

                        return LoaderWindow:CloseWhitelist();
                    end;

                    RateLimit = false;

                    return false;
                end,
            }
        });

        task.wait(0.1);
    end;

    if not script_key then
        if isfile(LicenseKeyCache) then
            local Key = readfile(LicenseKeyCache);

            LoaderWindow:AddLabel("Checking Key ...","Success");

            if CheckKey(tostring(Key)) then
                getgenv().script_key = tostring(Key);
                getfenv().script_key = tostring(Key);

                LoaderWindow:AddLabel("Whitelist!","Success");
            else
                LoadKeySystem();
            end;
        else
            LoadKeySystem();
        end;
    else
        LoaderWindow:AddLabel("Checking Key ...","Success");

        task.wait(0.1);

        if not CheckKey(tostring(script_key)) then
            LoaderWindow:AddLabel("Invalid Key","Error");
            
            LoadKeySystem();
        else
            LoaderWindow:AddLabel("Whitelist!","Success");
        end;
    end;

    task.wait(0.5);

    LoaderWindow:AddLabel("Loading Script ...","Success");

    task.delay(1.5,LoaderWindow.Close);

    loadstring(game:HttpGet(LoaderLink))({
        script_key = getgenv().script_key
    });

    return true;
end;
