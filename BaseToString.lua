-- (VOID) : Gui to Lua
-- Version: 1.4

-- Instances:

local LayoutThing = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Output = Instance.new("TextBox")
local UICorner_2 = Instance.new("UICorner")
local Cost = Instance.new("TextLabel")
local Convert = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")

--Properties:

LayoutThing.Name = "LayoutThing"
LayoutThing.Parent = (game:GetService("CoreGui") or gethui())
LayoutThing.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Main.Name = "Main"
Main.Parent = LayoutThing
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(30, 34, 42)
Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.Size = UDim2.new(0, 400, 0, 350)

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Main

Output.Name = "Output"
Output.Parent = Main
Output.AnchorPoint = Vector2.new(0.5, 0)
Output.BackgroundColor3 = Color3.fromRGB(50, 57, 64)
Output.BorderColor3 = Color3.fromRGB(0, 0, 0)
Output.BorderSizePixel = 0
Output.Position = UDim2.new(0.5, 0, 0, 10)
Output.Size = UDim2.new(1, -20, 0.600000024, 0)
Output.Font = Enum.Font.SourceSans
Output.Text = ""
Output.TextColor3 = Color3.fromRGB(0, 0, 0)
Output.TextScaled = true
Output.TextSize = 14.000
Output.TextWrapped = true
Output.ClearTextOnFocus = false
Output.TextEditable = false
Output.Interactable = true

UICorner_2.CornerRadius = UDim.new(0, 10)
UICorner_2.Parent = Output

Cost.Name = "Cost"
Cost.Parent = Main
Cost.AnchorPoint = Vector2.new(0.5, 0)
Cost.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Cost.BackgroundTransparency = 10.000
Cost.BorderColor3 = Color3.fromRGB(0, 0, 0)
Cost.BorderSizePixel = 0
Cost.Position = UDim2.new(0.5, 0, 0.620000005, 10)
Cost.Size = UDim2.new(1, -20, 0.133000001, 0)
Cost.Font = Enum.Font.SourceSans
Cost.Text = "Layout will cost $0 to fully load"
Cost.TextColor3 = Color3.fromRGB(204, 204, 204)
Cost.TextScaled = true
Cost.TextSize = 14.000
Cost.TextStrokeColor3 = Color3.fromRGB(204, 204, 204)
Cost.TextWrapped = true

Convert.Name = "Convert"
Convert.Parent = Main
Convert.AnchorPoint = Vector2.new(0.5, 1)
Convert.BackgroundColor3 = Color3.fromRGB(36, 54, 63)
Convert.BorderColor3 = Color3.fromRGB(0, 0, 0)
Convert.BorderSizePixel = 0
Convert.Position = UDim2.new(0.5, 0, 1, -10)
Convert.Size = UDim2.new(0.5, 0, 0.159999996, 0)
Convert.Font = Enum.Font.SourceSansBold
Convert.Text = "Convert base To String"
Convert.TextColor3 = Color3.fromRGB(199, 199, 199)
Convert.TextScaled = true
Convert.TextSize = 14.000
Convert.TextWrapped = true

UICorner_3.CornerRadius = UDim.new(0, 10)
UICorner_3.Parent = Convert

local Suffixes = { "k", "M", "B", "T", "qd", "Qn", "sx", "Sp", "O", "N", "de", "Ud",
	"DD", "tdD", "qdD", "QnD", "sxD", "SpD", "OcD", "NvD", "Vgn", "UVg", "DVg", "TVg",
	"qtV", "QnV", "SeV", "SPG", "OVG", "NVG", "TGN", "UTG", "DTG", "tsTG", "qtTG", 
	"QnTG", "ssTG", "SpTG", "OcTG", "NoTG", "QdDR", "uQDR", "dQDR", "tQDR", "qdQDR", 
	"QnQDR", "sxQDR", "SpQDR", "OQDDr", "NQDDr", "qQGNT", "uQGNT", "dQGNT", "tQGNT", 
	"qdQGNT", "QnQGNT", "sxQGNT", "SpQGNT", "OQQGNT", "NQQGNT", "SXGNTL", "USXGNTL", 
	"DSXGNTL", "TSXGNTL", "QTSXGNTL", "QNSXGNTL", "SXSXGNTL", "SPSXGNTL", "OSXGNTL", 
	"NVSXGNTL", "SPTGNTL", "USPTGNTL", "DSPTGNTL", "TSPTGNTL", "QTSPTGNTL", "QNSPTGNTL",
	"SXSPTGNTL", "SPSPTGNTL", "OSPTGNTL", "NVSPTGNTL", "OTGNTL", "UOTGNTL", "DOTGNTL", 
	"TOTGNTL", "QTOTGNTL", "QNOTGNTL", "SXOTGNTL", "SPOTGNTL", "OTOTGNTL", "NVOTGNTL", 
	"NONGNTL", "UNONGNTL", "DNONGNTL", "TNONGNTL", "QTNONGNTL", "QNNONGNTL", "SXNONGNTL", 
	"SPNONGNTL", "OTNONGNTL", "NONONGNTL", "CENT", "UNCENT","inf"
}

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


local Player = game.Players.LocalPlayer
local Items = game.ReplicatedStorage.Items
local PlayerTycoon = Player.PlayerTycoon.Value
local HTTP = game:GetService("HttpService")


local function ConvertToString()--Converts The players current base to a layout string to be shared
	local Cost = 0
	local FullLayout = {}
	for i,v in pairs(PlayerTycoon:GetChildren()) do 
		if v:FindFirstChild("ItemId") then
			if v.ItemType.Value >0 and v.ItemType.Value <5 and v:FindFirstChild("Cost") then
				Cost += v.Cost.Value 
			end 
			local Tab = {v.Name,tostring(v.Hitbox.CFrame-PlayerTycoon.Base.Position)}
			table.insert(FullLayout,Tab)
		end
	end
	local ShotCost = shorten(Cost)
	local Text = "Layout will cost $"..ShotCost.." to fully load"
	local String = HTTP:JSONEncode(FullLayout).."¬"..ShotCost
	Output.Text = String
end

Convert.MouseButton1Click:Connect(function()
	ConvertToString()
end)
