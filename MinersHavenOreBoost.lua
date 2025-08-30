local Player = game.Players.LocalPlayer
local Tycoon = Player.PlayerTycoon.Value
local Ores = game.Workspace.DroppedParts:FindFirstChild(Tycoon.Name)
local GUI = Player.PlayerGui.GUI
local Money = GUI:FindFirstChild("Money")
local Boxes = game.Workspace.Boxes
local Layout1 = "Layou1"
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

local UILib = loadstring(game:HttpGet("https://raw.githubusercontent.com/MX6-RBX/UiLib/refs/heads/main/UiLib.lua"))()
local MainUi = UILib.new("Miners Haven Hub")
local BoostPage = MainUi:addPage("Boost Options","130772689610761")
local BoostSection = BoostPage:addSection("Main Options")
local AutoSection = BoostPage:addSection("Other Options")
local OtherOptionsPage = MainUi:addPage("Other Options","6023426938")
local VisualSection = OtherOptionsPage:addSection("Visual Options")
local CharSection = OtherOptionsPage:addSection("Character")

local Options = MainUi:addPage("UI Options","6031280882")
local OptionsSection = Options:addSection("Main")
local UIThemeSection = Options:addSection("UI Colors")
UILib:setTheme("Glow",Color3.fromRGB(240, 234, 81))

local function AddBoxTrack(Box)
	local Ui = GUi:Clone()
	Ui.Box.Text = Box.Name
	Ui.Box.BackgroundColor3 = Box.Color
	Ui.AlwaysOnTop = true
	Ui.Parent = Box
	Ui.Adornee = Box
	Ui.Box.BackgroundTransparency = 0
	Ui.Enabled = TrackBoxes
end

local function ToggleBoxTrack(Val)
	TrackBoxes = Val
	for i,v in Boxes:GetChildren() do
		if v:FindFirstChildOfClass("BillboardGui") then
			v:FindFirstChildOfClass("BillboardGui").Enabled = Val
		else
			AddBoxTrack(v)
		end
	end
end

local AutoRebirthToggle = BoostSection:addToggle("Auto Rebirth",false,function(Val)
	AutoRebirth = Val
end)
local OreBoostToggle = BoostSection:addToggle("Ore Boost",false,function(Val)
	OreBoost = Val
	OreBoostActive = Val
end)
local MooneyLoopToggle = BoostSection:addToggle("Use Money Loopables",false,function(Val)
	UsingMoneyLoop = Val
end)

local MinWaitBox = BoostSection:addTextbox("Minimum Rebirth Wait","20",function(text)
	MinWait = tonumber(text) or 20
end)
local LayoutSelect = BoostSection:addDropdown("First Layout ",{"Layout1","Layout2","Layout3"}, function(Selected)
	Layout1 = Selected
end)
local LayoutWaitBox = BoostSection:addTextbox("Layout 2 load Wait","5",function(text)
	LayoutWaitTime = tonumber(text) or 5
end)

local LayoutSelect2 = BoostSection:addDropdown("Second Layout ",{"None","Layout1","Layout2","Layout3"}, function(Selected)
	Layout2 = Selected
end)

local OreTrackToggle = AutoSection:addToggle("Track Ore Value",false,function(Val)
	OreTracking = Val
end)

local NightTime = VisualSection:addButton("Set Night Time", function()
	game.ReplicatedStorage.NightTime.Value = true
end)

local DayTime = VisualSection:addButton("Set Day Time", function()
	game.ReplicatedStorage.NightTime.Value = false
end)

local BoxTrack = VisualSection:addToggle("Track Dropped Boxes",false,function(Val)
	ToggleBoxTrack(Val)
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

function BoostOre(Ore,Single)
	for i,v in Tycoon:GetChildren() do
		if OreBoostActive == false and Single == false then break end--Oreboost not active
		if not Ore then break end--Ore missing
		if not v  then break end--ItemMissing
		if MoneyLoopables[v.Name] or table.find(ResettersNames,v.Name) then continue end--Passes money loops and resetters

		if v and v:FindFirstChild("ItemId") and v:FindFirstChild("Plane")  then
			if v and v:FindFirstChild("Model") and v.Model:FindFirstChild("Upgrade") then
				local SavePos = v.Model.Upgrade.CFrame
				v.Model.Upgrade.CFrame = v.Model.Upgrade.CFrame + Vector3.new(0,20,0)
				for i=1,3 do
					Ore.CFrame =v.Model.Upgrade.CFrame
					wait(0.05)
				end
				v.Model.Upgrade.CFrame = SavePos
			elseif v and v:FindFirstChild("Model") and v.Model:FindFirstChild("Lava") and not v.Model:FindFirstChild("Lava"):FindFirstChild("TeleportSend") then
				if Furnace == nil or Furnace:FindFirstChild("Model") == nil or Furnace.Model:FindFirstChild("Lava")then 
					Furnace = v	
				end
			end
		end
	end

end

function Reset(Ore)
	local Dae = Tycoon:FindFirstChild("Daestrophe") 
	local Sac =  Tycoon:FindFirstChild("The Final Upgrader") or Tycoon:FindFirstChild("The Ultimate Sacrifice")  
	local Star = Tycoon:FindFirstChild("Void Star") or Tycoon:FindFirstChild("Black Dwarf")
	local Tes = Tycoon:FindFirstChild("Resetter") or Tycoon:FindFirstChild("Tesla Refuter")
	
	BoostOre(Ore)
	if Dae and Ore and OreBoostActive then 
		for i=1,3 do 
			Ore.CFrame = Dae.Model.Upgrade.CFrame
		end
		BoostOre(Ore)
	end
	if Sac and Ore and OreBoostActive then 
		for i=1,3 do 
			Ore.CFrame = Sac.Model.Upgrade.CFrame
		end
		BoostOre(Ore)
	end
	if Star and Ore and OreBoostActive then 
		for i=1,3 do 
			Ore.CFrame = Star.Model.Upgrade.CFrame
		end
		BoostOre(Ore)
	end
	if Tes and Ore and OreBoostActive then 
		for i=1,3 do 
			Ore.CFrame = Tes.Model.Upgrade.CFrame
		end
		BoostOre(Ore)
	end
end

function StartOreBoost(Ore)
	Ore.Anchored = true
	repeat wait() until Ore:FindFirstChild("Cash")

	local SavePos = Ore.CFrame
	local MoneyLoop = nil
	local LooperStats 
	local Protect
	Ore.Anchored = false
	if UsingMoneyLoop then
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
			local Info = MoneyLoopables[MoneyLoop.Name]
			repeat 
				if not Ore then
					break
				end
				if OreBoost == false or OreBoostActive == false then break end 
				Ore.CFrame = MoneyLoop.Model.Upgrade.CFrame
				if LooperStats.Effect ~= nil and Protect ~= nil then
					Ore.CFrame = Protect.Model.Upgrade.CFrame
				else
					print("No effect or missing removing device")
				end
				wait(0.1)
			until Ore == nil or MoneyLoop == nil or MoneyLoop:FindFirstChild("Model") == nil or Ore:FindFirstChild("Cash") == nil or Ore.Cash.Value >= Info.Cap
		end
	end
	if OreBoostActive then
		Reset(Ore)
	end

	if Ore then
		Ore.AssemblyAngularVelocity = Vector3.new(0,0,0)
		Ore.AssemblyLinearVelocity = Vector3.new(0,0,0)
		if Furnace and Furnace:FindFirstChild("Model") then
			Ore.CFrame = Furnace.Model.Lava.CFrame + Vector3.new(0,2,0)
		else
			Ore.CFrame = SavePos	
		end
	end

end

function Load()
	if OreBoost then
		OreBoostActive = true
	end
	game.ReplicatedStorage.DestroyAll:InvokeServer()
	wait(0.1)
	game.ReplicatedStorage.Layouts:InvokeServer("Load",Layout1)
	if Layout2 ~= "None" then
		wait(LayoutWaitTime)
		OreBoostActive = false
		if OreBoost then
			wait(0.3)
			game.ReplicatedStorage.DestroyAll:InvokeServer()
			wait(0.1)
			game.ReplicatedStorage.Layouts:InvokeServer("Load","Layout3")
			wait(0.1)
			OreBoostActive = true
		end
	end
end

if Ores then
	Ores.ChildAdded:Connect(function(Child)
		if OreBoost then
			StartOreBoost(Child)
		end
	end)
end

local SingleBoost = BoostSection:addButton("Single Boost", function()
	StartOreBoost()
end)

local rebirthing  = false
local LastRebirth = os.time()
Money.Changed:Connect(function()
	local RB = RebornPrice(Player)
	if AutoRebirth and not rebirthing and  Money.Value > RB and os.time()-LastRebirth >= MinWait then
		rebirthing = true
		OreBoostActive = false
		wait(.5)
		game.ReplicatedStorage.Rebirth:InvokeServer()
		wait(2)
		rebirthing = false
		LastRebirth = os.time()
		if AutoRebirth then
			Load()
		end
	end
end)


game.Workspace.Boxes.ChildAdded:Connect(function(Box)
	AddBoxTrack(Box)
end)
