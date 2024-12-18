local Stores = {
    "CoffeeShop",
    "Supermarket",
    "PizzaShop",
    "ToyShop",
    "Obbies",
    "Neighborhood",
    "CampingShop",
    "AutoShop",
    "Nursery",
    "Cave",
    "IceCream",
    "PotionShop",
    "SkyCastle",
    "Hospital",
    "HatShop",
    "PetShop",
    "School",
    "BabyShop",
    "HotSpringHouse",
    "SafetyHub",
    "DebugInterior",
    "VIP",
    "Salon",
    "SpleefMinigame",
    "SimonSaysMinigame",
    "WinterCastle"
}

local Baths = {
    "StylishShower",
    "CheapBathtub",
    "ModernShower",
    "Bathtub",
    "GingerbreadShower",
    "HotTub"
}

local FreeFoods = {
    "ham_vip",
    "water_vip",
    "chocolate_milk_vip",
    "popcorn_vip",
    "marshmallow_on_a_stick",
    "healing_apple",
    "teachers_apple",
}

local Beds = {
    "FancyPetBed",
    "ModernPetBed",
    "CircularPetBed",
    "RectangularPetBed",
    "NormalCrib",
    "BasicCrib",
    "RoyalCrib",
    "PoshCrib",
}
local Tasks = {
    "hungry",
    "sleepy",
    "thirsty",
    "bored",
    "dirty",
    "camping",
    "sick",
    "school",
    "pool_party",
    "salon",
    "pizza_party",
    "beach_party"
}

local Eggs = {
    "cracked_egg",
    "regular_pet_egg",
    "royal_egg",
    "retired_egg",
    "seasia_2023_egg",
    "mythic_egg",
    "japan_2022_egg",
    "danger_2023_egg",
}

local gifts = {
    "smallgift",
    "biggift",
    "massivegift",
    "legend_hat_2022_simple_chest",
    "legend_hat_2022_regal_chest"
}
local Obbys = {
    "miniworld",
    "coastal_climb",
    "shipwreck_bay",
    "ancient_ruins",
    "lonelypeak",
    "pyramid",
    "tinyisles"
}

local RetardedBullShit = {
    "CashRegister",
    "GoldenCashRegister"
}

local Tick = tick()
local Part = Instance.new("Part")
Part.Name = "P"
Part.Size = Vector3.new(9e9,0,9e9)
Part.Anchored = true
Part.Transparency = 0.5
Part.CFrame = CFrame.new(5000,5000,5000)
Part.Parent = Workspace
local Main = ReplicatedStorage:FindFirstChild("Fsys", true)
repeat wait() until table.find(getloadedmodules(), Main)
local RequireMain = require(Main)

for i, v in pairs(getupvalue(require(Main).load("RouterClient").init, 4)) do
    v.Name = i
end
local Load = function(TableName)
    local Old = get_thread_identity()
    set_thread_identity(2)
    local loading = RequireMain.load(TableName)
    set_thread_identity(Old)
    return loading
end
local RF = function(RemoteName)
    local Remote = ReplicatedStorage:FindFirstChild(RemoteName, true)
    if Remote then
        if Remote:IsA("RemoteFunction") then
            return Remote
        end
    end
end

local RE = function(RemoteName)
    local Remote = ReplicatedStorage:FindFirstChild(RemoteName, true)
    if Remote then
        if Remote:IsA("RemoteEvent") then
            return Remote
        end
    end
end
local SwitchTeams = function(Team)
    RF("TeamAPI/ChooseTeam"):InvokeServer(Team,{["dont_send_back_home"] = false,["source_for_logging"] = ""})
end
local GetCurrentPetOut = function()
    for i,v in next, require(ReplicatedStorage.ClientModules.Game.PetEntities.PetEntityManager).get_local_owned_pet_entities() do
        return v
    end
end
local Load2 = function()
    SwitchTeams("Babies")
    Load("UIManager").set_app_visibility('MainMenuApp', false);
    Load("UIManager").set_app_visibility('NewsApp', false);
    Load("UIManager").set_app_visibility("DialogApp", false)
end

local Location = nil
for i,v in next, getgc() do
    if type(v) == "function" and islclosure(v) then
        if table.find(getconstants(v), "LocationAPI/SetLocation") then
            Location = v
        end
    end
end
print("Load Check point 1 took ".. tick() - Tick ..  " Seconds to load")
Tick = tick()
local SetLocation = function(A, B, C)
    local O = get_thread_identity()
    set_thread_identity(2)
    Location(A, B, C)
    set_thread_identity(7)
end
local Home = function()
    if Workspace.HouseInteriors.blueprint:FindFirstChildWhichIsA("Model") then
        return Workspace.HouseInteriors.blueprint:FindFirstChildWhichIsA("Model").Name
    else
        return false
    end
end
local PersonHome = function()
    if Workspace.HouseInteriors.blueprint:FindFirstChildWhichIsA("Model") then
        return Workspace.HouseInteriors.blueprint:FindFirstChildWhichIsA("Model").Name
    else
        return false
    end
end
local Store = function()
    if Workspace.Interiors:FindFirstChildWhichIsA("Model") then
        if not string.find(Workspace.Interiors:FindFirstChildWhichIsA("Model").Name,"MainMap") and not
            string.find(Workspace.Interiors:FindFirstChildWhichIsA("Model").Name,"Neighborhood")
        then
            return Workspace.Interiors:FindFirstChildWhichIsA("Model").Name
        else
            return false
        end
    else
        return false
    end
end

local MainMap = function()
    if Workspace.Interiors:FindFirstChildWhichIsA("Model") then
        if string.find(Workspace.Interiors:FindFirstChildWhichIsA("Model").Name,"MainMap") then
            return Workspace.Interiors:FindFirstChildWhichIsA("Model").Name
        else
            return false
        end
    else
        return false
    end
end

local Neighborhood = function()
    if Workspace.Interiors:FindFirstChildWhichIsA("Model") then
        if string.find(Workspace.Interiors:FindFirstChildWhichIsA("Model").Name,"Neighborhood") then
            return Workspace.Interiors:FindFirstChildWhichIsA("Model").Name
        else
            return false
        end
    else
        return false
    end
end

local GoToStore = function(Name)
    if Store() == Name then
        return true
    end

    SetLocation(Name, "MainDoor", {})

    while Store() ~= Name do
        wait()
    end
    if Home() then
        return true
    end
    return false
end

local GoToHome = function()
    SetLocation("housing", "MainDoor", {["house_owner"] = Player})
    while not Home() do
        wait()

    end
    if Home() then

        return true
    end

    return false

end

local GoToNeighborhood = function()
    SetLocation("Neighborhood", "MainDoor", {})
    while not Neighborhood() do
        wait()

    end
    if Neighborhood() then

        return true
    end
    return false
end

local GoToMainMap = function()
    SetLocation("MainMap", "Neighborhood/MainDoor", {})
    while not MainMap() do

        wait()
    end
    if MainMap() then

        return true
    end
    return false
end

local GoToPersonsHouse = function(Name)
    SetLocation("housing","MainDoor",{["house_owner"] = Players[Name]})
    while not PersonHome() do

        wait()
    end
    if PersonHome() then

        return true
    end
    return false
end
local Bed = function(Name)
    GoToHome()
    Player.Character.HumanoidRootPart.CFrame = Workspace.HouseInteriors.blueprint[Player.Name].Doors.MainDoor:GetModelCFrame():ToWorldSpace(CFrame.new(0, 0, -6)) 
    for i, v in pairs(Workspace.HouseInteriors.furniture:GetChildren()) do
        if v:FindFirstChildWhichIsA("Model") and (table.find(Beds, v:FindFirstChildWhichIsA("Model").Name)) then
            local String = string.split(v.Name,"/f")[2]
            print(String)
            return "f".. String
        end
    end
end

local Showers = function(Name)
    GoToHome()
    Player.Character.HumanoidRootPart.CFrame = Workspace.HouseInteriors.blueprint[Player.Name].Doors.MainDoor:GetModelCFrame():ToWorldSpace(CFrame.new(0, 0, -6)) 
    for i, v in pairs(Workspace.HouseInteriors.furniture:GetChildren()) do
        if v:FindFirstChildWhichIsA("Model") and (table.find(Baths, v:FindFirstChildWhichIsA("Model").Name)) then
            local String = string.split(v.Name,"true/")[2]
            print(String)
            return String
        end
    end
end
Load2()
print("Load Check point 2 took ".. tick() - Tick ..  " Seconds to load")
Tick = tick()
local Remotes = {}
local PP = {}
local Table = {
    6152116144,
    185655149
}


local Neons = {}
local AilmentFurnitues = {}
local Neon = {}
local Spec = {}
local Key = {}
local PetsShow = {}
local List = {}
local JoJo = {}
local GGO = {}
local Ps = {}
local a = {
    ["sleepy"] = function(c)
        if not Bed() then
            RF("HousingAPI/BuyFurnitures"):InvokeServer({["kind"] = "basiccrib", ["properties"] = {["cframe"] = CFrame.new()}})
        end

        spawn(function()
            while c.Parent == Player.PlayerGui.AilmentsMonitorApp.Ailments do
                if c.Parent == Player.PlayerGui.AilmentsMonitorApp.Ailments then
                    print(Player, Bed(), 'UseBlock', {['cframe'] = Player.Character.HumanoidRootPart.CFrame}, GetCurrentPetOut().base.pet_model.Parent)
                    RF('HousingAPI/ActivateFurniture',true):InvokeServer(Player, Bed(), 'UseBlock', {['cframe'] = Player.Character.HumanoidRootPart.CFrame}, GetCurrentPetOut().base.pet_model.Parent)
                    if not Bed() then
                        GoToMainMap()
                        GoToHome()
                    end
                end
            end
        end)
        repeat wait(0) until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,
    ['dirty'] = function(c)
        spawn(function()
            while c.Parent == Player.PlayerGui.AilmentsMonitorApp.Ailments do
                print(Player, Bed(), 'UseBlock', {['cframe'] = Player.Character.HumanoidRootPart.CFrame}, GetCurrentPetOut().base.pet_model.Parent)
                RF("HousingAPI/ActivateFurniture",true):InvokeServer(Player, Showers(), 'UseBlock', {['cframe'] = Player.Character.HumanoidRootPart.CFrame}, GetCurrentPetOut().base.pet_model.Parent)
                if not Showers() then
                    GoToMainMap()
                    GoToHome()
                end
            end
        end)
        repeat wait() until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,
    ["hungry"] = function(c)
        RF("ShopAPI/BuyItem",true):InvokeServer('food', 'apple', {})
        local Foods = require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.food or {}
        local apple
        for i, v in pairs(Foods) do
            if v.id == 'apple' then
                apple = v.unique
                break
            end
        end
        if not apple then
            return
        end
        local Pet = string.split(GetCurrentPetOut().unique_id, "-")[1]
        RF("PetObjectAPI/CreatePetObject",true):InvokeServer("__Enum_PetObjectCreatorType_2",{["unique_id"] = apple,["possible_grabber_pet_unique"] = Pet,["pet_unique"] = Pet,["grab_immediately"] = false})
        RE("PetAPI/ConsumeFoodItem",true):FireServer(apple, Pet)

        repeat wait() until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,

    ["thirsty"] = function(c)
        RF("ShopAPI/BuyItem",true):InvokeServer('food', 'tea', {})
        local Foods = require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.food or {}
        local Tea
        for i, v in pairs(Foods) do
            if v.id == 'tea' then
                Tea = v.unique
                break
            end
        end
        if not Tea then
            return
        end
        local Pet = string.split(GetCurrentPetOut().unique_id, "-")[1]
        RF("PetObjectAPI/CreatePetObject",true):InvokeServer("__Enum_PetObjectCreatorType_2",{["unique_id"] = Tea,["possible_grabber_pet_unique"] = Pet,["pet_unique"] = Pet,["grab_immediately"] = false})
        RE("PetAPI/ConsumeFoodItem",true):FireServer(Tea, Pet)
        repeat wait() until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,
    ["sick"] = function(c)
        repeat wait(0) RE("MonitorAPI/HealWithDoctor",true):FireServer() until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,
    ["adoption_party"] = function(c)
        GoToStore('Nursery')
        repeat wait() until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,
    ["school"] = function(c)
        GoToStore('School')
        repeat wait() until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,
    ["pizza_party"] = function(c)
        GoToStore("PizzaShop")
        repeat wait() until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,
    ["salon"] = function(c)
        GoToStore("Salon")
        repeat wait() until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,
    ["beach_party"] = function(c)
        GoToMainMap()
        Player.Character.HumanoidRootPart.CFrame = CFrame.new(Workspace.StaticMap.Beach.BeachPartyAilmentTarget.Position + Vector3.new(0, 5, 0))
        repeat wait() until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,
    ["camping"] = function(c)
        GoToMainMap()
        Player.Character.HumanoidRootPart.CFrame = CFrame.new(Workspace.StaticMap.Campsite.CampsiteOrigin.Position + Vector3.new(0, 5, 0))
        repeat wait() until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end,
    ['bored'] = function(c)
        GoToMainMap()
        Player.Character.HumanoidRootPart.CFrame = CFrame.new(Workspace.StaticMap.Park.AilmentTarget.Position + Vector3.new(0, 5, 0))
        repeat wait() until c.Parent ~= Player.PlayerGui.AilmentsMonitorApp.Ailments
    end
}

local PetID
local Pet
for i,v in next, Players:GetPlayers() do
    table.insert(Ps, v.Name)
end
for i, v in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
    local key = tostring(v["id"]) .. " - " .. tostring(v["properties"]["age"]) .. " years old"
    if not table.find(List, Key) and v.kind ~= "practice_dog" then
        PetsShow[key] = v
        table.insert(List, key)
        table.sort(List)
    end
end
for i, v in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
    if not table.find(JoJo,tostring(v["id"])) and v.kind ~= "practice_dog" then
        local Key2 = tostring(v["id"])
        GGO[Key2] = v
        table.insert(JoJo,Key2)
        table.sort(JoJo)
    end
end

for i,v in next, PetsShow do
    Key = v
    break
end

UserInputService.WindowFocusReleased:Connect(function()
    if Render then
        RunService:Set3dRenderingEnabled(false)
        if table.find(Table, game.PlaceId) then
            setfpscap(30)
        else
            setfpscap(15)
        end
    end
end)
UserInputService.WindowFocused:Connect(function()
    if Render then
        RunService:Set3dRenderingEnabled(true)
        setfpscap(100)
    end
end)

pcall(function()
    RF("DailyLoginAPI/ClaimDailyReward"):InvokeServer()
end)

spawn(function()
    while wait() do
        pcall(function()
            if Loll then
                ReplicatedStorage.API["ShopAPI/BuyItem"]:InvokeServer("gifts",Gifts,{})
            end
            if Lol2 then
                ReplicatedStorage.API["ShopAPI/BuyItem"]:InvokeServer("pets",Egg,{})
            end
            if SwitchOutFullyGrown then
                local Pets = require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets or {}
                if Key and Key["properties"]["age"] == 6 then
                    for i, v in pairs(Pets) do
                        if v["properties"]["age"] ~= 6 then
                            Key = v
                        end
                    end
                end
            end
            if BabyFarm then
                for i,v in pairs(Player.PlayerGui.AilmentsMonitorApp.Ailments:GetChildren()) do
                    if v:IsA("Frame") then
                        ReplicatedStorage.API["MonitorAPI/AddAdditive"]:FireServer(v.Name, 100)
                    end
                end
            end
            if Neon then
                local N = 0
                for i,v in pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets) do
                    local Old = v.id
                    if string.find(Old,v.id) and v.properties.age == 6 then
                        N = N + 1
                        table.insert(Neons, v.unique)
                        if N == 4 then
                            RF("PetAPI/DoNeonFusion"):InvokeServer({unpack(Neons)})
                            table.clear(Neons)
                            N = 0
                        end
                    end
                end
            end
            if SwitchOutEgg then
                local Pets = require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets or {}
                if Key.id:match("egg") and Key.id:match("basic_egg") then
                    for i, v in pairs(Pets) do
                        if v["id"]:match("egg") and not v["id"]:match("basic_egg") then
                            Key = v
                        end
                    end
                end
            end
            if True then
                local Pets = require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets or {}
                if v["id"] ~= sp or v["properties"]["age"] == 6 then
                    for i, v in pairs(Pets) do
                        if v["id"] == sp and v["properties"]["age"] ~= 6 then
                            Key = v
                        end
                    end
                end
            end
            if Grow then
                local Foods = require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.food or {}
                local Tea
                for i, v in pairs(Foods) do
                    if v.kind == "pet_age_potion" then
                        Tea = v.unique
                        break
                    end
                end
                if not Tea then
                    return
                end
                local Pets = require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets or {}
                for i,v in next, Pets do
                    if v.kind == Petsc and v["properties"]["age"] ~= 6 then
                        RF("ToolAPI/Unequip"):InvokeServer(v.unique)
                        RF("ToolAPI/Equip"):InvokeServer(v.unique)
                    end
                end
                local Pet = string.split(GetCurrentPetOut().unique_id, "-")[1]
                RF("PetObjectAPI/CreatePetObject",true):InvokeServer("__Enum_PetObjectCreatorType_2",{["unique_id"] = Tea,["possible_grabber_pet_unique"] = Pet,["pet_unique"] = Pet,["grab_immediately"] = false})
                RE("PetAPI/ConsumeFoodItem",true):FireServer(Tea, Pet)
            end
            if HealOthers then
                ReplicatedStorage.API["MonitorAPI/HealWithDoctor"]:FireServer()
            end
        end)
    end
end)
local NewPet = GetCurrentPetOut()
if not NewPet then
    RF("ToolAPI/Unequip"):InvokeServer(Key.unique, {["use_sound_delay"] = false,["equip_as_last"] = false})
    RF("ToolAPI/Equip"):InvokeServer(Key.unique, {["use_sound_delay"] = false,["equip_as_last"] = false})
end

spawn(function()
    while wait() do

            if PetFarm then
                local Ailment = Player.PlayerGui.AilmentsMonitorApp.Ailments:FindFirstChildWhichIsA("Frame")
                if Ailment then
                    local Name = Ailment.Name
                    if a[Name]then
                        a[Name](Ailment)
                    end
                end
                if not GetCurrentPetOut() then
                    RF("ToolAPI/Unequip"):InvokeServer(Key.unique, {["use_sound_delay"] = false,["equip_as_last"] = false})
                    RF("ToolAPI/Equip"):InvokeServer(Key.unique, {["use_sound_delay"] = false,["equip_as_last"] = false})
                elseif string.split(GetCurrentPetOut().unique_id, "-")[1] ~= Key.unique then
                    RF("ToolAPI/Unequip"):InvokeServer(Key.unique, {["use_sound_delay"] = false,["equip_as_last"] = false})
                    RF("ToolAPI/Equip"):InvokeServer(Key.unique, {["use_sound_delay"] = false,["equip_as_last"] = false})
                end
            end

    end
end)

RunService.RenderStepped:Connect(function()
    if Crash then
        for i=1,50 do
            ReplicatedStorage.API["TeamAPI/ChooseTeam"]:InvokeServer("Babies", true)
        end 
    end
    if PetFarm then
        if GetCurrentPetOut() and GetCurrentPetOut().base.pet_model.Parent and VG.Mag(Player.Character:GetModelCFrame(), GetCurrentPetOut().base.pet_model.Parent:GetModelCFrame()) >= 25 then
            GetCurrentPetOut().base.pet_model.Parent.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame
        end
        Workspace["P"].CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.new(Vector3.new(0,-5,0))
        VG.NoClip()
    end
end)
print("Load Check point 3 took ".. tick() - Tick ..  " Seconds to load")
Tick = tick()
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Noot: Adopt Me!", .. MarketplaceService:GetProductInfo(game.PlaceId).Name,
    SubTitle = "Nova Era",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.Delete -- Used when theres no MinimizeKeybind
})


local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Main2 = Window:AddTab({ Title = "Misc", Icon = "" }),
    Main3 = Window:AddTab({ Title = "Teleports", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

do
    Fluent:Notify({
        Title = "Noot",
        Content = "Congrats your using Noot " .. Verison,
        SubContent = "", -- Optional
        Duration = 10 -- Set to nil to make the notification not disappear
    })
    local Toggle = Tabs.Main:AddToggle("no", {Title = "Baby Farm", Default = false})
    Toggle:OnChanged(function()
        BabyFarm = Options.no.Value
    end)

    local Toggle = Tabs.Main2:AddToggle("CPU", {Title = "LowCpu render", Default = false})
    Toggle:OnChanged(function()
        Render = Options.CPU.Value
    end)

    local Toggle = Tabs.Main2:AddToggle("Cr", {Title = "Lag Server", Default = false})
    Toggle:OnChanged(function()
        Crash = Options.Cr.Value
    end)

    local Toggle = Tabs.Main:AddToggle("Ne", {Title = "Auto Neon", Default = false})
    Toggle:OnChanged(function()
        Neon = Options.Ne.Value
    end)
    
    local Dropdown = Tabs.Main:AddDropdown("d", {Title = "Pets",Values = List,Multi = false,Default = 1})
    Dropdown:OnChanged(function(Value)
        Key = PetsShow[Value]
    end)

    local Toggle = Tabs.Main:AddToggle("New", {Title = "Auto pet", Default = false})
    Toggle:OnChanged(function()
        PetFarm = Options.New.Value
    end)

    local Toggle = Tabs.Main:AddToggle("New1", {Title = "SwitchOutFullyGrown", Default = false})
    Toggle:OnChanged(function()
        SwitchOutFullyGrown = Options.New1.Value
    end)

    local Toggle = Tabs.Main:AddToggle("New12", {Title = "SwitchOutEgg", Default = false})
    Toggle:OnChanged(function()
        SwitchOutEgg = Options.New12.Value
    end)

    local Toggle = Tabs.Main:AddToggle("New123", {Title = "Switch Out same Pet Species", Default = false})
    Toggle:OnChanged(function()
        True = Options.New123.Value
    end)

    local Dropdown = Tabs.Main:AddDropdown("s", {Title = "Pets Species",Values = JoJo,Multi = false,Default = 1,})
    Dropdown:OnChanged(function(Value)
        sp = Value
    end)

    local Toggle = Tabs.Main:AddToggle("New1231", {Title = "Auto use Age Pot", Default = false})
    Toggle:OnChanged(function()
        Grow = Options.New1231.Value
    end)

    local Dropdown = Tabs.Main:AddDropdown("a", {Title = "Pets Use potion on", Values = List, Multi = false, Default = 1,})
    Dropdown:OnChanged(function(Value)
        Petsc = Value
    end)

    local Toggle = Tabs.Main:AddToggle("Hi", {Title = "Healing Aura", Default = false})
    Toggle:OnChanged(function()
        HealOthers = Options.Hi.Value
    end)

    local Toggle = Tabs.Main2:AddToggle("Hi1", {Title = "Anti Pick Up", Default = false})
    Toggle:OnChanged(function()
        Family = Options.Hi1.Value
        if Family then
            ReplicatedStorage.API["FamilyAPI/CreateFamily"]:InvokeServer() 
        elseif not Family then
            ReplicatedStorage.API["FamilyAPI/LeaveFamily"]:InvokeServer()
        end
    end)

    local Toggle = Tabs.Main2:AddToggle("Hi2", {Title = "Auto buy egg", Default = false})
    Toggle:OnChanged(function()
        Lol2 = Options.Hi2.Value
    end)

    local Dropdown = Tabs.Main2:AddDropdown("a13", {Title = "Eggs",Values = Eggs,Multi = false,Default = 1,})
    Dropdown:OnChanged(function(Value)
        Egg = Value
    end)

    local Toggle = Tabs.Main2:AddToggle("Hi21", {Title = "Auto buy Gift", Default = false})
    Toggle:OnChanged(function()
        Loll = Options.Hi21.Value
    end)

    local Dropdown = Tabs.Main2:AddDropdown("a132", {Title = "Gifts",Values = gifts,Multi = false,Default = 1})
    Dropdown:OnChanged(function(Value)
        Gift = Value
    end)

    local Toggle = Tabs.Main2:AddToggle("Hi3", {Title = "Auto Open Gifts", Default = false})
    Toggle:OnChanged(function()
        System = Options.Hi3.Value
    end)

    Tabs.Main2:AddButton({Title = "Grab Trading Linence",Description = "Grabs Trading Linence",Callback = function()
        RE("TradeAPI/BeginQuiz"):FireServer()
        for i,v in pairs(getgc(true)) do
            if type(v) == "table" and rawget(v,"question_index") then
                for i,v in pairs(v.quiz) do
                    RE("TradeAPI/AnswerQuizQuestion"):FireServer(v.answer)
                end 
            end 
        end 
    end})

    Tabs.Main3:AddButton({Title = "Go To Store",Description = "Goes to selected store",Callback = function()
        spawn(function()
            pcall(function()
                GoToStore(Ass)
                Player.Character.HumanoidRootPart.CFrame = Workspace.Interiors:FindFirstChildWhichIsA('Model').Doors.MainDoor.WorkingParts.TouchToEnter.CFrame:ToWorldSpace(CFrame.new(0, 0, -6))
            end)
        end)
    end})

    local Dropdown = Tabs.Main3:AddDropdown("s", {Title = "Stores",Values = Stores,Multi = false,Default = 1,})
    Dropdown:OnChanged(function(Value)
        Ass = Value
    end)

    Tabs.Main3:AddButton({Title = "Go To Home",Description = "Goes to House",Callback = function()
        spawn(function()
            GoToHome()
            Player.Character.HumanoidRootPart.CFrame = Workspace.HouseInteriors.blueprint[Player.Name].Doors.MainDoor:GetModelCFrame():ToWorldSpace(CFrame.new(0, 0, -6)) 
        end)
    end})
    
    Tabs.Main3:AddButton({Title = "Go To MainMap",Description = "Goes to MainMap",Callback = function()
        spawn(function()
            GoToMainMap()
            Player.Character.HumanoidRootPart.CFrame = Workspace.Interiors:FindFirstChildWhichIsA("Model"):GetModelCFrame():ToWorldSpace(CFrame.new(0, 0, -6))
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(-247.35408, 17.3820152, -1518.88879) 
        end)
    end})
end
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Main)
Window:SelectTab(1)

Fluent:Notify({
    Title = "Noot",
    Content = "The script has been loaded.",
    Duration = 8
})

SaveManager:LoadAutoloadConfig()
print("Load Check GUI took ".. tick() - Tick ..  " Seconds to load")
