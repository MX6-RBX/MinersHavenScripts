local Chat = game:GetService("TextChatService")
local channel = Chat:WaitForChild('TextChannels').RBXGeneral
local PList = game.CoreGui.PlayerList.Children.OffsetFrame.PlayerScrollList.SizeOffsetFrame.ScrollingFrameContainer.ScrollingFrameClippingFrame.ScollingFrame.OffsetUndoFrame
local Player = game.Players.LocalPlayer
local PlayerList = PList:FindFirstChild("p_"..tostring(Player.UserId))


local FakeName = ""
local RandomRebriths =false
local SpoofName = false
local LifeVal = 0 


local UILib =require(game.ReplicatedStorage.Old)
local MainUi = UILib.new("InfoSpoofer")
local SpoofPage = MainUi:addPage("Main","130772689610761")
local SpoofSection = SpoofPage:addSection("Spoof Info")
local Options = MainUi:addPage("UI Options","6031280882")
local OptionsSection = Options:addSection("Main")
local UIThemeSection = Options:addSection("UI Colors")
UILib:setTheme("Glow",Color3.fromRGB(240, 234, 81))


local function ToggleNameSpoof()
	if SpoofName then 
		PlayerList.ChildrenFrame.NameFrame.BGFrame.OverlayFrame.PlayerName.PlayerName.Text = FakeName
	else
		PlayerList.ChildrenFrame.NameFrame.BGFrame.OverlayFrame.PlayerName.PlayerName.Text = Player.Name
	end
end


local FakeNameText = SpoofSection:addTextbox("Fake Name",Player.Name,function(text)
	FakeName =text or Player.Name
end)

local SpoofNameToggle = SpoofSection:addToggle("Spoof Name",false,function(Val)
	SpoofName = Val
	ToggleNameSpoof()
end)

local LifeRandomness = SpoofSection:addSlider("Additional Lifes",0,0,5000,function(val)
	LifeVal = val or 0
end)

local SpoofLifeToggle = SpoofSection:addToggle("Spoof Rebirtrhs",false,function(Val)
	SpoofName = Val
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


local function comma(Value)
	local v3, v4, v5 = string.match(tostring(Value), "^([^%d]*%d)(%d*)(.-)$");
	return v3 .. v4:reverse():gsub("(%d%d%d)", "%1,"):reverse() .. v5;
end

function HandleLife(Life)
	local Suffix
	local LastDigit = tonumber(string.sub(tostring(Life),string.len(tostring(Life))))
	local SendLastDigit = tonumber(string.sub(tostring(Life),string.len(tostring(Life-1))))
	if Life <= 20 and Life >= 10 then
		Suffix = "th"
	elseif LastDigit == 1 then
		Suffix = "st"
	elseif LastDigit == 2 and SendLastDigit ~= 1 then
		Suffix = "nd"
	elseif LastDigit == 3 then
		Suffix = "rd"
	else
		Suffix = "th"
	end
	return tostring(comma(Life))..Suffix
end


Chat.OnIncomingMessage = function(Message)
	if Message.Text and not Message.TextSource then
		local Prefix = ""				
		if Player:FindFirstChild("SecondSacrifice") then
			Prefix = "S+"
		elseif Player:FindFirstChild("Sacrificed") then
			Prefix = "s-"
		end		
		if string.find(Message.Text,"was born") and string.find(Message.Text, Player.Name) then
			local CurrentLifeText = tostring(Player.Rebirths.Value+1).."%a%a"
			local NewLife = HandleLife(Player.Rebirths.Value+LifeVal)
			local NewText = Message.Text
			if SpoofName then
				NewText = string.gsub(NewText,Player.Name,FakeName)
			end
			if RandomRebriths then
				NewText = string.gsub(NewText,CurrentLifeText,NewLife)
			end
			Message.Text = NewText
		end
	end
end
