-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

--------------------------------------------------------------------------------
-- 1. CLEANUP & INITIALIZATION
--------------------------------------------------------------------------------
if PlayerGui:FindFirstChild("NOT_ANASYT_Gui") then
	PlayerGui.NOT_ANASYT_Gui:Destroy()
end

pcall(function()
	StarterGui:SetCore("SendNotification", {
		Title = "NOT_ANASYT Controls",
		Text = "Loaded Custom Preset with Key Toggling!",
		Duration = 4
	})
end)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NOT_ANASYT_Gui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 9999
screenGui.Parent = PlayerGui

-- Watermark
local watermark = Instance.new("TextLabel")
watermark.Name = "Watermark"
watermark.Size = UDim2.new(0, 200, 0, 20)
watermark.Position = UDim2.new(0, 10, 1, -30)
watermark.BackgroundTransparency = 1
watermark.Text = "Made by NOT_ANASYT"
watermark.TextColor3 = Color3.fromRGB(255, 255, 255)
watermark.TextTransparency = 0.4
watermark.TextSize = 12
watermark.TextXAlignment = Enum.TextXAlignment.Left
watermark.Parent = screenGui

--------------------------------------------------------------------------------
-- 2. THEMES & HIGH-CLARITY FONTS
--------------------------------------------------------------------------------
local availableFonts = {
	{ Name = "Gotham Bold (Clean)", Font = Enum.Font.GothamBold },
	{ Name = "Fredoka One (Bold)", Font = Enum.Font.FredokaOne },
	{ Name = "Source Sans Bold (Crisp)", Font = Enum.Font.SourceSansBold },
	{ Name = "Oswald (Tall)", Font = Enum.Font.Oswald },
	{ Name = "Cartoon (Friendly)", Font = Enum.Font.Cartoon },
	{ Name = "Arcade (Retro)", Font = Enum.Font.Arcade },
	{ Name = "Special Elite (Typewriter)", Font = Enum.Font.SpecialElite }
}

local currentStyleMode = 1
local currentFontIndex = 1
local currentAccent = Color3.fromRGB(0, 255, 170)
local currentBgDark = Color3.fromRGB(15, 15, 20)
local currentBgFrame = Color3.fromRGB(22, 22, 28)
local currentBgButton = Color3.fromRGB(35, 35, 45)

local trackedCorners = {}
local trackedStrokes = {}
local trackedLabels = {}

local function registerCorner(uiCorner, defaultRadius)
	table.insert(trackedCorners, { Instance = uiCorner, DefaultRadius = defaultRadius })
	uiCorner.CornerRadius = (currentStyleMode == 1) and defaultRadius or UDim.new(0, 0)
end

local function registerStroke(uiStroke)
	table.insert(trackedStrokes, uiStroke)
	uiStroke.Color = currentAccent
	uiStroke.Thickness = (currentStyleMode == 3) and 3 or 1.5
end

local function registerLabel(textLabel)
	table.insert(trackedLabels, textLabel)
	textLabel.Font = availableFonts[currentFontIndex].Font
end

registerLabel(watermark)

local function applyStyleAndTheme()
	for _, data in ipairs(trackedCorners) do
		if data.Instance and data.Instance.Parent then
			data.Instance.CornerRadius = (currentStyleMode == 1) and data.DefaultRadius or UDim.new(0, 0)
		end
	end
	for _, stroke in ipairs(trackedStrokes) do
		if stroke and stroke.Parent then
			stroke.Color = currentAccent
			stroke.Thickness = (currentStyleMode == 3) and 3 or 1.5
		end
	end
	for _, label in ipairs(trackedLabels) do
		if label and label.Parent then
			label.Font = availableFonts[currentFontIndex].Font
		end
	end
end

--------------------------------------------------------------------------------
-- 3. DRAGGING ENGINE
--------------------------------------------------------------------------------
local editModeActive = false

local function makeGuiDraggable(guiElement, onDragEnd)
	local dragging, dragStart, startPos, touchObject = false, nil, nil, nil

	guiElement.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			if editModeActive or guiElement.Name == "Toolbar" or guiElement.Name == "VirtualKeyboardFrame" or guiElement.Name == "StyleMenu" or guiElement.Name == "SizeMenu" then
				dragging = true
				dragStart = input.Position
				startPos = guiElement.Position
				touchObject = input
			end
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input == touchObject or input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
			local delta = input.Position - dragStart
			guiElement.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)

	local function endDrag(input)
		if dragging and (input == touchObject or input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
			dragging = false
			touchObject = nil
			if onDragEnd then onDragEnd() end
		end
	end

	guiElement.InputEnded:Connect(endDrag)
	UserInputService.InputEnded:Connect(endDrag)
end

--------------------------------------------------------------------------------
-- 4. CAMERA-RELATIVE JOYSTICK
--------------------------------------------------------------------------------
local joyBase = Instance.new("Frame")
joyBase.Name = "NOT_ANASYT_JoystickBase"
joyBase.Size = UDim2.new(0, 120, 0, 120)
joyBase.Position = UDim2.new(0.08, 0, 0.62, 0)
joyBase.BackgroundColor3 = currentBgDark
joyBase.BackgroundTransparency = 0.35
joyBase.Active = true
joyBase.Parent = screenGui

local joyCorner = Instance.new("UICorner", joyBase)
registerCorner(joyCorner, UDim.new(1, 0))

local joyStroke = Instance.new("UIStroke")
joyStroke.Thickness = 2
joyStroke.Parent = joyBase
registerStroke(joyStroke)

local joyThumb = Instance.new("Frame")
joyThumb.Name = "NOT_ANASYT_JoystickThumb"
joyThumb.Size = UDim2.new(0, 48, 0, 48)
joyThumb.Position = UDim2.new(0.5, -24, 0.5, -24)
joyThumb.BackgroundColor3 = currentAccent
joyThumb.Parent = joyBase

local thumbCorner = Instance.new("UICorner", joyThumb)
registerCorner(thumbCorner, UDim.new(1, 0))

makeGuiDraggable(joyBase)

local activeJoyTouch = nil
local moveVector = Vector2.new(0, 0)

joyBase.InputBegan:Connect(function(input)
	if not editModeActive and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) then
		if not activeJoyTouch then
			activeJoyTouch = input
		end
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if not editModeActive and input == activeJoyTouch then
		local baseCenter = joyBase.AbsolutePosition + (joyBase.AbsoluteSize / 2)
		local inputPos = Vector2.new(input.Position.X, input.Position.Y)
		local delta = inputPos - baseCenter
		local maxRadius = joyBase.AbsoluteSize.X / 2

		if delta.Magnitude > maxRadius then
			delta = delta.Unit * maxRadius
		end

		joyThumb.Position = UDim2.new(0.5, delta.X - 24, 0.5, delta.Y - 24)
		moveVector = Vector2.new(delta.X / maxRadius, delta.Y / maxRadius)
	end
end)

local function resetJoystick()
	activeJoyTouch = nil
	moveVector = Vector2.new(0, 0)
	joyThumb.Position = UDim2.new(0.5, -24, 0.5, -24)
end

UserInputService.InputEnded:Connect(function(input)
	if input == activeJoyTouch then
		resetJoystick()
	end
end)

RunService.RenderStepped:Connect(function()
	if moveVector.Magnitude > 0.1 then
		local character = LocalPlayer.Character
		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			local camera = Workspace.CurrentCamera
			if humanoid and camera then
				local cameraCFrame = camera.CFrame
				local forward = cameraCFrame.LookVector
				local right = cameraCFrame.RightVector
				
				forward = Vector3.new(forward.X, 0, forward.Z).Unit
				right = Vector3.new(right.X, 0, right.Z).Unit

				local worldDirection = (forward * -moveVector.Y) + (right * moveVector.X)
				humanoid:Move(worldDirection, false)
			end
		end
	end
end)

--------------------------------------------------------------------------------
-- 5. BUTTON PROPERTIES & TOGGLE MENU
--------------------------------------------------------------------------------
local activeEditingButton = nil

local sizeMenu = Instance.new("Frame")
sizeMenu.Name = "SizeMenu"
sizeMenu.Size = UDim2.new(0, 220, 0, 145)
sizeMenu.Position = UDim2.new(0.5, -110, 0.4, -72)
sizeMenu.BackgroundColor3 = currentBgFrame
sizeMenu.Visible = false
sizeMenu.Active = true
sizeMenu.Parent = screenGui

local smCorner = Instance.new("UICorner", sizeMenu)
registerCorner(smCorner, UDim.new(0, 10))

local smStroke = Instance.new("UIStroke")
smStroke.Thickness = 1.5
smStroke.Parent = sizeMenu
registerStroke(smStroke)

makeGuiDraggable(sizeMenu)

local smTitle = Instance.new("TextLabel")
smTitle.Size = UDim2.new(1, 0, 0, 25)
smTitle.BackgroundTransparency = 1
smTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
smTitle.TextSize = 12
smTitle.Text = "📐 Edit Button Properties"
smTitle.Parent = sizeMenu
registerLabel(smTitle)

local remapBtn = Instance.new("TextButton")
remapBtn.Size = UDim2.new(0.45, 0, 0, 24)
remapBtn.Position = UDim2.new(0.04, 0, 0.22, 0)
remapBtn.BackgroundColor3 = currentBgButton
remapBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
remapBtn.TextSize = 10
remapBtn.Text = "⌨️ Bind Key"
remapBtn.Parent = sizeMenu
registerLabel(remapBtn)
local rmCorner = Instance.new("UICorner", remapBtn)
registerCorner(rmCorner, UDim.new(0, 5))

local deleteBtn = Instance.new("TextButton")
deleteBtn.Size = UDim2.new(0.45, 0, 0, 24)
deleteBtn.Position = UDim2.new(0.51, 0, 0.22, 0)
deleteBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
deleteBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
deleteBtn.TextSize = 10
deleteBtn.Text = "🗑️ Delete"
deleteBtn.Parent = sizeMenu
registerLabel(deleteBtn)
local delCorner = Instance.new("UICorner", deleteBtn)
registerCorner(delCorner, UDim.new(0, 5))

local toggleModeBtn = Instance.new("TextButton")
toggleModeBtn.Size = UDim2.new(0.92, 0, 0, 24)
toggleModeBtn.Position = UDim2.new(0.04, 0, 0.42, 0)
toggleModeBtn.BackgroundColor3 = currentBgButton
toggleModeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleModeBtn.TextSize = 10
toggleModeBtn.Text = "🔄 Mode: Hold to Input"
toggleModeBtn.Parent = sizeMenu
registerLabel(toggleModeBtn)
local tmCorner = Instance.new("UICorner", toggleModeBtn)
registerCorner(tmCorner, UDim.new(0, 5))

local sizeLabel = Instance.new("TextLabel")
sizeLabel.Size = UDim2.new(1, 0, 0, 18)
sizeLabel.Position = UDim2.new(0, 0, 0.62, 0)
sizeLabel.BackgroundTransparency = 1
sizeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
sizeLabel.TextSize = 10
sizeLabel.Text = "Resize (30px - 120px):"
sizeLabel.Parent = sizeMenu
registerLabel(sizeLabel)

local minusSize = Instance.new("TextButton")
minusSize.Size = UDim2.new(0, 30, 0, 22)
minusSize.Position = UDim2.new(0.1, 0, 0.78, 0)
minusSize.BackgroundColor3 = currentBgButton
minusSize.TextColor3 = Color3.fromRGB(255, 255, 255)
minusSize.Text = "-"
minusSize.Parent = sizeMenu
registerLabel(minusSize)

local plusSize = Instance.new("TextButton")
plusSize.Size = UDim2.new(0, 30, 0, 22)
plusSize.Position = UDim2.new(0.8, 0, 0.78, 0)
plusSize.BackgroundColor3 = currentBgButton
plusSize.TextColor3 = Color3.fromRGB(255, 255, 255)
plusSize.Text = "+"
plusSize.Parent = sizeMenu
registerLabel(plusSize)

--------------------------------------------------------------------------------
-- 6. 100% PC KEYBOARD UI
--------------------------------------------------------------------------------
local keyboardFrame = Instance.new("Frame")
keyboardFrame.Name = "VirtualKeyboardFrame"
keyboardFrame.Size = UDim2.new(0, 780, 0, 280)
keyboardFrame.Position = UDim2.new(0.5, -390, 0.5, -140)
keyboardFrame.BackgroundColor3 = currentBgFrame
keyboardFrame.Visible = false
keyboardFrame.Active = true
keyboardFrame.Parent = screenGui

local kbCorner = Instance.new("UICorner", keyboardFrame)
registerCorner(kbCorner, UDim.new(0, 10))

local kbStroke = Instance.new("UIStroke")
kbStroke.Thickness = 1.5
kbStroke.Parent = keyboardFrame
registerStroke(kbStroke)

makeGuiDraggable(keyboardFrame)

local kbTitle = Instance.new("TextLabel")
kbTitle.Size = UDim2.new(1, -30, 0, 30)
kbTitle.Position = UDim2.new(0, 10, 0, 0)
kbTitle.BackgroundTransparency = 1
kbTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
kbTitle.TextSize = 12
kbTitle.TextXAlignment = Enum.TextXAlignment.Left
kbTitle.Text = "⚡ Select a Key to Bind"
kbTitle.Parent = keyboardFrame
registerLabel(kbTitle)

local closeKbBtn = Instance.new("TextButton")
closeKbBtn.Size = UDim2.new(0, 24, 0, 24)
closeKbBtn.Position = UDim2.new(1, -28, 0, 3)
closeKbBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeKbBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeKbBtn.Text = "X"
closeKbBtn.TextSize = 11
closeKbBtn.Parent = keyboardFrame
registerLabel(closeKbBtn)

closeKbBtn.MouseButton1Click:Connect(function() keyboardFrame.Visible = false end)

local keyboardContainer = Instance.new("Frame")
keyboardContainer.Size = UDim2.new(1, -20, 1, -40)
keyboardContainer.Position = UDim2.new(0, 10, 0, 35)
keyboardContainer.BackgroundTransparency = 1
keyboardContainer.Parent = keyboardFrame

local fullKeyboardLayout = {
	{
		{Text = "Esc", Key = Enum.KeyCode.Escape, Width = 1},
		{Text = "F1", Key = Enum.KeyCode.F1, Width = 1}, {Text = "F2", Key = Enum.KeyCode.F2, Width = 1},
		{Text = "F3", Key = Enum.KeyCode.F3, Width = 1}, {Text = "F4", Key = Enum.KeyCode.F4, Width = 1},
		{Text = "F5", Key = Enum.KeyCode.F5, Width = 1}, {Text = "F6", Key = Enum.KeyCode.F6, Width = 1},
		{Text = "F7", Key = Enum.KeyCode.F7, Width = 1}, {Text = "F8", Key = Enum.KeyCode.F8, Width = 1},
		{Text = "F9", Key = Enum.KeyCode.F9, Width = 1}, {Text = "F10", Key = Enum.KeyCode.F10, Width = 1},
		{Text = "F11", Key = Enum.KeyCode.F11, Width = 1}, {Text = "F12", Key = Enum.KeyCode.F12, Width = 1},
		{Text = "L-CLK", IsMouse = true, MouseType = "Mouse1", Width = 1.25, Color = Color3.fromRGB(0, 140, 110)},
		{Text = "R-CLK", IsMouse = true, MouseType = "Mouse2", Width = 1.25, Color = Color3.fromRGB(0, 140, 110)}
	},
	{
		{Text = "`", Key = Enum.KeyCode.Backquote, Width = 1},
		{Text = "1", Key = Enum.KeyCode.One, Width = 1}, {Text = "2", Key = Enum.KeyCode.Two, Width = 1},
		{Text = "3", Key = Enum.KeyCode.Three, Width = 1}, {Text = "4", Key = Enum.KeyCode.Four, Width = 1},
		{Text = "5", Key = Enum.KeyCode.Five, Width = 1}, {Text = "6", Key = Enum.KeyCode.Six, Width = 1},
		{Text = "7", Key = Enum.KeyCode.Seven, Width = 1}, {Text = "8", Key = Enum.KeyCode.Eight, Width = 1},
		{Text = "9", Key = Enum.KeyCode.Nine, Width = 1}, {Text = "0", Key = Enum.KeyCode.Zero, Width = 1},
		{Text = "-", Key = Enum.KeyCode.Minus, Width = 1}, {Text = "=", Key = Enum.KeyCode.Equals, Width = 1},
		{Text = "Backspace", Key = Enum.KeyCode.Backspace, Width = 2}
	},
	{
		{Text = "Tab", Key = Enum.KeyCode.Tab, Width = 1.5},
		{Text = "Q", Key = Enum.KeyCode.Q, Width = 1}, {Text = "W", Key = Enum.KeyCode.W, Width = 1},
		{Text = "E", Key = Enum.KeyCode.E, Width = 1}, {Text = "R", Key = Enum.KeyCode.R, Width = 1},
		{Text = "T", Key = Enum.KeyCode.T, Width = 1}, {Text = "Y", Key = Enum.KeyCode.Y, Width = 1},
		{Text = "U", Key = Enum.KeyCode.U, Width = 1}, {Text = "I", Key = Enum.KeyCode.I, Width = 1},
		{Text = "O", Key = Enum.KeyCode.O, Width = 1}, {Text = "P", Key = Enum.KeyCode.P, Width = 1},
		{Text = "[", Key = Enum.KeyCode.LeftBracket, Width = 1}, {Text = "]", Key = Enum.KeyCode.RightBracket, Width = 1},
		{Text = "\\", Key = Enum.KeyCode.BackSlash, Width = 1.5}
	},
	{
		{Text = "Caps", Key = Enum.KeyCode.CapsLock, Width = 1.75},
		{Text = "A", Key = Enum.KeyCode.A, Width = 1}, {Text = "S", Key = Enum.KeyCode.S, Width = 1},
		{Text = "D", Key = Enum.KeyCode.D, Width = 1}, {Text = "F", Key = Enum.KeyCode.F, Width = 1},
		{Text = "G", Key = Enum.KeyCode.G, Width = 1}, {Text = "H", Key = Enum.KeyCode.H, Width = 1},
		{Text = "J", Key = Enum.KeyCode.J, Width = 1}, {Text = "K", Key = Enum.KeyCode.K, Width = 1},
		{Text = "L", Key = Enum.KeyCode.L, Width = 1}, {Text = ";", Key = Enum.KeyCode.Semicolon, Width = 1},
		{Text = "'", Key = Enum.KeyCode.Quote, Width = 1}, {Text = "Enter", Key = Enum.KeyCode.Return, Width = 2.25}
	},
	{
		{Text = "Shift", Key = Enum.KeyCode.LeftShift, Width = 2.25},
		{Text = "Z", Key = Enum.KeyCode.Z, Width = 1}, {Text = "X", Key = Enum.KeyCode.X, Width = 1},
		{Text = "C", Key = Enum.KeyCode.C, Width = 1}, {Text = "V", Key = Enum.KeyCode.V, Width = 1},
		{Text = "B", Key = Enum.KeyCode.B, Width = 1}, {Text = "N", Key = Enum.KeyCode.N, Width = 1},
		{Text = "M", Key = Enum.KeyCode.M, Width = 1}, {Text = ",", Key = Enum.KeyCode.Comma, Width = 1},
		{Text = ".", Key = Enum.KeyCode.Period, Width = 1}, {Text = "/", Key = Enum.KeyCode.Slash, Width = 1},
		{Text = "Shift", Key = Enum.KeyCode.RightShift, Width = 2.75}
	},
	{
		{Text = "Ctrl", Key = Enum.KeyCode.LeftControl, Width = 1.5},
		{Text = "Alt", Key = Enum.KeyCode.LeftAlt, Width = 1.25},
		{Text = "Space", Key = Enum.KeyCode.Space, Width = 6.25},
		{Text = "Alt", Key = Enum.KeyCode.RightAlt, Width = 1.25},
		{Text = "Ctrl", Key = Enum.KeyCode.RightControl, Width = 1.5},
		{Text = "▲", Key = Enum.KeyCode.Up, Width = 1},
		{Text = "▼", Key = Enum.KeyCode.Down, Width = 1},
		{Text = "◄", Key = Enum.KeyCode.Left, Width = 1},
		{Text = "►", Key = Enum.KeyCode.Right, Width = 1}
	}
}

local yOffset = 0
for _, row in ipairs(fullKeyboardLayout) do
	local rowFrame = Instance.new("Frame")
	rowFrame.Size = UDim2.new(1, 0, 0, 34)
	rowFrame.Position = UDim2.new(0, 0, 0, yOffset)
	rowFrame.BackgroundTransparency = 1
	rowFrame.Parent = keyboardContainer

	local xOffset = 0
	for _, keyData in ipairs(row) do
		local keyBtn = Instance.new("TextButton")
		keyBtn.Size = UDim2.new(0, keyData.Width * 44, 0, 30)
		keyBtn.Position = UDim2.new(0, xOffset, 0, 2)
		keyBtn.BackgroundColor3 = keyData.Color or currentBgButton
		keyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		keyBtn.TextSize = 10
		keyBtn.Text = keyData.Text
		keyBtn.Parent = rowFrame
		registerLabel(keyBtn)

		local kCorner = Instance.new("UICorner", keyBtn)
		registerCorner(kCorner, UDim.new(0, 4))

		keyBtn.MouseButton1Click:Connect(function()
			if activeEditingButton then
				activeEditingButton.SetKey(keyData.Text, keyData.Key, keyData.IsMouse, keyData.MouseType)
				keyboardFrame.Visible = false
			end
		end)

		xOffset = xOffset + (keyData.Width * 44) + 4
	end
	yOffset = yOffset + 38
end

--------------------------------------------------------------------------------
-- 7. CUSTOM BUTTON CREATION, SIZING & TOGGLING LOGIC
--------------------------------------------------------------------------------
local createdButtons = {}

function createCustomButton(labelName, keyEnum, isMouse, mouseType, defaultPos, defaultSize)
	local sizePx = defaultSize or 54
	local isToggle = false
	local isToggledActive = false

	local btn = Instance.new("TextButton")
	btn.Name = "NOT_ANASYT_CustomButton"
	btn.Size = UDim2.new(0, sizePx, 0, sizePx)
	btn.Position = defaultPos or UDim2.new(0.8, 0, 0.5, 0)
	btn.BackgroundColor3 = currentBgButton
	btn.BackgroundTransparency = 0.2
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextSize = math.clamp(math.floor(sizePx * 0.22), 9, 24)
	btn.Text = labelName or "KEY"
	btn.Parent = screenGui
	registerLabel(btn)

	local bCorner = Instance.new("UICorner", btn)
	registerCorner(bCorner, UDim.new(0, 10))

	local bStroke = Instance.new("UIStroke")
	bStroke.Thickness = 1.5
	bStroke.Parent = btn
	registerStroke(bStroke)

	local boundKey = keyEnum or Enum.KeyCode.E
	local boundIsMouse = isMouse or false
	local boundMouseType = mouseType or "Mouse1"

	local function SetKey(newLabel, newKey, newIsMouse, newMouseType)
		boundKey = newKey
		boundIsMouse = newIsMouse or false
		boundMouseType = newMouseType or "Mouse1"
		btn.Text = newLabel
	end

	local function Resize(newSize)
		sizePx = math.
