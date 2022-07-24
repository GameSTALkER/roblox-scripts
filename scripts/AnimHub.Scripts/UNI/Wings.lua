
--[[ 200rbx
https://www.roblox.com/catalog/6203658105/Black-Metal-Left-Wing
https://www.roblox.com/catalog/6203659107/Black-Metal-Right-Wing
]]
--loadstring(game:HttpGet("https://raw.githubusercontent.com/GameSTALkER/ngstloader/main/scripts/AnimHub.Scripts/Universal/netless.lua"))()
   
local settings = {
    -- core settings
    debug = true; -- print information in console
    bloxify = false; -- from normal UGS to gray block (R6 only)
    speed = 100;
    start_from_end = false;
    isR15allowed = true;
    
    R6WeldPart = "Torso"; -- weld wings to part named as ...
    R15WeldPart = "UpperTorso"; -- attach to part if R15 RigType
    
    -- script settings
}

local function debug(str) if settings.debug then print(tostring(str)) end end

local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character
if Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
    if not settings.isR15allowed then warn("R15 is not allowed!"); return end
    settings.R6WeldPart = settings.R15WeldPart
    
end

--[[getgenv().]]Hats = {[1] = {}, [2] = {}}

for i,v in pairs(Character:GetChildren()) do
    if v.ClassName == "Accessory" and v.Name == "black metal wings" then
        table.insert(--[[getgenv().]]Hats[1],v)
        debug(v.Name.." added to --[[getgenv().]]Hats[1]")
        
    end
    
end

if settings.start_from_end then
    local temp = --[[getgenv().]]Hats[1]
    --[[getgenv().]]Hats[1] = {}
    for i=1, #temp do
        table.insert(--[[getgenv().]]Hats[1],temp[#temp + 1 - i])
    end

end

for i,v in next, --[[getgenv().]]Hats[1] do
    v.Handle.AccessoryWeld:Remove()
    if settings.bloxify then
        for _,mesh in next, v:GetDescendants() do
            if mesh:IsA("Mesh") or mesh:IsA("SpecialMesh") then
                mesh:Remove()
                
            end
            
        end
        
    end
    
end

--[[getgenv().]]HatManage = function(num, callback)
    callback = callback or function() end
    for i,v in pairs(--[[getgenv().]]Hats[num]) do
        local resp, err = callback(v, i)
        if not resp then debug(err) end
        
    end
    
end
do
    local num = 0;
    local toedit = {}
    
    local function align(i,v,num)
        -- Handle parent
        local att0 = Instance.new("Attachment", i.Handle) -- hat att
        att0.Position = Vector3.new(0,0,0)
        table.insert(toedit,att0)
        
        local att1 = Instance.new("Attachment", v)
        att1.Name = i.Name..num
        att1.Position = Vector3.new(0,0,0)
        table.insert(--[[getgenv().]]Hats[2],att1)
        
        -- Handle parent
        local AP = Instance.new("AlignPosition", i.Handle)
        AP.Attachment0 = att0
        AP.Attachment1 = att1
        AP.RigidityEnabled = false
        AP.ReactionForceEnabled = false
        AP.ApplyAtCenterOfMass = true
        AP.MaxForce = math.huge
        AP.MaxVelocity = math.huge
        AP.Responsiveness = settings.speed
        
        local AO = Instance.new("AlignOrientation", i.Handle)
        AO.Attachment0 = att0
        AO.Attachment1 = att1
        AO.ReactionTorqueEnabled = false
        AO.PrimaryAxisOnly = false
        AO.MaxTorque = math.huge
        AO.MaxAngularVelocity = math.huge
        AO.Responsiveness = settings.speed
        
    end
    
    --[[getgenv().]]HatManage(1, function(myhat)
        num = num + 1
        align(myhat, Character[settings.R6WeldPart], num)
        
    end)
    --[[getgenv().]]Hats[1] = toedit
end

-- END OF THE HAT REANIMATOR

--[[getgenv().]]HatManage(2, function(myhat, num)
    if num == 1 then     myhat.Rotation = Vector3.new(180,0,180);myhat.Position = Vector3.new(3,1,0)
    elseif num == 2 then myhat.Rotation = Vector3.new(180,0,180);myhat.Position = Vector3.new(-3,1,0) end
end)

if --[[getgenv().]]iuoweasefhdiuohaws9e ~= nil then --[[getgenv().]]iuoweasefhdiuohaws9e:Disconnect(); --[[getgenv().]]iuoweasefhdiuohaws9e = nil end
if --[[getgenv().]]wepoasdfgifjiw ~= nil then --[[getgenv().]]wepoasdfgifjiw:Disconnect(); --[[getgenv().]]wepoasdfgifjiw = nil end

--[[getgenv().]]HatManage(2, function(myhat, num)
    if num == 1 then     myhat.Rotation = Vector3.new(180,0,180);myhat.Position = Vector3.new(3,1,0)
    elseif num == 2 then myhat.Rotation = Vector3.new(180,0,180);myhat.Position = Vector3.new(-3,1,0) end
end)
            
local q = {[1]=true,[2]=false,[3]=false,[4]=false}
local a = 1
--[[getgenv().]]iuoweasefhdiuohaws9e = game:GetService("UserInputService").InputBegan:Connect(function(key,enter)
    if enter then return end
    key = key.KeyCode.Name:lower()
    
    if key == "q" then
        if a == 1 then q[1] = not q[1] end
        a = 1
        if q[1] then
            --[[getgenv().]]HatManage(2, function(myhat, num)
                if num == 1 then     myhat.Rotation = Vector3.new(180,0,180);myhat.Position = Vector3.new(3,1,0)
                elseif num == 2 then myhat.Rotation = Vector3.new(180,0,180);myhat.Position = Vector3.new(-3,1,0) end
            end)
        else
            --[[getgenv().]]HatManage(2, function(myhat, num)
                if num == 1 then     myhat.Rotation = Vector3.new(180,0,230);myhat.Position = Vector3.new(2.7,-1,0)
                elseif num == 2 then myhat.Rotation = Vector3.new(180,0,130);myhat.Position = Vector3.new(-2.7,-1,0) end
            end)
        end
    elseif key == "e" then
        if a == 2 then q[2] = not q[2] end
        a = 2
        if q[2] then
            --[[getgenv().]]HatManage(2, function(myhat, num)
                if num == 1 then     myhat.Rotation = Vector3.new(120,0,180);myhat.Position = Vector3.new(3,0,-0.2)
                elseif num == 2 then myhat.Rotation = Vector3.new(120,0,180);myhat.Position = Vector3.new(-3,0,-0.2) end
            end)
        else
            --[[getgenv().]]HatManage(2, function(myhat, num)
                if num == 1 then     myhat.Rotation = Vector3.new(120,-30,180);myhat.Position = Vector3.new(2.4,-1,-0.8)
                elseif num == 2 then myhat.Rotation = Vector3.new(120,30,180);myhat.Position = Vector3.new(-2.4,-1,-0.8) end
            end)
        end
    elseif key == "r" then
        if a == 3 then q[3] = not q[3] end
        a = 3
        if q[3] then
            --[[getgenv().]]HatManage(2, function(myhat, num)
                if num == 1 then     myhat.Rotation = Vector3.new(150,-60,180);myhat.Position = Vector3.new(1,0,-1.7)
                elseif num == 2 then myhat.Rotation = Vector3.new(150,60,180);myhat.Position = Vector3.new(-1,0,-1.7) end
            end)
        else
            --[[getgenv().]]HatManage(2, function(myhat, num)
                if num == 1 then     myhat.Rotation = Vector3.new(150,60,180);myhat.Position = Vector3.new(3,2,1.9)
                elseif num == 2 then myhat.Rotation = Vector3.new(150,-60,180);myhat.Position = Vector3.new(-3,2,1.9) end
            end)
        end
    elseif key == "t" then
        if a == 4 then q[4] = not q[4] end
        a = 4
        if q[4] then
            --[[getgenv().]]HatManage(2, function(myhat, num)
                if num == 1 then     myhat.Rotation = Vector3.new(110,-35,70);myhat.Position = Vector3.new(0.5,2.5,-2)
                elseif num == 2 then myhat.Rotation = Vector3.new(100,33,310);myhat.Position = Vector3.new(-0.5,2.3,-2) end
            end)
        else
            --[[getgenv().]]HatManage(2, function(myhat, num)
                if num == 1 then     myhat.Rotation = Vector3.new(100,-30,60);myhat.Position = Vector3.new(0.5,2,-0.5)
                elseif num == 2 then myhat.Rotation = Vector3.new(90,25,300);myhat.Position = Vector3.new(-0.5,1.8,-0.5) end
            end)
        end
    end

end)

--[[getgenv().]]wepoasdfgifjiw = game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").Died:Connect(function()
    --[[getgenv().]]iuoweasefhdiuohaws9e:Disconnect(); --[[getgenv().]]iuoweasefhdiuohaws9e = nil
    --[[getgenv().]]wepoasdfgifjiw:Disconnect(); --[[getgenv().]]wepoasdfgifjiw = nil

end)
