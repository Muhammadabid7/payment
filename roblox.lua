-- Buat ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BidzzMod"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Frame utama
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 340, 0, 460) -- Slightly larger for better spacing
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -230)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30) -- Dark blue-gray base
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

-- Sudut membulat
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = MainFrame

-- Shadow effect
local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(50, 80, 255) -- Blue accent
UIStroke.Transparency = 0.7
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = MainFrame

-- Animasi buka/tutup MainFrame
local TweenService = game:GetService("TweenService")
local function animateFrame(visible)
    local goal = visible and {Size = UDim2.new(0, 340, 0, 460)} or {Size = UDim2.new(0, 340, 0, 0)}
    local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
    local tween = TweenService:Create(MainFrame, tweenInfo, goal)
    tween:Play()
    MainFrame.Visible = true
    if not visible then
        tween.Completed:Connect(function()
            MainFrame.Visible = false
        end)
    end
end

-- Header Frame
local HeaderFrame = Instance.new("Frame")
HeaderFrame.Size = UDim2.new(1, 0, 0, 60)
HeaderFrame.BackgroundColor3 = Color3.fromRGB(30, 40, 80) -- Darker blue header
HeaderFrame.BorderSizePixel = 0
HeaderFrame.Parent = MainFrame

local HeaderUICorner = Instance.new("UICorner")
HeaderUICorner.CornerRadius = UDim.new(0, 16)
HeaderUICorner.Parent = HeaderFrame

-- Nama Mod Menu
local ModMenuLabel = Instance.new("TextLabel")
ModMenuLabel.Size = UDim2.new(1, 0, 0, 60)
ModMenuLabel.Text = "Bidzz Mod Menu"
ModMenuLabel.TextColor3 = Color3.fromRGB(200, 220, 255) -- Light blue text
ModMenuLabel.BackgroundTransparency = 1
ModMenuLabel.Font = Enum.Font.GothamBold
ModMenuLabel.TextSize = 22
ModMenuLabel.Parent = HeaderFrame

-- Tombol toggle
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 70, 0, 70)
ToggleButton.Position = UDim2.new(0, 20, 0, 20)
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 80, 255) -- Primary blue
ToggleButton.Text = "MOD"
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 18
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Parent = ScreenGui

-- Sudut membulat untuk tombol toggle
local ToggleUICorner = Instance.new("UICorner")
ToggleUICorner.CornerRadius = UDim.new(1, 0) -- Circular button
ToggleUICorner.Parent = ToggleButton

-- Shadow untuk tombol toggle
local ToggleUIStroke = Instance.new("UIStroke")
ToggleUIStroke.Thickness = 2
ToggleUIStroke.Color = Color3.fromRGB(30, 50, 200) -- Darker blue shadow
ToggleUIStroke.Transparency = 0.8
ToggleUIStroke.Parent = ToggleButton

-- Efek hover untuk tombol toggle
ToggleButton.MouseEnter:Connect(function()
    TweenService:Create(ToggleButton, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {BackgroundColor3 = Color3.fromRGB(80, 110, 255)}):Play()
end)
ToggleButton.MouseLeave:Connect(function()
    TweenService:Create(ToggleButton, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {BackgroundColor3 = Color3.fromRGB(50, 80, 255)}):Play()
end)

-- Fungsi drag untuk tombol toggle
local UIS = game:GetService("UserInputService")
local dragToggle = false
local dragStart = nil
local startPos = nil

ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragToggle = true
        dragStart = input.Position
        startPos = ToggleButton.Position
    end
end)

ToggleButton.InputChanged:Connect(function(input)
    if dragToggle and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        ToggleButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

ToggleButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragToggle = false
    end
end)

-- Toggle MainFrame
local isOpen = false
ToggleButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    animateFrame(isOpen)
end)

-- Fungsi membuat tombol fitur
local function CreateFeatureButton(name, position, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 280, 0, 50)
    Button.Position = position
    Button.BackgroundColor3 = Color3.fromRGB(35, 45, 90) -- Dark blue button
    Button.Text = name
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 16
    Button.TextColor3 = Color3.fromRGB(200, 220, 255)
    Button.Parent = MainFrame

    local ButtonUICorner = Instance.new("UICorner")
    ButtonUICorner.CornerRadius = UDim.new(0, 10)
    ButtonUICorner.Parent = Button

    local ButtonUIStroke = Instance.new("UIStroke")
    ButtonUIStroke.Thickness = 1
    ButtonUIStroke.Color = Color3.fromRGB(50, 80, 255)
    ButtonUIStroke.Transparency = 0.8
    ButtonUIStroke.Parent = Button

    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {BackgroundColor3 = Color3.fromRGB(50, 65, 120)}):Play()
    end)
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {BackgroundColor3 = Color3.fromRGB(35, 45, 90)}):Play()
    end)

    Button.MouseButton1Click:Connect(callback)
end

-- Fungsi membuat input box
local function CreateInputBox(name, position, callback)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(0, 280, 0, 90)
    Container.Position = position
    Container.BackgroundTransparency = 1
    Container.Parent = MainFrame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 20)
    Label.Position = UDim2.new(0, 0, 0, 0)
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(200, 220, 255)
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 14
    Label.Parent = Container

    local InputBox = Instance.new("TextBox")
    InputBox.Size = UDim2.new(1, 0, 0, 40)
    InputBox.Position = UDim2.new(0, 0, 0, 25)
    InputBox.PlaceholderText = "Enter number..."
    InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    InputBox.BackgroundColor3 = Color3.fromRGB(30, 40, 80)
    InputBox.TextSize = 14
    InputBox.Font = Enum.Font.Gotham
    InputBox.Parent = Container

    local InputUICorner = Instance.new("UICorner")
    InputUICorner.CornerRadius = UDim.new(0, 8)
    InputUICorner.Parent = Input EwingBox

    local InputUIStroke = Instance.new("UIStroke")
    InputUIStroke.Thickness = 1
    InputUIStroke.Color = Color3.fromRGB(50, 80, 255)
    InputUIStroke.Transparency = 0.8
    InputUIStroke.Parent = InputBox

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 120, 0, 35)
    Button.Position = UDim2.new(0.5, -60, 0, 70)
    Button.BackgroundColor3 = Color3.fromRGB(50, 80, 255)
    Button.Text = "Set " .. name
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 14
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Parent = Container

    local ButtonUICorner = Instance.new("UICorner")
    ButtonUICorner.CornerRadius = UDim.new(0, 8)
    ButtonUICorner.Parent = Button

    local ButtonUIStroke = Instance.new("UIStroke")
    ButtonUIStroke.Thickness = 1
    ButtonUIStroke.Color = Color3.fromRGB(30, 50, 200)
    ButtonUIStroke.Transparency = 0.8
    ButtonUIStroke.Parent = Button

    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {BackgroundColor3 = Color3.fromRGB(80, 110, 255)}):Play()
    end)
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {BackgroundColor3 = Color3.fromRGB(50, 80, 255)}):Play()
    end)

    Button.MouseButton1Click:Connect(function()
        local input = tonumber(InputBox.Text)
        if input then
            callback(input)
        else
            warn("Please enter a valid number!")
        end
    end)
end

-- Input untuk JumpPower dan Speed
CreateInputBox("JumpPower", UDim2.new(0, 30, 0, 80), function(value)
    if game.Players.LocalPlayer.Character then
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
    end
end)

CreateInputBox("Speed", UDim2.new(0, 30, 0, 190), function(value)
    if game.Players.LocalPlayer.Character then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
end)

-- Noclip
local NoclipEnabled = false
local NoclipConnection
CreateFeatureButton("Noclip (Toggle)", UDim2.new(0, 30, 0, 300), function()
    NoclipEnabled = not NoclipEnabled
    if NoclipEnabled then
        NoclipConnection = game:GetService("RunService").Stepped:Connect(function()
            if game.Players.LocalPlayer.Character then
                for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if NoclipConnection then
            NoclipConnection:Disconnect()
        end
    end
end)

-- Infinite Jump
local InfJumpEnabled = false
local InfJumpConnection
CreateFeatureButton("InfJump (Toggle)", UDim2.new(0, 30, 0, 370), function()
    InfJumpEnabled = not InfJumpEnabled
    if InfJumpEnabled then
        InfJumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
            if InfJumpEnabled and game.Players.LocalPlayer.Character then
                game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    else
        if InfJumpConnection then
            InfJumpConnection:Disconnect()
        end
    end)
end)
