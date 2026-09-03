-- Obfuscated with Standard String & Byte Encoding
local _0x1 = game:GetService("Players")
local _0x2 = game:GetService("UserInputService")
local _0x3 = game:GetService("VirtualInputManager")
local _0x4 = game:GetService("RunService")
local _0x5 = game:GetService("Workspace")
local _0x6 = game:GetService("StarterGui")

local _0x7 = _0x1.LocalPlayer
local _0x8 = _0x7:WaitForChild("\80\108\97\121\101\114\71\117\105")

if _0x8:FindFirstChild("\78\79\84\95\65\78\65\83\89\84\95\71\117\105") then
	_0x8["\78\79\84\95\65\78\65\83\89\84\95\71\117\105"]:Destroy()
end

pcall(function()
	_0x6:SetCore("\83\101\110\100\78\111\116\105\102\105\99\97\116\105\111\110", {
		Title = "\78\79\84\95\65\78\65\83\89\84\32\67\111\110\116\114\111\108\115",
		Text = "\76\111\97\100\101\100\32\67\117\115\116\111\109\32\80\114\101\115\101\116\33",
		Duration = 4
	})
end)

local _0x9 = Instance.new("\83\99\114\101\101\110\71\117\105")
_0x9.Name = "\78\79\84\95\65\78\65\83\89\84\95\71\117\105"
_0x9.ResetOnSpawn = false
_0x9.IgnoreGuiInset = true
_0x9.DisplayOrder = 9999
_0x9.Parent = _0x8

local _0xA = Instance.new("\84\101\120\116\76\97\98\101\108")
_0xA.Name = "\87\97\116\101\114\109\97\114\107"
_0xA.Size = UDim2.new(0, 200, 0, 20)
_0xA.Position = UDim2.new(0, 10, 1, -30)
_0xA.BackgroundTransparency = 1
_0xA.Text = "\77\97\100\101\32\98\121\32\78\79\84\95\65\78\65\83\89\84"
_0xA.TextColor3 = Color3.fromRGB(255, 255, 255)
_0xA.TextTransparency = 0.4
_0xA.TextSize = 12
_0xA.TextXAlignment = Enum.TextXAlignment.Left
_0xA.Parent = _0x9

local _0xB = {
	{ Name = "Gotham Bold", Font = Enum.Font.GothamBold },
	{ Name = "Fredoka One", Font = Enum.Font.FredokaOne },
	{ Name = "Source Sans", Font = Enum.Font.SourceSansBold },
	{ Name = "Oswald", Font = Enum.Font.Oswald },
	{ Name = "Cartoon", Font = Enum.Font.Cartoon },
	{ Name = "Arcade", Font = Enum.Font.Arcade }
}

local _0xC, _0xD = 1, 1
local _0xE = Color3.fromRGB(0, 255, 170)
local _0xF = Color3.fromRGB(15, 15, 20)
local _0x10 = Color3.fromRGB(22, 22, 28)
local _0x11 = Color3.fromRGB(35, 35, 45)

local _0x12, _0x13, _0x14 = {}, {}, {}

local function _0x15(_0x16, _0x17)
	table.insert(_0x12, { Instance = _0x16, DefaultRadius = _0x17 })
	_0x16.CornerRadius = (_0xC == 1) and _0x17 or UDim.new(0, 0)
end

local function _0x18(_0x19)
	table.insert(_0x13, _0x19)
	_0x19.Color = _0xE
	_0x19.Thickness = (_0xC == 3) and 3 or 1.5
end

local function _0x1A(_0x1B)
	table.insert(_0x14, _0x1B)
	_0x1B.Font = _0xB[_0xD].Font
end

_0x1A(_0xA)

local _0x1C = false
local function _0x1D(_0x1E, _0x1F)
	local _0x20, _0x21, _0x22, _0x23 = false, nil, nil, nil
	_0x1E.InputBegan:Connect(function(_0x24)
		if _0x24.UserInputType == Enum.UserInputType.MouseButton1 or _0x24.UserInputType == Enum.UserInputType.Touch then
			_0x20 = true
			_0x21 = _0x24.Position
			_0x22 = _0x1E.Position
			_0x23 = _0x24
		end
	end)

	_0x2.InputChanged:Connect(function(_0x24)
		if _0x20 and (_0x24 == _0x23 or _0x24.UserInputType == Enum.UserInputType.Touch or _0x24.UserInputType == Enum.UserInputType.MouseMovement) then
			local _0x25 = _0x24.Position - _0x21
			_0x1E.Position = UDim2.new(_0x22.X.Scale, _0x22.X.Offset + _0x25.X, _0x22.Y.Scale, _0x22.Y.Offset + _0x25.Y)
		end
	end)

	local function _0x26(_0x24)
		if _0x20 and (_0x24 == _0x23 or _0x24.UserInputType == Enum.UserInputType.MouseButton1 or _0x24.UserInputType == Enum.UserInputType.Touch) then
			_0x20 = false
			_0x23 = nil
			if _0x1F then _0x1F() end
		end
	end
	_0x1E.InputEnded:Connect(_0x26)
	_0x2.InputEnded:Connect(_0x26)
end

local _0x27 = Instance.new("\70\114\97\109\101")
_0x27.Name = "\78\79\84\95\65\78\65\83\89\84\95\74\111\121\115\116\105\99\107\66\97\115\101"
_0x27.Size = UDim2.new(0, 120, 0, 120)
_0x27.Position = UDim2.new(0.08, 0, 0.62, 0)
_0x27.BackgroundColor3 = _0xF
_0x27.BackgroundTransparency = 0.35
_0x27.Active = true
_0x27.Parent = _0x9

local _0x28 = Instance.new("\85\73\67\111\114\110\101\114", _0x27)
_0x15(_0x28, UDim.new(1, 0))

local _0x29 = Instance.new("\85\73\83\116\114\111\107\101")
_0x29.Thickness = 2
_0x29.Parent = _0x27
_0x18(_0x29)

local _0x2A = Instance.new("\70\114\97\109\101")
_0x2A.Name = "\78\79\84\95\65\78\65\83\89\84\95\74\111\121\115\116\105\99\107\84\104\117\109\98"
_0x2A.Size = UDim2.new(0, 48, 0, 48)
_0x2A.Position = UDim2.new(0.5, -24, 0.5, -24)
_0x2A.BackgroundColor3 = _0xE
_0x2A.Parent = _0x27

local _0x2B = Instance.new("\85\73\67\111\114\110\101\114", _0x2A)
_0x15(_0x2B, UDim.new(1, 0))

_0x1D(_0x27)

local _0x2C = nil
local _0x2D = Vector2.new(0, 0)

_0x27.InputBegan:Connect(function(_0x24)
	if not _0x1C and (_0x24.UserInputType == Enum.UserInputType.Touch or _0x24.UserInputType == Enum.UserInputType.MouseButton1) then
		if not _0x2C then _0x2C = _0x24 end
	end
end)

_0x2.InputChanged:Connect(function(_0x24)
	if not _0x1C and _0x24 == _0x2C then
		local _0x2E = _0x27.AbsolutePosition + (_0x27.AbsoluteSize / 2)
		local _0x2F = Vector2.new(_0x24.Position.X, _0x24.Position.Y)
		local _0x30 = _0x2F - _0x2E
		local _0x31 = _0x27.AbsoluteSize.X / 2

		if _0x30.Magnitude > _0x31 then _0x30 = _0x30.Unit * _0x31 end

		_0x2A.Position = UDim2.new(0.5, _0x30.X - 24, 0.5, _0x30.Y - 24)
		_0x2D = Vector2.new(_0x30.X / _0x31, _0x30.Y / _0x31)
	end
end)

local function _0x32()
	_0x2C = nil
	_0x2D = Vector2.new(0, 0)
	_0x2A.Position = UDim2.new(0.5, -24, 0.5, -24)
end

_0x2.InputEnded:Connect(function(_0x24)
	if _0x24 == _0x2C then _0x32() end
end)

_0x4.RenderStepped:Connect(function()
	if _0x2D.Magnitude > 0.1 then
		local _0x33 = _0x7.Character
		if _0x33 then
			local _0x34 = _0x33:FindFirstChildOfClass("\72\117\109\97\110\111\105\100")
			local _0x35 = _0x5.CurrentCamera
			if _0x34 and _0x35 then
				local _0x36 = _0x35.CFrame
				local _0x37 = Vector3.new(_0x36.LookVector.X, 0, _0x36.LookVector.Z).Unit
				local _0x38 = Vector3.new(_0x36.RightVector.X, 0, _0x36.RightVector.Z).Unit
				local _0x39 = (_0x37 * -_0x2D.Y) + (_0x38 * _0x2D.X)
				_0x34:Move(_0x39, false)
			end
		end
	end
end)

function createCustomButton(_0x3A, _0x3B, _0x3C, _0x3D, _0x3E, _0x3F)
	local _0x40 = _0x3F or 54
	local _0x41 = Instance.new("\84\101\120\116\66\117\116\116\111\110")
	_0x41.Name = "\78\79\84\95\65\78\65\83\89\84\95\63\117\115\116\111\109\66\117\116\116\111\110"
	_0x41.Size = UDim2.new(0, _0x40, 0, _0x40)
	_0x41.Position = _0x3E or UDim2.new(0.8, 0, 0.5, 0)
	_0x41.BackgroundColor3 = _0x11
	_0x41.BackgroundTransparency = 0.2
	_0x41.TextColor3 = Color3.fromRGB(255, 255, 255)
	_0x41.TextSize = math.clamp(math.floor(_0x40 * 0.22), 9, 24)
	_0x41.Text = _0x3A or "\75\69\89"
	_0x41.Parent = _0x9
	_0x1A(_0x41)

	local _0x42 = Instance.new("\85\73\67\111\114\110\101\114", _0x41)
	_0x15(_0x42, UDim.new(0, 10))

	local _0x43 = Instance.new("\85\73\83\116\114\111\107\101")
	_0x43.Thickness = 1.5
	_0x43.Parent = _0x41
	_0x18(_0x43)

	_0x1D(_0x41)
	return _0x41
end
