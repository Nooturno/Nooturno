repeat task.wait() until game:IsLoaded()
-- Carregando script Global de forma segura
local success, errorMessage = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Nooturno/Nooturno/main/Global.lua"))()
end)
if not success then
    warn("Erro ao carregar script Global: ", errorMessage)
end

if KeySystem then
    pcall(function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/Nooturno/Nooturno/main/Key.lua'))()
    end)
end

if Advertisement then
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Nooturno/Nooturno/main/RobloxScriptsAdvertisment.lua"))()
    end)
end

local StartTime = tick()
local A = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nooturno/Nooturno/refs/heads/main/Noot-Games-List.lua"))()

local ScreenGui = Instance.new("ScreenGui")
if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
    ScreenGui.Parent = CoreGui
elseif gethui then
    ScreenGui.Parent = gethui()
else
    ScreenGui.Parent = CoreGui
end

local ImageLabel = Instance.new("ImageLabel")
ImageLabel.Parent = ScreenGui
ImageLabel.BackgroundColor3 = Color3.new(1, 1, 1)
ImageLabel.BackgroundTransparency = 1
ImageLabel.Position = UDim2.new(0.5, -(303 / 2), 0.5, -(263 / 2))
ImageLabel.Rotation = 0
ImageLabel.Size = UDim2.new(0, 303, 0, 263)
ImageLabel.Image = "rbxassetid://8429081004"
ImageLabel.ImageTransparency = 1

for Index = 1, 50, 2 do
    ImageLabel.ImageTransparency = ImageLabel.ImageTransparency - 0.1
    wait()
end
ScreenGui:Destroy()

for i, v in next, A do
    if i == game.GameId or i == game.PlaceId then
        pcall(function()
            loadstring(game:HttpGet(v))()
        end)
    end
end

print("Took ", tick() - StartTime, " To Load <3")

queue_on_teleport[[loadstring(game:HttpGet("https://raw.githubusercontent.com/Nooturno/Nooturno/refs/heads/main/Functions.lua"))()]]
