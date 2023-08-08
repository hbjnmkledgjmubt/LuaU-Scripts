getgenv()['Tool'] = {}
getgenv()['Net'] = false

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character

Tool.SelectAll = function(Path, TName)
	local count = 0
	for i,v in pairs(Path:GetDescendants()) do
		if TName then
            if v:IsA('Tool') and v.Name == tostring(TName) then
                v.Parent = Character
				count = count + 1
            else
                return 'Failed to find tools.';
            end
        else
            if v:IsA('Tool') then
                v.Parent = Character
				count = count + 1
            end
		end
	end
	if count > 0 then
		return true;
	else
		return false;
	end
end

Tool.CreateNet = function(Path)
	if Net == true then
		return true;
	else
		Net = true
	end
	task.spawn(function()
		while Net and task.wait() do
			for i,v in pairs(Path:GetDescendants()) do
				if v:IsA('BasePart') and v.Name ~= 'HumanoidRootPart' then
					v.Velocity = Vector3.new(0,30,0)
				end
			end
		end
	end)
    return true;
end

Tool.DeleteNet = function()
	if Net == true then
		Net = false;
	else
		return false;
	end

    return true;
end

Tool.BreakJoins = function()
    for i,v in pairs(Character:GetDescendants()) do
        if v:IsA('Tool') then
            v.Parent = Player.Backpack
			v.Parent = Character.HumanoidRootPart
			v.Parent = Character
        end
    end
    return true;
end

Tool.RequestNetwork = function(handle)
	while handle and task.wait() do
		sethiddenproperty(handle, 'NetworkIsSleeping', false)
		handle.Velocity = Vector3.new(50, 50, 50)
	end
    return true;
end
