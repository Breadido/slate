local thethingy = {
	DraggingSpeed = 0.15
}
function DraggingEnabled(frame, parent)
	parent = parent or frame

	local gui = parent
	local dragging
	local dragInput
	local dragStart
	local startPos

	local function update(input)
		local delta = input.Position - dragStart
		game:GetService("TweenService"):Create(gui,TweenInfo.new(thethingy.DraggingSpeed), {
			Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		}):Play()
		--gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end

	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

function ResizeEnabled(frame, parent)
	parent = parent or frame

	local gui = parent
	local dragging
	local dragInput
	local dragStart
	local startSize

	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startSize = gui.Size

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			local newWidth = math.clamp(startSize.X.Offset + delta.X, 565, 900)
			local newHeight = math.clamp(startSize.Y.Offset + delta.Y, 360, 800)
			gui.Size = UDim2.new(0, newWidth, 0, newHeight)
		end
	end)
end

local TweenService = game:GetService("TweenService")
local notifications = {}
local notificationSpacing = 8
local baseHeight = 60
thethingy.CreateNotification = (function(title, message, duration)
	local ScreenGui = Instance.new("ScreenGui")
	local Frame = Instance.new("Frame")
	local Frame_2 = Instance.new("Frame")
	local Corner = Instance.new("UICorner")
	local Stroke = Instance.new("UIStroke")
	local Title = Instance.new("TextLabel")
	local Desc = Instance.new("TextLabel")
	local Close = Instance.new("ImageButton")
	local shadowHolder = Instance.new("Frame")
	local umbraShadow = Instance.new("ImageLabel")
	local penumbraShadow = Instance.new("ImageLabel")
	local ambientShadow = Instance.new("ImageLabel")

	ScreenGui.Parent = game.CoreGui
	ScreenGui.Enabled = true
	ScreenGui.ResetOnSpawn = false

	local TempLabel = Instance.new("TextLabel")
	TempLabel.Font = Enum.Font.SourceSans
	TempLabel.TextSize = 16
	TempLabel.Text = message
	TempLabel.Visible = false
	TempLabel.Parent = ScreenGui

	local textWidth = math.max(TempLabel.TextBounds.X, 100) -- Minimum width
	local notificationWidth = textWidth + 32 -- Add padding
	TempLabel:Destroy()

	Frame.Parent = ScreenGui
	Frame.AnchorPoint = Vector2.new(1, 1)
	Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	Frame.BackgroundTransparency = 1.000
	Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame.BorderSizePixel = 0
	Frame.Position = UDim2.new(1, -10, 1, -10)
	Frame.Size = UDim2.new(0, notificationWidth, 0, baseHeight)

	Frame_2.Parent = Frame
	Frame_2.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame_2.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	Frame_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame_2.BorderSizePixel = 0
	Frame_2.Position = UDim2.new(0.5, 0, 0.5, 0)
	Frame_2.Size = UDim2.new(1, -7, 1, -7)

	Corner.Name = "Corner"
	Corner.Parent = Frame_2

	Stroke.Name = "Stroke"
	Stroke.Parent = Frame_2
	Stroke.Color = Color3.fromRGB(70, 68, 70)
	Stroke.Thickness = 1.200

	Title.Name = "Title"
	Title.Parent = Frame_2
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Title.BorderSizePixel = 0
	Title.Position = UDim2.new(0, 10, 0, 5)
	Title.Size = UDim2.new(1, -5, 0, 25)
	Title.Font = Enum.Font.SourceSansSemibold
	Title.Text = title
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 16.000
	Title.TextXAlignment = Enum.TextXAlignment.Left

	Desc.Name = "Desc"
	Desc.Parent = Frame_2
	Desc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Desc.BackgroundTransparency = 1.000
	Desc.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Desc.BorderSizePixel = 0
	Desc.Position = UDim2.new(0, 10, 0, 30)
	Desc.Size = UDim2.new(1, -15, 1, -30)
	Desc.Font = Enum.Font.SourceSans
	Desc.Text = message
	Desc.TextColor3 = Color3.fromRGB(170, 170, 170)
	Desc.TextSize = 16.000
	Desc.TextXAlignment = Enum.TextXAlignment.Left
	Desc.TextYAlignment = Enum.TextYAlignment.Top

	Close.Name = "Close"
	Close.Parent = Frame_2
	Close.AnchorPoint = Vector2.new(1, 0)
	Close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Close.BackgroundTransparency = 1.000
	Close.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Close.BorderSizePixel = 0
	Close.Position = UDim2.new(1, -5, 0, 5)
	Close.Size = UDim2.new(0, 20, 0, 20)
	Close.Image = "rbxassetid://10747384394"
	
	-- i have no idea why shadow is not working but whatever

	shadowHolder.Name = "shadowHolder"
	shadowHolder.Parent = Frame
	shadowHolder.BackgroundTransparency = 1.000
	shadowHolder.Size = UDim2.new(1, 0, 1, 0)
	shadowHolder.ZIndex = 0

	umbraShadow.Name = "umbraShadow"
	umbraShadow.Parent = shadowHolder
	umbraShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	umbraShadow.BackgroundTransparency = 1.000
	umbraShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	umbraShadow.Size = UDim2.new(1, 2, 1, 2)
	umbraShadow.Visible = false
	umbraShadow.ZIndex = 0
	umbraShadow.Image = "rbxassetid://1316045217"
	umbraShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	umbraShadow.ImageTransparency = 0.560
	umbraShadow.ScaleType = Enum.ScaleType.Slice
	umbraShadow.SliceCenter = Rect.new(10, 10, 118, 118)

	penumbraShadow.Name = "penumbraShadow"
	penumbraShadow.Parent = shadowHolder
	penumbraShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	penumbraShadow.BackgroundTransparency = 1.000
	penumbraShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	penumbraShadow.Size = UDim2.new(1, 2, 1, 2)
	penumbraShadow.Visible = false
	penumbraShadow.ZIndex = 0
	penumbraShadow.Image = "rbxassetid://1316045217"
	penumbraShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	penumbraShadow.ImageTransparency = 0.580
	penumbraShadow.ScaleType = Enum.ScaleType.Slice
	penumbraShadow.SliceCenter = Rect.new(10, 10, 118, 118)

	ambientShadow.Name = "ambientShadow"
	ambientShadow.Parent = shadowHolder
	ambientShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	ambientShadow.BackgroundTransparency = 1.000
	ambientShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	ambientShadow.Size = UDim2.new(1, 2, 1, 2)
	ambientShadow.Visible = false
	ambientShadow.ZIndex = 0
	ambientShadow.Image = "rbxassetid://1316045217"
	ambientShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	ambientShadow.ImageTransparency = 0.500
	ambientShadow.ScaleType = Enum.ScaleType.Slice
	ambientShadow.SliceCenter = Rect.new(10, 10, 118, 118)
	
	local tweeninfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad)
	
	-- sorry but i had to use little bit of chatgpt for the notification because i don't really good at these type of stuff
	table.insert(notifications, Frame)
	for i,v in next, notifications do
		TweenService:Create(v, tweeninfo, {
			Position = UDim2.new(1, -10, 1, -((baseHeight + notificationSpacing) * i))
		}):Play()
	end
	Frame.Position = UDim2.new(1, notificationWidth, 1, -((baseHeight + notificationSpacing) * #notifications))
	TweenService:Create(Frame, tweeninfo, {
		Position = UDim2.new(1, -10, 1, -((baseHeight + notificationSpacing) * #notifications))
	}):Play()
	local close = (function()
		for i,v in next, notifications do
			if v == Frame then
				table.remove(notifications, i)
				break
			end
		end
		TweenService:Create(Frame, tweeninfo, {
			Position = UDim2.new(1, notificationWidth, Frame.Position.Y.Scale, Frame.Position.Y.Offset)
		}):Play()
		task.wait(0.25)
		ScreenGui:Destroy()
		for i,v in next, notifications do
			TweenService:Create(v, tweeninfo, {
				Position = UDim2.new(1, -10, 1, -((baseHeight + notificationSpacing) * i))
			}):Play()
		end
	end)
	Close.MouseButton1Click:Connect(close)
	task.delay(duration, close)

end)

thethingy.SetupUI = (function(c)
	c = c or {}
	c.TitleName = c.TitleName or "thethingy"
	c.GameName = c.GameName or "Unknown"
	c.Size = c.Size or UDim2.new(0, 565, 0, 360)
	c.DraggingSpeed = c.DraggingSpeed or 0.15
	c.MaximizeText = c.MaximizeText or c.TitleName or "Maximize"
	c.Color = c.Color or {}
	c.Color.GradientColor1 = c.Color.GradientColor1 or Color3.fromRGB(207, 207, 0)
	c.Color.GradientColor2 = c.Color.GradientColor2 or Color3.fromRGB(255, 170, 0)
	c.Discord = c.Discord or {}
	c.Discord.Name = c.Discord.Name or "dude"
	c.Discord.Image = c.Discord.Image or ""
	c.Discord.DiscordButtonCallback = c.Discord.DiscordButtonCallback or function() end

	local color1 = c.Color.GradientColor1
	local color2 = c.Color.GradientColor2
	
	local ScreenGui = Instance.new("ScreenGui")
	local ImageLabel = Instance.new("CanvasGroup")
	local Main = Instance.new("Frame")
	local MainCorner = Instance.new("UICorner")
	local Topbar = Instance.new("Frame")
	local TopbarCorner = Instance.new("UICorner")
	local TopbarCornerHider = Instance.new("Frame")
	local TopbarMenu = Instance.new("ImageLabel")
	local TopbarMenuTrigger = Instance.new("TextButton")
	local TopbarText1 = Instance.new("TextLabel")
	local TopbarText2 = Instance.new("TextLabel")
	local MainStroke = Instance.new("UIStroke")
	local Pagebar = Instance.new("Frame")
	local PagebarStroke = Instance.new("UIStroke")
	local PagebarCorner = Instance.new("UICorner")
	local PagebarSeperator = Instance.new("TextLabel")
	local PagebarLayout = Instance.new("UIListLayout")
	local PageShow = Instance.new("Frame")
	local PageshowCorner = Instance.new("UICorner")
	local PageshowStroke = Instance.new("UIStroke")
	local Menu = Instance.new("Frame")
	local MenuTime = Instance.new("TextLabel")
	local MenuCorner = Instance.new("UICorner")
	local MenuDate = Instance.new("TextLabel")
	local Session = Instance.new("Frame")
	local SessionCorner = Instance.new("UICorner")
	local SessionStroke = Instance.new("UIStroke")
	local SessionLayout = Instance.new("UIListLayout")
	local SessionText = Instance.new("TextLabel")
	local SessionScrolling = Instance.new("ScrollingFrame")
	local SessionScrollingCorner = Instance.new("UICorner")
	local SessionScrollingStroke = Instance.new("UIStroke")
	local SessionScrollingLayout = Instance.new("UIListLayout")
	local SessionScrollingText = Instance.new("TextLabel")
	local User = Instance.new("Frame")
	local UserCorner = Instance.new("UICorner")
	local UserStroke = Instance.new("UIStroke")
	local UserText1 = Instance.new("TextLabel")
	local UserAnonymous = Instance.new("ImageButton")
	local UserAnonymousCorner = Instance.new("UICorner")
	local UserAnonymousStroke = Instance.new("UIStroke")
	local UserText2 = Instance.new("TextLabel")
	local Discord = Instance.new("CanvasGroup")
	local DiscordCorner = Instance.new("UICorner")
	local DiscordStroke = Instance.new("UIStroke")
	local UserText1_2 = Instance.new("TextLabel")
	local UserText2_2 = Instance.new("TextLabel")
	local DiscordImage = Instance.new("ImageLabel")
	local DiscordDarken = Instance.new("Frame")
	local UserStroke_2 = Instance.new("UIStroke")
	local UserCorner_2 = Instance.new("UICorner")
	local DiscordButton = Instance.new("ImageButton")
	local BackButton = Instance.new("ImageButton")
	local Prefrences = Instance.new("Frame")
	local PrefrencesStroke = Instance.new("UIStroke")
	local PrefrencesCorner = Instance.new("UICorner")
	local PrefrencesList = Instance.new("ScrollingFrame")
	local SettingsListLayoutSeperator = Instance.new("Frame")
	local SettingsImage = Instance.new("ImageButton")
	local SettingsListCorner = Instance.new("UICorner")
	local SettingsListLayout = Instance.new("UIListLayout")
	local SettingsListStroke = Instance.new("UIStroke")
	local PrefrencesShow = Instance.new("Frame")
	local SettingsListStroke_2 = Instance.new("UIStroke")
	local SettingsListLayout_2 = Instance.new("UIListLayout")
	local SettingsListCorner_2 = Instance.new("UICorner")
	local PageLayoutSeperator_2 = Instance.new("Frame")
	local PrefrencesText = Instance.new("TextLabel")
	local Slider_2 = Instance.new("Frame")
	local SliderStroke_2 = Instance.new("UIStroke")
	local SliderCorner_2 = Instance.new("UICorner")
	local SliderText_2 = Instance.new("TextLabel")
	local ToggleCheckbox_3 = Instance.new("ImageButton")
	local ToggleCheckboxCheckmark_3 = Instance.new("ImageLabel")
	local SliderMain_2 = Instance.new("Frame")
	local SliderMainStroke_2 = Instance.new("UIStroke")
	local SliderMainCorner_2 = Instance.new("UICorner")
	local SliderMainFill_2 = Instance.new("Frame")
	local SliderMainFillCorner_2 = Instance.new("UICorner")
	local SliderMainFillGradient_2 = Instance.new("UIGradient")
	local SliderMainValue_2 = Instance.new("TextLabel")
	local SliderMainTrigger_2 = Instance.new("TextButton")
	local Keybind_2 = Instance.new("Frame")
	local KeybindStroke_3 = Instance.new("UIStroke")
	local KeybindCorner_3 = Instance.new("UICorner")
	local KeybindText_2 = Instance.new("TextLabel")
	local KeybindImage_2 = Instance.new("ImageButton")
	local KeybindTrigger_2 = Instance.new("TextButton")
	local KeybindStroke_4 = Instance.new("UIStroke")
	local KeybindCorner_4 = Instance.new("UICorner")
	local PrefrencesText_2 = Instance.new("TextLabel")
	local shadowHolder = Instance.new("Frame")
	local umbraShadow = Instance.new("ImageLabel")
	local penumbraShadow = Instance.new("ImageLabel")
	local ambientShadow = Instance.new("ImageLabel")
	local Maximizer = Instance.new("CanvasGroup")
	local MaximizerMain = Instance.new("TextButton")
	local MaximizerMainCorner = Instance.new("UICorner")
	local MaximizerMainStroke = Instance.new("UIStroke")
	local MaximizerMainThings = Instance.new("Frame")
	local MaximizerMainThingsImage = Instance.new("ImageButton")
	local MaximizerMainThingsLayout = Instance.new("UIListLayout")
	local MaximizerMainThingsText = Instance.new("TextLabel")
	local shadowHolder2 = Instance.new("Frame")
	local umbraShadow2 = Instance.new("ImageLabel")
	local penumbraShadow2 = Instance.new("ImageLabel")
	local ambientShadow2 = Instance.new("ImageLabel")
	
	ScreenGui.Parent = game.CoreGui
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	ImageLabel.Parent = ScreenGui
	ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel.BackgroundTransparency = 1.000
	ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ImageLabel.BorderSizePixel = 0
	ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	ImageLabel.Size = UDim2.new(0, 565, 0, 360)

	Main.Name = "Main"
	Main.Parent = ImageLabel
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Main.BorderSizePixel = 0
	Main.ClipsDescendants = true
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.Size = UDim2.new(1, -10, 1, -10)
	
	local ResizeHandle = Instance.new("ImageButton")
	ResizeHandle.Size = UDim2.new(0, 12, 0, 12)
	ResizeHandle.Position = UDim2.new(1, -5, 1, -5)
	ResizeHandle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	ResizeHandle.BackgroundTransparency = 1
	ResizeHandle.BorderSizePixel = 0
	ResizeHandle.AnchorPoint = Vector2.new(1, 1)
	ResizeHandle.Name = "ResizeHandle"
	ResizeHandle.ZIndex = 2
	ResizeHandle.Parent = ImageLabel
	ResizeHandle.Image = "rbxassetid://10734940825"
	ResizeHandle.Rotation = 90
	ResizeEnabled(ResizeHandle, ImageLabel)

	MainCorner.Name = "MainCorner"
	MainCorner.Parent = Main

	Topbar.Name = "Topbar"
	Topbar.Parent = Main
	Topbar.BackgroundColor3 = Color3.fromRGB(31, 30, 31)
	Topbar.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Topbar.BorderSizePixel = 0
	Topbar.Size = UDim2.new(1, 0, 0, 35)
	
	DraggingEnabled(Topbar, ImageLabel)

	TopbarCorner.Name = "TopbarCorner"
	TopbarCorner.Parent = Topbar

	TopbarCornerHider.Name = "TopbarCornerHider"
	TopbarCornerHider.Parent = Topbar
	TopbarCornerHider.BackgroundColor3 = Color3.fromRGB(31, 30, 31)
	TopbarCornerHider.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TopbarCornerHider.BorderSizePixel = 0
	TopbarCornerHider.Position = UDim2.new(0, 0, 0.828571439, 0)
	TopbarCornerHider.Size = UDim2.new(1, 0, 0, 6)

	TopbarMenu.Name = "TopbarMenu"
	TopbarMenu.Parent = Topbar
	TopbarMenu.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TopbarMenu.BackgroundTransparency = 1.000
	TopbarMenu.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TopbarMenu.BorderSizePixel = 0
	TopbarMenu.Position = UDim2.new(0, 12, 0.150000006, 0)
	TopbarMenu.Size = UDim2.new(0, 25, 0, 25)
	TopbarMenu.Image = "rbxassetid://10723433811"

	TopbarMenuTrigger.Name = "TopbarMenuTrigger"
	TopbarMenuTrigger.Parent = TopbarMenu
	TopbarMenuTrigger.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TopbarMenuTrigger.BackgroundTransparency = 1.000
	TopbarMenuTrigger.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TopbarMenuTrigger.BorderSizePixel = 0
	TopbarMenuTrigger.Size = UDim2.new(1, 0, 1, 0)
	TopbarMenuTrigger.Font = Enum.Font.SourceSans
	TopbarMenuTrigger.Text = ""
	TopbarMenuTrigger.TextColor3 = Color3.fromRGB(0, 0, 0)
	TopbarMenuTrigger.TextSize = 14.000

	TopbarText1.Name = "TopbarText1"
	TopbarText1.Parent = Topbar
	TopbarText1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TopbarText1.BackgroundTransparency = 1.000
	TopbarText1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TopbarText1.BorderSizePixel = 0
	TopbarText1.Position = UDim2.new(0, 44, 0, 0)
	TopbarText1.Size = UDim2.new(0, 200, 0, 18)
	TopbarText1.Font = Enum.Font.SourceSansSemibold
	TopbarText1.Text = c.TitleName
	TopbarText1.TextColor3 = Color3.fromRGB(200, 200, 200)
	TopbarText1.TextSize = 15.000
	TopbarText1.TextXAlignment = Enum.TextXAlignment.Left
	TopbarText1.TextYAlignment = Enum.TextYAlignment.Bottom

	TopbarText2.Name = "TopbarText2"
	TopbarText2.Parent = Topbar
	TopbarText2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TopbarText2.BackgroundTransparency = 1.000
	TopbarText2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TopbarText2.BorderSizePixel = 0
	TopbarText2.Position = UDim2.new(0, 44, 0.400000006, 0)
	TopbarText2.Size = UDim2.new(0, 200, 0, 18)
	TopbarText2.Font = Enum.Font.SourceSans
	TopbarText2.Text = c.GameName
	TopbarText2.TextColor3 = Color3.fromRGB(136, 136, 136)
	TopbarText2.TextSize = 14.000
	TopbarText2.TextXAlignment = Enum.TextXAlignment.Left

	local TopbarMinimize = Instance.new("ImageButton")
	TopbarMinimize.Name = "TopbarMinimize"
	TopbarMinimize.Parent = Topbar
	TopbarMinimize.AnchorPoint = Vector2.new(1, 0.5)
	TopbarMinimize.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TopbarMinimize.BackgroundTransparency = 1.000
	TopbarMinimize.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TopbarMinimize.BorderSizePixel = 0
	TopbarMinimize.Position = UDim2.new(1, -10, 0.5, 0)
	TopbarMinimize.Size = UDim2.new(0, 20, 0, 20)
	TopbarMinimize.Image = "rbxassetid://10734895530"
	TopbarMinimize.ImageColor3 = Color3.fromRGB(201, 201, 201)

	MainStroke.Name = "MainStroke"
	MainStroke.Parent = Main
	MainStroke.Color = Color3.fromRGB(70, 68, 70)
	MainStroke.Thickness = 1.200

	Pagebar.Name = "Pagebar"
	Pagebar.Parent = Main
	Pagebar.BackgroundColor3 = Color3.fromRGB(31, 30, 31)
	Pagebar.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Pagebar.BorderSizePixel = 0
	Pagebar.Position = UDim2.new(0, 10, 0, 45)
	Pagebar.Size = UDim2.new(0, 155, 1, -58)

	PagebarStroke.Name = "PagebarStroke"
	PagebarStroke.Parent = Pagebar
	PagebarStroke.Color = Color3.fromRGB(48, 47, 48)
	PagebarStroke.Thickness = 1.200

	PagebarCorner.CornerRadius = UDim.new(0, 6)
	PagebarCorner.Name = "PagebarCorner"
	PagebarCorner.Parent = Pagebar

	PagebarSeperator.Name = "PagebarSeperator"
	PagebarSeperator.Parent = Pagebar
	PagebarSeperator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	PagebarSeperator.BackgroundTransparency = 1.000
	PagebarSeperator.BorderColor3 = Color3.fromRGB(0, 0, 0)
	PagebarSeperator.BorderSizePixel = 0
	PagebarSeperator.Size = UDim2.new(1, 0, 0, 3)
	PagebarSeperator.Font = Enum.Font.SourceSans
	PagebarSeperator.Text = ""
	PagebarSeperator.TextColor3 = Color3.fromRGB(0, 0, 0)
	PagebarSeperator.TextSize = 14.000

	PagebarLayout.Name = "PagebarLayout"
	PagebarLayout.Parent = Pagebar
	PagebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
	
	PageShow.Name = "PageShow"
	PageShow.Parent = Main
	PageShow.AnchorPoint = Vector2.new(1, 0)
	PageShow.BackgroundColor3 = Color3.fromRGB(31, 30, 31)
	PageShow.BorderColor3 = Color3.fromRGB(0, 0, 0)
	PageShow.BorderSizePixel = 0
	PageShow.Position = UDim2.new(1, -10, 0, 45)
	PageShow.Size = UDim2.new(1, -185, 1, -58)

	PageshowCorner.CornerRadius = UDim.new(0, 6)
	PageshowCorner.Name = "PageshowCorner"
	PageshowCorner.Parent = PageShow

	PageshowStroke.Name = "PageshowStroke"
	PageshowStroke.Parent = PageShow
	PageshowStroke.Color = Color3.fromRGB(48, 47, 48)
	PageshowStroke.Thickness = 1.200
	
	Menu.Name = "Menu"
	Menu.Parent = Main
	Menu.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Menu.BackgroundTransparency = 0.150
	Menu.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Menu.BorderSizePixel = 0
	Menu.Position = UDim2.new(0, 0, -1, 0)
	Menu.Size = UDim2.new(1, 0, 1, 0)

	MenuTime.Name = "MenuTime"
	MenuTime.Parent = Menu
	MenuTime.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MenuTime.BackgroundTransparency = 1.000
	MenuTime.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MenuTime.BorderSizePixel = 0
	MenuTime.Position = UDim2.new(0, 20, 0, 20)
	MenuTime.Size = UDim2.new(0, 100, 0, 40)
	MenuTime.Font = Enum.Font.GothamSemibold
	MenuTime.Text = "10:30"
	MenuTime.TextColor3 = Color3.fromRGB(255, 255, 255)
	MenuTime.TextSize = 35.000
	MenuTime.TextXAlignment = Enum.TextXAlignment.Left

	MenuCorner.Name = "MenuCorner"
	MenuCorner.Parent = Menu

	MenuDate.Name = "MenuDate"
	MenuDate.Parent = Menu
	MenuDate.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MenuDate.BackgroundTransparency = 1.000
	MenuDate.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MenuDate.BorderSizePixel = 0
	MenuDate.Position = UDim2.new(0, 22, 0, 55)
	MenuDate.Size = UDim2.new(0, 100, 0, 20)
	MenuDate.Font = Enum.Font.GothamMedium
	MenuDate.Text = "8/3/2025"
	MenuDate.TextColor3 = Color3.fromRGB(161, 161, 161)
	MenuDate.TextSize = 20.000
	MenuDate.TextXAlignment = Enum.TextXAlignment.Left
	MenuDate.TextYAlignment = Enum.TextYAlignment.Top
	
	task.spawn(function()
		while true do task.wait(.1)
			MenuDate.Text = os.date("%x")
			MenuTime.Text = os.date("%X")
		end
	end)
	
	Session.Name = "Session"
	Session.Parent = Menu
	Session.BackgroundColor3 = Color3.fromRGB(31, 30, 31)
	Session.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Session.BorderSizePixel = 0
	Session.Position = UDim2.new(0, 20, 0, 85)
	Session.Size = UDim2.new(0, 160, 1, -175)

	SessionCorner.Name = "SessionCorner"
	SessionCorner.Parent = Session

	SessionStroke.Name = "SessionStroke"
	SessionStroke.Parent = Session
	SessionStroke.Color = Color3.fromRGB(48, 47, 48)

	SessionLayout.Name = "SessionLayout"
	SessionLayout.Parent = Session
	SessionLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	SessionLayout.SortOrder = Enum.SortOrder.LayoutOrder
	SessionLayout.Padding = UDim.new(0, 5)

	SessionText.Name = "SessionText"
	SessionText.Parent = Session
	SessionText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SessionText.BackgroundTransparency = 1.000
	SessionText.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SessionText.BorderSizePixel = 0
	SessionText.Size = UDim2.new(1, 0, 0, 30)
	SessionText.Font = Enum.Font.SourceSansSemibold
	SessionText.Text = "   Session Info"
	SessionText.TextColor3 = Color3.fromRGB(255, 255, 255)
	SessionText.TextSize = 18.000
	SessionText.TextXAlignment = Enum.TextXAlignment.Left

	SessionScrolling.Name = "SessionScrolling"
	SessionScrolling.Parent = Session
	SessionScrolling.Active = true
	SessionScrolling.AnchorPoint = Vector2.new(0.5, 0.5)
	SessionScrolling.BackgroundColor3 = Color3.fromRGB(20, 19, 20)
	SessionScrolling.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SessionScrolling.BorderSizePixel = 0
	SessionScrolling.Size = UDim2.new(1, -10, 1, -40)
	SessionScrolling.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
	SessionScrolling.CanvasSize = UDim2.new(0, 0, 1, 0)
	SessionScrolling.ScrollBarThickness = 1

	SessionScrollingCorner.Name = "SessionScrollingCorner"
	SessionScrollingCorner.Parent = SessionScrolling

	SessionScrollingStroke.Name = "SessionScrollingStroke"
	SessionScrollingStroke.Parent = SessionScrolling
	SessionScrollingStroke.Color = Color3.fromRGB(48, 47, 48)

	SessionScrollingLayout.Name = "SessionScrollingLayout"
	SessionScrollingLayout.Parent = SessionScrolling
	SessionScrollingLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	SessionScrollingLayout.SortOrder = Enum.SortOrder.LayoutOrder
	SessionScrollingLayout.Padding = UDim.new(0, 5)

	SessionScrollingText.Name = "SessionScrollingText"
	SessionScrollingText.Parent = SessionScrolling
	SessionScrollingText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SessionScrollingText.BackgroundTransparency = 1.000
	SessionScrollingText.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SessionScrollingText.BorderSizePixel = 0
	SessionScrollingText.Size = UDim2.new(1, -10, 1, 0)
	SessionScrollingText.Visible = false
	SessionScrollingText.Font = Enum.Font.SourceSans
	SessionScrollingText.Text = "Money Made: math.huge"
	SessionScrollingText.TextColor3 = Color3.fromRGB(255, 255, 255)
	SessionScrollingText.TextSize = 14.000
	SessionScrollingText.TextWrapped = true
	SessionScrollingText.TextXAlignment = Enum.TextXAlignment.Left
	SessionScrollingText.TextYAlignment = Enum.TextYAlignment.Top

	User.Name = "User"
	User.Parent = Menu
	User.BackgroundColor3 = Color3.fromRGB(31, 30, 31)
	User.BorderColor3 = Color3.fromRGB(0, 0, 0)
	User.BorderSizePixel = 0
	User.Position = UDim2.new(0, 20, 1, -80)
	User.Size = UDim2.new(0, 160, 0, 70)

	UserCorner.Name = "UserCorner"
	UserCorner.Parent = User

	UserStroke.Name = "UserStroke"
	UserStroke.Parent = User
	UserStroke.Color = Color3.fromRGB(48, 47, 48)

	UserText1.Name = "UserText1"
	UserText1.Parent = User
	UserText1.AnchorPoint = Vector2.new(1, 0.5)
	UserText1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	UserText1.BackgroundTransparency = 1.000
	UserText1.BorderColor3 = Color3.fromRGB(0, 0, 0)
	UserText1.BorderSizePixel = 0
	UserText1.Position = UDim2.new(1, 0, 0.5, -10)
	UserText1.Size = UDim2.new(1, -50, 0, 30)
	UserText1.Font = Enum.Font.SourceSansSemibold
	UserText1.Text = "Anonymous"
	UserText1.TextColor3 = Color3.fromRGB(255, 255, 255)
	UserText1.TextSize = 18.000
	UserText1.TextXAlignment = Enum.TextXAlignment.Left

	UserAnonymous.Name = "UserAnonymous"
	UserAnonymous.Parent = User
	UserAnonymous.AnchorPoint = Vector2.new(0, 0.5)
	UserAnonymous.BackgroundColor3 = Color3.fromRGB(20, 19, 20)
	UserAnonymous.BackgroundTransparency = 1.000
	UserAnonymous.BorderColor3 = Color3.fromRGB(0, 0, 0)
	UserAnonymous.BorderSizePixel = 0
	UserAnonymous.Position = UDim2.new(0, 5, 0.5, 0)
	UserAnonymous.Size = UDim2.new(0, 40, 0, 40)
	UserAnonymous.AutoButtonColor = false
	UserAnonymous.Image = "rbxassetid://10747373176"

	UserAnonymousCorner.Name = "UserAnonymousCorner"
	UserAnonymousCorner.Parent = UserAnonymous

	UserAnonymousStroke.Name = "UserAnonymousStroke"
	UserAnonymousStroke.Parent = UserAnonymous
	UserAnonymousStroke.Color = Color3.fromRGB(48, 47, 48)
	UserAnonymousStroke.Transparency = 1.000

	UserText2.Name = "UserText2"
	UserText2.Parent = User
	UserText2.AnchorPoint = Vector2.new(1, 0.5)
	UserText2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	UserText2.BackgroundTransparency = 1.000
	UserText2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	UserText2.BorderSizePixel = 0
	UserText2.Position = UDim2.new(1, 0, 0.5, 10)
	UserText2.Size = UDim2.new(1, -50, 0, 30)
	UserText2.Font = Enum.Font.SourceSans
	UserText2.Text = "who are you?"
	UserText2.TextColor3 = Color3.fromRGB(255, 255, 255)
	UserText2.TextSize = 14.000
	UserText2.TextWrapped = true
	UserText2.TextXAlignment = Enum.TextXAlignment.Left
	UserText2.TextYAlignment = Enum.TextYAlignment.Top

	Discord.Name = "Discord"
	Discord.Parent = Menu
	Discord.BackgroundColor3 = Color3.fromRGB(31, 30, 31)
	Discord.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Discord.BorderSizePixel = 0
	Discord.ClipsDescendants = true
	Discord.Position = UDim2.new(0, 190, 1, -80)
	Discord.Size = UDim2.new(0, 160, 0, 70)

	DiscordCorner.Name = "DiscordCorner"
	DiscordCorner.Parent = Discord

	DiscordStroke.Name = "DiscordStroke"
	DiscordStroke.Parent = Discord
	DiscordStroke.Color = Color3.fromRGB(48, 47, 48)

	UserText1_2.Name = "UserText1"
	UserText1_2.Parent = Discord
	UserText1_2.AnchorPoint = Vector2.new(0, 0.5)
	UserText1_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	UserText1_2.BackgroundTransparency = 1.000
	UserText1_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	UserText1_2.BorderSizePixel = 0
	UserText1_2.Position = UDim2.new(0, 10, 0.5, -20)
	UserText1_2.Size = UDim2.new(1, -50, 0, 20)
	UserText1_2.ZIndex = 2
	UserText1_2.Font = Enum.Font.SourceSansSemibold
	UserText1_2.Text = c.Discord.Name
	UserText1_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	UserText1_2.TextSize = 18.000
	UserText1_2.TextXAlignment = Enum.TextXAlignment.Left

	UserText2_2.Name = "UserText2"
	UserText2_2.Parent = Discord
	UserText2_2.AnchorPoint = Vector2.new(1, 0.5)
	UserText2_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	UserText2_2.BackgroundTransparency = 1.000
	UserText2_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	UserText2_2.BorderSizePixel = 0
	UserText2_2.Position = UDim2.new(1, 0, 0.5, 10)
	UserText2_2.Size = UDim2.new(1, -50, 0, 30)
	UserText2_2.Visible = false
	UserText2_2.Font = Enum.Font.SourceSans
	UserText2_2.Text = "who are you?"
	UserText2_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	UserText2_2.TextSize = 14.000
	UserText2_2.TextWrapped = true
	UserText2_2.TextXAlignment = Enum.TextXAlignment.Left
	UserText2_2.TextYAlignment = Enum.TextYAlignment.Top

	DiscordImage.Name = "DiscordImage"
	DiscordImage.Parent = Discord
	DiscordImage.AnchorPoint = Vector2.new(0.5, 0.5)
	DiscordImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	DiscordImage.BackgroundTransparency = 1
	DiscordImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
	DiscordImage.BorderSizePixel = 0
	DiscordImage.Position = UDim2.new(0.5, 0, 0.5, 0)
	DiscordImage.Size = UDim2.new(0, 170, 0, 150)
	DiscordImage.ZIndex = -1
	DiscordImage.Image = c.Discord.Image
	

	DiscordDarken.Name = "DiscordDarken"
	DiscordDarken.Parent = Discord
	DiscordDarken.AnchorPoint = Vector2.new(0.5, 0.5)
	DiscordDarken.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	DiscordDarken.BackgroundTransparency = 0.300
	DiscordDarken.BorderColor3 = Color3.fromRGB(0, 0, 0)
	DiscordDarken.BorderSizePixel = 0
	DiscordDarken.Position = UDim2.new(0.5, 0, 0.5, 0)
	DiscordDarken.Size = UDim2.new(1, 4, 1, 4)

	UserStroke_2.Name = "UserStroke"
	UserStroke_2.Parent = DiscordDarken
	UserStroke_2.Color = Color3.fromRGB(48, 47, 48)

	UserCorner_2.Name = "UserCorner"
	UserCorner_2.Parent = DiscordDarken

	DiscordButton.Name = "DiscordButton"
	DiscordButton.Parent = Discord
	DiscordButton.AnchorPoint = Vector2.new(1, 0)
	DiscordButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	DiscordButton.BackgroundTransparency = 1.000
	DiscordButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	DiscordButton.BorderSizePixel = 0
	DiscordButton.Position = UDim2.new(1, -5, 0, 5)
	DiscordButton.Size = UDim2.new(0, 20, 0, 20)
	DiscordButton.AutoButtonColor = false
	DiscordButton.Image = "rbxassetid://16188837922"

	BackButton.Name = "BackButton"
	BackButton.Parent = Menu
	BackButton.AnchorPoint = Vector2.new(0.5, 0)
	BackButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BackButton.BackgroundTransparency = 1.000
	BackButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BackButton.BorderSizePixel = 0
	BackButton.Position = UDim2.new(0.5, 0, 0, 10)
	BackButton.Size = UDim2.new(0, 20, 0, 20)
	BackButton.Image = "rbxassetid://10723407389"

	Prefrences.Name = "Prefrences"
	Prefrences.Parent = Menu
	Prefrences.AnchorPoint = Vector2.new(1, 0)
	Prefrences.BackgroundColor3 = Color3.fromRGB(31, 30, 31)
	Prefrences.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Prefrences.BorderSizePixel = 0
	Prefrences.Position = UDim2.new(1, -20, 0, 85)
	Prefrences.Size = UDim2.new(1, -210, 1, -175)

	PrefrencesStroke.Name = "PrefrencesStroke"
	PrefrencesStroke.Parent = Prefrences
	PrefrencesStroke.Color = Color3.fromRGB(48, 47, 48)

	PrefrencesCorner.Name = "PrefrencesCorner"
	PrefrencesCorner.Parent = Prefrences

	PrefrencesList.Name = "PrefrencesList"
	PrefrencesList.Parent = Prefrences
	PrefrencesList.Active = true
	PrefrencesList.BackgroundColor3 = Color3.fromRGB(20, 19, 20)
	PrefrencesList.BorderColor3 = Color3.fromRGB(0, 0, 0)
	PrefrencesList.BorderSizePixel = 0
	PrefrencesList.Position = UDim2.new(0, 5, 0, 35)
	PrefrencesList.Size = UDim2.new(0, 30, 1, -40)
	PrefrencesList.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
	PrefrencesList.ScrollBarThickness = 0

	SettingsListLayoutSeperator.Name = "SettingsListLayoutSeperator"
	SettingsListLayoutSeperator.Parent = PrefrencesList
	SettingsListLayoutSeperator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SettingsListLayoutSeperator.BackgroundTransparency = 1.000
	SettingsListLayoutSeperator.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SettingsListLayoutSeperator.BorderSizePixel = 0
	SettingsListLayoutSeperator.Size = UDim2.new(1, 0, 0, 1)

	SettingsImage.Name = "SettingsImage"
	SettingsImage.Parent = PrefrencesList
	SettingsImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SettingsImage.BackgroundTransparency = 1.000
	SettingsImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SettingsImage.BorderSizePixel = 0
	SettingsImage.Size = UDim2.new(0, 20, 0, 20)
	SettingsImage.Image = "rbxassetid://10734950309"

	SettingsListCorner.Name = "SettingsListCorner"
	SettingsListCorner.Parent = PrefrencesList

	SettingsListLayout.Name = "SettingsListLayout"
	SettingsListLayout.Parent = PrefrencesList
	SettingsListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	SettingsListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	SettingsListLayout.Padding = UDim.new(0, 3)

	SettingsListStroke.Name = "SettingsListStroke"
	SettingsListStroke.Parent = PrefrencesList
	SettingsListStroke.Color = Color3.fromRGB(48, 47, 48)

	PrefrencesShow.Name = "PrefrencesShow"
	PrefrencesShow.Parent = Prefrences
	PrefrencesShow.BackgroundColor3 = Color3.fromRGB(20, 19, 20)
	PrefrencesShow.BorderColor3 = Color3.fromRGB(0, 0, 0)
	PrefrencesShow.BorderSizePixel = 0
	PrefrencesShow.Position = UDim2.new(0, 45, 0, 35)
	PrefrencesShow.Size = UDim2.new(1, -55, 1, -40)

	SettingsListStroke_2.Name = "SettingsListStroke"
	SettingsListStroke_2.Parent = PrefrencesShow
	SettingsListStroke_2.Color = Color3.fromRGB(48, 47, 48)

	SettingsListLayout_2.Name = "SettingsListLayout"
	SettingsListLayout_2.Parent = PrefrencesShow
	SettingsListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
	SettingsListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
	SettingsListLayout_2.Padding = UDim.new(0, 5)

	SettingsListCorner_2.Name = "SettingsListCorner"
	SettingsListCorner_2.Parent = PrefrencesShow

	PageLayoutSeperator_2.Name = "PageLayoutSeperator"
	PageLayoutSeperator_2.Parent = PrefrencesShow
	PageLayoutSeperator_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	PageLayoutSeperator_2.BackgroundTransparency = 1.000
	PageLayoutSeperator_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	PageLayoutSeperator_2.BorderSizePixel = 0
	PageLayoutSeperator_2.Position = UDim2.new(0.360335201, 0, 0, 0)
	PageLayoutSeperator_2.Size = UDim2.new(0, 100, 0, 1)

	PrefrencesText.Name = "PrefrencesText"
	PrefrencesText.Parent = PrefrencesShow
	PrefrencesText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	PrefrencesText.BackgroundTransparency = 1.000
	PrefrencesText.BorderColor3 = Color3.fromRGB(0, 0, 0)
	PrefrencesText.BorderSizePixel = 0
	PrefrencesText.Size = UDim2.new(1, 0, 0, 20)
	PrefrencesText.Font = Enum.Font.SourceSansSemibold
	PrefrencesText.Text = "   Settings"
	PrefrencesText.TextColor3 = Color3.fromRGB(255, 255, 255)
	PrefrencesText.TextSize = 18.000
	PrefrencesText.TextXAlignment = Enum.TextXAlignment.Left

	Slider_2.Name = "Slider"
	Slider_2.Parent = PrefrencesShow
	Slider_2.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	Slider_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Slider_2.BorderSizePixel = 0
	Slider_2.Position = UDim2.new(0.0140449442, 0, 0.142730772, 0)
	Slider_2.Size = UDim2.new(1, -20, 0, 30)

	SliderStroke_2.Name = "SliderStroke"
	SliderStroke_2.Parent = Slider_2
	SliderStroke_2.Color = Color3.fromRGB(48, 47, 48)

	SliderCorner_2.CornerRadius = UDim.new(0, 4)
	SliderCorner_2.Name = "SliderCorner"
	SliderCorner_2.Parent = Slider_2

	SliderText_2.Name = "SliderText"
	SliderText_2.Parent = Slider_2
	SliderText_2.AnchorPoint = Vector2.new(0, 0.5)
	SliderText_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SliderText_2.BackgroundTransparency = 1.000
	SliderText_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SliderText_2.BorderSizePixel = 0
	SliderText_2.Position = UDim2.new(0, 0, 0.5, 0)
	SliderText_2.Size = UDim2.new(1, -150, 1, 0)
	SliderText_2.Font = Enum.Font.SourceSans
	SliderText_2.Text = "   Dragging Speed"
	SliderText_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	SliderText_2.TextSize = 15.000
	SliderText_2.TextWrapped = true
	SliderText_2.TextXAlignment = Enum.TextXAlignment.Left

	ToggleCheckbox_3.Name = "ToggleCheckbox"
	ToggleCheckbox_3.Parent = Slider_2
	ToggleCheckbox_3.AnchorPoint = Vector2.new(1, 0.5)
	ToggleCheckbox_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ToggleCheckbox_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ToggleCheckbox_3.BorderSizePixel = 0
	ToggleCheckbox_3.Position = UDim2.new(1, -6, 0.5, 0)
	ToggleCheckbox_3.Size = UDim2.new(0, 20, 0, 20)
	ToggleCheckbox_3.Visible = false
	ToggleCheckbox_3.AutoButtonColor = false
	ToggleCheckbox_3.ImageTransparency = 1.000

	ToggleCheckboxCheckmark_3.Name = "ToggleCheckboxCheckmark"
	ToggleCheckboxCheckmark_3.Parent = ToggleCheckbox_3
	ToggleCheckboxCheckmark_3.AnchorPoint = Vector2.new(0.5, 0.5)
	ToggleCheckboxCheckmark_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ToggleCheckboxCheckmark_3.BackgroundTransparency = 1.000
	ToggleCheckboxCheckmark_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ToggleCheckboxCheckmark_3.BorderSizePixel = 0
	ToggleCheckboxCheckmark_3.Position = UDim2.new(0.5, 0, 0.5, 0)
	ToggleCheckboxCheckmark_3.Size = UDim2.new(1, 0, 1, 0)

	SliderMain_2.Name = "SliderMain"
	SliderMain_2.Parent = Slider_2
	SliderMain_2.AnchorPoint = Vector2.new(1, 0.5)
	SliderMain_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SliderMain_2.BackgroundTransparency = 1.000
	SliderMain_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SliderMain_2.BorderSizePixel = 0
	SliderMain_2.Position = UDim2.new(1, -6, 0.5, 0)
	SliderMain_2.Size = UDim2.new(0, 130, 0, 20)

	SliderMainStroke_2.Name = "SliderMainStroke"
	SliderMainStroke_2.Parent = SliderMain_2
	SliderMainStroke_2.Color = Color3.fromRGB(48, 47, 48)

	SliderMainCorner_2.CornerRadius = UDim.new(0, 4)
	SliderMainCorner_2.Name = "SliderMainCorner"
	SliderMainCorner_2.Parent = SliderMain_2

	SliderMainFill_2.Name = "SliderMainFill"
	SliderMainFill_2.Parent = SliderMain_2
	SliderMainFill_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SliderMainFill_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SliderMainFill_2.BorderSizePixel = 0
	SliderMainFill_2.Size = UDim2.new(0, 50, 1, 0)

	SliderMainFillCorner_2.CornerRadius = UDim.new(0, 4)
	SliderMainFillCorner_2.Name = "SliderMainFillCorner"
	SliderMainFillCorner_2.Parent = SliderMainFill_2

	SliderMainFillGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, color1), ColorSequenceKeypoint.new(1.00, color2)}
	SliderMainFillGradient_2.Rotation = 90
	SliderMainFillGradient_2.Name = "SliderMainFillGradient"
	SliderMainFillGradient_2.Parent = SliderMainFill_2

	SliderMainValue_2.Name = "SliderMainValue"
	SliderMainValue_2.Parent = SliderMain_2
	SliderMainValue_2.AnchorPoint = Vector2.new(1, 0.5)
	SliderMainValue_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SliderMainValue_2.BackgroundTransparency = 1.000
	SliderMainValue_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SliderMainValue_2.BorderSizePixel = 0
	SliderMainValue_2.Position = UDim2.new(1, -5, 0.5, 0)
	SliderMainValue_2.Size = UDim2.new(0, 30, 0, 20)
	SliderMainValue_2.Font = Enum.Font.SourceSans
	SliderMainValue_2.Text = "0.5"
	SliderMainValue_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	SliderMainValue_2.TextSize = 14.000
	SliderMainValue_2.TextXAlignment = Enum.TextXAlignment.Right

	SliderMainTrigger_2.Name = "SliderMainTrigger"
	SliderMainTrigger_2.Parent = SliderMain_2
	SliderMainTrigger_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SliderMainTrigger_2.BackgroundTransparency = 1.000
	SliderMainTrigger_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SliderMainTrigger_2.BorderSizePixel = 0
	SliderMainTrigger_2.Size = UDim2.new(1, 0, 1, 0)
	SliderMainTrigger_2.Font = Enum.Font.SourceSans
	SliderMainTrigger_2.Text = ""
	SliderMainTrigger_2.TextColor3 = Color3.fromRGB(0, 0, 0)
	SliderMainTrigger_2.TextSize = 14.000

	Keybind_2.Name = "Keybind"
	Keybind_2.Parent = PrefrencesShow
	Keybind_2.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	Keybind_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Keybind_2.BorderSizePixel = 0
	Keybind_2.Position = UDim2.new(0.0140449442, 0, 0.142730772, 0)
	Keybind_2.Size = UDim2.new(1, -20, 0, 30)

	KeybindStroke_3.Name = "KeybindStroke"
	KeybindStroke_3.Parent = Keybind_2
	KeybindStroke_3.Color = Color3.fromRGB(48, 47, 48)

	KeybindCorner_3.CornerRadius = UDim.new(0, 4)
	KeybindCorner_3.Name = "KeybindCorner"
	KeybindCorner_3.Parent = Keybind_2

	KeybindText_2.Name = "KeybindText"
	KeybindText_2.Parent = Keybind_2
	KeybindText_2.AnchorPoint = Vector2.new(0, 0.5)
	KeybindText_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	KeybindText_2.BackgroundTransparency = 1.000
	KeybindText_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	KeybindText_2.BorderSizePixel = 0
	KeybindText_2.Position = UDim2.new(0, 0, 0.5, 0)
	KeybindText_2.Size = UDim2.new(1, -100, 1, 0)
	KeybindText_2.Font = Enum.Font.SourceSans
	KeybindText_2.Text = "   UI Hide Keybind"
	KeybindText_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	KeybindText_2.TextSize = 15.000
	KeybindText_2.TextWrapped = true
	KeybindText_2.TextXAlignment = Enum.TextXAlignment.Left

	KeybindImage_2.Name = "KeybindImage"
	KeybindImage_2.Parent = Keybind_2
	KeybindImage_2.AnchorPoint = Vector2.new(1, 0.5)
	KeybindImage_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	KeybindImage_2.BackgroundTransparency = 1.000
	KeybindImage_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	KeybindImage_2.BorderSizePixel = 0
	KeybindImage_2.Position = UDim2.new(1, -6, 0.5, 0)
	KeybindImage_2.Size = UDim2.new(0, 20, 0, 20)
	KeybindImage_2.Visible = false
	KeybindImage_2.AutoButtonColor = false
	KeybindImage_2.Image = "rbxassetid://10734898355"

	KeybindTrigger_2.Name = "KeybindTrigger"
	KeybindTrigger_2.Parent = Keybind_2
	KeybindTrigger_2.AnchorPoint = Vector2.new(1, 0.5)
	KeybindTrigger_2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	KeybindTrigger_2.BackgroundTransparency = 0.950
	KeybindTrigger_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	KeybindTrigger_2.BorderSizePixel = 0
	KeybindTrigger_2.Position = UDim2.new(1, -5, 0.5, 0)
	KeybindTrigger_2.Size = UDim2.new(0, 81, 0, 24)
	KeybindTrigger_2.AutoButtonColor = false
	KeybindTrigger_2.Font = Enum.Font.SourceSans
	KeybindTrigger_2.Text = "RightControl"
	KeybindTrigger_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	KeybindTrigger_2.TextSize = 14.000

	KeybindStroke_4.Name = "KeybindStroke"
	KeybindStroke_4.Parent = KeybindTrigger_2
	KeybindStroke_4.Color = Color3.fromRGB(48, 47, 48)
	KeybindStroke_4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

	KeybindCorner_4.CornerRadius = UDim.new(0, 4)
	KeybindCorner_4.Name = "KeybindCorner"
	KeybindCorner_4.Parent = KeybindTrigger_2

	PrefrencesText_2.Name = "PrefrencesText"
	PrefrencesText_2.Parent = Prefrences
	PrefrencesText_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	PrefrencesText_2.BackgroundTransparency = 1.000
	PrefrencesText_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	PrefrencesText_2.BorderSizePixel = 0
	PrefrencesText_2.Size = UDim2.new(1, 0, 0, 30)
	PrefrencesText_2.Font = Enum.Font.SourceSansSemibold
	PrefrencesText_2.Text = "   Prefrences"
	PrefrencesText_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	PrefrencesText_2.TextSize = 18.000
	PrefrencesText_2.TextXAlignment = Enum.TextXAlignment.Left

	shadowHolder.Name = "shadowHolder"
	shadowHolder.Parent = ImageLabel
	shadowHolder.BackgroundTransparency = 1.000
	shadowHolder.Size = UDim2.new(1, 0, 1, 0)
	shadowHolder.ZIndex = 0

	umbraShadow.Name = "umbraShadow"
	umbraShadow.Parent = shadowHolder
	umbraShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	umbraShadow.BackgroundTransparency = 1.000
	umbraShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	umbraShadow.Size = UDim2.new(1, 2, 1, 2)
	umbraShadow.ZIndex = 0
	umbraShadow.Image = "rbxassetid://1316045217"
	umbraShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	umbraShadow.ImageTransparency = 0.560
	umbraShadow.ScaleType = Enum.ScaleType.Slice
	umbraShadow.SliceCenter = Rect.new(10, 10, 118, 118)

	penumbraShadow.Name = "penumbraShadow"
	penumbraShadow.Parent = shadowHolder
	penumbraShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	penumbraShadow.BackgroundTransparency = 1.000
	penumbraShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	penumbraShadow.Size = UDim2.new(1, 2, 1, 2)
	penumbraShadow.ZIndex = 0
	penumbraShadow.Image = "rbxassetid://1316045217"
	penumbraShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	penumbraShadow.ImageTransparency = 0.580
	penumbraShadow.ScaleType = Enum.ScaleType.Slice
	penumbraShadow.SliceCenter = Rect.new(10, 10, 118, 118)

	ambientShadow.Name = "ambientShadow"
	ambientShadow.Parent = shadowHolder
	ambientShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	ambientShadow.BackgroundTransparency = 1.000
	ambientShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	ambientShadow.Size = UDim2.new(1, 2, 1, 2)
	ambientShadow.ZIndex = 0
	ambientShadow.Image = "rbxassetid://1316045217"
	ambientShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	ambientShadow.ImageTransparency = 0.500
	ambientShadow.ScaleType = Enum.ScaleType.Slice
	ambientShadow.SliceCenter = Rect.new(10, 10, 118, 118)

	Maximizer.Name = "Maximizer"
	Maximizer.Parent = ScreenGui
	Maximizer.AnchorPoint = Vector2.new(0.5, 0.5)
	Maximizer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Maximizer.BackgroundTransparency = 1.000
	Maximizer.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Maximizer.BorderSizePixel = 0
	Maximizer.Position = UDim2.new(0.5, 0, 0.5, 0)
	Maximizer.Size = UDim2.new(0, 182, 0, 50)
	Maximizer.Visible = false

	MaximizerMain.Name = "MaximizerMain"
	MaximizerMain.Parent = Maximizer
	MaximizerMain.AnchorPoint = Vector2.new(0.5, 0.5)
	MaximizerMain.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	MaximizerMain.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MaximizerMain.BorderSizePixel = 0
	MaximizerMain.ClipsDescendants = true
	MaximizerMain.Position = UDim2.new(0.5, 0, 0.5, 0)
	MaximizerMain.Size = UDim2.new(1, -10, 1, -10)
	MaximizerMain.AutoButtonColor = false
	MaximizerMain.Text = ""

	MaximizerMainCorner.Name = "MaximizerMainCorner"
	MaximizerMainCorner.Parent = MaximizerMain

	MaximizerMainStroke.Name = "MaximizerMainStroke"
	MaximizerMainStroke.Parent = MaximizerMain
	MaximizerMainStroke.Color = Color3.fromRGB(70, 68, 70)
	MaximizerMainStroke.Thickness = 1.200
	MaximizerMainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

	MaximizerMainThings.Name = "MaximizerMainThings"
	MaximizerMainThings.Parent = MaximizerMain
	MaximizerMainThings.AnchorPoint = Vector2.new(0.5, 0.5)
	MaximizerMainThings.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MaximizerMainThings.BackgroundTransparency = 1.000
	MaximizerMainThings.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MaximizerMainThings.BorderSizePixel = 0
	MaximizerMainThings.Position = UDim2.new(0.5, 0, 0.5, 0)
	MaximizerMainThings.Size = UDim2.new(1, -15, 1, -15)

	MaximizerMainThingsImage.Name = "MaximizerMainThingsImage"
	MaximizerMainThingsImage.Parent = MaximizerMainThings
	MaximizerMainThingsImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MaximizerMainThingsImage.BackgroundTransparency = 1.000
	MaximizerMainThingsImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MaximizerMainThingsImage.BorderSizePixel = 0
	MaximizerMainThingsImage.Size = UDim2.new(0, 25, 0, 25)
	MaximizerMainThingsImage.Image = "rbxassetid://10734886496"

	MaximizerMainThingsLayout.Name = "MaximizerMainThingsLayout"
	MaximizerMainThingsLayout.Parent = MaximizerMainThings
	MaximizerMainThingsLayout.FillDirection = Enum.FillDirection.Horizontal
	MaximizerMainThingsLayout.SortOrder = Enum.SortOrder.LayoutOrder
	MaximizerMainThingsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	MaximizerMainThingsLayout.Padding = UDim.new(0, 7)

	MaximizerMainThingsText.Name = "MaximizerMainThingsText"
	MaximizerMainThingsText.Parent = MaximizerMainThings
	MaximizerMainThingsText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	MaximizerMainThingsText.BackgroundTransparency = 1.000
	MaximizerMainThingsText.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MaximizerMainThingsText.BorderSizePixel = 0
	MaximizerMainThingsText.Size = UDim2.new(0, 120, 1, 0)
	MaximizerMainThingsText.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
	MaximizerMainThingsText.Text = c.MaximizeText
	MaximizerMainThingsText.TextColor3 = Color3.fromRGB(230, 230, 230)
	MaximizerMainThingsText.TextSize = 14.000
	MaximizerMainThingsText.TextXAlignment = Enum.TextXAlignment.Left

	shadowHolder2.Name = "shadowHolder2"
	shadowHolder2.Parent = Maximizer
	shadowHolder2.BackgroundTransparency = 1.000
	shadowHolder2.Size = UDim2.new(1, 0, 1, 0)
	shadowHolder2.ZIndex = 0

	umbraShadow2.Name = "umbraShadow2"
	umbraShadow2.Parent = shadowHolder2
	umbraShadow2.AnchorPoint = Vector2.new(0.5, 0.5)
	umbraShadow2.BackgroundTransparency = 1.000
	umbraShadow2.Position = UDim2.new(0.5, 0, 0.5, 0)
	umbraShadow2.Size = UDim2.new(1, 2, 1, 2)
	umbraShadow2.ZIndex = 0
	umbraShadow2.Image = "rbxassetid://1316045217"
	umbraShadow2.ImageColor3 = Color3.fromRGB(0, 0, 0)
	umbraShadow2.ImageTransparency = 0.560
	umbraShadow2.ScaleType = Enum.ScaleType.Slice
	umbraShadow2.SliceCenter = Rect.new(10, 10, 118, 118)

	penumbraShadow2.Name = "penumbraShadow2"
	penumbraShadow2.Parent = shadowHolder2
	penumbraShadow2.AnchorPoint = Vector2.new(0.5, 0.5)
	penumbraShadow2.BackgroundTransparency = 1.000
	penumbraShadow2.Position = UDim2.new(0.5, 0, 0.5, 0)
	penumbraShadow2.Size = UDim2.new(1, 2, 1, 2)
	penumbraShadow2.ZIndex = 0
	penumbraShadow2.Image = "rbxassetid://1316045217"
	penumbraShadow2.ImageColor3 = Color3.fromRGB(0, 0, 0)
	penumbraShadow2.ImageTransparency = 0.580
	penumbraShadow2.ScaleType = Enum.ScaleType.Slice
	penumbraShadow2.SliceCenter = Rect.new(10, 10, 118, 118)

	ambientShadow2.Name = "ambientShadow2"
	ambientShadow2.Parent = shadowHolder2
	ambientShadow2.AnchorPoint = Vector2.new(0.5, 0.5)
	ambientShadow2.BackgroundTransparency = 1.000
	ambientShadow2.Position = UDim2.new(0.5, 0, 0.5, 0)
	ambientShadow2.Size = UDim2.new(1, 2, 1, 2)
	ambientShadow2.ZIndex = 0
	ambientShadow2.Image = "rbxassetid://1316045217"
	ambientShadow2.ImageColor3 = Color3.fromRGB(0, 0, 0)
	ambientShadow2.ImageTransparency = 0.500
	ambientShadow2.ScaleType = Enum.ScaleType.Slice
	ambientShadow2.SliceCenter = Rect.new(10, 10, 118, 118)

	DraggingEnabled(MaximizerMainThings, Maximizer)

	task.spawn(function()
		for i = 1, 20 do task.wait(0.2)
			MaximizerMainThingsText.Size = UDim2.new(0, MaximizerMainThingsText.TextBounds.X, 1, 0)
			Maximizer.Size = UDim2.new(0, MaximizerMainThingsLayout.AbsoluteContentSize.X + 30, 0, 50)
		end
	end)
	local oldsize = ImageLabel.AbsoluteSize
	local opened = true
	local closeui = (function()
		oldsize = ImageLabel.AbsoluteSize
		game:GetService("TweenService"):Create(ImageLabel,TweenInfo.new(0.1,Enum.EasingStyle.Quad),{Size = UDim2.new(0,oldsize.X - 20,0, oldsize.Y - 20)}):Play()
		game:GetService("TweenService"):Create(ImageLabel,TweenInfo.new(0.1,Enum.EasingStyle.Quad),{GroupTransparency = 1}):Play()
	end)
	local openui = (function()
		game:GetService("TweenService"):Create(ImageLabel,TweenInfo.new(0.1,Enum.EasingStyle.Quad),{Size = UDim2.new(0,oldsize.X,0, oldsize.Y)}):Play()
		game:GetService("TweenService"):Create(ImageLabel,TweenInfo.new(0.1,Enum.EasingStyle.Quad),{GroupTransparency = 0}):Play()
	end)

	MaximizerMain.MouseButton1Click:Connect(function()
		opened = true
		Maximizer.Visible = false
		openui()
	end)
	
	TopbarMenuTrigger.MouseButton1Click:Connect(function()
		game:GetService("TweenService"):Create(Menu, TweenInfo.new(0.65, Enum.EasingStyle.Quint), {Position = UDim2.new(0,0,0,0)}):Play()
	end)
	BackButton.MouseButton1Click:Connect(function()
		game:GetService("TweenService"):Create(Menu, TweenInfo.new(0.65, Enum.EasingStyle.Quint), {Position = UDim2.new(0,0,-1,0)}):Play()
	end)
	DiscordButton.MouseButton1Click:Connect(c.Discord.DiscordButtonCallback)
	
	-- source slider module daur ulang aowkowkwowkw
	local mouse = game:GetService("Players").LocalPlayer:GetMouse()
	local uis = game:GetService("UserInputService")
	local Min_Value = 0
	local Max_Value = 1
	local Precise = true
	local Bar = SliderMainFill_2
	local Sliderbox = SliderMainValue_2
	local SizeChia = 130
	local DefaultValue = 0.15

	if DefaultValue then 
		if DefaultValue <= Min_Value then DefaultValue = Min_Value elseif DefaultValue >= Max_Value then DefaultValue = Max_Value end
		Bar.Size = UDim2.new(1 - ((Max_Value - DefaultValue) / (Max_Value - Min_Value)),0, 1, 0)
		Sliderbox.Text = DefaultValue
		thethingy.DraggingSpeed = DefaultValue
	end

	SliderMainTrigger_2.MouseButton1Down:Connect(function()
		local value = Precise and  tonumber(string.format("%.2f",(((tonumber(Max_Value) - tonumber(Min_Value)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(Min_Value))) or math.floor((((tonumber(Max_Value) - tonumber(Min_Value)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(Min_Value))

		pcall(function()
			thethingy.DraggingSpeed = value
			Sliderbox.Text = value
		end)
		Bar.Size = UDim2.new(0, math.clamp(mouse.X - Bar.AbsolutePosition.X, 0, SizeChia), 1, 0)
		moveconnection = mouse.Move:Connect(function()   
			local value = Precise and  tonumber(string.format("%.2f",(((tonumber(Max_Value) - tonumber(Min_Value)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(Min_Value))) or math.floor((((tonumber(Max_Value) - tonumber(Min_Value)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(Min_Value))
			pcall(function()
				thethingy.DraggingSpeed = value
				Sliderbox.Text = value
			end)
			Bar.Size = UDim2.new(0, math.clamp(mouse.X - Bar.AbsolutePosition.X, 0, SizeChia), 1, 0)
		end)
		releaseconnection = uis.InputEnded:Connect(function(Mouse)
			if Mouse.UserInputType == Enum.UserInputType.MouseButton1 or Mouse.UserInputType == Enum.UserInputType.Touch then
				local value = Precise and  tonumber(string.format("%.2f",(((tonumber(Max_Value) - tonumber(Min_Value)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(Min_Value))) or math.floor((((tonumber(Max_Value) - tonumber(Min_Value)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(Min_Value))

				pcall(function()
					thethingy.DraggingSpeed = value
					Sliderbox.Text = value
				end)
				Bar.Size = UDim2.new(0, math.clamp(mouse.X - Bar.AbsolutePosition.X, 0, SizeChia), 1, 0)
			end
		end)
		uis.InputEnded:Connect(function(Mouse)
			if Mouse.UserInputType == Enum.UserInputType.MouseButton1 or Mouse.UserInputType == Enum.UserInputType.Touch then
				moveconnection:Disconnect()
				releaseconnection:Disconnect()
			end
		end)
	end)
	
	local keybindBtn = KeybindTrigger_2
	local oldkey = Enum.KeyCode.RightControl
	local focusing = false
	keybindBtn.MouseButton1Click:connect(function(e) 
		keybindBtn.Text = ". . ."
		focusing = true
		local a = game:GetService('UserInputService').InputBegan:Wait();
		if a.KeyCode.Name ~= "Unknown" then
			keybindBtn.Text = a.KeyCode.Name
			oldKey = a.KeyCode.Name;
			task.delay(0.1, function()
				game.TweenService:Create(keybindBtn, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Size = UDim2.new(0, keybindBtn.TextBounds.X + 20,0, 24)}):Play()
				task.wait(0.1)
				focusing = false
			end)
		end
	end)
	game:GetService("UserInputService").InputBegan:Connect(function(key, ok) 
		if not ok then 
			if key.KeyCode.Name == oldKey and focusing == false then 
				if opened then
					Maximizer.Visible = true
					closeui()
				else
					Maximizer.Visible = false
					openui()
				end
				opened = not opened
			end
		end
	end)

	TopbarMinimize.MouseButton1Click:Connect(function()
		closeui()
		opened = false
		Maximizer.Visible = true
	end)

	local page = {}
	page.CreateTab = (function(c)
		c = c or {}
		c.Name = c.Name or "who cares"
		c.Image = c.Image or ""
		
		local Farming = Instance.new("TextButton")
		local PageButtonImage = Instance.new("ImageLabel")
		local PageButtonText = Instance.new("TextLabel")
		local Farming_2 = Instance.new("ScrollingFrame")
		local PageLayout = Instance.new("UIListLayout")
		local PageLayoutSeperator = Instance.new("Frame")
		
		Farming.Name = c.Name
		Farming.Parent = Pagebar
		Farming.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Farming.BackgroundTransparency = 1.000
		Farming.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Farming.BorderSizePixel = 0
		Farming.Size = UDim2.new(0, 155, 0, 30)
		Farming.AutoButtonColor = false
		Farming.Font = Enum.Font.SourceSans
		Farming.Text = ""
		Farming.TextColor3 = Color3.fromRGB(0, 0, 0)
		Farming.TextSize = 14.000

		PageButtonImage.Name = "PageButtonImage"
		PageButtonImage.Parent = Farming
		PageButtonImage.AnchorPoint = Vector2.new(0, 0.5)
		PageButtonImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		PageButtonImage.BackgroundTransparency = 1.000
		PageButtonImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
		PageButtonImage.BorderSizePixel = 0
		PageButtonImage.Position = UDim2.new(0, 5, 0.5, 0)
		PageButtonImage.Size = UDim2.new(0, 20, 0, 20)
		PageButtonImage.Image = c.Image

		PageButtonText.Name = "PageButtonText"
		PageButtonText.Parent = Farming
		PageButtonText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		PageButtonText.BackgroundTransparency = 1.000
		PageButtonText.BorderColor3 = Color3.fromRGB(0, 0, 0)
		PageButtonText.BorderSizePixel = 0
		PageButtonText.Position = UDim2.new(0, 31, 0, 0)
		PageButtonText.Size = UDim2.new(1.00000024, 0, 1, 0)
		PageButtonText.Font = Enum.Font.SourceSans
		PageButtonText.TextColor3 = Color3.fromRGB(255, 255, 255)
		PageButtonText.TextSize = 14.000
		PageButtonText.TextXAlignment = Enum.TextXAlignment.Left
		PageButtonText.Text = c.Name
		
		Farming_2.Name = c.Name
		Farming_2.Parent = PageShow
		Farming_2.Active = true
		Farming_2.AnchorPoint = Vector2.new(0.5, 0.5)
		Farming_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Farming_2.BackgroundTransparency = 1.000
		Farming_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Farming_2.BorderSizePixel = 0
		Farming_2.Position = UDim2.new(0.5, 0, 0.5, 0)
		Farming_2.Size = UDim2.new(1, -12, 1, -12)
		Farming_2.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
		Farming_2.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
		Farming_2.ScrollBarThickness = 0
		Farming_2.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
		Farming_2.Visible = false

		PageLayout.Name = "PageLayout"
		PageLayout.Parent = Farming_2
		PageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
		PageLayout.Padding = UDim.new(0, 6)

		PageLayoutSeperator.Name = "PageLayoutSeperator"
		PageLayoutSeperator.Parent = Farming_2
		PageLayoutSeperator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		PageLayoutSeperator.BackgroundTransparency = 1.000
		PageLayoutSeperator.BorderColor3 = Color3.fromRGB(0, 0, 0)
		PageLayoutSeperator.BorderSizePixel = 0
		PageLayoutSeperator.Position = UDim2.new(0.360335201, 0, 0, 0)
		PageLayoutSeperator.Size = UDim2.new(0, 100, 0, 0)
		
		PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			Farming_2.CanvasSize = UDim2.new(0,0,0,PageLayout.AbsoluteContentSize.Y + 2)
		end)

		for i,v in next, Pagebar:GetChildren() do
			if v:IsA("TextButton") then
				v.MouseButton1Click:Connect(function()
					for i2,v2 in next, PageShow:GetChildren() do
						if v2.ClassName == "ScrollingFrame" then
							v2.Visible = false
							print(v2.Visible)
						end
					end
					PageShow[v.Name].Visible = true
				end)
			end
		end
		
		local section = {}
		
		section.CreateSection = (function(c)
			c = c or {}
			c.Name = c.Name or "Section"
			c.DropSection = c.DropSection or false
			
			local PageSection = Instance.new("Frame")
			local PageSectionLayout = Instance.new("UIListLayout")
			local PageSectionTop = Instance.new("Frame")
			local PageSectionTopCorner = Instance.new("UICorner")
			local PageSectionTopStroke = Instance.new("UIStroke")
			local PageSectionTopCornerHider = Instance.new("Frame")
			local PageSectionTopStrokeFrame = Instance.new("Frame")
			local PageSectionTopText = Instance.new("TextLabel")
			local PageSectionCorner = Instance.new("UICorner")
			local PageSectionStroke = Instance.new("UIStroke")
			
			PageSection.Name = "PageSection"
			PageSection.Parent = Farming_2
			PageSection.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			PageSection.BorderColor3 = Color3.fromRGB(0, 0, 0)
			PageSection.BorderSizePixel = 0
			PageSection.Position = UDim2.new(0.00279329601, 0, 0.010714286, 0)
			PageSection.Size = UDim2.new(1, -2, 0, 210)

			PageSectionLayout.Name = "PageSectionLayout"
			PageSectionLayout.Parent = PageSection
			PageSectionLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			PageSectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
			PageSectionLayout.Padding = UDim.new(0, 5)

			PageSectionTop.Name = "PageSectionTop"
			PageSectionTop.Parent = PageSection
			PageSectionTop.BackgroundColor3 = Color3.fromRGB(31, 30, 31)
			PageSectionTop.BorderColor3 = Color3.fromRGB(0, 0, 0)
			PageSectionTop.BorderSizePixel = 0
			PageSectionTop.Size = UDim2.new(1, 0, 0, 30)

			PageSectionTopCorner.Name = "PageSectionTopCorner"
			PageSectionTopCorner.Parent = PageSectionTop
			PageSectionTopCorner.CornerRadius = UDim.new(0,5)

			PageSectionTopStroke.Name = "PageSectionTopStroke"
			PageSectionTopStroke.Parent = PageSectionTop
			PageSectionTopStroke.Color = Color3.fromRGB(48, 47, 48)

			PageSectionTopCornerHider.Name = "PageSectionTopCornerHider"
			PageSectionTopCornerHider.Parent = PageSectionTop
			PageSectionTopCornerHider.AnchorPoint = Vector2.new(0, 1)
			PageSectionTopCornerHider.BackgroundColor3 = Color3.fromRGB(31, 30, 31)
			PageSectionTopCornerHider.BorderColor3 = Color3.fromRGB(0, 0, 0)
			PageSectionTopCornerHider.BorderSizePixel = 0
			PageSectionTopCornerHider.Position = UDim2.new(0, 0, 1, 1)
			PageSectionTopCornerHider.Size = UDim2.new(1, 0, 0, 6)

			PageSectionTopStrokeFrame.Name = "PageSectionTopStrokeFrame"
			PageSectionTopStrokeFrame.Parent = PageSectionTopCornerHider
			PageSectionTopStrokeFrame.AnchorPoint = Vector2.new(0, 1)
			PageSectionTopStrokeFrame.BackgroundColor3 = Color3.fromRGB(48, 47, 48)
			PageSectionTopStrokeFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			PageSectionTopStrokeFrame.BorderSizePixel = 0
			PageSectionTopStrokeFrame.Position = UDim2.new(0, 0, 1, 0)
			PageSectionTopStrokeFrame.Size = UDim2.new(1, 0, 0, 1)

			PageSectionTopText.Name = "PageSectionTopText"
			PageSectionTopText.Parent = PageSectionTop
			PageSectionTopText.AnchorPoint = Vector2.new(1, 0.5)
			PageSectionTopText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			PageSectionTopText.BackgroundTransparency = 1.000
			PageSectionTopText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			PageSectionTopText.BorderSizePixel = 0
			PageSectionTopText.Position = UDim2.new(1, 0, 0.5, 0)
			PageSectionTopText.Size = UDim2.new(1, -10, 0, 20)
			PageSectionTopText.Font = Enum.Font.SourceSans
			PageSectionTopText.Text = c.Name
			PageSectionTopText.TextColor3 = Color3.fromRGB(255, 255, 255)
			PageSectionTopText.TextSize = 14.000
			PageSectionTopText.TextXAlignment = Enum.TextXAlignment.Left
			
			PageSectionCorner.Name = "PageSectionCorner"
			PageSectionCorner.Parent = PageSection
			PageSectionCorner.CornerRadius = UDim.new(0, 5)

			PageSectionStroke.Name = "PageSectionStroke"
			PageSectionStroke.Parent = PageSection
			PageSectionStroke.Color = Color3.fromRGB(48, 47, 48)

			if c.DropSection then
				local opened = false
				local PageSectionTopOpener = Instance.new("ImageButton")
				PageSectionTopOpener.Name = "PageSectionTopOpener"
				PageSectionTopOpener.Parent = PageSectionTop
				PageSectionTopOpener.AnchorPoint = Vector2.new(1, 0.5)
				PageSectionTopOpener.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				PageSectionTopOpener.BackgroundTransparency = 1.000
				PageSectionTopOpener.BorderColor3 = Color3.fromRGB(0, 0, 0)
				PageSectionTopOpener.BorderSizePixel = 0
				PageSectionTopOpener.Position = UDim2.new(1, -5, 0.5, 0)
				PageSectionTopOpener.Rotation = 0
				PageSectionTopOpener.Size = UDim2.new(0, 20, 0, 20)
				PageSectionTopOpener.Image = "rbxassetid://10709791281"

				PageSection.Size = UDim2.new(1, -2, 0, 30)
				PageSection.ClipsDescendants = true
				PageSectionTopCornerHider.Visible = false

				PageSectionLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					if opened then
						game.TweenService:Create(PageSection, TweenInfo.new(0.08, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
							Size = UDim2.new(1, -2,0, PageSectionLayout.AbsoluteContentSize.Y + 5)
						}):Play()
					end
				end)
				PageSectionTopOpener.MouseButton1Click:Connect(function()
					print("clicked")
					if opened == false then
						opened = true
						game.TweenService:Create(PageSection, TweenInfo.new(0.08, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
							Size = UDim2.new(1, -2,0, PageSectionLayout.AbsoluteContentSize.Y + 5)
						}):Play()
						game.TweenService:Create(PageSectionTopOpener, TweenInfo.new(0.08, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
							Rotation = -90
						}):Play()
						PageSectionTopCornerHider.Visible = true
					else
						opened = false
						game.TweenService:Create(PageSection, TweenInfo.new(0.08, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
							Size = UDim2.new(1, -2,0, 30)
						}):Play()
						game.TweenService:Create(PageSectionTopOpener, TweenInfo.new(0.08, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
							Rotation = -0
						}):Play()
						PageSectionTopCornerHider.Visible = false
					end
				end)
			else
				game.TweenService:Create(PageSection, TweenInfo.new(0.08, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
					Size = UDim2.new(1, -2,0, PageSectionLayout.AbsoluteContentSize.Y + 5)
				}):Play()
				PageSectionLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					game.TweenService:Create(PageSection, TweenInfo.new(0.08, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
						Size = UDim2.new(1, -2,0, PageSectionLayout.AbsoluteContentSize.Y + 5)
					}):Play()
				end)
			end
			
			local sectionelements = {}

			sectionelements.SectionClear = (function(ignorelist)
			
			end)
			
			sectionelements.CreateToggle = (function(c)
				c = c or {}
				c.Name = c.Name or "Toggle"
				c.Default = c.Default or false
				c.Callback = c.Callback or function(a) print(a) end
				
				local Toggle = Instance.new("Frame")
				local ToggleStroke = Instance.new("UIStroke")
				local ToggleCorner = Instance.new("UICorner")
				local ToggleText = Instance.new("TextLabel")
				local ToggleCheckbox_2 = Instance.new("ImageButton")
				local ToggleCheckboxCorner = Instance.new("UICorner")
				local ToggleCheckboxStroke = Instance.new("UIStroke")
				local ToggleCheckboxGradient = Instance.new("UIGradient")
				local ToggleCheckboxCheckmark_2 = Instance.new("ImageLabel")
				
				Toggle.Name = "Toggle"
				Toggle.Parent = PageSection
				Toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Toggle.BorderSizePixel = 0
				Toggle.Position = UDim2.new(0.0140449442, 0, 0.142730772, 0)
				Toggle.Size = UDim2.new(1, -10, 0, 30)

				ToggleStroke.Name = "ToggleStroke"
				ToggleStroke.Parent = Toggle
				ToggleStroke.Color = Color3.fromRGB(48, 47, 48)

				ToggleCorner.CornerRadius = UDim.new(0, 4)
				ToggleCorner.Name = "ToggleCorner"
				ToggleCorner.Parent = Toggle

				ToggleText.Name = "ToggleText"
				ToggleText.Parent = Toggle
				ToggleText.AnchorPoint = Vector2.new(0, 0.5)
				ToggleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleText.BackgroundTransparency = 1.000
				ToggleText.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ToggleText.BorderSizePixel = 0
				ToggleText.Position = UDim2.new(0, 0, 0.5, 0)
				ToggleText.Size = UDim2.new(1, -50, 1, 0)
				ToggleText.Font = Enum.Font.SourceSans
				ToggleText.Text = "   ".. c.Name
				ToggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
				ToggleText.TextSize = 15.000
				ToggleText.TextWrapped = true
				ToggleText.TextXAlignment = Enum.TextXAlignment.Left

				ToggleCheckbox_2.Name = "ToggleCheckbox"
				ToggleCheckbox_2.Parent = Toggle
				ToggleCheckbox_2.AnchorPoint = Vector2.new(1, 0.5)
				ToggleCheckbox_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleCheckbox_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ToggleCheckbox_2.BorderSizePixel = 0
				ToggleCheckbox_2.Position = UDim2.new(1, -6, 0.5, 0)
				ToggleCheckbox_2.Size = UDim2.new(0, 20, 0, 20)
				ToggleCheckbox_2.AutoButtonColor = false
				ToggleCheckbox_2.Image = "rbxassetid://10709790644"
				ToggleCheckbox_2.ImageTransparency = 1.000
				ToggleCheckbox_2.BackgroundTransparency = 1

				ToggleCheckboxCorner.CornerRadius = UDim.new(0, 4)
				ToggleCheckboxCorner.Name = "ToggleCheckboxCorner"
				ToggleCheckboxCorner.Parent = ToggleCheckbox_2

				ToggleCheckboxStroke.Name = "ToggleCheckboxStroke"
				ToggleCheckboxStroke.Parent = ToggleCheckbox_2
				ToggleCheckboxStroke.Color = Color3.fromRGB(48, 47, 48)

				ToggleCheckboxGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, color1), ColorSequenceKeypoint.new(1.00, color2)}
				ToggleCheckboxGradient.Name = "ToggleCheckboxGradient"
				ToggleCheckboxGradient.Parent = ToggleCheckbox_2
				ToggleCheckboxGradient.Rotation = 90

				ToggleCheckboxCheckmark_2.Name = "ToggleCheckboxCheckmark"
				ToggleCheckboxCheckmark_2.Parent = ToggleCheckbox_2
				ToggleCheckboxCheckmark_2.AnchorPoint = Vector2.new(0.5, 0.5)
				ToggleCheckboxCheckmark_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleCheckboxCheckmark_2.BackgroundTransparency = 1.000
				ToggleCheckboxCheckmark_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ToggleCheckboxCheckmark_2.BorderSizePixel = 0
				ToggleCheckboxCheckmark_2.Position = UDim2.new(0.5, 0, 0.5, 0)
				ToggleCheckboxCheckmark_2.Size = UDim2.new(1, 0, 1, 0)
				ToggleCheckboxCheckmark_2.Image = "rbxassetid://6023426926"
				ToggleCheckboxCheckmark_2.ImageTransparency = 1
				
				local toggled = false
				local togglefunction = {}
				
				togglefunction.Toggle = (function()
					if toggled == false then
						toggled = true
						task.spawn(function()
							c.Callback(toggled)
						end)
						game:GetService("TweenService"):Create(ToggleCheckboxCheckmark_2, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {ImageTransparency = 0}):Play()
						game:GetService("TweenService"):Create(ToggleCheckbox_2, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()
						--game:GetService("TweenService"):Create(parent.ToggleCheckbox, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {BackgroundTransparency = 0}):Play()
					else
						toggled = false
						task.spawn(function()
							c.Callback(toggled)
						end)
						game:GetService("TweenService"):Create(ToggleCheckboxCheckmark_2, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {ImageTransparency = 1}):Play()
						game:GetService("TweenService"):Create(ToggleCheckbox_2, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {BackgroundTransparency = 1}):Play()
					end
				end)
				
				ToggleCheckbox_2.MouseButton1Click:Connect(function()
					togglefunction.Toggle()
				end)
				
				if c.Default then
					togglefunction.Toggle()
				else
					c.Callback(toggled)
				end
				
				return togglefunction
				
			end)
			
			sectionelements.CreateButton = (function(c)
				c.Name = c.Name or "bt"
				c.Callback = c.Callback or (function() end)
				
				local Button = Instance.new("Frame")
				local ButtonStroke = Instance.new("UIStroke")
				local ButtonCorner = Instance.new("UICorner")
				local ButtonText = Instance.new("TextLabel")
				local ButtonImage = Instance.new("ImageButton")
				local ButtonTrigger = Instance.new("TextButton")
				
				Button.Name = "Button"
				Button.Parent = PageSection
				Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Button.BorderSizePixel = 0
				Button.Position = UDim2.new(0.0140449442, 0, 0.142730772, 0)
				Button.Size = UDim2.new(1, -10, 0, 30)

				ButtonStroke.Name = "ButtonStroke"
				ButtonStroke.Parent = Button
				ButtonStroke.Color = Color3.fromRGB(48, 47, 48)

				ButtonCorner.CornerRadius = UDim.new(0, 4)
				ButtonCorner.Name = "ButtonCorner"
				ButtonCorner.Parent = Button

				ButtonText.Name = "ButtonText"
				ButtonText.Parent = Button
				ButtonText.AnchorPoint = Vector2.new(0, 0.5)
				ButtonText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ButtonText.BackgroundTransparency = 1.000
				ButtonText.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ButtonText.BorderSizePixel = 0
				ButtonText.Position = UDim2.new(0, 0, 0.5, 0)
				ButtonText.Size = UDim2.new(1, -50, 1, 0)
				ButtonText.Font = Enum.Font.SourceSans
				ButtonText.Text = "   ".. c.Name
				ButtonText.TextColor3 = Color3.fromRGB(255, 255, 255)
				ButtonText.TextSize = 15.000
				ButtonText.TextWrapped = true
				ButtonText.TextXAlignment = Enum.TextXAlignment.Left

				ButtonImage.Name = "ButtonImage"
				ButtonImage.Parent = Button
				ButtonImage.AnchorPoint = Vector2.new(1, 0.5)
				ButtonImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ButtonImage.BackgroundTransparency = 1.000
				ButtonImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ButtonImage.BorderSizePixel = 0
				ButtonImage.Position = UDim2.new(1, -6, 0.5, 0)
				ButtonImage.Size = UDim2.new(0, 20, 0, 20)
				ButtonImage.AutoButtonColor = false
				ButtonImage.Image = "rbxassetid://10734898355"

				ButtonTrigger.Name = "ButtonTrigger"
				ButtonTrigger.Parent = Button
				ButtonTrigger.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ButtonTrigger.BackgroundTransparency = 1.000
				ButtonTrigger.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ButtonTrigger.BorderSizePixel = 0
				ButtonTrigger.Size = UDim2.new(1, 0, 1, 0)
				ButtonTrigger.Font = Enum.Font.SourceSans
				ButtonTrigger.Text = ""
				ButtonTrigger.TextColor3 = Color3.fromRGB(0, 0, 0)
				ButtonTrigger.TextSize = 14.000
				
				ButtonTrigger.MouseButton1Click:Connect(function()
					game:GetService("TweenService"):Create(Button, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(43,43,43)}):Play()
					task.wait(0.1)
					game:GetService("TweenService"):Create(Button, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
					c.Callback()
				end)
			end)
			
			sectionelements.CreateSlider = (function(c)
				c = c or {}
				c.Name = c.Name or "Slder"
				c.Min = c.Min or 0
				c.Max = c.Max or 100
				c.Default = c.Default or 0
				c.Precise = c.Precise or false
				c.Callback = c.Callback or function(a) print(a) end
				
				local Slider = Instance.new("Frame")
				local SliderStroke = Instance.new("UIStroke")
				local SliderCorner = Instance.new("UICorner")
				local SliderText = Instance.new("TextLabel")
				local SliderMain = Instance.new("Frame")
				local SliderMainStroke = Instance.new("UIStroke")
				local SliderMainCorner = Instance.new("UICorner")
				local SliderMainFill = Instance.new("Frame")
				local SliderMainFillCorner = Instance.new("UICorner")
				local SliderMainFillGradient = Instance.new("UIGradient")
				local SliderMainValue = Instance.new("TextLabel")
				local SliderMainTrigger = Instance.new("TextButton")
				
				Slider.Name = "Slider"
				Slider.Parent = PageSection
				Slider.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Slider.BorderSizePixel = 0
				Slider.Position = UDim2.new(0.0140449442, 0, 0.142730772, 0)
				Slider.Size = UDim2.new(1, -10, 0, 30)

				SliderStroke.Name = "SliderStroke"
				SliderStroke.Parent = Slider
				SliderStroke.Color = Color3.fromRGB(48, 47, 48)

				SliderCorner.CornerRadius = UDim.new(0, 4)
				SliderCorner.Name = "SliderCorner"
				SliderCorner.Parent = Slider

				SliderText.Name = "SliderText"
				SliderText.Parent = Slider
				SliderText.AnchorPoint = Vector2.new(0, 0.5)
				SliderText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SliderText.BackgroundTransparency = 1.000
				SliderText.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SliderText.BorderSizePixel = 0
				SliderText.Position = UDim2.new(0, 0, 0.5, 0)
				SliderText.Size = UDim2.new(1, -150, 1, 0)
				SliderText.Font = Enum.Font.SourceSans
				SliderText.Text = "   ".. c.Name
				SliderText.TextColor3 = Color3.fromRGB(255, 255, 255)
				SliderText.TextSize = 15.000
				SliderText.TextWrapped = true
				SliderText.TextXAlignment = Enum.TextXAlignment.Left

				SliderMain.Name = "SliderMain"
				SliderMain.Parent = Slider
				SliderMain.AnchorPoint = Vector2.new(1, 0.5)
				SliderMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SliderMain.BackgroundTransparency = 1.000
				SliderMain.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SliderMain.BorderSizePixel = 0
				SliderMain.Position = UDim2.new(1, -6, 0.5, 0)
				SliderMain.Size = UDim2.new(0, 130, 0, 20)

				SliderMainStroke.Name = "SliderMainStroke"
				SliderMainStroke.Parent = SliderMain
				SliderMainStroke.Color = Color3.fromRGB(48, 47, 48)

				SliderMainCorner.CornerRadius = UDim.new(0, 4)
				SliderMainCorner.Name = "SliderMainCorner"
				SliderMainCorner.Parent = SliderMain

				SliderMainFill.Name = "SliderMainFill"
				SliderMainFill.Parent = SliderMain
				SliderMainFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SliderMainFill.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SliderMainFill.BorderSizePixel = 0
				SliderMainFill.Size = UDim2.new(0, 50, 1, 0)

				SliderMainFillCorner.CornerRadius = UDim.new(0, 4)
				SliderMainFillCorner.Name = "SliderMainFillCorner"
				SliderMainFillCorner.Parent = SliderMainFill

				SliderMainFillGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, color1), ColorSequenceKeypoint.new(1.00, color2)}
				SliderMainFillGradient.Rotation = 90
				SliderMainFillGradient.Name = "SliderMainFillGradient"
				SliderMainFillGradient.Parent = SliderMainFill

				SliderMainValue.Name = "SliderMainValue"
				SliderMainValue.Parent = SliderMain
				SliderMainValue.AnchorPoint = Vector2.new(1, 0.5)
				SliderMainValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SliderMainValue.BackgroundTransparency = 1.000
				SliderMainValue.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SliderMainValue.BorderSizePixel = 0
				SliderMainValue.Position = UDim2.new(1, -5, 0.5, 0)
				SliderMainValue.Size = UDim2.new(0, 30, 0, 20)
				SliderMainValue.Font = Enum.Font.SourceSans
				SliderMainValue.Text = "124"
				SliderMainValue.TextColor3 = Color3.fromRGB(255, 255, 255)
				SliderMainValue.TextSize = 14.000
				SliderMainValue.TextXAlignment = Enum.TextXAlignment.Right

				SliderMainTrigger.Name = "SliderMainTrigger"
				SliderMainTrigger.Parent = SliderMain
				SliderMainTrigger.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SliderMainTrigger.BackgroundTransparency = 1.000
				SliderMainTrigger.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SliderMainTrigger.BorderSizePixel = 0
				SliderMainTrigger.Size = UDim2.new(1, 0, 1, 0)
				SliderMainTrigger.Font = Enum.Font.SourceSans
				SliderMainTrigger.Text = ""
				SliderMainTrigger.TextColor3 = Color3.fromRGB(0, 0, 0)
				SliderMainTrigger.TextSize = 14.000
				
				local mouse = game:GetService("Players").LocalPlayer:GetMouse()
				local uis = game:GetService("UserInputService")

				local Min_Value = c.Min
				local Max_Value = c.Max
				local Precise = c.Precise
				local Bar = SliderMainFill
				local Sliderbox = SliderMainValue
				local SizeChia = 130
				local DefaultValue = c.Default

				if DefaultValue then 
					if DefaultValue <= Min_Value then DefaultValue = Min_Value elseif DefaultValue >= Max_Value then DefaultValue = Max_Value end
					Bar.Size = UDim2.new(1 - ((Max_Value - DefaultValue) / (Max_Value - Min_Value)),0, 1, 0)
					Sliderbox.Text = DefaultValue
					c.Callback(DefaultValue)
				end

				SliderMainTrigger.MouseButton1Down:Connect(function()
					local value = Precise and  tonumber(string.format("%.1f",(((tonumber(Max_Value) - tonumber(Min_Value)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(Min_Value))) or math.floor((((tonumber(Max_Value) - tonumber(Min_Value)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(Min_Value))

					pcall(function()
						c.Callback(value)
						Sliderbox.Text = value
					end)
					Bar.Size = UDim2.new(0, math.clamp(mouse.X - Bar.AbsolutePosition.X, 0, SizeChia), 1, 0)
					moveconnection = mouse.Move:Connect(function()   
						local value = Precise and  tonumber(string.format("%.1f",(((tonumber(Max_Value) - tonumber(Min_Value)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(Min_Value))) or math.floor((((tonumber(Max_Value) - tonumber(Min_Value)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(Min_Value))
						pcall(function()
							c.Callback(value)
							Sliderbox.Text = value
						end)
						Bar.Size = UDim2.new(0, math.clamp(mouse.X - Bar.AbsolutePosition.X, 0, SizeChia), 1, 0)
					end)
					releaseconnection = uis.InputEnded:Connect(function(Mouse)
						if Mouse.UserInputType == Enum.UserInputType.MouseButton1 or Mouse.UserInputType == Enum.UserInputType.Touch then
							local value = Precise and  tonumber(string.format("%.1f",(((tonumber(Max_Value) - tonumber(Min_Value)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(Min_Value))) or math.floor((((tonumber(Max_Value) - tonumber(Min_Value)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(Min_Value))

							pcall(function()
								c.Callback(value)
								Sliderbox.Text = value
							end)
							Bar.Size = UDim2.new(0, math.clamp(mouse.X - Bar.AbsolutePosition.X, 0, SizeChia), 1, 0)
						end
					end)
					uis.InputEnded:Connect(function(Mouse)
						if Mouse.UserInputType == Enum.UserInputType.MouseButton1 or Mouse.UserInputType == Enum.UserInputType.Touch then
							moveconnection:Disconnect()
							releaseconnection:Disconnect()
						end
					end)
				end)
				
				local sliderfunction = {}
				
				sliderfunction.Set = (function(a)
					DefaultValue = a
					if DefaultValue then 
						if DefaultValue <= Min_Value then DefaultValue = Min_Value elseif DefaultValue >= Max_Value then DefaultValue = Max_Value end
						Bar.Size = UDim2.new(1 - ((Max_Value - DefaultValue) / (Max_Value - Min_Value)),0, 1, 0)
						Sliderbox.Text = DefaultValue
						c.Callback(DefaultValue)
					end
				end)
				
				return sliderfunction
			end)
			
			sectionelements.CreateSelector = (function(c)
				c = c or {}
				c.Name = c.Name or "selectot"
				c.Table = c.Table or {"1", "ayoen", "ainf"}
				c.Callback = c.Callback or function(a) print(a) end
				
				local Selector = Instance.new("Frame")
				local SelectorStroke = Instance.new("UIStroke")
				local SelectorCorner = Instance.new("UICorner")
				local SelectorText = Instance.new("TextLabel")
				local SelectorMain = Instance.new("TextButton")
				local SelectorMainStroke = Instance.new("UIStroke")
				local SelectorMainCorner = Instance.new("UICorner")
				local SelectorMainLayout = Instance.new("UIListLayout")
				local SelectorMainLayoutSpacing = Instance.new("Frame")
				local SelectorMainLeft = Instance.new("ImageButton")
				local SelectorMainLeftStroke = Instance.new("UIStroke")
				local SelectorMainLeftCorner = Instance.new("UICorner")
				local SelectorMainValue = Instance.new("TextLabel")
				local SelectorMainRight = Instance.new("ImageButton")
				local SelectorMainStroke_2 = Instance.new("UIStroke")
				local SelectorMainCorner_2 = Instance.new("UICorner")
				
				Selector.Name = "Selector"
				Selector.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				Selector.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Selector.BorderSizePixel = 0
				Selector.Position = UDim2.new(0.0140449442, 0, 0.142730772, 0)
				Selector.Size = UDim2.new(1, -10, 0, 30)
				Selector.Parent = PageSection

				SelectorStroke.Name = "SelectorStroke"
				SelectorStroke.Parent = Selector
				SelectorStroke.Color = Color3.fromRGB(48, 47, 48)

				SelectorCorner.CornerRadius = UDim.new(0, 4)
				SelectorCorner.Name = "SelectorCorner"
				SelectorCorner.Parent = Selector

				SelectorText.Name = "SelectorText"
				SelectorText.Parent = Selector
				SelectorText.AnchorPoint = Vector2.new(0, 0.5)
				SelectorText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SelectorText.BackgroundTransparency = 1.000
				SelectorText.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SelectorText.BorderSizePixel = 0
				SelectorText.Position = UDim2.new(0, 0, 0.5, 0)
				SelectorText.Size = UDim2.new(1, -100, 1, 0)
				SelectorText.Font = Enum.Font.SourceSans
				SelectorText.Text = "   ".. c.Name
				SelectorText.TextColor3 = Color3.fromRGB(255, 255, 255)
				SelectorText.TextSize = 15.000
				SelectorText.TextWrapped = true
				SelectorText.TextXAlignment = Enum.TextXAlignment.Left

				SelectorMain.Name = "SelectorMain"
				SelectorMain.Parent = Selector
				SelectorMain.AnchorPoint = Vector2.new(1, 0.5)
				SelectorMain.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				SelectorMain.BackgroundTransparency = 0.950
				SelectorMain.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SelectorMain.BorderSizePixel = 0
				SelectorMain.Position = UDim2.new(1, -5, 0.5, 0)
				SelectorMain.Size = UDim2.new(0, 111, 0, 24)
				SelectorMain.AutoButtonColor = false
				SelectorMain.Font = Enum.Font.SourceSans
				SelectorMain.Text = ""
				SelectorMain.TextColor3 = Color3.fromRGB(255, 255, 255)
				SelectorMain.TextSize = 14.000

				SelectorMainStroke.Name = "SelectorMainStroke"
				SelectorMainStroke.Parent = SelectorMain
				SelectorMainStroke.Color = Color3.fromRGB(48, 47, 48)
				SelectorMainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

				SelectorMainCorner.CornerRadius = UDim.new(0, 4)
				SelectorMainCorner.Name = "SelectorMainCorner"
				SelectorMainCorner.Parent = SelectorMain

				SelectorMainLayout.Name = "SelectorMainLayout"
				SelectorMainLayout.Parent = SelectorMain
				SelectorMainLayout.FillDirection = Enum.FillDirection.Horizontal
				SelectorMainLayout.SortOrder = Enum.SortOrder.LayoutOrder
				SelectorMainLayout.VerticalAlignment = Enum.VerticalAlignment.Center
				SelectorMainLayout.Padding = UDim.new(0, 2)

				SelectorMainLayoutSpacing.Name = "SelectorMainLayoutSpacing"
				SelectorMainLayoutSpacing.Parent = SelectorMain
				SelectorMainLayoutSpacing.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SelectorMainLayoutSpacing.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SelectorMainLayoutSpacing.BorderSizePixel = 0

				SelectorMainLeft.Name = "SelectorMainLeft"
				SelectorMainLeft.Parent = SelectorMain
				SelectorMainLeft.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SelectorMainLeft.BackgroundTransparency = 1.000
				SelectorMainLeft.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SelectorMainLeft.BorderSizePixel = 0
				SelectorMainLeft.Size = UDim2.new(0, 20, 0, 20)
				SelectorMainLeft.Image = "rbxassetid://10709791281"

				SelectorMainLeftStroke.Name = "SelectorMainLeftStroke"
				SelectorMainLeftStroke.Parent = SelectorMainLeft
				SelectorMainLeftStroke.Color = Color3.fromRGB(48, 47, 48)
				SelectorMainLeftStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

				SelectorMainLeftCorner.CornerRadius = UDim.new(0, 4)
				SelectorMainLeftCorner.Name = "SelectorMainLeftCorner"
				SelectorMainLeftCorner.Parent = SelectorMainLeft

				SelectorMainValue.Name = "SelectorMainValue"
				SelectorMainValue.Parent = SelectorMain
				SelectorMainValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SelectorMainValue.BackgroundTransparency = 1.000
				SelectorMainValue.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SelectorMainValue.BorderSizePixel = 0
				SelectorMainValue.Size = UDim2.new(0, 63, 0, 15)
				SelectorMainValue.Font = Enum.Font.SourceSans
				SelectorMainValue.Text = ""
				SelectorMainValue.TextColor3 = Color3.fromRGB(255, 255, 255)
				SelectorMainValue.TextSize = 14.000

				SelectorMainRight.Name = "SelectorMainRight"
				SelectorMainRight.Parent = SelectorMain
				SelectorMainRight.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SelectorMainRight.BackgroundTransparency = 1.000
				SelectorMainRight.BorderColor3 = Color3.fromRGB(0, 0, 0)
				SelectorMainRight.BorderSizePixel = 0
				SelectorMainRight.Size = UDim2.new(0, 20, 0, 20)
				SelectorMainRight.Image = "rbxassetid://10709791437"

				SelectorMainStroke_2.Name = "SelectorMainStroke"
				SelectorMainStroke_2.Parent = SelectorMainRight
				SelectorMainStroke_2.Color = Color3.fromRGB(48, 47, 48)
				SelectorMainStroke_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

				SelectorMainCorner_2.CornerRadius = UDim.new(0, 4)
				SelectorMainCorner_2.Name = "SelectorMainCorner"
				SelectorMainCorner_2.Parent = SelectorMainRight
				
				local sexyTable = c.Table
				local currentSelectedIndex = 1
				local SelectorSelectedText = SelectorMainValue

				SelectorSelectedText.Text = sexyTable[currentSelectedIndex]
				SelectorSelectedText.Size = UDim2.new(0,SelectorSelectedText.TextBounds.X + 4, 0, 15)
				game.TweenService:Create(SelectorMain, TweenInfo.new(0.08, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
					Size = UDim2.new(0, SelectorMainLayout.AbsoluteContentSize.X + 3, 0, 24)
				}):Play()
				SelectorMainLeft.MouseButton1Click:Connect(function()
					if currentSelectedIndex ~= 1 then
						currentSelectedIndex = currentSelectedIndex - 1
						SelectorSelectedText.Text = sexyTable[currentSelectedIndex]
						c.Callback(sexyTable[currentSelectedIndex])
						SelectorSelectedText.Size = UDim2.new(0,SelectorSelectedText.TextBounds.X + 6, 0, 15)
						game.TweenService:Create(SelectorMain, TweenInfo.new(0.08, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
							Size = UDim2.new(0, SelectorMainLayout.AbsoluteContentSize.X + 3, 0, 24)
						}):Play()
					end
				end)
				SelectorMainRight.MouseButton1Click:Connect(function()
					if currentSelectedIndex ~= table.maxn(sexyTable) then
						currentSelectedIndex = currentSelectedIndex + 1
						SelectorSelectedText.Text = sexyTable[currentSelectedIndex]
						c.Callback(sexyTable[currentSelectedIndex])
						SelectorSelectedText.Size = UDim2.new(0,SelectorSelectedText.TextBounds.X + 4, 0, 15)
						game.TweenService:Create(SelectorMain, TweenInfo.new(0.08, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
							Size = UDim2.new(0, SelectorMainLayout.AbsoluteContentSize.X + 3, 0, 24)
						}):Play()
					end
				end)
				
			end)

			sectionelements.CreateLabel = (function(txt)
				local Label = Instance.new("Frame")
				local LabelStroke = Instance.new("UIStroke")
				local LabelCorner = Instance.new("UICorner")
				local LabelText_2 = Instance.new("TextLabel")

				Label.Name = "Label"
				Label.Parent = PageSection
				Label.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				Label.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Label.BorderSizePixel = 0
				Label.Position = UDim2.new(0.0140449442, 0, 0.142730772, 0)
				Label.Size = UDim2.new(1, -10, 0, 49)

				LabelStroke.Name = "LabelStroke"
				LabelStroke.Parent = Label
				LabelStroke.Color = Color3.fromRGB(48, 47, 48)

				LabelCorner.CornerRadius = UDim.new(0, 4)
				LabelCorner.Name = "LabelCorner"
				LabelCorner.Parent = Label

				LabelText_2.Name = "LabelText"
				LabelText_2.Parent = Label
				LabelText_2.AnchorPoint = Vector2.new(0, 0.5)
				LabelText_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				LabelText_2.BackgroundTransparency = 1.000
				LabelText_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				LabelText_2.BorderSizePixel = 0
				LabelText_2.Position = UDim2.new(0, 7, 0.5, 0)
				LabelText_2.Size = UDim2.new(1, -15, 1, 0)
				LabelText_2.Font = Enum.Font.SourceSans
				LabelText_2.Text = txt
				LabelText_2.TextColor3 = Color3.fromRGB(255, 255, 255)
				LabelText_2.TextSize = 14.000
				LabelText_2.TextWrapped = true
				LabelText_2.TextXAlignment = Enum.TextXAlignment.Left

				local updatesize = (function()
					Label.Size = UDim2.new(1, -10, 0, LabelText_2.TextBounds.Y + 7)
				end)

				updatesize()
				LabelText_2:GetPropertyChangedSignal("Text"):Connect(function()
					updatesize()
				end)
                
                LabelText_2:GetPropertyChangedSignal("TextBounds"):Connect(function()
                    updatesize()
                end)

				local labelfunction = {}

				labelfunction.Set = (function(txt)
					LabelText_2.Text = txt
					updatesize()
				end)

				return labelfunction
			end)

			local getplayerstable = (function()
				local tbl = {}
				for i,v in next, game:GetService("Players"):GetPlayers() do
					if v.Name ~= game:GetService("Players").LocalPlayer.Name then
						table.insert(tbl, v)
					end
				end
				return tbl
			end)

			sectionelements.CreateList = (function(c)
				c = c or {}
				c.Name = c.Name or "listo"
				c.List = c.List or getplayerstable()
				c.Multi = c.Multi or false -- this is not done yet
				c.Default = c.Default or "nil"
				c.NotifyOnApply = c.NotifyOnApply or true
				c.ApplyCallback = c.ApplyCallback or function(a) print(a) end
				c.RefreshCallback = c.RefreshCallback or getplayerstable
				
				local selected = c.Default
				local multiselected = type(c.Default) == "table" and c.Default or {}

				local List = Instance.new("Frame")
				local ListStroke = Instance.new("UIStroke")
				local ListCorner = Instance.new("UICorner")
				local ListText = Instance.new("TextLabel")
				local ListImage = Instance.new("ImageButton")
				local ListTrigger = Instance.new("TextButton")
				local ListShow = Instance.new("Frame")
				local ListShowCorner = Instance.new("UICorner")
				local ListInterface = Instance.new("Frame")
				local ListInterfaceStroke = Instance.new("UIStroke")
				local ListInterfaceCorner = Instance.new("UICorner")
				local ListInterfaceApply = Instance.new("TextButton")
				local ListInterfaceApplyStroke = Instance.new("UIStroke")
				local ListInterfaceApplyCorner = Instance.new("UICorner")
				local ListInterfaceRefresh = Instance.new("TextButton")
				local ListInterfaceRefreshStroke = Instance.new("UIStroke")
				local ListInterfaceRefreshCorner = Instance.new("UICorner")
				local ListInterfaceMain = Instance.new("Frame")
				local ListInterfaceMainStroke = Instance.new("UIStroke")
				local ListInterfaceMainCorner = Instance.new("UICorner")
				local ListInterfaceMainScroll = Instance.new("ScrollingFrame")
				local ListInterfaceMainScrollLayout = Instance.new("UIListLayout")
				local ListInterfaceMainScrollLayoutSeperator = Instance.new("Frame")
				local ListInterfaceSearch = Instance.new("Frame")
				local ListInterfaceSearchStroke = Instance.new("UIStroke")
				local ListInterfaceSearchCorner = Instance.new("UICorner")
				local ListInterfaceSearchBox = Instance.new("TextBox")
				local ListInterfaceSelected = Instance.new("TextLabel")

				List.Name = "List"
				List.Parent = PageSection
				List.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				List.BorderColor3 = Color3.fromRGB(0, 0, 0)
				List.BorderSizePixel = 0
				List.Position = UDim2.new(0.0140449442, 0, 0.142730772, 0)
				List.Size = UDim2.new(1, -10, 0, 30)

				ListStroke.Name = "ListStroke"
				ListStroke.Parent = List
				ListStroke.Color = Color3.fromRGB(48, 47, 48)

				ListCorner.CornerRadius = UDim.new(0, 4)
				ListCorner.Name = "ListCorner"
				ListCorner.Parent = List

				ListText.Name = "ListText"
				ListText.Parent = List
				ListText.AnchorPoint = Vector2.new(0, 0.5)
				ListText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ListText.BackgroundTransparency = 1.000
				ListText.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ListText.BorderSizePixel = 0
				ListText.Position = UDim2.new(0, 0, 0.5, 0)
				ListText.Size = UDim2.new(1, -50, 1, 0)
				ListText.Font = Enum.Font.SourceSans
				ListText.Text = "   ".. c.Name
				ListText.TextColor3 = Color3.fromRGB(255, 255, 255)
				ListText.TextSize = 15.000
				ListText.TextWrapped = true
				ListText.TextXAlignment = Enum.TextXAlignment.Left

				ListImage.Name = "ListImage"
				ListImage.Parent = List
				ListImage.AnchorPoint = Vector2.new(1, 0.5)
				ListImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ListImage.BackgroundTransparency = 1.000
				ListImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ListImage.BorderSizePixel = 0
				ListImage.Position = UDim2.new(1, -6, 0.5, 0)
				ListImage.Size = UDim2.new(0, 20, 0, 20)
				ListImage.AutoButtonColor = false
				ListImage.Image = "rbxassetid://10723433811"

				ListTrigger.Name = "ListTrigger"
				ListTrigger.Parent = List
				ListTrigger.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ListTrigger.BackgroundTransparency = 1.000
				ListTrigger.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ListTrigger.BorderSizePixel = 0
				ListTrigger.Size = UDim2.new(1, 0, 1, 0)
				ListTrigger.Font = Enum.Font.SourceSans
				ListTrigger.Text = ""
				ListTrigger.TextColor3 = Color3.fromRGB(0, 0, 0)
				ListTrigger.TextSize = 14.000

				ListShow.Name = "ListShow"
				ListShow.Parent = Main
				ListShow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				ListShow.BackgroundTransparency = 0.150
				ListShow.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ListShow.BorderSizePixel = 0
				ListShow.Size = UDim2.new(1, 0, 1, 0)
				ListShow.Visible = false

				ListShowCorner.Name = "ListShowCorner"
				ListShowCorner.Parent = ListShow

				ListInterface.Name = "ListInterface"
				ListInterface.Parent = ListShow
				ListInterface.AnchorPoint = Vector2.new(0.5, 0.5)
				ListInterface.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
				ListInterface.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ListInterface.BorderSizePixel = 0
				ListInterface.Position = UDim2.new(0.5, 0, 0.5, 0)
				ListInterface.Size = UDim2.new(1, -200, 1, -100)

				ListInterfaceStroke.Name = "ListInterfaceStroke"
				ListInterfaceStroke.Parent = ListInterface
				ListInterfaceStroke.Color = Color3.fromRGB(48, 47, 48)

				ListInterfaceCorner.CornerRadius = UDim.new(0, 5)
				ListInterfaceCorner.Name = "ListInterfaceCorner"
				ListInterfaceCorner.Parent = ListInterface

				ListInterfaceApply.Name = "ListInterfaceApply"
				ListInterfaceApply.Parent = ListInterface
				ListInterfaceApply.AnchorPoint = Vector2.new(1, 0)
				ListInterfaceApply.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
				ListInterfaceApply.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ListInterfaceApply.BorderSizePixel = 0
				ListInterfaceApply.Position = UDim2.new(1, -5, 0, 5)
				ListInterfaceApply.Size = UDim2.new(0, 45, 0, 27)
				ListInterfaceApply.AutoButtonColor = false
				ListInterfaceApply.Font = Enum.Font.SourceSans
				ListInterfaceApply.Text = "Apply"
				ListInterfaceApply.TextColor3 = Color3.fromRGB(255, 255, 255)
				ListInterfaceApply.TextSize = 14.000

				ListInterfaceApplyStroke.Name = "ListInterfaceApplyStroke"
				ListInterfaceApplyStroke.Parent = ListInterfaceApply
				ListInterfaceApplyStroke.Color = Color3.fromRGB(48, 47, 48)
				ListInterfaceApplyStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

				ListInterfaceApplyCorner.CornerRadius = UDim.new(0, 5)
				ListInterfaceApplyCorner.Name = "ListInterfaceApplyCorner"
				ListInterfaceApplyCorner.Parent = ListInterfaceApply

				ListInterfaceRefresh.Name = "ListInterfaceRefresh"
				ListInterfaceRefresh.Parent = ListInterface
				ListInterfaceRefresh.AnchorPoint = Vector2.new(1, 0)
				ListInterfaceRefresh.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
				ListInterfaceRefresh.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ListInterfaceRefresh.BorderSizePixel = 0
				ListInterfaceRefresh.Position = UDim2.new(1, -55, 0, 5)
				ListInterfaceRefresh.Size = UDim2.new(0, 50, 0, 27)
				ListInterfaceRefresh.AutoButtonColor = false
				ListInterfaceRefresh.Font = Enum.Font.SourceSans
				ListInterfaceRefresh.Text = "Refresh"
				ListInterfaceRefresh.TextColor3 = Color3.fromRGB(255, 255, 255)
				ListInterfaceRefresh.TextSize = 14.000

				ListInterfaceRefreshStroke.Name = "ListInterfaceRefreshStroke"
				ListInterfaceRefreshStroke.Parent = ListInterfaceRefresh
				ListInterfaceRefreshStroke.Color = Color3.fromRGB(48, 47, 48)
				ListInterfaceRefreshStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

				ListInterfaceRefreshCorner.CornerRadius = UDim.new(0, 5)
				ListInterfaceRefreshCorner.Name = "ListInterfaceRefreshCorner"
				ListInterfaceRefreshCorner.Parent = ListInterfaceRefresh

				ListInterfaceMain.Name = "ListInterfaceMain"
				ListInterfaceMain.Parent = ListInterface
				ListInterfaceMain.AnchorPoint = Vector2.new(0, 1)
				ListInterfaceMain.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
				ListInterfaceMain.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ListInterfaceMain.BorderSizePixel = 0
				ListInterfaceMain.Position = UDim2.new(0, 5, 1, -25)
				ListInterfaceMain.Size = UDim2.new(1, -10, 1, -65)

				ListInterfaceMainStroke.Name = "ListInterfaceMainStroke"
				ListInterfaceMainStroke.Parent = ListInterfaceMain
				ListInterfaceMainStroke.Color = Color3.fromRGB(48, 47, 48)

				ListInterfaceMainCorner.CornerRadius = UDim.new(0, 5)
				ListInterfaceMainCorner.Name = "ListInterfaceMainCorner"
				ListInterfaceMainCorner.Parent = ListInterfaceMain

				ListInterfaceMainScroll.Name = "ListInterfaceMainScroll"
				ListInterfaceMainScroll.Parent = ListInterfaceMain
				ListInterfaceMainScroll.Active = true
				ListInterfaceMainScroll.AnchorPoint = Vector2.new(0.5, 0.5)
				ListInterfaceMainScroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ListInterfaceMainScroll.BackgroundTransparency = 1.000
				ListInterfaceMainScroll.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ListInterfaceMainScroll.BorderSizePixel = 0
				ListInterfaceMainScroll.Position = UDim2.new(0.5, 0, 0.5, 0)
				ListInterfaceMainScroll.Size = UDim2.new(1, -5, 1, -5)
				ListInterfaceMainScroll.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
				ListInterfaceMainScroll.ScrollBarThickness = 0

				ListInterfaceMainScrollLayout.Name = "ListInterfaceMainScrollLayout"
				ListInterfaceMainScrollLayout.Parent = ListInterfaceMainScroll
				ListInterfaceMainScrollLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
				ListInterfaceMainScrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
				ListInterfaceMainScrollLayout.Padding = UDim.new(0, 2)

				ListInterfaceMainScrollLayoutSeperator.Name = "ListInterfaceMainScrollLayoutSeperator"
				ListInterfaceMainScrollLayoutSeperator.Parent = ListInterfaceMainScroll
				ListInterfaceMainScrollLayoutSeperator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ListInterfaceMainScrollLayoutSeperator.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ListInterfaceMainScrollLayoutSeperator.BorderSizePixel = 0
				ListInterfaceMainScrollLayoutSeperator.Size = UDim2.new(1, 0, 0, 0)

				ListInterfaceSearch.Name = "ListInterfaceSearch"
				ListInterfaceSearch.Parent = ListInterface
				ListInterfaceSearch.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
				ListInterfaceSearch.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ListInterfaceSearch.BorderSizePixel = 0
				ListInterfaceSearch.Position = UDim2.new(0, 5, 0, 5)
				ListInterfaceSearch.Size = UDim2.new(1, -115, 0, 27)

				ListInterfaceSearchStroke.Name = "ListInterfaceSearchStroke"
				ListInterfaceSearchStroke.Parent = ListInterfaceSearch
				ListInterfaceSearchStroke.Color = Color3.fromRGB(48, 47, 48)

				ListInterfaceSearchCorner.CornerRadius = UDim.new(0, 5)
				ListInterfaceSearchCorner.Name = "ListInterfaceSearchCorner"
				ListInterfaceSearchCorner.Parent = ListInterfaceSearch

				ListInterfaceSearchBox.Name = "ListInterfaceSearchBox"
				ListInterfaceSearchBox.Parent = ListInterfaceSearch
				ListInterfaceSearchBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ListInterfaceSearchBox.BackgroundTransparency = 1.000
				ListInterfaceSearchBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ListInterfaceSearchBox.BorderSizePixel = 0
				ListInterfaceSearchBox.Position = UDim2.new(0, 7, 0, 0)
				ListInterfaceSearchBox.Size = UDim2.new(1, -7, 1, 0)
				ListInterfaceSearchBox.ClearTextOnFocus = false
				ListInterfaceSearchBox.Font = Enum.Font.SourceSans
				ListInterfaceSearchBox.PlaceholderText = "Search..."
				ListInterfaceSearchBox.Text = ""
				ListInterfaceSearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
				ListInterfaceSearchBox.TextSize = 14.000
				ListInterfaceSearchBox.TextXAlignment = Enum.TextXAlignment.Left

				ListInterfaceSelected.Name = "ListInterfaceSelected"
				ListInterfaceSelected.Parent = ListInterface
				ListInterfaceSelected.AnchorPoint = Vector2.new(0, 1)
				ListInterfaceSelected.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ListInterfaceSelected.BackgroundTransparency = 1.000
				ListInterfaceSelected.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ListInterfaceSelected.BorderSizePixel = 0
				ListInterfaceSelected.Position = UDim2.new(0, 5, 1, -5)
				ListInterfaceSelected.Size = UDim2.new(1, -10, 0, 15)
				ListInterfaceSelected.Font = Enum.Font.SourceSans
				ListInterfaceSelected.Text = "Selected: "
				ListInterfaceSelected.TextColor3 = Color3.fromRGB(255, 255, 255)
				ListInterfaceSelected.TextSize = 14.000
				ListInterfaceSelected.TextXAlignment = Enum.TextXAlignment.Left

				ListInterfaceMainScrollLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					ListInterfaceMainScroll.CanvasSize = UDim2.new(0,0,0,ListInterfaceMainScrollLayout.AbsoluteContentSize.Y + 2)
				end)

				ListTrigger.MouseButton1Click:Connect(function()
					ListShow.Visible = not ListShow.Visible
				end)

				ListInterfaceSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
					local InputText = string.lower(ListInterfaceSearchBox.Text)
					for i,v in next, ListInterfaceMainScroll:GetChildren() do
						if v:IsA("TextButton") then
							v.Visible = string.find(string.lower(v.Name), InputText, 1, true) and true or false
						end
					end
				end)
				if c.Multi then
					for i,v in next, c.List do
						local ListInterfaceMainScrollButton = Instance.new("TextButton")
						local ListInterfaceMainScrollButton_2 = Instance.new("UIStroke")
						local ListInterfaceMainScrollButton_3 = Instance.new("UICorner")

						ListInterfaceMainScrollButton.Name = tostring(v)
						ListInterfaceMainScrollButton.Parent = ListInterfaceMainScroll
						ListInterfaceMainScrollButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
						ListInterfaceMainScrollButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
						ListInterfaceMainScrollButton.BorderSizePixel = 0
						ListInterfaceMainScrollButton.Size = UDim2.new(1, -2, 0, 30)
						ListInterfaceMainScrollButton.AutoButtonColor = false
						ListInterfaceMainScrollButton.Font = Enum.Font.SourceSans
						ListInterfaceMainScrollButton.Text = tostring(v)
						ListInterfaceMainScrollButton.TextColor3 = Color3.fromRGB(211, 211, 211)
						ListInterfaceMainScrollButton.TextSize = 14.000

						ListInterfaceMainScrollButton_2.Name = "ListInterfaceMainScrollButton"
						ListInterfaceMainScrollButton_2.Parent = ListInterfaceMainScrollButton
						ListInterfaceMainScrollButton_2.Color = Color3.fromRGB(48, 47, 48)
						ListInterfaceMainScrollButton_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

						ListInterfaceMainScrollButton_3.CornerRadius = UDim.new(0, 5)
						ListInterfaceMainScrollButton_3.Name = "ListInterfaceMainScrollButton"
						ListInterfaceMainScrollButton_3.Parent = ListInterfaceMainScrollButton

						local buttonisselected = false
						ListInterfaceMainScrollButton.MouseButton1Click:Connect(function()
							if table.find(multiselected, tostring(v)) then
								table.remove(multiselected, table.find(multiselected, tostring(v)))
							else
								table.insert(multiselected, tostring(v))
							end
							ListInterfaceSelected.Text = "Selected: ".. table.concat(multiselected, ", ")
							--thethingy.CreateNotification(c.Name, "Selected: ".. table.concat(multiselected, ", "), 5)
						end)
					end
				else
					for i,v in next, c.List do
						local ListInterfaceMainScrollButton = Instance.new("TextButton")
						local ListInterfaceMainScrollButton_2 = Instance.new("UIStroke")
						local ListInterfaceMainScrollButton_3 = Instance.new("UICorner")

						ListInterfaceMainScrollButton.Name = tostring(v)
						ListInterfaceMainScrollButton.Parent = ListInterfaceMainScroll
						ListInterfaceMainScrollButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
						ListInterfaceMainScrollButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
						ListInterfaceMainScrollButton.BorderSizePixel = 0
						ListInterfaceMainScrollButton.Size = UDim2.new(1, -2, 0, 30)
						ListInterfaceMainScrollButton.AutoButtonColor = false
						ListInterfaceMainScrollButton.Font = Enum.Font.SourceSans
						ListInterfaceMainScrollButton.Text = tostring(v)
						ListInterfaceMainScrollButton.TextColor3 = Color3.fromRGB(211, 211, 211)
						ListInterfaceMainScrollButton.TextSize = 14.000

						ListInterfaceMainScrollButton_2.Name = "ListInterfaceMainScrollButton"
						ListInterfaceMainScrollButton_2.Parent = ListInterfaceMainScrollButton
						ListInterfaceMainScrollButton_2.Color = Color3.fromRGB(48, 47, 48)
						ListInterfaceMainScrollButton_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

						ListInterfaceMainScrollButton_3.CornerRadius = UDim.new(0, 5)
						ListInterfaceMainScrollButton_3.Name = "ListInterfaceMainScrollButton"
						ListInterfaceMainScrollButton_3.Parent = ListInterfaceMainScrollButton

						ListInterfaceMainScrollButton.MouseButton1Click:Connect(function()
							ListInterfaceSelected.Text = "Selected: ".. tostring(v)
							selected = v
							--thethingy.CreateNotification(c.Name, "Selected: ".. tostring(v), 5)
						end)
					end
				end

				ListInterfaceRefresh.MouseButton1Click:Connect(function()
					local refreshedtable = c.RefreshCallback()
					table.sort(refreshedtable)
					if c.Multi then
						for i,v in next, refreshedtable do
							local ListInterfaceMainScrollButton2 = Instance.new("TextButton")
							local ListInterfaceMainScrollButton_22 = Instance.new("UIStroke")
							local ListInterfaceMainScrollButton_32 = Instance.new("UICorner")

							ListInterfaceMainScrollButton2.Name = tostring(v)
							ListInterfaceMainScrollButton2.Parent = ListInterfaceMainScroll
							ListInterfaceMainScrollButton2.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
							ListInterfaceMainScrollButton2.BorderColor3 = Color3.fromRGB(0, 0, 0)
							ListInterfaceMainScrollButton2.BorderSizePixel = 0
							ListInterfaceMainScrollButton2.Size = UDim2.new(1, -2, 0, 30)
							ListInterfaceMainScrollButton2.AutoButtonColor = false
							ListInterfaceMainScrollButton2.Font = Enum.Font.SourceSans
							ListInterfaceMainScrollButton2.Text = tostring(v)
							ListInterfaceMainScrollButton2.TextColor3 = Color3.fromRGB(211, 211, 211)
							ListInterfaceMainScrollButton2.TextSize = 14.000
							print(ListInterfaceMainScrollButton2.Text)

							ListInterfaceMainScrollButton_22.Name = "ListInterfaceMainScrollButton"
							ListInterfaceMainScrollButton_22.Parent = ListInterfaceMainScrollButton2
							ListInterfaceMainScrollButton_22.Color = Color3.fromRGB(48, 47, 48)
							ListInterfaceMainScrollButton_22.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

							ListInterfaceMainScrollButton_32.CornerRadius = UDim.new(0, 5)
							ListInterfaceMainScrollButton_32.Name = "ListInterfaceMainScrollButton"
							ListInterfaceMainScrollButton_32.Parent = ListInterfaceMainScrollButton2

							local buttonisselected = false
							ListInterfaceMainScrollButton2.MouseButton1Click:Connect(function()
								if table.find(multiselected, tostring(v)) then
									table.remove(multiselected, table.find(multiselected, tostring(v)))
								else
									table.insert(multiselected, tostring(v))
								end

								ListInterfaceSelected.Text = "Selected: ".. table.concat(multiselected, ", ")
								--thethingy.CreateNotification(c.Name, "Selected: ".. table.concat(multiselected, ", "), 5)
							end)
						end
						multiselected = {}
						ListInterfaceSelected.Text = "Selected: ".. table.concat(multiselected, ", ")
					else
						for i,v in next, refreshedtable do
							local ListInterfaceMainScrollButton = Instance.new("TextButton")
							local ListInterfaceMainScrollButton_2 = Instance.new("UIStroke")
							local ListInterfaceMainScrollButton_3 = Instance.new("UICorner")

							ListInterfaceMainScrollButton.Name = tostring(v)
							ListInterfaceMainScrollButton.Parent = ListInterfaceMainScroll
							ListInterfaceMainScrollButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
							ListInterfaceMainScrollButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
							ListInterfaceMainScrollButton.BorderSizePixel = 0
							ListInterfaceMainScrollButton.Size = UDim2.new(1, -2, 0, 30)
							ListInterfaceMainScrollButton.AutoButtonColor = false
							ListInterfaceMainScrollButton.Font = Enum.Font.SourceSans
							ListInterfaceMainScrollButton.Text = tostring(v)
							ListInterfaceMainScrollButton.TextColor3 = Color3.fromRGB(211, 211, 211)
							ListInterfaceMainScrollButton.TextSize = 14.000

							ListInterfaceMainScrollButton_2.Name = "ListInterfaceMainScrollButton"
							ListInterfaceMainScrollButton_2.Parent = ListInterfaceMainScrollButton
							ListInterfaceMainScrollButton_2.Color = Color3.fromRGB(48, 47, 48)
							ListInterfaceMainScrollButton_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

							ListInterfaceMainScrollButton_3.CornerRadius = UDim.new(0, 5)
							ListInterfaceMainScrollButton_3.Name = "ListInterfaceMainScrollButton"
							ListInterfaceMainScrollButton_3.Parent = ListInterfaceMainScrollButton

							ListInterfaceMainScrollButton.MouseButton1Click:Connect(function()
								ListInterfaceSelected.Text = "Selected: ".. tostring(v)
								selected = v
								--thethingy.CreateNotification(c.Name, "Selected: ".. tostring(v), 5)
							end)
						end
					end
					local seenednames = {}
					for i,v in next, ListInterfaceMainScroll:GetChildren() do
						if seenednames[v.Name] then
							v:Destroy()
						else
							seenednames[v.Name] = true
						end
					end
				end)

				ListInterfaceApply.MouseButton1Click:Connect(function()
					c.ApplyCallback(c.Multi and multiselected or selected)
					print(c.Multi and multiselected or selected)
					if c.NotifyOnApply then
						if c.Multi then
							thethingy.CreateNotification(c.Name, "Selected: ".. table.concat(multiselected, ", "), 5)
						else
							thethingy.CreateNotification(c.Name, "Selected: ".. tostring(selected), 5)
						end
					end
					ListShow.Visible = not ListShow.Visible
				end)
			end)

			sectionelements.CreateKeybind = (function(c)
				c = c or {}
				c.Name = c.Name or "key"
				c.Default = c.Default or Enum.KeyCode.E
				c.Callback = c.Callback or function() print("triggered") end

				local Keybind = Instance.new("Frame")
				local KeybindStroke = Instance.new("UIStroke")
				local KeybindCorner = Instance.new("UICorner")
				local KeybindText = Instance.new("TextLabel")
				local KeybindImage = Instance.new("ImageButton")
				local KeybindTrigger = Instance.new("TextButton")
				local KeybindStroke_sad = Instance.new("UIStroke")
				local KeybindCorner_sad = Instance.new("UICorner")

				Keybind.Name = "Keybind"
				Keybind.Parent = PageSection
				Keybind.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				Keybind.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Keybind.BorderSizePixel = 0
				Keybind.Position = UDim2.new(0.0140449442, 0, 0.142730772, 0)
				Keybind.Size = UDim2.new(1, -10, 0, 30)

				KeybindStroke.Name = "KeybindStroke"
				KeybindStroke.Parent = Keybind
				KeybindStroke.Color = Color3.fromRGB(48, 47, 48)

				KeybindCorner.CornerRadius = UDim.new(0, 4)
				KeybindCorner.Name = "KeybindCorner"
				KeybindCorner.Parent = Keybind

				KeybindText.Name = "KeybindText"
				KeybindText.Parent = Keybind
				KeybindText.AnchorPoint = Vector2.new(0, 0.5)
				KeybindText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				KeybindText.BackgroundTransparency = 1.000
				KeybindText.BorderColor3 = Color3.fromRGB(0, 0, 0)
				KeybindText.BorderSizePixel = 0
				KeybindText.Position = UDim2.new(0, 0, 0.5, 0)
				KeybindText.Size = UDim2.new(1, -100, 1, 0)
				KeybindText.Font = Enum.Font.SourceSans
				KeybindText.Text = "   ".. c.Name
				KeybindText.TextColor3 = Color3.fromRGB(255, 255, 255)
				KeybindText.TextSize = 15.000
				KeybindText.TextWrapped = true
				KeybindText.TextXAlignment = Enum.TextXAlignment.Left

				KeybindImage.Name = "KeybindImage"
				KeybindImage.Parent = Keybind
				KeybindImage.AnchorPoint = Vector2.new(1, 0.5)
				KeybindImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				KeybindImage.BackgroundTransparency = 1.000
				KeybindImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
				KeybindImage.BorderSizePixel = 0
				KeybindImage.Position = UDim2.new(1, -6, 0.5, 0)
				KeybindImage.Size = UDim2.new(0, 20, 0, 20)
				KeybindImage.Visible = false
				KeybindImage.AutoButtonColor = false
				KeybindImage.Image = "rbxassetid://10734898355"

				KeybindTrigger.Name = "KeybindTrigger"
				KeybindTrigger.Parent = Keybind
				KeybindTrigger.AnchorPoint = Vector2.new(1, 0.5)
				KeybindTrigger.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				KeybindTrigger.BackgroundTransparency = 0.950
				KeybindTrigger.BorderColor3 = Color3.fromRGB(0, 0, 0)
				KeybindTrigger.BorderSizePixel = 0
				KeybindTrigger.Position = UDim2.new(1, -5, 0.5, 0)
				KeybindTrigger.Size = UDim2.new(0, 81, 0, 24)
				KeybindTrigger.AutoButtonColor = false
				KeybindTrigger.Font = Enum.Font.SourceSans
				KeybindTrigger.Text = c.Default.Name
				KeybindTrigger.TextColor3 = Color3.fromRGB(255, 255, 255)
				KeybindTrigger.TextSize = 14.000

				KeybindStroke_sad.Name = "KeybindStroke"
				KeybindStroke_sad.Parent = KeybindTrigger
				KeybindStroke_sad.Color = Color3.fromRGB(48, 47, 48)
				KeybindStroke_sad.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

				KeybindCorner_sad.CornerRadius = UDim.new(0, 4)
				KeybindCorner_sad.Name = "KeybindCorner"
				KeybindCorner_sad.Parent = KeybindTrigger

				local keybindBtnn = KeybindTrigger
				local xcvcxv = Enum.KeyCode.E
				local focusing2 = false
				keybindBtnn.MouseButton1Click:connect(function(e) 
					keybindBtnn.Text = ". . ."
					focusing2 = true
					local aa = game:GetService('UserInputService').InputBegan:Wait();
					if aa.KeyCode.Name ~= "Unknown" then
						print(aa.KeyCode.Name)
						keybindBtnn.Text = aa.KeyCode.Name
						xcvcxv = aa.KeyCode
						task.delay(0.1, function()
							game.TweenService:Create(keybindBtnn, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Size = UDim2.new(0, keybindBtnn.TextBounds.X + 20,0, 24)}):Play()
							task.wait(0.1)
							focusing2 = false
						end)
					end
				end)
				game:GetService("UserInputService").InputBegan:Connect(function(key, ok) 
					if not ok then 
						if key.KeyCode.Name == xcvcxv.Name and focusing2 == false then 
							c.Callback()
						end
					end
				end)

			end)

			return sectionelements
		end)
		
		return section
	end)
	
	return page
end)
return thethingy
