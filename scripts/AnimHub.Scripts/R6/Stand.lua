-- SETTINGS
local body_speed = 35
local hair_name = "CoolBoyHair"

-- CODE
local plr = game.Players.LocalPlayer

local last = {}
local function rePart(name,parent,pos,rot,mesh,speed)
    if name == "" then name = nil end
    if speed == nil then speed = 1000 end
    if mesh == nil then mesh = true end
    if not last[name] then last[name] = {} end
    last[name].l = parent
    last[name].p = pos
    last[name].r = rot
    last[name].s = speed
    local hat = getgenv().Accessory(name,parent,{
        debug = false; -- print some info
        bloxify = mesh; -- remove mesh
        speed = speed; -- Speed
        
        pos = pos; -- Position
        rot = rot; -- Rotation
    })
    return hat
end
local last_player = plr.Character.HumanoidRootPart
local function def_pos()
    body = rePart(
        "LongStraightHair",
        last_player,
        Vector3.new(-1.5,3,2),
        Vector3.new(-10,90,0),
        nil,
        body_speed
    )
    rock = rePart(
        "RockAccessory",
        body.Handle,
        Vector3.new(0,-0.5,0),
        Vector3.new(0,0,0)
    )
    head = rePart(
        "HairAccessory",
        body.Handle,
        Vector3.new(0,1.7,0),
        Vector3.new(0,0,0)
        
    )
    hair = rePart(
        hair_name,
        head.Handle,
        Vector3.new(0,0.5,0),
        Vector3.new(0,-90,0),
        false
    )
    r_hand = rePart(
        "Kate Hair",
        body.Handle,
        Vector3.new(0.1,0.1,1.3),
        Vector3.new(-120,-10,0)
        
    )
    l_hand = rePart(
        "Pink Hair",
        body.Handle,
        Vector3.new(0.1,0.1,-1.3),
        Vector3.new(120,10,0)
        
    )
    flag = rePart(
        "Ukranian Flag",
        body.Handle,
        Vector3.new(-2.3,1.5,1.3),
        Vector3.new(-15,0,5),
        false
        
    )
end
def_pos()

local Mouse = game.Players.LocalPlayer:GetMouse()
getgenv().KeyBind("beba_come_to","f",function() 
    local trg = Mouse.Target
    local parent = plr.Character.HumanoidRootPart
    pcall(function()
        if trg.Parent:FindFirstChild("Humanoid") then
            parent = trg.Parent:FindFirstChild("HumanoidRootPart")
        elseif trg.Parent.Parent:FindFirstChild("Humanoid") or trg.Parent.Parent.Parent:FindFirstChild("Humanoid") then
            parent = trg.Parent.Parent:FindFirstChild("HumanoidRootPart") or trg.Parent.Parent.Parent:FindFirstChild("HumanoidRootPart")
        end 
    end)
    last_player = parent
    body = rePart(
    body.Name,
    parent,
    last[body.Name].p,
    last[body.Name].r,
    nil,
    last[body.Name].s
)
end)
local state = {
    wave = false;
    siethiel = false;
    hiden = false;
    kiss = false;
}

local function offExcept(state_name)
    for i,v in pairs(state) do
        if i ~= state_name then state[i] = false end
    end
end


getgenv().KeyBind("beba_wave","e",function()
    offExcept("wave")
    state.wave = not state.wave
    if not state.wave then
        r_hand = rePart(
            r_hand.Name,
            body.Handle,
            Vector3.new(0.1,0.1,1.3),
            Vector3.new(-120,-10,0)
        )
        flag = rePart(
            flag.Name,
            body.Handle,
            Vector3.new(-2.3,1.5,1.3),
            Vector3.new(-15,0,5),
            false
            
        )
    else
        r_hand = rePart(
            r_hand.Name,
            body.Handle,
            Vector3.new(0.1,1,1.5),
            Vector3.new(-30,10,0)
        )
        flag = rePart(
            flag.Name,
            r_hand.Handle,
            Vector3.new(1,1,2.5),
            Vector3.new(0,90,15),
            false
            
        )
    end
end)
getgenv().KeyBind("beba_hide","z",function()
    offExcept("hiden")
    state.hiden = not state.hiden
    if not state.hiden then
        body = rePart(
            body.Name,
            last_player,
            Vector3.new(-1.5,3,2),
            Vector3.new(-10,90,0),
            nil,
            body_speed
        )
    else
        body = rePart(
            body.Name,
            last_player,
            Vector3.new(-1.5,-15,2),
            Vector3.new(-10,90,0),
            nil,
            body_speed*10
        )
    end
end)
getgenv().KeyBind("beba_siethiel","c",function()
    offExcept("siethiel")
    state.siethiel = not state.siethiel
    if not state.siethiel then 
        r_hand = rePart(
            r_hand.Name,
            body.Handle,
            Vector3.new(0.1,0.1,1.3),
            Vector3.new(-120,-10,0)
        )
    else
        r_hand = rePart(
            r_hand.Name,
            body.Handle,
            Vector3.new(0.8,1.2,1.3),
            Vector3.new(-80,70,0)
        )
    end
end)
getgenv().KeyBind("beba_kiss","r",function()
    offExcept("kiss")
    state.kiss = not state.kiss
    if not state.kiss then
        def_pos()
    else
        body = rePart(
            body.Name,
            last_player,
            Vector3.new(0,0,-1.3),
            Vector3.new(10,270,0),
            nil,
            body_speed*10
        )
        head = rePart(
            head.Name,
            body.Handle,
            Vector3.new(0,1.7,0),
            Vector3.new(10,0,10)
            
        )
        r_hand = rePart(
            r_hand.Name,
            body.Handle,
            Vector3.new(0.8,1.5,1.3),
            Vector3.new(-120,50,-10)
        )
        l_hand = rePart(
            l_hand.Name,
            body.Handle,
            Vector3.new(0.8,1.2,-1.3),
            Vector3.new(130,-70,30)
            
        )
    end
end)
local Camera = workspace.CurrentCamera
getgenv().KeyBind("CameraSubject","q",function()
    local resp,err = pcall(function()
        if Camera.CameraSubject ~= plr.Character.Humanoid then
            Camera.CameraSubject = plr.Character.Humanoid
        else Camera.CameraSubject = head.Handle end
    end)
end)
 
if getgenv().head_look ~= nil then getgenv().head_look:Disconnect() end
getgenv().head_look = game:GetService("RunService").RenderStepped:Connect(function()
    if Camera.CameraSubject == head.Handle then
        local H = body.Handle.CFrame:toObjectSpace(Camera.CFrame).lookVector * Vector3.new(-50,50,-50)
        local B = last_player.CFrame:toObjectSpace(Camera.CFrame).lookVector * Vector3.new(-50,50,50)
        
        body = rePart(
            body.Name,
            last_player,
            last[body.Name].p,
            Vector3.new(0,90+B.X,B.Y),
            nil,
            body_speed
        )
        head = rePart(
            head.Name,
            body.Handle,
            Vector3.new(0,1.7,0),
            Vector3.new(0,H.Z,H.Y)
            
        )
    end
end)
if getgenv().die_con ~= nil then getgenv().die_con:Disconnect() end
getgenv().die_con = plr.Character.Humanoid.Died:Connect(function()
    getgenv().KeyBind("beba_come_to",false)
    getgenv().KeyBind("beba_wave",false)
    getgenv().KeyBind("beba_hide",false)
    getgenv().KeyBind("beba_siethiel",false)
    getgenv().KeyBind("beba_kiss",false)
    getgenv().KeyBind("CameraSubject",false)
    pcall(function() getgenv().head_look:Disconnect() end)
    pcall(function() getgenv().die_con:Disconnect() end)
end)
