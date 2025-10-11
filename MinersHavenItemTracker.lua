local UIS = game:GetService("UserInputService")
-- (VOID) : Gui to Lua
-- Version: 1.4

-- Instances:

local ItemTracker = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local ItemsFrame = Instance.new("Frame")
local Items = Instance.new("ScrollingFrame")
local ItemTemplate = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local ImageLabel = Instance.new("ImageLabel")
local UICorner_2 = Instance.new("UICorner")
local ItemName = Instance.new("TextLabel")
local UIPadding = Instance.new("UIPadding")
local ItemAmount = Instance.new("TextLabel")
local UIPadding_2 = Instance.new("UIPadding")
local LastObtained = Instance.new("TextLabel")
local UIPadding_3 = Instance.new("UIPadding")
local UIGridLayout = Instance.new("UIGridLayout")
local UIPadding_4 = Instance.new("UIPadding")
local UICorner_3 = Instance.new("UICorner")
local UICorner_4 = Instance.new("UICorner")
local Info = Instance.new("Frame")
local Start = Instance.new("TextLabel")
local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
local Current = Instance.new("TextLabel")
local UITextSizeConstraint_2 = Instance.new("UITextSizeConstraint")
local LastItem = Instance.new("TextLabel")
local UITextSizeConstraint_3 = Instance.new("UITextSizeConstraint")
local ElapseTime = Instance.new("TextLabel")
local UITextSizeConstraint_4 = Instance.new("UITextSizeConstraint")
local LivesAdvancedText = Instance.new("TextLabel")
local UITextSizeConstraint_5 = Instance.new("UITextSizeConstraint")
local UIListLayout = Instance.new("UIListLayout")
local UIPadding_5 = Instance.new("UIPadding")
local ItemCount = Instance.new("TextLabel")
local UITextSizeConstraint_6 = Instance.new("UITextSizeConstraint")
local Current_2 = Instance.new("TextLabel")
local UITextSizeConstraint_7 = Instance.new("UITextSizeConstraint")
local TierSelect = Instance.new("Frame")
local UICorner_5 = Instance.new("UICorner")
local List = Instance.new("ScrollingFrame")
local UIGridLayout_2 = Instance.new("UIGridLayout")
local UIPadding_6 = Instance.new("UIPadding")
local TierTemplate = Instance.new("TextButton")
local UICorner_6 = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")

--Properties:

ItemTracker.Name = "ItemTracker"
ItemTracker.Parent = game.CoreGui
ItemTracker.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Main.Name = "Main"
Main.Parent = ItemTracker
Main.Active = true
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Main.Draggable = true			
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.Selectable = true
Main.Size = UDim2.new(0.25, 0, 0.330000013, 0)

ItemsFrame.Name = "ItemsFrame"
ItemsFrame.Parent = Main
ItemsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ItemsFrame.Position = UDim2.new(0, 10, 0, 10)
ItemsFrame.Size = UDim2.new(0.5, -10, 1, -50)

Items.Name = "Items"
Items.Parent = ItemsFrame
Items.Active = true
Items.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Items.BackgroundTransparency = 1.000
Items.BorderSizePixel = 0
Items.Size = UDim2.new(1, 0, 1, 0)
Items.CanvasSize = UDim2.new(0, 0, 0, 0)
Items.AutomaticCanvasSize = Enum.AutomaticSize.Y

ItemTemplate.Name = "ItemTemplate"
ItemTemplate.Parent = Items
ItemTemplate.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
ItemTemplate.Size = UDim2.new(0, 100, 0, 100)
ItemTemplate.Visible = false
ItemTemplate.Text = ""
ItemTemplate.TextTransparency = 1.000

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = ItemTemplate

ImageLabel.Parent = ItemTemplate
ImageLabel.AnchorPoint = Vector2.new(0, 0.5)
ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel.Position = UDim2.new(0, 0, 0.5, 0)
ImageLabel.Size = UDim2.new(0, 50, 0, 50)
ImageLabel.Image = "rbxassetid://402169085"

UICorner_2.CornerRadius = UDim.new(0, 10)
UICorner_2.Parent = ImageLabel

ItemName.Name = "ItemName"
ItemName.Parent = ItemTemplate
ItemName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ItemName.BackgroundTransparency = 1.000
ItemName.Position = UDim2.new(0, 60, 0, 0)
ItemName.Size = UDim2.new(0.800000012, -60, 0.5, 0)
ItemName.Font = Enum.Font.ArialBold
ItemName.Text = "Clockwork"
ItemName.TextColor3 = Color3.fromRGB(255, 255, 255)
ItemName.TextScaled = true
ItemName.TextSize = 14.000
ItemName.TextStrokeTransparency = 0.000
ItemName.TextWrapped = true
ItemName.TextXAlignment = Enum.TextXAlignment.Left

UIPadding.Parent = ItemName
UIPadding.PaddingRight = UDim.new(0, 5)

ItemAmount.Name = "ItemAmount"
ItemAmount.Parent = ItemTemplate
ItemAmount.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ItemAmount.BackgroundTransparency = 1.000
ItemAmount.Position = UDim2.new(0.800000012, 0, 0, 0)
ItemAmount.Size = UDim2.new(0.200000003, 0, 0.5, 0)
ItemAmount.Font = Enum.Font.ArialBold
ItemAmount.Text = "x6"
ItemAmount.TextColor3 = Color3.fromRGB(255, 255, 255)
ItemAmount.TextScaled = true
ItemAmount.TextSize = 14.000
ItemAmount.TextStrokeTransparency = 0.000
ItemAmount.TextWrapped = true
ItemAmount.TextXAlignment = Enum.TextXAlignment.Right

UIPadding_2.Parent = ItemAmount
UIPadding_2.PaddingRight = UDim.new(0, 5)

LastObtained.Name = "LastObtained"
LastObtained.Parent = ItemTemplate
LastObtained.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LastObtained.BackgroundTransparency = 1.000
LastObtained.Position = UDim2.new(0, 60, 0.5, 0)
LastObtained.Size = UDim2.new(1, -60, 0.5, 0)
LastObtained.Font = Enum.Font.ArialBold
LastObtained.Text = "Last Obtained - S+5678"
LastObtained.TextColor3 = Color3.fromRGB(255, 255, 255)
LastObtained.TextScaled = true
LastObtained.TextSize = 14.000
LastObtained.TextStrokeTransparency = 0.000
LastObtained.TextWrapped = true
LastObtained.TextXAlignment = Enum.TextXAlignment.Left

UIPadding_3.Parent = LastObtained
UIPadding_3.PaddingRight = UDim.new(0, 5)

UIGridLayout.Parent = Items
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 10)
UIGridLayout.CellSize = UDim2.new(1, 0, 0, 50)

UIPadding_4.Parent = Items
UIPadding_4.PaddingBottom = UDim.new(0, 10)
UIPadding_4.PaddingLeft = UDim.new(0, 10)
UIPadding_4.PaddingRight = UDim.new(0, 12)
UIPadding_4.PaddingTop = UDim.new(0, 10)

UICorner_3.CornerRadius = UDim.new(0, 10)
UICorner_3.Parent = ItemsFrame

UICorner_4.CornerRadius = UDim.new(0, 10)
UICorner_4.Parent = Main

Info.Name = "Info"
Info.Parent = Main
Info.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Info.BackgroundTransparency = 1.000
Info.Position = UDim2.new(0.5, 0, 0, 0)
Info.Size = UDim2.new(0.5, 0, 1, 0)

Start.Name = "Start"
Start.Parent = Info
Start.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Start.BackgroundTransparency = 1.000
Start.LayoutOrder = 1
Start.Position = UDim2.new(0, 0, 0.0500000007, 0)
Start.Size = UDim2.new(1, 0, 0.100000001, 0)
Start.Font = Enum.Font.ArialBold
Start.Text = "Start Life - 53789"
Start.TextColor3 = Color3.fromRGB(255, 255, 255)
Start.TextScaled = true
Start.TextSize = 14.000
Start.TextWrapped = true

UITextSizeConstraint.Parent = Start
UITextSizeConstraint.MaxTextSize = 30

Current.Name = "Current"
Current.Parent = Info
Current.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Current.BackgroundTransparency = 1.000
Current.LayoutOrder = 2
Current.Position = UDim2.new(0, 0, 0.200000003, 0)
Current.Size = UDim2.new(1, 0, 0.100000001, 0)
Current.Font = Enum.Font.ArialBold
Current.Text = "Current Life - 53789"
Current.TextColor3 = Color3.fromRGB(255, 255, 255)
Current.TextScaled = true
Current.TextSize = 14.000
Current.TextWrapped = true

UITextSizeConstraint_2.Parent = Current
UITextSizeConstraint_2.MaxTextSize = 30

LastItem.Name = "LastItem"
LastItem.Parent = Info
LastItem.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LastItem.BackgroundTransparency = 1.000
LastItem.LayoutOrder = 4
LastItem.Position = UDim2.new(0, 0, 0.349999994, 0)
LastItem.Size = UDim2.new(1, 0, 0.100000001, 0)
LastItem.Font = Enum.Font.ArialBold
LastItem.Text = "Last  Item - ClockWork"
LastItem.TextColor3 = Color3.fromRGB(255, 255, 255)
LastItem.TextScaled = true
LastItem.TextSize = 14.000
LastItem.TextWrapped = true

UITextSizeConstraint_3.Parent = LastItem
UITextSizeConstraint_3.MaxTextSize = 30

ElapseTime.Name = "ElapseTime"
ElapseTime.Parent = Info
ElapseTime.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ElapseTime.BackgroundTransparency = 1.000
ElapseTime.LayoutOrder = 6
ElapseTime.Position = UDim2.new(0, 0, 0.649999976, 0)
ElapseTime.Size = UDim2.new(1, 0, 0.100000001, 0)
ElapseTime.Font = Enum.Font.ArialBold
ElapseTime.Text = "Elapse Time - 00:00:00"
ElapseTime.TextColor3 = Color3.fromRGB(255, 255, 255)
ElapseTime.TextScaled = true
ElapseTime.TextSize = 14.000
ElapseTime.TextWrapped = true

UITextSizeConstraint_4.Parent = ElapseTime
UITextSizeConstraint_4.MaxTextSize = 30

LivesAdvancedText.Name = "LivesAdvanced"
LivesAdvancedText.Parent = Info
LivesAdvancedText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LivesAdvancedText.BackgroundTransparency = 1.000
LivesAdvancedText.LayoutOrder = 3
LivesAdvancedText.Position = UDim2.new(0, 0, 0.5, 0)
LivesAdvancedText.Size = UDim2.new(1, 0, 0.100000001, 0)
LivesAdvancedText.Font = Enum.Font.ArialBold
LivesAdvancedText.Text = "Lifes Advanced - 10000"
LivesAdvancedText.TextColor3 = Color3.fromRGB(255, 255, 255)
LivesAdvancedText.TextScaled = true
LivesAdvancedText.TextSize = 14.000
LivesAdvancedText.TextWrapped = true

UITextSizeConstraint_5.Parent = LivesAdvancedText
UITextSizeConstraint_5.MaxTextSize = 30

UIListLayout.Parent = Info
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)

UIPadding_5.Parent = Info
UIPadding_5.PaddingTop = UDim.new(0, 20)

ItemCount.Name = "ItemCount"
ItemCount.Parent = Info
ItemCount.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ItemCount.BackgroundTransparency = 1.000
ItemCount.LayoutOrder = 4
ItemCount.Position = UDim2.new(0, 0, 0.349999994, 0)
ItemCount.Size = UDim2.new(1, 0, 0.100000001, 0)
ItemCount.Font = Enum.Font.ArialBold
ItemCount.Text = "Total Item Obtained - 0"
ItemCount.TextColor3 = Color3.fromRGB(255, 255, 255)
ItemCount.TextScaled = true
ItemCount.TextSize = 14.000
ItemCount.TextWrapped = true

UITextSizeConstraint_6.Parent = ItemCount
UITextSizeConstraint_6.MaxTextSize = 30

Current_2.Name = "Current"
Current_2.Parent = Main
Current_2.AnchorPoint = Vector2.new(0, 1)
Current_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Current_2.BackgroundTransparency = 1.000
Current_2.LayoutOrder = 2
Current_2.Position = UDim2.new(0, 0, 1, -10)
Current_2.Size = UDim2.new(0.5, -10, 0, 20)
Current_2.Font = Enum.Font.ArialBold
Current_2.Text = "Click an Item to remove from List"
Current_2.TextColor3 = Color3.fromRGB(255, 255, 255)
Current_2.TextScaled = true
Current_2.TextSize = 14.000
Current_2.TextTransparency = 0.300
Current_2.TextWrapped = true

UITextSizeConstraint_7.Parent = Current_2
UITextSizeConstraint_7.MaxTextSize = 30

TierSelect.Name = "TierSelect"
TierSelect.Parent = Main
TierSelect.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TierSelect.Position = UDim2.new(1, 10, 0, 0)
TierSelect.Size = UDim2.new(0.300000012, 0, 0.5, 70)

UICorner_5.CornerRadius = UDim.new(0, 10)
UICorner_5.Parent = TierSelect

List.Name = "List"
List.Parent = TierSelect
List.Active = true
List.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
List.BackgroundTransparency = 2.000
List.BorderColor3 = Color3.fromRGB(0, 0, 0)
List.BorderSizePixel = 0
List.Size = UDim2.new(1, 0, 1, 0)
List.ScrollBarThickness = 6
List.AutomaticCanvasSize = Enum.AutomaticSize.Y

UIGridLayout_2.Parent = List
UIGridLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout_2.CellPadding = UDim2.new(0, 5, 0, 10)
UIGridLayout_2.CellSize = UDim2.new(1, 0, 0, 50)

UIPadding_6.Parent = List
UIPadding_6.PaddingBottom = UDim.new(0, 10)
UIPadding_6.PaddingLeft = UDim.new(0, 10)
UIPadding_6.PaddingRight = UDim.new(0, 13)
UIPadding_6.PaddingTop = UDim.new(0, 20)

TierTemplate.Name = "TierTemplate"
TierTemplate.Parent = List
TierTemplate.AnchorPoint = Vector2.new(0, 0.5)
TierTemplate.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TierTemplate.Position = UDim2.new(0.725000024, 10, 0.5, 0)
TierTemplate.Size = UDim2.new(0.224999994, 0, 0, 40)
TierTemplate.Visible = false
TierTemplate.Font = Enum.Font.SourceSansBold
TierTemplate.Text = "Reborn"
TierTemplate.TextColor3 = Color3.fromRGB(62, 178, 255)
TierTemplate.TextScaled = true
TierTemplate.TextSize = 14.000
TierTemplate.TextWrapped = true

UICorner_6.CornerRadius = UDim.new(0, 10)
UICorner_6.Parent = TierTemplate

UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Color = Color3.fromRGB(97, 162, 93)
UIStroke.Thickness = 3.000
UIStroke.Parent = TierTemplate
local ButtonCount = Instance.new("IntValue")
ButtonCount.Name ="Count"
ButtonCount.Value = 0
ButtonCount.Parent = Items
local RealAmount = Instance.new("IntValue")
RealAmount.Value = 0
RealAmount.Name = "Amount"
RealAmount.Parent = ItemTemplate

local TierValue = Instance.new("IntValue")
TierValue.Value = 0
TierValue.Name = "TierValue"
TierValue.Parent = TierTemplate

local Player = game.Players.LocalPlayer
local Tiers = game.ReplicatedStorage:FindFirstChild("Tiers")
function GetSuffix()--puts the sac tag next to the life in the gui
	if Player:FindFirstChild("SecondSacrifice") then
		return "S+"
	elseif Player:FindFirstChild("Sacrificed") then
		return "s-"
	else
		return ""
	end
end



local GUI = Player.PlayerGui:WaitForChild("GUI")
local Life = Player.Rebirths
local StartLife = Life.Value + 1

local SelectedTiers = {30,33,36,38}--Filtered Item Tracking defualt Reborns, Advanced Reborns, Shinies, Limited Shinies
local LastLife = Player.Rebirths.Value
local OverAllTime = 0
local LivesAdvanced = 0
local LogShinysOnly = false
local LogAll = false
local TotalItems = 0

local function ToggleTier(Ui)
	local Tier = Ui.TierValue.Value
	if table.find(SelectedTiers,Tier) then
		print("Removed ",Tier)
		local pos = table.find(SelectedTiers,Tier)
		
		table.remove(SelectedTiers,pos)
		Ui.UIStroke.Enabled = false
	else
		print("Added ",Tier)
		table.insert(SelectedTiers,Tier)
		Ui.UIStroke.Enabled = true
	end
	print(SelectedTiers)
end


for i,v in Tiers:GetChildren() do
	local Tier = tonumber(v.Name)
	local Ui = TierTemplate:Clone()
	Ui.Name = v.TierName.Value
	Ui.Text = Ui.Name
	Ui.TextColor3 = v.TierColor.Value
	Ui.TextStrokeTransparency = 0
	Ui.TextStrokeColor3 = Color3.fromRGB(200,200,200)
	Ui.UIStroke.Enabled = table.find(SelectedTiers,tonumber(v.Name))
	Ui.Parent = List
	Ui.Visible = true
	Ui.LayoutOrder = Tier
	Ui.TierValue.Value = Tier
	Ui.MouseButton1Click:Connect(function()
		ToggleTier(Ui)
	end)
end


Items.ScrollBarThickness = 6
Start.Text = "Start Life - "..GetSuffix()..StartLife
Current.Text = "Current Life - "..GetSuffix()..StartLife
LivesAdvancedText.Text = "Lifes Advanced - 0"
LastItem.Text = "Last Item - NAN"

function HandleTime(t)--converts the time in seconds into the HH:MM:SS format

	local seconds = t % 60
	local minutes = math.floor(t / 60) % 60
	local hours = math.floor(t / 3600) % 24

	if seconds <10 then seconds = "0"..seconds end
	if minutes <10 then minutes = "0"..minutes end
	if hours <10 then hours = "0"..hours end

	return hours..":"..minutes..":"..seconds
end

function GetTierColor(Tier)--Gets the items tier color
	local RealTier = game.ReplicatedStorage.Tiers:FindFirstChild(tostring(Tier)) 
	if RealTier then
		return RealTier.TierColor.Value
	end
end

UIS.InputBegan:Connect(function(Input)--toggle key function for the gui
	if UIS:GetFocusedTextBox() == nil then
		if Input.KeyCode == Enum.KeyCode.T then --toggle key its self ( T By defult)
			Main.Visible = not Main.Visible
		elseif Input.KeyCode == Enum.KeyCode.Y then
			TierSelect.Visible = not TierSelect.Visible
		end
	end
end)

local function AddNewButton(Item,Amount)
	if Items:FindFirstChild(Item.Name) == nil then
		local Clone = ItemTemplate:Clone()
		Clone.Name = Item.Name
		Clone.BackgroundColor3 = GetTierColor(Item.Tier.Value)
		Clone.ImageLabel.Image = "rbxassetid://"..Item.ThumbnailId.Value
		Clone.ItemName.Text = Item.Name
		Clone.Amount.Value = Amount
		Clone.ItemAmount.Text = "X"..Clone.Amount.Value
		Clone.LastObtained.Text = "Last Obtained - "..GetSuffix()..Life.Value+1
		Clone.Parent = Items
		local TierId = Item.Tier.Value
		local Tier =  game.ReplicatedStorage.Tiers:FindFirstChild(tostring(TierId))
		
		if TierId == 36 or TierId == 38 then
			local UiS = UIStroke:Clone()
			UiS.Parent = Clone
			UiS.Color = Tier.TierColor.Value		
		end  
		ButtonCount.Value  +=1
		if Item:FindFirstChild("RebornChance") and Item.RebornChance.Value <1 then
			local Stroke = Instance.new("UIStroke")
			Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			Stroke.Color = Color3.fromRGB(255, 0, 255)
			Stroke.Parent = game.workspace
			Stroke.Thickness = 3
		end
		Clone.Visible = true
		Clone.MouseButton1Click:Connect(function()
			ButtonCount.Value -= 1
			Clone:Destroy()
		end)
	else
		local ItemFrame = Items:FindFirstChild(Item.Name)
		ItemFrame.Amount.Value = ItemFrame.Amount.Value +Amount
		ItemFrame.ItemAmount.Text = "X"..ItemFrame.Amount.Value
		ItemFrame.LayoutOrder = ItemFrame.LayoutOrder -  ItemFrame.Amount.Value
		ItemFrame.LastObtained.Text = "Last Obtained - "..GetSuffix()..Life.Value+1
	end
	LastItem.Text = "Last Item - "..Item.Name
	TotalItems +=1 
	ItemCount.Text = "Total Items Obtained - "..TotalItems
end

game.ReplicatedStorage.ItemObtained.OnClientEvent:Connect(function(Item,Amount)
	if table.find(SelectedTiers,Item.Tier.Value) then
		AddNewButton(Item,Amount)
	end
	local LifeChange = Life.Value - LastLife
	if LifeChange > 0 then
		LivesAdvanced = LivesAdvanced + LifeChange
		LastLife = Life.Value
	end
	LivesAdvancedText.Text = "Lifes Advanced - " ..tostring(LivesAdvanced)
	Current.Text = "Current Life - "..GetSuffix()..Life.Value+1
end)


while wait(1) do--Elaspe time loop
	OverAllTime = OverAllTime +1
	ElapseTime.Text = "Elapse Time - ".. HandleTime(OverAllTime)
end
