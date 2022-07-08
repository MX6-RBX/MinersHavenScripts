--Anything with (!) its highly recommended you leave alone as it could break the script.

local UIS = game:GetService("UserInputService")
local Player = game.Players.LocalPlayer
local GUI = Player.PlayerGui.GUI
local tycoon = Player.PlayerTycoon.Value
local Ores = game.Workspace.DroppedParts:FindFirstChild(tycoon.Name)
local Resetters = {"Tesla Resetter","Tesla Refuter","Black Dwarf","Void Star","The Final Upgrader","The Ultimate Sacrifice","Daestrophe"} --basic resetters. No shinies

local Cash = GUI:FindFirstChild("Money")
local MoneyLib = require(game.ReplicatedStorage.MoneyLib)
local Ore = nil
local Furnace = nil
local BoostOres = false
local AutoRB = false
local LayoutName = "Layout1" --Change to layout of your choice
local SaveOreLimit = tonumber(math.ceil(GUI.Settings.Menu.PrimaryUtil.AdjustOreLimit.Progress.Slider.Slider.Position.X.Scale*250)) --Saves ore limit 

function Boost(Ore)--(!)   script that boosts the ore
    for i,v in pairs(tycoon:GetChildren())do
        if v:FindFirstChild("ItemId") and not table.find(Resetters,v.Name) then 
            if v.Model:FindFirstChild("Upgrade")  then 
                spawn(function()
                firetouchinterest(v.Model.Upgrade, Ore, 0) --0 is touch
                Wait(0)
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
    firetouchinterest(Upgrade, Ore, 1)
end

Ores.ChildAdded:Connect(function(Child)--(!)  detects when a ore is added to the game and then upgrades it if Boost is on
    if BoostOres == true then
    Child.Anchored = true
    Boost(Child)
    Wait(0.1)
    local tesla = tycoon:FindFirstChild("Tesla Refuter") or tycoon:FindFirstChild("Tesla Resetter")
    if tesla then
        Reset(Child,tesla.Model.Upgrade)
        Wait(0.1)
        Boost(Child)
        wait(0.1)
        local Stars = tycoon:FindFirstChild("Void Star") or tycoon:FindFirstChild("Black Dwarf")
        if Stars then 
            Reset(Child,Stars.Model.Upgrade)
            wait(0.1)
            Boost(Child)
            Wait(0.1)
            local SacRes = tycoon:FindFirstChild("The Final Upgrader") or tycoon:FindFirstChild("The Ultimate Sacrifice")
            if SacRes then 
                Reset(Child,SacRes.Model.Upgrade)
                Wait(0.1)
                Boost(Child)
                Wait(0.1)
                local Dae = tycoon:FindFirstChild("Daestrophe")
                if Dae then
                    sup(Child,Dae.Model.Upgrade)
                    Wait(0.1)
                    Boost(Child)
                    Wait(0.1)
                end
            end
        end
    end
    if Furnace then
        Child.CFrame = Furnace.CFrame + Vector3.new(0,1,0)
        Child.Anchored = false
        else
        print("No furnace")
    end
    end
end)

UIS.InputBegan:Connect(function(Input)--(!)  input for the toggles
    if Input.KeyCode == Enum.KeyCode.K then --enables ore boosting(key can be changed just replace K with key of your choice must be uppercase)
        if BoostOres == true then
            BoostOres = false
            game:GetService("ReplicatedStorage").Pulse:FireServer()
            wait(0.1)
            game:GetService("ReplicatedStorage").UpdateLimit:FireServer("OreLimit", SaveOreLimit)
        else
            game:GetService("ReplicatedStorage").Pulse:FireServer()
            wait(0.1)
            game:GetService("ReplicatedStorage").UpdateLimit:FireServer("OreLimit", 0)
            BoostOres = true
        end
    elseif Input.KeyCode == Enum.KeyCode.B then --Enables auto rebirth(key can be changed just replace B with key of your choice must be uppercase)
        AutoRB = not AutoRB
    end
end)
Cash.Changed:Connect(function()--(!)  detects change to money and then if there is enough to rebirth it will the load your chosen layout.
    local RBP = MoneyLib.RebornPrice(Player) --Players rebirth price
    if AutoRB == true and Cash.Value > RBP then 
        BoostOres = false
        game.ReplicatedStorage.Rebirth:InvokeServer()
        GUI.FocusWindow.Value = GUI.Layouts
        game.ReplicatedStorage.Layouts:InvokeServer("Load",LayoutName)
        wait(0.1)
        BoostOres = true
	  end
end)
