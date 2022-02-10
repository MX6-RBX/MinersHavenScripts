local Player = game.Players.LocalPlayer
local Popup = Player.PlayerGui.GUI.InputPrompt
Player.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.DataResetModel.Model.LowerTorso.CFrame + Vector3.new(0,5,0)
local Slot = Player.DataSlot
wait(0.3)
Player:Kick("Save slot "..Slot.Value.." was wiped successfully")
