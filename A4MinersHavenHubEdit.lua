--[[ This was made by MX6, and contributed by A4.
     HAPPY HALLOWEEN 2K26
>>>>> UPDATES BY MX6 <<<<<<<
	658
	828-831
]]

local ENV = (getgenv and getgenv()) or _G
local HUB_KEY = "MX6_MinersHavenHub"

if type(ENV[HUB_KEY]) == "table" and type(ENV[HUB_KEY].Unload) == "function" then
	pcall(ENV[HUB_KEY].Unload)
	task.wait(0.2)
end

local function DestroyHubGuis()
	local function wipe(parent)
		if not parent then return end
		for _, child in ipairs(parent:GetChildren()) do
			local n = string.lower(child.Name)
			if string.find(n, "rayfield", 1, true)
				or string.find(n, "mx6", 1, true)
				or string.find(n, "minershaven", 1, true)
				or child.Name == "GUi" then
				pcall(function() child:Destroy() end)
			end
		end
	end
	pcall(function()
		local lp = game:GetService("Players").LocalPlayer
		if lp then wipe(lp:FindFirstChild("PlayerGui")) end
	end)
	pcall(function()
		if gethui then wipe(gethui()) end
	end)
	pcall(function()
		for _, child in ipairs(game:GetService("Workspace"):GetDescendants()) do
			if child:IsA("BillboardGui") and child.Name == "GUi" then
				child:Destroy()
			end
		end
	end)
end
DestroyHubGuis()

local Hub = {
	Alive = true,
	Connections = {},
	ConnectionIndices = {},
	Set = nil,
	ChatHandler = nil,
	GUi = nil,
}
ENV[HUB_KEY] = Hub

local function Track(conn)
	if conn and not Hub.ConnectionIndices[conn] then
		table.insert(Hub.Connections, conn)
		Hub.ConnectionIndices[conn] = #Hub.Connections
	end
	return conn
end

local function Untrack(conn)
	if not conn then return end
	local index = Hub.ConnectionIndices[conn]
	if not index then return end
	local lastIndex = #Hub.Connections
	local lastConn = Hub.Connections[lastIndex]
	Hub.Connections[index] = lastConn
	Hub.Connections[lastIndex] = nil
	Hub.ConnectionIndices[conn] = nil
	if index < lastIndex and lastConn then
		Hub.ConnectionIndices[lastConn] = index
	end
end

local function DisconnectTracked(conn)
	if not conn then return end
	pcall(function() conn:Disconnect() end)
	Untrack(conn)
end

local function TrackForInstance(instance, conn)
	Track(conn)
	if not instance or not conn then return conn end
	local destroyConn
	destroyConn = instance.Destroying:Connect(function()
		DisconnectTracked(conn)
		DisconnectTracked(destroyConn)
	end)
	Track(destroyConn)
	return conn
end

local function HubAlive()
	return Hub.Alive == true and ENV[HUB_KEY] == Hub
end

local function HttpGetText(url)
	local httpRequest = request or http_request
	if type(httpRequest) ~= "function" then
		error("Executor HTTP request API is unavailable")
	end
	local response = httpRequest({Url = url, Method = "GET"})
	if type(response) ~= "table" or response.Success ~= true or type(response.Body) ~= "string" then
		error("HTTP request failed for " .. url .. ": " .. tostring(response and response.StatusCode))
	end
	return response.Body
end

local function LoadExternal(url)
	local source = HttpGetText(url)
	local chunk, compileError = loadstring(source)
	if type(chunk) ~= "function" then
		error("Failed to compile " .. url .. ": " .. tostring(compileError))
	end
	return chunk()
end

local Chat = game:GetService("TextChatService")
local TeleportService = game:GetService("TeleportService")
local SoundService = game:GetService("SoundService")
local Player = game.Players.LocalPlayer
local Rayfield = LoadExternal("https://sirius.menu/rayfield")
local MainUi = Rayfield:CreateWindow({
	Name = "MX6 Miners Haven Hub",
	Icon = 0,
	LoadingTitle = "MX6 Miners Haven Hub",
	LoadingSubtitle = "by MX6 and A4",
	ShowText = "Using Rayfield UI",
	Theme = "Default", 

	ToggleUIKeybind = "K",

	DisableRayfieldPrompts = true,
	DisableBuildWarnings = false, 

	ConfigurationSaving = {
		Enabled = true,
		FolderName = "MX6 Hub Settings", 
		FileName = "MinersHavenHub_" .. Player.Name
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
	},

})

local CustomThemeTable = {
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

local OldMinersHavenTheme = {
	TextColor = Color3.fromRGB(245, 245, 245),
	Background = Color3.fromRGB(68, 68, 74),
	Topbar = Color3.fromRGB(52, 52, 58),
	Shadow = Color3.fromRGB(28, 28, 32),
	NotificationBackground = Color3.fromRGB(52, 52, 58),
	NotificationActionsBackground = Color3.fromRGB(85, 175, 85),
	TabBackground = Color3.fromRGB(88, 88, 96),
	TabStroke = Color3.fromRGB(38, 38, 42),
	TabBackgroundSelected = Color3.fromRGB(65, 150, 215),
	TabTextColor = Color3.fromRGB(235, 235, 240),
	SelectedTabTextColor = Color3.fromRGB(255, 255, 255),
	ElementBackground = Color3.fromRGB(82, 82, 90),
	ElementBackgroundHover = Color3.fromRGB(98, 98, 106),
	SecondaryElementBackground = Color3.fromRGB(58, 58, 64),
	ElementStroke = Color3.fromRGB(40, 40, 44),
	SecondaryElementStroke = Color3.fromRGB(48, 48, 52),
	SliderBackground = Color3.fromRGB(48, 48, 54),
	SliderProgress = Color3.fromRGB(78, 188, 88),
	SliderStroke = Color3.fromRGB(100, 210, 110),
	ToggleBackground = Color3.fromRGB(48, 48, 54),
	ToggleEnabled = Color3.fromRGB(78, 188, 88),
	ToggleDisabled = Color3.fromRGB(105, 105, 112),
	ToggleEnabledStroke = Color3.fromRGB(120, 220, 130),
	ToggleDisabledStroke = Color3.fromRGB(85, 85, 92),
	ToggleEnabledOuterStroke = Color3.fromRGB(38, 38, 42),
	ToggleDisabledOuterStroke = Color3.fromRGB(38, 38, 42),
	DropdownSelected = Color3.fromRGB(65, 150, 215),
	DropdownUnselected = Color3.fromRGB(70, 70, 78),
	InputBackground = Color3.fromRGB(58, 58, 66),
	InputStroke = Color3.fromRGB(100, 100, 110),
	PlaceholderColor = Color3.fromRGB(180, 180, 190),
}

local OldMHStyleActive = false
local OldMHDescConns = {}
local OldMHInputConns = {}
local OldMHStyledInputs = {}
local OldMHRestylePending = false

local function FindRayfieldRoots()
	local roots, seen = {}, {}
	local function add(obj)
		if obj and not seen[obj] then
			seen[obj] = true
			table.insert(roots, obj)
		end
	end
	local function scan(parent)
		if not parent then return end
		for _, child in ipairs(parent:GetChildren()) do
			local n = string.lower(child.Name)
			if string.find(n, "rayfield", 1, true) or string.find(n, "mx6", 1, true) then
				add(child)
			end
		end
	end
	pcall(function()
		local lp = game:GetService("Players").LocalPlayer
		if lp then scan(lp:FindFirstChild("PlayerGui")) end
	end)
	pcall(function() if gethui then scan(gethui()) end end)
	return roots
end

local function FindUiByName(name)
	local playerGui = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui")
	if playerGui and playerGui:FindFirstChild(name) then return playerGui:FindFirstChild(name) end
	local ok, hui = pcall(function() return gethui and gethui() end)
	if ok and hui then return hui:FindFirstChild(name) end
	return nil
end
local function StyleInstanceOldMH(inst)
	if not inst or not inst.Parent then return end

	if inst:IsA("UICorner") then
		pcall(function() inst.CornerRadius = UDim.new(0, 3) end)
		return
	end

	if inst:IsA("UIStroke") then
		pcall(function()
			inst.Thickness = 1.5
			if inst.Transparency > 0.5 then inst.Transparency = 0.25 end
		end)
		return
	end

	if inst:IsA("TextBox") then
		pcall(function()
			inst.Font = Enum.Font.SourceSans
			inst.TextSize = 16
			inst.TextColor3 = Color3.fromRGB(255, 255, 255)
			inst.TextTransparency = 0
			inst.TextStrokeTransparency = 1
			inst.PlaceholderColor3 = Color3.fromRGB(185, 185, 195)
			inst.BackgroundColor3 = Color3.fromRGB(55, 55, 62)
			inst.BackgroundTransparency = 0
			inst.BorderSizePixel = 1
			inst.BorderColor3 = Color3.fromRGB(110, 110, 120)
			inst.TextXAlignment = Enum.TextXAlignment.Left
		end)
		local corner = inst:FindFirstChildOfClass("UICorner")
		if corner then
			corner.CornerRadius = UDim.new(0, 3)
		end
		if not inst:GetAttribute("MX6_OGFix") then
			inst:SetAttribute("MX6_OGFix", true)
			table.insert(OldMHStyledInputs, inst)
			local focusedConn = Track(inst.Focused:Connect(function()
				if not OldMHStyleActive then return end
				pcall(function()
					inst.TextColor3 = Color3.fromRGB(255, 255, 255)
					inst.TextTransparency = 0
					inst.BackgroundColor3 = Color3.fromRGB(55, 55, 62)
				end)
			end))
			table.insert(OldMHInputConns, focusedConn)
		end
		return
	end

	if inst:IsA("TextLabel") or inst:IsA("TextButton") then
		pcall(function()
			inst.Font = Enum.Font.SourceSans
			local avg = (inst.TextColor3.R + inst.TextColor3.G + inst.TextColor3.B) / 3
			if avg < 0.4 then
				inst.TextColor3 = Color3.fromRGB(240, 240, 245)
			end
		end)
		return
	end

	if inst:IsA("Frame") or inst:IsA("ScrollingFrame") then
		local corner = inst:FindFirstChildOfClass("UICorner")
		if corner and (corner.CornerRadius.Scale > 0 or corner.CornerRadius.Offset > 8) then
			corner.CornerRadius = UDim.new(0, 3)
		end
	end
end

local function RestyleRayfieldOldMH()
	if not OldMHStyleActive then return end
	for _, root in ipairs(FindRayfieldRoots()) do
		pcall(function()
			for _, d in ipairs(root:GetDescendants()) do
				StyleInstanceOldMH(d)
			end
		end)
	end
end

local function QueueOldMHRestyle()
	if not OldMHStyleActive or OldMHRestylePending then return end
	OldMHRestylePending = true
	task.delay(0.2, function()
		OldMHRestylePending = false
		if OldMHStyleActive and HubAlive() then
			RestyleRayfieldOldMH()
		end
	end)
end

local function StopOldMHRestyleWatch()
	OldMHStyleActive = false
	OldMHRestylePending = false
	for _, c in ipairs(OldMHDescConns) do
		DisconnectTracked(c)
	end
	table.clear(OldMHDescConns)
	for _, c in ipairs(OldMHInputConns) do
		DisconnectTracked(c)
	end
	table.clear(OldMHInputConns)
	for _, input in ipairs(OldMHStyledInputs) do
		pcall(function() input:SetAttribute("MX6_OGFix", nil) end)
	end
	table.clear(OldMHStyledInputs)
end

local function StartOldMHRestyleWatch()
	StopOldMHRestyleWatch()
	OldMHStyleActive = true

	for _, root in ipairs(FindRayfieldRoots()) do
		local c = root.DescendantAdded:Connect(function(d)
			if not OldMHStyleActive then return end
			task.defer(function() StyleInstanceOldMH(d) end)
			QueueOldMHRestyle()
		end)
		table.insert(OldMHDescConns, c)
		Track(c)
	end

	RestyleRayfieldOldMH()
	task.delay(0.25, function() if OldMHStyleActive then RestyleRayfieldOldMH() end end)
	task.delay(0.8, function() if OldMHStyleActive then RestyleRayfieldOldMH() end end)
end

local function NormalizeThemeName(name)
	if not name then return "Default" end
	-- migrate old saved names
	if name == "Old Miners Haven" or name == "Old Miner's Haven" then
		return "OG MH"
	end
	return name
end

local function ApplyGuiTheme(name)
	local S = Hub.Set
	if not S or not MainUi then return end
	name = NormalizeThemeName(name or S.GUIThemeName or "Default")
	S.GUIThemeName = name
	if name == "Custom" then
		StopOldMHRestyleWatch()
		pcall(function() MainUi.ModifyTheme(CustomThemeTable) end)
	elseif name == "OG MH" then
		pcall(function() MainUi.ModifyTheme(OldMinersHavenTheme) end)
		StartOldMHRestyleWatch()
	else
		StopOldMHRestyleWatch()
		pcall(function() MainUi.ModifyTheme(name) end)
	end
end

if not Player:FindFirstChild("BaseDataLoaded") then 
	Rayfield:Notify({
		Title = "Waiting on game",
		Content = "Please Load into a slot to allow the script to finnish loading",
		Duration = 5,
		Image = 4483362458,
	})
end
local Networking = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Networking")
local Jolt = require(Networking:WaitForChild("Jolt"))
local Net = {}
for _, remoteName in ipairs({"BuyItem", "CraftsmanEvents", "DestroyAll", "ItemObtained", "MysteryBox", "PlaceItem", "PlaySolo", "Rebirth", "RemoteDrop"}) do
	Net[remoteName] = Jolt.Client(remoteName)
end
local Layouts = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Placement"):WaitForChild("Layouts")
local Tycoon = Player.PlayerTycoon.Value
local ActiveTycoon = Player.ActiveTycoon
local AdjustSpeed = Tycoon.AdjustSpeed
local Ores = game.Workspace.DroppedParts:FindFirstChild(Tycoon.Name)
local GUI = Player.PlayerGui:WaitForChild("GUI")
local Menus = Player.PlayerGui:WaitForChild("Menus")
local PlaceItem = Net.PlaceItem 
local buyItem = Net.BuyItem 
local RemoteDrop = Net.RemoteDrop
local ClearBase = Net.DestroyAll
local Money = GUI:FindFirstChild("Money")
local Boxes = game.Workspace.Boxes

local Set = {
	Layout1 = "Layout1",
	Layout2 = "None",
	MinWait = 7,
	MaxWait = 20,
	LayoutWaitTime = 10,
	AutoRebirth = false,
	Rebirthing = false,
	LayoutLoading = false,
	LayoutExpectedCount = 0,
	LayoutVerified = false,
	LastLayoutReloadAt = 0,
	LayoutReloadFails = 0,
	UsingMoneyLoop = false,
	OreBoost = false,
	OreBoostActive = false,
	AutoDrop = false,
	Furnace = nil,
	IndMine = nil,
	OreTracking = false,
	FarmRp = false,
	TrackBoxes = false,
	TestingMode = false,
	Fuel = false,
	WalkSpeed = 16,
	JumpPower = 50,
	Skips = 0,
	CollectingBoxes = false,
	Blur = true,
	WithdrawBase = false,
	OpenBoxes = false,
	SelectedBox = "Regular",
	UpgraderSize = 1,
	SingleItemUpgrade = "",
	ConveyorSpeed = 5,
	FakeName = "",
	CTag = "[MX6]",
	SpoofLife = false,
	SpoofName = false,
	LifeVal = 0,
	FarmBoxes = false,
	AutoCandyConfirm = false,
	UpgradeLoopCount = 1,
	externalLayoutString = "",
	BlueprintCount = 0,
	BlueprintsCost = 0,
	SelectedPlayer = game.Players.LocalPlayer.Name,
	SelectedIsland = "Default",
	SelectedMusicTarget = "ClientBaseRadio",
	SelectedMusicPreset = "Halloween Day",
	SelectedRadioTrack = "Mesmerize",
	CustomMusicId = "",
	AntiLeaveBase = false,
	OreSize = 0,
	AutoResizeUpgraders = false,
	SelectedPlace = "The Void",
	BoxFarmSpeed = 30,
	AutoKillOresWait = 0,
	StopLife = 0,

	FarmResearch = true,
	FarmGolden = true,
	FarmDiamond = true,
	FarmLucky = true,
	FarmShadow = true,
	FarmCrystal = true,
	FarmOthers = true,

	PrimaryFurnaceName = "Auto",
	PrimaryMineName = "None",
	SelectedOreMines = {},
	SingularOre = false,
	AutoFirePrompts = false,
	StopSlipstream = "None",

	GhostLoad = false,
	AntiBaseSafety = false,
	GUIThemeName = "Default",
}

Hub.Set = Set



local GUi = Instance.new("BillboardGui")
local Box = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")
GUi.Name = "GUi"
GUi:SetAttribute("MX6HubOwned", true)
Hub.GUi = GUi
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
	Set.BoxWait = 4
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

local Data = {
	MoneyLoopables = {
		["Large Ore Upgrader"] ={Cap = 50e+3,Effect = nil,MinVal = nil},
		["Solar Large Upgrader"]={Cap = 50e+3,Effect = nil,MinVal = nil},
		["Precision Refiner"]= {Cap = 1e+8,Effect = "Fire",MinVal = nil},
		["Rainbow Upgrader"] ={Cap = 1e+8,Effect = nil,MinVal = nil},
		["Way-Up-High Upgrader"]={Cap =1e+9,Effect = nil,MinVal = nil},
		["Digital Ore Cleaner"]={Cap = 10e+9,Effect = nil,MinVal = nil},
		["Freon-Blast Upgrader"]= {Cap = 125e+9,Effect = nil,MinVal = nil},
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
		["Morning Star"]={ Cap = 1e+30, Effect = "Fire", MinVal = nil, MinWait = 0.12, IsStar = true, Cooldown = 1.55 },
		["⭐ Celestial Morning Star ⭐"]={ Cap = 1e+30, Effect = "Fire", MinVal = nil, MinWait = 0.12, IsStar = true, Cooldown = 1.55 },
		["Red Giant"]={ Cap = 1e+60, Effect = "Fire", MinVal = nil, MinWait = 0.12, IsStar = true, Cooldown = 1.55 },
		["⭐ Wholesome Red Giant ⭐"]={ Cap = 1e+60, Effect = "Fire", MinVal = nil, MinWait = 0.12, IsStar = true, Cooldown = 1.55 },
		["Catalyzed Star"]={ Cap = 1e+60, Effect = "Fire", MinVal = nil, MinWait = 0.12, IsStar = true, Cooldown = 1.55 },
		["Neutron Star"]={ Cap = 1e+72, Effect = "Fire", MinVal = nil, MinWait = 0.12, IsStar = true, Cooldown = 1.55 },
		["⭐ Wholesome Neutron Star ⭐"]={ Cap = 1e+72, Effect = "Fire", MinVal = nil, MinWait = 0.12, IsStar = true, Cooldown = 1.55 },
		["Blue Supergiant"]={ Cap = 1e+90, Effect = "Fire", MinVal = nil, MinWait = 0.12, IsStar = true, Cooldown = 1.55 },
		["⭐ Hypergiant Blue Supergiant ⭐"]={ Cap = 1e+90, Effect = "Fire", MinVal = nil, MinWait = 0.12, IsStar = true, Cooldown = 1.55 },
		["Nova Star"]={ Cap = 1e+72, Effect = "Fire", MinVal = nil, MinWait = 0.12, IsStar = true, Cooldown = 1.55 },
		["Sinister Sepulcher"]={ Cap = 1e+99, Effect = nil, MinVal = nil, MinWait = nil },
		["Renegade Sinister Sepulcher"]={ Cap = 1e+99, Effect = nil, MinVal = nil, MinWait = nil },
		["⭐ Ornate Sinister Sepulcher ⭐"]={ Cap = 1e+99, Effect = nil, MinVal = nil, MinWait = nil },
	},
	ResettersNames = {
		"Tesla Resetter","Tesla Refuter","Black Dwarf","Void Star","The Ultimate Sacrifice",
		"The Final Upgrader","Daestrophe","⭐ Advanced Tesla Refuter ⭐","⭐ Advanced Tesla Resetter ⭐",
		"⭐ Spooky Tesla Resetter ⭐","⭐ Stargazed Void Star ⭐","⭐ Beloved Black Dwarf ⭐","⭐ Stargazed Black Dwarf ⭐",
	},
	EffectRemovers = {"Wild Spore","Deadly Spore","Azure Spore","The Death Cap"},
	Slipstreams = {"None"},
	Blueprints = {},
	OreTrackers = {},
	BoxTrackers = {},
	BoxConnections = {},
	OreConnections = {},
	ActiveOreBoosts = {},
	ActiveOreBoostCount = 0,
	OreMineCache = setmetatable({}, {__mode = "k"}),
	SelectedOreMineSet = {},
	Places = {
		["Restore Data 2"] = 1778064565,
		["The Void"] = 4464946645,
		["Revenge of John Doe"] = 4780479031,
		["Illusion"] = 4888384971,
		["Heart of Void"] = 5621678877,
		["The Temple"] = 5621679766,
		["Shiny Void"] = 5621680266,
		["Data Restore V3"] = 16433781330,
	},
	ItemInfo = require(game.ReplicatedStorage.Modules.Data.Database).Items
}

local ELayout = LoadExternal("https://raw.githubusercontent.com/MX6-RBX/MinersHavenScripts/refs/heads/main/BasicFirstLife.lua")

for i,v in game.ReplicatedStorage.Items:GetChildren() do
	if not v:FindFirstChild("Tier") then continue end 
	if v.Tier.Value == 78 then
		table.insert(Data.Slipstreams,v.Name)
	elseif v:FindFirstChild("BlueprintPrice") then 
		table.insert(Data.Blueprints,{v.ItemId.Value,v.BlueprintPrice.Value})
	end
end

function ConvertBaseToString(PT)
	local FullLayout = {}
	for _, v in ipairs(PT:GetChildren()) do
		local itemIdValue = v:FindFirstChild("ItemId")
		local itemId = v:GetAttribute("ItemId") or (itemIdValue and itemIdValue.Value)
		local hitbox = v:FindFirstChild("Hitbox")
		if itemId and hitbox and hitbox:IsA("BasePart") then
			table.insert(FullLayout, {v.Name, tostring(hitbox.CFrame - PT.Base.Position)})
		end
	end
	local String = game.HttpService:JSONEncode(FullLayout)
	Set.externalLayoutString = tostring(String)
	if type(setclipboard) == "function" then pcall(setclipboard, String) end
end

local function GetPlayerTycoon()
	return Player.PlayerTycoon and Player.PlayerTycoon.Value
end

local function CountPlacedItems(tycoon)
	tycoon = tycoon or GetPlayerTycoon()
	if not tycoon then return 0 end
	local n = 0
	for _, v in pairs(tycoon:GetChildren()) do
		if v:FindFirstChild("ItemId") then n += 1 end
	end
	return n
end

local function TableEntryCount(t)
	if type(t) ~= "table" then return 0 end
	local n = 0
	for _ in pairs(t) do n += 1 end
	return n
end

local function ParseLayoutString(String)
	if typeof(String) ~= "string" or String == "" then return nil end
	local ok, layout = pcall(function() return game.HttpService:JSONDecode(String) end)
	if not ok or type(layout) ~= "table" then return nil end
	return layout
end

local function TeleportToOwnBase()
	local tycoon = GetPlayerTycoon()
	local char = Player.Character
	if not tycoon or not tycoon:FindFirstChild("Base") then return false end
	if not char or not char:FindFirstChild("HumanoidRootPart") then return false end
	char.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
	char.HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
	char.HumanoidRootPart.CFrame = tycoon.Base.CFrame + Vector3.new(0, 10, 0)
	return true
end

local function TeleportForLayoutLoad()
	if Set.GhostLoad then
		if Set.TestingMode then print("Ghost Load: skipped teleport for layout") end
		return false
	end
	return TeleportToOwnBase()
end

local function TeleportForBaseSafety()
	if not Set.AntiBaseSafety then
		if Set.TestingMode then print("Anti-Base Safety off: skipped return teleport") end
		return false
	end
	return TeleportToOwnBase()
end

local function WaitForLayoutSettle(timeout, minItems)
	timeout = timeout or 12
	minItems = minItems or 1
	local deadline = os.clock() + timeout
	local lastCount, stableSeconds, best = -1, 0, 0
	while os.clock() < deadline do
		local c = CountPlacedItems()
		if c > best then best = c end
		if c == lastCount and c >= minItems then
			stableSeconds += 0.2
			if stableSeconds >= 1 then return c end
		else
			stableSeconds = 0
			lastCount = c
		end
		task.wait(0.2)
	end
	return CountPlacedItems()
end

local function IsLayoutFullyLoaded(tolerance)
	tolerance = tolerance or 0.9
	local expected = Set.LayoutExpectedCount or 0
	if expected <= 0 then return true end
	local have = CountPlacedItems()
	return have >= math.max(1, math.floor(expected * tolerance))
end

local function GetLayoutItemId(item)
	if not item then return nil end
	local itemId = tonumber(item:GetAttribute("ItemId"))
	if itemId then return itemId end
	local value = item:FindFirstChild("ItemId")
	return value and tonumber(value.Value) or nil
end

local function ResolveLayoutItem(identifier)
	local items = game:GetService("ReplicatedStorage"):FindFirstChild("Items")
	if not items or identifier == nil then return nil end
	local direct = items:FindFirstChild(tostring(identifier))
	if direct then return direct end
	local wantedId = tonumber(identifier)
	if not wantedId then return nil end
	for _, item in ipairs(items:GetChildren()) do
		if GetLayoutItemId(item) == wantedId then return item end
	end
	return nil
end

local function DecodeLayoutCFrame(raw)
	if typeof(raw) == "CFrame" then return raw end
	local values = {}
	if type(raw) == "table" then
		for index = 1, math.min(#raw, 12) do
			local value = tonumber(raw[index])
			if not value then return nil end
			table.insert(values, value)
		end
	elseif type(raw) == "string" then
		for token in string.gmatch(raw, "[^,]+") do
			local clean = token:match("^%s*(.-)%s*$"):gsub("^%(", ""):gsub("%)$", "")
			local value = tonumber(clean)
			if not value then return nil end
			table.insert(values, value)
			if #values == 12 then break end
		end
	else
		return nil
	end
	if #values >= 12 then
		return CFrame.new(values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12])
	end
	if #values == 3 then return CFrame.new(values[1], values[2], values[3]) end
	return nil
end

local function PlaceLayoutEntry(identifier, rawPosition)
	local item = ResolveLayoutItem(identifier)
	if not item then return false, "item not found: " .. tostring(identifier) end
	local itemId = GetLayoutItemId(item)
	local position = DecodeLayoutCFrame(rawPosition)
	local tycoon = GetPlayerTycoon()
	local base = tycoon and tycoon:FindFirstChild("Base")
	if not itemId or not position or not base then return false, "invalid item, position, or base" end

	local itemType = item:FindFirstChild("ItemType")
	local Id = item:GetAttribute("ItemId") or item:FindFirstChild("ItemId").Value
	local cost = Data.ItemInfo[Id].Obtainability.Price
	if not cost then warn("Cost missing") end
	if itemType and cost and itemType.Value >= 1 and itemType.Value < 5 then
		local money = Player.PlayerGui.GUI:FindFirstChild("Money")
		if money and money.Value < cost.Value then return false, "not enough money: " .. item.Name end
		local bought = pcall(function() buyItem:Invoke(itemId, 1) end)
		if not bought then return false, "buy failed: " .. item.Name end
	end

	local ok, placed, code = pcall(function()
		return PlaceItem:Invoke(itemId, position + base.Position, {base})
	end)
	if not ok or placed == false then return false, tostring(code or placed) end
	return true
end

local function ImportLayout(entries, getEntry)
	local queue = {}
	if #entries > 0 then
		for _, entry in ipairs(entries) do table.insert(queue, entry) end
	else
		for _, entry in pairs(entries) do table.insert(queue, entry) end
	end
	local expected = #queue
	if expected == 0 then return 0 end

	local nextIndex, placed, firstIssue = 1, 0, nil
	local workers = math.min(6, expected)
	local finished = 0
	for _ = 1, workers do
		task.spawn(function()
			while HubAlive() do
				local index = nextIndex
				nextIndex += 1
				if index > expected then break end
				local identifier, position = getEntry(queue[index])
				local ok, issue = PlaceLayoutEntry(identifier, position)
				if ok then placed += 1 elseif not firstIssue then firstIssue = issue end
				task.wait()
			end
			finished += 1
		end)
	end
	while finished < workers and HubAlive() do task.wait() end
	local settled = placed > 0 and WaitForLayoutSettle(12, math.max(1, math.floor(placed * 0.5))) or 0
	if firstIssue then Rayfield:Notify({Title = "Layout import", Content = "Placed " .. placed .. "/" .. expected .. ". " .. firstIssue, Duration = 8}) end
	return math.max(placed, settled)
end

local function LoadExternlLayout(Layout)
	if type(Layout) ~= "table" then return 0 end
	return ImportLayout(Layout, function(entry)
		return entry.Name or entry.ItemId or entry[1], entry.Pos or entry.CFrame or entry[2]
	end)
end

local function LoadStringLayout(String)
	if typeof(String) ~= "string" then return 0 end
	local layout = ParseLayoutString(String)
	if not layout then
		Rayfield:Notify({Title = "Layout string loading error", Content = "The layout string could not be parsed.", Duration = 8})
		return 0
	end
	local entries = type(layout.Items) == "table" and layout.Items or layout
	return ImportLayout(entries, function(entry)
		return entry[1] or entry.Name or entry.ItemId, entry[2] or entry.Pos or entry.CFrame
	end)
end

local function LoadOneLayout(layoutName)
	if not layoutName or layoutName == "None" then return CountPlacedItems() end
	if layoutName == "Layout String" then
		if Set.externalLayoutString and Set.externalLayoutString ~= "" then
			return LoadStringLayout(Set.externalLayoutString)
		end
		Rayfield:Notify({Title = "Layout string erorr", Content = "Layout String missing, cant load from layout string", Duration = 10})
		return 0
	end
	Layouts:InvokeServer("Load", layoutName)
	local settled = WaitForLayoutSettle(14, 1)
	if Set.TestingMode then print("Saved layout", layoutName, "settled count:", settled) end
	return settled
end

local MAX_TRACKED_ORES = 50
local MAX_TRACKED_BOXES = 25

local function TrackerCount(trackers)
	local count = 0
	for _ in pairs(trackers) do count += 1 end
	return count
end

local function ClearBoxTracker(box)
	local connections = Data.BoxConnections[box]
	if connections then
		for _, connection in pairs(connections) do
			DisconnectTracked(connection)
		end
		Data.BoxConnections[box] = nil
	end
	local ui = Data.BoxTrackers[box]
	pcall(function() if ui then ui:Destroy() end end)
	Data.BoxTrackers[box] = nil
end

local function ClearBoxTrackers()
	local tracked = {}
	for box in pairs(Data.BoxTrackers) do table.insert(tracked, box) end
	for _, box in ipairs(tracked) do ClearBoxTracker(box) end
end

local function ClearOreTrackers()
	for ore, connections in pairs(Data.OreConnections) do
		for _, connection in pairs(connections) do
			DisconnectTracked(connection)
		end
		Data.OreConnections[ore] = nil
	end
	for ore, ui in pairs(Data.OreTrackers) do
		pcall(function() if ui then ui:Destroy() end end)
		Data.OreTrackers[ore] = nil
	end
end

local function AddBoxTrack(Box)
	if not Set.TrackBoxes or not Box or Data.BoxTrackers[Box] then return end
	if TrackerCount(Data.BoxTrackers) >= MAX_TRACKED_BOXES then return end
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
	Ui.Enabled = Set.TrackBoxes
	Data.BoxTrackers[Box] = Ui
	local connections = {}
	Data.BoxConnections[Box] = connections
	connections.ancestryConn = Track(Box.AncestryChanged:Connect(function(_, parent)
		if not HubAlive() then return end
		if not parent or not Box:IsDescendantOf(Boxes) then
			ClearBoxTracker(Box)
		end
	end))
	connections.destroyConn = Track(Box.Destroying:Connect(function()
		ClearBoxTracker(Box)
	end))
end

local function AddTracker(ore)
	if not HubAlive() then return end
	if not Set.OreTracking or not ore or Data.OreConnections[ore] then return end
	if TrackerCount(Data.OreTrackers) >= MAX_TRACKED_ORES then return end
	local cash = ore:WaitForChild("Cash", 5) 
	if not cash or not ore.Parent then return end
	local Ui = GUi:Clone()
	Ui.Box.Text = "$" .. shorten(cash.Value)
	Ui.AlwaysOnTop = true
	Ui.Parent = ore
	Ui.Adornee = ore
	Ui.Enabled = Set.OreTracking
	Data.OreTrackers[ore] = Ui
	local connections = {}
	Data.OreConnections[ore] = connections
	local cleaned = false
	connections.cashConn = Track(cash.Changed:Connect(function()
		if not HubAlive() then return end
		if Ui and Ui.Parent then Ui.Box.Text = "$" .. shorten(cash.Value or 0) end
	end))
	local function cleanup()
		if cleaned then return end
		cleaned = true
		for _, conn in pairs(connections) do DisconnectTracked(conn) end
		if Ui then Ui:Destroy() end
		Data.OreTrackers[ore] = nil
		Data.OreConnections[ore] = nil
	end
	connections.destroyConn = Track(ore.Destroying:Connect(cleanup))
	connections.ancestryConn = Track(ore.AncestryChanged:Connect(function(_, parent)
		if not parent then cleanup() end
	end))
end

local lastCandyConfirm = 0

local function ConfirmCandyCollection()
	if not Set.AutoCandyConfirm or os.clock() - lastCandyConfirm < 0.4 then return end
	local gui = Player:FindFirstChild("PlayerGui")
	local gameGui = gui and gui:FindFirstChild("GUI")
	local promptGui = gameGui and gameGui:FindFirstChild("InputPrompt")
	local prompt = promptGui and promptGui:FindFirstChild("InputPrompt")
	local title = prompt and prompt:FindFirstChild("Title")
	local yes = prompt and prompt:FindFirstChild("Yes")
	if not (prompt and title and yes and prompt.Visible and yes.Visible) then return end

	local promptText = string.lower(title.Text or "")
	if not (string.find(promptText, "collect", 1, true) and string.find(promptText, "candy", 1, true)) then return end

	local clicked = false
	if getconnections then
		for _, connection in ipairs(getconnections(yes.MouseButton1Click)) do
			if connection.Function then
				local ok = pcall(connection.Function)
				clicked = clicked or ok
			end
		end
	end
	if not clicked and firesignal then
		clicked = pcall(firesignal, yes.MouseButton1Click)
	end
	if not clicked then
		clicked = pcall(function() yes:Activate() end)
	end
	if clicked then lastCandyConfirm = os.clock() end
end

task.spawn(function()
	while HubAlive() do
		ConfirmCandyCollection()
		task.wait(0.1)
	end
end)

local function CollectBoxes()
	if not HubAlive() then return end
	if not Set.FarmBoxes or Set.Rebirthing or Set.LayoutLoading or Set.CollectingBoxes then return end
	if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then return end
	Set.CollectingBoxes = true
	local ok, err = pcall(function()
		local hrp = Player.Character.HumanoidRootPart
		for _,v in Boxes:GetChildren() do
			if not HubAlive() or not Set.FarmBoxes or Set.Rebirthing or Set.LayoutLoading then break end
			if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then break end

			local name = string.lower(v.Name or "")
			local should = false
			if string.find(name, "crystal") then
				should = Set.FarmCrystal
			elseif string.find(name, "research") or string.find(name, "basic") then
				should = Set.FarmResearch
			elseif string.find(name, "golden") or string.find(name, "gold") then
				should = Set.FarmGolden
			elseif string.find(name, "diamond") then
				should = Set.FarmDiamond
			elseif string.find(name, "lucky") then
				should = Set.FarmLucky
			elseif string.find(name, "shadow") then
				should = Set.FarmShadow
			else
				should = Set.FarmOthers
			end
			if not should then continue end

			hrp = Player.Character.HumanoidRootPart
			if v:IsA("Model") and v:FindFirstChild("Crate") then
				hrp.CFrame = v.Crate.CFrame
			else
				hrp.CFrame = v.CFrame
			end
			task.wait(Set.BoxFarmSpeed/100)
		end
		TeleportForBaseSafety()
	end)
	Set.CollectingBoxes = false
	if not ok and Set.TestingMode then warn("CollectBoxes error:", err) end
end

local function ToggleBoxTrack(Val)
	Set.TrackBoxes = Val
	if not Val then
		ClearBoxTrackers()
		return
	end
	for _, box in ipairs(Boxes:GetChildren()) do
		AddBoxTrack(box)
	end
end

local function ToggleOreTrack(Val)
	Set.OreTracking = Val
	if not Val then
		ClearOreTrackers()
		return
	end
	for _, ore in ipairs(Ores:GetChildren()) do
		AddTracker(ore)
	end
end

function TeleportToBase(SP)
	local RealPlayer = game.Players:FindFirstChild(SP)
	local Base = RealPlayer.PlayerTycoon.Value
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Base.Base.CFrame + Vector3.new(0,10,0)
end

local FindUpgradePart

local function ResizeUpgraders()
	for _, v in Tycoon:GetChildren() do
		if not v:FindFirstChild("ItemId") then continue end
		local up = FindUpgradePart(v)
		if not up or not up:IsA("BasePart") then continue end
		local baseSize = up:FindFirstChild("BaseSize")
		if not baseSize then
			baseSize = Instance.new("Vector3Value")
			baseSize.Name = "BaseSize"
			baseSize.Value = up.Size
			baseSize.Parent = up
		end
		if Set.TestingMode then print(v.Name, "Resized to ", Set.UpgraderSize) end
		up.Size = baseSize.Value * Set.UpgraderSize
	end
end

local function RezieSingleUpgrader(Name)
	local Item = Tycoon:FindFirstChild(Name)
	if not Item then return end
	local up = FindUpgradePart(Item)
	if not up or not up:IsA("BasePart") then return end
	local baseSize = up:FindFirstChild("BaseSize")
	if not baseSize then
		baseSize = Instance.new("Vector3Value")
		baseSize.Name = "BaseSize"
		baseSize.Value = up.Size
		baseSize.Parent = up
	end
	if Set.TestingMode then print(Item.Name, "Resized to ", Set.UpgraderSize) end
	up.Size = baseSize.Value * Set.UpgraderSize
end

local function ChangeUi(Name)
	if GUI.FocusWindow.Value then
		local focused = GUI.FocusWindow.Value
		if focused:IsA("LayerCollector") then
			focused.Enabled = false
		elseif focused:IsA("GuiObject") then
			focused.Visible = false
		end
		task.wait(0.01)
		GUI.FocusWindow.Value = nil
	end
	local Ui = Menus:FindFirstChild(Name, true) or GUI:FindFirstChild(Name, true)
	if Ui then
		if Ui:IsA("LayerCollector") then
			Ui.Enabled = true
		elseif Ui:IsA("GuiObject") then
			Ui.Visible = true
		else
			warn("Vendor UI is not a GUI object:", Name, Ui:GetFullName())
			return
		end
		GUI.FocusWindow.Value = Ui
	else
		local available = {}
		for _, child in ipairs(Menus:GetDescendants()) do
			if child:IsA("GuiObject") or child:IsA("LayerCollector") then
				table.insert(available, child.Name)
			end
		end
		warn("Vendor menu not found:", Name, "Available menus:", table.concat(available, ", "))
	end
end

local function comma(Value)
	local v3, v4, v5 = string.match(tostring(Value), "^([^%d]*%d)(%d*)(.-)$")
	return v3 .. v4:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v5
end

local function HandleLife(Life)
	local LastDigit = tonumber(string.sub(tostring(Life),string.len(tostring(Life))))
	local SendLastDigit = tonumber(string.sub(tostring(Life),string.len(tostring(Life-1))))
	local Suffix
	if Life <= 20 and Life >= 10 then Suffix = "th"
	elseif LastDigit == 1 then Suffix = "st"
	elseif LastDigit == 2 and SendLastDigit ~= 1 then Suffix = "nd"
	elseif LastDigit == 3 then Suffix = "rd"
	else Suffix = "th" end
	return tostring(comma(Life))..Suffix
end

local function KillOres()
	for i,v in Ores:GetChildren() do
		if v and v:IsA("Part") then v.CFrame = Tycoon.Base.CFrame end
	end
end

function BuyBlueprints()
	for i,v in Data.Blueprints do
		if Net.CraftsmanEvents:Invoke("type:hasblueprint", v[1]) then continue end
		local Bought = Net.CraftsmanEvents:Invoke("type:buyblueprint", v[1])
		if Bought then 
			Set.BlueprintsCost -= v[2]
			Set.BlueprintCount -= 1
		end
	end
end

local function ShopSpam()
	task.spawn(function()
		for _, item in ipairs(game.ReplicatedStorage.Items:GetChildren()) do
			if not HubAlive() then break end
			local itemType = item:FindFirstChild("ItemType")
			local itemId = item:GetAttribute("ItemId")
			if itemType and itemType.Value < 5 and itemId then
				for _ = 1, 10 do
					if not HubAlive() then break end
					pcall(function() buyItem:Invoke(itemId, 99) end)
					task.wait(0.03)
				end
			end
		end
	end)
end

local function HasNamedScript(root, scriptName)
	if not root then return false end
	return root:FindFirstChild(scriptName, true) ~= nil
end

local function FindLavaPart(item)
	if not item then return nil end
	local model = item:FindFirstChild("Model") or item
	local preferred = {"Lava", "Lava1", "MiniLava", "Lava2"}
	for _, n in ipairs(preferred) do
		local p = model:FindFirstChild(n, true)
		if p and p:IsA("BasePart") and not p:FindFirstChild("TeleportSend") then
			return p
		end
	end
	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("BasePart") then
			local ln = string.lower(d.Name)
			if string.find(ln, "lava", 1, true) and not d:FindFirstChild("TeleportSend") then
				return d
			end
		end
	end
	return nil
end

local function HasTouchInterest(part)
	if not part then return false end
	return part:FindFirstChild("TouchInterest") ~= nil
		or part:FindFirstChildOfClass("TouchTransmitter") ~= nil
end

local function ResolveToBasePart(inst)
	if not inst then return nil end
	if inst:IsA("BasePart") then return inst end
	if inst:IsA("Model") or inst:IsA("Folder") or inst:IsA("Configuration") then
		for _, d in ipairs(inst:GetDescendants()) do
			if d:IsA("BasePart") and HasTouchInterest(d) then return d end
		end
		for _, d in ipairs(inst:GetDescendants()) do
			if d:IsA("BasePart") then return d end
		end
		if inst:IsA("Model") and inst.PrimaryPart then return inst.PrimaryPart end
	end
	return nil
end
FindUpgradePart = function(item)
	if not item then return nil end
	local scope = item

	local names = {"Upgrade", "Upgrader", "Scan", "UpgraderPart"}

	for _, n in ipairs(names) do
		local p = scope:FindFirstChild(n, true)
		local part = ResolveToBasePart(p)
		if part and HasTouchInterest(part) then return part end
	end

	for _, n in ipairs(names) do
		local p = scope:FindFirstChild(n, true)
		local part = ResolveToBasePart(p)
		if part then return part end
	end

	for _, d in ipairs(scope:GetDescendants()) do
		if d:IsA("BasePart") and HasTouchInterest(d) then
			local n = string.lower(d.Name)
			if string.find(n, "upgrade", 1, true)
				or string.find(n, "scan", 1, true)
				or string.find(n, "refine", 1, true)
				or string.find(n, "advanc", 1, true) then
				return d
			end
		end
	end

	if HasNamedScript(scope, "UpgraderShip") then
		for _, d in ipairs(scope:GetDescendants()) do
			if d:IsA("BasePart") and HasTouchInterest(d) then
				local n = string.lower(d.Name)
				if not string.find(n, "lava", 1, true)
					and n ~= "hitbox" and n ~= "base" and n ~= "plane" then
					return d
				end
			end
		end
	end

	return nil
end

local function IsMineItem(v)
	if not v then return false end
	local model = v:FindFirstChild("Model")
	if not model then return false end
	return model:FindFirstChild("Drop", true) ~= nil
end

local function IsFurnaceItem(v)
	if not v then return false end
	local model = v:FindFirstChild("Model")
	if not model and not v:FindFirstChild("MoneyScript", true) then return false end

	local hasMoney = HasNamedScript(v, "MoneyScript")
	local lava = FindLavaPart(v)

	if lava and lava:FindFirstChild("TeleportSend") then return false end

	if hasMoney then
		return true
	end

	if lava and model and not model:FindFirstChild("Drop", true) then
		return true
	end
	return false
end

local function GetFurnacesOnBase()
	local list = {"Auto"}
	local seen = {Auto = true}
	if not Tycoon then return list end
	for _, v in Tycoon:GetChildren() do
		if IsFurnaceItem(v) and not seen[v.Name] then
			seen[v.Name] = true
			table.insert(list, v.Name)
		end
	end
	table.sort(list, function(a, b)
		if a == "Auto" then return true end
		if b == "Auto" then return false end
		return a:lower() < b:lower()
	end)
	return list
end

local function GetMinesOnBase()
	local list = {"None"}
	local seen = {None = true}
	if not Tycoon then return list end
	for _, v in Tycoon:GetChildren() do
		if IsMineItem(v) and not seen[v.Name] then
			seen[v.Name] = true
			table.insert(list, v.Name)
		end
	end
	return list
end

local RequestAutoRebirthCheck

-- ===================== UI =====================
local BoostPage = MainUi:CreateTab("Boost Options", 130772689610761) 
BoostPage:CreateSection("Auto Rebirth")
local AutoRebithToggle = BoostPage:CreateToggle({
	Name = "Auto Rebirth",
	CurrentValue = false,
	Flag = "Auto Rebirth",
	Callback = function(Value)
		Set.AutoRebirth = Value or false
		if Set.TestingMode then print("Auto Rebirth:",Value) end
		if Set.AutoRebirth and RequestAutoRebirthCheck then
			task.defer(RequestAutoRebirthCheck)
		end
	end,
})

BoostPage:CreateToggle({
	Name = "Anti Leave Base",
	CurrentValue = false,
	Flag = "AntiLeaveBase",
	Callback = function(Value)
		Set.AntiLeaveBase = Value or false
		if Set.TestingMode then print("Anti Leave Base:",Value) end
	end,
})

BoostPage:CreateToggle({
	Name = "Ghost Load",
	CurrentValue = false,
	Flag = "GhostLoad",
	Callback = function(Value)
		Set.GhostLoad = Value
		if Set.TestingMode then print("Ghost Load:", Value) end
	end,
})

BoostPage:CreateParagraph({
	Title = "<b>Ghost Load</b>",
	Content = "<i>Doesn't teleport to your base, anymore. You must be in the base to load your layouts.</i>"
})

BoostPage:CreateSlider({
	Name = "Wait for skips",
	Range = {0, 20},
	Increment = 1,
	Suffix = "Skips",
	CurrentValue = 0,
	Flag = "Skips",
	Callback = function(Value)
		Set.Skips = Value or 0
		if Set.TestingMode then print(" Wait for Skips:",Value) end
	end,
})

BoostPage:CreateInput({
	Name = "Rebirth Wait Min (sec)",
	CurrentValue = "7",
	PlaceholderText = "7",
	RemoveTextAfterFocusLost = false,
	Flag = "MinWait",
	Callback = function(Text)
		Set.MinWait = math.max(0, tonumber(Text) or 7)
		if Set.TestingMode then print("Rebirth Wait Min:", Set.MinWait) end
	end,
})

BoostPage:CreateInput({
	Name = "Rebirth Wait Max (sec)",
	CurrentValue = "20",
	PlaceholderText = "20",
	RemoveTextAfterFocusLost = false,
	Flag = "MaxWait",
	Callback = function(Text)
		Set.MaxWait = math.max(0, tonumber(Text) or 20)
		if Set.TestingMode then print("Rebirth Wait Max:", Set.MaxWait) end
	end,
})

BoostPage:CreateParagraph({
	Title = "<b>Wait Randomness</b>",
	Content = "<i>After a layout finishes loading, waits a random time between Min and Max before the next rebirth. Set Min = Max for a fixed delay (e.g. both 10 = always 10s).</i>"
})

BoostPage:CreateDropdown({
	Name = "Stop on Slipstream",
	Options = Data.Slipstreams,
	CurrentOption = {"None"},
	MultipleOptions = false,
	Flag = "StopOnSlipsteam",  
	Callback = function(Options)
		Set.StopSlipstream = Options[1]
		if Set.TestingMode then print("Stop on Slipstream:",Options[1]) end
	end,
})

BoostPage:CreateInput({
	Name = "Stop On Life(Set 0 to disable)",
	CurrentValue = "0",
	PlaceholderText = "0",
	RemoveTextAfterFocusLost = false,
	Flag = "StopLife",
	Callback = function(Text)
		Set.StopLife = tonumber(Text) or 0
		if Set.TestingMode then print("Stop on life set to:",Text) end
	end,
})

BoostPage:CreateDropdown({
	Name = "First Layout",
	Options = {"Layout1","Layout2","Layout3","Layout String"},
	CurrentOption = {"Layout1"},
	MultipleOptions = false,
	Flag = "Layout1",  
	Callback = function(Options)
		Set.Layout1 = Options[1]
		if Set.TestingMode then print("First Layout:",Options[1]) end
	end,
})

BoostPage:CreateInput({
	Name = "Layout 2 Load Wait",
	CurrentValue = "5",
	PlaceholderText = "5",
	RemoveTextAfterFocusLost = false,
	Flag = "LayoutLoadWait",
	Callback = function(Text)
		Set.LayoutWaitTime = tonumber(Text) or 5
		if Set.TestingMode then print("Layout 2 Load Wait:",Text) end
	end,
})

BoostPage:CreateToggle({
	Name = "Withdraw between layouts",
	CurrentValue = false,
	Flag = "WithdrawBase",  
	Callback = function(Value)
		Set.WithdrawBase = Value
		if Set.TestingMode then print("Add Wait Randomness:",Value) end
	end,
})

BoostPage:CreateDropdown({
	Name = "Second Layout",
	Options = {"None" ,"Layout1","Layout2","Layout3","Layout String"},
	CurrentOption = {"None"},
	MultipleOptions = false,
	Flag = "Layout2",  
	Callback = function(Options)
		Set.Layout2 = Options[1]
		if Set.TestingMode then print("Second Layout:",Options[1]) end
	end,
})

BoostPage:CreateToggle({
	Name = "Auto Remote drops",
	CurrentValue = false,
	Flag = "AutoDrop",  
	Callback = function(Value)
		Set.AutoDrop = Value
		if Set.TestingMode then print("Auto Drop:",Value) end
	end,
})

BoostPage:CreateToggle({
	Name = "Auto Fire Proximity Prompts (Base)",
	CurrentValue = false,
	Flag = "AutoFirePrompts",
	Callback = function(Value)
		Set.AutoFirePrompts = Value
		if Set.TestingMode then print("Auto Fire Prompts:", Value) end
	end,
})

BoostPage:CreateParagraph({
	Title = "<b>Proximity Prompts</b>",
	Content = "<i>Spams every Activate/ProximityPrompt on your base (e.g. Martian Lightningbolt Refiner). Does NOT edit prompt properties (so manual Z still works and withdrawing items is safe). Uses InputHoldBegin/End + fireproximityprompt + Triggered hooks. Best with an executor that has fireproximityprompt for true long-range.</i>"
})

BoostPage:CreateSection("Auto Upgrade")
local BoostToggle = BoostPage:CreateToggle({
	Name = "Ore Boost",
	CurrentValue = false,
	Flag = "OreBoost",  
	Callback = function(Value)
		Set.OreBoost = Value
		Set.OreBoostActive = Value
		if Set.TestingMode then print("Ore Boost:",Value) end
	end,
})

BoostPage:CreateParagraph({
	Title = "<b>Primary Furnace</b>",
	Content = "<i>Where ore is sold after boosting. Detects ANY furnace with a MoneyScript and/or Lava/Lava1/MiniLava sell part. Default Auto = first found. Pick one on base or type the name 1:1. Hit Refresh after placing. Saved.</i>"
})

local PrimaryFurnaceDropdown = BoostPage:CreateDropdown({
	Name = "Primary Furnace (from base)",
	Options = GetFurnacesOnBase(),
	CurrentOption = {Set.PrimaryFurnaceName or "Auto"},
	MultipleOptions = false,
	Flag = "PrimaryFurnaceName",
	Callback = function(Options)
		local name = Options[1] or "Auto"
		Set.PrimaryFurnaceName = name
		Set.Furnace = nil
		GetFurnace()
		if Set.TestingMode then print("Primary Furnace:", name) end
	end,
})

BoostPage:CreateInput({
	Name = "Primary Furnace Name (exact, 1:1)",
	CurrentValue = (Set.PrimaryFurnaceName and Set.PrimaryFurnaceName ~= "Auto") and Set.PrimaryFurnaceName or "",
	PlaceholderText = 'e.g. Oblivion Emission  (or Auto)',
	RemoveTextAfterFocusLost = false,
	Flag = "PrimaryFurnaceNameInput",
	Callback = function(Text)
		local name = (Text and Text:match("^%s*(.-)%s*$")) or ""
		if name == "" then name = "Auto" end
		Set.PrimaryFurnaceName = name
		Set.Furnace = nil
		GetFurnace()
		pcall(function() PrimaryFurnaceDropdown:Set({name}) end)
		if Set.TestingMode then print("Primary Furnace (typed):", name) end
	end,
})

BoostPage:CreateButton({
	Name = "Refresh Furnace List",
	Callback = function()
		local opts = GetFurnacesOnBase()
		pcall(function() PrimaryFurnaceDropdown:Refresh(opts) end)
		if Set.TestingMode then print("Furnaces:", table.concat(opts, ", ")) end
	end,
})

BoostPage:CreateParagraph({
	Title = "<b>Selected Mine Boosting</b>",
	Content = "<i>Leave this empty to boost every mine. Select one or more mines to boost only those ores; all other mines stay on their normal conveyors. Selected ores get the priority worker pool.</i>"
})

local function UpdateSelectedOreMines(options)
	table.clear(Data.SelectedOreMineSet)
	Set.SelectedOreMines = {}
	for _, name in ipairs(options or {}) do
		if name and name ~= "" and name ~= "None" then
			Data.SelectedOreMineSet[name] = true
			table.insert(Set.SelectedOreMines, name)
		end
	end
end

local SelectedMineDropdown = BoostPage:CreateDropdown({
	Name = "Mines to Boost (leave empty for all)",
	Options = GetMinesOnBase(),
	CurrentOption = Set.SelectedOreMines,
	MultipleOptions = true,
	Flag = "SelectedOreMines",
	Callback = function(Options)
		UpdateSelectedOreMines(Options)
	end,
})

BoostPage:CreateInput({
	Name = "Mines to Boost (exact names, comma-separated)",
	CurrentValue = "",
	PlaceholderText = "e.g. Havium Mine, Pumpkinite Mine",
	RemoveTextAfterFocusLost = false,
	Flag = "SelectedOreMinesInput",
	Callback = function(Text)
		local names = {}
		for name in string.gmatch(Text or "", "[^,]+") do
			name = name:match("^%s*(.-)%s*$")
			if name ~= "" then table.insert(names, name) end
		end
		UpdateSelectedOreMines(names)
		pcall(function() SelectedMineDropdown:Set(names) end)
	end,
})

BoostPage:CreateButton({
	Name = "Refresh Mine List",
	Callback = function()
		local opts = GetMinesOnBase()
		pcall(function() SelectedMineDropdown:Refresh(opts) end)
		if Set.TestingMode then print("Mines:", table.concat(opts, ", ")) end
	end,
})

BoostPage:CreateParagraph({Title = "<b>Upgrade Looping</b>", Content = "<i>Upgrade Loop Count is how many times the ore will go through an upgrader before going to the next, Higher value is slower but more likely to upgrade ores.</i>"})

BoostPage:CreateSlider({
	Name = "Upgrade Loop Count",
	Range = {1, 5},
	Increment = 1,
	Suffix = "Loop Count",
	CurrentValue = 0,
	Flag = "UpgradeLoopCount",  
	Callback = function(Value)
		Set.UpgradeLoopCount = Value or 1
		if Set.TestingMode then print("Upgrade Loop Count:",Value) end
	end,
})

BoostPage:CreateToggle({
	Name = "Using Ind Mine",
	CurrentValue = false,
	Flag = "IndMine",  
	Callback = function(Value) 
		Set.Fuel = true
		if Set.TestingMode then print("Using Industrial Mine: ",Value) end 
	end,
})

BoostPage:CreateToggle({
	Name = "Use Money Loopables",
	CurrentValue = false,
	Flag = "MoneyLoopables",  
	Callback = function(Value)
		Set.UsingMoneyLoop = Value
		if Set.TestingMode then print("Money Loopables: ",Value) end 
	end,
})


BoostPage:CreateToggle({
	Name = "Farm RP(Disables oreboost and auto rebirth)",
	CurrentValue = false,
	Flag = "FarmRp",  
	Callback = function(Value)
		Set.FarmRp = Value
		if Set.OreBoost then
			BoostToggle:Set(false)
			AutoRebithToggle:Set(false)
			Set.OreBoost = false
			Set.OreBoostActive = false
			Set.AutoRebirth = false
		end
		if Set.TestingMode then print("Farm Rp: ",Value) end 
	end,
})

BoostPage:CreateSection("Item Manipulation")
BoostPage:CreateSlider({
	Name = "Conveyor speed(Value ÷ 5",
	Range = {0, 100},
	Increment = 1,
	Suffix = "Conveyor Speed",
	CurrentValue = 5,
	Flag = "ConveyorSpeed",  
	Callback = function(Value)
		Set.ConveyorSpeed = Value or 5
		AdjustSpeed.Value = Set.ConveyorSpeed/5
		if Set.TestingMode then print("Conveyor Speed:",Set.ConveyorSpeed) end 
	end,
})

BoostPage:CreateSlider({
	Name = "Ore Size(Value ÷ 10 | 0 disable override)",
	Range = {0, 100},
	Increment = 1,
	Suffix = "Ore Size",
	CurrentValue = 5,
	Flag = "OreSize",  
	Callback = function(Value)
		Set.OreSize = Value/10 or 0
		if Set.TestingMode then print("Ore Size:",Set.OreSize) end 
	end,
})

BoostPage:CreateSlider({
	Name = "Upgrader Size",
	Range = {1, 20},
	Increment = 1,
	Suffix = "Upgrader Size",
	CurrentValue = 1,
	Flag = "UpgraderSize",  
	Callback = function(Value)
		Set.UpgraderSize = Value or 1
		if Set.TestingMode then print("Upgrader Size: ",Value) end 
	end,
})

BoostPage:CreateInput({
	Name = "Item Name (Case Sensitive)",
	CurrentValue = "",
	PlaceholderText = "Name",
	RemoveTextAfterFocusLost = false,
	Flag = "ItemName",
	Callback = function(Text)
		Set.SingleItemUpgrade = Text
		if Set.TestingMode then print("Upgrader Name:",Text) end
	end,
})

BoostPage:CreateButton({
	Name = "Resize Single Item",
	Callback = function()
		if Set.TestingMode then print("Resizing all upgraders") end
		RezieSingleUpgrader(Set.SingleItemUpgrade)
	end,
})

BoostPage:CreateButton({
	Name = "Resize All",
	Callback = function()
		if Set.TestingMode then print("Resizing all upgraders") end
		ResizeUpgraders()
	end,
})

BoostPage:CreateToggle({
	Name = "Auto Resize All Upgraders",
	CurrentValue = false,
	Flag = "AutoResizeAllUpg",  
	Callback = function(Value)
		Set.AutoResizeUpgraders = Value
		if Set.TestingMode then print("Auto Resize All: ",Value) end 
	end,
})

BoostPage:CreateButton({
	Name = "Kill Ores",
	Callback = function()
		if Set.TestingMode then print("Killing all ores") end
		KillOres()
	end,
})

BoostPage:CreateInput({
	Name = "Auto Kill Ores Wait(0 to disable) ",
	CurrentValue = "",
	PlaceholderText = "50",
	RemoveTextAfterFocusLost = false,
	Flag = "AutoKillOresWait",
	Callback = function(Text)
		Set.AutoKillOresWait = tonumber(Text) or 50
	end,
})

BoostPage:CreateSection("Other Options")
BoostPage:CreateToggle({
	Name = "Track Ore Value",
	CurrentValue = false,
	Flag = "TrackOreValue",  
	Callback = function(Value)
		ToggleOreTrack(Value)
		if Set.TestingMode then print("Track Ore Value: ",Value) end 
	end,
})

BoostPage:CreateButton({
	Name = "Load Basic First Life Setup(15qd-390qd, Warning loud)",
	Callback = function()
		if Set.TestingMode then print("Loading Basic First Life Layout.") end
		ClearBase:Invoke()
		LoadExternlLayout(ELayout)
	end,
})

local LayoutStringBox = BoostPage:CreateInput({
	Name = "Layout load String ",
	CurrentValue = "",
	PlaceholderText = "String",
	RemoveTextAfterFocusLost = false,
	Flag = "",
	Callback = function(Text)
		Set.externalLayoutString = Text
	end,
})

BoostPage:CreateButton({
	Name = "Load a layout from the inputed string",
	Callback = function()
		if Set.TestingMode then print("Loading Basic First Life Layout.") end
		ClearBase:Invoke()
		LoadStringLayout(Set.externalLayoutString)
	end,
})

BoostPage:CreateButton({
	Name = "Makes the Layout string your current base(Also set clipboard to)",
	Callback = function()
		if Set.TestingMode then print("Loading Basic First Life Layout.") end
		ConvertBaseToString(Tycoon)
		task.wait(3)
		LayoutStringBox:Set(Set.externalLayoutString) 
	end,
})

local VendorsPage = MainUi:CreateTab("Vendors",6031097225)
VendorsPage:CreateSection("GUI's")
VendorsPage:CreateButton({Name = "Open Crafts Man", Callback = function() ChangeUi("Craftsman") end})
VendorsPage:CreateButton({Name = "Open Masked Man", Callback = function() ChangeUi("MaskedMan") end})
VendorsPage:CreateButton({Name = "Open Box man", Callback = function() ChangeUi("SpookMcDook") end})
VendorsPage:CreateButton({Name = "Open Superstitious Crafting", Callback = function() ChangeUi("Superstitious") end})
VendorsPage:CreateButton({Name = "Open True Book Of Knowledge", Callback = function() ChangeUi("BookOfKnowledge") end})
VendorsPage:CreateButton({Name = "Open Phantasm", Callback = function() ChangeUi("Phantasm") end})
VendorsPage:CreateButton({Name = "Open Fleabag", Callback = function() ChangeUi("Fleabag") end})
VendorsPage:CreateButton({Name = "Open Event", Callback = function() ChangeUi("Event") end})

local PlayerList = {}
for i,v in game.Players:GetChildren() do table.insert(PlayerList,v.Name) end

VendorsPage:CreateSection("Player Base Teleport")
local PlayerSelectDropdown = VendorsPage:CreateDropdown({
	Name = "Select Player",
	Options = PlayerList,
	CurrentOption = {game.Players.LocalPlayer.Name},
	MultipleOptions = false,
	Flag = "PlayerSelect",  
	Callback = function(Options) Set.SelectedPlayer = Options[1] end,
})

VendorsPage:CreateButton({
	Name = "Teleport To Base",
	Callback = function()
		if Set.TestingMode then print("Teleporting to base") end
		TeleportToBase(Set.SelectedPlayer)
	end,
})

VendorsPage:CreateSection("Solo Island")
VendorsPage:CreateDropdown({
	Name = "Select Island Type",
	Options = {"Default","Executive","Mars","Sporest","Void"},
	CurrentOption = {"Default"},
	MultipleOptions = false,
	Flag = "IslandSelected",  
	Callback = function(Options)
		Set.SelectedIsland = Options[1]
		if Set.TestingMode then print("Seletced Island:",Options[1]) end
	end,
})
VendorsPage:CreateButton({
	Name = "Teleport To Solo Island",
	Callback = function()
		if Set.TestingMode then print("Teleporting to Solo Island",Set.SelectedIsland) end
		Net.PlaySolo:Invoke(Set.SelectedIsland)
	end,
})

VendorsPage:CreateSection("Game Universes/states")
VendorsPage:CreateDropdown({
	Name = "Select Place",
	Options = {"The Void","Revenge of John Doe","Illusion","Heart of Void","The Temple","Shiny Void","Data Restore V3","Data Restore V4"},
	CurrentOption = {"The Void"},
	MultipleOptions = false,
	Flag = "PlaceSelected",  
	Callback = function(Options)
		Set.SelectedPlace = Options[1]
		if Set.TestingMode then print("Seletced Place:",Options[1]) end
	end,
})
VendorsPage:CreateButton({
	Name = "Teleport To Place",
	Callback = function()
		if Set.TestingMode then print("Teleporting to ",Set.SelectedPlace) end
		local PlaceId = Data.Places[Set.SelectedPlace]
		TeleportService:Teleport(PlaceId,Player)
	end,
})

VendorsPage:CreateSection("Box Opening")
VendorsPage:CreateDropdown({
	Name = "Select Box",
	Options = {"Regular","Unreal","Inferno","Red-Banded","Spectral","Pumpkin","Luxury","Festive","Magnificent","Twitch","Birthday","Heavenly","Easter","Cake Raffle"},
	CurrentOption = {"Regular"},
	MultipleOptions = false,
	Flag = "BoxSelected",  
	Callback = function(Options)
		Set.SelectedBox = Options[1]
		if Set.TestingMode then print("Seletced Box:",Options[1]) end
	end,
})


VendorsPage:CreateToggle({
	Name = "Auto Open Selected box",
	CurrentValue = Set.OpenBoxes,
	Flag = "OpenBoxes",  
	Callback = function(Value)
		if Set.TestingMode then print("Toggle auto Box:",Value) end
		Set.OpenBoxes = Value
	end,
})

VendorsPage:CreateSection("Troll options")
VendorsPage:CreateParagraph({Title = '<font color="rgb(0,170,170)"><b>Shop Spam Troll</b></font>', Content = "Spam buys every shop item you can very quickly. This makes the notification take a while to vanish. Just add players to base and wait for them to come. Keep in mind this will also happen for you"})
VendorsPage:CreateButton({Name = "Shop Spam Troll", Callback = function() ShopSpam() end})

VendorsPage:CreateSection("Blueprints")
task.spawn(function()
	for i,v in Data.Blueprints do
		if not Net.CraftsmanEvents:Invoke("type:hasblueprint",v[1]) then
			Set.BlueprintCount += 1
			Set.BlueprintsCost += v[2]
		end
	end
	local Paragraph = VendorsPage:CreateParagraph({Title = '<font color="rgb(0,0,170)"><b>Blueprints</b></font>', Content = "You have "..Set.BlueprintCount.."/"..#Data.Blueprints.." Left to buy. It will cost "..comma(Set.BlueprintsCost).."RP to buy them all"})
	VendorsPage:CreateButton({
		Name = "Buy Craftsman Blueprints(Uses RP)",
		Callback = function()
			BuyBlueprints()
			Paragraph:Set({Title = '<font color="rgb(0,0,170)"><b>Blueprints</b></font>', Content = "You have "..Set.BlueprintCount.."/"..#Data.Blueprints.." Left to buy. It will cost "..comma(Set.BlueprintsCost).."RP to buy them all"})
		end,
	})
end)

local EventPage = MainUi:CreateTab("Event ")
EventPage:CreateSection("No active event")

local MusicPage = MainUi:CreateTab("Music", 6026568198)

local MusicTargets = {"Day ambience", "Night ambience", "ClientBackgroundMusic", "ClientBaseRadio"}
local MusicPresets = {
	["Halloween Day"] = {
		["ClientBackgroundMusic"] = 5707767063,
		["Day ambience"] = 9733943062,
	},
	["Halloween Night"] = {
		["ClientBackgroundMusic"] = 5707766686,
		["Night ambience"] = 9733940528,
	},
	["Normal Night"] = {
		["ClientBackgroundMusic"] = 6454368847,
		["Night ambience"] = 9733940528,
	},
}
local RadioTracks = {
	Mesmerize = 404060129,
	Roots = 474419296,
	["Cloud 9"] = 385287232,
	["Track 404064184"] = 404064184,
	Magic = 385290279,
	["Track 428553983"] = 428553983,
	Dreams = 385285034,
	["Tobu - Candyland"] = 335695249,
}

local function GetClientSound(name)
	local sound = SoundService:FindFirstChild(name, true)
	if sound and sound:IsA("Sound") then return sound end
	return nil
end

local function ToSoundId(value)
	local id = tostring(value or ""):match("(%d+)")
	if not id then return nil end
	return "rbxassetid://" .. id
end

local function ReplaceClientSound(name, value, shouldPlay)
	local sound = GetClientSound(name)
	local soundId = ToSoundId(value)
	if not soundId then
		Rayfield:Notify({Title = "Music", Content = "Enter a valid Roblox audio asset ID.", Duration = 5})
		return false
	end
	if not sound then
		Rayfield:Notify({Title = "Music", Content = "Could not find SoundService sound: " .. name, Duration = 6})
		return false
	end

	sound.SoundId = soundId
	if shouldPlay then
		pcall(function()
			sound.TimePosition = 0
			sound:Play()
		end)
	end
	return true
end

MusicPage:CreateSection("Seasonal music")
MusicPage:CreateDropdown({
	Name = "Music preset",
	Options = {"Halloween Day", "Halloween Night", "Normal Night"},
	CurrentOption = {Set.SelectedMusicPreset},
	MultipleOptions = false,
	Flag = "SelectedMusicPreset",
	Callback = function(options)
		Set.SelectedMusicPreset = options[1] or "Halloween Day"
	end,
})
MusicPage:CreateButton({
	Name = "Apply selected preset",
	Callback = function()
		local preset = MusicPresets[Set.SelectedMusicPreset]
		if not preset then return end
		local applied = 0
		for target, soundId in pairs(preset) do
			if ReplaceClientSound(target, soundId, true) then applied += 1 end
		end
		Rayfield:Notify({Title = "Music", Content = "Updated " .. applied .. " sound(s).", Duration = 4})
	end,
})

MusicPage:CreateSection("Base radio")
local radioOptions = {}
for name in pairs(RadioTracks) do table.insert(radioOptions, name) end
table.sort(radioOptions)
MusicPage:CreateDropdown({
	Name = "Radio song",
	Options = radioOptions,
	CurrentOption = {Set.SelectedRadioTrack},
	MultipleOptions = false,
	Flag = "SelectedRadioTrack",
	Callback = function(options)
		Set.SelectedRadioTrack = options[1] or "Mesmerize"
	end,
})
MusicPage:CreateButton({
	Name = "Set and play base radio",
	Callback = function()
		if ReplaceClientSound("ClientBaseRadio", RadioTracks[Set.SelectedRadioTrack], true) then
			Rayfield:Notify({Title = "Base radio", Content = Set.SelectedRadioTrack .. " is playing locally.", Duration = 4})
		end
	end,
})

MusicPage:CreateSection("Manual SoundService replacement")
MusicPage:CreateDropdown({
	Name = "Sound to replace",
	Options = MusicTargets,
	CurrentOption = {Set.SelectedMusicTarget},
	MultipleOptions = false,
	Flag = "SelectedMusicTarget",
	Callback = function(options)
		Set.SelectedMusicTarget = options[1] or "ClientBaseRadio"
	end,
})
MusicPage:CreateInput({
	Name = "Replacement audio ID",
	CurrentValue = Set.CustomMusicId,
	PlaceholderText = "e.g. 404060129 or rbxassetid://404060129",
	RemoveTextAfterFocusLost = false,
	Flag = "CustomMusicId",
	Callback = function(text)
		Set.CustomMusicId = text or ""
	end,
})
MusicPage:CreateButton({
	Name = "Replace and play selected sound",
	Callback = function()
		if ReplaceClientSound(Set.SelectedMusicTarget, Set.CustomMusicId, true) then
			Rayfield:Notify({Title = "Music", Content = Set.SelectedMusicTarget .. " updated locally.", Duration = 4})
		end
	end,
})

-- ===================== BOX FARMING TAB =====================
local BoxFarmPage = MainUi:CreateTab("Box Farming", 6031280882)

BoxFarmPage:CreateSection("Box Farming Controls")
BoxFarmPage:CreateToggle({
	Name = "Farm Boxes (Master Toggle)",
	CurrentValue = false,
	Flag = "AutoFarmBoxes",  
	Callback = function(Value)
		Set.FarmBoxes = Value
		if Set.TestingMode then print("Box Farming: ",Value) end 
	end,
})

BoxFarmPage:CreateToggle({
	Name = "Auto Confirm Candy (Yes)",
	CurrentValue = false,
	Flag = "AutoCandyConfirm",
	Callback = function(Value)
		Set.AutoCandyConfirm = Value
	end,
})

BoxFarmPage:CreateToggle({
	Name = "Ghost Load",
	CurrentValue = false,
	Flag = "GhostLoad",
	Callback = function(Value)
		Set.GhostLoad = Value
		if Set.TestingMode then print("Ghost Load:", Value) end
	end,
})

BoxFarmPage:CreateParagraph({
	Title = "<b>Ghost Load</b>",
	Content = "<i>Doesn't teleport to your base, anymore. You must be in the base to load your layouts. (Shared with Auto Rebirth layout loading.)</i>"
})

BoxFarmPage:CreateToggle({
	Name = "Anti-Base Safety",
	CurrentValue = false,
	Flag = "AntiBaseSafety",
	Callback = function(Value)
		Set.AntiBaseSafety = Value
		if Set.TestingMode then print("Anti-Base Safety:", Value) end
	end,
})

BoxFarmPage:CreateParagraph({
	Title = "<b>Anti-Base Safety</b>",
	Content = "<i>When ON: after box farming, teleports you back to base (private servers). When OFF (default): no spam teleport to the middle after farming.</i>"
})

BoxFarmPage:CreateSlider({
	Name = "Box Farm Speed",
	Range = {1, 100},
	Increment = 1,
	Suffix = "Speed",
	CurrentValue = 30,
	Flag = "BoxFarmSpeed",  
	Callback = function(Value)
		if Set.TestingMode then print("Box Farm speed",Value) end
		Set.BoxFarmSpeed = 101 - Value
	end,
})

BoxFarmPage:CreateToggle({
	Name = "Track Dropped Boxes (ESP)",
	CurrentValue = false,
	Flag = "TrackBoxes",  
	Callback = function(Value)
		ToggleBoxTrack(Value)
		if Set.TestingMode then print("Dropped Crate ESP: ",Value) end 
	end,
})

BoxFarmPage:CreateButton({
	Name = "Single Collect Boxes (High ban chance in public)",
	Callback = function()
		if Set.TestingMode then print("Collecting Boxes") end 
		CollectBoxes()
	end,
})

BoxFarmPage:CreateSection("Which Boxes To Farm")
BoxFarmPage:CreateToggle({
	Name = "Research / Basic Crates",
	CurrentValue = true,
	Flag = "FarmResearch",
	Callback = function(Value) Set.FarmResearch = Value end,
})
BoxFarmPage:CreateToggle({
	Name = "Golden Crates",
	CurrentValue = true,
	Flag = "FarmGolden",
	Callback = function(Value) Set.FarmGolden = Value end,
})
BoxFarmPage:CreateToggle({
	Name = "Diamond Crates",
	CurrentValue = true,
	Flag = "FarmDiamond",
	Callback = function(Value) Set.FarmDiamond = Value end,
})
BoxFarmPage:CreateToggle({
	Name = "Lucky Crates",
	CurrentValue = true,
	Flag = "FarmLucky",
	Callback = function(Value) Set.FarmLucky = Value end,
})
BoxFarmPage:CreateToggle({
	Name = "Shadow Crates",
	CurrentValue = true,
	Flag = "FarmShadow",
	Callback = function(Value) Set.FarmShadow = Value end,
})
BoxFarmPage:CreateToggle({
	Name = "Crystal Crates (Normal + Giant)",
	CurrentValue = true,
	Flag = "FarmCrystal",
	Callback = function(Value) Set.FarmCrystal = Value end,
})
BoxFarmPage:CreateToggle({
	Name = "Others (Seasonal / Executive / Gift / Gamepass)",
	CurrentValue = true,
	Flag = "FarmOthers",
	Callback = function(Value) Set.FarmOthers = Value end,
})

BoxFarmPage:CreateParagraph({
	Title = "<b>How Box Filtering Works</b>",
	Content = "<i>Turn OFF the specific crates you don't want. If you turn OFF Research/Golden/Diamond/Lucky/Shadow/Crystal, the script will only go for seasonals, Executive, Gift and other gamepass crates that drop from daily rewards / players.</i>"
})

-- ===================== OTHER OPTIONS =====================
local OtherOptionsPage = MainUi:CreateTab("Other Options",6023426938)
OtherOptionsPage:CreateSection("Testing")
OtherOptionsPage:CreateToggle({
	Name = "Testing Mode(set ore limit to 1 and check F9)",
	CurrentValue = false,
	Flag = "TestingMode",  
	Callback = function(Value)
		print("Testing mode", Value and "Enabled" or "Disabled")
		Set.TestingMode = Value
	end,
})

OtherOptionsPage:CreateSection("Visual Options")
OtherOptionsPage:CreateToggle({
	Name = "Disable Game Blur",
	CurrentValue = false,
	Flag = "GameBlur",  
	Callback = function(Value)
		if Set.TestingMode then print("game Blur toggle:", Value) end 
		Set.Blur = not Value
		game.Lighting.Blur.Enabled = Set.Blur
	end,
})

OtherOptionsPage:CreateSection("Character")
OtherOptionsPage:CreateSlider({
	Name = "Player Speed",
	Range = {16, 300},
	Increment = 1,
	Suffix = "Walk Speed",
	CurrentValue = 16,
	Flag = "WalkSpeed",  
	Callback = function(Value)
		if Set.TestingMode then print("Player Walk Speed set to",Value) end
		Player.Character.Humanoid.WalkSpeed = Value
		Set.WalkSpeed = Value
	end,
})

OtherOptionsPage:CreateSlider({
	Name = "Player Jump",
	Range = {50, 300},
	Increment = 1,
	Suffix = "Jump Power",
	CurrentValue = 50,
	Flag = "JumpPower",  
	Callback = function(Value)
		if Set.TestingMode then print("Player Jump set to",Value) end
		Player.Character.Humanoid.JumpPower = Value
		Set.JumpPower = Value
	end,
})

OtherOptionsPage:CreateSection("Useful Scripts")
OtherOptionsPage:CreateButton({
	Name = "Layout Stealer(Keybind N)",
	Callback = function()
		if Set.TestingMode then print("Loading External Script: Layout Stealer") end
		if FindUiByName("LayoutsStealer") then return end
		LoadExternal("https://raw.githubusercontent.com/MX6-RBX/MinersHavenScripts/refs/heads/main/LayoutLoaderRaw.lua")
	end,
})

OtherOptionsPage:CreateButton({
	Name = "Item Tracker(Keybnd T)",
	Callback = function()
		if Set.TestingMode then print("Loading External Script: Item Tracker") end
		if FindUiByName("ItemTracker") then return end
		LoadExternal("https://raw.githubusercontent.com/MX6-RBX/MinersHavenScripts/refs/heads/main/MinersHavenItemTracker.lua")
	end,
})

local SpoofPage = MainUi:CreateTab("Spoofer",6031215978)
SpoofPage:CreateSection("Info")
SpoofPage:CreateParagraph({Title = "<b>!WARNING!</b>", Content = "Spoofed Chats are local, Other player will seen tham as your roblox name."})

SpoofPage:CreateSection("Spoof Info")
SpoofPage:CreateInput({
	Name = "Fake Name",
	CurrentValue = "",
	PlaceholderText = "Fake Name",
	RemoveTextAfterFocusLost = false,
	Flag = "FakeName",
	Callback = function(Text)
		if Set.TestingMode then print("Fake Name set to",Text) end
		Set.FakeName = Text or Player.Name
	end,
})

SpoofPage:CreateToggle({
	Name = "Spoof Name",
	CurrentValue = false,
	Flag = "SpoofName",  
	Callback = function(Value)
		if Set.TestingMode then print("Toggled Name Spoofing:",Value) end
		Set.SpoofName = Value
	end,
})

SpoofPage:CreateInput({
	Name = "Custom Chat Tag(Rich Text Compatible)",
	CurrentValue = "[MX6]",
	PlaceholderText = "[MX6]",
	RemoveTextAfterFocusLost = false,
	Flag = "FakeTag",
	Callback = function(Text)
		if Set.TestingMode then print("Fake Tag set to",Text) end
		Set.CTag = Text
	end,
})

SpoofPage:CreateSlider({
	Name = "Additional Lifes",
	Range = {0, 5000},
	Increment = 1,
	Suffix = "Lives",
	CurrentValue = 0,
	Flag = "AddLives",  
	Callback = function(Value)
		if Set.TestingMode then print("Exta Lives set to:",Value) end
		Set.LifeVal = Value or 0
	end,
})

SpoofPage:CreateToggle({
	Name = "Spoof Rebirtrhs",
	CurrentValue = false,
	Flag = "SpoofLife",  
	Callback = function(Value)
		if Set.TestingMode then print("Spoof Lives toggle: ",Value) end
		Set.SpoofLife = Value
	end,
})

local Options = MainUi:CreateTab("UI Options",6031280882)
Options:CreateSection("UI Theme")
local ThemeDropdown = Options:CreateDropdown({
	Name = "GUI Theme",
	Options = {"Default","OG MH","AmberGlow","Amethyst","Bloom","DarkBlue","Green","Light","Ocean","Serenity","Custom"},
	CurrentOption = {NormalizeThemeName(Set.GUIThemeName) or "Default"},
	MultipleOptions = false,
	Flag = "GUITheme",  
	Callback = function(Options)
		local name = NormalizeThemeName(Options[1] or "Default")
		ApplyGuiTheme(name)
		if Set.TestingMode then print("GUI Theme:", name) end
	end,
})

Options:CreateParagraph({
	Title = "<b>OG MH</b>",
	Content = "<i>2017 Miner's Haven style: gray panels, money green, RP blue, flat corners, SourceSans, readable layout text boxes. Select any other theme to return to normal Rayfield. Saved.</i>"
})

Options:CreateSection("Advanced UI Theme")
Options:CreateParagraph({Title = "<b>Advanced Color Editing</b>", Content = "This allows for individual control of each color for parts of the gui"})

Options:CreateColorPicker({Name = "Text Color", Color = Color3.fromRGB(240, 240, 240), Flag = "TextColor", Callback = function(Value) CustomThemeTable.TextColor = Value or Color3.fromRGB(240, 240, 240) end})
Options:CreateColorPicker({Name = "Background", Color = Color3.fromRGB(25, 25, 25), Flag = "Background", Callback = function(Value) CustomThemeTable.Background = Value or Color3.fromRGB(25, 25, 25) end})
Options:CreateColorPicker({Name = "Topbar", Color = Color3.fromRGB(34, 34, 34), Flag = "Topbar", Callback = function(Value) CustomThemeTable.Topbar = Value or Color3.fromRGB(34, 34, 34) end})
Options:CreateColorPicker({Name = "Shadow", Color = Color3.fromRGB(20, 20, 20), Flag = "Shadow", Callback = function(Value) CustomThemeTable.Shadow = Value or Color3.fromRGB(20, 20, 20) end})
Options:CreateColorPicker({Name = "Notification Background", Color = Color3.fromRGB(20, 20, 20), Flag = "NotificationBackground", Callback = function(Value) CustomThemeTable.NotificationBackground = Value or Color3.fromRGB(20, 20, 20) end})
Options:CreateColorPicker({Name = "Notification Actions Background", Color = Color3.fromRGB(230, 230, 230), Flag = "NotificationActionsBackground", Callback = function(Value) CustomThemeTable.NotificationActionsBackground = Value or Color3.fromRGB(230, 230, 230) end})
Options:CreateColorPicker({Name = "Tab Background", Color = Color3.fromRGB(80, 80, 80), Flag = "TabBackground", Callback = function(Value) CustomThemeTable.TabBackground = Value or Color3.fromRGB(80, 80, 80) end})
Options:CreateColorPicker({Name = "Tab Stroke", Color = Color3.fromRGB(85, 85, 85), Flag = "TabStroke", Callback = function(Value) CustomThemeTable.TabStroke = Value or Color3.fromRGB(85, 85, 85) end})
Options:CreateColorPicker({Name = "Selected Tab Background", Color = Color3.fromRGB(210, 210, 210), Flag = "TabBackgroundSelected", Callback = function(Value) CustomThemeTable.TabBackgroundSelected = Value or Color3.fromRGB(210, 210, 210) end})
Options:CreateColorPicker({Name = "Tab Text Color", Color = Color3.fromRGB(240, 240, 240), Flag = "TabTextColor", Callback = function(Value) CustomThemeTable.TabTextColor = Value or Color3.fromRGB(240, 240, 240) end})
Options:CreateColorPicker({Name = "Selected Tab Text Color", Color = Color3.fromRGB(50, 50, 50), Flag = "SelectedTabTextColor", Callback = function(Value) CustomThemeTable.SelectedTabTextColor = Value or Color3.fromRGB(50, 50, 50) end})
Options:CreateColorPicker({Name = "Element Background", Color = Color3.fromRGB(35, 35, 35), Flag = "ElementBackground", Callback = function(Value) CustomThemeTable.ElementBackground = Value or Color3.fromRGB(35, 35, 35) end})
Options:CreateColorPicker({Name = "Element Background Hover", Color = Color3.fromRGB(40, 40, 40), Flag = "ElementBackgroundHover", Callback = function(Value) CustomThemeTable.ElementBackgroundHover = Value or Color3.fromRGB(40, 40, 40) end})
Options:CreateColorPicker({Name = "Secondary Element Background", Color = Color3.fromRGB(25, 25, 25), Flag = "SecondaryElementBackground", Callback = function(Value) CustomThemeTable.SecondaryElementBackground = Value or Color3.fromRGB(25, 25, 25) end})
Options:CreateColorPicker({Name = "Element Stroke", Color = Color3.fromRGB(50, 50, 50), Flag = "ElementStroke", Callback = function(Value) CustomThemeTable.ElementStroke = Value or Color3.fromRGB(50, 50, 50) end})
Options:CreateColorPicker({Name = "Secondary Element Stroke", Color = Color3.fromRGB(40, 40, 40), Flag = "SecondaryElementStroke", Callback = function(Value) CustomThemeTable.SecondaryElementStroke = Value or Color3.fromRGB(40, 40, 40) end})
Options:CreateColorPicker({Name = "Slider Background", Color = Color3.fromRGB(50, 138, 220), Flag = "SliderBackground", Callback = function(Value) CustomThemeTable.SliderBackground = Value or Color3.fromRGB(50, 138, 220) end})
Options:CreateColorPicker({Name = "Slider Progress", Color = Color3.fromRGB(50, 138, 220), Flag = "SliderProgress", Callback = function(Value) CustomThemeTable.SliderProgress = Value or Color3.fromRGB(50, 138, 220) end})
Options:CreateColorPicker({Name = "Slider Stroke", Color = Color3.fromRGB(58, 163, 255), Flag = "SliderStroke", Callback = function(Value) CustomThemeTable.SliderStroke = Value or Color3.fromRGB(58, 163, 255) end})
Options:CreateColorPicker({Name = "Toggle Background", Color = Color3.fromRGB(30, 30, 30), Flag = "ToggleBackground", Callback = function(Value) CustomThemeTable.ToggleBackground = Value or Color3.fromRGB(30, 30, 30) end})
Options:CreateColorPicker({Name = "Toggle Enabled", Color = Color3.fromRGB(0, 146, 214), Flag = "ToggleEnabled", Callback = function(Value) CustomThemeTable.ToggleEnabled = Value or Color3.fromRGB(0, 146, 214) end})
Options:CreateColorPicker({Name = "Toggle Disabled", Color = Color3.fromRGB(100, 100, 100), Flag = "ToggleDisabled", Callback = function(Value) CustomThemeTable.ToggleDisabled = Value or Color3.fromRGB(100, 100, 100) end})
Options:CreateColorPicker({Name = "Toggle Enabled Stroke", Color = Color3.fromRGB(0, 170, 255), Flag = "ToggleEnabledStroke", Callback = function(Value) CustomThemeTable.ToggleEnabledStroke = Value or Color3.fromRGB(0, 170, 255) end})
Options:CreateColorPicker({Name = "Toggle Disabled Stroke", Color = Color3.fromRGB(125, 125, 125), Flag = "ToggleDisabledStroke", Callback = function(Value) CustomThemeTable.ToggleDisabledStroke = Value or Color3.fromRGB(125, 125, 125) end})
Options:CreateColorPicker({Name = "Toggle Enabled Outer Stroke", Color = Color3.fromRGB(100, 100, 100), Flag = "ToggleEnabledOuterStroke", Callback = function(Value) CustomThemeTable.ToggleEnabledOuterStroke = Value or Color3.fromRGB(100, 100, 100) end})
Options:CreateColorPicker({Name = "Toggle Disabled Outer Stroke", Color = Color3.fromRGB(65, 65, 65), Flag = "ToggleDisabledOuterStroke", Callback = function(Value) CustomThemeTable.ToggleDisabledOuterStroke = Value or Color3.fromRGB(65, 65, 65) end})
Options:CreateColorPicker({Name = "Dropdown Selected", Color = Color3.fromRGB(40, 40, 40), Flag = "DropdownSelected", Callback = function(Value) CustomThemeTable.DropdownSelected = Value or Color3.fromRGB(40, 40, 40) end})
Options:CreateColorPicker({Name = "Dropdown Unselected", Color = Color3.fromRGB(30, 30, 30), Flag = "DropdownUnselected", Callback = function(Value) CustomThemeTable.DropdownUnselected = Value or Color3.fromRGB(30, 30, 30) end})
Options:CreateColorPicker({Name = "Input Background", Color = Color3.fromRGB(30, 30, 30), Flag = "InputBackground", Callback = function(Value) CustomThemeTable.InputBackground = Value or Color3.fromRGB(30, 30, 30) end})
Options:CreateColorPicker({Name = "Input Stroke", Color = Color3.fromRGB(65, 65, 65), Flag = "InputStroke", Callback = function(Value) CustomThemeTable.InputStroke = Value or Color3.fromRGB(65, 65, 65) end})
Options:CreateColorPicker({Name = "Placeholder Color", Color = Color3.fromRGB(178, 178, 178), Flag = "PlaceholderColor", Callback = function(Value) CustomThemeTable.PlaceholderColor = Value or Color3.fromRGB(178, 178, 178) end})

Options:CreateButton({
	Name = "Apply Custom theme colors",
	Callback = function()
		ApplyGuiTheme("Custom")
		pcall(function() ThemeDropdown:Set({"Custom"}) end)
	end,
})

-- ===================== CORE LOGIC =====================
local function RebornPrice(Player)
	local Life = Player.Rebirths.Value+1
	if Life >= 80351 then return 1e241 end
	local x = Life - 1
	local cost
	if Life >= 1 and Life <= 40 then
		cost = 2.5 * (10^19) * (x + 1)
	elseif Life >= 41 and Life <= 5000 then
		cost = ((10^19) * ((5 * math.floor(x / 5)) + 2.5) * ((100 * math.floor(x / 25)) + 1) * ((1000 * math.floor(x / 500)) + 1)) ^ ((0.00024 * x) + 1)
	elseif Life >= 5001 then
		cost = ((10^19) * ((5 * math.floor(x / 5)) + 2.5) * ((100 * math.floor(x / 25)) + 1) * ((1000 * math.floor(x / 500)) + 1)) ^ ((0.00024 * math.floor(10 * ((12500 * (x ^ 4)) ^ (1/7)))) + 1)
	else
		return 2.5 * (10^19)
	end
	if cost >= 1e241 then return 1e241 end
	return cost
end

local function RunOreThroughPart(Ore, part)
	if not Ore or not part then return end
	part = ResolveToBasePart(part) or (part:IsA("BasePart") and part)
	if not part or not part:IsA("BasePart") then return end
	local loops = math.max(1, tonumber(Set.UpgradeLoopCount) or 1)
	for _ = 1, loops do
		if not HubAlive() or not Set.OreBoostActive or not Ore or not Ore.Parent then break end
		pcall(function()
			Ore.Anchored = true
			Ore.AssemblyLinearVelocity = Vector3.zero
			Ore.AssemblyAngularVelocity = Vector3.zero
			Ore.CFrame = part.CFrame + Vector3.new(0, 0.5, 0)
		end)
		task.wait(0.008)
		pcall(function()
			Ore.Anchored = false
		end)
		task.wait(0.004)
	end
end

function BoostOre(Ore)
	if not HubAlive() then return end
	if not Ore or not Ore.Parent then return end
	local base = GetPlayerTycoon() or Tycoon
	if not base then return end

	if Set.TestingMode then print("Ore boost Start on", base.Name) end

	local upgradeCount = 0
	for _, v in base:GetChildren() do
		if not HubAlive() or Set.OreBoostActive == false then break end
		if not Ore or not Ore.Parent or not v then break end
		if table.find(Data.ResettersNames, v.Name) then continue end
		if Set.UsingMoneyLoop and Data.MoneyLoopables[v.Name] then continue end

		local upgradePart = FindUpgradePart(v)
		if upgradePart then
			upgradeCount += 1
			if Set.TestingMode then
				print("Boost through:", v.Name, "→", upgradePart:GetFullName())
			end
			RunOreThroughPart(Ore, upgradePart)
		elseif IsFurnaceItem(v) then
			local prefer = Set.PrimaryFurnaceName
			local usingAuto = (not prefer or prefer == "" or prefer == "Auto")
			if usingAuto and (not IsFurnaceItem(Set.Furnace)) then
				Set.Furnace = v
			elseif not usingAuto and v.Name == prefer then
				Set.Furnace = v
			end
		elseif IsMineItem(v) then
			local model = v:FindFirstChild("Model")
			local lava = FindLavaPart(v)
			if lava and model and model:FindFirstChild("Drop", true) then
				if Set.IndMine == nil or not Set.IndMine.Parent then
					Set.IndMine = v
				end
			end
		end
	end

	if Set.TestingMode then
		print("Ore boost End — passed", upgradeCount, "upgrader(s)")
	end
end

function Reset(Ore)
	local function passNamed(item)
		if not item or not Ore or not Set.OreBoostActive then return end
		local part = FindUpgradePart(item)
		if part then RunOreThroughPart(Ore, part) end
	end

	local base = GetPlayerTycoon() or Tycoon
	if not base then
		base = Tycoon
	end

	local Dae = base:FindFirstChild("Daestrophe")
	local Sac = base:FindFirstChild("The Final Upgrader") or base:FindFirstChild("The Ultimate Sacrifice")
	local Star = base:FindFirstChild("Void Star") or base:FindFirstChild("Black Dwarf") or base:FindFirstChild("⭐ Stargazed Black Dwarf ⭐") or base:FindFirstChild("⭐ Beloved Black Dwarf ⭐") or base:FindFirstChild("⭐ Stargazed Void Star ⭐")
	local Tes = base:FindFirstChild("Tesla Resetter") or base:FindFirstChild("⭐ Advanced Tesla Resetter ⭐") or base:FindFirstChild("⭐ Spooky Tesla Resetter ⭐") or base:FindFirstChild("Tesla Refuter") or base:FindFirstChild("⭐ Advanced Tesla Refuter ⭐")

	BoostOre(Ore)
	if Star and Ore and Set.OreBoostActive then
		passNamed(Star)
		BoostOre(Ore)
	end
	if Tes and Ore and Set.OreBoostActive then
		passNamed(Tes)
		BoostOre(Ore)
	end
	if Sac and Ore and Set.OreBoostActive then
		passNamed(Sac)
		BoostOre(Ore)
	end
	if Dae and Ore and Set.OreBoostActive then
		passNamed(Dae)
		BoostOre(Ore)
	end
end

function GetFurnace()
	local preferred = Set.PrimaryFurnaceName
	if preferred and preferred ~= "" and preferred ~= "Auto" then
		local f = Tycoon:FindFirstChild(preferred)
		if IsFurnaceItem(f) then
			Set.Furnace = f
			if Set.TestingMode then print("Primary furnace resolved:", f.Name) end
		elseif Set.TestingMode then
			warn("Primary furnace not on base:", preferred, "— using Auto")
		end
	end

	for _, v in Tycoon:GetChildren() do
		if IsFurnaceItem(v) then
			if Set.Furnace == nil or not IsFurnaceItem(Set.Furnace) then
				Set.Furnace = v
			end
		end
		if IsMineItem(v) then
			if Set.IndMine == nil or not Set.IndMine.Parent then
				Set.IndMine = v
			end
		end
	end
	return Set.Furnace
end

function Sell(Ore)
	if not Ore then return end
	local furn = nil
	local preferred = Set.PrimaryFurnaceName
	if preferred and preferred ~= "" and preferred ~= "Auto" then
		local f = Tycoon:FindFirstChild(preferred)
		if IsFurnaceItem(f) then furn = f end
	end
	if not furn then
		if not IsFurnaceItem(Set.Furnace) then
			GetFurnace()
		end
		furn = Set.Furnace
	else
		Set.Furnace = furn
	end
	local lava = furn and FindLavaPart(furn)
	if lava then
		Ore.CFrame = lava.CFrame + Vector3.new(0, 1, 0)
	elseif Set.TestingMode then
		warn("Sell: no valid furnace/lava found (need MoneyScript and/or Lava part)")
	end
end

local function IdentifyOreMine(ore)
	if not ore then return nil end
	local cached = Data.OreMineCache[ore]
	if cached ~= nil then return cached or nil end
	local result
	for _, childName in ipairs({"Source", "Mine", "Origin", "DroppedFrom", "From"}) do
		local c = ore:FindFirstChild(childName)
		if c then
			if c:IsA("ObjectValue") and c.Value then result = c.Value.Name break end
			if c:IsA("StringValue") and c.Value ~= "" then result = c.Value break end
		end
	end
	if not result then
		local attrMine = ore:GetAttribute("Mine") or ore:GetAttribute("Source") or ore:GetAttribute("Origin")
		if attrMine and tostring(attrMine) ~= "" then result = tostring(attrMine) end
	end
	if not result then
		local bestName, bestDist = nil, 30
		local pos = ore:IsA("BasePart") and ore.Position or (ore:IsA("Model") and ore:GetPivot().Position)
		if pos then
			for _, v in Tycoon:GetChildren() do
				if IsMineItem(v) then
					local drop = v.Model:FindFirstChild("Drop", true)
					if drop and drop:IsA("BasePart") then
						local d = (drop.Position - pos).Magnitude
						if d < bestDist then
							bestDist = d
							bestName = v.Name
						end
					end
				end
			end
		end
		result = bestName
	end
	Data.OreMineCache[ore] = result or false
	return result
end

local function ShouldOreBoostThisOre(ore)
	if next(Data.SelectedOreMineSet) then
		local source = IdentifyOreMine(ore)
		return Data.SelectedOreMineSet[source] == true, true
	end

	local legacyMine = Set.PrimaryMineName
	if Set.SingularOre and legacyMine and legacyMine ~= "" and legacyMine ~= "None" then
		return IdentifyOreMine(ore) == legacyMine, true
	end

	return true, false
end

local function CollectMoneyLoopInstances(base)
	local list = {}
	if not base then return list end
	for name, info in pairs(Data.MoneyLoopables) do
		for _, child in base:GetChildren() do
			if child.Name == name then
				local part = FindUpgradePart(child)
				if part then
					table.insert(list, {
						Item = child,
						Name = name,
						Info = info,
						Part = part,
						LastHit = 0,
						Hits = 0,
					})
				end
			end
		end
	end
	return list
end

local function GetProtectPart(base)
	if not base then return nil end
	for _, name in ipairs(Data.EffectRemovers) do
		local item = base:FindFirstChild(name)
		if item then
			local p = FindUpgradePart(item)
			if p then return p end
		end
	end
	return nil
end

local function HitMoneyLoopPart(Ore, part, minWait)
	if not Ore or not part or not part.Parent then return end
	pcall(function()
		Ore.Anchored = true
		Ore.AssemblyLinearVelocity = Vector3.zero
		Ore.AssemblyAngularVelocity = Vector3.zero
		Ore.CFrame = part.CFrame + Vector3.new(0, 0.5, 0)
	end)
	task.wait(minWait or 0.1)
	pcall(function()
		if Ore and Ore.Parent then Ore.Anchored = false end
	end)
end
local function RunStarMoneyLoop(Ore, stars, protectPart)
	if not Ore or #stars == 0 then return end
	local cap = 0
	for _, s in ipairs(stars) do
		if s.Info.Cap and s.Info.Cap > cap then cap = s.Info.Cap end
	end
	if cap <= 0 then cap = 1e30 end

	if Set.TestingMode then
		print("Star money loop:", #stars, "star instance(s), cap=", cap)
	end

	while HubAlive() and Ore and Ore.Parent and Set.OreBoost and Set.OreBoostActive and Set.UsingMoneyLoop do
		local cash = Ore:FindFirstChild("Cash")
		if not cash or cash.Value <= 0 or cash.Value >= cap then break end

		local hitsThisPass = 0
		for _, s in ipairs(stars) do
			if not HubAlive() or not Ore or not Ore.Parent then break end
			cash = Ore:FindFirstChild("Cash")
			if not cash or cash.Value <= 0 or cash.Value >= cap then break end
			if not s.Item or not s.Item.Parent then continue end
			if not s.Part or not s.Part.Parent then
				s.Part = FindUpgradePart(s.Item)
			end
			if not s.Part then continue end

			local cd = s.Info.Cooldown or 1.55
			local now = os.clock()
			local need = (s.LastHit + cd) - now
			if need > 0 then
				task.wait(need)
			end
			if not Ore.Parent or not s.Part.Parent then continue end

			HitMoneyLoopPart(Ore, s.Part, s.Info.MinWait or 0.12)
			s.LastHit = os.clock()
			s.Hits += 1
			hitsThisPass += 1

			if s.Info.Effect and protectPart and protectPart.Parent and Ore.Parent then
				pcall(function()
					Ore.CFrame = protectPart.CFrame + Vector3.new(0, 0.5, 0)
				end)
				task.wait(0.06)
			end
		end

		if hitsThisPass == 0 then break end
	end
end

local function RunNormalMoneyLoop(Ore, entries, protectPart)
	if not Ore or #entries == 0 then return end
	table.sort(entries, function(a, b)
		return (a.Info.Cap or 0) > (b.Info.Cap or 0)
	end)
	local primary = entries[1]
	local Info = primary.Info
	local cap = Info.Cap or 1e30

	repeat
		if not Ore or not Ore.Parent then break end
		local cash = Ore:FindFirstChild("Cash")
		if not cash or cash.Value <= 0 then break end
		if Info.MinVal and cash.Value < Info.MinVal then break end
		if not HubAlive() or not Set.OreBoost or not Set.OreBoostActive then break end

		for _, e in ipairs(entries) do
			if not Ore.Parent then break end
			cash = Ore:FindFirstChild("Cash")
			if not cash or cash.Value >= cap then break end
			if not e.Part or not e.Part.Parent then
				e.Part = e.Item and FindUpgradePart(e.Item)
			end
			if e.Part then
				for _ = 1, math.max(1, tonumber(Set.UpgradeLoopCount) or 1) do
					HitMoneyLoopPart(Ore, e.Part, Info.MinWait or 0.01)
					if Info.Effect and protectPart then
						pcall(function() Ore.CFrame = protectPart.CFrame end)
						task.wait(0.03)
					end
				end
			end
		end
		task.wait(0.02)
	until not HubAlive() or not Ore or not Ore.Parent
		or not Ore:FindFirstChild("Cash")
		or Ore.Cash.Value >= cap
		or Ore.Cash.Value <= 0
end

local function RunOreBoost(Ore)
	if not HubAlive() then return end
	if Set.TestingMode then print("Ore Boost Setting up") end
	repeat task.wait() until not HubAlive() or Ore:FindFirstChild("Cash")
	if not HubAlive() or not Ore or not Ore:FindFirstChild("Cash") then return end
	if Ore.Cash.Value <= 0 then
		Ore.Anchored = false
		return
	end

	local base = GetPlayerTycoon() or Tycoon
	if Set.UsingMoneyLoop and base then
		local all = CollectMoneyLoopInstances(base)
		local protectPart = GetProtectPart(base)

		local stars, normals = {}, {}
		for _, e in ipairs(all) do
			if e.Info.IsStar then
				table.insert(stars, e)
			else
				table.insert(normals, e)
			end
		end

		if #stars > 0 then
			RunStarMoneyLoop(Ore, stars, protectPart)
		elseif #normals > 0 then
			RunNormalMoneyLoop(Ore, normals, protectPart)
		end
	end

	if Set.OreBoostActive then Reset(Ore) end
	if Ore then
		Ore.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
		Ore.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
		Sell(Ore)
	end
end

local MAX_DEFAULT_ORE_BOOSTS = 2
local MAX_SELECTED_MINE_BOOSTS = 8

function StartOreBoost(Ore, selectedMine)
	if not HubAlive() or not Ore or not Ore.Parent then return end
	local maxWorkers = selectedMine and MAX_SELECTED_MINE_BOOSTS or MAX_DEFAULT_ORE_BOOSTS
	if Data.ActiveOreBoosts[Ore] or Data.ActiveOreBoostCount >= maxWorkers then return end

	Data.ActiveOreBoosts[Ore] = true
	Data.ActiveOreBoostCount += 1
	local ok, err = pcall(RunOreBoost, Ore)
	Data.ActiveOreBoosts[Ore] = nil
	Data.ActiveOreBoostCount = math.max(0, Data.ActiveOreBoostCount - 1)
	if not ok and Set.TestingMode then warn("Ore boost error:", err) end
end

local function ResolveFireProximityPrompt()
	if typeof(fireproximityprompt) == "function" then
		return fireproximityprompt
	end
	if getgenv and typeof(getgenv().fireproximityprompt) == "function" then
		return getgenv().fireproximityprompt
	end
	if getrenv then
		local ok, r = pcall(function() return getrenv().fireproximityprompt end)
		if ok and typeof(r) == "function" then return r end
	end
	return nil
end

local function CollectBaseProximityPrompts()
	local prompts = {}
	local seen = {}
	local function addFrom(root)
		if not root or not root.Parent then return end
		local ok, descendants = pcall(function() return root:GetDescendants() end)
		if not ok or not descendants then return end
		for _, d in descendants do
			if d and d.Parent and d:IsA("ProximityPrompt") and not seen[d] then
				seen[d] = true
				table.insert(prompts, d)
			end
		end
	end
	addFrom(Tycoon)
	pcall(function()
		if ActiveTycoon and ActiveTycoon.Value and ActiveTycoon.Value ~= Tycoon then
			addFrom(ActiveTycoon.Value)
		end
	end)
	pcall(function()
		if Player.PlayerTycoon and Player.PlayerTycoon.Value and Player.PlayerTycoon.Value ~= Tycoon then
			addFrom(Player.PlayerTycoon.Value)
		end
	end)
	return prompts
end
local function FireOneProximityPrompt(prompt, fireFn)
	if not prompt or not prompt.Parent then return end
	if not prompt:IsA("ProximityPrompt") then return end

	if prompt.Enabled == false then return end

	pcall(function()
		prompt:InputHoldBegin()
	end)
	pcall(function()
		prompt:InputHoldEnd()
	end)

	if fireFn then
		pcall(fireFn, prompt)
		return
	end

	pcall(function()
		if firesignal and prompt.Triggered then
			firesignal(prompt.Triggered, Player)
		end
	end)
	pcall(function()
		if getconnections then
			for _, c in getconnections(prompt.Triggered) do
				if c.Function then pcall(c.Function, Player) end
			end
		end
	end)
end

local cachedBasePrompts = {}
local nextPromptScanAt = 0

local function FireBaseProximityPrompts()
	if not Set.AutoFirePrompts or not HubAlive() then return end
	if Set.Rebirthing or Set.LayoutLoading then return end

	local now = os.clock()
	if now >= nextPromptScanAt then
		cachedBasePrompts = CollectBaseProximityPrompts()
		nextPromptScanAt = now + 1
	end

	local fireFn = ResolveFireProximityPrompt()

	for _, prompt in ipairs(cachedBasePrompts) do
		if not HubAlive() then break end
		if prompt and prompt.Parent then
			pcall(FireOneProximityPrompt, prompt, fireFn)
		end
	end
end

function Load()
	Set.LayoutLoading = true
	Set.LayoutVerified = false
	local expectedFinal = 0
	local ok, err = pcall(function()
		if Set.TestingMode then print("Start Layout Loading") end
		TeleportForLayoutLoad()
		task.wait(0.15)
		if Set.OreBoost then Set.OreBoostActive = true end
		Net.DestroyAll:Invoke()
		task.wait(0.15)

		local function looksComplete(expected, fraction)
			local have = CountPlacedItems()
			if expected and expected > 0 then
				return have >= math.max(1, math.floor(expected * (fraction or 0.9)))
			end
			return have >= 5
		end

		local exp1 = LoadOneLayout(Set.Layout1)
		expectedFinal = exp1 or 0
		if not looksComplete(expectedFinal, 0.5) then
			TeleportForLayoutLoad()
			task.wait(0.1)
			Net.DestroyAll:Invoke()
			task.wait(0.15)
			expectedFinal = LoadOneLayout(Set.Layout1) or expectedFinal
		end

		if Set.Layout2 ~= "None" then
			task.wait(Set.LayoutWaitTime)
			Set.OreBoostActive = false
			task.wait(0.3)
			if Set.WithdrawBase then
				Net.DestroyAll:Invoke()
				task.wait(0.15)
			end
			TeleportForLayoutLoad()
			local exp2 = LoadOneLayout(Set.Layout2)
			if Set.WithdrawBase then
				expectedFinal = exp2 or CountPlacedItems()
			else
				expectedFinal = CountPlacedItems()
			end
			if not looksComplete(expectedFinal, 0.85) then
				TeleportForLayoutLoad()
				task.wait(0.1)
				if Set.WithdrawBase then
					Net:Invoke()
					task.wait(0.15)
				end
				local exp2b = LoadOneLayout(Set.Layout2)
				if Set.WithdrawBase then
					expectedFinal = exp2b or expectedFinal
				else
					expectedFinal = math.max(expectedFinal, CountPlacedItems())
				end
			end
			task.wait(0.1)
			if Set.OreBoost then Set.OreBoostActive = true end
		end

		local settled = WaitForLayoutSettle(3, 1)
		if expectedFinal and expectedFinal > 0 then
			Set.LayoutExpectedCount = math.max(expectedFinal, settled)
		else
			Set.LayoutExpectedCount = settled
		end
		Set.LayoutVerified = looksComplete(Set.LayoutExpectedCount, 0.9)
		if Set.LayoutVerified then Set.LayoutReloadFails = 0 end
		if Set.AutoResizeUpgraders then ResizeUpgraders() end
		Set.Furnace = nil
		Set.IndMine = nil
		GetFurnace()
		if Set.TestingMode then print("Layout load done. items=", CountPlacedItems(), " expected=", Set.LayoutExpectedCount, " verified=", Set.LayoutVerified, " furnace=", Set.Furnace and Set.Furnace.Name) end
	end)
	Set.LayoutLoading = false
	if Set.OreBoost then Set.OreBoostActive = true end
	if not ok then warn("Load() error:", err) end
end

local function EnsureLayoutLoaded()
	if not HubAlive() then return end
	if Set.LayoutLoading or Set.Rebirthing then return end
	if not Set.AutoRebirth then return end
	if not Set.LayoutExpectedCount or Set.LayoutExpectedCount <= 0 then return end
	if IsLayoutFullyLoaded(0.9) then
		Set.LayoutVerified = true
		Set.LayoutReloadFails = 0
		return
	end
	if os.clock() - (Set.LastLayoutReloadAt or 0) < 6 then return end

	local have = CountPlacedItems()
	if (Set.LayoutReloadFails or 0) >= 3 then
		if have > 0 then
			Set.LayoutExpectedCount = have
			Set.LayoutVerified = true
			Set.LayoutReloadFails = 0
		end
		return
	end

	Set.LastLayoutReloadAt = os.clock()
	Set.LayoutVerified = false
	local stackedLayouts = (Set.Layout2 and Set.Layout2 ~= "None" and not Set.WithdrawBase)

	if stackedLayouts then
		Load()
		if IsLayoutFullyLoaded(0.9) then Set.LayoutReloadFails = 0
		else Set.LayoutReloadFails = (Set.LayoutReloadFails or 0) + 1 end
		return
	end

	Set.LayoutLoading = true
	local ok, err = pcall(function()
		TeleportForLayoutLoad()
		task.wait(0.1)
		local finalName = (Set.Layout2 and Set.Layout2 ~= "None") and Set.Layout2 or Set.Layout1
		Net.DestroyAll:Invoke()
		task.wait(0.15)
		local exp = LoadOneLayout(finalName)
		if exp and exp > 0 then
			Set.LayoutExpectedCount = math.max(Set.LayoutExpectedCount, exp)
		else
			local settled = WaitForLayoutSettle(4, 1)
			if settled > (Set.LayoutExpectedCount or 0) then Set.LayoutExpectedCount = settled end
		end
	end)
	Set.LayoutLoading = false
	if not ok then warn("EnsureLayoutLoaded soft reload error:", err) end

	if IsLayoutFullyLoaded(0.9) then
		Set.LayoutVerified = true
		Set.LayoutReloadFails = 0
		if Set.OreBoost then Set.OreBoostActive = true end
		if Set.AutoResizeUpgraders then pcall(ResizeUpgraders) end
		return
	end
	Load()
	if IsLayoutFullyLoaded(0.9) then Set.LayoutReloadFails = 0
	else Set.LayoutReloadFails = (Set.LayoutReloadFails or 0) + 1 end
end

GetFurnace()
if Ores then
	Track(Ores.ChildAdded:Connect(function(Child)
		if not HubAlive() then return end
		if Set.OreTracking then AddTracker(Child) end
		if Set.OreSize > 0 then 
			Child.Size = Vector3.new(Set.OreSize,Set.OreSize,Set.OreSize)
		end
		if Set.OreBoost then
			if Child:FindFirstChild("Fuel") and Set.Fuel then
				if Set.IndMine then
					local lava = FindLavaPart(Set.IndMine)
					if lava then
						Child.CFrame = lava.CFrame + Vector3.new(0, 1, 0)
					end
				end
				return 
			end
			local shouldBoost, selectedMine = ShouldOreBoostThisOre(Child)
			if not shouldBoost then
				return
			end
			StartOreBoost(Child, selectedMine)
		elseif Set.FarmRp then
			Sell(Child)
		end
	end))
end

local nextRebirthAt = 0

local function isInfiniteMoney(value)
	if type(value) == "number" then
		if value ~= value then return false end
		return value == math.huge or value == -math.huge
	end
	local s = string.lower(tostring(value or ""))
	s = string.gsub(s, "[%s%$]", "")
	if s == "inf" or s == "+inf" or s == "-inf" or s == "infinity" then return true end
	if string.find(s, "inf", 1, true) then return true end
	return false
end

local function canAffordRebirth(money, price)
	if isInfiniteMoney(money) then return true end
	if type(money) ~= "number" or money ~= money then return false end
	if type(price) ~= "number" or price ~= price or isInfiniteMoney(price) then return false end
	return money > price
end

local function rollRebirthWait()
	local minW = tonumber(Set.MinWait) or 0
	local maxW = tonumber(Set.MaxWait) or minW
	if minW < 0 then minW = 0 end
	if maxW < 0 then maxW = 0 end
	if maxW < minW then minW, maxW = maxW, minW end
	if maxW <= minW then return minW end
	return minW + math.random() * (maxW - minW)
end

local function scheduleNextRebirthWait(reason)
	local waitSec = rollRebirthWait()
	nextRebirthAt = os.clock() + waitSec
	if Set.TestingMode then
		print(string.format("AutoRebirth: next attempt in %.2fs (%s) [min=%s max=%s]",
			waitSec, reason or "wait", tostring(Set.MinWait), tostring(Set.MaxWait)))
	end
end

local function stopAutoRebirthAtLife()
	BoostToggle:Set(false)
	AutoRebithToggle:Set(false)
	Set.OreBoost = false
	Set.OreBoostActive = false
	Set.AutoRebirth = false
end

local function TryAutoRebirth()
	if not HubAlive() then return end
	if not Set.AutoRebirth then return end
	if Set.Rebirthing or Set.LayoutLoading then return end
	if os.clock() < nextRebirthAt then return end
	if Set.StopLife > 0 and Player.Rebirths.Value >= Set.StopLife then return end

	local moneyVal
	local moneyOk, moneyErr = pcall(function() moneyVal = Money.Value end)
	if not moneyOk then
		if Set.TestingMode then warn("AutoRebirth money read failed:", moneyErr) end
		return
	end

	local priceOk, RB = pcall(function() return RebornPrice(Player) * (1000 ^ (Set.Skips or 0)) end)
	if not priceOk then
		if Set.TestingMode then warn("AutoRebirth price calc failed:", RB) end
		return
	end

	if not canAffordRebirth(moneyVal, RB) then return end

	if Set.TestingMode then
		print("AutoRebirth: can afford. money=", moneyVal, " price=", RB, " inf=", isInfiniteMoney(moneyVal))
	end

	Set.Rebirthing = true
	Set.OreBoostActive = false

	local lifeBefore = Player.Rebirths.Value
	local ranOk, ranErr = pcall(function()
		task.wait(0.1)
		Net.Rebirth:Invoke()
		local deadline = os.clock() + 3
		while Player.Rebirths.Value <= lifeBefore and os.clock() < deadline do
			task.wait(0.1)
		end
		if Player.Rebirths.Value <= lifeBefore then
			if Set.TestingMode then warn("AutoRebirth: rebirth not confirmed, will retry after wait") end
			scheduleNextRebirthWait("rebirth-not-confirmed")
			return
		end
		if Set.TestingMode then print("AutoRebirth: rebirthed to life", Player.Rebirths.Value + 1) end
		if Set.StopLife > 0 and Player.Rebirths.Value >= Set.StopLife then
			stopAutoRebirthAtLife()
			return
		end
		if not Set.AutoRebirth then return end
		Load()
		if Set.AutoRebirth then scheduleNextRebirthWait("after-layout-load") end
	end)

	Set.Rebirthing = false
	Set.LayoutLoading = false
	if Set.OreBoost and Set.AutoRebirth then Set.OreBoostActive = true end
	if not ranOk then
		warn("AutoRebirth error:", ranErr)
		scheduleNextRebirthWait("error-backoff")
	end
end

RequestAutoRebirthCheck = function()
	local ok, err = pcall(TryAutoRebirth)
	if not ok then
		warn("RequestAutoRebirthCheck error:", err)
		Set.Rebirthing = false
		Set.LayoutLoading = false
	end
end

if Money then
	Track(Money.Changed:Connect(function()
		if not HubAlive() then return end
		if Set.AutoRebirth then RequestAutoRebirthCheck() end
	end))
end

task.spawn(function()
	while HubAlive() do
		task.wait(0.35)
		if not HubAlive() then break end
		if Set.AutoRebirth then
			local okL, errL = pcall(EnsureLayoutLoaded)
			if not okL and Set.TestingMode then warn("EnsureLayoutLoaded error:", errL) end
		end
		if Set.AutoRebirth then RequestAutoRebirthCheck() end
	end
end)

task.spawn(function()
	local stuckSince = nil
	while HubAlive() do
		task.wait(1)
		if not HubAlive() then break end
		if Set.Rebirthing or Set.LayoutLoading then
			stuckSince = stuckSince or os.clock()
			if os.clock() - stuckSince > 120 then
				warn("AutoRebirth: force-clearing stuck Rebirthing/LayoutLoading flags")
				Set.Rebirthing = false
				Set.LayoutLoading = false
				if Set.OreBoost then Set.OreBoostActive = true end
				stuckSince = nil
				if Set.AutoRebirth then scheduleNextRebirthWait("force-unstuck") end
			end
		else
			stuckSince = nil
		end
	end
end)

if Set.TrackBoxes then
	for _, box in ipairs(Boxes:GetChildren()) do AddBoxTrack(box) end
end

Track(Net.ItemObtained:Connect(function(Item,Amount)
	if not HubAlive() then return end
	if not Item:FindFirstChild("Tier") then return end 
	if Item.Tier.Value == 78 and Item.Name == Set.StopSlipstream then
		BoostToggle:Set(false)
		AutoRebithToggle:Set(false)
		Set.OreBoost = false
		Set.OreBoostActive = false
		Set.AutoRebirth = false
	end
end))

Track(game.Workspace.Boxes.ChildAdded:Connect(function(Box)
	if not HubAlive() then return end
	if Set.TrackBoxes then AddBoxTrack(Box) end
end))

local CharacterConnections = {}
local function ClearCharacterConnections()
	for i = #CharacterConnections, 1, -1 do
		DisconnectTracked(CharacterConnections[i])
		CharacterConnections[i] = nil
	end
end

local function TrackCharacterConnection(conn)
	Track(conn)
	if conn then table.insert(CharacterConnections, conn) end
	return conn
end

Track(Player.CharacterAdded:Connect(function(character)
	if not HubAlive() then return end
	ClearCharacterConnections()
	local humanoid = character:WaitForChild("Humanoid", 10)
	if not humanoid or not HubAlive() then return end
	if humanoid.WalkSpeed < Set.WalkSpeed then humanoid.WalkSpeed = Set.WalkSpeed end
	if humanoid.JumpPower < Set.JumpPower then humanoid.JumpPower = Set.JumpPower end
	TrackCharacterConnection(humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
		if not HubAlive() then return end
		if humanoid.WalkSpeed < Set.WalkSpeed then humanoid.WalkSpeed = Set.WalkSpeed end
	end))
	TrackCharacterConnection(humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
		if not HubAlive() then return end
		if humanoid.JumpPower < Set.JumpPower then humanoid.JumpPower = Set.JumpPower end
	end))
	TrackCharacterConnection(character.Destroying:Connect(ClearCharacterConnections))
end))

Track(game.Lighting.Blur:GetPropertyChangedSignal("Enabled"):Connect(function()
	if not HubAlive() then return end
	game.Lighting.Blur.Enabled = Set.Blur
end))

Track(ActiveTycoon.Changed:Connect(function()
	if not HubAlive() then return end
	if (ActiveTycoon.Value == nil or ActiveTycoon.Value.Name ~= Tycoon.Name) and Set.AntiLeaveBase then
		Player.Character.Humanoid.Health = 0
	end
end))

Hub.ChatHandler = function(Message)
	if not HubAlive() then return end
	if Message then
		if Message.Text and not Message.TextSource then
			local NewText = Message.Text
			if string.find(Message.Text, Player.DisplayName) then 
				if Set.SpoofName then NewText = string.gsub(NewText,Player.DisplayName,Set.FakeName) end
			end
			if string.find(Message.Text, Player.Name) then 
				if Set.SpoofName then NewText = string.gsub(NewText,Player.Name,Set.FakeName) end
			end
			if string.find(Message.Text,"was born") then
				local CurrentLifeText = comma(Player.Rebirths.Value+1)
				local NewLife = HandleLife(tonumber(Player.Rebirths.Value+Set.LifeVal))
				if Set.SpoofLife then NewText = string.gsub(NewText,CurrentLifeText.."(..)",NewLife) end
				Message.Text = NewText
			end
		elseif Message.TextSource then 
			if string.find(Message.PrefixText, tostring(Player.DisplayName)) then 
				if Set.SpoofName then
					Message.PrefixText = string.gsub(Message.PrefixText,tostring(Player.DisplayName),Set.CTag..Set.FakeName)
				end
			elseif not string.find(Message.PrefixText, tostring(Player.DisplayName)) and string.find(Message.Text, Player.DisplayName) then 
				local NewText = Message.Text
				if Set.SpoofName then NewText = string.gsub(NewText,Player.DisplayName,Set.FakeName) end
				Message.Text = NewText
			end
		end
	end
end
Chat.OnIncomingMessage = Hub.ChatHandler

Track(game.Players.PlayerAdded:Connect(function(Plr)
	if not HubAlive() then return end
	if not table.find(PlayerList,Plr.Name) then table.insert(PlayerList,Plr.Name) end
	PlayerSelectDropdown:Refresh(PlayerList)
end))
Track(game.Players.PlayerRemoving:Connect(function(Plr)
	if not HubAlive() then return end
	local Pos = table.find(PlayerList,Plr.Name)
	if Pos then table.remove(PlayerList,Pos) end
	PlayerSelectDropdown:Refresh(PlayerList)
end))

local VS = game:GetService("VirtualUser")
Track(game.Players.LocalPlayer.Idled:Connect(function()
	if not HubAlive() then return end
	VS:CaptureController()
	VS:ClickButton2(Vector2.new())
end))

function Hub.Unload()
	Hub.Alive = false

	local S = Hub.Set or Set
	if S then
		S.AutoRebirth = false
		S.OreBoost = false
		S.OreBoostActive = false
		S.FarmBoxes = false
		S.AutoCandyConfirm = false
		S.OpenBoxes = false
		S.AutoDrop = false
		S.AutoFirePrompts = false
		S.FarmRp = false
		S.Rebirthing = false
		S.LayoutLoading = false
		S.CollectingBoxes = false
		S.TrackBoxes = false
		S.OreTracking = false
		S.AntiLeaveBase = false
		S.AutoResizeUpgraders = false
		S.UsingMoneyLoop = false
	end

	for i = #Hub.Connections, 1, -1 do
		DisconnectTracked(Hub.Connections[i])
	end
	table.clear(Hub.Connections)
	table.clear(Hub.ConnectionIndices)

	if Data then
		ClearBoxTrackers()
		ClearOreTrackers()
		table.clear(Data.ActiveOreBoosts)
		Data.ActiveOreBoostCount = 0
	end
	table.clear(cachedBasePrompts)
	ClearCharacterConnections()

	pcall(function()
		if Chat.OnIncomingMessage == Hub.ChatHandler then
			Chat.OnIncomingMessage = nil
		end
	end)

	pcall(function()
		if Hub.GUi then Hub.GUi:Destroy() end
	end)

	pcall(function()
		if StopOldMHRestyleWatch then StopOldMHRestyleWatch() end
	end)

	DestroyHubGuis()
	pcall(function()
		if Rayfield and Rayfield.Destroy then Rayfield:Destroy() end
	end)
	pcall(function()
		if MainUi and MainUi.Destroy then MainUi:Destroy() end
	end)

	if ENV[HUB_KEY] == Hub then
		ENV[HUB_KEY] = nil
	end

	print("[MX6 Hub] Previous instance unloaded (safe to re-execute).")
end

Rayfield:LoadConfiguration()

task.defer(function()
	if not HubAlive() then return end
	local theme = NormalizeThemeName(Set.GUIThemeName or "Default")
	pcall(function()
		ApplyGuiTheme(theme)
		if theme == "OG MH" then
			pcall(function() ThemeDropdown:Set({"OG MH"}) end)
		end
	end)
end)

task.spawn(function()
	local lastBoxOpen, lastRemoteDrop, lastOreKill = 0, 0, 0
	while HubAlive() do
		task.wait(0.1)
		if not HubAlive() then break end
		local now = os.clock()
		if Set.FarmBoxes then CollectBoxes() end
		if Set.OpenBoxes and (now - lastBoxOpen >= (Set.BoxWait or 1)) then
			Net.MysteryBox:Invoke(Set.SelectedBox or "Regular")
			lastBoxOpen = now
		end
		if Set.AutoDrop and (now - lastRemoteDrop >= 0.5) then
			if RemoteDrop and type(RemoteDrop.Fire) == "function" then
				RemoteDrop:Fire()
			else
				warn("[MX6] Auto Remote drops unavailable: Net.RemoteDrop does not expose Fire().")
				Set.AutoDrop = false
			end
			lastRemoteDrop = now
		end
		if Set.AutoKillOresWait > 0 and (now - lastOreKill >= Set.AutoKillOresWait) then
			KillOres()
			lastOreKill = now
		end
	end
end)

task.spawn(function()
	local lastCountLog = 0
	while HubAlive() do
		if Set.AutoFirePrompts then
			local ok, err = pcall(FireBaseProximityPrompts)
			if not ok and Set.TestingMode then
				warn("FireBaseProximityPrompts error:", err)
			end
			if Set.TestingMode and os.clock() - lastCountLog > 4 then
				lastCountLog = os.clock()
				local n = #CollectBaseProximityPrompts()
				local hasFire = ResolveFireProximityPrompt() ~= nil
				print(string.format(
					"Auto Fire Prompts: %d prompt(s) | fireproximityprompt=%s",
					n, tostring(hasFire)
					))
			end
			task.wait(0.5)
		else
			task.wait(0.3)
		end
	end
end)

-- Only webhook in this whole script, is that God loves you!
print("[MX6 Hub] Loaded. Re-executing this script will replace this instance cleanly.")
