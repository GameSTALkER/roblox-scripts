
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
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

properties.NamingEnabled = true;
properties.DistanceEnabled = true;
properties.HealthEnabled = true;
properties.ToolsEnabled = true;

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
	for i, instance in pairs(Objects) do
		instance.DepthMode = value and Enum.HighlightDepthMode.Occluded or Enum.HighlightDepthMode.AlwaysOnTop;
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

module.ToolsEnabledChanged = function(value)
	for i, instance in pairs(Objects) do
		instance.ui.List.Visible = value;
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

	local con1, con2, con3, con4, con5, con6;
	if Player then
		con1 = Player.CharacterAdded:Connect(function(Model: Model)
			instance.Adornee = Model;
		end);
	end;
	
	local gui = Instance.new("BillboardGui", instance);
	gui.Name = "ui";
	gui.ResetOnSpawn = false;
	gui.Size = UDim2.new(5, 0, 6, 0);
	gui.ExtentsOffset = Vector3.new(0, 0.15, 0);
	gui.StudsOffset = Vector3.new(0, 0, 1);
	gui.LightInfluence = 0;
	gui.ClipsDescendants = false;
	gui.AlwaysOnTop = not properties.OnlyVisible;
	
	local info = Instance.new("TextLabel", gui);
	info.Name = "Info";
	info.Text = "Name";
	info.TextScaled = true;
	info.Size = UDim2.new(1, 10, 0, 30)
	info.BackgroundTransparency = 1;
	info.TextStrokeTransparency = 0;
	info.TextColor3 = instance.FillColor;
	
	local list = Instance.new("Frame", gui);
	list.Name = "List";
	list.AnchorPoint = Vector2.new(0, 0);
	list.Position = UDim2.new(0.99, 0, 0, 0);
	list.Size = UDim2.new(1, 0, 0, 1);
	list.BackgroundTransparency = 1;
	
	local grid = Instance.new("UIGridLayout", list);
	grid.Name = "Grid";
	grid.CellSize = UDim2.new(1, 0, 0, 20);
	grid.CellPadding = UDim2.new(0, 0, 0, 0);
	grid.SortOrder = Enum.SortOrder.LayoutOrder;
	
	local sample = Instance.new("TextLabel", gui);
	sample.Name = "Sample";
	sample.Visible = false;
	sample.TextScaled = true;
	sample.BackgroundTransparency = 1;
	sample.TextStrokeTransparency = 0;
	sample.TextColor3 = instance.FillColor;
	sample.LayoutOrder = 1;
	sample.TextXAlignment = Enum.TextXAlignment.Left;
	
	local id = #Objects + 1;

	local function Destroy()
		if con1 then con1:Disconnect(); con1 = nil; end;
		if con2 then con2:Disconnect(); con2 = nil; end;
		if con3 then con3:Disconnect(); con3 = nil; end;
		if con4 then con4:Disconnect(); con4 = nil; end;
		if con5 then con5:Disconnect(); con5 = nil; end;
		if con6 then con6:Disconnect(); con6 = nil; end;
		pcall(function()
			instance:Destroy();
		end);
	end;
	
	instance:GetPropertyChangedSignal("Enabled"):Connect(function()
		gui.Enabled = instance.Enabled;
	end);
	instance:GetPropertyChangedSignal("DepthMode"):Connect(function()
		gui.AlwaysOnTop = instance.DepthMode == Enum.HighlightDepthMode.AlwaysOnTop;
	end);
	instance:GetPropertyChangedSignal("Adornee"):Connect(function()
		gui.Adornee = instance.Adornee;
		
		if con2 then con2:Disconnect(); con2 = nil; end;
		if con3 then con3:Disconnect(); con3 = nil; end;
		if con4 then con4:Disconnect(); con4 = nil; end;
		if con5 then con5:Disconnect(); con5 = nil; end;
		if con6 then con6:Disconnect(); con6 = nil; end;
		
		if not instance.Adornee then return; end;
		
		Model = instance.Adornee;
		Player = Players:GetPlayerFromCharacter(Model);
		
		local humanoid = Model:FindFirstChildOfClass("Humanoid");
		if not Player then
			if humanoid then
				humanoid.Died:Connect(Destroy);
			end;
			Model.Destroying:Connect(Destroy);
		end;
		
		local changeData = function()
			local part = instance.Adornee and ((instance.Adornee:IsA("Model") and instance.Adornee.PrimaryPart) or (instance.Adornee:IsA("Part") and instance.Adornee) or instance.Adornee:FindFirstChildOfClass("Part"));
			local humanoid = Model:FindFirstChildOfClass("Humanoid");
			
			local Distance = 0;
			local Health = humanoid and (tostring(humanoid.Health) .. "/" .. tostring(humanoid.MaxHealth)) or false;
			local Name = humanoid and (humanoid.DisplayName:gsub(" ", "") ~= "" and humanoid.DisplayName) or Model.Name;
			
			if part and LocalPlayer.Character then
				Distance = math.round((part.CFrame.Position - LocalPlayer.Character.PrimaryPart.CFrame.Position).Magnitude);
			end;
			
			local Name = (properties.NamingEnabled and Name or "");
			local Health = (properties.HealthEnabled and Health and ((Name ~= "" and " | " or "") .. Health) or "");
			Distance = (properties.DistanceEnabled and Distance ~= 0 and (((Name .. Health) ~= "" and " | " or "") .. tostring(Distance) .. " Studs") or "");
			
			info.Text = Name .. Health .. Distance;
		end;
		con2 = RunService.RenderStepped:Connect(changeData);
		
		local ToolChanged = function()
			for i, v in pairs(list:GetChildren()) do
				if v:IsA("TextLabel") then
					v:Destroy();
				end;
			end;
			
			if Player then
				for i, v in pairs(Player.Backpack:GetChildren()) do -- inactive
					local new = sample:Clone();
					new.Parent = list;
					new.Visible = true;
					new.TextColor3 = Color3.new(0.7, 0.7, 0.7);
					new.Text = v.Name;
					new.Name = v.Name;
				end;
			end;
			for i, v in pairs(Model:GetChildren()) do -- active
				if v:IsA("Tool") then
					local new = sample:Clone();
					new.Parent = list;
					new.LayoutOrder = 0;
					new.Visible = true;
					new.Text = v.Name;
				end;
			end;
		end;

		if Player then
			con3 = Player.Backpack.ChildAdded:Connect(ToolChanged);
			con4 = Player.Backpack.ChildRemoved:Connect(ToolChanged);
		end;
		con5 = Model.ChildAdded:Connect(ToolChanged);
		con6 = Model.ChildRemoved:Connect(ToolChanged);
		ToolChanged();
		
	end);
	instance:GetPropertyChangedSignal("FillColor"):Connect(function()
		info.TextColor3 = instance.FillColor;
	end);
	--instance:GetPropertyChangedSignal("OutlineColor"):Connect(function()
	--	info.TextStrokeColor3 = instance.OutlineColor;
	--end);
	
	instance.Destroying:Connect(Destroy);
	
	instance.Adornee = Model;
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
