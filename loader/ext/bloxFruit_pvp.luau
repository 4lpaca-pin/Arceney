local loader = loadstring(game:HttpGet("https://raw.githubusercontent.com/4lpaca-pin/Arceney/refs/heads/main/modules/loader.luau"))();
local url = "https://api.luarmor.net/files/v3/loaders/52a5578586189b55026b4148722aac71.lua";

if not script_key then
    loader:Auth({
        OnGetKey = function()
            (setclipboard or toclipboard)("https://ads.luarmor.net/get_key?for=KNClinkvertise-NyZRHgKYOfty");
        end;
        OnLogIn = function(key,cls)
            task.spawn(function()
                script_key = key;
                getfenv().script_key = key;
                getgenv().script_key = key;
                loadstring(game:HttpGet(url))(key);
            end);
    
            task.wait(0.25);
    
            return true;
        end;
    });
else
    loadstring(game:HttpGet(url))(script_key);
end;

