-- local UI = getgenv().EasyUI.Library or loadstring(game:HttpGet("raw_url_here"))(); -- Best way to avoid GitHub ratelimit.
-- Call getgenv().EasyUI.Destroy(); to unload lib

local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");

local UI = {};

UI.ScreenGui = function(parent, properties)
	properties = properties or {};
    -- Removing some client sided checks (if available)
    if getconnections then
        local count = 0;
        local check = {
            "ChildAdded";
            "DescendantAdded";
            "ChildRemoved";
            "DescendantRemoving";
        }
        for i,v in pairs(check) do
            for i,v in pairs(getconnections(parent[v])) do
                count = count + 1;
                v:Disable();
            end;
        end;
        if count > 0 then
            print("[easy-ui] disabled " .. tostring(count) .. " connections.");
        end;
    end;
	local instance = Instance.new("ScreenGui", parent);
	instance.Name = " ";
	instance.DisplayOrder = 0;
	instance.ResetOnSpawn = false;
	instance.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
	instance.AutoLocalize = false;
	instance.Archivable = false;
	for i,v in pairs(properties) do
		pcall(function()
			instance[i] = v;
		end);
	end;
	return instance;
end;
-- // Frames
UI.Frame = function(parent, properties)
	properties = properties or {};

	local instance = Instance.new("Frame", parent);
	instance.Name = " ";
	instance.AnchorPoint = Vector2.new(0, 0);
	instance.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	instance.BackgroundTransparency = 0;
	instance.Position = UDim2.new(0, 0, 0, 0);
	instance.Size = UDim2.new(0, 100, 0, 100);
	instance.BorderSizePixel = 0;
	instance.AutoLocalize = false;
	instance.Archivable = false;
	for i,v in pairs(properties) do
		pcall(function()
			instance[i] = v;
		end);
	end;
	return instance;
end;
UI.ScrollingFrame = function(parent, properties)
	properties = properties or {};

	local instance = Instance.new("ScrollingFrame", parent);
	instance.Name = " ";
	instance.AnchorPoint = Vector2.new(0, 0);
	instance.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	instance.BackgroundTransparency = 0;
	instance.Position = UDim2.new(0, 0, 0, 0);
	instance.Size = UDim2.new(0, 100, 0, 100);
	instance.CanvasSize = UDim2.new(0, 0, 0, 0);
	instance.ScrollBarThickness = 6;
	instance.BorderSizePixel = 0;
	instance.AutoLocalize = false;
	instance.Archivable = false;
	for i,v in pairs(properties) do
		pcall(function()
			instance[i] = v;
		end);
	end;
	return instance;
end;
UI.CanvasGroup = function(parent, properties)
	properties = properties or {};

	local instance = Instance.new("CanvasGroup", parent);
	instance.Name = " ";
	instance.AnchorPoint = Vector2.new(0, 0);
	instance.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	instance.BackgroundTransparency = 1;
	instance.Position = UDim2.new(0, 0, 0, 0);
	instance.Size = UDim2.new(0, 100, 0, 100);
	instance.BorderSizePixel = 0;
	instance.GroupColor3 = Color3.fromRGB(255, 255, 255);
	instance.GroupTransparency = 0;
	instance.AutoLocalize = false;
	instance.Archivable = false;
	for i,v in pairs(properties) do
		pcall(function()
			instance[i] = v;
		end);
	end;
	return instance;
end;
-- // Text
UI.TextLabel = function(parent, properties)
	properties = properties or {};

	local instance = Instance.new("TextLabel", parent);
	instance.Name = " ";
	instance.AnchorPoint = Vector2.new(0, 0);
	instance.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	instance.Position = UDim2.new(0, 0, 0, 0);
	instance.Size = UDim2.new(0, 100, 0, 100);
	instance.Font = Enum.Font.Ubuntu;
	instance.TextColor3 = Color3.fromRGB(0, 0, 0);
	instance.TextSize = 14;
	instance.TextTransparency = 0;
	instance.TextStrokeTransparency = 1;
	instance.BorderSizePixel = 0;
	instance.AutoLocalize = false;
	instance.Archivable = false;
	for i,v in pairs(properties) do
		pcall(function()
			instance[i] = v;
		end);
	end;
	return instance;
end;
UI.TextButton = function(parent, properties)
	properties = properties or {};

	local instance = Instance.new("TextButton", parent);
	instance.Name = " ";
	instance.AnchorPoint = Vector2.new(0, 0);
	instance.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	instance.Position = UDim2.new(0, 0, 0, 0);
	instance.Size = UDim2.new(0, 100, 0, 100);
	instance.AutoButtonColor = false;
	instance.Font = Enum.Font.Ubuntu;
	instance.TextColor3 = Color3.fromRGB(0, 0, 0);
	instance.TextSize = 14;
	instance.TextTransparency = 0;
	instance.TextStrokeTransparency = 1;
	instance.BorderSizePixel = 0;
	instance.AutoLocalize = false;
	instance.Archivable = false;
	for i,v in pairs(properties) do
		pcall(function()
			instance[i] = v;
		end);
	end;
	return instance;
end;
UI.TextBox = function(parent, properties)
	properties = properties or {};

	local instance = Instance.new("TextBox", parent);
	instance.Name = " ";
	instance.AnchorPoint = Vector2.new(0, 0);
	instance.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	instance.Position = UDim2.new(0, 0, 0, 0);
	instance.Size = UDim2.new(0, 100, 0, 100);
	instance.Font = Enum.Font.Ubuntu;
	instance.TextColor3 = Color3.fromRGB(0, 0, 0);
	instance.TextSize = 14;
	instance.TextTransparency = 0;
	instance.TextStrokeTransparency = 1;
	instance.ClearTextOnFocus = false;
	instance.TextEditable = true;
	instance.MultiLine = false;
	instance.BorderSizePixel = 0;
	instance.AutoLocalize = false;
	instance.Archivable = false;
	for i,v in pairs(properties) do
		pcall(function()
			instance[i] = v;
		end);
	end;
	return instance;
end;
-- // Image
UI.ImageLabel = function(parent, properties)
	properties = properties or {};

	local instance = Instance.new("ImageLabel", parent);
	instance.Name = " ";
	instance.AnchorPoint = Vector2.new(0, 0);
	instance.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	instance.Position = UDim2.new(0, 0, 0, 0);
	instance.Size = UDim2.new(0, 100, 0, 100);
	instance.Image = "";
	instance.BorderSizePixel = 0;
	instance.AutoLocalize = false;
	instance.Archivable = false;
	for i,v in pairs(properties) do
		pcall(function()
			instance[i] = v;
		end);
	end;
	return instance;
end;
UI.ImageButton = function(parent, properties)
	properties = properties or {};

	local instance = Instance.new("ImageButton", parent);
	instance.Name = " ";
	instance.AnchorPoint = Vector2.new(0, 0);
	instance.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	instance.Position = UDim2.new(0, 0, 0, 0);
	instance.Size = UDim2.new(0, 100, 0, 100);
	instance.Image = "";
	instance.BorderSizePixel = 0;
	instance.AutoLocalize = false;
	instance.Archivable = false;
	for i,v in pairs(properties) do
		pcall(function()
			instance[i] = v;
		end);
	end;
	return instance;
end;
UI.VideoFrame = function(parent, properties)
	properties = properties or {};

	local instance = Instance.new("VideoFrame", parent);
	instance.Name = " ";
	instance.AnchorPoint = Vector2.new(0, 0);
	instance.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
	instance.Position = UDim2.new(0, 0, 0, 0);
	instance.Size = UDim2.new(0, 100, 0, 100);
	instance.Image = "";
	instance.BorderSizePixel = 0;
	instance.AutoLocalize = false;
	instance.Archivable = false;
	instance.Looped = false;
	instance.Playeing = false;
	instance.Video = "";
	instance.Volume = 1;
	for i,v in pairs(properties) do
		pcall(function()
			instance[i] = v;
		end);
	end;
	return instance;
end;
-- // Styles
UI.Corner = function(parent, properties)
	properties = properties or {};

	local instance = Instance.new("UICorner", parent);
	instance.Name = "UICorner";
	instance.CornerRadius = UDim.new(0, 0);
	for i,v in pairs(properties) do
		pcall(function()
			instance[i] = v;
		end);
	end;
	return instance;
end;
UI.Scale = function(parent, properties)
	properties = properties or {};

	local instance = Instance.new("UIScale", parent);
	instance.Name = "UIScale";
	instance.Scale = 1;
	for i,v in pairs(properties) do
		pcall(function()
			instance[i] = v;
		end);
	end;
	return instance;
end;
UI.Stroke = function(parent, properties)
	properties = properties or {};

	local instance = Instance.new("UIStroke", parent);
	instance.Name = "UIStroke";
	instance.Color = Color3.new(0, 0, 0);
	instance.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
	instance.LineJoinMode = Enum.LineJoinMode.Round;
	instance.Thickness = 1;
	instance.Transparency = 0;
	instance.Enabled = true;
	for i,v in pairs(properties) do
		pcall(function()
			instance[i] = v;
		end);
	end;
	return instance;
end;
UI.Gradient = function(parent, properties)
	properties = properties or {};

	local instance = Instance.new("UIGradient", parent);
	instance.Name = "UIGradient";
	instance.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1));
		ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1));
	});
	instance.Enabled = true;
	instance.Offset = Vector2.new(0, 0);
	instance.Rotation = 0;
	local Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0);
		NumberSequenceKeypoint.new(1, 0);
	});
	for i,v in pairs(properties) do
		pcall(function()
			instance[i] = v;
		end);
	end;
	return instance;
end;
UI.GridLayout = function(parent, properties)
	properties = properties or {};

	local instance = Instance.new("UIGridLayout", parent);
	instance.Name = " ";
	instance.CellPadding = UDim2.new(0, 2, 0, 2);
	instance.CellSize = UDim2.new(0, 100, 0, 100);
	instance.FillDirection = Enum.FillDirection.Horizontal;
	instance.FillDirectionMaxCells = 0;
	instance.HorizontalAlignment = Enum.HorizontalAlignment.Left;
	instance.SortOrder = Enum.SortOrder.LayoutOrder;
	instance.StartCorner = Enum.StartCorner.TopLeft;
	instance.VerticalAlignment = Enum.VerticalAlignment.Top;
	for i,v in pairs(properties) do
		pcall(function()
			instance[i] = v;
		end);
	end;
	return instance;
end;
UI.ListLayout = function(parent, properties)
	properties = properties or {};

	local instance = Instance.new("UIListLayout", parent);
	instance.Name = " ";
	instance.Padding = UDim.new(0, 0);
	instance.FillDirection = Enum.FillDirection.Vertical;
	instance.HorizontalAlignment = Enum.HorizontalAlignment.Left;
	instance.SortOrder = Enum.SortOrder.LayoutOrder;
	instance.VerticalAlignment = Enum.VerticalAlignment.Top;
	for i,v in pairs(properties) do
		pcall(function()
			instance[i] = v;
		end);
	end;
	return instance;
end;
UI.PageLayout = function(parent, properties)
	properties = properties or {};

	local instance = Instance.new("UIPageLayout", parent);
	instance.Name = " ";
	instance.Animated = true;
	instance.Circular = false;
	instance.EasingDirection = Enum.EasingDirection.Out;
	instance.EasingStyle = Enum.EasingStyle.Sine;
	instance.Padding = UDim.new(0, 0);
	instance.TweenTime = 1;
	instance.FillDirection = Enum.FillDirection.Horizontal;
	instance.HorizontalAlignment = Enum.HorizontalAlignment.Left;
	instance.SortOrder = Enum.SortOrder.LayoutOrder;
	instance.VerticalAlignment = Enum.VerticalAlignment.Top;
	for i,v in pairs(properties) do
		pcall(function()
			instance[i] = v;
		end);
	end;
	return instance;
end;
-- // Custom
UI.Dragify = function(Button, Frame)
	Frame = Frame or Button
	local dragToggle = false;
	local dragInput;
	local dragStart;
	local dragPos;
	local startPos;
	local cons = {};
	local tw = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out);

	local function updateInput(input)
		local Delta = input.Position - dragStart;
		local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y);
		--Frame.Position = Position;
		local anim = TweenService:Create(Frame, tw, {
			Position = Position;
		});
		anim:Play();
		spawn(function()
			anim.Completed:Wait();
			anim:Destroy();
		end);
	end;

	cons[1] = Button.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
			dragToggle = true;
			dragStart = input.Position;
			startPos = Frame.Position;
			if not cons[4] then
				cons[4] = input.Changed:Connect(function()
					if (input.UserInputState == Enum.UserInputState.End) then
						dragToggle = false;
						cons[4]:Disconnect();
						cons[4] = nil;
					end;
				end);
			end;
		end;
	end);

	cons[2] = Button.InputChanged:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			dragInput = input;
		end;
	end);

	cons[3] = UserInputService.InputChanged:Connect(function(input)
		if (input == dragInput and dragToggle) then
			updateInput(input);
		end;
	end);

	Button.Destroying:Connect(function()
		for i,v in pairs(cons) do
			pcall(function() cons[i]:Disconnect() end)
		end;
		cons = {};
	end);
end;

getgenv().EasyUI = {
    Library = UI;
    Destroy = function()
        getgenv().EasyUI = nil;
    end;
};
return getgenv().EasyUI;
