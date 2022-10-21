local Run = game:GetService("RunService")
local Hub = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/kavo-Ui-Library/main/source.lua"))()
local NPCs = game:GetService("Workspace").Map:FindFirstChild("TrickOrTreaters")

local colors = {
    SchemeColor = Color3.fromRGB(50,50,50),
    Background = Color3.fromRGB(30,30,30),
    Header = Color3.fromRGB(40,40,40),
    TextColor = Color3.fromRGB(255, 150, 0),
    ElementColor = Color3.fromRGB(20, 20, 20)
}
local MainWindow = Hub.CreateLib("MH Candy Hub",colors)
local MainTab = MainWindow:NewTab("Auto Farm")
local OtherTab = MainWindow:NewTab("Other Stuff")
local UiTab = MainWindow:NewTab("UI Options")
local AutoMine = false
local AutoCollect = false
local AutoUpgrade  =false
local Player = game.Players.LocalPlayer
local Tycoon = Player.PlayerTycoon.Value
local Popup = Player.PlayerGui.GUI.InputPrompt.InputPrompt
local Ores = game.Workspace.DroppedParts:FindFirstChild(Tycoon.Name)
local Mine

local Upgraders = {
	"Candy Castle",
	"Candy Corn Real Estate",
	"Candy Refiner",
	"Candycorn Refiner",
	"Chocolate Coater",
	"Chocolate Forest",
	"Frank'n'Cupcake",
	"Giant Pretzel",
	"Grand Wafer",
	"Gummy Refiner",
	"Hellish Bat Cookie",
	"Lollipop-inator",
	"Ore Caramelizer",
	"Pumpkin Pie Refiner",
	"Pumpkin Spice Refiner",
	"Sugar Corroder",
	"The Cookinator",
	"The Rock",
}
local Mines  = {"Swintite Mine",
	"Super Swintite Mine",
	"Pumpkinite Mine",
	"Goliath Gumball Machine"
}

local Collectors = {
	["Candy Center"] = 450,
	["Candy Factory"] = 3800,
	["Candy Metropolis"] = 9500
}

function GetItems()
	Mine = Tycoon:FindFirstChild("Swintite Mine") or  Tycoon:FindFirstChild("Pumpkinite Mine") 
	for i,v in pairs(Collectors) do
		if Tycoon:FindFirstChild(i)then 
			Collect = Tycoon:FindFirstChild(i)
			Count = Collect.Model.CounterPart.CandyTracker.Background.Amount
            print("Picked ",Mine, Collect)
		end
	end 
end

function CollectNpc()
    local SavePos =  Player.Character.HumanoidRootPart.CFrame
      for i,v in pairs(NPCs:GetChildren()) do
       if v:FindFirstChild("Internal")  then 
           local Prompt = v.Internal:FindFirstChildWhichIsA("ProximityPrompt")
           if Prompt then 
               Player.Character.HumanoidRootPart.CFrame = v.Internal.CFrame 
               wait(0.3)
               fireproximityprompt(Prompt, 50)
               wait(0.1)
            end
        end
      end
    local Die = game:GetService("Workspace").Map.Fargield.Internal.ProximityPrompt
    Player.Character.HumanoidRootPart.CFrame = Die.Parent.CFrame 
    wait(0.3)
    fireproximityprompt(Die, 50)
    wait(0.1)
    local Box = game:GetService("Workspace").Map.SpookMcDook.Internal.ProximityPrompt
    Player.Character.HumanoidRootPart.CFrame = Box.Parent.CFrame 
    wait(0.3)
    fireproximityprompt(Box, 50)
    wait(0.1)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = SavePos
end

function Boost(Ore)
	Ore.Anchored = true
	for i,v in pairs(Upgraders) do
		local Item = Tycoon:FindFirstChild(v)
		if Item then 
		    if Item:FindFirstChild("Upgrade") then 
			firetouchinterest(Item.Model.Upgrade,Ore,0)
			wait(0.01)
			firetouchinterest(Item.Model.Upgrade,Ore,1) 
		    else
		    for _,Part in pairs(Item.Model:GetDescendants()) do
		        if Part.Name == "Upgrade" then 
		            firetouchinterest(Part,Ore,0)
			        wait(0.01)
			        firetouchinterest(Part,Ore,1)
		        end
		    end
		    end
		end
	end
	if Tycoon:FindFirstChild("Candy Core") then 
		game:GetService("ReplicatedStorage").Pulse:FireServer()
	end
	wait(.5)
	if AutoCollect == true then
	firetouchinterest(Collect.Model.Lava,Ore,0)
	firetouchinterest(Collect.Model.MiniLava,Ore,0)
	else
	Ore.Anchored = false
	end
end

local SectionMainTab = MainTab:NewSection("Auto Candy")

local AutoMineToggle = SectionMainTab:NewToggle("Auto Mine", "Activates a placed remote candy mine", function(state)
  AutoMine = state
  print(AutoMine)
  Mine = Tycoon:FindFirstChild("Swintite Mine") or Tycoon:FindFirstChild("Pumpkinite Mine") 
end)

local AutoCollectToggle = SectionMainTab:NewToggle("Auto Collect", "Collects Candy from a candy center for you", function(state)
  AutoCollect = state
  print(AutoCollect)
  
end)

local AutoUpgradeToggle = SectionMainTab:NewToggle("Auto Upgrade", "Upgardes the candy ores with placed candy upgarders", function(state)
  AutoUpgrade = state
  print(AutoCollect)
end)

local SectionOtherTab = OtherTab:NewSection("Npcs")

if NPCs then 
SectionOtherTab:NewButton("Auto collect Daily", "Collects all the rewards from the daily npcs", function()
  CollectNpc()
end)
else
  SectionOtherTab:NewLabel("Npcs not found(Not avaliable in solo)")
end

local ColorSelection = UiTab:NewSection("Ui Colors")

ColorSelection:NewColorPicker("Scheme Color","", colors.SchemeColor, function(color)
  Hub:ChangeColor("SchemeColor", color)
  
end)

ColorSelection:NewColorPicker("Background Color","", colors.Background, function(color)
   Hub:ChangeColor("Background", color)
end)

ColorSelection:NewColorPicker("Header Color","", colors.Header, function(color)
    pHub:ChangeColor("Header", color)
end)

ColorSelection:NewColorPicker("Text Color","", colors.TextColor, function(color)
    Hub:ChangeColor("TextColor", color)
end)

ColorSelection:NewColorPicker("Element Color","", colors.ElementColor, function(color)
   Hub:ChangeColor("ElementColor", color)
end)

Ores.ChildAdded:Connect(function(Ore)
	if table.find(Mines,Ore.Name) and AutoUpgrade == true then 
		Boost(Ore)
	end
end)
GetItems()
Run.Stepped:Connect(function()
	if AutoMine then 
		if Mine == nil or Mine:FindFirstChild("Model") == nil or Collect == nil or Collect:FindFirstChild("Model") == nil then GetItems() return end 
    	if tonumber(Count.Text)>= Collectors[Collect.Name] and AutoCollect then
        	local Prompt = Collect.Model.Internal.ProximityPrompt
        	fireproximityprompt(Prompt, 10)
        else
        	local Prompt = Mine.Model.Internal.ProximityPrompt
        	local Mag = (Prompt.Parent.Position-Player.Character.HumanoidRootPart.Position).Magnitude
        	if Mag > 20 then 
        	    Player.Character.HumanoidRootPart.CFrame = Prompt.Parent.CFrame + Vector3.new(0,5,0)
            	end
		fireproximityprompt(Prompt, 10)
    	end
    end
end)

game.Players.LocalPlayer.PlayerGui.GUI.InputPrompt.Absorb.Changed:connect(function(property)
	if property == "Visible" then
		if string.match(string.lower(Popup.Title.Text),"would you like to collect") then
			for i,v in pairs(getconnections(game.Players.LocalPlayer.PlayerGui.GUI.InputPrompt.InputPrompt.Yes.MouseButton1Click)) do
				v:Fire()
			end
		end
	end
end)
