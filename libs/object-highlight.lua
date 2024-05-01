
local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;

local module, properties, meta = {}, {}, {};
local Objects = {};
local PlayerObjects = {};

properties.Parent = game:GetService("ReplicatedStorage");
properties.Color = Color3.new(1, 1, 1);
properties.AllyColor = Color3.new(0, 1, 0);

properties.FillTransparency = 0.5
properties.OutlineTransparency = 0.8;

properties.OnlyVisible = false;
properties.HighlightSelf = true;
properties.HighlightAllies = true;
properties.UseTeamColors = false;

module.ParentChanged = function(value)
	for i, instance in pairs(Objects) do
		instance.Parent = value;
	end;
end;
module.ColorChanged = function(value)
	for i, instance in pairs(Objects) do
		instance.FillColor = value;
		instance.OutlineColor = value;
	end;
end;
module.AllyColorChanged = function(value)
end;

module.FillTransparencyChanged = function(value)
	for i, instance in pairs(Objects) do
		instance.FillTransparency = value;
	end;
end;
module.OutlineTransparencyChanged = function(value)
	for i, instance in pairs(Objects) do
		instance.OutlineTransparency = value;
	end;
end;

module.OnlyVisibleChanged = function(value)
	for i, instance in pairs(PlayerObjects) do
		if tonumber(i) then
			instance[1].DepthMode = value and Enum.HighlightDepthMode.Occluded or Enum.HighlightDepthMode.AlwaysOnTop;
		end;
	end;
end;
module.HighlightSelfChanged = function(value)
	for i, instance in pairs(PlayerObjects) do
		if tonumber(i) and instance[1].Adornee == LocalPlayer.Character then
			instance[1].Enabled = value;
			break;
		end;
	end;
end;
module.HighlightAlliesChanged = function(value)
	for i, instance in pairs(PlayerObjects) do
		if tonumber(i) and instance[1].Adornee ~= LocalPlayer.Character then
			if value then
				instance[1].Enabled = true;
			else
				instance[1].Enabled = (Players:GetPlayerFromCharacter(instance[1].Adornee).Team ~= LocalPlayer.Team);
			end;
		end;
	end;

end;
module.UseTeamColorsChanged = function(value)
	for i, instance in pairs(PlayerObjects) do
		if tonumber(i) then
			local Player = Players:GetPlayerFromCharacter(instance[1].Adornee);
			instance[1].FillColor = value and Player and Player.Team and Player.Team.TeamColor.Color or properties.Color;
			instance[1].OutlineColor = instance[1].FillColor;
		end;
	end;
end;

function module.new(Model)
	local instance = Instance.new("Highlight", properties.Parent);
	local Player = Players:GetPlayerFromCharacter(Model);
	instance.FillColor = properties.UseTeamColors and Player and Player.Team and Player.Team.TeamColor.Color or properties.Color;
	instance.OutlineColor = instance.FillColor;
	instance.FillTransparency = properties.FillTransparency;
	instance.OutlineTransparency = properties.OutlineTransparency;
	instance.DepthMode = properties.OnlyVisible and Enum.HighlightDepthMode.Occluded or Enum.HighlightDepthMode.AlwaysOnTop;
	instance.Adornee = Model;
	
	local id = #Objects + 1;
	
	if Model then
		Model.Destroying:Connect(function()
			instance:Destroy();
		end);
	end;
	Objects[id] = instance;
	
	return instance;
end;

local function prepareCharacter(highlight, Model)
	highlight.Adornee = Model;
	if LocalPlayer.Character == Model then
		highlight.Enabled = properties.HighlightSelf;
	else
		if properties.HighlightAllies then
			highlight.Enabled = true;
		else
			highlight.Enabled = (Players:GetPlayerFromCharacter(Model).Team ~= LocalPlayer.Team);
		end;
	end;
	local humanoid = Model:FindFirstChildOfClass("Humanoid");
	repeat
		humanoid = Model:FindFirstChildOfClass("Humanoid");
		task.wait();
	until humanoid;
	humanoid.Died:Connect(function()
		highlight.Enabled = false;
	end);
end;

local function preparePlayer(Player)
	if PlayerObjects[tostring(Player.UserId)] then
		PlayerObjects[tostring(Player.UserId)][1]:Destroy();
		PlayerObjects[tostring(Player.UserId)][2]:Disconnect();
		PlayerObjects[tostring(Player.UserId)][3]:Disconnect();
	end;
	
	local highlight = module.new();
	if Player.Character then
		prepareCharacter(highlight, Player.Character);
	end;
	
	PlayerObjects[tostring(Player.UserId)] = {
		highlight;
		Player.CharacterAdded:Connect(function(Model)
			prepareCharacter(highlight, Model);
		end);
		Player:GetPropertyChangedSignal("Team"):Connect(function()
			highlight.FillColor = properties.UseTeamColors and Player.Team and Player.Team.TeamColor.Color or properties.Color;
			highlight.OutlineColor = highlight.FillColor;
		end);
	};
end;

function module:Players(state)
	if state then
		PlayerObjects["PlayersAdded"] = Players.PlayerAdded:Connect(function(Player)
			preparePlayer(Player);
		end);
		PlayerObjects["PlayersLeft"] = Players.PlayerAdded:Connect(function(Player)
			PlayerObjects[tostring(Player.UserId)][1]:Destroy();
			PlayerObjects[tostring(Player.UserId)][2]:Disconnect();
			PlayerObjects[tostring(Player.UserId)][3]:Disconnect();
			PlayerObjects[tostring(Player.UserId)] = nil;
		end);
		for i, v in pairs(Players:GetPlayers()) do
			preparePlayer(v);
		end;
	elseif PlayerObjects["PlayersAdded"] ~= nil then
		for i, v in pairs(PlayerObjects) do
			if type(v) == "table" then
				for i, v in pairs(v) do
					local IsConnected, err = pcall(function()
						return v.Connected;
					end);
					if IsConnected then
						v:Disconnect();
					elseif err then
						v:Destroy();
					end
				end;
			else
				v:Disconnect();
			end;
		end;
		PlayerObjects = {};
	end;
end;
PlayerObjects["TeamChanged"] = LocalPlayer:GetPropertyChangedSignal("Team"):Connect(function()
	module.HighlightAlliesChanged(meta.HighlightAllies);
end);


function module:Destroy()
	module:Players(false);
	for i, v in pairs(Objects) do
		if v then
			v:Destroy();
		end;
	end;
end;

meta = setmetatable(module, {
	__index = function(root, index)
		return properties[index];
	end,
	__newindex = function(root, index, value)
		if module[index .. "Changed"] then
			module[index .. "Changed"](value);
		end;
		properties[index] = value
		return value;
	end;
});

return meta;
