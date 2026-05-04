--[[
            - BITE BY NIGHT -

    - KILLER ESP
    - SURVIVORS ESP
    - KILLER/SURVIVORS SKILL ESP
    - PREDICTION [BETA]

    AUTHOR: 4LPACA
]]

dx9.ShowConsole(false);

local Self = dx9.get_localplayer();

local SelfName = Self.Info.Name;

local dModelBase = dx9.GetDatamodel();

local Players = dx9.FindFirstChild(dModelBase,'Players');

local Workspace = dx9.FindFirstChild(dModelBase,'Workspace');

local PLAYERS_FOLDER = dx9.FindFirstChild(Workspace,'PLAYERS');
local KILLER_FOLDER = dx9.FindFirstChild(PLAYERS_FOLDER,'KILLER');
local ALIVE_FOLDER = dx9.FindFirstChild(PLAYERS_FOLDER,'ALIVE');
local IGNORE_FOLDER = dx9.FindFirstChild(Workspace,'IGNORE');

local center_point = {
    x = dx9.size().width / 2,
    y = dx9.size().height / 2,
};

function GetDistance(a, b)
    local dx = b.x - a.x;
    local dy = b.y - a.y;
    local dz = b.z - a.z;
    return math.ceil(math.sqrt(dx * dx + dy * dy + dz * dz))
end

function get2d(a,b) 
    local dx = b.x - a.x;
    local dy = b.y - a.y;
    return math.ceil(math.sqrt(dx * dx + dy * dy))
end;

local NearestPlyer,OPT = nil , math.huge;

for i,model in next , dx9.GetChildren(ALIVE_FOLDER) do
    if dx9.GetName(model) ~= SelfName then
        local root = dx9.FindFirstChild(model,'HumanoidRootPart');
        local humanoid = dx9.FindFirstChild(model,'Humanoid');

        local Health = dx9.GetHealth(humanoid);

        local TargetPosition = dx9.GetPosition(root);

        local worldpoint = dx9.WorldToScreen({TargetPosition.x,TargetPosition.y + 3,TargetPosition.z});
        local worldpoint2 = dx9.WorldToScreen({TargetPosition.x,TargetPosition.y - 3,TargetPosition.z});
        local default = dx9.WorldToScreen({TargetPosition.x,TargetPosition.y,TargetPosition.z});

        local diff = (worldpoint2.y - worldpoint.y) / 3;

        dx9.DrawBox({
            worldpoint.x - 5 - diff,
            worldpoint.y - 10
        },{
            worldpoint2.x + 5 + diff,
            worldpoint2.y + 10
        },{110, 255, 173});

        local class = "UNKNOW";

        if dx9.FindFirstChild(model,'Medkit') ~= 0 then
            class = "MEDIC";
        elseif dx9.FindFirstChild(model,'FAZ-TAZER') ~= 0 then
            class = "SECURITY GUARD";
        elseif dx9.FindFirstChild(model,'Assets') ~= 0 and dx9.FindFirstChild(dx9.FindFirstChild(model,'Assets'),'EnergyDrink') ~= 0 then
            class = "CUSTOMER";
        elseif dx9.FindFirstChild(model,'Axe') ~= 0 then
            class = "FIGHTER";
        elseif dx9.FindFirstChild(model,'Belt') ~= 0 then
            class = "TECHNICIAN";
        end;

        if worldpoint.x > 0 and worldpoint.y > 0 then
            dx9.DrawString({worldpoint.x - 15 - diff, worldpoint.y - diff - 5},{110, 255, 173},"[CLASS]: "..tostring(class)..' | HP: '..tostring(math.ceil(Health)))
        end;

        local foxdis = get2d(center_point , default) / 2;

        if foxdis < OPT then
            OPT = foxdis
            NearestPlyer = TargetPosition;
        end;
    end;
end;

local Killer = false;
for i,model in next , dx9.GetChildren(KILLER_FOLDER) do
    if dx9.GetName(model) ~= SelfName then
        local root = dx9.FindFirstChild(model,'HumanoidRootPart');

        local TargetPosition = dx9.GetPosition(root);

        local worldpoint = dx9.WorldToScreen({TargetPosition.x,TargetPosition.y + 4,TargetPosition.z});
        local worldpoint2 = dx9.WorldToScreen({TargetPosition.x,TargetPosition.y - 4,TargetPosition.z});

        local diff = (worldpoint2.y - worldpoint.y) / 4;

        dx9.DrawBox({
            worldpoint.x - 6 - diff,
            worldpoint.y - 10
        },{
            worldpoint2.x + 6 + diff,
            worldpoint2.y + 10
        },{255, 110, 110});

        if worldpoint.x > 0 and worldpoint.y > 0 then
            dx9.DrawString({worldpoint.x - 10 - diff, worldpoint.y - diff},{255, 110, 110},"KILLER: "..tostring(dx9.GetName(model)))
        end;
    else
        Killer = true;
    end;
end;

if IGNORE_FOLDER ~= 0 then
    local Dir = 15;

    -- TRAP ESP

    local esp_trap = function(trap)
        local TrapPart = dx9.FindFirstChild(trap,'Trap');

        if TrapPart == 0 then
            return 0;
        end;

        local pos = dx9.GetPosition(TrapPart);

        local worldpoint = dx9.WorldToScreen({pos.x,pos.y - 1,pos.z});
        local worldpoint2 = dx9.WorldToScreen({pos.x,pos.y + 1,pos.z});

        local diff = (worldpoint2.y - worldpoint.y) / 4;

        if worldpoint.x > 0 and worldpoint.y > 0 then
            dx9.DrawBox({
                worldpoint.x - Dir - diff,
                worldpoint.y - Dir
            },{
                worldpoint2.x + Dir + diff,
                worldpoint2.y + Dir
            },{255, 216, 117});

            dx9.DrawString({worldpoint.x - (Dir + 5) - diff, worldpoint.y - 25 - diff},{255, 216, 117},"TRAP")
        end;
    end;

    local Trap1 = dx9.FindFirstChild(IGNORE_FOLDER,'Trap1');

    -- ESP MINION
    local esp_minion = function(HumanoidRootPart)
        if HumanoidRootPart == 0 then
            return 0;
        end;

        local pos = dx9.GetPosition(HumanoidRootPart);

        local worldpoint = dx9.WorldToScreen({pos.x,pos.y - 1,pos.z});
        local worldpoint2 = dx9.WorldToScreen({pos.x,pos.y + 1,pos.z});

        local diff = (worldpoint2.y - worldpoint.y) / 4;

        if worldpoint.x > 0 and worldpoint.y > 0 then
            dx9.DrawBox({
                worldpoint.x - Dir - diff,
                worldpoint.y - Dir
            },{
                worldpoint2.x + Dir + diff,
                worldpoint2.y + Dir
            },{255, 117, 147});

            dx9.DrawString({worldpoint.x - (Dir + 5) - diff, worldpoint.y - 25 - diff},{255, 117, 147},"MINION")
        end;
    end;

    -- ESP ANTENA [STATIC MIRAGE]
    local esp_staticmirage = function(Part)
        if Part == 0 then
            return 0;
        end;

        local pos = dx9.GetPosition(Part);

        local worldpoint = dx9.WorldToScreen({pos.x,pos.y - 1,pos.z});
        local worldpoint2 = dx9.WorldToScreen({pos.x,pos.y + 1,pos.z});

        local diff = (worldpoint2.y - worldpoint.y) / 4;

        if worldpoint.x > 0 and worldpoint.y > 0 then
            dx9.DrawBox({
                worldpoint.x - Dir - diff,
                worldpoint.y - Dir
            },{
                worldpoint2.x + Dir + diff,
                worldpoint2.y + Dir
            },{117, 255, 184});

            dx9.DrawString({worldpoint.x - (Dir + 5) - diff, worldpoint.y - 25 - diff},{117, 255, 184},"ANTENNA")
        end;
    end;

    for i,v in next , dx9.GetChildren(IGNORE_FOLDER) do
        local ObjectName = dx9.GetName(v);

        if ObjectName == "Minion" then
            local HumanoidRootPart =dx9.FindFirstChild(v,'HumanoidRootPart');

            if HumanoidRootPart ~= 0 then
                esp_minion(HumanoidRootPart)
            end;
        elseif ObjectName == "Antenna" then
            local StaticRoot = dx9.FindFirstChild(v,'StaticRoot');

            if StaticRoot ~= 0 then
                esp_staticmirage(StaticRoot)
            end;
        end;
    end;

    local Trap2 = dx9.FindFirstChild(IGNORE_FOLDER,'Trap2');
    local Trap3 = dx9.FindFirstChild(IGNORE_FOLDER,'Trap3');

    if Trap1 ~= 0 then
        esp_trap(Trap1)
    end;

    if Trap2 ~= 0 then
        esp_trap(Trap2)
    end;

    if Trap3 ~= 0 then
        esp_trap(Trap3)
    end;
end;

function addVec(a, b)
    return {x = a.x + b.x, y = a.y + b.y, z = a.z + b.z}
end

function subVec(a, b)
    return {x = a.x - b.x, y = a.y - b.y, z = a.z - b.z}
end

function scaleVec(v, s)
    return {x = v.x * s, y = v.y * s, z = v.z * s}
end

local lerp = (function(a, b, t)
    return addVec(a , scaleVec(subVec(b , a) , t))
end);

local QuadraticBezier = (function(t, p0, p1, p2)
    local l1 = lerp(p0, p1, t);
    local l2 = lerp(p1, p2, t);
    local quad = lerp(l1, l2, t);

    return quad;
end);

if NearestPlyer and Killer then
    --- stupid ass code i ever write

    local cliPos = Self.Position;

    local dis = GetDistance(cliPos , NearestPlyer);

    local lineup = 4.775;

    if dis > 240 then
        lineup = 3.5;
    end;

    local Point = QuadraticBezier(0.5 , cliPos , addVec(NearestPlyer, {
        x = 0,
        y = dis / lineup,
        z = 0
    }) , NearestPlyer);

    local worldpoint = dx9.WorldToScreen({
        Point.x,
        Point.y,
        Point.z
    })

    dx9.DrawString({worldpoint.x - 2, worldpoint.y},{255, 110, 110},"[+]")
end;
