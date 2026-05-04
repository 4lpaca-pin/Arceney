-- SNIPER DUALS [NOT FINISH IM TOO LAZY] --

local targetPart = "Head"; -- "Head" , "Torso" , "Left Arm" , "Right Arm" , ...

local sensitivity = 3;
local smoothness = 3;
local StableShake = 0.011;

dx9.ShowConsole(false);

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

if dx9 then
    local dModelBase = dx9.GetDatamodel();

    local Players = dx9.FindFirstChild(dModelBase,'Players');
    local SelfPosition = dx9.get_localplayer().Position;
    local aimbot_range = dx9.GetAimbotValue('range');
    local aimbot_fov = dx9.GetAimbotValue('fov');

    local RefreshPlayer = function()
        local sint = {};
	
        for i,v in next , dx9.GetChildren(Players) do
            if dx9.FindFirstChild(v,'PlayerGui') == 0 then
                table.insert(sint , v)
            end;
        end;

        return sint;
    end;

    local nearestaim,opt = nil , aimbot_fov;
    local TargetPart;

    local center_point = {
        x = dx9.size().width / 2,
        y = dx9.size().height / 2,
    };

    for i,v in next , dx9.GetChildren(Players) do
        if dx9.FindFirstChild(v,'PlayerGui') == 0 then
            local char = dx9.GetCharacter(v);

            if char ~= 0 then
                -- esp
                local root = dx9.FindFirstChild(char,'HumanoidRootPart');
                if root ~= 0 then
                    local pos = dx9.GetPosition(root);
                    if pos then
                        local Target = dx9.GetPosition(dx9.FindFirstChild(char,targetPart));

                        local worldpoint = dx9.WorldToScreen({pos.x,pos.y + 3,pos.z});
                        local worldpoint2 = dx9.WorldToScreen({pos.x,pos.y - 3,pos.z});
                        local Target2D = dx9.WorldToScreen({Target.x,Target.y,Target.z});

                        local default = dx9.WorldToScreen({pos.x,pos.y,pos.z});

                        local diff = (worldpoint2.y - worldpoint.y) / 3;

                        local dstance = GetDistance(pos , SelfPosition);

                        if dstance < aimbot_range and worldpoint2.x ~=0 then
                            dx9.DrawBox({
                                worldpoint.x - 5 - diff,
                                worldpoint.y - 10
                            },{
                                worldpoint2.x + 5 + diff,
                                worldpoint2.y + 10
                            },{255,255,255})

                            dx9.DrawString({worldpoint.x - 10 - diff, worldpoint.y - diff},{255,255,255},"[DIS]:"..tostring(dstance))

                            -- aimbot

                            local foxdis = get2d(center_point , default) / 2;

                            if foxdis < opt then
                                opt = foxdis
                                nearestaim = Target2D;
                                TargetPart = dx9.FindFirstChild(char,targetPart)
                            end;
                        end;
                    end
                end;
            end;
        end;
    end;

    if nearestaim and TargetPart then
        local Target = dx9.GetPosition(TargetPart);

        local Target2D = dx9.WorldToScreen({Target.x,Target.y,Target.z});

        dx9.SetAimbotValue("x", 0)
		dx9.SetAimbotValue("y", 0)
		dx9.SetAimbotValue("z", 0)

        _G.AIMBOT_DELAY = _G.AIMBOT_DELAY or os.clock();

        if (os.clock() - _G.AIMBOT_DELAY) > StableShake then
            _G.AIMBOT_DELAY = os.clock();
            dx9.FirstPersonAim({
                (Target2D.x + center_point.x),
                (Target2D.y + center_point.y)
            }, smoothness , sensitivity);
        end;
    end;
end;
