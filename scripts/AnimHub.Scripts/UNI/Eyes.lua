
local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character

local Hats = {[1] = {}, [2] = {}}
local topart = {Character.Head}

for i,v in pairs(Character:GetChildren()) do
    if v.ClassName == "Accessory" and v.Name == "Eyes" then
        table.insert(Hats[1],v)
        print(v.Name.." added to Hats[1]")
        
    end
    
end

HatManage = function(num, callback)
    callback = callback or function() end
    for i,v in pairs(Hats[num]) do
        local resp, err = pcall(callback, v, i)
        if not resp then print(err) end
        
    end
    
end
do
    local num = 0;
    local toedit = {}
    
    local function align(i,v)

        local att0 = Instance.new("Attachment", i.Handle) -- hat att
        att0.Position = Vector3.new(0,0,0)
        table.insert(toedit,att0)
        
        local att1 = Instance.new("Attachment", v)
        att1.Name = i.Name..num
        att1.Position = Vector3.new(0,0,0)
        table.insert(Hats[2],att1)
        
        -- Handle parent
        local AP = Instance.new("AlignPosition", i.Handle)
        AP.Attachment0 = att0
        AP.Attachment1 = att1
        AP.RigidityEnabled = false
        AP.ReactionForceEnabled = false
        AP.ApplyAtCenterOfMass = true
        AP.MaxForce = math.huge
        AP.MaxVelocity = math.huge
        AP.Responsiveness = 1500 -- 175
        
        local AO = Instance.new("AlignOrientation", i.Handle)
        AO.Attachment0 = att0
        AO.Attachment1 = att1
        AO.ReactionTorqueEnabled = false
        AO.PrimaryAxisOnly = false
        AO.MaxTorque = math.huge
        AO.MaxAngularVelocity = math.huge
        AO.Responsiveness = 1500 -- 100

        pcall(function() i.Handle.AccessoryWeld:Remove() end)
        
    end
    
    HatManage(1, function(myhat)
        num = num + 1
        align(myhat, topart[num])
        
    end)
    Hats[1] = toedit
end

HatManage(2, function(myhat) -- position
    if myhat.Name:lower():find("eyes") then myhat.Position = Vector3.new(0,0.15,-0.5)
    end
    
end)

local Head = Character:WaitForChild("Head")

if getgenv().ou3e4wasvdkuxBAIoNST ~= nil then getgenv().ou3e4wasvdkuxBAIoNST:Disconnect() end
getgenv().ou3e4wasvdkuxBAIoNST = game:GetService("RunService").RenderStepped:Connect(function() 
    local m = Player:GetMouse()
    local x = 35
    HatManage(2, function(myhat) -- rotation
        if myhat.Name:lower():find("eyes") then 
            myhat.Rotation = Vector3.new(-((m.Y-(m.ViewSizeY/2))/(x/2)),-((m.X-(m.ViewSizeX/2))/x),0) -- idk how to do better...
            
        end
        
    end)
    
end)

local toggle = true
if getgenv().oihegiulelowepojuU89 ~= nil then getgenv().oihegiulelowepojuU89:Disconnect() end
getgenv().oihegiulelowepojuU89 = game:GetService("UserInputService").InputBegan:Connect(function(key,enter)
    if enter then return end
    key = key.KeyCode.Name:lower()


    if key == "e" then
        local value = -30
        toggle = not toggle
        if toggle then value = 0.15 end
        HatManage(2, function(myhat)
            if myhat.Name:lower():find("eyes") then myhat.Position = Vector3.new(0,value,-0.5)
            end
            
        end)

    end

end)
if getgenv().we98uasehdfiouw ~= nil then getgenv().we98uasehdfiouw:Disconnect() end
getgenv().we98uasehdfiouw = Player.Character:WaitForChild("Humanoid").Died:Connect(function() -- remove connections on death
    getgenv().oihegiulelowepojuU89:Disconnect(); getgenv().oihegiulelowepojuU89 = nil
    getgenv().ou3e4wasvdkuxBAIoNST:Disconnect(); getgenv().ou3e4wasvdkuxBAIoNST = nil
    getgenv().we98uasehdfiouw:Disconnect(); getgenv().we98uasehdfiouw = nil

end)
