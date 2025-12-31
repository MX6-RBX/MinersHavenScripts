local Chat = game:GetService("TextChatService")
local channel = Chat:WaitForChild('TextChannels').RBXGeneral
local Player = game.Players.LocalPlayer
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local MainUi = Rayfield:CreateWindow({
	Name = "MX6 Miners Haven Hub",
	Icon = 0,
	LoadingTitle = "MX6 Miners Haven Hub",
	LoadingSubtitle = "by MX6",
	ShowText = "Using Rayfield UI",
	Theme = "Default", 

	ToggleUIKeybind = "K",

	DisableRayfieldPrompts = true,
	DisableBuildWarnings = false, 

	ConfigurationSaving = {
		Enabled = true,
		FolderName = "MX6 Hub Settings", 
		FileName = "MinersHavenHub"
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

local  CustomThemeTable = {
	TextColor = Color3.fromRGB(240, 240, 240),

	Background = Color3.fromRGB(25, 25, 25),
	Topbar = Color3.fromRGB(34, 34, 34),
	Shadow = Color3.fromRGB(20, 20, 20),

	NotificationBackground = Color3.fromRGB(20, 20, 20),
	NotificationActionsBackground = Color3.fromRGB(230, 230, 230),

	TabBackground = Color3.fromRGB(80, 80, 80),
	TabStroke = Color3.fromRGB(85, 85, 85),
	TabBackgroundSelected = Color3.fromRGB(210, 210, 210),
	TabTextColor = Color3.fromRGB(240, 240, 240),
	SelectedTabTextColor = Color3.fromRGB(50, 50, 50),

	ElementBackground = Color3.fromRGB(35, 35, 35),
	ElementBackgroundHover = Color3.fromRGB(40, 40, 40),
	SecondaryElementBackground = Color3.fromRGB(25, 25, 25),
	ElementStroke = Color3.fromRGB(50, 50, 50),
	SecondaryElementStroke = Color3.fromRGB(40, 40, 40),

	SliderBackground = Color3.fromRGB(50, 138, 220),
	SliderProgress = Color3.fromRGB(50, 138, 220),
	SliderStroke = Color3.fromRGB(58, 163, 255),

	ToggleBackground = Color3.fromRGB(30, 30, 30),
	ToggleEnabled = Color3.fromRGB(0, 146, 214),
	ToggleDisabled = Color3.fromRGB(100, 100, 100),
	ToggleEnabledStroke = Color3.fromRGB(0, 170, 255),
	ToggleDisabledStroke = Color3.fromRGB(125, 125, 125),
	ToggleEnabledOuterStroke = Color3.fromRGB(100, 100, 100),
	ToggleDisabledOuterStroke = Color3.fromRGB(65, 65, 65),

	DropdownSelected = Color3.fromRGB(40, 40, 40),
	DropdownUnselected = Color3.fromRGB(30, 30, 30),

	InputBackground = Color3.fromRGB(30, 30, 30),
	InputStroke = Color3.fromRGB(65, 65, 65),
	PlaceholderColor = Color3.fromRGB(178, 178, 178)
}

if not Player:FindFirstChild("BaseDataLoaded") then 
	Rayfield:Notify({
		Title = "Waiting on game",
		Content = "Please Load into a slot to allow the script to finnish loading",
		Duration = 5,
		Image = 4483362458,
	})
end
local Tycoon = Player.PlayerTycoon.Value
local ActiveTycoon = Player.ActiveTycoon.Value
local AdjustSpeed = Tycoon.AdjustSpeed
local Ores = game.Workspace.DroppedParts:FindFirstChild(Tycoon.Name)
local GUI = Player.PlayerGui:WaitForChild("GUI")
local PlaceItem = game.ReplicatedStorage.PlaceItem 
local buyItem = game.ReplicatedStorage.BuyItem 
local RemoteDrop = game.ReplicatedStorage.RemoteDrop
local ClearBase = game.ReplicatedStorage.DestroyAll
local Money = GUI:FindFirstChild("Money")
local Boxes = game.Workspace.Boxes
local Layout1 = "Layout1"
local Layout2 = "None"
local MinWait = 20
local LayoutWaitTime = 10
local AutoRebirth = false
local Rebirthing = false
local UsingMoneyLoop = false
local OreBoost = false
local OreBoostActive = false
local AutoDrop = false
local Furnace = nil
local IndMine = nil
local OreTracking = false
local FarmRp = false
local TrackBoxes = false
local TestingMode = false
local AddRandomness = false
local Fuel = false
local WalkSpeed = 16
local JumpPower = 50

local WaitToRebirth = false
local Skips = 0
local CollectingBoxes = false
local Blur = true
local WithdrawBase = false
local OpenBoxes = false
local UseCloversValue = Player:FindFirstChild("UseClover")
local UseClovers = UseCloversValue
local SelectedBox = "Regular"
local UpgraderSize = 1
local SingleItemUpgrade = ""
local Slipstream = ""
local ConveyorSpeed = 5
local FakeName = ""
local CTag = "[MX6]"
local SpoofLife =false
local SpoofName = false
local LifeVal = 0 
local FastOreBoost = false
local FarmBoxes = false
local UpgradeLoopCount = 1
local AutoDrop = false


local GUi = Instance.new("BillboardGui")
local Box = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")
GUi.Name = "GUi"
GUi.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
GUi.Active = true
GUi.ExtentsOffset = Vector3.new(0, 2, 0)
GUi.LightInfluence = 1.000
GUi.Size = UDim2.new(0, 200, 0, 50)

Box.Name = "Box"
Box.Parent = GUi
Box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Box.BorderColor3 = Color3.fromRGB(0, 0, 0)
Box.BorderSizePixel = 0
Box.Size = UDim2.new(0, 200, 0, 50)
Box.Font = Enum.Font.SourceSans
Box.TextColor3 = Color3.fromRGB(0, 0, 0)
Box.TextSize = 14.000
Box.TextColor3 = Color3.new(1,1,1)
Box.TextStrokeColor3 = Color3.new(0,0,0)
Box.TextStrokeTransparency = 0
Box.TextScaled = true
Box.BackgroundTransparency = 1

UICorner.Parent = Box
local Suffixes = { "k", "M", "B", "T", "qd", "Qn", "sx", "Sp", "O", "N", "de", "Ud", "DD", "tdD", "qdD", "QnD", "sxD", "SpD", "OcD", "NvD", 
	"Vgn", "UVg", "DVg", "TVg", "qtV", "QnV", "SeV", "SPG", "OVG", "NVG", "TGN", "UTG", "DTG", "tsTG", "qtTG", "QnTG", "ssTG", "SpTG", "OcTG", 
	"NoTG", "QdDR", "uQDR", "dQDR", "tQDR", "qdQDR", "QnQDR", "sxQDR", "SpQDR", "OQDDr", "NQDDr", "qQGNT", "uQGNT", "dQGNT", "tQGNT", "qdQGNT", 
	"QnQGNT", "sxQGNT", "SpQGNT", "OQQGNT", "NQQGNT", "SXGNTL", "USXGNTL", "DSXGNTL", "TSXGNTL", "QTSXGNTL", "QNSXGNTL", "SXSXGNTL", "SPSXGNTL", 
	"OSXGNTL", "NVSXGNTL", "SPTGNTL", "USPTGNTL", "DSPTGNTL", "TSPTGNTL", "QTSPTGNTL", "QNSPTGNTL", "SXSPTGNTL", "SPSPTGNTL", "OSPTGNTL",
	"NVSPTGNTL", "OTGNTL", "UOTGNTL", "DOTGNTL", "TOTGNTL", "QTOTGNTL","QNOTGNTL", "SXOTGNTL", "SPOTGNTL", "OTOTGNTL", "NVOTGNTL", "NONGNTL", 
	"UNONGNTL", "DNONGNTL", "TNONGNTL", "QTNONGNTL", "QNNONGNTL", "SXNONGNTL", "SPNONGNTL", "OTNONGNTL", "NONONGNTL", "CENT", "UNCENT","inf" }  

if game:GetService("MarketplaceService"):UserOwnsGamePassAsync(Player.UserId,13046381) then
	BoxWait = 4
	print("Box Wait changed")
end

local function shorten(Input)
	local Negative = Input < 0
	Input = math.abs(Input)

	local Paired = false
	for i,v in pairs(Suffixes) do
		if not (Input >= 10^(3*i)) then
			Input = Input / 10^(3*(i-1))
			local isComplex = (string.find(tostring(Input),".") and string.sub(tostring(Input),4,4) ~= ".")
			Input = string.sub(tostring(Input),1,(isComplex and 4) or 3) .. (Suffixes[i-1] or "")
			Paired = true
			break;
		end
	end
	if not Paired then
		local Rounded = math.floor(Input)
		Input = tostring(Rounded)
	end

	if Negative then
		return "-"..Input
	end
	return Input
end

local MoneyLoopables = {
	["Large Ore Upgarder"] ={Cap = 50e+3,Effect = nil,MinVal = nil},
	["Solar Large Upgrader"]={Cap = 50e+3,Effect = nil,MinVal = nil},
	["Precision Refiner"]= {Cap = 1e+8,Effect = "Fire",MinVal = nil},
	["Rainbow Upgrader"] ={Cap = 1e+8,Effect = nil,MinVal = nil},
	["Way-Up-High Upgrader"]={Cap =1e+9,Effect = nil,MinVal = nil},
	["Digital Ore Cleaner"]={Cap = 10e+9,Effect = nil,MinVal = nil},
	["Freon-Blast Upgrader"]= {Cap = 125e+9,Effect = nil,MinVal = nil},
	["Radioactive Refiner"]={Cap = 500e+9,Effect = nil,MinVal = nil},
	["Fire-Blast Upgrader"]={Cap = 64e+9,Effect = "Fire",MinVal = nil},
	["Serpentine Upgrader"]={Cap = 1e+12,Effect = nil,MinVal = nil,},
	["Suspended Refiner"]={Cap = 1e+18,Effect = nil,MinVal = nil},
	["Molten Upgrader"]={ Cap = 50e+18,Effect = nil,MinVal = 1e+12},
	["Advanced Ore Atomizer"]={ Cap = 1e+21,Effect = nil,MinVal = nil},
	["Freon Suppressor"]={Cap = 100e+21,Effect = nil,MinVal = nil},
	["Horizon Centrifuge"]={Cap = 1e+24,Effect = nil,MinVal = 1e+21},
	["Ore Thermocrusher"]={ Cap = 100e+24,Effect = nil,MinVal = nil},
	["Suspended Lava Refiner"]={ Cap = 1e+27,Effect = nil,MinVal = nil},
	["Ore Transistor"]={Cap = 1e+30,Effect = nil,MinVal = 1e+24},
	["Ore Transponder"]={ Cap = 1e+33,Effect = nil,MinVal = nil},
	["Morning Star"]={ Cap = 1e+30,Effect = "Fire",MinVal = nil,MinWait = 1.5},
	["⭐ Celestial Morning Star ⭐"]={Cap = 1e+30,Effect = "Fire",MinVal = nil,MinWait = 1.5},
	["Red Giant"]={ Cap = 1e+60,Effect = "Fire",MinVal = nil,MinWait = 1.5},
	["⭐ Wholesome Red Giant ⭐"]={ Cap = 1e+60,Effect = "Fire",MinVal = nil,MinWait = 1.5},
	["Catalyzed Star"]={ Cap = 1e+60,Effect = "Fire",MinVal = nil,MinWait = 1.5},
	["Neutron Star"]={ Cap = 1e+72,Effect = "Fire",MinVal = nil,MinWait = 1.5},
	["⭐ Wholesome Neutron Star ⭐"]={ Cap = 1e+72,Effect = "Fire",MinVal = nil,MinWait = 1.5},
	["Blue Supergiant"]={ Cap = 1e+90,Effect = "Fire",MinVal = nil,MinWait = 1.5},
	["⭐ Hypergiant Blue Supergiant ⭐"]={ Cap = 1e+90,Effect = "Fire",MinVal = nil,MinWait = 1.5},
	["Sinister Sepulcher"]={ Cap = 1e+99,Effect = nil,MinVal = nil,MinWait = nil},
	["Renegade Sinister Sepulcher"]={ Cap = 1e+99,Effect = nil,MinVal = nil,MinWait = 0.03},
	["⭐ Ornate Sinister Sepulcher ⭐"]={ Cap = 1e+99,Effect = nil,MinVal = nil,MinWait = 0.03},

}
--⭐ Ornate Sinister Sepulcher ⭐     Renegade Sinister Sepulcher      Sinister Sepulcher
local EffectRemovers = {
	"Wild Spore", 
	"Deadly Spore", 
	"Azure Spore", 
	"The Death Cap"
}

local ResettersNames = {
	"Tesla Resetter",
	"Tesla Refuter",
	"Black Dwarf",
	"Void Star",
	"The Ultimate Sacrifice",
	"The Final Upgrader",
	"Daestrophe",
	"⭐ Advanced Tesla Refuter ⭐",
	"⭐ Advanced Tesla Resetter ⭐",
	"⭐ Spooky Tesla Resetter ⭐"
}

local Slipstreams = {"None"}	
local OreTrackers = {}
local BoxTrackers = {}
local ELayout = loadstring(game:HttpGet('https://raw.githubusercontent.com/MX6-RBX/MinersHavenScripts/refs/heads/main/BasicFirstLife.lua'))()
local UILib = loadstring(game:HttpGet("https://raw.githubusercontent.com/MX6-RBX/UiLib/refs/heads/main/UiLib.lua"))()

for i,v in  game.ReplicatedStorage.Items:GetChildren() do
	if v.Tier.Value == 78 then
		table.insert(Slipstreams,v.Name)
	end
end

local function LoadExternlLayout(Layout)--Converts a shared layout string to a placeable layout
	if Layout then 
		local PlaceTable = {}
		for i,v in pairs(Layout) do
			spawn(function()
				local Item = game.ReplicatedStorage.Items:FindFirstChild(v["Name"])
				local P = string.split(v["Pos"],",")
				local Pos = CFrame.new(P[1],P[2],P[3],P[4],P[5],P[6],P[7],P[8],P[9],P[10],P[11],P[12])
				if Item.ItemType.Value >=1 and Item.ItemType.Value <5  then
					if Player.PlayerGui.GUI.Money.Value >= Item.Cost.Value then
						buyItem:InvokeServer(Item.Name,1)
						PlaceItem:InvokeServer(v.Name,  Pos+Player.PlayerTycoon.Value.Base.Position, {Player.PlayerTycoon.Value.Base}) 
					else
						print("Cant buy item :(")
					end
				else
					PlaceItem:InvokeServer(Item.Name,  Pos, {Player.PlayerTycoon.Value.Base}) 
				end
			end)
		end
		return 
	else
		return nil
	end 
end

local function AddBoxTrack(Box)
	local Ui = GUi:Clone()
	Ui.Box.Text = Box.Name
	Ui.AlwaysOnTop = true
	Ui.Box.BackgroundTransparency = 0
	if Box:IsA("Model") and Box:FindFirstChild("Crate") then
		Ui.Box.BackgroundColor3 = Box.Crate.Color
		Ui.Parent = Box.Crate
		Ui.Adornee = Box.Crate

	else
		Ui.Box.BackgroundColor3 = Box.Color
		Ui.Parent = Box
		Ui.Adornee = Box
	end
	Ui.Enabled = TrackBoxes
	table.insert(BoxTrackers,Ui)
end

local function CollectBoxes()
	if not CollectingBoxes then
		local Pos = Player.Character.HumanoidRootPart.CFrame 
		CollectingBoxes = true

		for i,v in Boxes:GetChildren() do
			if v:IsA("Model") and v:FindFirstChild("Crate") then
				Player.Character.HumanoidRootPart.CFrame = v.Crate.CFrame		
			else
				Player.Character.HumanoidRootPart.CFrame = v.CFrame	
			end
			wait(0.5)
		end
		CollectingBoxes = false
		Player.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0,0,0)
		Player.Character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0,0,0)
		Player.Character.HumanoidRootPart.CFrame = Pos
	end
end

local function AddTracker(ore)
	repeat wait() until ore:FindFirstChild("Cash")
	local Ui = GUi:Clone()
	Ui.Box.Text = "$"..shorten(ore.Cash.Value)
	Ui.AlwaysOnTop = true
	Ui.Parent = ore
	Ui.Adornee = ore
	Ui.Enabled = OreTracking
	table.insert(OreTrackers,Ui)
	ore.Cash.Changed:Connect(function()
		local Val = 0
		if ore and ore.Cash then
			Val = ore.Cash.Value or 0
		end
		Ui.Box.Text = "$"..shorten(Val)
	end)
end

local function ToggleBoxTrack(Val)
	TrackBoxes = Val
	for i,v in BoxTrackers do 
		v.Enabled = TrackBoxes
	end
end

local function ToggleOreTrack(Val)
	OreTracking = Val

	for i,v in OreTrackers do
		if v and v.Parent then
			v.Enabled = OreTracking
		end
	end
end

local function ResizeUpgraders()
	for i,v in Tycoon:GetChildren() do
		if v:FindFirstChild("ItemId") and v:FindFirstChild("Plane")  then
			if not v:FindFirstChild("Model") then continue end
			if v.Model:FindFirstChild("Upgrade") then
				if not v.Model.Upgrade:FindFirstChild("BaseSize") then
					local BS = Instance.new("Vector3Value")
					BS.Value = v.Model.Upgrade.Size
					BS.Name = "BaseSize"
					BS.Parent = v.Model.Upgrade
					wait(0.1)
				end
				if TestingMode then
					print(v.Name, "Resized to ",UpgraderSize)
				end
				v.Model.Upgrade.Size = v.Model.Upgrade.BaseSize.Value * UpgraderSize
			end
		end
	end
end
local function RezieSingleUpgrader(Name)
	--print("Resizing: ",Name)
	local Item = Tycoon:FindFirstChild(Name)
	if Item then
		--print("Found")
		if Item:FindFirstChild("Model") and Item.Model:FindFirstChild("Upgrade") then
			--print("Is Item and upgrader")
			if not Item.Model.Upgrade:FindFirstChild("BaseSize") then
				local BS = Instance.new("Vector3Value")
				BS.Value = Item.Model.Upgrade.Size
				BS.Name = "BaseSize"
				BS.Parent = Item.Model.Upgrade
				wait(0.1)
			end
			if TestingMode then
				print(Item.Name, "Resized to ",UpgraderSize)
			end
			Item.Model.Upgrade.Size = Item.Model.Upgrade.BaseSize.Value * UpgraderSize
		end
	end
end

local function ChangeUi(Name)
	if GUI.FocusWindow.Value then  
		GUI.FocusWindow.Value.Visible = false
		wait(0.01)
		GUI.FocusWindow.Value = nil
	end
	local Ui = GUI:FindFirstChild(Name)
	if Ui then
		Ui.Visible = true
		GUI.FocusWindow.Value = Ui
		if TestingMode then
			print("Toggled: "..Name)
		end
	end
end

local function comma(Value)
	local v3, v4, v5 = string.match(tostring(Value), "^([^%d]*%d)(%d*)(.-)$");
	return v3 .. v4:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v5;
end

local function HandleLife(Life)
	local Suffix
	local LastDigit = tonumber(string.sub(tostring(Life),string.len(tostring(Life))))
	local SendLastDigit = tonumber(string.sub(tostring(Life),string.len(tostring(Life-1))))
	if Life <= 20 and Life >= 10 then
		Suffix = "th"
	elseif LastDigit == 1 then
		Suffix = "st"
	elseif LastDigit == 2 and SendLastDigit ~= 1 then
		Suffix = "nd"
	elseif LastDigit == 3 then
		Suffix = "rd"
	else
		Suffix = "th"
	end
	return tostring(comma(Life))..Suffix
end

local function KillOres()
	for i,v in Ores:GetChildren() do
		if v and v:IsA("Part") then
			v.CFrame = Tycoon.Base.CFrame
		end
	end
end

local BoostPage = MainUi:CreateTab("Boost Options", 130772689610761) 
local AutoRebirthSection = BoostPage:CreateSection("Auto Rebirth")
local AutoRebithToggle = BoostPage:CreateToggle({
	Name = "Auto Rebirth",
	CurrentValue = false,
	Flag = "Auto Rebirth",
	Callback = function(Value)
		AutoRebirth = Value or false
		if TestingMode then
			print("Auto Rebirth:",Value)
		end
	end,
})

local WaitForSkips = BoostPage:CreateSlider({
	Name = "Wait for skips",
	Range = {0, 20},
	Increment = 1,
	Suffix = "Skips",
	CurrentValue = 0,
	Flag = "Skips", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		Skips = Value or 0
		if TestingMode then
			print(" Wait for Skips:",Value)
		end
	end,
})

local MinWaitTime = BoostPage:CreateInput({
	Name = "Min Rebirth time",
	CurrentValue = "20",
	PlaceholderText = "20",
	RemoveTextAfterFocusLost = false,
	Flag = "MinWait",
	Callback = function(Text)
		MinWait = tonumber(Text) or 20
		if TestingMode then
			print("Min Wait Time:",Text)
		end
	end,
})

local WaitRandom = BoostPage:CreateToggle({
	Name = "Add Wait Randomnes",
	CurrentValue = false,
	Flag = "WaitRandomnes", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		AddRandomness = Value
		if TestingMode then
			print("Add Wait Randomness:",Value)
		end
	end,
})

local SlipsteamDropDown = BoostPage:CreateDropdown({
	Name = "Stop on Slipstream",
	Options = Slipstreams,
	CurrentOption = {"None"},
	MultipleOptions = false,
	Flag = "StopOnSlipsteam", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Options)
		Slipstream = Options[1]
		if TestingMode then	
			print("Stop on Slipstream:",Options[1])
		end
	end,
})

local Layout1Dropdown = BoostPage:CreateDropdown({
	Name = "First Layout",
	Options = {"Layout1","Layout2","Layout3"},
	CurrentOption = {"Layout1"},
	MultipleOptions = false,
	Flag = "Layout1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Options)
		Layout1 = Options[1]
		if TestingMode then	
			print("First Layout:",Options[1])
		end
	end,
})

local LayoutWaitBox = BoostPage:CreateInput({
	Name = "Layout 2 Load Wait",
	CurrentValue = "5",
	PlaceholderText = "5",
	RemoveTextAfterFocusLost = false,
	Flag = "LayoutLoadWait",
	Callback = function(Text)
		LayoutWaitTime = tonumber(Text) or 5
		if TestingMode then
			print("Layout 2 Load Wait:",Text)
		end
	end,
})

local WithdrawLayoutToggle = BoostPage:CreateToggle({
	Name = "Withdraw between layouts",
	CurrentValue = false,
	Flag = "WithdrawBase", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		WithdrawBase = Value
		if TestingMode then
			print("Add Wait Randomness:",Value)
		end
	end,
})

local Layout2Dropdown = BoostPage:CreateDropdown({
	Name = "Second Layout",
	Options = {"None" ,"Layout1","Layout2","Layout3"},
	CurrentOption = {"None"},
	MultipleOptions = false,
	Flag = "Layout2", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Options)
		Layout2 = Options[1]
		if TestingMode then	
			print("Second Layout:",Options[1])
		end
	end,
})

local AutoDropToggle = BoostPage:CreateToggle({
	Name = "Auto Remote drops",
	CurrentValue = false,
	Flag = "AutoDrop", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		AutoDrop = Value
		if TestingMode then
			print("Auto Drop:",Value)
		end
	end,
})

local BoostSection = BoostPage:CreateSection("Auto Upgrade")
local BoostToggle = BoostPage:CreateToggle({
	Name = "Ore Boost",
	CurrentValue = false,
	Flag = "OreBoost", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		OreBoost = Value
		OreBoostActive = Value
		if TestingMode then
			print("Ore Boost:",Value)
		end
	end,
})
local Paragraph = BoostPage:CreateParagraph({Title = "<b>Upgrade Looping</b>", Content = "<i>Upgrade Loop Count is how many times the ore will go through an upgrader before going to the next, Higher value is slower but more likely to upgrade ores.</i>"})

local LoopCountSlider = BoostPage:CreateSlider({
	Name = "Upgrade Loop Count",
	Range = {1, 5},
	Increment = 1,
	Suffix = "Loop Count",
	CurrentValue = 0,
	Flag = "UpgradeLoopCount", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		UpgradeLoopCount = Value or 1
		if TestingMode then
			print("Upgrade Loop Count:",Value)
		end
	end,
})

local IgnoreFuleToggle = BoostPage:CreateToggle({
	Name = "Using Ind Mine",
	CurrentValue = false,
	Flag = "IndMine", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value) 
		Fuel = true
	end,
})

local MoneyLoopToggle = BoostPage:CreateToggle({
	Name = "Use Money Loopables",
	CurrentValue = false,
	Flag = "MoneyLoopables", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		UsingMoneyLoop = Value
		if TestingMode then
			print("Money Loopables: ",Value)
		end 
	end,
})

local FarmRpToggle = BoostPage:CreateToggle({
	Name = "Farm RP(Disables oreboost and auto rebirth)",
	CurrentValue = false,
	Flag = "FarmRp", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		FarmRp = Value
		if OreBoost then
			BoostToggle:Set(false)
			AutoRebithToggle:Set(false)
			OreBoost = false
			OreBoostActive = false
			AutoRebirth = false
		end
		if TestingMode then
			print("Farm Rp: ",Value)
		end 
	end,
})

local Paragraph = BoostPage:CreateParagraph({Title = "Fast Ore Boost", Content = "Fast Ore boost will use a custom function that some executors have to upgrade the ores quicker. NOTE Not all executors will work so check before using. Enabling this when using an unsupported executor may brake the script. solara should have this"})

local FastOreBoostToggle = BoostPage:CreateToggle({
	Name = "Enable Fast boost method",
	CurrentValue = false,
	Flag = "FastOreBoost", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		FastOreBoost = Value
		if TestingMode then
			print("Fast Ore Boost: ",Value)
		end 
	end,
})



local UpgraderSection = BoostPage:CreateSection("Item Manipulation")
local ConveyorSpeedSlider = BoostPage:CreateSlider({
	Name = "Conveyor speed",
	Range = {0, 100},
	Increment = 1,
	Suffix = "Conveyor Speed",
	CurrentValue = 5,
	Flag = "ConveyorSpeed", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		ConveyorSpeed = Value or 5
		AdjustSpeed.Value = ConveyorSpeed/5
		if TestingMode then
			print("Conveyor Speed:",ConveyorSpeed)
		end 
	end,
})

local UpgSizeSlider = BoostPage:CreateSlider({
	Name = "Upgrader Size",
	Range = {1, 20},
	Increment = 1,
	Suffix = "Upgrader Size",
	CurrentValue = 1,
	Flag = "UpgraderSize", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		UpgraderSize = Value or 1
	end,
})

local UpgarderNameTextBox = BoostPage:CreateInput({
	Name = "Item Name (Case Sensitive)",
	CurrentValue = "",
	PlaceholderText = "Name",
	RemoveTextAfterFocusLost = false,
	Flag = "ItemName",
	Callback = function(Text)
		SingleItemUpgrade = Text
		if TestingMode then
			print("Upgrader Name:",Text)
		end
	end,
})

local RezieAllButton = BoostPage:CreateButton({
	Name = "Resize All",
	Callback = function()
		if TestingMode then
			print("Resizing all upgraders")
		end
		ResizeUpgraders()
	end,
})

local KillOresButton = BoostPage:CreateButton({
	Name = "Kill Ores",
	Callback = function()
		if TestingMode then
			print("Killing all ores")
		end
		KillOres()
	end,
})

local AutoSection = BoostPage:CreateSection("Other Options")
local OreTrackToggle = BoostPage:CreateToggle({
	Name = "Track Ore Value",
	CurrentValue = false,
	Flag = "TrackOreValue", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		ToggleOreTrack(Value)
		if TestingMode then
			print("Track Ore Value: ",Value)
		end 
	end,
})

local FirstLife = BoostPage:CreateButton({
	Name = "Load Basic First Life Setup(15qd-390qd, Warning loud)",
	Callback = function()
		if TestingMode then
			print("Loading Basic First Life Layout.")
		end
		ClearBase:InvokeServer()
		LoadExternlLayout(ELayout)
	end,
})

local VendorsPage = MainUi:CreateTab("Vendors",6031097225)
local GuiInteractions = VendorsPage:CreateSection("GUI's")
local Craftsman = VendorsPage:CreateButton({
	Name = "Open Crafts Man",
	Callback = function()
		ChangeUi("Craftsman")
	end,
})

local MaksedMan = VendorsPage:CreateButton({
	Name = "Open Masked Man",
	Callback = function()
		ChangeUi("EventShop")
	end,
})

local Boxman = VendorsPage:CreateButton({
	Name = "Open Box man",
	Callback = function()
		ChangeUi("SpookMcDookShop")
	end,
})

local Superstitious = VendorsPage:CreateButton({
	Name = "Open Superstitious Crafting",
	Callback = function()
		ChangeUi("SuperstitiousCrafting")
	end,
})

local TBOK = VendorsPage:CreateButton({
	Name = "Open True Book Of Knowlage",
	Callback = function()
		ChangeUi("BOKBook")
	end,
})

local Phantasm = VendorsPage:CreateButton({
	Name = "Open Phantasm",
	Callback = function()
		ChangeUi("Phantasm")
	end,
})

local Fleabag = VendorsPage:CreateButton({
	Name = "Open Fleabag",
	Callback = function()
		ChangeUi("Fleabag")
	end,
})

local EventMenu = VendorsPage:CreateButton({
	Name = "Open Event",
	Callback = function()
		ChangeUi("EventMenu")
	end,
})

local GiftExchange = VendorsPage:CreateButton({
	Name = "Open Gift Exchange/Present Santa",
	Callback = function()
		if game.Workspace.Map:FindFirstChild("SantaModel") then
			Player.Character.HumanoidRootPart.CFrame = game.Workspace.Map.SantaModel.Santa.CamPos.CFrame
			wait(0.1)
			ChangeUi("GiftExchange")
		else
			Rayfield:Notify({
				Title = "Unable to open",
				Content = "The Gui cant be opened due to the Santa model not being found, this is probably because your playing on solo island.",
				Duration = 5,
				Image = 4483362458,
			})
		end

	end,
})

local BaseTP = VendorsPage:CreateButton({
	Name = "Teleport To Base",
	Callback = function()
		if TestingMode then
			print("Teleporting to base")
		end
		Player.Character.HumanoidRootPart.CFrame = Tycoon.Base.CFrame + Vector3.new(0,10,0)
	end,
})

local BoxSection = VendorsPage:CreateSection("Box Opening")
local BoxSelectDropdown = VendorsPage:CreateDropdown({
	Name = "Select Box",
	Options = {"Regular","Unreal","Inferno","Red-Banded","Spectral","Pumpkin","Luxury","Festive","Magnificent","Twitch","Birthday","Heavenly","Easter","Cake Raffle"},
	CurrentOption = {"Regular"},
	MultipleOptions = false,
	Flag = "BoxSelected", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Options)
		SelectedBox = Options[1]
		if TestingMode then	
			print("Seletced Box:",Options[1])
		end
	end,
})

local UseCloverToggle = VendorsPage:CreateToggle({
	Name = "Use Clovers",
	CurrentValue = UseClovers,
	Flag = nil, -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		if TestingMode then
			print("Toggled Clovers:",Value)
		end
		game.ReplicatedStorage.ToggleBoxItem:InvokeServer("Clover")
		UseClovers = Value
	end,
})

local OpenBoxToggle = VendorsPage:CreateToggle({
	Name = "Auto Open Selected box",
	CurrentValue = OpenBoxes,
	Flag = "OpenBoxes", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		if TestingMode then
			print("Toggle auto Box:",Value)
		end
		OpenBoxes = Value
	end,
})

local OtherOptionsPage = MainUi:CreateTab("Other Options",6023426938)
local TestSection = OtherOptionsPage:CreateSection("Testing")
local TestingToggle = OtherOptionsPage:CreateToggle({
	Name = "Testing Mode(set ore limit to 1 and check F9)",
	CurrentValue = false,
	Flag = "TestingMode", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		local MessageEnd  = Value and "Enabled" or "Disabled"
		print("Testing mode",MessageEnd)
		TestingMode = Value
	end,
})

local VisualSection = OtherOptionsPage:CreateSection("Visual Options")
local BoxTrackToggle = OtherOptionsPage:CreateToggle({
	Name = "Track Dropped Boxes",
	CurrentValue = false,
	Flag = "TrackBoxes", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		ToggleBoxTrack(Value)
		if TestingMode then
			print("Dropped Crate ESP: ",Value)
		end 
	end,
})

local BoxTeleport = OtherOptionsPage:CreateButton({
	Name = "Single Collect Boxes(High ban chance in public Servers)",
	Callback = function()
		if TestingMode then
			print("Collecting Boxes")
		end 
		CollectBoxes()
	end,
})
local AutoBoxTeleportToggle = OtherOptionsPage:CreateToggle({
	Name = "Farm Boxes",
	CurrentValue = false,
	Flag = "AutoFarmBoxes", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		FarmBoxes = Value
		if TestingMode then
			print("Box Farming: ",Value)
		end 
	end,
})

local BlurToggle = OtherOptionsPage:CreateToggle({
	Name = "Disable Game Blur",
	CurrentValue = false,
	Flag = "GameBlur", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		if TestingMode then
			print("game Blur toggle:", Value)
		end 
		Blur = not Value
		game.Lighting.Blur.Enabled = Blur
	end,
})

local CharSection = OtherOptionsPage:CreateSection("Character")
local CharSpeed = OtherOptionsPage:CreateSlider({
	Name = "Player Speed",
	Range = {16, 300},
	Increment = 1,
	Suffix = "Walk Speed",
	CurrentValue = 16,
	Flag = "WalkSpeed", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		if TestingMode then
			print("Player Walk Speed set to",Value)
		end
		Player.Character.Humanoid.WalkSpeed = Value
		WalkSpeed = Value
	end,
})

local CharJump = OtherOptionsPage:CreateSlider({
	Name = "Player Jump",
	Range = {50, 300},
	Increment = 1,
	Suffix = "Jump Power",
	CurrentValue = 50,
	Flag = "JumpPower", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		if TestingMode then
			print("Player Jump set to",Value)
		end
		Player.Character.Humanoid.JumpPower = Value
		JumpPower = Value
	end,
})

local ExternalSection = OtherOptionsPage:CreateSection("Useful Scripts")
local LayoutStealer = OtherOptionsPage:CreateButton({
	Name = "Layout Stealer(Keybind N)",
	Callback = function()
		if TestingMode then
			print("Loading External Script: Layout Stealer")
		end
		if game.CoreGui:FindFirstChild("LayoutsStealer") then return end
		loadstring(game:HttpGet("https://raw.githubusercontent.com/MX6-RBX/MinersHavenScripts/refs/heads/main/LayoutLoaderRaw.lua"))()
	end,
})

local ItemTracker = OtherOptionsPage:CreateButton({
	Name = "Item Tracker(Keybnd T)",
	Callback = function()
		if TestingMode then
			print("Loading External Script: Item Tracker")
		end
		if game.CoreGui:FindFirstChild("ItemTracker") then return end
		loadstring(game:HttpGet("https://raw.githubusercontent.com/MX6-RBX/MinersHavenScripts/refs/heads/main/MinersHavenItemTracker.lua"))()
	end,
})

local SpoofPage = MainUi:CreateTab("Spoofer",6031215978)
local InfoSection = SpoofPage:CreateSection("Info")
local Paragraph = SpoofPage:CreateParagraph({Title = "<b>!WARNING!</b>", Content = "Spoofed Chats are local, Other player will seen tham as your roblox name."})

local SpoofSection = SpoofPage:CreateSection("Spoof Info")
local SpoofNameText = SpoofPage:CreateInput({
	Name = "Fake Name",
	CurrentValue = "",
	PlaceholderText = "Fake Name",
	RemoveTextAfterFocusLost = false,
	Flag = "FakeName",
	Callback = function(Text)
		if TestingMode then
			print("Fake Name set to",Text)
		end
		FakeName =Text or Player.Name
	end,
})

local SpoofedNameToggle = SpoofPage:CreateToggle({
	Name = "Spoof Name",
	CurrentValue = false,
	Flag = "SpoofName", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		if TestingMode then
			print("Toggled Name Spoofing:",Value)
		end
		SpoofName = Value
	end,
})

local CutsomTagText = SpoofPage:CreateInput({
	Name = "Custom Chat Tag(Rich Text Compatible)",
	CurrentValue = "[MX6]",
	PlaceholderText = "[MX6]",
	RemoveTextAfterFocusLost = false,
	Flag = "FakeTag",
	Callback = function(Text)
		if TestingMode then
			print("Fake Tag set to",Text)
		end
		CTag =Text
	end,
})

local LifeRandomness = SpoofPage:CreateSlider({
	Name = "Additional Lifes",
	Range = {0, 5000},
	Increment = 1,
	Suffix = "Lives",
	CurrentValue = 0,
	Flag = "AddLives", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		if TestingMode then
			print("Exta Lives set to:",Value)
		end
		LifeVal = Value or 0
	end,
})

local SpoofedLifeToggle = SpoofPage:CreateToggle({
	Name = "Spoof Rebirtrhs",
	CurrentValue = false,
	Flag = "SpoofLife", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		if TestingMode then
			print("Spoof Lives toggle: ",Value)
		end
		SpoofLife = Value
	end,
})

local Options = MainUi:CreateTab("UI Options",6031280882)
local UiOptionsSection = SpoofPage:CreateSection("UI Theme")
local ThemeDropdown = Options:CreateDropdown({
	Name = "GUI Theme",
	Options = {"Default","AmberGlow","Amethyst","Bloom","DarkBlue","Green","Light","Ocean","Serenity","Custom"},
	CurrentOption = {"Default"},
	MultipleOptions = false,
	Flag = "GUITheme", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Options)
		print(Options)
		if Options[1] == "Custom" then
			MainUi.ModifyTheme(CustomThemeTable)
		else
			MainUi.ModifyTheme(Options[1])
		end
	end,
})

local AdvUiOptionsSection = Options:CreateSection("Advanced UI Theme")
local Paragraph = Options:CreateParagraph({Title = "<b>Advanced Color Editing</b>", Content = "This allows for individual control of each color for parts of the gui"})
-- Text Color
local TextColorPicker = Options:CreateColorPicker({
	Name = "Text Color",
	Color = Color3.fromRGB(240, 240, 240),
	Flag = "TextColor",
	Callback = function(Value)
		CustomThemeTable.TextColor = Value or Color3.fromRGB(240, 240, 240)
	end
})

-- Background
local BackgroundPicker = Options:CreateColorPicker({
	Name = "Background",
	Color = Color3.fromRGB(25, 25, 25),
	Flag = "Background",
	Callback = function(Value)
		CustomThemeTable.Background = Value or Color3.fromRGB(25, 25, 25)
	end
})

-- Topbar
local TopbarPicker = Options:CreateColorPicker({
	Name = "Topbar",
	Color = Color3.fromRGB(34, 34, 34),
	Flag = "Topbar",
	Callback = function(Value)
		CustomThemeTable.Topbar = Value or Color3.fromRGB(34, 34, 34)
	end
})

-- Shadow
local ShadowPicker = Options:CreateColorPicker({
	Name = "Shadow",
	Color = Color3.fromRGB(20, 20, 20),
	Flag = "Shadow",
	Callback = function(Value)
		CustomThemeTable.Shadow = Value or Color3.fromRGB(20, 20, 20)
	end
})

-- Notification Background
local NotificationBackgroundPicker = Options:CreateColorPicker({
	Name = "Notification Background",
	Color = Color3.fromRGB(20, 20, 20),
	Flag = "NotificationBackground",
	Callback = function(Value)
		CustomThemeTable.NotificationBackground = Value or Color3.fromRGB(20, 20, 20)
	end
})

-- Notification Actions Background
local NotificationActionsBackgroundPicker = Options:CreateColorPicker({
	Name = "Notification Actions Background",
	Color = Color3.fromRGB(230, 230, 230),
	Flag = "NotificationActionsBackground",
	Callback = function(Value)
		CustomThemeTable.NotificationActionsBackground = Value or Color3.fromRGB(230, 230, 230)
	end
})

-- Tab Background
local TabBackgroundPicker = Options:CreateColorPicker({
	Name = "Tab Background",
	Color = Color3.fromRGB(80, 80, 80),
	Flag = "TabBackground",
	Callback = function(Value)
		CustomThemeTable.TabBackground = Value or Color3.fromRGB(80, 80, 80)
	end
})

-- Tab Stroke
local TabStrokePicker = Options:CreateColorPicker({
	Name = "Tab Stroke",
	Color = Color3.fromRGB(85, 85, 85),
	Flag = "TabStroke",
	Callback = function(Value)
		CustomThemeTable.TabStroke = Value or Color3.fromRGB(85, 85, 85)
	end
})

-- Selected Tab Background
local TabBackgroundSelectedPicker = Options:CreateColorPicker({
	Name = "Selected Tab Background",
	Color = Color3.fromRGB(210, 210, 210),
	Flag = "TabBackgroundSelected",
	Callback = function(Value)
		CustomThemeTable.TabBackgroundSelected = Value or Color3.fromRGB(210, 210, 210)
	end
})

-- Tab Text Color
local TabTextColorPicker = Options:CreateColorPicker({
	Name = "Tab Text Color",
	Color = Color3.fromRGB(240, 240, 240),
	Flag = "TabTextColor",
	Callback = function(Value)
		CustomThemeTable.TabTextColor = Value or Color3.fromRGB(240, 240, 240)
	end
})

-- Selected Tab Text Color
local SelectedTabTextColorPicker = Options:CreateColorPicker({
	Name = "Selected Tab Text Color",
	Color = Color3.fromRGB(50, 50, 50),
	Flag = "SelectedTabTextColor",
	Callback = function(Value)
		CustomThemeTable.SelectedTabTextColor = Value or Color3.fromRGB(50, 50, 50)
	end
})

-- Element Background
local ElementBackgroundPicker = Options:CreateColorPicker({
	Name = "Element Background",
	Color = Color3.fromRGB(35, 35, 35),
	Flag = "ElementBackground",
	Callback = function(Value)
		CustomThemeTable.ElementBackground = Value or Color3.fromRGB(35, 35, 35)
	end
})

-- Element Background Hover
local ElementBackgroundHoverPicker = Options:CreateColorPicker({
	Name = "Element Background Hover",
	Color = Color3.fromRGB(40, 40, 40),
	Flag = "ElementBackgroundHover",
	Callback = function(Value)
		CustomThemeTable.ElementBackgroundHover = Value or Color3.fromRGB(40, 40, 40)
	end
})

-- Secondary Element Background
local SecondaryElementBackgroundPicker = Options:CreateColorPicker({
	Name = "Secondary Element Background",
	Color = Color3.fromRGB(25, 25, 25),
	Flag = "SecondaryElementBackground",
	Callback = function(Value)
		CustomThemeTable.SecondaryElementBackground = Value or Color3.fromRGB(25, 25, 25)
	end
})

-- Element Stroke
local ElementStrokePicker = Options:CreateColorPicker({
	Name = "Element Stroke",
	Color = Color3.fromRGB(50, 50, 50),
	Flag = "ElementStroke",
	Callback = function(Value)
		CustomThemeTable.ElementStroke = Value or Color3.fromRGB(50, 50, 50)
	end
})

-- Secondary Element Stroke
local SecondaryElementStrokePicker = Options:CreateColorPicker({
	Name = "Secondary Element Stroke",
	Color = Color3.fromRGB(40, 40, 40),
	Flag = "SecondaryElementStroke",
	Callback = function(Value)
		CustomThemeTable.SecondaryElementStroke = Value or Color3.fromRGB(40, 40, 40)
	end
})

-- Slider Background
local SliderBackgroundPicker = Options:CreateColorPicker({
	Name = "Slider Background",
	Color = Color3.fromRGB(50, 138, 220),
	Flag = "SliderBackground",
	Callback = function(Value)
		CustomThemeTable.SliderBackground = Value or Color3.fromRGB(50, 138, 220)
	end
})

-- Slider Progress
local SliderProgressPicker = Options:CreateColorPicker({
	Name = "Slider Progress",
	Color = Color3.fromRGB(50, 138, 220),
	Flag = "SliderProgress",
	Callback = function(Value)
		CustomThemeTable.SliderProgress = Value or Color3.fromRGB(50, 138, 220)
	end
})

-- Slider Stroke
local SliderStrokePicker = Options:CreateColorPicker({
	Name = "Slider Stroke",
	Color = Color3.fromRGB(58, 163, 255),
	Flag = "SliderStroke",
	Callback = function(Value)
		CustomThemeTable.SliderStroke = Value or Color3.fromRGB(58, 163, 255)
	end
})

-- Toggle Background
local ToggleBackgroundPicker = Options:CreateColorPicker({
	Name = "Toggle Background",
	Color = Color3.fromRGB(30, 30, 30),
	Flag = "ToggleBackground",
	Callback = function(Value)
		CustomThemeTable.ToggleBackground = Value or Color3.fromRGB(30, 30, 30)
	end
})

-- Toggle Enabled
local ToggleEnabledPicker = Options:CreateColorPicker({
	Name = "Toggle Enabled",
	Color = Color3.fromRGB(0, 146, 214),
	Flag = "ToggleEnabled",
	Callback = function(Value)
		CustomThemeTable.ToggleEnabled = Value or Color3.fromRGB(0, 146, 214)
	end
})

-- Toggle Disabled
local ToggleDisabledPicker = Options:CreateColorPicker({
	Name = "Toggle Disabled",
	Color = Color3.fromRGB(100, 100, 100),
	Flag = "ToggleDisabled",
	Callback = function(Value)
		CustomThemeTable.ToggleDisabled = Value or Color3.fromRGB(100, 100, 100)
	end
})

-- Toggle Enabled Stroke
local ToggleEnabledStrokePicker = Options:CreateColorPicker({
	Name = "Toggle Enabled Stroke",
	Color = Color3.fromRGB(0, 170, 255),
	Flag = "ToggleEnabledStroke",
	Callback = function(Value)
		CustomThemeTable.ToggleEnabledStroke = Value or Color3.fromRGB(0, 170, 255)
	end
})

-- Toggle Disabled Stroke
local ToggleDisabledStrokePicker = Options:CreateColorPicker({
	Name = "Toggle Disabled Stroke",
	Color = Color3.fromRGB(125, 125, 125),
	Flag = "ToggleDisabledStroke",
	Callback = function(Value)
		CustomThemeTable.ToggleDisabledStroke = Value or Color3.fromRGB(125, 125, 125)
	end
})

-- Toggle Enabled Outer Stroke
local ToggleEnabledOuterStrokePicker = Options:CreateColorPicker({
	Name = "Toggle Enabled Outer Stroke",
	Color = Color3.fromRGB(100, 100, 100),
	Flag = "ToggleEnabledOuterStroke",
	Callback = function(Value)
		CustomThemeTable.ToggleEnabledOuterStroke = Value or Color3.fromRGB(100, 100, 100)
	end
})

-- Toggle Disabled Outer Stroke
local ToggleDisabledOuterStrokePicker = Options:CreateColorPicker({
	Name = "Toggle Disabled Outer Stroke",
	Color = Color3.fromRGB(65, 65, 65),
	Flag = "ToggleDisabledOuterStroke",
	Callback = function(Value)
		CustomThemeTable.ToggleDisabledOuterStroke = Value or Color3.fromRGB(65, 65, 65)
	end
})

-- Dropdown Selected
local DropdownSelectedPicker = Options:CreateColorPicker({
	Name = "Dropdown Selected",
	Color = Color3.fromRGB(40, 40, 40),
	Flag = "DropdownSelected",
	Callback = function(Value)
		CustomThemeTable.DropdownSelected = Value or Color3.fromRGB(40, 40, 40)
	end
})

-- Dropdown Unselected
local DropdownUnselectedPicker = Options:CreateColorPicker({
	Name = "Dropdown Unselected",
	Color = Color3.fromRGB(30, 30, 30),
	Flag = "DropdownUnselected",
	Callback = function(Value)
		CustomThemeTable.DropdownUnselected = Value or Color3.fromRGB(30, 30, 30)
	end
})

-- Input Background
local InputBackgroundPicker = Options:CreateColorPicker({
	Name = "Input Background",
	Color = Color3.fromRGB(30, 30, 30),
	Flag = "InputBackground",
	Callback = function(Value)
		CustomThemeTable.InputBackground = Value or Color3.fromRGB(30, 30, 30)
	end
})

-- Input Stroke
local InputStrokePicker = Options:CreateColorPicker({
	Name = "Input Stroke",
	Color = Color3.fromRGB(65, 65, 65),
	Flag = "InputStroke",
	Callback = function(Value)
		CustomThemeTable.InputStroke = Value or Color3.fromRGB(65, 65, 65)
	end
})

-- Placeholder Color
local PlaceholderColorPicker = Options:CreateColorPicker({
	Name = "Placeholder Color",
	Color = Color3.fromRGB(178, 178, 178),
	Flag = "PlaceholderColor",
	Callback = function(Value)
		CustomThemeTable.PlaceholderColor = Value or Color3.fromRGB(178, 178, 178)
	end
})

local ApplyCustomThemeButton = Options:CreateButton({
	Name = "Apply Custom theme colors",
	Callback = function()
		MainUi.ModifyTheme(CustomThemeTable)
		ThemeDropdown:Set({"Custom"})
	end,
})



local MaxRebirthPrice = 1e241 -- 10 * 10^240 = 10^241
local function RebornPrice(Player)
	local Life = Player.Rebirths.Value+1
	local REBIRTH_PRICE_CAP = 1e241 -- 10NVSPTGNTL
	local REBIRTH_CAP_LIFE = 80351

	if Life >= 80351 then
		return 1e241
	end

	local x = Life - 1
	local cost

	if Life >= 1 and Life <= 40 then
		cost = 2.5 * (10^19) * (x + 1)
	elseif Life >= 41 and Life <= 5000 then
		cost = ((10^19) * ((5 * math.floor(x / 5)) + 2.5) * ((100 * math.floor(x / 25)) + 1) * ((1000 * math.floor(x / 500)) + 1)) ^ ((0.00024 * x) + 1)
	elseif Life >= 5001 then
		cost = ((10^19) * ((5 * math.floor(x / 5)) + 2.5) * ((100 * math.floor(x / 25)) + 1) * ((1000 * math.floor(x / 500)) + 1)) ^ ((0.00024 * math.floor(10 * ((12500 * (x ^ 4)) ^ (1/7)))) + 1)
	else
		-- If currentLife is invalid (e.g., less than 1), return the cost for the first life (Life 1)
		return 2.5 * (10^19) * (1 - 1 + 1) -- This simplifies to 2.5e19, which is cost for life 1 (x=0)
	end

	if cost >= 1e241 then
		return 1e241
	end
	return cost
end

function BoostOre(Ore) 
	if TestingMode then
		print("Ore boost Start")
	end 
	for i,v in Tycoon:GetChildren() do
		if OreBoostActive == false then break end--Oreboost not active
		if not Ore then break end 
		if not v  then break end 
		if MoneyLoopables[v.Name] or table.find(ResettersNames,v.Name) then continue end--Passes money loops and resetters
		if v:FindFirstChild("ItemId") and v:FindFirstChild("Plane")  then
			if not v:FindFirstChild("Model") then continue end
			if v.Model:FindFirstChild("Upgrade") then
				if FastOreBoost then
					print(Ore)
					print(v.Model.Upgrade)
					firetouchinterest(Ore,v.Model.Upgrade,0) 
					wait(0.01)
					firetouchinterest(Ore,v.Model.Upgrade,1)
				else
					for a = 1,UpgradeLoopCount do
						if v and v:FindFirstChild("Model")  then
							Ore.CFrame =v.Model.Upgrade.CFrame 
							wait(0.01)
						end
					end
				end

			elseif v.Model:FindFirstChild("Lava") and not v.Model:FindFirstChild("TeleportSend") then
				if v and v:FindFirstChild("Model") and v.Model:FindFirstChild("Lava") and not v.Model.Lava:FindFirstChild("TeleportSend") then
					if TestingMode then
						print("Has Lava, not a tp")
					end
					if not v.Model:FindFirstChild("Drop") and  (Furnace == nil or Furnace:FindFirstChild("Model") == nil or Furnace.Model:FindFirstChild("Lava") == nil) then 
						Furnace = v	
						if TestingMode then
							print("Furnace set to",v.Name)
						end
					end
					if v.Model:FindFirstChild("Drop") and v.Model:FindFirstChild("Lava") and  (IndMine == nil or IndMine:FindFirstChild("Model") == nil )  then
						IndMine = v
						if TestingMode then
							print("Industrial Mine set to",v.Name)
						end
					end
				end
			end
		end
	end
	if TestingMode then
		print("Ore boost End")
	end 
end
--BaseDataLoaded
function Reset(Ore)
	local Dae = Tycoon:FindFirstChild("Daestrophe") 
	local Sac =  Tycoon:FindFirstChild("The Final Upgrader") or Tycoon:FindFirstChild("The Ultimate Sacrifice")  
	local Star = Tycoon:FindFirstChild("Void Star") or Tycoon:FindFirstChild("Black Dwarf")
	local Tes = Tycoon:FindFirstChild("Tesla Resetter")or Tycoon:FindFirstChild("⭐ Advanced Tesla Resetter ⭐") or Tycoon:FindFirstChild("⭐ Spooky Tesla Resetter ⭐") or Tycoon:FindFirstChild("Tesla Refuter") or Tycoon:FindFirstChild("⭐ Advanced Tesla Refuter ⭐") 
	BoostOre(Ore)
	if Dae and Ore and OreBoostActive then --checks if Daestrophe is on the base
		if TestingMode then
			print("Found Daestrophe")
		end 
		if FastOreBoost then
			firetouchinterest(Ore,Dae.Model.Upgrade,0)
			wait(0.01)
			firetouchinterest(Ore,Dae.Model.Upgrade,1)
		else
			for a = 1,UpgradeLoopCount do
				if Dae and Dae:FindFirstChild("Model") then
					Ore.CFrame = Dae.Model.Upgrade.CFrame
					wait(0.01)
				end
			end
		end

		BoostOre(Ore)
	else
		if TestingMode then
			print("Daestrophe Not found")
		end
	end
	if Sac and Ore and OreBoostActive then  --Checks if either of the sacrifice resetters are on the base 
		if TestingMode then
			print("Found", Sac.Name)
		end 

		if FastOreBoost then
			firetouchinterest(Ore,Sac.Model.Upgrade,0)
			wait(0.01)
			firetouchinterest(Ore,Sac.Model.Upgrade,1)
		else
			for a = 1,UpgradeLoopCount do
				if Sac and Sac:FindFirstChild("Model") then
					Ore.CFrame = Sac.Model.Upgrade.CFrame
					wait(0.01)
				end
			end
		end
		BoostOre(Ore)
	else
		if TestingMode then
			print("Sacrifice resetter Not found")
		end				
	end
	if Star and Ore and OreBoostActive then --Checks if black dwarf or void star is on the base 
		if TestingMode then
			print("Found", Star.Name)
		end 
		if FastOreBoost then
			firetouchinterest(Ore,Star.Model.Upgrade,0)
			wait(0.01)
			firetouchinterest(Ore,Star.Model.Upgrade,1)
		else
			for a = 1,UpgradeLoopCount do
				if Star and Star:FindFirstChild("Model") then
					Ore.CFrame = Star.Model.Upgrade.CFrame
					wait(0.01)
				end
			end
		end
		BoostOre(Ore)
	else
		if TestingMode then
			print("Void star/black dwarf Not found")
		end
	end
	if Tes and Ore and OreBoostActive then --Checks if either tesla is on the base
		if TestingMode then
			print("Found", Tes.Name)
		end 
		if FastOreBoost then
			firetouchinterest(Ore,Tes.Model.Upgrade,0)
			wait()
			firetouchinterest(Ore,Tes.Model.Upgrade,1)
		else
			for a = 1,UpgradeLoopCount do
				if Tes and Tes:FindFirstChild("Model") then
					Ore.CFrame = Tes.Model.Upgrade.CFrame
					wait(0.01)
				end
			end
		end
		BoostOre(Ore)
	else
		if TestingMode then
			print("Tesla Not found")
		end
	end
end

function GetFurnace()
	for i,v in Tycoon:GetChildren() do
		if v and v:FindFirstChild("Model") and v.Model:FindFirstChild("Lava") and not v.Model.Lava:FindFirstChild("TeleportSend") then
			if not v.Model:FindFirstChild("Drop") and  (Furnace == nil or Furnace:FindFirstChild("Model") == nil or Furnace.Model:FindFirstChild("Lava") == nil) then 
				Furnace = v	
			end
			if v.Model:FindFirstChild("Drop") and v.Model:FindFirstChild("Lava") and  (IndMine == nil or IndMine:FindFirstChild("Model") == nil )  then
				IndMine = v
			end
		end
	end
end

function Sell(Ore)
	if Furnace == nil or Furnace:FindFirstChild("Model") == nil or Furnace.Model:FindFirstChild("Lava")then 
		GetFurnace()
	end
	Ore.CFrame = Furnace.Model.Lava.CFrame + Vector3.new(0,1,0)
end

function StartOreBoost(Ore)
	if TestingMode then
		print("Ore Boost Setting up")
	end 
	Ore.Anchored = true
	repeat wait() until Ore:FindFirstChild("Cash")
	if Ore.Cash.Value <= 0 then
		Ore.Anchored = false
		return
	end
	local SavePos = Ore.CFrame
	local MoneyLoop = nil
	local LooperStats 
	local Protect
	if not FastOreBoost then
		Ore.Anchored = false
	end

	if TestingMode then
		print("Ore Boost finished setting up")
	end 
	if UsingMoneyLoop then
		if TestingMode then
			print("Using Money cap Items")
		end 
		for i,v in MoneyLoopables do
			if Tycoon:FindFirstChild(i) then 
				MoneyLoop = Tycoon:FindFirstChild(i)
				LooperStats = i
			end
		end
		for i,v in EffectRemovers do
			if Tycoon:FindFirstChild(i) then 
				Protect = Tycoon:FindFirstChild(i)
			end
		end
		if MoneyLoop then
			if TestingMode then
				print("Found Money Loop item:",MoneyLoop)
			end 
			local Info = MoneyLoopables[MoneyLoop.Name]
			repeat 
				if not Ore or (Info.MinVal and  Ore.Cash.Value < Info.MinVal) then
					break
				end
				if OreBoost == false or OreBoostActive == false then break end
				if FastOreBoost then
					firetouchinterest(Ore,MoneyLoop.Model.Upgrade,0)
					wait(0.01)
					firetouchinterest(Ore,MoneyLoop.Model.Upgrade,1)
					if LooperStats.Effect ~= nil and Protect ~= nil then
						firetouchinterest(Ore,Protect.Model.Upgrade,0)
						wait(0.01)
						firetouchinterest(Ore,Protect.Model.Upgrade,1)
					end
				else
					for a = 1,UpgradeLoopCount do
						Ore.CFrame = MoneyLoop.Model.Upgrade.CFrame
						wait(Info.MinWait or 0.01)
						if LooperStats.Effect ~= nil and Protect ~= nil then
							Ore.CFrame = Protect.Model.Upgrade.CFrame
						end
					end
				end

				wait(0.05)
			until Ore == nil or MoneyLoop == nil or MoneyLoop:FindFirstChild("Model") == nil or Ore:FindFirstChild("Cash") == nil or Ore.Cash.Value >= Info.Cap
			if TestingMode then
				print("Money Loop Finished")
			end 	
		end
	end

	if OreBoostActive then
		Reset(Ore)
	end

	if Ore then
		if TestingMode then
			print("Selling Ore")
		end 
		Ore.AssemblyAngularVelocity = Vector3.new(0,0,0)
		Ore.AssemblyLinearVelocity = Vector3.new(0,0,0)
		if Furnace and Furnace:FindFirstChild("Model") then
			if FastOreBoost then
				firetouchinterest(Ore,Furnace.Model.Lava,0)
				wait(0.01)
				firetouchinterest(Ore,Furnace.Model.Lava,1)
			else
				Ore.Anchored = false
				Ore.CFrame = Furnace.Model.Lava.CFrame + Vector3.new(0,2,0)
			end

		else
			if TestingMode then
				print("No Furnace found, sending ore to spawn location")
			end 
			Ore.Anchored = false
			Ore.CFrame = SavePos	
		end
	end
end

function Load()
	if TestingMode then
		print("Start Layout Loading")
	end 
	if OreBoost then
		OreBoostActive = true
	end
	game.ReplicatedStorage.DestroyAll:InvokeServer()
	wait(0.1)
	if TestingMode then
		print("Load First Layout")
	end 
	game.ReplicatedStorage.Layouts:InvokeServer("Load",Layout1)
	if Layout2 ~= "None" then
		if TestingMode then
			print("Using Second Layout")
		end 
		wait(LayoutWaitTime)
		OreBoostActive = false
		wait(0.3)
		if WithdrawBase then
			game.ReplicatedStorage.DestroyAll:InvokeServer()
			wait(0.1)
		end

		if TestingMode then
			print("Load Second Layout")
		end 
		game.ReplicatedStorage.Layouts:InvokeServer("Load",Layout2)
		wait(0.1)
		if OreBoost then
			OreBoostActive = true
		end
	end
end

GetFurnace()
if Ores then
	Ores.ChildAdded:Connect(function(Child)
		AddTracker(Child)
		if OreBoost then
			if Child:FindFirstChild("Fuel") and Fuel then
				if IndMine and IndMine:FindFirstChild("Model") then
					Child.CFrame = IndMine.Model.Lava.CFrame + Vector3.new(0,1,0)
				end
				return 
			end 
			StartOreBoost(Child)
		elseif FarmRp then
			Sell(Child)
		end
	end)
end

local rebirthing  = false
local LastRebirth = os.time()
local WaitTime = 0
Money.Changed:Connect(function()
	if TestingMode then
		print("Money Updated")
	end 
	local RB = RebornPrice(Player) * (1000^Skips)
	WaitTime= MinWait + math.random(1,20) * (AddRandomness and 1 or 0)
	if TestingMode then
		print("Wait Time: ",WaitTime)
	end 
	if TestingMode then
		print("Rebirth Price: ",RB)
	end 

	if AutoRebirth and not rebirthing and Money.Value > RB and os.time()-LastRebirth >= WaitTime and Tycoon == ActiveTycoon then
		if TestingMode then
			print("Is on their tycoon")
		end 
		rebirthing = true
		OreBoostActive = false
		wait(0.1)
		game.ReplicatedStorage.Rebirth:InvokeServer()
		wait(1)
		rebirthing = false
		LastRebirth = os.time()
		WaitTime = 0
		if AutoRebirth then
			if TestingMode then
				print("Rebirthed")
			end 
			Load()
		end
	end
end)

for i,v in Boxes:GetChildren(1) do
	AddBoxTrack(v)
end

game.ReplicatedStorage.ItemObtained.OnClientEvent:Connect(function(Item,Amount)
	if Item.Tier.Value == 78 and Item.Name == Slipstream then
		AutoRebirth = false
		OreBoostActive = false
	end
end)

game.Workspace.Boxes.ChildAdded:Connect(function(Box)
	AddBoxTrack(Box)
end)

Player.CharacterAdded:Connect(function(character)
	local humanoid = character:WaitForChild("Humanoid")

	-- Set initial properties
	humanoid.WalkSpeed = WalkSpeed
	humanoid.JumpPower = JumpPower

	-- Re-connect the property change signals
	humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
		if humanoid.WalkSpeed < WalkSpeed then
			humanoid.WalkSpeed = WalkSpeed
		end
	end)

	humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
		if humanoid.JumpPower < JumpPower then
			humanoid.JumpPower = JumpPower
		end
	end)
end)


game.Lighting.Blur:GetPropertyChangedSignal("Enabled"):Connect(function()
	game.Lighting.Blur.Enabled = Blur
end)

Chat.OnIncomingMessage = function(Message)
	if Message then
		if Message.Text and not Message.TextSource then
			local NewText = Message.Text
			if string.find(Message.Text, Player.Name)  then 
				if SpoofName then
					NewText = string.gsub(NewText,Player.Name,FakeName)
				end
			end
			if string.find(Message.Text,"was born")then
				local CurrentLifeText = comma(Player.Rebirths.Value+1)
				local NewLife = HandleLife(tonumber(Player.Rebirths.Value+LifeVal))
				if SpoofLife then
					NewText = string.gsub(NewText,CurrentLifeText.."(..)",NewLife)
				end
				Message.Text = NewText
			end
		elseif Message.TextSource then 
			if string.find(Message.PrefixText, tostring(Player.Name)) then 
				if SpoofName then
					Message.PrefixText = string.gsub(Message.PrefixText,tostring(Player.Name),CTag..FakeName)
				end
			elseif not string.find(Message.PrefixText, tostring(Player.Name)) and  string.find(Message.Text, Player.Name) then 
				local NewText = Message.Text
				if SpoofName then
					NewText = string.gsub(NewText,Player.Name,FakeName)
				end
				Message.Text = NewText
			end
		end
	end
end

local VS = game:GetService("VirtualUser")
game.Players.LocalPlayer.Idled:Connect(function()
	VS:CaptureController()
	VS:ClickButton2(Vector2.new())
end)
Rayfield:LoadConfiguration()
--Keep at bottom of script

task.spawn(function()
	while true do
		wait()
		if FarmBoxes then
			local Pos = Player.Character.HumanoidRootPart.CFrame 
			for i,v in Boxes:GetChildren() do
				if v:IsA("Model") and v:FindFirstChild("Crate") then
					Player.Character.HumanoidRootPart.CFrame = v.Crate.CFrame		
				else
					Player.Character.HumanoidRootPart.CFrame = v.CFrame	
				end
				wait(0.5)
			end
			Player.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0,0,0)
			Player.Character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0,0,0)
			Player.Character.HumanoidRootPart.CFrame = Pos
		end
	end
end)

task.spawn(function()
	while true do
		wait(BoxWait)
		local BoxName = SelectedBox or "Regular"
		local Box = Player.Crates:FindFirstChild(SelectedBox)
		if OpenBoxes and  Box and Box.Value >0  then
			game.ReplicatedStorage.MysteryBox:InvokeServer(Box.Name)	
		end 
	end
end)
task.spawn(function()
	while true do
		wait()
		if AutoDrop then 
			RemoteDrop:FireServer()
		end
	end
end)

