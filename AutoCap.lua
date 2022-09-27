-- Gui to Lua
-- Version: 3.2

-- Instances:

local AutoCap = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Go = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local UIPadding = Instance.new("UIPadding")
local Info = Instance.new("TextLabel")
local UICorner_2 = Instance.new("UICorner")

--Properties:

AutoCap.Name = "AutoCap"
AutoCap.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
AutoCap.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Main.Name = "Main"
Main.Parent = AutoCap
Main.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Main.Size = UDim2.new(0, 300, 0, 175)

Go.Name = "Go"
Go.Parent = Main
Go.AnchorPoint = Vector2.new(0.5, 0)
Go.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Go.Position = UDim2.new(0.5, 0, 0.5, 5)
Go.Size = UDim2.new(1, -30, 0.5, -15)
Go.Font = Enum.Font.SourceSans
Go.Text = "Activate AutoCap"
Go.TextColor3 = Color3.fromRGB(255, 255, 255)
Go.TextScaled = true
Go.TextSize = 14.000
Go.TextTransparency = 0.300
Go.TextWrapped = true

UICorner.Parent = Go

UIPadding.Parent = Go
UIPadding.PaddingBottom = UDim.new(0, 4)
UIPadding.PaddingLeft = UDim.new(0, 4)
UIPadding.PaddingRight = UDim.new(0, 4)
UIPadding.PaddingTop = UDim.new(0, 4)

Info.Name = "Info"
Info.Parent = Main
Info.AnchorPoint = Vector2.new(0.5, 0)
Info.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Info.BackgroundTransparency = 1.000
Info.Position = UDim2.new(0.5, 0, 0, 10)
Info.Size = UDim2.new(1, -30, 0.5, -15)
Info.Font = Enum.Font.SourceSans
Info.TextColor3 = Color3.fromRGB(255, 255, 255)
Info.TextScaled = true
Info.Text ="No Active"
Info.TextSize = 14.000
Info.TextTransparency = 0.300
Info.TextWrapped = true

UICorner_2.Parent = Main


local Player = game.Players.LocalPlayer
local Base = Player.PlayerTycoon.Value
local Ores = game.Workspace.DroppedParts:FindFirstChild(Base.Name)
--local top = 0
local selected = nil
local AutoCapEnabled = false
local Looping 
local MoneyLib = require(game.ReplicatedStorage.MoneyLib)

local MoneyLoopables = {
	["Large Ore Upgarder"] ={Cap = 50e+3,Effect = nil,MinVal = nil},
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

local RepeatLoopables = {
	["Portable Ore Advancer" ]={ UseLimit = 30,Effect = nil,Cap = nil},
	[ "Portable Ore Enhancer"]={  UseLimit = 31,Effect = nil,Cap = nil},	
	[ "Portable Ore Stopper"]={  UseLimit = 31,Effect = nil,Cap = nil},	
	[ "Portable Tractor Beam"]={  UseLimit = 16,Effect = nil,Cap = nil},
	[ ""]={  UseLimit = 0,Effect = nil,Cap = nil},
}

function getUpgrader(Ore)
	local Top = 0
	local Item
	local Sts  
	for i,v in pairs(Base:GetChildren()) do
		if MoneyLoopables[v.Name] and Ore:FindFirstChild("Cash") then 
			--print("yes",v.Name)
			if MoneyLoopables[v.Name].MinVal then
				--print("Has Minval")
				--print(MoneyLoopables[v.Name].MinVal)
				--print(v.Name)
				if MoneyLoopables[v.Name].MinVal <= Ore.Cash.Value then
					print("Checked")
					if MoneyLoopables[v.Name].Cap > Top then
					    Top = MoneyLoopables[v.Name].Cap
						Item = v
						--print(MoneyLoopables[v.Name])
						Sts = MoneyLoopables[v.Name]
					end 
				end
			else
				if MoneyLoopables[v.Name].Cap > Top then
				    Top = MoneyLoopables[v.Name].Cap
					Item = v
					--print(MoneyLoopables[v.Name])
					Sts = MoneyLoopables[v.Name]
				end 
			end 
		end
	end
	if Item and Sts then 
		return Item,Sts
	end
end

Go.MouseButton1Click:Connect(function()
	if AutoCapEnabled then
		AutoCapEnabled = false
		Go.Text = "Activate AutoCap"
	else
		AutoCapEnabled = true
		Go.Text = "Deactivate AutoCap"
	end
end)

Ores.ChildAdded:Connect(function(Ore)
	-- print(Ore)
	--print(AutoCapEnabled,Looping)
	if AutoCapEnabled and Looping == nil then
		--print(Looping,AutoCapEnabled)
		Ore.Anchored = true
		Looping = Ore
		--print(Looping)
		wait(0.1)
		local loopItem,ItemStats = getUpgrader(Ore)
		if loopItem then 
			print(ItemStats.Cap)
			print(loopItem)
			Info.Text = "Looping: "..loopItem.Name.." | Cap: "..MoneyLib.HandleMoney(ItemStats.Cap)
			--print("using - " ..loopItem.Name)
			spawn(function()
				repeat
					firetouchinterest(loopItem.Model.Upgrade,Ore,0)
					wait(0.017)
					firetouchinterest(loopItem.Model.Upgrade,Ore,1)
					if ItemStats.Effect then
						local Heal = Base:FindFirstChild("Wild Spore") or Base:FindFirstChild("Deadly Spore")
						if Heal then
							firetouchinterest(Heal.Model.Upgrade,Ore,0)
							wait(0.017)
							firetouchinterest(Heal.Model.Upgrade,Ore,1)
						else

						end
					end
					if ItemStats.MinWait then 
						wait(ItemStats.MinWait-0.02)
					end
				until Ore.Cash.Value >= tonumber(ItemStats.Cap)
				--print("Done 1")
				local loopItem2,ItemStats2 = getUpgrader(Ore)
				if loopItem2 then 
					--print("Next"..loopItem2.Name,Cap2)
					repeat
						firetouchinterest(loopItem2.Model.Upgrade,Ore,0)
						wait(0.017)
						firetouchinterest(loopItem2.Model.Upgrade,Ore,1)
						if ItemStats2.Effect then
							local Heal = Base:FindFirstChild("Wild Spore") or Base:FindFirstChild("Deadly Spore")
							if Heal then
								firetouchinterest(Heal.Model.Upgrade,Ore,0)
								wait(0.017)
								firetouchinterest(Heal.Model.Upgrade,Ore,1)
							else

							end
						end
						if ItemStats2.MinWait then 
							wait(ItemStats2.MinWait-0.02)
						end
					until Ore.Cash.Value >= tonumber(ItemStats2.Cap)
					wait(0.1)
					Ore.Anchored = false
					Looping = nil
					--print("Unk")
				else
					Ore.Anchored = false
					Looping = nil
				end

			end)
		else
			Ore.Anchored = false
			Looping = nil
		end 
	end
end)
