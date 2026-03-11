local path = game:GetService('PathfindingService');
local lp = game:GetService('Players').LocalPlayer;
local await = Instance.new('BindableEvent');

local clWalk : {
	__path : Path,
	walk : Vector3,
	
	compute : (walkpos : Vector3) -> path,
	start : () -> thread,
	stop : () -> nil,
	rct : RaycastParams,
	isFinish : () -> nil,
	waitFinish : () -> nil,
} = {};

clWalk.walk = nil;
clWalk.__path = nil;
clWalk.rct = RaycastParams.new();

local PressInput = function(keys)
    game:GetService('VirtualInputManager'):SendKeyEvent(true, keys, false, game:GetService("Players").LocalPlayer.PlayerGui);
    task.wait();
    game:GetService('VirtualInputManager'):SendKeyEvent(false, keys, false, game:GetService("Players").LocalPlayer.PlayerGui);
end;

function clWalk._loadpath()
	clWalk.__path = path:CreatePath({
		AgentRadius = 2,
		AgentCanClimb = true,
		WaypointSpacing = 6,
	});
end;

local newPart = function()
	local ind = Instance.new('Part');
	
	ind.Size = Vector3.new(1,1,1);
	ind.Anchored = true
	ind.CanCollide = false
	ind.Material = Enum.Material.Neon
	ind.Parent = workspace;
	
	return ind
end;

function clWalk.compute(walkPos : Vector3)
	if clWalk.walk == walkPos then
		return;
	end;
	
	local start = lp.Character:FindFirstChild('HumanoidRootPart');
	
	clWalk.walk = walkPos;
	
	clWalk.__path:ComputeAsync(start.Position , walkPos);
	
	clWalk.rct.FilterType = Enum.RaycastFilterType.Exclude;
	clWalk.rct.IgnoreWater = true
	clWalk.rct.RespectCanCollide = false;
	clWalk.rct.FilterDescendantsInstances = {lp.Character};
		
	return clWalk.__path;
end;

function clWalk.raycast(target : Vector3)
	local HumanoidRootPart : BasePart = lp.Character:FindFirstChild('HumanoidRootPart');

	local ut = (target - HumanoidRootPart.Position);
	
	local raycast = workspace:Raycast(HumanoidRootPart.Position , ut , clWalk.rct);
	
	if raycast then
		return (raycast.Position - target).Magnitude <= 25;
	end;
	
	return;
end;

function clWalk.isFinish()
	if not clWalk.walk then return true end;
	
	local HumanoidRootPart : BasePart = lp.Character:FindFirstChild('HumanoidRootPart');

	return (Vector3.new(clWalk.walk.X,0,clWalk.walk.Z) - Vector3.new(HumanoidRootPart.Position.X,0,HumanoidRootPart.Position.Z)).Magnitude <= 3;
end;

function clWalk.waitFinish()
	repeat task.wait(0.1)
		
	until clWalk.isFinish();
end;

function clWalk.start()
	if clWalk.__thread then
		task.cancel(clWalk.__thread);
	end;
	
	clWalk.__thread = task.spawn(function()
		local Humanoid : Humanoid = lp.Character:FindFirstChild('Humanoid');

		if clWalk.__path.Status ~= Enum.PathStatus.Success then
			Humanoid:MoveTo(clWalk.walk);
		end;

		for i,v : PathWaypoint in next , clWalk.__path:GetWaypoints() do
			local part = newPart()
			
			part.Position = v.Position;
			
			part.Parent = workspace
			
			task.delay(1,part.Destroy,part)
			
			repeat task.wait()
	
				Humanoid:MoveTo(v.Position + Vector3.new(math.random(-2,2),math.random(-1,1),math.random(-2,2)));

				if v.Action == Enum.PathWaypointAction.Jump or Humanoid.RootPart.Velocity.Magnitude <= 3 then
					PressInput(Enum.KeyCode.Space);
					Humanoid:MoveTo(v.Position + Vector3.new(math.random(-15,15),math.random(-15,15),math.random(-15,15)));
				end;

			until (Vector3.new(Humanoid.RootPart.Position.X,0,Humanoid.RootPart.Position.Z) - Vector3.new(v.Position.X,0,v.Position.Z)).Magnitude <= 3;
		end;
	end);
end;

function clWalk.stop()
	if clWalk.__thread then
		task.cancel(clWalk.__thread);
	end;
end;

clWalk._loadpath()

return clWalk;
