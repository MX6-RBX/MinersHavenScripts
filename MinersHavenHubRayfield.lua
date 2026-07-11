local Player = game.Players.LocalPlayer
local playerGui = Player:WaitForChild("PlayerGui")

local MainUi = Instance.new("ScreenGui")
MainUi.Parent = playerGui
MainUi.Name = "depreky is back"

local Texts = {
	"depreky is back",
	"depreky is the best",
	"MX6 is a noob",
	"Bow for lord depreky",
	"This was made by depreky",
	"The script was trash",
}

wait(5)
local Seed = math.randomseed(1)
local ScreenSize = workspace.CurrentCamera.ViewportSize
for i= 1,1500 do
	local button = Instance.new("TextButton")
	button.Parent = MainUi
	button.Size = UDim2.new(0,150,0,80)
	button.TextScaled = true
	button.Font = Enum.Font.SourceSansBold
	button.TextColor3 = Color3.fromRGB(math.random(1,255),math.random(1,255),math.random(1,255))
	button.Text = Texts[math.random(1,#Texts)]
	button.Position = UDim2.new(0,math.random(0,ScreenSize.X),0,math.random(0,ScreenSize.Y))
	task.wait(0.01)
end	
