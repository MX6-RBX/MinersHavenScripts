local Player = game.Players.LocalPlayer
local Character = Player.Character
local Zombies = game.Workspace.SpawnedZombies
local CF = CFrame.new(-161, 115,52,-0.83,1.93,0.55,1.75,1,-8.57,-0.55,2.51,-0.83)
local Sword = Character:FindFirstChild("LinkedSword") or Player.Backpack:FindFirstChild("LinkedSword")
Character.HumanoidRootPart.CFrame = CF

repeat
	wait(.5)
until #Zombies:GetChildren() >0
wait(1.5)
for a=1,12 do
	for i,v in pairs(Zombies:GetChildren()) do
		spawn(function()
			v.HumanoidRootPart.Anchored = true
			v.Head.Anchored = true
			wait(.3)
			v.Head.Position= Sword.Handle.Position
		end)
	end
	if Character:FindFirstChild("LinkedSword") == nil then
		Character.Humanoid:EquipTool(Sword)
	end
	while #Zombies:GetChildren() >0 and Character:FindFirstChild("LinkedSword") do
		wait(0.5)
		Sword:Activate() 
	end 
	repeat
		wait(1)
	until #Zombies:GetChildren() >0
	wait(1.5)
end

