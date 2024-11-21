local TweenService = game:service"TweenService"
local plr = game.Players.LocalPlayer
local uis = game:GetService("UserInputService")
local Mouse = plr:GetMouse()
local ParentGui = game.Players.LocalPlayer.PlayerGui -- or ParentGui
local Library = {}

local function makedraggable(topbarobject, object)
	local function CustomPos(topbarobject, object)
		local Dragging = nil
		local DragInput = nil
		local DragStart = nil
		local StartPosition = nil

		local function UpdatePos(input)
			local Delta = input.Position - DragStart
			local newPos = UDim2.new(
				StartPosition.X.Scale,
				StartPosition.X.Offset + Delta.X,
				StartPosition.Y.Scale,
				StartPosition.Y.Offset + Delta.Y
			)
			object.Position = newPos
		end

		topbarobject.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				DragStart = input.Position
				StartPosition = object.Position

				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						Dragging = false
					end
				end)
			end
		end)

		topbarobject.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				DragInput = input
			end
		end)

		uis.InputChanged:Connect(function(input)
			if input == DragInput and Dragging then
				UpdatePos(input)
			end
		end)
	end
	local function CustomSize(object)
		local Dragging = false
		local DragInput = nil
		local DragStart = nil
		local StartSize = nil
		local maxSizeX = object.Size.X.Offset
		local maxSizeY = object.Size.Y.Offset
		object.Size = UDim2.new(0, maxSizeX, 0, maxSizeY)
		local changesizeobject = Instance.new("Frame");

		changesizeobject.AnchorPoint = Vector2.new(1, 1)
		changesizeobject.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		changesizeobject.BackgroundTransparency = 0.9990000128746033
		changesizeobject.BorderColor3 = Color3.fromRGB(0, 0, 0)
		changesizeobject.BorderSizePixel = 0
		changesizeobject.Position = UDim2.new(1, 20, 1, 20)
		changesizeobject.Size = UDim2.new(0, 40, 0, 40)
		changesizeobject.Name = "changesizeobject"
		changesizeobject.Parent = object

		local function UpdateSize(input)
			local Delta = input.Position - DragStart
			local newWidth = StartSize.X.Offset + Delta.X
			local newHeight = StartSize.Y.Offset + Delta.Y
			newWidth = math.max(newWidth, maxSizeX)
			newHeight = math.max(newHeight, maxSizeY)
			local Tween = TweenService:Create(object, TweenInfo.new(0.2), {Size = UDim2.new(0, newWidth, 0, newHeight)})
			Tween:Play()
		end

		changesizeobject.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				DragStart = input.Position
				StartSize = object.Size
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						Dragging = false
					end
				end)
			end
		end)

		changesizeobject.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				DragInput = input
			end
		end)

		uis.InputChanged:Connect(function(input)
			if input == DragInput and Dragging then
				UpdateSize(input)
			end
		end)
	end
	CustomSize(object)
	CustomPos(topbarobject, object)
end
function CircleClick(Button, X, Y)
	spawn(function()
		Button.ClipsDescendants = true
		local Circle = Instance.new("ImageLabel")
		Circle.Image = "rbxassetid://83429535930475"
		Circle.ImageColor3 = Color3.fromRGB(80, 80, 80)
		Circle.ImageTransparency = 0.8999999761581421
		Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Circle.BackgroundTransparency = 1
		Circle.ZIndex = 10
		Circle.Name = "Circle"
		Circle.Parent = Button

		local NewX = X - Circle.AbsolutePosition.X
		local NewY = Y - Circle.AbsolutePosition.Y
		Circle.Position = UDim2.new(0, NewX, 0, NewY)
		local Size = 0
		if Button.AbsoluteSize.X > Button.AbsoluteSize.Y then
			Size = Button.AbsoluteSize.X*1.5
		elseif Button.AbsoluteSize.X < Button.AbsoluteSize.Y then
			Size = Button.AbsoluteSize.Y*1.5
		elseif Button.AbsoluteSize.X == Button.AbsoluteSize.Y then
			Size = Button.AbsoluteSize.X*1.5
		end

		local Time = 0.5
		Circle:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, -Size/2, 0.5, -Size/2), "Out", "Quad", Time, false, nil)
		for i=1,10 do
			Circle.ImageTransparency = Circle.ImageTransparency + 0.01
			wait(Time/10)
		end
		Circle:Destroy()
	end)
end

function Library:AddNotify(ConfigNotify)
	ConfigNotify = ConfigNotify or {}
	ConfigNotify.Title = ConfigNotify.Title or "Notification"
	ConfigNotify.Content = ConfigNotify.Content or "This Is Notification"
	ConfigNotify.Time = ConfigNotify.Time or 5

	spawn(function()
		if not game.Players.LocalPlayer.PlayerGui:FindFirstChild("NotifyGay") then
			local UniqueNotify = Instance.new("ScreenGui")
			UniqueNotify.Name = "NotifyGay"
			UniqueNotify.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
			UniqueNotify.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		end
		if not game.Players.LocalPlayer.PlayerGui:WaitForChild("NotifyGay"):FindFirstChild("NotifyLayout") then
			local NotifyLayout = Instance.new("Frame")
			NotifyLayout.Name = "NotifyLayout"
			NotifyLayout.Parent = game.Players.LocalPlayer.PlayerGui:WaitForChild("NotifyGay")
			NotifyLayout.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NotifyLayout.BackgroundTransparency = 1.000
			NotifyLayout.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NotifyLayout.BorderSizePixel = 0
			NotifyLayout.Position = UDim2.new(1, 200, 1, -100)
			NotifyLayout.Size = UDim2.new(0, 200, 0, 63)
			local Count = 0
			game.Players.LocalPlayer.PlayerGui:WaitForChild("NotifyGay").NotifyLayout.ChildRemoved:Connect(function()
				for r, v in next, game.Players.LocalPlayer.PlayerGui:WaitForChild("NotifyGay").NotifyLayout:GetChildren() do
					TweenService:Create(v, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Position = UDim2.new(0, 0, 1, -((v.Size.Y.Offset + 12) * Count))}):Play()
					Count = Count + 1
				end
			end)
		end
		local NotifyPosHeigh = 0
		for i, v in game.Players.LocalPlayer.PlayerGui:WaitForChild("NotifyGay").NotifyLayout:GetChildren() do
			NotifyPosHeigh = -(v.Position.Y.Offset) + v.Size.Y.Offset + 12
		end
		local NotifyReal = Instance.new("Frame")
		local UICorner = Instance.new("UICorner")
		local Title = Instance.new("TextLabel")
		local UIPadding = Instance.new("UIPadding")
		local Desc = Instance.new("TextLabel")
		local UIPadding_2 = Instance.new("UIPadding")
		local Time = Instance.new("Frame")
		local Close = Instance.new("Frame")
		local Logo = Instance.new("ImageLabel")
		local Click = Instance.new("TextButton")
		local DropShadowHolder = Instance.new("Frame")
		local DropShadow = Instance.new("ImageLabel")
		local NotifyFunc = {}

		NotifyReal.Name = "NotifyReal"
		NotifyReal.Parent = game.Players.LocalPlayer.PlayerGui:WaitForChild("NotifyGay"):FindFirstChild("NotifyLayout")
		NotifyReal.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		NotifyReal.BorderColor3 = Color3.fromRGB(0, 0, 0)
		NotifyReal.BorderSizePixel = 0
		NotifyReal.Position = UDim2.new(0, 0, 0, -(NotifyPosHeigh))
		NotifyReal.Size = UDim2.new(0, 200, 0, 66)

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = NotifyReal

		Title.Name = "Title"
		Title.Parent = NotifyReal
		Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Title.BackgroundTransparency = 1.000
		Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Title.BorderSizePixel = 0
		Title.Size = UDim2.new(1, 0, 0, 20)
		Title.Font = Enum.Font.GothamBold
		Title.Text = ConfigNotify.Title
		Title.TextColor3 = Color3.fromRGB(255, 255, 255)
		Title.TextSize = 14.000
		Title.TextXAlignment = Enum.TextXAlignment.Left

		UIPadding.Parent = Title
		UIPadding.PaddingLeft = UDim.new(0, 12)
		UIPadding.PaddingTop = UDim.new(0, 7)

		Desc.Name = "Desc"
		Desc.Parent = NotifyReal
		Desc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Desc.BackgroundTransparency = 1.000
		Desc.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Desc.BorderSizePixel = 0
		Desc.Position = UDim2.new(0, 0, 0, 23)
		Desc.Size = UDim2.new(1, 0, 1, -23)
		Desc.Font = Enum.Font.GothamBold
		Desc.Text = ConfigNotify.Content
		Desc.TextColor3 = Color3.fromRGB(144, 144, 144)
		Desc.TextSize = 12.000
		Desc.TextWrapped = true
		Desc.TextXAlignment = Enum.TextXAlignment.Left
		Desc.TextYAlignment = Enum.TextYAlignment.Top

		UIPadding_2.Parent = Desc
		UIPadding_2.PaddingLeft = UDim.new(0, 12)
		UIPadding_2.PaddingTop = UDim.new(0, 2)

		Time.Name = "Time"
		Time.Parent = NotifyReal
		Time.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Time.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Time.BorderSizePixel = 0
		Time.Size = UDim2.new(1, 0, 0, 1)

		Close.Name = "Close"
		Close.Parent = NotifyReal
		Close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Close.BackgroundTransparency = 1.000
		Close.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Close.BorderSizePixel = 0
		Close.Position = UDim2.new(1, -20, 0, 0)
		Close.Size = UDim2.new(0, 20, 0, 20)

		Logo.Name = "Logo"
		Logo.Parent = Close
		Logo.AnchorPoint = Vector2.new(0.5, 0.5)
		Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Logo.BackgroundTransparency = 1.000
		Logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Logo.BorderSizePixel = 0
		Logo.Position = UDim2.new(0.5, 0, 0.5, 0)
		Logo.Size = UDim2.new(0, 10, 0, 10)
		Logo.Image = "rbxassetid://83429535930475"

		Click.Name = "Click"
		Click.Parent = Close
		Click.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Click.BackgroundTransparency = 1.000
		Click.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Click.BorderSizePixel = 0
		Click.Size = UDim2.new(1, 0, 1, 0)
		Click.Font = Enum.Font.SourceSans
		Click.Text = ""
		Click.TextColor3 = Color3.fromRGB(0, 0, 0)
		Click.TextSize = 14.000

		DropShadowHolder.Name = "DropShadowHolder"
		DropShadowHolder.Parent = NotifyFrame
		DropShadowHolder.BackgroundTransparency = 1.000
		DropShadowHolder.BorderSizePixel = 0
		DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
		DropShadowHolder.ZIndex = 0

		DropShadow.Name = "DropShadow"
		DropShadow.Parent = DropShadowHolder
		DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
		DropShadow.BackgroundTransparency = 1.000
		DropShadow.BorderSizePixel = 0
		DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
		DropShadow.Size = UDim2.new(1, 50, 1, 50)
		DropShadow.ZIndex = 0
		DropShadow.Image = "rbxassetid://6015897843"
		DropShadow.ImageColor3 = Color3.fromRGB(106, 117, 135)
		DropShadow.ImageTransparency = 0.500
		DropShadow.ScaleType = Enum.ScaleType.Slice
		DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

		local waitbruh = false
		function NotifyFunc:Close()
			if waitbruh then
				return false
			end
			waitbruh = true
			TweenService:Create(
				NotifyReal,
				TweenInfo.new(tonumber(.2), Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
				{Position = UDim2.new(0, 400, 0, 0)}
			):Play()
			task.wait(tonumber(ConfigNotify.Time) / 1.2)
			game.Players.LocalPlayer.PlayerGui.NotifyGay.NotifyLayout:Destroy()
		end
		Click.MouseButton1Click:Connect(
			function()
				NotifyFunc:Close()
			end
		)
		TweenService:Create(
			NotifyReal,
			TweenInfo.new(tonumber(.2), Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
			{Position = UDim2.new(0, -444, 1, -(NotifyPosHeigh) - 20)}
		):Play()
		Time:TweenSize(UDim2.new(0, 0, 0, 1),"Out","Quad",tonumber(ConfigNotify.Time),true)
		task.wait(tonumber(ConfigNotify.Time))
		TweenService:Create(
			NotifyReal,
			TweenInfo.new(tonumber(.2), Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
			{Position = UDim2.new(1, -0, 1, -(NotifyPosHeigh) - 20)}
		):Play()
		task.wait(tonumber(2))
		NotifyFunc:Close()
		return NotifyFunc
	end)
end

function Library:AddWindows()
	local MainScreen = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local UIStroke = Instance.new("UIStroke")
	local DropShadowHolder = Instance.new("Frame")
	local DropShadow = Instance.new("ImageLabel")
	local Top = Instance.new("Frame")
	local UICorner_4 = Instance.new("UICorner")
	local TopFake = Instance.new("Frame")
	local NameHub = Instance.new("TextLabel")
	local TextLabel = Instance.new("TextLabel")
	local TabList = Instance.new("Frame")
	local TabHolder = Instance.new("ScrollingFrame")
	local UIPadding = Instance.new("UIPadding")
	local UIListLayout = Instance.new("UIListLayout")
	local LayoutChannel = Instance.new("Frame")
	local Layout = Instance.new("Frame")
	local ChannelFolder = Instance.new("Folder")
	local UIPageLayout = Instance.new("UIPageLayout")
	local UIClose = Instance.new("Frame")
	local DropShadowHolder_2 = Instance.new("Frame")
	local DropShadow_2 = Instance.new("ImageLabel")
	local Clicked_9 = Instance.new("ImageButton")
	local UICorner_33 = Instance.new("UICorner")
	local UIStroke_15 = Instance.new("UIStroke")
	local ChangeSized = Instance.new("Frame")
	local Lib = {}

	ChangeSized.Name = "ChangeSized"
	ChangeSized.Parent = MainScreen
	ChangeSized.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ChangeSized.BackgroundTransparency = 1.000
	ChangeSized.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ChangeSized.BorderSizePixel = 0
	ChangeSized.Position = UDim2.new(1, -20, 1, -20)
	ChangeSized.Size = UDim2.new(0, 30, 0, 30)

	MainScreen.Name = "MainScreen"
	MainScreen.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

	Main.Name = "Main"
	Main.Parent = MainScreen
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
	Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Main.BorderSizePixel = 0
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.Size = UDim2.new(0, 0, 0, 0) -- UDim2.new(0, 500, 0, 300)
	Main.ClipsDescendants = true
	TweenService:Create(Main, TweenInfo.new(1.5, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 500, 0, 300)}):Play()
	UICorner.Parent = Main

	UIStroke.Parent = Main
	UIStroke.Color = Color3.fromRGB(255, 255, 255)
	UIStroke.Transparency = 0.890
	UIStroke.Thickness = 2.200

	DropShadowHolder.Name = "DropShadowHolder"
	DropShadowHolder.Parent = Main
	DropShadowHolder.BackgroundTransparency = 1.000
	DropShadowHolder.BorderSizePixel = 0
	DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
	DropShadowHolder.ZIndex = 0

	DropShadow.Name = "DropShadow"
	DropShadow.Parent = DropShadowHolder
	DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadow.BackgroundTransparency = 1.000
	DropShadow.BorderSizePixel = 0
	DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	DropShadow.Size = UDim2.new(1, 50, 1, 50)
	DropShadow.ZIndex = 0
	DropShadow.Image = "rbxassetid://6014261993"
	DropShadow.ImageTransparency = 0.500
	DropShadow.ScaleType = Enum.ScaleType.Slice
	DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

	UIClose.Name = "UIClose"
	UIClose.Parent = MainScreen
	UIClose.AnchorPoint = Vector2.new(0.200000003, 0.200000003)
	UIClose.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	UIClose.BackgroundTransparency = 1.000
	UIClose.BorderColor3 = Color3.fromRGB(0, 0, 0)
	UIClose.BorderSizePixel = 0
	UIClose.Position = UDim2.new(0.150000006, 0, 0.150000006, 0)
	UIClose.Size = UDim2.new(0, 0, 0, 0)
	UIClose.ClipsDescendants = true
	TweenService:Create(UIClose, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 45, 0, 45)}):Play()

	DropShadowHolder_2.Name = "DropShadowHolder"
	DropShadowHolder_2.Parent = UIClose
	DropShadowHolder_2.BackgroundTransparency = 1.000
	DropShadowHolder_2.BorderSizePixel = 0
	DropShadowHolder_2.Size = UDim2.new(1, 0, 1, 0)
	DropShadowHolder_2.ZIndex = 0

	DropShadow_2.Name = "DropShadow"
	DropShadow_2.Parent = DropShadowHolder_2
	DropShadow_2.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadow_2.BackgroundTransparency = 1.000
	DropShadow_2.BorderSizePixel = 0
	DropShadow_2.Position = UDim2.new(0.5, 0, 0.5, 0)
	DropShadow_2.Size = UDim2.new(1, 47, 1, 47)
	DropShadow_2.ZIndex = 0
	DropShadow_2.Image = "rbxassetid://6014261993"
	DropShadow_2.ImageColor3 = Color3.fromRGB(0, 0, 0)
	DropShadow_2.ImageTransparency = 0.500
	DropShadow_2.ScaleType = Enum.ScaleType.Slice
	DropShadow_2.SliceCenter = Rect.new(49, 49, 450, 450)
Clicked_9.Name = "Clicked"
Clicked_9.Parent = UIClose
Clicked_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Clicked_9.BorderColor3 = Color3.fromRGB(0, 0, 0)
Clicked_9.BorderSizePixel = 0
Clicked_9.Size = UDim2.new(1, 0, 1, 0)
Clicked_9.Image = "rbxassetid://83429535930475"

-- Thêm UICorner
local UICorner_33 = Instance.new("UICorner")
UICorner_33.CornerRadius = UDim.new(1, 0) -- Bo góc 1 pixel
UICorner_33.Parent = Clicked_9

local OldSize = UDim2.new(0, 500, 0, 300)
Clicked_9.Activated:Connect(function()
	CircleClick(Clicked_9, Mouse.X, Mouse.Y)
	if Main.Size.Y.Offset <= 0 then
		UIStroke.Enabled = true
		TweenService:Create(Main, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = OldSize}):Play()
	else
		OldSize = Main.Size
		UIStroke.Enabled = false
		TweenService:Create(Main, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 0, 0, -0)}):Play()
	end
end)

UIStroke_15.Parent = Clicked_9
UIStroke_15.Color = Color3.fromRGB(255, 255, 255)
UIStroke_15.Transparency = 1

	Top.Name = "Top"
	Top.Parent = Main
	Top.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
	Top.BackgroundTransparency = 1.000
	Top.Position = UDim2.new(0, -200, 0, 0)
	Top.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Top.BorderSizePixel = 0
	Top.Size = UDim2.new(1, 0, 0, 30)
	TweenService:Create(Top, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Position = UDim2.new(0, 0, 0, 0)}):Play()
	UICorner_4.Parent = Top

	TopFake.Name = "Top Fake"
	TopFake.Parent = Top
	TopFake.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
	TopFake.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TopFake.BorderSizePixel = 0
	TopFake.Position = UDim2.new(0, 0, 1, -5)
	TopFake.Size = UDim2.new(1, 0, 0, 10)

	NameHub.Name = "NameHub"
	NameHub.Parent = Top
	NameHub.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	NameHub.BackgroundTransparency = 1.000
	NameHub.BorderColor3 = Color3.fromRGB(0, 0, 0)
	NameHub.BorderSizePixel = 0
	NameHub.Position = UDim2.new(0, 17, 0, 7) -- Offset : 17
	NameHub.Size = UDim2.new(0, 100, 0, 25)
	NameHub.Font = Enum.Font.GothamBold
	NameHub.Text = "Rise Hub"
	NameHub.TextColor3 = Color3.fromRGB(255, 255, 255)
	NameHub.TextSize = 14.000
	NameHub.TextXAlignment = Enum.TextXAlignment.Left

	TextLabel.Parent = Top
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.BackgroundTransparency = 1.000
	TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel.BorderSizePixel = 0
	TextLabel.Position = UDim2.new(0, 65, 0, 2)
	TextLabel.Size = UDim2.new(0, 165, 0, 35)
	TextLabel.Font = Enum.Font.GothamBold
	TextLabel.Text = "discord.gg/P24sKJYapX"
	TextLabel.TextColor3 = Color3.fromRGB(95, 95, 95)
	TextLabel.TextSize = 13.000

	TabList.Name = "TabList"
	TabList.Parent = Main
	TabList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabList.BackgroundTransparency = 1.000
	TabList.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabList.BorderSizePixel = 0
	TabList.Position = UDim2.new(0, -200, 0, 40)
	TabList.Size = UDim2.new(0, 125, 1, -40)
	TweenService:Create(TabList, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Position = UDim2.new(0, 0, 0, 40)}):Play()

	TabHolder.Name = "Tab Holder"
	TabHolder.Parent = TabList
	TabHolder.AnchorPoint = Vector2.new(0.5, 0.5)
	TabHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabHolder.BackgroundTransparency = 1.000
	TabHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabHolder.BorderSizePixel = 0
	TabHolder.Position = UDim2.new(0.5, 0, 0.5, 0)
	TabHolder.Size = UDim2.new(1, -5, 1, -5)
	TabHolder.ScrollBarThickness = 0
	game:GetService("RunService").Stepped:Connect(function ()
		TabHolder.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 20)
	end)

	UIPadding.Parent = TabHolder
	UIPadding.PaddingBottom = UDim.new(0, 2)
	UIPadding.PaddingLeft = UDim.new(0, 2)
	UIPadding.PaddingRight = UDim.new(0, 2)
	UIPadding.PaddingTop = UDim.new(0, 7)

	UIListLayout.Parent = TabHolder
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 8)

	LayoutChannel.Name = "LayoutChannel"
	LayoutChannel.Parent = Main
	LayoutChannel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LayoutChannel.BackgroundTransparency = 1.000
	LayoutChannel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LayoutChannel.BorderSizePixel = 0
	LayoutChannel.Position = UDim2.new(0, 500, 0, 40)
	LayoutChannel.Size = UDim2.new(1, -125, 1, -40)
	LayoutChannel.ClipsDescendants = true
	TweenService:Create(LayoutChannel, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Position = UDim2.new(0, 125, 0, 40)}):Play()

	Layout.Name = "Layout"
	Layout.Parent = LayoutChannel
	Layout.AnchorPoint = Vector2.new(0.5, 0.5)
	Layout.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Layout.BackgroundTransparency = 1.000
	Layout.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Layout.BorderSizePixel = 0
	Layout.Position = UDim2.new(0.5, 0, 0.5, 0)
	Layout.Size = UDim2.new(1, -5, 1, -5)

	ChannelFolder.Name = "Channel Folder"
	ChannelFolder.Parent = Layout

	UIPageLayout.Parent = ChannelFolder
	UIPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIPageLayout.Padding = UDim.new(0, 12)
	UIPageLayout.TweenTime = 0.480
	UIPageLayout.ScrollWheelInputEnabled = false
	function Library:BuildUI()
		Main.Visible = true
	end
	makedraggable(Top, Main)
	local CountTab = 0
	local TabFunc = {}
	function TabFunc:AddTab(cf)
		cf = cf or {}
		cf.Name = cf.Name or "Tab 1"

		local Channel = Instance.new("ScrollingFrame")
		local UIListLayout_2 = Instance.new("UIListLayout")
		local UIPadding_2 = Instance.new("UIPadding")
		local TabDisable = Instance.new("Frame")
		local UICorner_7 = Instance.new("UICorner")
		local NameTab_2 = Instance.new("TextLabel")
		local Cricle_2 = Instance.new("Frame")
		local UICorner_8 = Instance.new("UICorner")
		local Click_2 = Instance.new("TextButton")

		Channel.Name = "Channel"
		Channel.Parent = ChannelFolder
		Channel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Channel.BackgroundTransparency = 1.000
		Channel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Channel.BorderSizePixel = 0
		Channel.Size = UDim2.new(1, 0, 1, 0)
		Channel.ScrollBarThickness = 0
		Channel.LayoutOrder = CountTab
		game:GetService("RunService").Stepped:Connect(function ()
			Channel.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_2.AbsoluteContentSize.Y + 20)
		end)

		UIListLayout_2.Parent = Channel
		UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_2.Padding = UDim.new(0, 9)

		UIPadding_2.Parent = Channel
		UIPadding_2.PaddingBottom = UDim.new(0, 7)
		UIPadding_2.PaddingLeft = UDim.new(0, 7)
		UIPadding_2.PaddingRight = UDim.new(0, 7)
		UIPadding_2.PaddingTop = UDim.new(0, 7)

		TabDisable.Name = "Tab Disable"
		TabDisable.Parent = TabHolder
		TabDisable.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabDisable.BackgroundTransparency = 1.000
		TabDisable.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabDisable.BorderSizePixel = 0
		TabDisable.ClipsDescendants = true
		TabDisable.Size = UDim2.new(1, 0, 0, 25)

		UICorner_7.CornerRadius = UDim.new(0, 2)
		UICorner_7.Parent = TabDisable

		NameTab_2.Name = "NameTab"
		NameTab_2.Parent = TabDisable
		NameTab_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		NameTab_2.BackgroundTransparency = 1.000
		NameTab_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		NameTab_2.BorderSizePixel = 0
		NameTab_2.Position = UDim2.new(0, 30, 0, 0)
		NameTab_2.Size = UDim2.new(1, -30, 1, 0)
		NameTab_2.Font = Enum.Font.GothamBold
		NameTab_2.Text = cf.Name
		NameTab_2.TextColor3 = Color3.fromRGB(177, 177, 177)
		NameTab_2.TextSize = 13.000
		NameTab_2.TextXAlignment = Enum.TextXAlignment.Left

		Cricle_2.Name = "Cricle"
		Cricle_2.Parent = TabDisable
		Cricle_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Cricle_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Cricle_2.BorderSizePixel = 0
		Cricle_2.Position = UDim2.new(0, -10, 0, 3)
		Cricle_2.Size = UDim2.new(0, 5, 0, 20)

		UICorner_8.Parent = Cricle_2

		Click_2.Name = "Click"
		Click_2.Parent = TabDisable
		Click_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Click_2.BackgroundTransparency = 1.000
		Click_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Click_2.BorderSizePixel = 0
		Click_2.Size = UDim2.new(1, 0, 1, 0)
		Click_2.Font = Enum.Font.SourceSans
		Click_2.Text = ""
		Click_2.TextColor3 = Color3.fromRGB(0, 0, 0)
		Click_2.TextSize = 14.000
		Click_2.Activated:Connect(function()
			CircleClick(Click_2, Mouse.X, Mouse.Y)
			for r, v in pairs(TabHolder:GetChildren()) do
				if v.Name == "Tab Disable" then
					TweenService:Create(v, TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundTransparency = 1.000}):Play()
				end
			end
			for r, v in pairs(TabHolder:GetChildren()) do
				for ni, gga in next, v:GetChildren() do
					if gga.Name == "NameTab" then
						TweenService:Create(gga, TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {TextColor3 = Color3.fromRGB(144, 144, 144)}):Play()
					end
				end
			end
			for r, v in pairs(TabHolder:GetChildren()) do
				for ni, gga in next, v:GetChildren() do
					if gga.Name == "Cricle" then
						TweenService:Create(gga, TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Position = UDim2.new(0, -7, 0, 3)}):Play()
					end
				end
			end
			UIPageLayout:JumpToIndex(Channel.LayoutOrder)
			TweenService:Create(TabDisable, TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundTransparency = 1.980}):Play()
			TweenService:Create(NameTab_2, TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
			TweenService:Create(Cricle_2, TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Position = UDim2.new(0, 0, 0, 3)}):Play()
		end)
		CountTab = CountTab + 1
		local Fe = {}
		function Fe:AddSeperator(hahaha)
			local Seperator = Instance.new("Frame")
			local Line = Instance.new("Frame")
			local Title = Instance.new("TextLabel")

			Seperator.Name = "Seperator"
			Seperator.Parent = Channel
			Seperator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Seperator.BackgroundTransparency = 1.000
			Seperator.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Seperator.BorderSizePixel = 0
			Seperator.Size = UDim2.new(1, 0, 0, 30)

			Line.Name = "Line"
			Line.Parent = Seperator
			Line.AnchorPoint = Vector2.new(0.5, 0.5)
			Line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Line.BorderSizePixel = 0
			Line.Position = UDim2.new(0.5, 0, 0.5, 0)
			Line.Size = UDim2.new(1, 0, 0, 2)

			Title.Name = "Title"
			Title.Parent = Line
			Title.AnchorPoint = Vector2.new(0.5, 0.5)
			Title.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Position = UDim2.new(0.479999989, 0, 0.5, 0)
			Title.Size = UDim2.new(0, 100, 0, 30)
			Title.Font = Enum.Font.GothamBold
			Title.Text = hahaha
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 13.000
			Title:GetPropertyChangedSignal("Text"):Connect(function()
				Title.Size = UDim2.new(0, Title.TextBounds.X + 34, 0, 45)
			end)
		end
		function Fe:AddButton(cf)
			cf = cf or {}
			cf.Name = cf.Name or "Button"
			cf.Description = cf.Description or ""
			cf.Callback = cf.Callback or function() print("Hello World") end

			local Button = Instance.new("Frame")
			local UICorner_9 = Instance.new("UICorner")
			local Title_2 = Instance.new("TextLabel")
			local Description1 = Instance.new("TextLabel")
			local UIStroke_2 = Instance.new("UIStroke")
			local Icon = Instance.new("ImageLabel")
			local Clicked = Instance.new("TextButton")

			Button.Name = "Button"
			Button.Parent = Channel
			Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Button.BackgroundTransparency = 0.930
			Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Button.BorderSizePixel = 0
			Button.Size = UDim2.new(1, 0, 0, 45)

			UICorner_9.CornerRadius = UDim.new(0, 4)
			UICorner_9.Parent = Button

			Title_2.Name = "Title"
			Title_2.Parent = Button
			Title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title_2.BackgroundTransparency = 1.000
			Title_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title_2.BorderSizePixel = 0
			Title_2.Position = UDim2.new(0, 7, 0, 4)
			Title_2.Size = UDim2.new(1, 0, 0, 15)
			Title_2.Font = Enum.Font.GothamBold
			Title_2.Text = cf.Name
			Title_2.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title_2.TextSize = 13.000
			Title_2.TextXAlignment = Enum.TextXAlignment.Left

			Description1.Name = "Description1"
			Description1.Parent = Button
			Description1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Description1.BackgroundTransparency = 1.000
			Description1.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Description1.BorderSizePixel = 0
			Description1.Position = UDim2.new(0, 7, 0, 19)
			Description1.Size = UDim2.new(1, -40, 0, 26)
			Description1.Font = Enum.Font.GothamBold
			Description1.Text = cf.Description
			Description1.TextColor3 = Color3.fromRGB(144, 144, 144)
			Description1.TextSize = 12.000
			Description1.TextWrapped = true
			Description1.TextXAlignment = Enum.TextXAlignment.Left
			Description1.TextYAlignment = Enum.TextYAlignment.Top

			UIStroke_2.Parent = Button
			UIStroke_2.Color = Color3.fromRGB(255, 255, 255)
			UIStroke_2.Transparency = 0.880
			UIStroke_2.Thickness = 1.040

			Icon.Name = "Icon"
			Icon.Parent = Button
			Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Icon.BackgroundTransparency = 1.000
			Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Icon.BorderSizePixel = 0
			Icon.Position = UDim2.new(1, -40, 0, 10)
			Icon.Size = UDim2.new(0, 25, 0, 25)
			Icon.Image = "http://www.roblox.com/asset/?id=136218211170733"

			Clicked.Name = "Clicked"
			Clicked.Parent = Button
			Clicked.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Clicked.BackgroundTransparency = 1.000
			Clicked.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Clicked.BorderSizePixel = 0
			Clicked.Size = UDim2.new(1, 0, 1, 0)
			Clicked.Font = Enum.Font.SourceSans
			Clicked.Text = ""
			Clicked.TextColor3 = Color3.fromRGB(0, 0, 0)
			Clicked.TextSize = 14.000
			Clicked.Activated:Connect(function()
				CircleClick(Clicked, Mouse.X, Mouse.Y)
				cf.Callback()
			end)
		end
		function Fe:AddToggle(cf)
			cf = cf or {}
			cf.Name = cf.Name or "Toggle"
			cf.Description = cf.Description or ""
			cf.Settings = cf.Settings or false
			cf.Default = cf.Default or false
			cf.Callback = cf.Callback or function() end

			local Toggle = Instance.new("Frame")
			local UICorner_10 = Instance.new("UICorner")
			local Title_3 = Instance.new("TextLabel")
			local Description_2 = Instance.new("TextLabel")
			local UIStroke_3 = Instance.new("UIStroke")
			local Clicked_2 = Instance.new("TextButton")
			local CheckFrame = Instance.new("Frame")
			local UICorner_11 = Instance.new("UICorner")
			local UIStroke_4 = Instance.new("UIStroke")
			local Check = Instance.new("Frame")
			local UICorner_12 = Instance.new("UICorner")
			local Checker = Instance.new("ImageLabel")
			local Settings = Instance.new("Frame")
			local UICorner_13 = Instance.new("UICorner")
			local Hide = Instance.new("Frame")
			local Icon_2 = Instance.new("ImageLabel")
			local Clicked_3 = Instance.new("TextButton")
			local ToggleSetting = Instance.new("Frame")
			local UICorner_27 = Instance.new("UICorner")
			local UIStroke_12 = Instance.new("UIStroke")
			local BackFrame = Instance.new("Frame")
			local Setting = Instance.new("TextLabel")
			local BackFrame1 = Instance.new("Frame")
			local Icon_4 = Instance.new("ImageLabel")
			local Clicked_7 = Instance.new("TextButton")
			local List = Instance.new("Frame")
			local UIListLayout_4 = Instance.new("UIListLayout")
			local UIPadding_4 = Instance.new("UIPadding")
			local ToggleFunc = {Value = cf.Default}

			Toggle.Name = "Toggle"
			Toggle.Parent = Channel
			Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Toggle.BackgroundTransparency = 0.930
			Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Toggle.BorderSizePixel = 0
			Toggle.Size = UDim2.new(1, 0, 0, 45)

			UICorner_10.CornerRadius = UDim.new(0, 4)
			UICorner_10.Parent = Toggle

			Title_3.Name = "Title"
			Title_3.Parent = Toggle
			Title_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title_3.BackgroundTransparency = 1.000
			Title_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title_3.BorderSizePixel = 0
			Title_3.Position = UDim2.new(0, 7, 0, 4)
			Title_3.Size = UDim2.new(1, 0, 0, 15)
			Title_3.Font = Enum.Font.GothamBold
			Title_3.Text = cf.Name
			Title_3.TextColor3 = Color3.fromRGB(177, 177, 177)
			Title_3.TextSize = 13.000
			Title_3.TextXAlignment = Enum.TextXAlignment.Left

			Description_2.Name = "Description"
			Description_2.Parent = Toggle
			Description_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Description_2.BackgroundTransparency = 1.000
			Description_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Description_2.BorderSizePixel = 0
			Description_2.Position = UDim2.new(0, 7, 0, 19)
			Description_2.Size = UDim2.new(1, -40, 0, 26)
			Description_2.Font = Enum.Font.GothamBold
			Description_2.Text = cf.Description
			Description_2.TextColor3 = Color3.fromRGB(144, 144, 144)
			Description_2.TextSize = 12.000
			Description_2.TextXAlignment = Enum.TextXAlignment.Left
			Description_2.TextYAlignment = Enum.TextYAlignment.Top

			UIStroke_3.Parent = Toggle
			UIStroke_3.Color = Color3.fromRGB(255, 255, 255)
			UIStroke_3.Transparency = 0.880
			UIStroke_3.Thickness = 1.040

			Clicked_2.Name = "Clicked"
			Clicked_2.Parent = Toggle
			Clicked_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Clicked_2.BackgroundTransparency = 1.000
			Clicked_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Clicked_2.BorderSizePixel = 0
			Clicked_2.Size = UDim2.new(1, -20, 1, 0)
			Clicked_2.Font = Enum.Font.SourceSans
			Clicked_2.Text = ""
			Clicked_2.TextColor3 = Color3.fromRGB(0, 0, 0)
			Clicked_2.TextSize = 14.000

			CheckFrame.Name = "CheckFrame"
			CheckFrame.Parent = Toggle
			CheckFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
			CheckFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			CheckFrame.BorderSizePixel = 0
			CheckFrame.Position = UDim2.new(1, -55, 0, 10)
			CheckFrame.Size = UDim2.new(0, 25, 0, 25)

			UICorner_11.CornerRadius = UDim.new(0, 4)
			UICorner_11.Parent = CheckFrame

			UIStroke_4.Parent = CheckFrame
			UIStroke_4.Color = Color3.fromRGB(255, 255, 255)
			UIStroke_4.Transparency = 0.870

			Check.Name = "Check"
			Check.Parent = CheckFrame
			Check.AnchorPoint = Vector2.new(0.5, 0.5)
			Check.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Check.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Check.BorderSizePixel = 0
			Check.Position = UDim2.new(0.5, 0, 0.5, 0)
			Check.Size = UDim2.new(0, 0, 0,0) -- UDim2.new(1, -2, 1, -2)

			UICorner_12.CornerRadius = UDim.new(0, 4)
			UICorner_12.Parent = Check

			Checker.Name = "Checker"
			Checker.Parent = Check
			Checker.AnchorPoint = Vector2.new(0.5, 0.5)
			Checker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Checker.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Checker.BorderSizePixel = 0
			Checker.Position = UDim2.new(0.5, 0, 0.5, 0)
			Checker.Size = UDim2.new(0, 0, 0, 0) -- UDim2.new(1, -5, 1, -5)
			Checker.Image = "http://www.roblox.com/asset/?id=110154647736853"
			Checker.ImageColor3 = Color3.fromRGB(0, 0, 0)

			if cf.Settings then
				Settings.Name = "Settings"
				Settings.Parent = Toggle
				Settings.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
				Settings.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Settings.BorderSizePixel = 0
				Settings.Position = UDim2.new(1, -10, 0, 0)
				Settings.Size = UDim2.new(0, 10, 1, 0)

				UICorner_13.CornerRadius = UDim.new(0, 4)
				UICorner_13.Parent = Settings

				Hide.Name = "Hide"
				Hide.Parent = Settings
				Hide.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
				Hide.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Hide.BorderSizePixel = 0
				Hide.Position = UDim2.new(0, -8, 0, 0)
				Hide.Size = UDim2.new(1, 0, 1, 0)

				Icon_2.Name = "Icon"
				Icon_2.Parent = Settings
				Icon_2.AnchorPoint = Vector2.new(0.5, 0.5)
				Icon_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Icon_2.BackgroundTransparency = 1.000
				Icon_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Icon_2.BorderSizePixel = 0
				Icon_2.Position = UDim2.new(0.400000006, 0, 0.5, 0)
				Icon_2.Size = UDim2.new(0, 25, 0, 25)
				Icon_2.Image = "rbxassetid://79805696573932"
				Icon_2.ImageColor3 = Color3.fromRGB(200, 200, 200)

				Clicked_3.Name = "Clicked"
				Clicked_3.Parent = Settings
				Clicked_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Clicked_3.BackgroundTransparency = 1.000
				Clicked_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Clicked_3.BorderSizePixel = 0
				Clicked_3.Position = UDim2.new(0, -10, 0, 0)
				Clicked_3.Size = UDim2.new(1, 10, 1, 0)
				Clicked_3.Font = Enum.Font.SourceSans
				Clicked_3.Text = ""
				Clicked_3.TextColor3 = Color3.fromRGB(0, 0, 0)
				Clicked_3.TextSize = 14.000

				ToggleSetting.Name = "ToggleSetting"
				ToggleSetting.Parent = Main
				ToggleSetting.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
				ToggleSetting.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ToggleSetting.BorderSizePixel = 0
				ToggleSetting.ClipsDescendants = true
				ToggleSetting.Position = UDim2.new(1, 0, 0, 40)
				ToggleSetting.Size = UDim2.new(0, 0, 1, -40)

				UICorner_27.CornerRadius = UDim.new(0, 2)
				UICorner_27.Parent = ToggleSetting

				UIStroke_12.Parent = ToggleSetting
				UIStroke_12.Color = Color3.fromRGB(255, 255, 255)
				UIStroke_12.Transparency = 0.890
				UIStroke_12.Thickness = 2.200

				BackFrame.Name = "BackFrame"
				BackFrame.Parent = ToggleSetting
				BackFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				BackFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				BackFrame.BorderSizePixel = 0
				BackFrame.Size = UDim2.new(1, 0, 0, 40)

				Setting.Name = "Setting"
				Setting.Parent = BackFrame
				Setting.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Setting.BackgroundTransparency = 1.000
				Setting.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Setting.BorderSizePixel = 0
				Setting.Position = UDim2.new(0, 50, 0, 0)
				Setting.Size = UDim2.new(0, 100, 0, 40)
				Setting.Font = Enum.Font.GothamBold
				Setting.Text = "Settings"
				Setting.TextColor3 = Color3.fromRGB(255, 255, 255)
				Setting.TextSize = 13.000
				Setting.TextXAlignment = Enum.TextXAlignment.Left

				BackFrame1.Name = "BackFrame1"
				BackFrame1.Parent = BackFrame
				BackFrame1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				BackFrame1.BackgroundTransparency = 1.000
				BackFrame1.BorderColor3 = Color3.fromRGB(0, 0, 0)
				BackFrame1.BorderSizePixel = 0
				BackFrame1.Size = UDim2.new(0, 40, 0, 40)

				Icon_4.Name = "Icon"
				Icon_4.Parent = BackFrame1
				Icon_4.AnchorPoint = Vector2.new(0.5, 0.5)
				Icon_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Icon_4.BackgroundTransparency = 1.000
				Icon_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Icon_4.BorderSizePixel = 0
				Icon_4.Position = UDim2.new(0.5, 0, 0.5, 0)
				Icon_4.Size = UDim2.new(1, -10, 1, -10)
				Icon_4.Image = "rbxassetid://83868171368679"

				Clicked_7.Name = "Clicked"
				Clicked_7.Parent = BackFrame1
				Clicked_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Clicked_7.BackgroundTransparency = 1.000
				Clicked_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Clicked_7.BorderSizePixel = 0
				Clicked_7.Size = UDim2.new(1, 0, 1, 0)
				Clicked_7.Font = Enum.Font.SourceSans
				Clicked_7.Text = ""
				Clicked_7.TextColor3 = Color3.fromRGB(0, 0, 0)
				Clicked_7.TextSize = 14.000

				List.Name = "List"
				List.Parent = ToggleSetting
				List.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				List.BackgroundTransparency = 1.000
				List.BorderColor3 = Color3.fromRGB(0, 0, 0)
				List.BorderSizePixel = 0
				List.Position = UDim2.new(0, 0, 0, 40)
				List.Size = UDim2.new(1, 0, 1, -40)

				UIListLayout_4.Parent = List
				UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout_4.Padding = UDim.new(0, 9)

				UIPadding_4.Parent = List
				UIPadding_4.PaddingBottom = UDim.new(0, 7)
				UIPadding_4.PaddingLeft = UDim.new(0, 7)
				UIPadding_4.PaddingRight = UDim.new(0, 7)
				UIPadding_4.PaddingTop = UDim.new(0, 7)

				Clicked_3.Activated:Connect(function()
					CircleClick(Clicked_3, Mouse.X, Mouse.Y)
					Clicked_2.Active = false
					TweenService:Create(ToggleSetting, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(0, -220, 1, -40)}):Play()
				end)

				Clicked_7.Activated:Connect(function()
					CircleClick(Clicked_7, Mouse.X, Mouse.Y)
					Clicked_2.Active = true
					TweenService:Create(ToggleSetting, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 0, 1, -40)}):Play()
				end)
			end

            Clicked_2.Activated:Connect(function()
				CircleClick(Clicked_2, Mouse.X, Mouse.Y)
				ToggleFunc.Value = not ToggleFunc.Value
				ToggleFunc:Set(ToggleFunc.Value)
			end)

			function ToggleFunc:Set(Value)
				if Value then
					TweenService:Create(Title_3, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
					TweenService:Create(Check, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(1, -2, 1, -2)}):Play()
					TweenService:Create(Checker, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(1, -5, 1, -5)}):Play()
				else
					TweenService:Create(Title_3, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {TextColor3 = Color3.fromRGB(177, 177, 177)}):Play()
					TweenService:Create(Check, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 0, 0, 0)}):Play()
					TweenService:Create(Checker, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 0, 0, 0)}):Play()
				end
				ToggleFunc.Value = Value
				cf.Callback(ToggleFunc.Value)
			end
			ToggleFunc:Set(ToggleFunc.Value)
			
			function ToggleFunc:AddToggle(cftoggle)
				cftoggle = cftoggle or {}
				cftoggle.Name = cftoggle.Name or "Toggle"
				cftoggle.Default = cftoggle.Default or false
				cftoggle.Callback = cftoggle.Callback or function() end

				local Toggle_2 = Instance.new("Frame")
				local Title_10 = Instance.new("TextLabel")
				local Checker_2 = Instance.new("Frame")
				local UICorner_28 = Instance.new("UICorner")
				local UIStroke_13 = Instance.new("UIStroke")
				local Check_2 = Instance.new("Frame")
				local UICorner_29 = Instance.new("UICorner")
				local Checker_3 = Instance.new("ImageLabel")
				local Clicked_8 = Instance.new("TextButton")
				local ToggleSettingsFunc = {}

				Toggle_2.Name = "Toggle"
				Toggle_2.Parent = List
				Toggle_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Toggle_2.BackgroundTransparency = 1.000
				Toggle_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Toggle_2.BorderSizePixel = 0
				Toggle_2.Size = UDim2.new(1, 0, 0, 40)

				Title_10.Name = "Title"
				Title_10.Parent = Toggle_2
				Title_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title_10.BackgroundTransparency = 1.000
				Title_10.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Title_10.BorderSizePixel = 0
				Title_10.Position = UDim2.new(0, 7, 0, 0)
				Title_10.Size = UDim2.new(0, 100, 1, 0)
				Title_10.Font = Enum.Font.GothamBold
				Title_10.Text = cftoggle.Name
				Title_10.TextColor3 = Color3.fromRGB(255, 255, 255)
				Title_10.TextSize = 13.000
				Title_10.TextXAlignment = Enum.TextXAlignment.Left

				Checker_2.Name = "Checker"
				Checker_2.Parent = Toggle_2
				Checker_2.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
				Checker_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Checker_2.BorderSizePixel = 0
				Checker_2.Position = UDim2.new(0.864, 0,0.17, 0)
				Checker_2.Size = UDim2.new(0, 25, 0, 25)

				UICorner_28.CornerRadius = UDim.new(0, 4)
				UICorner_28.Parent = Checker_2

				UIStroke_13.Parent = Checker_2
				UIStroke_13.Color = Color3.fromRGB(255, 255, 255)
				UIStroke_13.Transparency = 0.890
				UIStroke_13.Thickness = 1.200

				Check_2.Name = "Check"
				Check_2.Parent = Checker_2
				Check_2.AnchorPoint = Vector2.new(0.5, 0.5)
				Check_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Check_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Check_2.BorderSizePixel = 0
				Check_2.Position = UDim2.new(0.5, 0, 0.5, 0)
				Check_2.Size = UDim2.new(0,0,0,0)

				UICorner_29.CornerRadius = UDim.new(0, 4)
				UICorner_29.Parent = Check_2

				Checker_3.Name = "Checker"
				Checker_3.Parent = Check_2
				Checker_3.AnchorPoint = Vector2.new(0.5, 0.5)
				Checker_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Checker_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Checker_3.BorderSizePixel = 0
				Checker_3.Position = UDim2.new(0.5, 0, 0.5, 0)
				Checker_3.Size = UDim2.new(0,0,0,0)
				Checker_3.Image = "http://www.roblox.com/asset/?id=110154647736853"
				Checker_3.ImageColor3 = Color3.fromRGB(0, 0, 0)

				Clicked_8.Name = "Clicked"
				Clicked_8.Parent = Toggle_2
				Clicked_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Clicked_8.BackgroundTransparency = 1.000
				Clicked_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Clicked_8.BorderSizePixel = 0
				Clicked_8.Size = UDim2.new(1, 0, 1, 0)
				Clicked_8.Font = Enum.Font.SourceSans
				Clicked_8.Text = ""
				Clicked_8.TextColor3 = Color3.fromRGB(0, 0, 0)
				Clicked_8.TextSize = 14.000

				NiggaToggled = false
				function ToggleSettingsFunc:Set(Value)
					if Value then
						TweenService:Create(Title_10, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
						TweenService:Create(Check_2, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(1, -2, 1, -2)}):Play()
						TweenService:Create(Checker_3, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(1, -5, 1, -5)}):Play()
					else
						TweenService:Create(Title_10, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {TextColor3 = Color3.fromRGB(177, 177, 177)}):Play()
						TweenService:Create(Check_2, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 0, 0, 0)}):Play()
						TweenService:Create(Checker_3, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 0, 0, 0)}):Play()
					end
					NiggaToggled = Value
					cftoggle.Callback(NiggaToggled)
				end

				if cftoggle.Default then
					NiggaToggled = true
					ToggleSettingsFunc:Set(true)
				end

				Clicked_8.Activated:Connect(function()
					CircleClick(Clicked_8, Mouse.X, Mouse.Y)
					if not NiggaToggled then
						TweenService:Create(Title_10, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
						TweenService:Create(Check_2, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(1, -2, 1, -2)}):Play()
						TweenService:Create(Checker_3, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(1, -5, 1, -5)}):Play()
					else
						TweenService:Create(Title_10, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {TextColor3 = Color3.fromRGB(177, 177, 177)}):Play()
						TweenService:Create(Check_2, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 0, 0, 0)}):Play()
						TweenService:Create(Checker_3, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 0, 0, 0)}):Play()
					end
					NiggaToggled = not NiggaToggled
					cftoggle.Callback(NiggaToggled)
				end)
				return ToggleSettingsFunc
			end
			function ToggleFunc:AddSlider(cfslider)
				cfslider = cfslider or {}
				cfslider.Name = cfslider.Name or "Slider"
				cfslider.Max = cfslider.Max or 100
				cfslider.Min = cfslider.Min or 10
				cfslider.Default = cfslider.Default or 50
				cfslider.Callback = cfslider.Callback or function() end

				local Slider_2 = Instance.new("Frame")
				local Title_11 = Instance.new("TextLabel")
				local SliderFrame_2 = Instance.new("Frame")
				local UICorner_30 = Instance.new("UICorner")
				local UIStroke_14 = Instance.new("UIStroke")
				local SliderDraggable_2 = Instance.new("Frame")
				local UICorner_31 = Instance.new("UICorner")
				local Cricle_6 = Instance.new("Frame")
				local UICorner_32 = Instance.new("UICorner")
				local Slider1 = {Value = cfslider.Default}

				Slider_2.Name = "Slider"
				Slider_2.Parent = List
				Slider_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Slider_2.BackgroundTransparency = 1.000
				Slider_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Slider_2.BorderSizePixel = 0
				Slider_2.Size = UDim2.new(1, 0, 0, 40)

				Title_11.Name = "Title"
				Title_11.Parent = Slider_2
				Title_11.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title_11.BackgroundTransparency = 1.000
				Title_11.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Title_11.BorderSizePixel = 0
				Title_11.Position = UDim2.new(0, 7, 0, 0)
				Title_11.Size = UDim2.new(0, 100, 0, 20)
				Title_11.Font = Enum.Font.GothamBold
				Title_11.Text = cfslider.Name .. " : " .. cfslider.Default
				Title_11.TextColor3 = Color3.fromRGB(255, 255, 255)
				Title_11.TextSize = 13.000
				Title_11.TextXAlignment = Enum.TextXAlignment.Left

				SliderFrame_2.Name = "SliderFrame_2"
				SliderFrame_2.Parent = Slider_2
				SliderFrame_2.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
				SliderFrame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SliderFrame_2.BorderSizePixel = 0
				SliderFrame_2.Position = UDim2.new(0, 7, 0, 25)
				SliderFrame_2.Size = UDim2.new(1, -14, 0, 6)

				UICorner_30.CornerRadius = UDim.new(0, 2)
				UICorner_30.Parent = SliderFrame_2

				UIStroke_14.Parent = SliderFrame_2
				UIStroke_14.Color = Color3.fromRGB(255, 255, 255)
				UIStroke_14.Transparency = 0.890
				UIStroke_14.Thickness = 1.200

				SliderDraggable_2.Name = "SliderDraggable"
				SliderDraggable_2.Parent = SliderFrame_2
				SliderDraggable_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SliderDraggable_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SliderDraggable_2.BorderSizePixel = 0
				SliderDraggable_2.Size = UDim2.new(0, 100, 1, 0)

				UICorner_31.CornerRadius = UDim.new(0, 4)
				UICorner_31.Parent = SliderDraggable_2

				Cricle_6.Name = "Cricle"
				Cricle_6.Parent = SliderDraggable_2
				Cricle_6.AnchorPoint = Vector2.new(1, 1)
				Cricle_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Cricle_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Cricle_6.BorderSizePixel = 0
				Cricle_6.Position = UDim2.new(1, 0, 0, 13)
				Cricle_6.Size = UDim2.new(0, 20, 0, 20)

				UICorner_32.CornerRadius = UDim.new(1, 0)
				UICorner_32.Parent = Cricle_6

				local function Round(Number, Factor)
					local Result = math.floor(Number/Factor + (math.sign(Number) * 0.5)) * Factor
					if Result < 0 then Result = Result + Factor end
					return Result
				end
				function Slider1:Set(Value)
					Value = math.clamp(Round(Value, 1), cfslider.Min, cfslider.Max)
					Slider1.Value = Value
					Title_11.Text = cfslider.Name .. " : " .. tostring(Value)
					cfslider.Callback(Slider1.Value)
					TweenService:Create(
						SliderDraggable_2,
						TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Size = UDim2.fromScale((Value - cfslider.Min) / (cfslider.Max - cfslider.Min), 1)}
					):Play()
				end
				SliderFrame_2.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = true
					end
				end)
				uis.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = false
					end
				end)            
				uis.InputChanged:Connect(function(input)
					if dragging then
						local SizeScale = math.clamp((input.Position.X - SliderFrame_2.AbsolutePosition.X) / SliderFrame_2.AbsoluteSize.X, 0, 1)
						Slider1:Set(cfslider.Min + ((cfslider.Max - cfslider.Min) * SizeScale)) 
					end
				end)        
				Slider1:Set(tonumber(cfslider.Default))
				return Slider1
			end
			return ToggleFunc
		end
		function Fe:AddSlider(cf)
			cf = cf or {}
			cf.Name = cf.Name or "Slider"
			cf.Max = cf.Max or 100
			cf.Min = cf.Min or 0
			cf.Default = cf.Default or 50
			cf.Callback = cf.Callback or function() end

			local Slider = Instance.new("Frame")
			local UICorner_20 = Instance.new("UICorner")
			local Title_7 = Instance.new("TextLabel")
			local UIStroke_7 = Instance.new("UIStroke")
			local SliderFrame = Instance.new("Frame")
			local UICorner_21 = Instance.new("UICorner")
			local UIStroke_8 = Instance.new("UIStroke")
			local SliderDraggable = Instance.new("Frame")
			local UICorner_22 = Instance.new("UICorner")
			local Cricle_5 = Instance.new("Frame")
			local UICorner_23 = Instance.new("UICorner")
			local NumberValue = Instance.new("TextLabel")
			local SliderFunc = {Value = cf.Default}

			Slider.Name = "Slider"
			Slider.Parent = Channel
			Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Slider.BackgroundTransparency = 0.930
			Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Slider.BorderSizePixel = 0
			Slider.Size = UDim2.new(1, 0, 0, 45)

			UICorner_20.CornerRadius = UDim.new(0, 4)
			UICorner_20.Parent = Slider

			Title_7.Name = "Title"
			Title_7.Parent = Slider
			Title_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title_7.BackgroundTransparency = 1.000
			Title_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title_7.BorderSizePixel = 0
			Title_7.Position = UDim2.new(0, 7, 0, 4)
			Title_7.Size = UDim2.new(1, 0, 0, 15)
			Title_7.Font = Enum.Font.GothamBold
			Title_7.Text = cf.Name
			Title_7.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title_7.TextSize = 13.000
			Title_7.TextXAlignment = Enum.TextXAlignment.Left

			UIStroke_7.Parent = Slider
			UIStroke_7.Color = Color3.fromRGB(255, 255, 255)
			UIStroke_7.Transparency = 0.880
			UIStroke_7.Thickness = 1.040

			SliderFrame.Name = "SliderFrame"
			SliderFrame.Parent = Slider
			SliderFrame.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
			SliderFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SliderFrame.BorderSizePixel = 0
			SliderFrame.Position = UDim2.new(0, 7, 0, 25)
			SliderFrame.Size = UDim2.new(0, 344, 0, 6)

			UICorner_21.CornerRadius = UDim.new(0, 4)
			UICorner_21.Parent = SliderFrame

			UIStroke_8.Parent = SliderFrame
			UIStroke_8.Color = Color3.fromRGB(255, 255, 255)
			UIStroke_8.Transparency = 0.880
			UIStroke_8.Thickness = 1.040

			SliderDraggable.Name = "SliderDraggable"
			SliderDraggable.Parent = SliderFrame
			SliderDraggable.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SliderDraggable.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SliderDraggable.BorderSizePixel = 0
			SliderDraggable.Size = UDim2.new(0, 100, 1, 0)

			UICorner_22.CornerRadius = UDim.new(0, 4)
			UICorner_22.Parent = SliderDraggable

			Cricle_5.Name = "Cricle"
			Cricle_5.Parent = SliderDraggable
			Cricle_5.AnchorPoint = Vector2.new(1, 1)
			Cricle_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Cricle_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Cricle_5.BorderSizePixel = 0
			Cricle_5.Position = UDim2.new(1, 0, 0, 13)
			Cricle_5.Size = UDim2.new(0, 20, 0, 20)

			UICorner_23.CornerRadius = UDim.new(1, 0)
			UICorner_23.Parent = Cricle_5

			NumberValue.Name = "NumberValue"
			NumberValue.Parent = Slider
			NumberValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NumberValue.BackgroundTransparency = 1.000
			NumberValue.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NumberValue.BorderSizePixel = 0
			NumberValue.Position = UDim2.new(1, -50, 0, 4)
			NumberValue.Size = UDim2.new(0, 50, 0, 10)
			NumberValue.Font = Enum.Font.GothamBold
			NumberValue.Text = cf.Default
			NumberValue.TextColor3 = Color3.fromRGB(255, 255, 255)
			NumberValue.TextSize = 13.000

			local Dragging = false
			local function Round(Number, Factor)
				local Result = math.floor(Number/Factor + (math.sign(Number) * 0.5)) * Factor
				if Result < 0 then Result = Result + Factor end
				return Result
			end
			function SliderFunc:Set(Value)
				Value = math.clamp(Round(Value, 1), cf.Min, cf.Max)
				SliderFunc.Value = Value
				NumberValue.Text = tostring(Value)
				cf.Callback(SliderFunc.Value)
				TweenService:Create(
					SliderDraggable,
					TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{Size = UDim2.fromScale((Value - cf.Min) / (cf.Max - cf.Min), 1)}
				):Play()
			end
			SliderFrame.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
					Dragging = true
				end
			end)
			uis.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
					Dragging = false
				end
			end)            
			uis.InputChanged:Connect(function(input)
				if Dragging then
					local SizeScale = math.clamp((input.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 1)
					SliderFunc:Set(cf.Min + ((cf.Max - cf.Min) * SizeScale)) 
				end
			end)            
			NumberValue:GetPropertyChangedSignal("Text"):Connect(function()
				local Valid = NumberValue.Text:gsub("[^%d]", "")
				if Valid ~= "" then
					local ValidNumber = math.min(tonumber(Valid), cf.Max)
					NumberValue.Text = tostring(ValidNumber)
				else
					NumberValue.Text = tostring(Valid)
				end
			end)
			SliderFunc:Set(tonumber(cf.Default))
			return SliderFunc
		end
		function Fe:AddDropdown(cf)
			cf = cf or {}
			cf.Name = cf.Name or "Dropdown"
			cf.Description = cf.Description or ""
			cf.Options = cf.Options or {}
			cf.Default = cf.Default or ""
			cf.Callback = cf.Callback or function() end

			local Dropdown = Instance.new("Frame")
			local UICorner_14 = Instance.new("UICorner")
			local Title_4 = Instance.new("TextLabel")
			local Description_3 = Instance.new("TextLabel")
			local UIStroke_5 = Instance.new("UIStroke")
			local Icon_3 = Instance.new("ImageLabel")
			local Clicked_4 = Instance.new("TextButton")
			local ListFrame = Instance.new("Frame")
			local UICorner_15 = Instance.new("UICorner")
			local UIStroke_6 = Instance.new("UIStroke")
			local Listed = Instance.new("ScrollingFrame")
			local UIListLayout_3 = Instance.new("UIListLayout")
			local UIPadding_3 = Instance.new("UIPadding")
			local DropFunc = {}

			Dropdown.Name = "Dropdown"
			Dropdown.Parent = Channel
			Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Dropdown.BackgroundTransparency = 0.930
			Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Dropdown.BorderSizePixel = 0
			Dropdown.ClipsDescendants = true
			Dropdown.Size = UDim2.new(1, 0, 0, 45)

			UICorner_14.CornerRadius = UDim.new(0, 4)
			UICorner_14.Parent = Dropdown

			Title_4.Name = "Title"
			Title_4.Parent = Dropdown
			Title_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title_4.BackgroundTransparency = 1.000
			Title_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title_4.BorderSizePixel = 0
			Title_4.Position = UDim2.new(0, 7, 0, 4)
			Title_4.Size = UDim2.new(1, 0, 0, 15)
			Title_4.Font = Enum.Font.GothamBold
			Title_4.Text = cf.Name .. " : " .. cf.Default
			Title_4.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title_4.TextSize = 13.000
			Title_4.TextXAlignment = Enum.TextXAlignment.Left

			Description_3.Name = "Description"
			Description_3.Parent = Dropdown
			Description_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Description_3.BackgroundTransparency = 1.000
			Description_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Description_3.BorderSizePixel = 0
			Description_3.Position = UDim2.new(0, 7, 0, 19)
			Description_3.Size = UDim2.new(1, -40, 0, 26)
			Description_3.Font = Enum.Font.GothamBold
			Description_3.Text = cf.Description
			Description_3.TextColor3 = Color3.fromRGB(144, 144, 144)
			Description_3.TextSize = 12.000
			Description_3.TextXAlignment = Enum.TextXAlignment.Left
			Description_3.TextYAlignment = Enum.TextYAlignment.Top

			UIStroke_5.Parent = Dropdown
			UIStroke_5.Color = Color3.fromRGB(255, 255, 255)
			UIStroke_5.Transparency = 0.880
			UIStroke_5.Thickness = 1.040

			Icon_3.Name = "Icon"
			Icon_3.Parent = Dropdown
			Icon_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Icon_3.BackgroundTransparency = 1.000
			Icon_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Icon_3.BorderSizePixel = 0
			Icon_3.Position = UDim2.new(1, -35, 0, 14)
			Icon_3.Rotation = 90.000
			Icon_3.Size = UDim2.new(0, 18, 0, 18)
			Icon_3.Image = "http://www.roblox.com/asset/?id=136546491054534"

			Clicked_4.Name = "Clicked"
			Clicked_4.Parent = Dropdown
			Clicked_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Clicked_4.BackgroundTransparency = 1.000
			Clicked_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Clicked_4.BorderSizePixel = 0
			Clicked_4.Size = UDim2.new(1, 0, 0, 45)
			Clicked_4.Font = Enum.Font.SourceSans
			Clicked_4.Text = ""
			Clicked_4.TextColor3 = Color3.fromRGB(0, 0, 0)
			Clicked_4.TextSize = 14.000

			ListFrame.Name = "ListFrame"
			ListFrame.Parent = Dropdown
			ListFrame.BackgroundColor3 = Color3.fromRGB(7, 7, 7)
			ListFrame.BackgroundTransparency = 0.300
			ListFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ListFrame.BorderSizePixel = 0
			ListFrame.Position = UDim2.new(0, 10, 0, 50)
			ListFrame.Size = UDim2.new(0, 338, 0, 90)

			UICorner_15.CornerRadius = UDim.new(0, 4)
			UICorner_15.Parent = ListFrame

			UIStroke_6.Parent = ListFrame
			UIStroke_6.Color = Color3.fromRGB(255, 255, 255)
			UIStroke_6.Transparency = 0.880
			UIStroke_6.Thickness = 1.040

			Listed.Name = "Listed"
			Listed.Parent = ListFrame
			Listed.AnchorPoint = Vector2.new(0.5, 0.5)
			Listed.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Listed.BackgroundTransparency = 1.000
			Listed.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Listed.BorderSizePixel = 0
			Listed.Position = UDim2.new(0.5, 0, 0.5, 0)
			Listed.Size = UDim2.new(1, -10, 1, -10)
			Listed.ScrollBarThickness = 0

			UIListLayout_3.Parent = Listed
			UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_3.Padding = UDim.new(0, 9)

			UIPadding_3.Parent = Listed
			UIPadding_3.PaddingBottom = UDim.new(0, 2)
			UIPadding_3.PaddingLeft = UDim.new(0, 2)
			UIPadding_3.PaddingRight = UDim.new(0, 2)
			UIPadding_3.PaddingTop = UDim.new(0, 7)

			game:GetService("RunService").Stepped:Connect(function ()
				Listed.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_3.AbsoluteContentSize.Y + 20)
			end)

			Clicked_4.Activated:Connect(function()
				CircleClick(Clicked_4, Mouse.X, Mouse.Y)
				if Dropdown.Size.Y.Offset <= 45 then
					Dropdown:TweenSize(UDim2.new(1, 0, 0, 145),"Out","Quad",0.3,true)
					TweenService:Create(Icon_3, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Rotation = 0}):Play()
				else
					Dropdown:TweenSize(UDim2.new(1, 0, 0, 45),"Out","Quad",0.3,true)
					TweenService:Create(Icon_3, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Rotation = 90.000}):Play()
				end
			end)

			function DropFunc:Add(Value)
				for _, v in next, Value do
					local Options_2 = Instance.new("Frame")
					local UICorner_18 = Instance.new("UICorner")
					local Title_6 = Instance.new("TextLabel")
					local Clicked_6 = Instance.new("TextButton")
					local Cricle_4 = Instance.new("Frame")
					local UICorner_19 = Instance.new("UICorner")

					Options_2.Name = "Options"
					Options_2.Parent = Listed
					Options_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Options_2.BackgroundTransparency = 1.000
					Options_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Options_2.BorderSizePixel = 0
					Options_2.ClipsDescendants = true
					Options_2.Size = UDim2.new(1, 0, 0, 25)

					UICorner_18.CornerRadius = UDim.new(0, 4)
					UICorner_18.Parent = Options_2

					Title_6.Name = "Title"
					Title_6.Parent = Options_2
					Title_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Title_6.BackgroundTransparency = 1.000
					Title_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Title_6.BorderSizePixel = 0
					Title_6.Size = UDim2.new(1, 0, 1, 0)
					Title_6.Font = Enum.Font.GothamBold
					Title_6.Text = tostring(v)
					Title_6.TextColor3 = Color3.fromRGB(177, 177, 177)
					Title_6.TextSize = 14.000

					Clicked_6.Name = "Clicked"
					Clicked_6.Parent = Options_2
					Clicked_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Clicked_6.BackgroundTransparency = 1.000
					Clicked_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Clicked_6.BorderSizePixel = 0
					Clicked_6.Size = UDim2.new(1, 0, 1, 0)
					Clicked_6.Font = Enum.Font.SourceSans
					Clicked_6.Text = ""
					Clicked_6.TextColor3 = Color3.fromRGB(0, 0, 0)
					Clicked_6.TextSize = 14.000

					Cricle_4.Name = "Cricle"
					Cricle_4.Parent = Options_2
					Cricle_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Cricle_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Cricle_4.BorderSizePixel = 0
					Cricle_4.Position = UDim2.new(0, -7, 0, 1)
					Cricle_4.Size = UDim2.new(0, 6, 0, 23)

					UICorner_19.CornerRadius = UDim.new(0, 4)
					UICorner_19.Parent = Cricle_4

					Clicked_6.MouseButton1Click:Connect(function()
						for r, a in next, Listed:GetChildren() do
							if a.Name == "Options" then
								a.BackgroundTransparency = 1.000
							end
						end
						for r, a in next, Listed:GetChildren() do
							if a.Name == "Options" then
								a.Title.TextColor3 = Color3.fromRGB(177, 177, 177)
							end
						end
						for r, a in next, Listed:GetChildren() do
							if a.Name == "Options" then
								TweenService:Create(a.Cricle, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Position = UDim2.new(0, -7, 0, 1)}):Play()
							end
						end
						TweenService:Create(Cricle_2, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Position = UDim2.new(0, -0, 0, 1)}):Play()
						Title_6.TextColor3 = Color3.fromRGB(255, 255, 255)
						Options_2.BackgroundTransparency = 0.400
						cf.Callback(Title_6.Text)
						Title_4.Text = cf.Name .. " : " .. Title_6.Text
					end)
				end
			end

			function DropFunc:Set(acc)
				for i, v in pairs(Listed:GetChildren()) do
					if v.Name == "Options" then
						if v.Title.Text == acc then
							for r, a in next, Listed:GetChildren() do
								if a.Name == "Options" then
									a.BackgroundTransparency = 1.000
								end
							end
							for r, a in next, Listed:GetChildren() do
								if a.Name == "Options" then
									a.Title.TextColor3 = Color3.fromRGB(177, 177, 177)
								end
							end
							for r, a in next, Listed:GetChildren() do
								if a.Name == "Options" then
									TweenService:Create(a.Cricle, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Position = UDim2.new(0, -7, 0, 1)}):Play()
								end
							end
							v.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
							v.BackgroundTransparency = 0.930
							Title_4.Text = cf.Name .. " : " .. v.Title.Text
							cf.Callback(v.Title.Text)
						end
					end
				end
			end

			function DropFunc:Refresh(Options)
				for i, v in pairs(Listed:GetChildren()) do
					if v.Name == "Options" then
						v:Destroy()
					end
				end
				DropFunc:Add(Options)
				Title_4.Text = cf.Name .. " : "
			end
			DropFunc:Refresh(cf.Options)
			DropFunc:Set(cf.Default)
			cf.Callback(cf.Default)
			return DropFunc
		end
		function Fe:AddParagraph(cf)
			cf = cf or {}
			cf.Name = cf.Name or "Paragraph"
			cf.Description = cf.Description or ""

			local Paragraph = Instance.new("Frame")
			local UICorner_24 = Instance.new("UICorner")
			local Title_8 = Instance.new("TextLabel")
			local Description_4 = Instance.new("TextLabel")
			local UIStroke_9 = Instance.new("UIStroke")
			local ParaFunc = {}

			Paragraph.Name = "Paragraph"
			Paragraph.Parent = Channel
			Paragraph.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Paragraph.BackgroundTransparency = 0.930
			Paragraph.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Paragraph.BorderSizePixel = 0
			Paragraph.Size = UDim2.new(1, 0, 0, 45)

			UICorner_24.CornerRadius = UDim.new(0, 4)
			UICorner_24.Parent = Paragraph

			Title_8.Name = "Title"
			Title_8.Parent = Paragraph
			Title_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title_8.BackgroundTransparency = 1.000
			Title_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title_8.BorderSizePixel = 0
			Title_8.Position = UDim2.new(0, 7, 0, 4)
			Title_8.Size = UDim2.new(1, 0, 0, 15)
			Title_8.Font = Enum.Font.GothamBold
			Title_8.Text = cf.Name
			Title_8.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title_8.TextSize = 13.000
			Title_8.TextXAlignment = Enum.TextXAlignment.Left

			Description_4.Name = "Description"
			Description_4.Parent = Paragraph
			Description_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Description_4.BackgroundTransparency = 1.000
			Description_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Description_4.BorderSizePixel = 0
			Description_4.Position = UDim2.new(0, 7, 0, 19)
			Description_4.Size = UDim2.new(1, -40, 0, 26)
			Description_4.Font = Enum.Font.GothamBold
			Description_4.Text = cf.Description
			Description_4.TextColor3 = Color3.fromRGB(144, 144, 144)
			Description_4.TextSize = 12.000
			Description_4.TextXAlignment = Enum.TextXAlignment.Left
			Description_4.TextYAlignment = Enum.TextYAlignment.Top

			UIStroke_9.Parent = Paragraph
			UIStroke_9.Color = Color3.fromRGB(255, 255, 255)
			UIStroke_9.Transparency = 0.880
			UIStroke_9.Thickness = 1.040

			function ParaFunc:Set(cfSet)
				cfSet = cfSet or {}
				cfSet.Name = cfSet.Name
				cfSet.Description = cfSet.Description

				if cfSet.Name ~= "" and cfSet.Name ~= nil then
					Title_8.Text = cfSet.Name
				end
				if cfSet.Description ~= "" and cfSet.Description ~= nil then
					Description_4.Text = cfSet.Name
				end
			end
			return ParaFunc
		end
		function Fe:AddInput(cf)
			cf = cf or {}
			cf.Name = cf.Name or "Input"
			cf.Description = cf.Description or "Description"
			cf.PlaceholderText = cf.PlaceholderText or "Input..."
			cf.Default = cf.Default or ""
			cf.Callback = cf.Callback or function() end

			local Input = Instance.new("Frame")
			local UICorner_25 = Instance.new("UICorner")
			local Title_9 = Instance.new("TextLabel")
			local Description_5 = Instance.new("TextLabel")
			local UIStroke_10 = Instance.new("UIStroke")
			local InptutFrame = Instance.new("Frame")
			local UICorner_26 = Instance.new("UICorner")
			local UIStroke_11 = Instance.new("UIStroke")
			local RealInput = Instance.new("TextBox")

			Input.Name = "Input"
			Input.Parent = Channel
			Input.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Input.BackgroundTransparency = 0.930
			Input.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Input.BorderSizePixel = 0
			Input.Size = UDim2.new(1, 0, 0, 45)

			UICorner_25.CornerRadius = UDim.new(0, 4)
			UICorner_25.Parent = Input

			Title_9.Name = "Title"
			Title_9.Parent = Input
			Title_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title_9.BackgroundTransparency = 1.000
			Title_9.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title_9.BorderSizePixel = 0
			Title_9.Position = UDim2.new(0, 7, 0, 4)
			Title_9.Size = UDim2.new(1, 0, 0, 15)
			Title_9.Font = Enum.Font.GothamBold
			Title_9.Text = cf.Name
			Title_9.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title_9.TextSize = 13.000
			Title_9.TextXAlignment = Enum.TextXAlignment.Left

			Description_5.Name = "Description"
			Description_5.Parent = Input
			Description_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Description_5.BackgroundTransparency = 1.000
			Description_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Description_5.BorderSizePixel = 0
			Description_5.Position = UDim2.new(0, 7, 0, 19)
			Description_5.Size = UDim2.new(1, -50, 0, 26)
			Description_5.Font = Enum.Font.GothamBold
			Description_5.Text = cf.Description
			Description_5.TextColor3 = Color3.fromRGB(144, 144, 144)
			Description_5.TextSize = 12.000
			Description_5.TextXAlignment = Enum.TextXAlignment.Left
			Description_5.TextYAlignment = Enum.TextYAlignment.Top

			UIStroke_10.Parent = Input
			UIStroke_10.Color = Color3.fromRGB(255, 255, 255)
			UIStroke_10.Transparency = 0.880
			UIStroke_10.Thickness = 1.040

			InptutFrame.Name = "InptutFrame"
			InptutFrame.Parent = Input
			InptutFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			InptutFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			InptutFrame.BorderSizePixel = 0
			InptutFrame.Position = UDim2.new(1, -90, 0, 10)
			InptutFrame.Size = UDim2.new(0, 85, 0, 22)

			UICorner_26.CornerRadius = UDim.new(0, 4)
			UICorner_26.Parent = InptutFrame

			UIStroke_11.Parent = InptutFrame
			UIStroke_11.Color = Color3.fromRGB(255, 255, 255)
			UIStroke_11.Transparency = 0.880
			UIStroke_11.Thickness = 1.040

			RealInput.Name = "Real Input"
			RealInput.Parent = InptutFrame
			RealInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			RealInput.BackgroundTransparency = 1.000
			RealInput.BorderColor3 = Color3.fromRGB(0, 0, 0)
			RealInput.BorderSizePixel = 0
			RealInput.ClipsDescendants = true
			RealInput.Size = UDim2.new(1, 0, 1, 0)
			RealInput.Font = Enum.Font.GothamBold
			RealInput.PlaceholderColor3 = Color3.fromRGB(144, 144, 144)
			RealInput.PlaceholderText = cf.PlaceholderText
			RealInput.Text = cf.Default
			RealInput.TextColor3 = Color3.fromRGB(255, 255, 255)
			RealInput.TextSize = 13.000
			RealInput.TextWrapped = true
			RealInput.FocusLost:Connect(function()
				cf.Callback(RealInput.Text)
			end)
		end
		return Fe
	end
	return TabFunc
end
return Library
