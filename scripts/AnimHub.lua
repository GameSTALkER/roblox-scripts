
while wait() do
    local r = pcall(function()
        ngamestalker:isLoaded()
    end)
    if r then
        break
    end
end

local plr = game:GetService("Players").LocalPlayer
local httpService = game:GetService("HttpService")


local DeathCon
local hatCons = {}
local menu = ngamestalker:Menu("AnimHub","http://www.roblox.com/asset/?id=917776098",function()
    pcall(function() DeathCon:Disconnect() end)
    for i,v in pairs(hatCons) do
        pcall(function() v:Disconnect() end)
    end
end)

local emoteTab = menu:Tab("Emotes")

local tab = {}


local function getRigType()
    local char = plr.Character or plr.CharacterAdded:Wait()
    
    if char.Humanoid.RigType == Enum.HumanoidRigType.R15 then return "R15"
    elseif char.Humanoid.RigType == Enum.HumanoidRigType.R6 then return "R6" end
    
    return false
end

emoteButtons = {}
local emotesTable = false
local function PlayEmote(emoteName,b)
    b:Edit({name="Getting Humanoid..."})
    local myChar = plr.Character or plr.CharacterAdded:Wait()
    local humanoid = myChar:WaitForChild("Humanoid")
    b:Edit({name="Play Emote \""..emoteName.."\""})
    if humanoid:GetAttribute("AllEmotesLoaded") then
        local r = pcall(function() humanoid:PlayEmote(emoteName) end)
        if not r then
            b:Edit({name="Emote not found"})
            if n then n:Desc("Emote not found") end
            wait(1)
            b:Edit({name="Play Emote \""..emoteName.."\""})
        end
    elseif not humanoid:GetAttribute("AllEmotesLoaded") and humanoid.RigType == Enum.HumanoidRigType.R15 then
        humanoid:SetAttribute("AllEmotesLoaded",true)
        if emotesTable == false then
        	emotesTable = {}
            b:Edit({name="Requesting for animations..."})
            local animationCategory = httpService:JSONDecode(game:HttpGet('https://catalog.roblox.com/v1/categories')).AvatarAnimations
            local emoteCategory = httpService:JSONDecode(game:HttpGet('https://catalog.roblox.com/v1/subcategories')).EmoteAnimations
        
            local cursor = ''
            
            b:Edit({name="Getting emotes..."})
            while true do
                local requestString = ('https://catalog.roblox.com/v1/search/items/details?Category=%s&Subcategory=%s&IncludeNotForSale=true&Limit=30&Cursor=%s'):format(
                    animationCategory, emoteCategory, cursor
                )
                local response = httpService:JSONDecode(game:HttpGet(requestString))
                cursor = response.nextPageCursor
                
                for _, data in ipairs(response.data) do
                	emotesTable[data.name:lower()] = data.id
                end
            
                if not cursor then
                    break
                end
            end
        end
		for i,v in pairs(emotesTable) do
			humanoid.HumanoidDescription:AddEmote(i,v)
		end
        b:Edit({name="Play Emote \""..emoteName.."\""})
        local r = pcall(function() humanoid:PlayEmote(emoteName) end)
        if not r then
            b:Edit({name="Emote not found"})
            if n then n:Desc("Emote not found") end
            wait(1)
            b:Edit({name="Play Emote \""..emoteName.."\""})
        end
    elseif humanoid.RigType == Enum.HumanoidRigType.R15 and humanoid:GetAttribute("AllEmotesLoaded") then
        b:Edit({name="All emotes already loaded!"})
        wait(1)
        b:Edit({name="Play Emote \""..emoteName.."\""})
    else
        b:Edit({name="Use R6 RigType character!"})
        wait(1)
        b:Edit({name="Play Emote \""..emoteName.."\""})
    end
end

emoteTab:Button({name="Add emote slot",key="false"},function()
    local id
    table.insert(emoteButtons,emoteTab:Text({name='Play Emote "not given"'},function(name,n)
        PlayEmote(name:lower(),emoteButtons[id],n)
    end))
    id = #emoteButtons
    
end)

--
local function exec(RigType,Hats,link)
    if getRigType() == RigType or RigType == "UNI" then
        if Hats then 
            if getgenv().neededhats(Hats) then getgenv().netless()
                spawn(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/GameSTALkER/roblox-scripts/main/scripts/AnimHub.Scripts/"..RigType.."/"..link..".lua"))() end)
                return true
            else ngamestalker:Notification({desc="You forgot wear some hats (open console to check)"});return false end
        else spawn(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/GameSTALkER/roblox-scripts/main/scripts/AnimHub.Scripts/"..RigType.."/"..link..".lua"))() end) end
    else ngamestalker:Notification({desc="Accepting only "..RigType.."."});return false end
end

local function HatTransparency(hatHandle)
    table.insert(hatCons,hatHandle:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function()
        hatHandle.LocalTransparencyModifier = 0
    end))
    hatHandle.LocalTransparencyModifier = 0
    
end
DeathCon = plr.CharacterAdded:Connect(function()
    for i,v in pairs(hatCons) do
        pcall(function() v:Disconnect() end)
    end 
end)

local data = {
    Hand = {
        "R6";
        {"Nagamaki","Robloxclassicred",'Pal Hair','Pink Hair','Hat1','Kate Hair','LavanderHair','Bedhead','BlockheadBaseballCap',"MessyHair"};
    };
    Doll = {
        "R6";
        {"Robloxclassicred","Pal Hair",'LavanderHair','Pink Hair','HairAccessory','International Fedora','MeshPartAccessory','BrownCharmerHair','MessyHair'};
    };
    Stand = {
        "R6";
        {47963332,81642452,319354652,"HairAccessory","CoolBoyHair"};
    };
    Penis = {
        "R6";
        {{"InternationalFedora","MeshPartAccessory"},{"InternationalFedora","MeshPartAccessory"},{"InternationalFedora","MeshPartAccessory"},{"InternationalFedora","MeshPartAccessory"},{"InternationalFedora","MeshPartAccessory"},{"InternationalFedora","MeshPartAccessory"},{"InternationalFedora","MeshPartAccessory"},{"InternationalFedora","MeshPartAccessory"},{"InternationalFedora","MeshPartAccessory"},{"InternationalFedora","MeshPartAccessory"}};
    };

    FakeVR = {
        "UNI";
    };
    Eyes = {
        "UNI";
        {"Eyes"};
    };
    Wings = {
        "UNI";
        {"black metal wings"};
    };
}

for name,data in pairs(data) do
    if not tab[data[1]] then tab[data[1]] = menu:Tab(data[1]) end
    
    tab[data[1]]:Button({name=name.." script",desc=data[3]},function()
        local v1 = exec(data[1],data[2],name)
        if v1 then
            local myChar = plr.Character or plr.CharacterAdded:Wait()
            for i,v in pairs(myChar.Humanoid:GetAccessories()) do
                HatTransparency(v.Handle)
            end
        end
    end)
end
