local Player = game.Players.LocalPlayer
local Tycoon = Player.PlayerTycoon.Value
local Ores = game.Workspace.DroppedParts:FindFirstChild(Tycoon.Name)
local GUI = Player.PlayerGui:WaitForChild("GUI")
local PlaceItem = game.ReplicatedStorage.PlaceItem 
local buyItem = game.ReplicatedStorage.BuyItem 
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
local OreTracking = false
local FarmRp = false
local TrackBoxes = false
local TestingMode = false
local AddRandomness = false
local Fule = false

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
local Suffixes = { "k", "M", "B", "T", "qd", "Qn", "sx", "Sp", "O", "N", "de", "Ud", "DD", "tdD", "qdD", "QnD", "sxD", "SpD", "OcD", "NvD", "Vgn", "UVg", "DVg", "TVg", "qtV", "QnV", "SeV", "SPG", "OVG", "NVG", "TGN", "UTG", "DTG", "tsTG", "qtTG", "QnTG", "ssTG", "SpTG", "OcTG", "NoTG", "QdDR", "uQDR", "dQDR", "tQDR", "qdQDR", "QnQDR", "sxQDR", "SpQDR", "OQDDr", "NQDDr", "qQGNT", "uQGNT", "dQGNT", "tQGNT", "qdQGNT", "QnQGNT", "sxQGNT", "SpQGNT", "OQQGNT", "NQQGNT", "SXGNTL", "USXGNTL", "DSXGNTL", "TSXGNTL", "QTSXGNTL", "QNSXGNTL", "SXSXGNTL", "SPSXGNTL", "OSXGNTL", "NVSXGNTL", "SPTGNTL", "USPTGNTL", "DSPTGNTL", "TSPTGNTL", "QTSPTGNTL", "QNSPTGNTL", "SXSPTGNTL", "SPSPTGNTL", "OSPTGNTL", "NVSPTGNTL", "OTGNTL", "UOTGNTL", "DOTGNTL", "TOTGNTL", "QTOTGNTL", "QNOTGNTL", "SXOTGNTL", "SPOTGNTL", "OTOTGNTL", "NVOTGNTL", "NONGNTL", "UNONGNTL", "DNONGNTL", "TNONGNTL", "QTNONGNTL", "QNNONGNTL", "SXNONGNTL", "SPNONGNTL", "OTNONGNTL", "NONONGNTL", "CENT", "UNCENT","inf" }  

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
}

local EffectRemovers = {"Wild Spore", "Deadly Spore", "Azure Spore", "The Death Cap"}

local ResettersNames = {"Resetter","Tesla Refuter","Black Dwarf","Void Star","The Ultimate Sacrifice","The Final Upgrader","Daestrophe"}
local Resetters = {
	{Item = "Tesla Resetter", Evo = "Tesla Refuter",IPosition = Vector3.new(12,2,0)},
	{Item = "Black Dwarf",Evo = "Void Star",IPosition =  Vector3.new(24,2,0)},
	{Item = "The Ultimate Sacrifice", Evo = "The Final Upgrader",IPosition = Vector3.new(36,2,0)},
	{Item = "Daestrophe",Evo = nil, IPosition =  Vector3.new(48,2,0)}
}	

local function LoadExternlLayout(Layout)--Converts a shared layout string to a placeable layout
	
	----printLayout)
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

local OreTrackers = {}
local BoxTrackers = {}
local ELayout = loadstring(game:HttpGet('https://raw.githubusercontent.com/MX6-RBX/MinersHavenScripts/refs/heads/main/BasicFirstLife.lua'))()
local UILib = loadstring(game:HttpGet("https://raw.githubusercontent.com/MX6-RBX/UiLib/refs/heads/main/UiLib.lua"))()
local MainUi = UILib.new("Miners Haven Hub")
local BoostPage = MainUi:addPage("Boost Options","130772689610761")
local BoostSection = BoostPage:addSection("Main Options")
local AutoSection = BoostPage:addSection("Other Options")
local VendorsPage = MainUi:addPage("Vendors","6031097225")
local GuiInteractions = VendorsPage:addSection("GUI's")
local OtherOptionsPage = MainUi:addPage("Other Options","6023426938")
local TestSecrion = OtherOptionsPage:addSection("Testing")
local VisualSection = OtherOptionsPage:addSection("Visual Options")
local CharSection = OtherOptionsPage:addSection("Character")

local Options = MainUi:addPage("UI Options","6031280882")
local OptionsSection = Options:addSection("Main")
local UIThemeSection = Options:addSection("UI Colors")
UILib:setTheme("Glow",Color3.fromRGB(240, 234, 81))

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

local function AddTracker(ore)
	local Ui = GUi:Clone()
	Ui.Box.Text = ore.Cash.Value
	Ui.AlwaysOnTop = true
	Ui.Parent = ore
	Ui.Adornee = ore
	Ui.Enabled = OreTracking
	table.insert(OreTrackers,Ui)
	ore.Cash.Changed:Connect(function()
		Ui.Box.Text = "$"..shorten(ore.Cash.Value)
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

local AutoRebirthToggle = BoostSection:addToggle("Auto Rebirth",false,function(Val)
	AutoRebirth = Val
	if TestingMode then
		print("Auto Rebirth: ",Val)
	end 
end)
local OreBoostToggle = BoostSection:addToggle("Ore Boost",false,function(Val)
	OreBoost = Val
	OreBoostActive = Val
	if TestingMode then
		print("Ore Boost: ",Val)
	end 
end)
local IgnoreFuleToggle = BoostSection:addToggle("Ignore Fule ore(coal ext)",false,function(Val)
	Fule = Val
	if TestingMode then
		print("Ignore Fule: ",Val)
	end 
end)

local FarmRPToggle = BoostSection:addToggle("Farm RP(Disable ore boost)",false,function(Val)
	FarmRp = Val
	if TestingMode then
		print("Farm RP: ",Val)
	end 
end)
local MooneyLoopToggle = BoostSection:addToggle("Use Money Loopables",false,function(Val)
	UsingMoneyLoop = Val
	if TestingMode then
		print("Money Loopables: ",Val)
	end 
end)

local MinWaitBox = BoostSection:addTextbox("Minimum Rebirth Wait","20",function(text)
	MinWait = tonumber(text) or 20
	if TestingMode then
		print("Minimum rebirth wait : ",text)
	end 
end)

local WaitRandom = BoostSection:addToggle("Add Wait Randomness ",false,function(Val)
	AddRandomness = Val
	if TestingMode then
		print("Minimum rebirth wait randomness: ",Val)
	end 
end)
local LayoutSelect = BoostSection:addDropdown("First Layout ",{"Layout1","Layout2","Layout3"}, function(Selected)
	Layout1 = Selected
	if TestingMode then
		print("First Layout: ",Selected)
	end 
end)
local LayoutWaitBox = BoostSection:addTextbox("Layout 2 load Wait","5",function(text)
	LayoutWaitTime = tonumber(text) or 5
	if TestingMode then
		print("Layout Spit wait: ",text)
	end 
end)

local LayoutSelect2 = BoostSection:addDropdown("Second Layout ",{"None","Layout1","Layout2","Layout3"}, function(Selected)
	Layout2 = Selected
	if TestingMode then
		print("Second Layout: ",Selected)
	end 
end)
local FirstLife = BoostSection:addButton("Load Badic First Life Setup(15qd-390qd, Warning loud)", function()
	if TestingMode then
		print("Loading Basic First Life Layout.")
	end
	ClearBase:InvokeServer()
	LoadExternlLayout(ELayout)
	
end)

local OreTrackToggle = AutoSection:addToggle("Track Ore Value",false,function(Val)
	ToggleOreTrack(Val)
	if TestingMode then
		print("Ore Value Tracking: ",Val)
	end 
end)

local Craftsman = GuiInteractions:addButton("Open Craftsman", function()
	ChangeUi("Craftsman")
end)
local Boxman = GuiInteractions:addButton("Open Box merchant", function()
	ChangeUi("SpookMcDookShop")
end)
local Superstitious = GuiInteractions:addButton("Open Superstitious Crafting", function()
	ChangeUi("SuperstitiousCrafting")
end)
local TBOK = GuiInteractions:addButton("Open True Book Of Knowlage", function()
	ChangeUi("BOKBook")
end)
local Phantasm = GuiInteractions:addButton("Open Phantasm", function()
	ChangeUi("Phantasm")
end)
local Fleabag = GuiInteractions:addButton("Open Fleabag", function()
	ChangeUi("Fleabag")
end)

local Testing = TestSecrion:addToggle("Testing Mode(set ore limit to 1 and check F9)",false,function(Val)
	TestingMode = Val
end)

local BoxTrack = VisualSection:addToggle("Track Dropped Boxes",false,function(Val)
	ToggleBoxTrack(Val)
	if TestingMode then
		print("Dropped Crate ESP: ",Val)
	end 
end)


local CharSpeed = CharSection:addSlider("Player Speed",16,1,200,function(val)
	Player.Character.Humanoid.WalkSpeed = val
end)
local CharJump = CharSection:addSlider("Player Jump",50,1,300,function(val)
	Player.Character.Humanoid.JumpPower = val
end)

local ToggleKey = OptionsSection:addKeybind("UI Toggle",Enum.KeyCode.K,function(Key)
	MainUi:toggle()--Toggles the gui when the set key is pressed
end)

local Background = UIThemeSection:addColorPicker("Background", Color3.fromRGB(0,0,0),function(Col)
	UILib:setTheme("Background",Col)
end)
local Glow = UIThemeSection:addColorPicker("Glow", Color3.fromRGB(170,170,0),function(Col) 
	UILib:setTheme("Glow",Col)
end)
local Accent = UIThemeSection:addColorPicker("Accent", Color3.fromRGB(50,50,50),function(Col) 
	UILib:setTheme("Accent",Col)
end)
local LightContrast = UIThemeSection:addColorPicker("Light Contrast", Color3.fromRGB(30,30,30),function(Col) 
	UILib:setTheme("LightContrast",Col)
end)
local DarkContrast = UIThemeSection:addColorPicker("Dark Contrast", Color3.fromRGB(10,10,10),function(Col) 
	UILib:setTheme("DarkContrast",Col)
end)
local TextColor = UIThemeSection:addColorPicker("Text Color", Color3.fromRGB(255,255,255),function(Col) 
	UILib:setTheme("TextColor",Col)
end)
local ScrollBarColor = UIThemeSection:addColorPicker("Scroll Bar Color", Color3.fromRGB(200,200,200),function(Col) 
	UILib:setTheme("ScrollBarColor",Col)
end)
local MaxRebirthPrice = 1e241 -- 10 * 10^240 = 10^241



local function RebornPrice(Player)
	local Life = Player.Rebirths.Value
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

		if v and v:FindFirstChild("ItemId") and v:FindFirstChild("Plane")  then
			if v and v:FindFirstChild("Model") and v.Model:FindFirstChild("Upgrade") then
				for i=1,3 do
					Ore.CFrame =v.Model.Upgrade.CFrame 
					wait(0.01)
				end
			elseif v and v:FindFirstChild("Model") and v.Model:FindFirstChild("Lava") and not v.Model:FindFirstChild("Lava"):FindFirstChild("TeleportSend") and not v.Model:FindFirstChild("Lava"):FindFirstChild("Drop") then
				if Furnace == nil or Furnace:FindFirstChild("Model") == nil or Furnace.Model:FindFirstChild("Lava")then 
					Furnace = v	
				end
			end
		end
	end
	if TestingMode then
		print("Ore boost End")
	end 
end

function Reset(Ore)
	local Dae = Tycoon:FindFirstChild("Daestrophe") 
	local Sac =  Tycoon:FindFirstChild("The Final Upgrader") or Tycoon:FindFirstChild("The Ultimate Sacrifice")  
	local Star = Tycoon:FindFirstChild("Void Star") or Tycoon:FindFirstChild("Black Dwarf")
	local Tes = Tycoon:FindFirstChild("Resetter") or Tycoon:FindFirstChild("Tesla Refuter")

	BoostOre(Ore)
	if Dae and Ore and OreBoostActive then --checks if Daestrophe is on the base
		if TestingMode then
			print("Found Daestrophe")
		end 
		for i=1,3 do 
			Ore.CFrame = Dae.Model.Upgrade.CFrame
			wait(0.01)
		end
		BoostOre(Ore)
	else
		if TestingMode then
			print("Daestrophe Not found")
		end
	end
	if Sac and Ore and OreBoostActive then  --Checks if either of the sacrifice resetters are on the base 
		if TestingMode then
			print("Found ", Sac.Name)
		end 
		for i=1,3 do 
			Ore.CFrame = Sac.Model.Upgrade.CFrame
			wait(0.01)
		end
		BoostOre(Ore)
	else
		if TestingMode then
			print("Sacrifice resetter Not found")
		end				
	end
	if Star and Ore and OreBoostActive then --Checks if black dwarf or void star is on the base 
		if TestingMode then
			print("Found ", Star.Name)
		end 
		for i=1,3 do 
			Ore.CFrame = Star.Model.Upgrade.CFrame
			wait(0.01)
		end
		BoostOre(Ore)
	else
		if TestingMode then
			print("Void star/black dwarf Not found")
		end
	end
	if Tes and Ore and OreBoostActive then --Checks if either tesla is on the base
		if TestingMode then
			print("Found ", Tes.Name)
		end 
		for i=1,3 do 
			Ore.CFrame = Tes.Model.Upgrade.CFrame
			wait(0.01)
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
		if v and v:FindFirstChild("ItemId") and v:FindFirstChild("Plane")  then
			if v and v:FindFirstChild("Model") and v.Model:FindFirstChild("Lava") and not v.Model:FindFirstChild("Lava"):FindFirstChild("TeleportSend") then
				if Furnace == nil or Furnace:FindFirstChild("Model") == nil or Furnace.Model:FindFirstChild("Lava") == nil then 
					Furnace = v	
				end
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

	local SavePos = Ore.CFrame
	local MoneyLoop = nil
	local LooperStats 
	local Protect
	Ore.Anchored = false
	if TestingMode then
		print("Ore Boost finished setting up")
	end 
	if UsingMoneyLoop then
		if TestingMode then
			print("Using Money cap Items ")
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
				print("Found Money Loop item: ",MoneyLoop)
			end 
			local Info = MoneyLoopables[MoneyLoop.Name]
			repeat 
				if not Ore then
					break
				end
				if OreBoost == false or OreBoostActive == false then break end
				for i=1,3 do
					Ore.CFrame = MoneyLoop.Model.Upgrade.CFrame
					wait()
				end

				if LooperStats.Effect ~= nil and Protect ~= nil then
					Ore.CFrame = Protect.Model.Upgrade.CFrame
				else
					if TestingMode then
						print("No effect or missing removing device")
					end
				end
				wait(0.1)
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
			Ore.CFrame = Furnace.Model.Lava.CFrame + Vector3.new(0,2,0)
		else
			if TestingMode then
				print("No Furnace found, sending ore to spawn location")
			end 
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
		if OreBoost then
			wait(0.3)
			game.ReplicatedStorage.DestroyAll:InvokeServer()
			wait(0.1)
			if TestingMode then
				print("Load Second Layout")
			end 
			game.ReplicatedStorage.Layouts:InvokeServer("Load",Layout2)
			wait(0.1)
			OreBoostActive = true
		end
	end
end

if Ores then
	Ores.ChildAdded:Connect(function(Child)
		
		AddTracker(Child)
		if Child:FindFirstChild("Fule") and Fule == false then return end 
		if OreBoost then
			
			StartOreBoost(Child)
		elseif FarmRp then
			Sell(Child)

		end

	end)
end

local rebirthing  = false
local LastRebirth = os.time()
Money.Changed:Connect(function()
	if TestingMode then
		print("Money Updfated")
	end 
	local RB = RebornPrice(Player)

	if AutoRebirth and not rebirthing and  Money.Value > RB and os.time()-LastRebirth >= MinWait then
		if TestingMode then
			print("Auto Rebirth")
		end 
		rebirthing = true
		OreBoostActive = false
		wait(.5)
		game.ReplicatedStorage.Rebirth:InvokeServer()
		wait(2)
		rebirthing = false
		MinWait= MinWait + math.random(1,20) * (AddRandomness and 1 or 0)
		if AutoRebirth then
			if TestingMode then
				print("Rebirthed.")
			end 
			Load()
		end
	end
end)

for i,v in Boxes:GetChildren(1) do
	AddBoxTrack(v)
end
game.Workspace.Boxes.ChildAdded:Connect(function(Box)
	AddBoxTrack(Box)
end)
