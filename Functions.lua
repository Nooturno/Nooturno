
repeat task.wait() until game:IsLoaded()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Nooturno/Nooturno/main/Global.lua"))()
if KeySystem then
	loadstring(game:HttpGet('https://raw.githubusercontent.com/Nooturno/Nooturno/main/Key.lua'))()
end
if Advertisement then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Nooturno/Nooturno/main/RobloxScriptsAdvertisment.lua"))()
end
local StartTime = tick()
local A = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nooturno/Nooturno/main/V.G-Hub-Games-List.lua"))()

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
		loadstring(game:HttpGet(v))()
	end
end
--Toxic Mods screen thingy And Kiriot22 esp, IY for fly script inspiration, Staylin Save Settings, Felix for being sexy, E621 Anticheat bypass

print("Took ", tick() - StartTime, " To Load <3")

local function Copy()
	setclipboard("No its done not updating anymore")
end
local Gang = Instance.new("BindableFunction")

function Gang.OnInvoke(v)
	if v == "Yes" then
		Copy()
		VG.SendNotification("No", "Why don't you listen", "rbxassetid://8429081004", 15)
	end
end

StarterGui:SetCore("SendNotification",{ Title = "discontinued", Text = "Disabled gone no more updates", Duration = 5, Callback = Gang, Button1 = "Yes", Button2 ="No" })
wait(5)
----------------------------------------------------------------------------------------------
local function Copy()
	setclipboard("https://www.youtube.com/@SirMemeV2")
end
local Gang = Instance.new("BindableFunction")

function Gang.OnInvoke(v)
	if v == "Yes" then
		Copy()
		VG.SendNotification("Sirmemes youtube", "Copying of Sirmemes youtube successful", "rbxassetid://8429081004", 15)
	end
end

StarterGui:SetCore("SendNotification",{ Title = "Sirmemes youtube", Text = "Copy to clipboard?", Duration = 5, Callback = Gang, Button1 = "Yes", Button2 ="No" })

queue_on_teleport[[loadstring(game:HttpGet("https://github.com/1201for/V.G-Hub/blob/main/Extras/Functions"))()]]
