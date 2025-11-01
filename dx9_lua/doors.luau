local DataModel = dx9.GetDatamodel();
local ReplicatedStorage = dx9.FindFirstChild(DataModel, 'ReplicatedStorage');
local Workspace = dx9.FindFirstChild(DataModel, 'Workspace');

local RenderMonsterESP = function(addr,NAME)
    local Basepart = dx9.FindFirstChild(addr , "Core");

    if Basepart == 0 then
        Basepart = dx9.FindFirstChild(addr , "RushNew");
    end;

    if Basepart == 0 then
        Basepart = dx9.FindFirstChild(addr , "AmbushNew");
    end;

    if Basepart ~= 0 then
        local Position = dx9.GetPosition(Basepart);
     
        local wsc = dx9.WorldToScreen({Position.x,Position.y,Position.z});

        if wsc.x ~= 0 and wsc.y ~= 0 then
            dx9.DrawString( {wsc.x,wsc.y} ,{255,3,3}, "[ MONSTER - "..tostring(NAME).." ]");
        end;
    else
        dx9.DrawString( {100,100} ,{255,3,3}, "[ MONSTER - "..tostring(NAME).." - FAILED ]")
    end;
end;

local rh = dx9.FindFirstChild(Workspace , "RushMoving");
if rh ~= 0 then
    dx9.DrawString({15, 55}, {255,3,3}, "RUSH SPAWN!");

    RenderMonsterESP(rh , 'RUSH')
end;

local amb = dx9.FindFirstChild(Workspace , "AmbushMoving");
if amb ~= 0 then
    dx9.DrawString({15, 65}, {255,3,3}, "AMBUSH SPAWN!");

    RenderMonsterESP(amb , 'AMBUSH')
end;

local eye = dx9.FindFirstChild(Workspace , "Eyes");
if eye ~= 0 then
    dx9.DrawString({15, 75}, {255,3,3}, "EYES SPAWN!");

    RenderMonsterESP(eye, "EYE");
end;

local CurrentRooms = dx9.FindFirstChild(Workspace , "CurrentRooms");

if CurrentRooms ~= 0 then
    local lar = 0;
    local CurrentRoomAddr;

    for i,v in next , dx9.GetChildren(CurrentRooms) do
        local room_num = dx9.GetName(v);

        if tonumber(room_num) > lar then
            lar = tonumber(room_num);

            CurrentRoomAddr = v;
        end;
    end;

    dx9.DrawString({15, 45}, {255,255,255}, "Current Room: "..tostring(lar)..' - [OMPKILLER-RS.lua]');

    if CurrentRoomAddr then
        local EQ_ROOM = dx9.FindFirstChild(CurrentRooms , tostring(lar - 1));
        local Door = dx9.FindFirstChild(EQ_ROOM , "Door");

        if Door ~= 0 then
            local CurrentDoor = dx9.FindFirstChild(Door , "Door");
            local Position = dx9.GetPosition(CurrentDoor);
     
            local wsc = dx9.WorldToScreen({ Position.x,Position.y,Position.z });
            local txt = "[ CURRENT DOOR - ["..tostring(lar).."] ]";

            dx9.DrawString( { wsc.x - (dx9.CalcTextWidth(txt) / 2) , wsc.y } ,{255,255,255}, txt)
        end;
    end;
end;
