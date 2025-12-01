local Player = game.Players.LocalPlayer
local Tycoon = Player.PlayerTycoon.Value
local ActiveTycoon = Player.ActiveTycoon.Value
local AdjustSpeed = Tycoon.AdjustSpeed
local Ores = game.Workspace.DroppedParts:FindFirstChild(Tycoon.Name)
local GUI = Player.PlayerGui:WaitForChild("GUI")
local AutoExchangeGift = false
local LastGift = os.time()
local UILib = loadstring(game:HttpGet("https://raw.githubusercontent.com/MX6-RBX/UiLib/refs/heads/main/UiLib.lua"))()
local MainUi = UILib.new("Miners Haven Hub | MX6")
local BoostPage = MainUi:addPage("Event","1485575235")
local BoostSection = BoostPage:addSection("Auto Upgrade")
local TPPos = Tycoon.Base.CFrame + Vector3.new(0,10,0)
local Internal = Tycoon:FindFirstChild("Silicon Excavator").Model.Internal
Internal.ProximityPrompt.RequiresLineOfSight = false
local Furnace = Tycoon:FindFirstChild("Present Center").Model.Conv
local ConveyorSpeed = 5

local function Exchange()
	local Time = os.time()-LastGift
	local TimeLeft = 15-Time
	if Time < 15 then
		wait(TimeLeft+3)
	end
	Player.Character.HumanoidRootPart.CFrame =game.Workspace.Map.SantaModel.Santa.CamPos.CFrame
	wait(3)
	game:GetService("ReplicatedStorage").EventControllers.Christmas.CashInGift:InvokeServer()
	LastGift = os.time()
	wait(1)
	Player.Character.HumanoidRootPart.CFrame = Internal.CFrame +Vector3.new(0,5,0)
	wait(1)
	keypress(90)
	wait(0.1)
	keyrelease(90)
end

local AutoGift = BoostSection:addToggle("Auto Exhange Gift",false,function(Val)
	AutoExchangeGift = Val
	if Player.MostRecentObject.Value and Player.MostRecentObject.Value.Name == "CreatedPresent" and Val == true then
		Exchange()
	end
end)
local ConveyorSpeedSlider = BoostSection:addSlider("Conveyor Speed(Max 30)",1,5,100,function(val)
	ConveyorSpeed = val or 5
	AdjustSpeed.Value = ConveyorSpeed/5
end)
game.Workspace.ChildAdded:Connect(function(Child)
	if Child.Name == "CreatedPresent" and (Child.Position-Furnace.Position).Magnitude <= 20 then
		if not AutoExchangeGift then return end
		Child.ProximityPrompt.RequiresLineOfSight = false
		wait(0.5)
		Player.Character.HumanoidRootPart.CFrame = Child.CFrame + Vector3.new(0,5,0)
		wait(1)
		keypress(90)
		wait(0.1)
		keyrelease(90)
	end
end)

local VS = game:GetService("VirtualUser")
game.Players.LocalPlayer.Idled:Connect(function()
	VS:CaptureController()
	VS:ClickButton2(Vector2.new())
end)
Player.MostRecentObject.Changed:Connect(function()
	if not AutoExchangeGift then return end 
	if Player.MostRecentObject.Value and Player.MostRecentObject.Value.Name == "CreatedPresent" then
		Exchange()
	end
end)

