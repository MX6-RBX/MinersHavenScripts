local UIS = game:GetService("UserInputService")
local Player = game.Players.LocalPlayer
local GUI = Player.PlayerGui.GUI
local tycoon = Player.PlayerTycoon.Value
local NotiType =  game.Players.LocalPlayer:WaitForChild("PlayerSettings"):WaitForChild("ToggleNINS") 
local Main = GUI.Menu
local Menu = require(Main.Menu)
local Sounds = GUI.Menu.Menu.Sounds
local NotiPrompt = require(GUI.NoticePrompt.InputPrompt.NoticePrompt)
local InputPrompt = require(GUI.InputPrompt.InputPrompt.InputPrompt)
local Ores = game.Workspace.DroppedParts:FindFirstChild(tycoon.Name)
local Resetters = {"Tesla Resetter","Tesla Refuter","Black Dwarf","Void Star","The Final Upgrader","The Ultimate Sacrifice","Daestrophe"}
local Item = tycoon:FindFirstChild("Plasma Iron Polisher")
local Cash = GUI:FindFirstChild("Money")
local MoneyLib = require(game.ReplicatedStorage.MoneyLib)
local Ore = nil
local Furnace = nil
local BoostOres = false
local AutoRB = false
local DisableManual = false
_G.Layout = "Layout1"--Chosen layout
--local SaveOreLimit = tonumber(math.ceil(GUI.Settings.Menu.PrimaryUtil.AdjustOreLimit.Progress.Slider.Slider.Position.X.Scale*250))
local Tween = require(game:GetService("ReplicatedFirst").Tween);


function Notify(Message,TextColor,BackgroundColor,Image)
	Count = Count or 1
	Message = Message or "Message"
	TextColor = TextColor or Color3.fromRGB(255, 255, 255)
	BackgroundColor = BackgroundColor or Color3.fromRGB(0, 0, 0)
	Image = Image or "rbxassetid://2961493545"
	local Template = GUI.Notifications.MessageTemplate:Clone()
	local UICorner = Instance.new("UICorner")
	UICorner.Parent = Template.Exclaim
	Template.Label.Text = Message
	Template.Label.TextColor3 = TextColor
	Template.BackgroundTransparency = 0
	Template.Exclaim.ImageTransparency = 0
	Template.Label.TextTransparency = 0
	Template.Visible = true
	Template.BackgroundColor3 = BackgroundColor
	Template.Exclaim.Image = Image
	Template.Size = UDim2.new(0.5,0,0,40)
	Template.Parent = GUI.Notifications

	--TweenItem(Template, 0)
	wait(10)
	--TweenItem(Template, 1)
	Template:Destroy()
end
function Boost(Ore)--(!)   script that boosts the ore
	for i,v in pairs(tycoon:GetChildren())do
		if v:FindFirstChild("ItemId") and not table.find(Resetters,v.Name) then 
			if v.Model:FindFirstChild("Upgrade")  then 
				spawn(function()
					firetouchinterest(v.Model.Upgrade, Ore, 0) --0 is touch
					wait(0.02)
					firetouchinterest(v.Model.Upgrade, Ore, 1)
				end)
			elseif v.Model:FindFirstChild("Lava") then 
				Furnace = v.Model.Lava
			elseif v.Model:FindFirstChild("MiniLava") then
				Furnace = v.Model.MiniLava
			end
		end

	end
end

function Reset(Ore,Upgrade)--(!)   Resets the ore tags
	firetouchinterest(Upgrade, Ore, 0) --0 is touch
	wait(0.02)
	firetouchinterest(Upgrade, Ore, 1)
end

Ores.ChildAdded:Connect(function(Child)--(!)  detects when a ore is added to the game and then upgrades it if Boost is on
	if BoostOres == true then
		Child.Anchored = true
		Boost(Child)
		wait(0.2)
		local tesla = tycoon:FindFirstChild("Tesla Refuter") or tycoon:FindFirstChild("Tesla Resetter")
		local SacRes = tycoon:FindFirstChild("The Final Upgrader") or tycoon:FindFirstChild("The Ultimate Sacrifice")
		local Stars = tycoon:FindFirstChild("Void Star") or tycoon:FindFirstChild("Black Dwarf")
		local Dae = tycoon:FindFirstChild("Daestrophe")
		if tesla then
			Reset(Child,tesla.Model.Upgrade)
			--wait(0.01)
			Boost(Child)
			wait(0.2)
		end

		if Dae then
			Reset(Child,Dae.Model.Upgrade)
		--	wait(0.01)
			Boost(Child)
			wait(0.2)
		end

		if SacRes then 
			Reset(Child,SacRes.Model.Upgrade)
		--	wait(0.01)
			Boost(Child)
			wait(0.2)
		end

		if Stars then 
			Reset(Child,Stars.Model.Upgrade)
		--	wait(0.01)
			Boost(Child)
			wait(0.2)
		end

		if Furnace then
			Child.CFrame = Furnace.CFrame + Vector3.new(0,1,0)
			Child.Anchored = false
		else
			print("No furnace")
		end
	end
end)

UIS.InputBegan:Connect(function(Input)
	if Input.KeyCode == Enum.KeyCode.G then 
		if BoostOres then 
			BoostOres = false
			DisableManual = true
			Notify("Ore Boosting: Off",Color3.fromRGB(255,255,255),Color3.fromRGB(30,30,30),"http://www.roblox.com/asset/?id=7265270534")
		else
			DisableManual = false
			BoostOres = true
			Notify("Ore Boosting: On",Color3.fromRGB(255,255,255),Color3.fromRGB(30,30,30),"http://www.roblox.com/asset/?id=7265270534")
		end
	elseif Input.KeyCode == Enum.KeyCode.H then 
		--AutoRB = not AutoRB
		if AutoRB then  
			AutoRB = false
			Notify("Auto rebirth: Off",Color3.fromRGB(255,255,255),Color3.fromRGB(30,30,30),"http://www.roblox.com/asset/?id=7265270534")
		else
			AutoRB = true
			Notify("Auto rebirth: On",Color3.fromRGB(255,255,255),Color3.fromRGB(30,30,30),"http://www.roblox.com/asset/?id=7265270534")
		end

	end
end)
Cash.Changed:Connect(function()--(!)  detects change to money and then if there is enough to rebirth it will the load your chosen layout.
	local RBP = MoneyLib.RebornPrice(Player) --Players rebirth price
	if AutoRB == true and Cash.Value > RBP then 
		BoostOres = false
		game.ReplicatedStorage.Rebirth:InvokeServer()
		GUI.FocusWindow.Value = GUI.Layouts
		game.ReplicatedStorage.Layouts:InvokeServer("Load",_G.Layout)
		wait(0.1)
		if DisableManual == false
			BoostOres = true
		end
	end
end)
