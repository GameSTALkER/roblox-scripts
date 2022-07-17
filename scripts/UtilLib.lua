--[[ UtilLib

neededhats(hats: table)
Example:
    if getgenv().neededhats({"Pal Hair",01001,{"Katana",010100}}) then
        print("All is good!")
    else print("You don't have some hats ^") end
 
CFG(location: string, action: table(save) or string(load))
Example:
    local cfg = CFG("tetris","load") -- load
    cfg["debug"] = false
    cfg["completed"] = true
    cfg["pos"] = Vector3.new(35,0,0)
    CFG("tetris",cfg) -- save

netless() -- R6 + R15
Example:
    getgenv().netless()
    Accessory() -- Example of this is below

Accessory(hatName: string, parent: Instance, settings: table, callback: function(AP, AO))
Example:
    getgenv().Accessory("Dark Cyberpunk Katana",game:GetService("Players").LocalPlayer.Character["Left Arm"],{
        debug = false; -- print some info
        bloxify = false; -- remove mesh
        speed = 100; -- Speed
        shakeFix = true; -- prevent part to be under the drugs ( no soft animations :( )
        
        pos = Vector3.new(0,0,0); -- Position
        rot = Vector3.new(0,0,0); -- Rotation
        
    },function(AP,AO) -- turn off Oreintation, and will rotate
        AO.Enabled = false
        AP.RigidityEnabled = true
    end)
    
ScriptSession(check_type: number)
Example:
local session = ScriptSession(1) -- generating session
while session == ScriptSession() do -- checking if session changed
    print("session is alive");wait(1)
end
print("session ended :(") -- after re executing this script

PlayEmote(animation_id: number)
Example:
PlayEmote(4555816777) -- play curtsy anim (only roblox animations allowed or in-game)
]]--

getgenv().neededhats = function(hats) -- table, available args: "string", nil
	if hats == nil then warn("UtilLib | Error: getgenv().neededhats("..hats..")\n                        you forgot to add argumet (table) - ^^^"); return end
	if type(hats) ~= "table" then warn("UtilLib | Error: getgenv().neededhats("..hats..")\n           that argument must be \"table\" type - ^^^"); return end
	
    local function getmesh(a)
        for i,v in pairs(a:GetDescendants()) do
            if table.find({"Mesh","SpecialMesh"},v.ClassName) then 
                local id = v.TextureId:gsub("%rbxassetid://","")
                if id:find("http") then id = id:sub(33) end
                
                local di = v.MeshId:gsub("%rbxassetid://","")
                if di:find("http") then di = di:sub(33) end
                
                return {tostring(id):lower(),tostring(di):lower(),a.Name:lower()}
            end
        end
        return {a.Name} -- if no mash found
    end
    
	local plr = game:GetService("Players").LocalPlayer
    
    local found_hats = {}
    local is_all_hats_found = true
    for q,w in pairs(hats) do
        local found = false
        for i,v in pairs(plr.Character.Humanoid:GetAccessories()) do
            local ac = getmesh(v)
            if type(w) == "table" then
                for e,r in pairs(w) do
                    if table.find(ac,tostring(r):lower()) then
                        table.insert(found_hats,v)
                        found = true
                        break
                    end
                end
                if found then break end
            else
                if table.find(ac,tostring(w):lower()) then
                    table.insert(found_hats,v)
                    found = true
                    break
                end
                if found then break end
            end
        end
        if not found then
            local name = nil
            if type(w) == "table" then
                for i,v in pairs(w) do
                    if type(v) == "string" then name = v;break end
                end
                if name == nil then name = tostring(w[1]).." (MashId or TextureId)" end
            else name = w end
            warn("You need: "..tostring(name)) 
            is_all_hats_found = false
        end
	end
    return is_all_hats_found
    
end

getgenv().CFG = function(location, action)
    if location == nil then location = "global" end
    if action == nil then action = "get" end
    location = tostring(location):lower()

    local folder = "nGSTLoader" -- root folder
    local file_type = ".txt"
    local HttpService = game:GetService("HttpService")
    
    if not isfolder(folder) then makefolder(folder) end -- root folder
    if location ~= "global" then
        folder = folder.."/"..game.PlaceId
        if not isfolder(folder) then makefolder(folder) end -- root/game folder
        folder = folder.."/"..location..file_type
        if not isfile(folder) then writefile(folder, "{}") end -- root/game/%location folder
    else 
        folder = folder.."/"..location..file_type
        if not isfile(folder) then writefile(folder, "{}") end -- root/%location folder
    end
    if type(action) == "table" then -- save
        local data = HttpService:JSONEncode(action)
        writefile(folder, data)
    else -- load
        local raw_string = readfile(folder)
        local data = HttpService:JSONDecode(raw_string)
        return data
    end

end

getgenv().netless = function()
    -- Netless ReAnimation
    -- Created by MiAiHsIs1226
    pcall(function()
        if game.Players.LocalPlayer.Character:GetAttribute("IsNetless") then return end
        game.Players.LocalPlayer.Character:SetAttribute("IsNetless",true)
        function Senti_IiiiIiIiIiiIiIIiIIiIi_(a,_)if a~=nil then if _>-2+(-41)+(2)+(72)+(95)+(-91)+(30)then print("you're usin fps unlock")end if Senti_IiiiIiIiIiiIiIIiIIiIie then print("you usin synapse.congratulations(I have no idea what to say)")end if("hello")=="x68x65x6Cx6Cx6F"then print("are you usin a bad exploit?")end return true elseif a==nil then return true else return end end Senti_IiiiIiIiIiiIiIIiIIiIie=Senti_IiiiIiIiIiiIiIIiIIiIie or nil Senti_IiiiIiIiIiiIiIIiIIiIid=Senti_IiiiIiIiIiiIiIIiIIiIid or Instance.new("Script") Senti_IiiiIiIiIiiIiIIiIIiIic=game:GetService("Workspace"):GetRealPhysicsFPS() Senti_IiiiIiIiIiiIiIIiIIiIib=game:GetService("Players")['LocalPlayer'] Senti_IiiiIiIiIiiIiIIiIIiIia=Senti_IiiiIiIiIiiIiIIiIIiIi_(Senti_IiiiIiIiIiiIiIIiIIiIib,Senti_IiiiIiIiIiiIiIIiIIiIic) if(not Senti_IiiiIiIiIiiIiIIiIIiIia)==true then return pcall(function()game:GetService("TestService"):Fail("Cannot load script")end)end return xpcall(function(a,b)local c=a local _=b a,b=nil,nil table.clear(c()) local _={} local b={} b.number=(65-(20/100)+.2) local d=getmetatable(newproxy(true)) local a=getmetatable(setmetatable({},{})) spawn(function()if c()then wait() d[2](d[3](d[4]))()else return"bitch"end end) local _=function(_)local d="" local a=function(_)return(_:gsub(".",function(_)if tonumber(_)then return _ else return""end end))end for _,c in next,string.split(_,"\a")do local _=tonumber(a(c)) if _~=nil then d=d..string.char(_-b.number)elseif c then d=d..c end end return d:sub(4)end a.index=_([['{\173;\176;\162;\165;\180;\181;\179;\170;\175;\168;}']]) d={} d[1-(20/100)+.2]=c() d[2-(20/100)+.2]=d[1][a.index] d[3-(20/100)+.2]=_ d[4-(20/100)+.2]=[['{\167;\176;\179;\97;\170;\109;\183;\97;\170;\175;\97;\175;\166;\185;\181;\109;\97;\168;\162;\174;\166;\123;\136;\166;\181;\148;\166;\179;\183;\170;\164;\166;\105;\99;\145;\173;\162;\186;\166;\179;\180;\99;\106;\111;\141;\176;\164;\162;\173;\145;\173;\162;\186;\166;\179;\111;\132;\169;\162;\179;\162;\164;\181;\166;\179;\123;\136;\166;\181;\133;\166;\180;\164;\166;\175;\165;\162;\175;\181;\180;\105;\106;\97;\165;\176;\78;\75;\170;\167;\97;\183;\123;\138;\180;\130;\105;\99;\131;\162;\180;\166;\145;\162;\179;\181;\99;\106;\97;\162;\175;\165;\97;\183;\111;\143;\162;\174;\166;\97;\191;\126;\99;\137;\182;\174;\162;\175;\176;\170;\165;\147;\176;\176;\181;\145;\162;\179;\181;\99;\97;\181;\169;\166;\175;\97;\78;\75;\168;\162;\174;\166;\123;\136;\166;\181;\148;\166;\179;\183;\170;\164;\166;\105;\99;\147;\182;\175;\148;\166;\179;\183;\170;\164;\166;\99;\106;\111;\137;\166;\162;\179;\181;\163;\166;\162;\181;\123;\164;\176;\175;\175;\166;\164;\181;\105;\167;\182;\175;\164;\181;\170;\176;\175;\105;\106;\78;\75;\183;\111;\151;\166;\173;\176;\164;\170;\181;\186;\97;\126;\97;\151;\166;\164;\181;\176;\179;\116;\111;\175;\166;\184;\105;\110;\115;\118;\111;\119;\109;\113;\109;\113;\106;\78;\75;\166;\175;\165;\106;\78;\75;\168;\162;\174;\166;\123;\136;\166;\181;\148;\166;\179;\183;\170;\164;\166;\105;\99;\147;\182;\175;\148;\166;\179;\183;\170;\164;\166;\99;\106;\111;\137;\166;\162;\179;\181;\163;\166;\162;\181;\123;\164;\176;\175;\175;\166;\164;\181;\105;\167;\182;\175;\164;\181;\170;\176;\175;\105;\106;\78;\75;\184;\162;\170;\181;\105;\111;\113;\114;\106;\78;\75;\183;\111;\151;\166;\173;\176;\164;\170;\181;\186;\97;\126;\97;\151;\166;\164;\181;\176;\179;\116;\111;\175;\166;\184;\105;\113;\109;\113;\109;\113;\106;\78;\75;\166;\175;\165;\106;\78;\75;\166;\175;\165;\78;\75;\166;\175;\165;\78;\75;\78;\75;\168;\162;\174;\166;\123;\136;\166;\181;\148;\166;\179;\183;\170;\164;\166;\105;\99;\148;\181;\162;\179;\181;\166;\179;\136;\182;\170;\99;\106;\123;\148;\166;\181;\132;\176;\179;\166;\105;\99;\148;\166;\175;\165;\143;\176;\181;\170;\167;\170;\164;\162;\181;\170;\176;\175;\99;\109;\97;\188;\97;\78;\75;\149;\170;\181;\173;\166;\97;\126;\97;\99;\143;\176;\181;\170;\167;\170;\164;\162;\181;\170;\176;\175;\99;\124;\78;\75;\149;\166;\185;\181;\97;\126;\97;\99;\143;\166;\181;\173;\166;\180;\180;\97;\162;\164;\181;\170;\183;\162;\181;\166;\165;\157;\175;\132;\179;\166;\162;\181;\166;\165;\97;\163;\186;\97;\142;\170;\130;\170;\137;\180;\138;\180;\114;\115;\115;\119;\99;\124;\78;\75;\138;\164;\176;\175;\97;\126;\97;\99;\179;\163;\185;\181;\169;\182;\174;\163;\123;\112;\112;\181;\186;\177;\166;\126;\130;\180;\180;\166;\181;\103;\170;\165;\126;\118;\114;\113;\120;\114;\121;\115;\114;\114;\117;\103;\184;\126;\114;\118;\113;\103;\169;\126;\114;\118;\113;\99;\124;\78;\75;\133;\182;\179;\162;\181;\170;\176;\175;\97;\126;\97;\114;\119;\124;\190;\106;\78;\75;}']]end,function(_)game:GetService("TestService"):Fail("\n"..(script or Instance.new('Script')):GetFullName().." has occurred an error:".._)end,getfenv,setfenv) 
    end)
    
end

getgenv().Accessory = function(hatName,parent,settings,callback)
    local default_settings = {
        debug = false; -- print some info
        bloxify = false; -- remove mesh
        speed = 175; -- speed
        shakeFix = true; -- prevent part to be under the drugs ( no soft animations :( )
        
        pos = Vector3.new(0,0,0); -- Position
        rot = Vector3.new(0,0,0); -- Rotation
    }
    local function neededType(value,ntype)
        if type(value) == ntype then 
            return true 
        elseif rstr == nil then 
            return false 
        end
    end
    
    if hatName == nil then print("hatName can't be nil.");return nil end
    if parent == nil then print("parent can't be nil.");return nil end
    if type(settings) ~= "table" then 
        print("loaded default settings.")
        settings = default_settings
    else
        if settings.debug == nil then settings.debug = default_settings.debug end
        if settings.bloxify == nil then settings.bloxify = default_settings.bloxify end
        if settings.speed == nil then settings.speed = default_settings.speed end
        if settings.pos == nil then settings.pos = default_settings.pos end
        if settings.rot == nil then settings.rot = default_settings.rot end
        if settings.shakeFix == nil then settings.shakeFix = default_settings.shakeFix end
    end
    if callback == nil then callback = function() end end
    local function debug(str) if settings.debug then print(tostring(str)) end end
    
    local Player = game:GetService("Players").LocalPlayer
    
    local hat = nil
    if getgenv().hats_attributes == nil then getgenv().hats_attributes = {} end
    if type(hatName) == "string" then
        hat = Player.Character:FindFirstChild(hatName)
    else hat = hatName end
    if hat == nil then return nil end
    getgenv().netless()
    local unnedeedWeld = hat.Handle:FindFirstChild("AccessoryWeld")
    if unnedeedWeld then unnedeedWeld:Destroy() end
    if hat:GetAttribute("IsReanimated") and getgenv().hats_attributes[hat.Name] then
        getgenv().hats_attributes[hat.Name].Pos.Responsiveness = settings.speed
        getgenv().hats_attributes[hat.Name].Rot.Responsiveness = settings.speed
        getgenv().hats_attributes[hat.Name].Pos.RigidityEnabled = settings.shakeFix
        getgenv().hats_attributes[hat.Name].att1.Parent = parent
        getgenv().hats_attributes[hat.Name].att1.Position = settings.pos
        getgenv().hats_attributes[hat.Name].att1.Rotation = settings.rot
        getgenv().hats_attributes[hat.Name].att0.Visible = settings.debug
        if settings.bloxify and getgenv().hats_attributes[hat.Name].mesh ~= nil then
            getgenv().hats_attributes[hat.Name].mesh.Parent = hat
        elseif getgenv().hats_attributes[hat.Name].mesh ~= nil then
            getgenv().hats_attributes[hat.Name].mesh.Parent = hat.Handle
        end
    else
        getgenv().hats_attributes[hat.Name] = {att0=nil,att1=nil,Pos=nil,Rot=nil,mesh=nil,trans_con=nil}
        -- Handle parent
        local att0 = Instance.new("Attachment", hat.Handle) -- hat att
        att0.Name = "Root"
        att0.Position = Vector3.new(0,0,0)
        att0.Visible = settings.debug
        getgenv().hats_attributes[hat.Name].att0 = att0
        
        local att1 = Instance.new("Attachment", parent) -- parent to
        att1.Name = "hat-"..hat.Name
        att1.Position = settings.pos
        att1.Rotation = settings.rot
        getgenv().hats_attributes[hat.Name].att1 = att1
        
        -- Handle parent
        local AP = Instance.new("AlignPosition", hat.Handle)
        AP.Name = "Pos"
        AP.Attachment0 = att0
        AP.Attachment1 = att1
        AP.RigidityEnabled = false
        AP.ReactionForceEnabled = false
        AP.ApplyAtCenterOfMass = true
        AP.MaxForce = math.huge
        AP.MaxVelocity = math.huge
        AP.Responsiveness = settings.speed
        AP.RigidityEnabled = settings.shakeFix
        getgenv().hats_attributes[hat.Name].Pos = AP
        
        local AO = Instance.new("AlignOrientation", hat.Handle)
        AO.Name = "Rot"
        AO.Attachment0 = att0
        AO.Attachment1 = att1
        AO.ReactionTorqueEnabled = false
        AO.PrimaryAxisOnly = false
        AO.MaxTorque = math.huge
        AO.MaxAngularVelocity = math.huge
        AO.Responsiveness = settings.speed
        getgenv().hats_attributes[hat.Name].Rot = AO
        
        for n,p in pairs(hat.Handle:GetChildren()) do
            if p:IsA("Mesh") or p:IsA("SpecialMesh") then
                local newmesh = p
                if settings.bloxify then
                    newmesh = p:Clone()
                    p:Destroy() 
                else newmesh = p end
                getgenv().hats_attributes[hat.Name].mesh = newmesh
            end
        end
        
        if getgenv().hats_attributes[hat.Name] then
            pcall(function() getgenv().hats_attributes[hat.Name].trans_con:Disconnect() end)
            getgenv().hats_attributes[hat.Name].trans_con = nil
        end
        
        if settings.bloxify and getgenv().hats_attributes[hat.Name].mesh ~= nil then
            getgenv().hats_attributes[hat.Name].mesh.Parent = hat
        elseif getgenv().hats_attributes[hat.Name].mesh ~= nil then
            getgenv().hats_attributes[hat.Name].mesh.Parent = hat.Handle
        end
        
        hat:SetAttribute("IsReanimated",true)
    end
    
    spawn(function()
        callback(
            getgenv().hats_attributes[hat.Name].Pos, -- AlignPosition
            getgenv().hats_attributes[hat.Name].Rot  -- AlignOrientation
        )
    end)
    
    return hat
    
end

getgenv().KeyBind = function(id,key,callback)
    if id == nil then print("Id must be provided");return end
    if key == nil then print("Key must be provided");return end
    if callback == nil and key ~= false then print("CallBack must be provided");return end
    
    if getgenv().KeyBindsss == nil then getgenv().KeyBindsss = {} end
    if getgenv().KeyBindsss[tostring(id)] then 
        getgenv().KeyBindsss[tostring(id)]:Disconnect()
    end
    if key == false then print("Keybind "..tostring(id).." disabled");return end
    local UIS = game:GetService("UserInputService")
    getgenv().KeyBindsss[tostring(id)] = UIS.InputBegan:Connect(function(a)
        if a.KeyCode.Name:lower() == key:lower() then
            callback()
        end
    end)
    
end

getgenv().ScriptSession = function(id,check_type)

    if type(id) == "number" then check_type = id;id=nil end
    if id == nil then id = "global" end
    if check_type == nil then check_type = 0 end
    
    if getgenv().ScriptInstanceID == nil then getgenv().ScriptInstanceID = {} end
    if check_type == 1 then
        local array = {}
        for i = 1, 10 do
            array[i] = string.char(math.random(32, 126))
        end
        local Gen_ID = table.concat(array);array = nil
        getgenv().ScriptInstanceID[id] = Gen_ID
        return Gen_ID
    else
        return getgenv().ScriptInstanceID[id]
    end
    
end

local active = {}
getgenv().PlayEmote = function(animid)
	for i,v in pairs(active) do
		v:Stop()
		active[i] = nil

	end

	local Character = game.Players.LocalPlayer.Character
	local Anim = Instance.new("Animation")
	Anim.AnimationId = "rbxassetid://"..animid

	Character.Animate.Disabled = true
	local toplay = Character.Humanoid.Animator:LoadAnimation(Anim)
	toplay:Play()

	active[animid] = toplay
	con = Character.Humanoid.Running:connect(function(speed)
		if speed > 3 then
			Character.Animate.Disabled = false
			toplay:Stop()
			active[animid] = nil
			con:Disconnect()

		end

	end)

	jumpcon = Character.Humanoid.Jumping:connect(function()
		Character.Animate.Disabled = false
		toplay:Stop()
		active[animid] = nil
		jumpcon:Disconnect()

	end)
	
end
