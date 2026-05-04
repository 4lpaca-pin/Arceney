--[[
            DX9WARE | LUA
    Author: 4lpaca (2lpa)
    Game: The Mimic
    Info: 
        Book 1 = Universal
        Book 2 / other = just read and select in the ui
]]

dx9.ShowConsole(true);

local DataModel = dx9.GetDatamodel();
local ReplicatedStorage = dx9.FindFirstChild(DataModel, 'ReplicatedStorage');
local Workspace = dx9.FindFirstChild(DataModel, 'Workspace');

local Lib = loadstring(dx9.Get("https://raw.githubusercontent.com/soupg/DXLibUI/main/main.lua?h=1"))()

local Window = Lib:CreateWindow({
    Title = "4lpaca.lua | DX9WARE",
    Index = "window_1",
    Size = {0,0},
    Resizable = true,
    ToggleKey = "[F5]",
    StartLocation = {300, 300},
})

local CheatTab = Window:AddTab("Cheat");

local Visuals = CheatTab:AddMiddleGroupbox("Settings")

local db_selte = {
    "Nightmare Circus",
    "Universal",
    "Book 2 Chapter 1"
};

Visuals:AddLabel("Made by 4lpaca.lol", {255,255,255});

local enable = Visuals:AddToggle({
    Index = "tool",
    Default = _G.Cheat_Enabled,
    Text = "Enabled"
})

local Dropdown = Visuals:AddDropdown({
    Index = "dropdown2",
    Text = "Current Game:",
    Default = 1,
    Values = db_selte
});

Visuals:AddLabel("Warning please enter a valid current game", {255,255,255});

enable:OnChanged(function(value)
    _G.Cheat_Enabled = value;
end)

_G.Cheat_Enabled = _G.Cheat_Enabled or false;
_G.GameModeSettings = _G.GameModeSettings or "Universal";

Dropdown:OnChanged(function(value)
    _G.GameModeSettings = value;
end)

if Lib.FirstRun then
    CheatTab:Focus()
end

local UniversalESP = function()
    local GameAI = dx9.FindFirstChild(Workspace , "GameAI");

    if GameAI ~= 0 then -- book 1 only

        for i,v in next , dx9.GetChildren(GameAI) do
            local humanoidrootpart = dx9.FindFirstChild(v,'HumanoidRootPart');

            if humanoidrootpart ~= 0 then
                local position = dx9.GetPosition(humanoidrootpart);
                local tows = dx9.WorldToScreen({position.x,position.y,position.z});

                dx9.DrawBox( {tows.x - 10, tows.y - 15} , {tows.x + 10, tows.y + 15} , {255,255,255});

                dx9.DrawString({tows.x + 10 , tows.y - 15} , {255,5,5},"[ "..tostring(dx9.GetName(v)).." ]");
            end;
        end;

    end

    -- other folder for b1
    local GameAI2 = dx9.FindFirstChild(Workspace , "GameAI2");

    if GameAI2 ~= 0 then -- book 1 only
        for i,v in next , dx9.GetChildren(GameAI2) do
            if dx9.GetType(v) == "Model" then
                local humanoidrootpart = dx9.FindFirstChild(v,'HumanoidRootPart');

                if humanoidrootpart ~= 0 then
                    local position = dx9.GetPosition(humanoidrootpart);
                    local tows = dx9.WorldToScreen({position.x,position.y,position.z});

                    dx9.DrawBox( {tows.x - 10, tows.y - 15} , {tows.x + 10, tows.y + 15} , {255,5,5});

                    dx9.DrawString({tows.x + 10 , tows.y - 15} , {255,5,5},"[ "..tostring(dx9.GetName(v)).." ]");
                end;
            end;
        end;
    end;
end;

local ProcessMonsterFolder = function(folder)
    for _ , monster in next , dx9.GetChildren(folder) do 
        if dx9.GetType(monster) == "Model" then
            local humanoidrootpart = dx9.FindFirstChild(monster,'HumanoidRootPart');

            if humanoidrootpart ~= 0 then
                local position = dx9.GetPosition(humanoidrootpart);
                local tows = dx9.WorldToScreen({position.x,position.y,position.z});

                dx9.DrawBox( {tows.x - 10, tows.y - 15} , {tows.x + 10, tows.y + 15} , {255,255,255});

                dx9.DrawString({tows.x + 10 , tows.y - 15} , {255,5,5},"[ "..tostring(dx9.GetName(monster)).." ]");
            end;    
        end;
    end;
end;


local NightmareCircus = function()
    local Section1 = dx9.FindFirstChild(Workspace , "Section1");

    if Section1 ~= 0 then -- book 2 / gamemode
        local MonsterFolder = dx9.FindFirstChild(Section1 , "Monster");

        if MonsterFolder ~= 0 then
            
            ProcessMonsterFolder(MonsterFolder);
        end;



        -- ESP Objective for NMC;

        local ObjFolder = dx9.FindFirstChild(Section1 , "Objective");

        if ObjFolder ~= 0 then

            for _ , jackbox in next , dx9.GetChildren(ObjFolder) do 
                if dx9.GetType(jackbox) == "Model" then
                    local rootpart = dx9.FindFirstChild(jackbox,'RootPart');

                    if rootpart ~= 0 then
                        local position = dx9.GetPosition(rootpart);
                        local tows = dx9.WorldToScreen({position.x,position.y,position.z});

                        local name = "[ Jackbox ]";

                        dx9.DrawString({tows.x - (dx9.CalcTextWidth(name) / 2) , tows.y} , {255,255,255},name);
                    end;
                end;
            end;

        end;
    end;

    local Section2 = dx9.FindFirstChild(Workspace , "Section2");

    if Section2 ~= 0 then
        local MonsterFolder = dx9.FindFirstChild(Section2 , "Monsters");
        
        local Objective = dx9.FindFirstChild(Section2 , "Objective");

        if MonsterFolder ~= 0 then
            
            ProcessMonsterFolder(MonsterFolder);
        end;

        if Objective ~= 0 then
            local Cards = dx9.FindFirstChild(Objective , "Cards");

            if Cards ~= 0 then
                
                for i,v in next , dx9.GetChildren(Cards) do
                    local card = dx9.FindFirstChild(v,'card');

                    if card ~= 0 then
                        local position = dx9.GetPosition(card);
                        local tows = dx9.WorldToScreen({position.x,position.y,position.z});
                        local name = "[ CARD ]";

                        dx9.DrawBox( {tows.x - 5, tows.y - 5} , {tows.x + 5, tows.y + 5} , {255,255,255});

                        dx9.DrawString({tows.x - (dx9.CalcTextWidth(name) / 2) , tows.y} , {255,255,255},name);
                    end;
                end;
            end;
        end;
    end;
end;

local Loadss1 = function()
    local GetSection1Folder , section7 , last_game;

    for i,v in next , dx9.GetChildren(Workspace) do
        if dx9.GetType(v) == "Folder" then
            local fake_rat = dx9.FindFirstChild(v,"AISpawn");
            local Checkpoint2 = dx9.FindFirstChild(v,"Disposals");
            local OxygenTanks = dx9.FindFirstChild(v,"Elevators");

            if fake_rat ~= 0 then
                GetSection1Folder = v;
            end;

            if Checkpoint2 ~= 0 then
                section7 = v;
            end;

            if OxygenTanks ~= 0 then
                last_game = v;
            end;
        end;
    end;

    dx9.DrawString({15,75} , {255,255,255},"Current Game: Book 2 Chapter 1");

    if GetSection1Folder then
        local monster , rat_folder;
        
        for i,v in next , dx9.GetChildren(GetSection1Folder) do
            if dx9.GetType(v) == "Folder" then
                local cs = dx9.GetChildren(v);

                local onec = cs[1];

                if onec and onec ~= 0 and dx9.GetType(onec) == "Model" and #cs == 1 and dx9.FindFirstChild(onec , "Humanoid") ~= 0 then
                    monster = onec;
                end
                
                if onec and onec ~= 0 and dx9.GetType(onec) == "Model" and #cs <= 3 and dx9.FindFirstChild(onec , "Cube") ~= 0 then
                    rat_folder = v;
                end;
            end;
        end;

        ------------------------------- ESP RATS -------------------------------
        if rat_folder and rat_folder ~= 0 then
            for i,v in next , dx9.GetChildren(rat_folder) do
                if dx9.GetType(v) == "Model" then
                    local cube = dx9.FindFirstChild(v,'Cube');

                    if cube and cube ~= 0 then
                        local position = dx9.GetPosition(cube);
                        local tows = dx9.WorldToScreen({position.x,position.y,position.z});

                        local scale = 10;
                
                        dx9.DrawBox( {tows.x - scale, tows.y - (scale + 15)} , {tows.x + (scale - 5), tows.y + (scale - 15)} , {102, 255, 143});

                        dx9.DrawString({tows.x + scale , tows.y - (scale + 15)} , {102, 255, 143},"[ RAT [ "..tostring(i).." ] ]");
                    end;
                end;
            end;
        end;

        ------------------------------- ESP RIN -------------------------------

        if monster and monster ~= 0 and dx9.GetType(monster) == "Model" then
            local HumanoidRootPart = dx9.FindFirstChild(monster , "HumanoidRootPart");

            if HumanoidRootPart ~= 0 then
                local position = dx9.GetPosition(HumanoidRootPart);
                local tows = dx9.WorldToScreen({position.x,position.y,position.z});

                local scale = 30;
                
                dx9.DrawBox( {tows.x - scale, tows.y - (scale + 15)} , {tows.x + (scale - 5), tows.y + (scale - 15)} , {255,255,255});

                dx9.DrawString({tows.x + scale , tows.y - (scale + 15)} , {255,5,5},"[ RIN ]");
            end;  
        end;  

        dx9.DrawString({15,85} , {255,255,255},"Current Section: 1");
    else
        if section7 then


            ------------------------------- ESP MONSTER -------------------------------
            local monsters;
        
            for i,v in next , dx9.GetChildren(section7) do
                if dx9.GetType(v) == "Folder" then
                    local cs = dx9.GetChildren(v);

                    local onec = cs[1];

                    if onec and onec ~= 0 and dx9.GetType(onec) == "Model" and dx9.FindFirstChild(onec , "Humanoid") ~= 0 then
                        monsters = v;
                        break;
                    end
                end;
            end;


            if monsters then
                for i,v in next , dx9.GetChildren(monsters) do
                    local HumanoidRootPart = dx9.FindFirstChild(v , "HumanoidRootPart");

                    if HumanoidRootPart ~= 0 then
                        local position = dx9.GetPosition(HumanoidRootPart);
                        local tows = dx9.WorldToScreen({position.x,position.y,position.z});

                        local scale = 25;
                        
                        dx9.DrawBox( {tows.x - scale, tows.y - (scale + 15)} , {tows.x + (scale - 5), tows.y + (scale - 15)} , {255,255,255});

                        dx9.DrawString({tows.x + scale , tows.y - (scale + 15)} , {255,5,5},"[ MONSTER ]");

                    end; 
                end;
            end;


            dx9.DrawString({15,85} , {255,255,255},"Current Section: 4");

        else
            if last_game ~= 0 and dx9.FindFirstChild(last_game , "NPC") ~= 0 then
                local OxygenTanks = dx9.FindFirstChild(last_game,"OxygenTanks");

                ------------------------- ESP OXYGEN TANKS -----------------------
                if OxygenTanks ~= 0 then
                    for i,v in next , dx9.GetChildren(OxygenTanks) do
                        if dx9.GetType(v) == "Model" then
                            local air = dx9.FindFirstChild(v,'air');

                            if air ~= 0 then
                                local position = dx9.GetPosition(air);
                                local tows = dx9.WorldToScreen({position.x,position.y,position.z});


                                dx9.DrawBox( {tows.x - 10 , tows.y -20} , {tows.x + 10 , tows.y + 20} , {102, 219, 255});

                                dx9.DrawString({tows.x + 10 , tows.y - (35)} , {255, 255, 255},"[ OXYGEN TANK ]");
                            end;
                        end;
                    end;
                end;

                ------------------------- ESP MONSTERS -----------------------
                for i,v in next , dx9.GetChildren(last_game) do
                    if dx9.GetType(v) == "Folder" then
                        local cs = dx9.GetChildren(v);

                        local onec = cs[1];

                        if onec and onec ~= 0 and dx9.GetType(onec) == "Model" and dx9.FindFirstChild(onec , "Humanoid") ~= 0 then
                            -- verified 100% monsters folder
                            
                            for c,x in next , cs do
                                local HumanoidRootPart = dx9.FindFirstChild(x , "HumanoidRootPart");

                                if HumanoidRootPart ~= 0 then
                                    local position = dx9.GetPosition(HumanoidRootPart);
                                    local tows = dx9.WorldToScreen({position.x,position.y,position.z});

                                    local scale = 30;
                                    
                                    dx9.DrawBox( {tows.x - scale, tows.y - (scale + 15)} , {tows.x + (scale - 5), tows.y + (scale - 15)} , {255,255,255});

                                    dx9.DrawString({tows.x + scale , tows.y - (scale + 15)} , {255,5,5},"[ MONSTER ]");
                                end;  
                            end;

                            break;
                        end
                    end;
                end;

                dx9.DrawString({15,85} , {255,255,255},"Current Section: 5 - End");
            else
                dx9.DrawString({15,85} , {255,255,255},"Current Section: Unknow [2 ~ 3 or 4]");
            end;
        end;
    end;
end;


if _G.Cheat_Enabled then
    if _G.GameModeSettings == "Universal" then
        UniversalESP();
    elseif _G.GameModeSettings == "Nightmare Circus" then
        NightmareCircus();
    elseif _G.GameModeSettings == "Book 2 Chapter 1" then
        Loadss1();
    end;
end;
