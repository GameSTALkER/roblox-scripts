
local settings = {
    WeldPart = "Torso", -- weld pp to part named as ...

    hiden = Vector3.new(0,-10,0),
    drag = Vector3.new(0,0,0),
    
    balls = {
        [1] = Vector3.new(0.4,-1.3,-0.5),
        [2] = Vector3.new(-0.4,-1.3,-0.5)
        
    },
    pos = {
        [1] = Vector3.new(0,-1.1,-1),
        [2] = Vector3.new(0,-10,0),
        [3] = Vector3.new(0,0,0),
        [4] = Vector3.new(0,0,0),
        [5] = Vector3.new(0,0,0),
        [6] = Vector3.new(0,0,0),
        [7] = Vector3.new(0,0,0),
        [8] = Vector3.new(0,0,0)
    }
    
}

local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character
if Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
    settings.WeldPart = "HumanoidRootPart"
    
end

local Hats = {[1] = {}, [2] = {}}

for i,v in pairs(Character:GetChildren()) do
    if v.ClassName == "Accessory" and (v.Name == "MeshPartAccessory" or v.Name == "InternationalFedora" or v.Name == "International Fedora") then
        table.insert(Hats[1],v)
        print(v.Name.." added to Hats[1]")
        
    end
    
end

for i,v in next, Hats[1] do
    v.Handle.AccessoryWeld:Remove()
    for _,mesh in next, v:GetDescendants() do
        if mesh:IsA("Mesh") or mesh:IsA("SpecialMesh") then
            mesh:Remove()
            
        end
        
    end
    
end
    
HatManage = function(num, callback)
    callback = callback or function() end
    for i,v in pairs(Hats[num]) do
        local resp, err = callback(v, i)
        if not resp then print(err) end
        
    end
    
end
do
    local lastparent = nil;
    local num = 0;
    local toedit = {}
    
    local function align(i,v,num)
        -- Handle parent
        local att0 = Instance.new("Attachment", i.Handle) -- hat att
        att0.Position = Vector3.new(0,0,0)
        table.insert(toedit,att0)
        
        -- dynamic parent or idk
        if lastparent == nil then lastparent = v end
        local att1 = Instance.new("Attachment", lastparent)
        att1.Name = i.Name..num
        att1.Position = Vector3.new(0,0,0)
        table.insert(Hats[2],att1)
        if num > 2 then lastparent = i.Handle end
        
        -- Handle parent
        local AP = Instance.new("AlignPosition", i.Handle)
        AP.Attachment0 = att0
        AP.Attachment1 = att1
        AP.RigidityEnabled = false
        AP.ReactionForceEnabled = false
        AP.ApplyAtCenterOfMass = true
        AP.MaxForce = math.huge
        AP.MaxVelocity = math.huge
        AP.Responsiveness = 175
        
        local AO = Instance.new("AlignOrientation", i.Handle)
        AO.Attachment0 = att0
        AO.Attachment1 = att1
        AO.ReactionTorqueEnabled = false
        AO.PrimaryAxisOnly = false
        AO.MaxTorque = math.huge
        AO.MaxAngularVelocity = math.huge
        AO.Responsiveness = 100
        
    end
    
    HatManage(1, function(myhat)
        num = num + 1
        align(myhat, Character[settings.WeldPart], num)
        
    end)
    Hats[1] = toedit
end

local function returnpp()
    HatManage(2, function(myhat, num)
        if num ~= 1 and num ~= 2 then 
            myhat.Position = settings.pos[(num - 2)]
            
        end

    end)
    
end

local mode = 1
local active = ""
local toggles = {
    E = false,
    Position = {false,false,false,false,false,false,false,false,false,false},
    Rotation = {false,false,false,false,false,false,false,false,false,false}

}
local function Frames(key)
    if key == "zero" then -- hide penis
        HatManage(2, function(myhat, num)
            if num == 1 then     myhat.Position = settings.hiden -- ball 1
            elseif num == 2 then myhat.Position = settings.hiden -- ball 2
            elseif num == 3 then myhat.Position = settings.hiden
            elseif num == 4 then myhat.Position = Vector3.new(0,0,0)
            elseif num == 5 then myhat.Position = Vector3.new(0,0,0)
            elseif num == 6 then myhat.Position = Vector3.new(0,0,0)
            elseif num == 7 then myhat.Position = Vector3.new(0,0,0)
            elseif num == 8 then myhat.Position = Vector3.new(0,0,0)
            elseif num == 9 then myhat.Position = Vector3.new(0,0,0)
            elseif num == 10 then myhat.Position= Vector3.new(0,0,0) end

        end)

    elseif mode == 1 then
        if key == "one" then
            HatManage(2, function(myhat, num)
                if num == 1 then     myhat.Position = settings.balls[1] -- ball 1
                elseif num == 2 then myhat.Position = settings.balls[2] -- ball 2
                elseif num == 3 then myhat.Position = Vector3.new(0,-1.1,-1);settings.pos[1] = Vector3.new(0,-1.1,-1)
                elseif num == 4 then myhat.Position = settings.hiden;settings.pos[2] = settings.hiden
                elseif num == 5 then myhat.Position = Vector3.new(0,0,0);settings.pos[3] = Vector3.new(0,0,0)
                elseif num == 6 then myhat.Position = Vector3.new(0,0,0);settings.pos[4] = Vector3.new(0,0,0)
                elseif num == 7 then myhat.Position = Vector3.new(0,0,0);settings.pos[5] = Vector3.new(0,0,0)
                elseif num == 8 then myhat.Position = Vector3.new(0,0,0);settings.pos[6] = Vector3.new(0,0,0)
                elseif num == 9 then myhat.Position = Vector3.new(0,0,0);settings.pos[7] = Vector3.new(0,0,0)
                elseif num == 10 then myhat.Position= Vector3.new(0,0,0);settings.pos[8] = Vector3.new(0,0,0) end

            end)
        
        elseif key == "two" then
            HatManage(2, function(myhat, num)
                if num == 1 then     myhat.Position = settings.balls[1] -- ball 1
                elseif num == 2 then myhat.Position = settings.balls[2] -- ball 2
                elseif num == 3 then myhat.Position = Vector3.new(0,-1.1,-1);settings.pos[1] = Vector3.new(0,-1.1,-1)
                elseif num == 4 then myhat.Position = Vector3.new(0,0,-0.9);settings.pos[2] = Vector3.new(0,0,-0.9)
                elseif num == 5 then myhat.Position = settings.hiden;settings.pos[3] = settings.hiden
                elseif num == 6 then myhat.Position = Vector3.new(0,0,0);settings.pos[4] = Vector3.new(0,0,0)
                elseif num == 7 then myhat.Position = Vector3.new(0,0,0);settings.pos[5] = Vector3.new(0,0,0)
                elseif num == 8 then myhat.Position = Vector3.new(0,0,0);settings.pos[6] = Vector3.new(0,0,0)
                elseif num == 9 then myhat.Position = Vector3.new(0,0,0);settings.pos[7] = Vector3.new(0,0,0)
                elseif num == 10 then myhat.Position= Vector3.new(0,0,0);settings.pos[8] = Vector3.new(0,0,0) end

            end)

        elseif key == "three" then
            HatManage(2, function(myhat, num)
                if num == 1 then     myhat.Position = settings.balls[1] -- ball 1
                elseif num == 2 then myhat.Position = settings.balls[2] -- ball 2
                elseif num == 3 then myhat.Position = Vector3.new(0,-1.1,-1);settings.pos[1] = Vector3.new(0,-1.1,-1)
                elseif num == 4 then myhat.Position = Vector3.new(0,0,-0.9);settings.pos[2] = Vector3.new(0,0,-0.9)
                elseif num == 5 then myhat.Position = Vector3.new(0,0,-0.9);settings.pos[3] = Vector3.new(0,0,-0.9)
                elseif num == 6 then myhat.Position = settings.hiden;settings.pos[4] = settings.hiden
                elseif num == 7 then myhat.Position = Vector3.new(0,0,0);settings.pos[5] = Vector3.new(0,0,0)
                elseif num == 8 then myhat.Position = Vector3.new(0,0,0);settings.pos[6] = Vector3.new(0,0,0)
                elseif num == 9 then myhat.Position = Vector3.new(0,0,0);settings.pos[7] = Vector3.new(0,0,0)
                elseif num == 10 then myhat.Position= Vector3.new(0,0,0);settings.pos[8] = Vector3.new(0,0,0) end

            end)

        elseif key == "four" then
            HatManage(2, function(myhat, num)
                if num == 1 then     myhat.Position = settings.balls[1] -- ball 1
                elseif num == 2 then myhat.Position = settings.balls[2] -- ball 2
                elseif num == 3 then myhat.Position = Vector3.new(0,-1.1,-1);settings.pos[1] = Vector3.new(0,-1.1,-1)
                elseif num == 4 then myhat.Position = Vector3.new(0,0,-0.9);settings.pos[2] = Vector3.new(0,0,-0.9)
                elseif num == 5 then myhat.Position = Vector3.new(0,0,-0.9);settings.pos[3] = Vector3.new(0,0,-0.9)
                elseif num == 6 then myhat.Position = Vector3.new(0,0,-0.9);settings.pos[4] = Vector3.new(0,0,-0.9)
                elseif num == 7 then myhat.Position = settings.hiden;settings.pos[5] = settings.hiden
                elseif num == 8 then myhat.Position = Vector3.new(0,0,0);settings.pos[6] = Vector3.new(0,0,0)
                elseif num == 9 then myhat.Position = Vector3.new(0,0,0);settings.pos[7] = Vector3.new(0,0,0)
                elseif num == 10 then myhat.Position= Vector3.new(0,0,0);settings.pos[8] = Vector3.new(0,0,0) end

            end)

        elseif key == "five" then
            HatManage(2, function(myhat, num)
                if num == 1 then     myhat.Position = settings.balls[1] -- ball 1
                elseif num == 2 then myhat.Position = settings.balls[2] -- ball 2
                elseif num == 3 then myhat.Position = Vector3.new(0,-1.1,-1);settings.pos[1] = Vector3.new(0,-1.1,-1)
                elseif num == 4 then myhat.Position = Vector3.new(0,0,-0.9);settings.pos[2] = Vector3.new(0,0,-0.9)
                elseif num == 5 then myhat.Position = Vector3.new(0,0,-0.9);settings.pos[3] = Vector3.new(0,0,-0.9)
                elseif num == 6 then myhat.Position = Vector3.new(0,0,-0.9);settings.pos[4] = Vector3.new(0,0,-0.9)
                elseif num == 7 then myhat.Position = Vector3.new(0,0,-0.9);settings.pos[5] = Vector3.new(0,0,-0.9)
                elseif num == 8 then myhat.Position = settings.hiden;settings.pos[6] = settings.hiden
                elseif num == 9 then myhat.Position = Vector3.new(0,0,0);settings.pos[7] = Vector3.new(0,0,0)
                elseif num == 10 then myhat.Position= Vector3.new(0,0,0);settings.pos[8] = Vector3.new(0,0,0) end

            end)

        elseif key == "six" then
            HatManage(2, function(myhat, num)
                if num == 1 then     myhat.Position = settings.balls[1] -- ball 1
                elseif num == 2 then myhat.Position = settings.balls[2] -- ball 2
                elseif num == 3 then myhat.Position = Vector3.new(0,-1.1,-1);settings.pos[1] = Vector3.new(0,-1.1,-1)
                elseif num == 4 then myhat.Position = Vector3.new(0,0,-0.9);settings.pos[2] = Vector3.new(0,0,-0.9)
                elseif num == 5 then myhat.Position = Vector3.new(0,0,-0.9);settings.pos[3] = Vector3.new(0,0,-0.9)
                elseif num == 6 then myhat.Position = Vector3.new(0,0,-0.9);settings.pos[4] = Vector3.new(0,0,-0.9)
                elseif num == 7 then myhat.Position = Vector3.new(0,0,-0.9);settings.pos[5] = Vector3.new(0,0,-0.9)
                elseif num == 8 then myhat.Position = Vector3.new(0,0,-0.9);settings.pos[6] = Vector3.new(0,0,-0.9)
                elseif num == 9 then myhat.Position = settings.hiden;settings.pos[7] = settings.hiden
                elseif num == 10 then myhat.Position= Vector3.new(0,0,0);settings.pos[8] = Vector3.new(0,0,0) end

            end)

        elseif key == "seven" then
            HatManage(2, function(myhat, num)
                if num == 1 then     myhat.Position = settings.balls[1] -- ball 1
                elseif num == 2 then myhat.Position = settings.balls[2] -- ball 2
                elseif num == 3 then myhat.Position = Vector3.new(0,-1.1,-1);settings.pos[1] = Vector3.new(0,-1.1,-1)
                elseif num == 4 then myhat.Position = Vector3.new(0,0,-0.9);settings.pos[2] = Vector3.new(0,0,-0.9)
                elseif num == 5 then myhat.Position = Vector3.new(0,0,-0.9);settings.pos[3] = Vector3.new(0,0,-0.9)
                elseif num == 6 then myhat.Position = Vector3.new(0,0,-0.9);settings.pos[4] = Vector3.new(0,0,-0.9)
                elseif num == 7 then myhat.Position = Vector3.new(0,0,-0.9);settings.pos[5] = Vector3.new(0,0,-0.9)
                elseif num == 8 then myhat.Position = Vector3.new(0,0,-0.9);settings.pos[6] = Vector3.new(0,0,-0.9)
                elseif num == 9 then myhat.Position = Vector3.new(0,0,-0.9);settings.pos[7] = Vector3.new(0,0,-0.9)
                elseif num == 10 then myhat.Position= settings.hiden;settings.pos[8] = settings.hiden end

            end)

        elseif key == "eight" then
            HatManage(2, function(myhat, num)
                if num == 1 then     myhat.Position = settings.balls[1] -- ball 1
                elseif num == 2 then myhat.Position = settings.balls[2] -- ball 2
                elseif num == 3 then myhat.Position = Vector3.new(0,-1.1,-1);settings.pos[1] = Vector3.new(0,-1.1,-1)
                elseif num == 4 then myhat.Position = Vector3.new(0,0,-0.9);settings.pos[2] = Vector3.new(0,0,-0.9)
                elseif num == 5 then myhat.Position = Vector3.new(0,0,-0.9);settings.pos[3] = Vector3.new(0,0,-0.9)
                elseif num == 6 then myhat.Position = Vector3.new(0,0,-0.9);settings.pos[4] = Vector3.new(0,0,-0.9)
                elseif num == 7 then myhat.Position = Vector3.new(0,0,-0.9);settings.pos[5] = Vector3.new(0,0,-0.9)
                elseif num == 8 then myhat.Position = Vector3.new(0,0,-0.9);settings.pos[6] = Vector3.new(0,0,-0.9)
                elseif num == 9 then myhat.Position = Vector3.new(0,0,-0.9);settings.pos[7] = Vector3.new(0,0,-0.9)
                elseif num == 10 then myhat.Position= Vector3.new(0,0,-0.9);settings.pos[8] = Vector3.new(0,0,-0.9) end

            end)

        elseif key == "nine" then
            HatManage(2, function(myhat, num)
                if num == 1 then     myhat.Position = Vector3.new(0,-1.1,-0.9) -- ball 1
                elseif num == 2 then myhat.Position = Vector3.new(0,-1.1,-1.8) -- ball 2
                elseif num == 3 then myhat.Position = Vector3.new(0,-1.1,-2.7)
                elseif num == 4 then myhat.Position = Vector3.new(0,0,-0.9)
                elseif num == 5 then myhat.Position = Vector3.new(0,0,-0.9)
                elseif num == 6 then myhat.Position = Vector3.new(0,0,-0.9)
                elseif num == 7 then myhat.Position = Vector3.new(0,0,-0.9)
                elseif num == 8 then myhat.Position = Vector3.new(0,0,-0.9)
                elseif num == 9 then myhat.Position = Vector3.new(0,0,-0.9)
                elseif num == 10 then myhat.Position= Vector3.new(0,0,-0.9) end

            end)

        end

    elseif mode == 2 then
        Hats[2][1].Position = settings.balls[1]
        Hats[2][2].Position = settings.balls[2]
        returnpp()
        if key == "one" then
            if active == "R1" then toggles.Rotation[1] = not toggles.Rotation[1] end
            active = "R1"
            if toggles.Rotation[1] then
                HatManage(2, function(myhat, num)
                    if num == 3 then myhat.Rotation     = Vector3.new(0,0,0); settings.drag = Vector3.new(0,0,0)
                    elseif num == 4 then myhat.Rotation = Vector3.new(-2,0,0)
                    elseif num == 5 then myhat.Rotation = Vector3.new(-2,0,0)
                    elseif num == 6 then myhat.Rotation = Vector3.new(-2,0,0)
                    elseif num == 7 then myhat.Rotation = Vector3.new(-2,0,0)
                    elseif num == 8 then myhat.Rotation = Vector3.new(-2,0,0)
                    elseif num == 9 then myhat.Rotation = Vector3.new(-2,0,0)
                    elseif num == 10 then myhat.Rotation= Vector3.new(-2,0,0) end

                end)

            else
                HatManage(2, function(myhat, num)
                    if num == 3 then myhat.Rotation     = Vector3.new(0,0,0); settings.drag = Vector3.new(0,0,0)
                    elseif num == 4 then myhat.Rotation = Vector3.new(2,0,0)
                    elseif num == 5 then myhat.Rotation = Vector3.new(2,0,0)
                    elseif num == 6 then myhat.Rotation = Vector3.new(2,0,0)
                    elseif num == 7 then myhat.Rotation = Vector3.new(2,0,0)
                    elseif num == 8 then myhat.Rotation = Vector3.new(2,0,0)
                    elseif num == 9 then myhat.Rotation = Vector3.new(2,0,0)
                    elseif num == 10 then myhat.Rotation= Vector3.new(2,0,0) end

                end)

            end

        elseif key == "two" then
            if active == "R2" then toggles.Rotation[2] = not toggles.Rotation[2] end
            active = "R2"
            if toggles.Rotation[2] then
                HatManage(2, function(myhat, num)
                    if num == 3 then myhat.Rotation     = Vector3.new(5,0,0); settings.drag = Vector3.new(5,0,0)
                    elseif num == 4 then myhat.Rotation = Vector3.new(5,0,0)
                    elseif num == 5 then myhat.Rotation = Vector3.new(5,0,0)
                    elseif num == 6 then myhat.Rotation = Vector3.new(4,0,0)
                    elseif num == 7 then myhat.Rotation = Vector3.new(4,0,0)
                    elseif num == 8 then myhat.Rotation = Vector3.new(4,0,0)
                    elseif num == 9 then myhat.Rotation = Vector3.new(3,0,0)
                    elseif num == 10 then myhat.Rotation= Vector3.new(2,0,0) end
    
                end)
            else
                HatManage(2, function(myhat, num)
                    if num == 3 then myhat.Rotation     = Vector3.new(24,0,0); settings.drag = Vector3.new(24,0,0)
                    elseif num == 4 then myhat.Rotation = Vector3.new(6,0,0)
                    elseif num == 5 then myhat.Rotation = Vector3.new(2,0,0)
                    elseif num == 6 then myhat.Rotation = Vector3.new(-2,0,0)
                    elseif num == 7 then myhat.Rotation = Vector3.new(-6,0,0)
                    elseif num == 8 then myhat.Rotation = Vector3.new(-6,0,0)
                    elseif num == 9 then myhat.Rotation = Vector3.new(-6,0,0)
                    elseif num == 10 then myhat.Rotation= Vector3.new(-12,0,0) end
        
                end)
            end

        elseif key == "three" then
            if active == "R3" then toggles.Rotation[3] = not toggles.Rotation[3] end
            active = "R3"
            if toggles.Rotation[3] then
                HatManage(2, function(myhat, num)
                    if num == 3 then myhat.Rotation     = Vector3.new(45,0,0); settings.drag = Vector3.new(45,0,0)
                    elseif num == 4 then myhat.Rotation = Vector3.new(5,0,0)
                    elseif num == 5 then myhat.Rotation = Vector3.new(5,0,0)
                    elseif num == 6 then myhat.Rotation = Vector3.new(4,0,0)
                    elseif num == 7 then myhat.Rotation = Vector3.new(4,0,0)
                    elseif num == 8 then myhat.Rotation = Vector3.new(4,0,0)
                    elseif num == 9 then myhat.Rotation = Vector3.new(3,0,0)
                    elseif num == 10 then myhat.Rotation= Vector3.new(2,0,0) end
        
                end)
                
            else
                HatManage(2, function(myhat, num)
                    if num == 3 then myhat.Rotation     = Vector3.new(45,0,0); settings.drag = Vector3.new(45,0,0)
                    elseif num == 4 then myhat.Rotation = Vector3.new(45,15,0)
                    elseif num == 5 then myhat.Rotation = Vector3.new(0,40,0)
                    elseif num == 6 then myhat.Rotation = Vector3.new(0,-45,0)
                    elseif num == 7 then myhat.Rotation = Vector3.new(0,-45,0)
                    elseif num == 8 then myhat.Rotation = Vector3.new(0,-45,0)
                    elseif num == 9 then myhat.Rotation = Vector3.new(0,-45,0)
                    elseif num == 10 then myhat.Rotation= Vector3.new(0,-45,0) end
        
                end)
                
            end

        elseif key == "four" then
            if active == "R4" then toggles.Rotation[4] = not toggles.Rotation[4] end
            active = "R4"
            if toggles.Rotation[4] then
                HatManage(2, function(myhat, num)
                    if num == 3 then myhat.Rotation     = Vector3.new(83,0,0); settings.drag = Vector3.new(83,0,0)
                    elseif num == 4 then myhat.Rotation = Vector3.new(5,0,0)
                    elseif num == 5 then myhat.Rotation = Vector3.new(6,0,0)
                    elseif num == 6 then myhat.Rotation = Vector3.new(3,0,0)
                    elseif num == 7 then myhat.Rotation = Vector3.new(80,0,0)
                    elseif num == 8 then myhat.Rotation = Vector3.new(4,0,0)
                    elseif num == 9 then myhat.Rotation = Vector3.new(65,0,0)
                    elseif num == 10 then myhat.Rotation= Vector3.new(5,0,0) end
        
                end)
                
            else
                HatManage(2, function(myhat, num)
                    if num == 3 then myhat.Rotation     = Vector3.new(83,30,-5); settings.drag = Vector3.new(83,30,-5)
                    elseif num == 4 then myhat.Rotation = Vector3.new(5,-5,5)
                    elseif num == 5 then myhat.Rotation = Vector3.new(6,-6,5)
                    elseif num == 6 then myhat.Rotation = Vector3.new(80,1,25)
                    elseif num == 7 then myhat.Rotation = Vector3.new(10,0,0)
                    elseif num == 8 then myhat.Rotation = Vector3.new(65,0,0)
                    elseif num == 9 then myhat.Rotation = Vector3.new(30,0,0)
                    elseif num == 10 then myhat.Rotation= Vector3.new(-8,0,0) end
        
                end)
            
            end

        elseif key == "five" then
            if active == "R5" then toggles.Rotation[5] = not toggles.Rotation[8] end
            active = "R5"
            HatManage(2, function(myhat, num)
                if num == 3 then myhat.Rotation     = Vector3.new(0,0,0); settings.drag = Vector3.new(0,0,0)
                elseif num == 4 then myhat.Rotation = Vector3.new(-2,0,0)
                elseif num == 5 then myhat.Rotation = Vector3.new(-2,0,0)
                elseif num == 6 then myhat.Rotation = Vector3.new(-2,0,0)
                elseif num == 7 then myhat.Rotation = Vector3.new(-2,0,0)
                elseif num == 8 then myhat.Rotation = Vector3.new(-2,0,0)
                elseif num == 9 then myhat.Rotation = Vector3.new(-2,0,0)
                elseif num == 10 then myhat.Rotation= Vector3.new(-2,0,0) end

            end)

        elseif key == "six" then
            if active == "R6" then toggles.Rotation[6] = not toggles.Rotation[6] end
            active = "R6"
            HatManage(2, function(myhat, num)
                if num == 3 then myhat.Rotation     = Vector3.new(0,0,0); settings.drag = Vector3.new(0,0,0)
                elseif num == 4 then myhat.Rotation = Vector3.new(-2,0,0)
                elseif num == 5 then myhat.Rotation = Vector3.new(-2,0,0)
                elseif num == 6 then myhat.Rotation = Vector3.new(-2,0,0)
                elseif num == 7 then myhat.Rotation = Vector3.new(-2,0,0)
                elseif num == 8 then myhat.Rotation = Vector3.new(-2,0,0)
                elseif num == 9 then myhat.Rotation = Vector3.new(-2,0,0)
                elseif num == 10 then myhat.Rotation= Vector3.new(-2,0,0) end

            end)

        elseif key == "seven" then
            if active == "R7" then toggles.Rotation[7] = not toggles.Rotation[7] end
            active = "R7"
            HatManage(2, function(myhat, num)
                if num == 3 then myhat.Rotation     = Vector3.new(0,0,0); settings.drag = Vector3.new(0,0,0)
                elseif num == 4 then myhat.Rotation = Vector3.new(-2,0,0)
                elseif num == 5 then myhat.Rotation = Vector3.new(-2,0,0)
                elseif num == 6 then myhat.Rotation = Vector3.new(-2,0,0)
                elseif num == 7 then myhat.Rotation = Vector3.new(-2,0,0)
                elseif num == 8 then myhat.Rotation = Vector3.new(-2,0,0)
                elseif num == 9 then myhat.Rotation = Vector3.new(-2,0,0)
                elseif num == 10 then myhat.Rotation= Vector3.new(-2,0,0) end

            end)

        elseif key == "eight" then
            if active == "R8" then toggles.Rotation[8] = not toggles.Rotation[8] end
            active = "R8"
            HatManage(2, function(myhat, num)
                if num == 3 then myhat.Rotation     = Vector3.new(0,0,0); settings.drag = Vector3.new(0,0,0)
                elseif num == 4 then myhat.Rotation = Vector3.new(-2,0,0)
                elseif num == 5 then myhat.Rotation = Vector3.new(-2,0,0)
                elseif num == 6 then myhat.Rotation = Vector3.new(-2,0,0)
                elseif num == 7 then myhat.Rotation = Vector3.new(-2,0,0)
                elseif num == 8 then myhat.Rotation = Vector3.new(-2,0,0)
                elseif num == 9 then myhat.Rotation = Vector3.new(-2,0,0)
                elseif num == 10 then myhat.Rotation= Vector3.new(-2,0,0) end

            end)

        end

    end

end

local ischanging = false
local isdraggable = false
local thepp;
HatManage(2, function(myhat,n)
    if n == 3 then thepp = myhat end
end)
if getgenv().iuoweasefhdiuohaws9e ~= nil then getgenv().iuoweasefhdiuohaws9e:Disconnect() end
if getgenv().wliaeilrshdfioq ~= nil then getgenv().wliaeilrshdfioq:Disconnect(); getgenv().wliaeilrshdfioq = nil end
getgenv().iuoweasefhdiuohaws9e = game:GetService("UserInputService").InputBegan:Connect(function(key,enter)
    if enter or ischanging then return end
    ischanging = true
    key = key.KeyCode.Name:lower()
    
    if table.find({"one","two","three","four","five","six","seven","eight","nine","zero"},key) then
        Frames(key)
        
    elseif key == 'q' then
        if mode == 2 then mode = 1
        else mode = mode + 1 end
    
    elseif key == "e" then
        if active == "E" then toggles["E"] = not toggles["E"] end
        active = "E"
        local rot;
        if toggles["E"] then rot = Vector3.new(0,15,0)
        else rot = Vector3.new(0,-15,0) end
        HatManage(2, function(myhat, num)
            if num == 3 then myhat.Rotation     = rot
            elseif num == 4 then myhat.Rotation = rot
            elseif num == 5 then myhat.Rotation = rot
            elseif num == 6 then myhat.Rotation = rot
            elseif num == 7 then myhat.Rotation = rot
            elseif num == 8 then myhat.Rotation = rot
            elseif num == 9 then myhat.Rotation = rot
            elseif num == 10 then myhat.Rotation= rot end

        end)

    elseif key == "r" then
        isdraggable = not isdraggable
        if isdraggable then
            getgenv().wliaeilrshdfioq = game:GetService("RunService").RenderStepped:Connect(function() 
                local m = game:GetService("Players").LocalPlayer:GetMouse()
                local x = 15
                thepp.Rotation = Vector3.new(-((m.Y-(m.ViewSizeY/2))/x),-((m.X-(m.ViewSizeX/2))/x),0) -- idk how to do better...
                
            end)

        else getgenv().wliaeilrshdfioq:Disconnect(); getgenv().wliaeilrshdfioq = nil; thepp.Rotation = settings.drag end

    end
    --wait(0.25)
    ischanging = false

end)

getgenv().wepoasdfgifjiw = Character:WaitForChild("Humanoid").Died:Connect(function()
    getgenv().iuoweasefhdiuohaws9e:Disconnect(); getgenv().iuoweasefhdiuohaws9e = nil
    getgenv().wliaeilrshdfioq:Disconnect(); getgenv().wliaeilrshdfioq = nil
    getgenv().wepoasdfgifjiw:Disconnect(); getgenv().wepoasdfgifjiw = nil

end)
