
local Player = game.Players.LocalPlayer
local Tycoon = Player.PlayerTycoon.Value
local ActiveTycoon = Player.ActiveTycoon.Value
local AdjustSpeed = Tycoon.AdjustSpeed
local Ores = game.Workspace.DroppedParts:FindFirstChild(Tycoon.Name)
local GUI = Player.PlayerGui:WaitForChild("GUI")
local AutoExchangeGift = false
local LastGift = os.time()
local TPPos = Tycoon.Base.CFrame + Vector3.new(0,10,0)
local Internal = Tycoon:FindFirstChild("Silicon Excavator").Model.Internal
Internal.ProximityPrompt.RequiresLineOfSight = false
local Furnace = Tycoon:FindFirstChild("Present Center").Model.Conv
local ConveyorSpeed = 5
local ESPValue = 65

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

local function AddValueToUi()
	local Ui = GUI:FindFirstChild("GiftExchange")
	for i,v in Ui.Items:GetChildren() do
		if v:FindFirstChild("PresentValue") then
			local ValueText = Instance.new("TextLabel")
			ValueText.Name = "ValueText"
			ValueText.Parent = v
			ValueText.AnchorPoint = Vector2.new(1, 1)
			ValueText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ValueText.BackgroundTransparency = 1.000
			ValueText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ValueText.BorderSizePixel = 0
			ValueText.Position = UDim2.new(1, -3, 1, -3)
			ValueText.Size = UDim2.new(0.3, 0, 0.3, 0)
			ValueText.ZIndex = 67
			ValueText.Font = Enum.Font.SourceSansBold
			ValueText.Text = v.PresentValue.Value
			ValueText.TextColor3 = Color3.fromRGB(255, 255, 255)
			ValueText.TextScaled = true
			ValueText.TextSize = 14.000
			ValueText.TextStrokeTransparency = 0.000
			ValueText.TextWrapped = true
		end
	end
end
AddValueToUi()

local function AddEsp(Pes)
	local Esp = Instance.new("Highlight")
	Esp.FillColor = Color3.fromRGB(100,255,100)
	Esp.FillTransparency = 0.5
	Esp.OutlineColor = Color3.fromRGB(255,100,100)
	Esp.Adornee = Pes
	Esp.Parent = Pes
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local MainUi = Rayfield:CreateWindow({
	Name = "MX6 Miners Haven Auto Gift",
	Icon = 0,
	LoadingTitle = "MX6 Miners Haven Hub",
	LoadingSubtitle = "by MX6",
	ShowText = "Using Rayfield UI",
	Theme = "Default", 

	ToggleUIKeybind = "B",

	DisableRayfieldPrompts = false,
	DisableBuildWarnings = false, 

	ConfigurationSaving = {
		Enabled = false,
		FolderName = "MX6 Hub Settings", 
		FileName = "MinersHavenAutoGiftSettings"
	},

	Discord = {
		Enabled = false, 
		Invite = "discord.gg/eCQnApxxgd", 
		RememberJoins = true
	},

	KeySystem = false, 
	KeySettings = {
		Title = "This Is Just A Test",
		Subtitle = "Key System",
		Note = "Key Is FreeKeys",
		FileName = "MX6MinersHavenHubKeys", 
		SaveKey = true, 
		GrabKeyFromSite = false, 
		Key = {"FreeKeys"}
	}
})

local AutoPage = MainUi:CreateTab("Gift", 130772689610761) 
local AutoRebirthSection = AutoPage:CreateSection("Auto Gift")
local AutoRebithToggle = AutoPage:CreateToggle({
	Name = "Auto farm gifts",
	CurrentValue = false,
	Flag = "",
	Callback = function(Value)
		AutoExchangeGift = Value
	end,
})
local ConveyorSpeedSlider = AutoPage:CreateSlider({
	Name = "Conveyor speed",
	Range = {0, 100},
	Increment = 1,
	Suffix = "Conveyor Speed",
	CurrentValue = 5,
	Flag = "ConveyorSpeed", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		ConveyorSpeed = Value or 5
		AdjustSpeed.Value = ConveyorSpeed/5
	end,
})


local EspThresholdSlider = AutoPage:CreateSlider({
	Name = "ESP Threshold",
	Range = {0, 65},
	Increment = 1,
	Suffix = "EspThreshold",
	CurrentValue = 65,
	Flag = "", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		ESPValue = Value
	end,
})

if Ores then
	Ores.ChildAdded:Connect(function(Ore)
		if  not Ore:FindFirstChild("PresentValue") then return end
		
		Ore.PresentValue.Changed:Connect(function()
			if ESPValue >0 and Ore.PresentValue.Value >= ESPValue then
				AddEsp(Ore)
			end
		end)

	end)
end

game.Workspace.ChildAdded:Connect(function(Child)
	if Child.Name == "CreatedPresent" and (Child.Position-Tycoon.Base.Position).Magnitude <= 230 then
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
