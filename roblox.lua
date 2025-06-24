-- Buat ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BidzzMod"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Frame utama
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 340, 0, 460)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -230)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui
MainFrame.ClipsDescendants = true

-- Gradien latar belakang
local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 35)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 25))
}
UIGradient.Rotation = 45
UIGradient.Parent = MainFrame

-- Sudut membulat
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = MainFrame

-- Bayangan lembut
local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(50, 50, 255)
UIStroke.Transparency = 0.3
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = MainFrame

-- Efek glow
local GlowEffect = Instance.new("UIStroke")
GlowEffect.Thickness = 4
GlowEffect.Color = Color3.fromRGB(100, 100, 255)
GlowEffect.Transparency = 0.7
GlowEffect.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
GlowEffect.Parent = MainFrame

-- Animasi buka/tutup MainFrame
local TweenService = game:GetService("TweenService")
local function animateFrame(visible)
    local goal = visible and {
        Size = UDim2.new(0, 340, 0, 460),
        BackgroundTransparency = 0
    } or {
        Size = UDim2.new(0, 340, 0, 0),
        BackgroundTransparency = 1
    }
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

-- Nama Mod Menu
local ModMenuLabel = Instance.new("TextLabel")
ModMenuLabel.Size = UDim2.new(1, 0, 0, 50)
ModMenuLabel.Position = UDim2.new(0, 0, 0, 10)
ModMenuLabel.Text = "Bidzz Mod Menu"
ModMenuLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
ModMenuLabel.BackgroundTransparency = 1
ModMenuLabel.Font = Enum.Font.GothamBlack
ModMenuLabel.TextSize = 24
ModMenuLabel.TextStrokeTransparency = 0.8
ModMenuLabel.Parent = MainFrame

-- Tombol toggle (modern)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 70, 0, 70)
ToggleButton.Position = UDim2.new(0, 20, 0, 20)
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 255)
ToggleButton.Text = "MOD"
ToggleButton.Font = Enum.Font.GothamBlack
ToggleButton.TextSize = 18
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Parent = ScreenGui

-- Sudut membulat untuk tombol toggle
local ToggleUICorner = Instance.new("UICorner")
ToggleUICorner.CornerRadius = UDim.new(1, 0) -- Bentuk lingkaran
ToggleUICorner.Parent = ToggleButton

-- Efek gradien pada tombol toggle
local ToggleGradient = Instance.new("UIGradient")
ToggleGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 100, 255))
}
ToggleGradient.Parent = ToggleButton

-- Efek hover dan klik untuk tombol toggle
local function applyButtonEffects(button)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {
            BackgroundColor3 = Color3.fromRGB(80, 80, 255),
            Size = UDim2.new(0, 75, 0, 75)
        }):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {
            BackgroundColor3 = Color3.fromRGB(50, 50, 255),
            Size = UDim2.new(0, 70, 0, 70)
        }):Play()
    end)
    button.MouseButton1Down:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
            Size = UDim2.new(0, 65, 0, 65)
        }):Play()
    end)
    button.MouseButton1Up:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
            Size = UDim2.new(0, 70, 0, 70)
        }):Play()
    end)
end
applyButtonEffects(ToggleButton)

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
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    Button.Text = name
    Button.Font = Enum.Font.GothamSemibold
    Button.TextSize = 16
    Button.TextColor3 = Color3.fromRGB(200, 200, 255)
    Button.Parent = MainFrame

    -- Sudut membulat
    local ButtonUICorner = Instance.new("UICorner")
    ButtonUICorner.CornerRadius = UDim.new(0, 10)
    ButtonUICorner.Parent = Button

    -- Gradien tombol
    local ButtonGradient = Instance.new("UIGradient")
    ButtonGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 40))
    }
    ButtonGradient.Parent = Button

    -- Efek hover dan klik
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {
            BackgroundColor3 = Color3.fromRGB(60, 60, 65),
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }):Play()
    end)
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {
            BackgroundColor3 = Color3.fromRGB(40, 40, 45),
            TextColor3 = Color3.fromRGB(200, 200, 255)
        }):Play()
    end)

    Button.MouseButton1Click:Connect(callback)
end

-- Fungsi membuat input box
local function CreateInputBox(name, position, callback)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(0, 280, 0, 80)
    Container.Position = position
    Container.BackgroundTransparency = 1
    Container.Parent = MainFrame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 20)
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(200, 200, 255)
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.GothamSemibold
    Label.TextSize = 14
    Label.Parent = Container

    local InputBox = Instance.new("TextBox")
    InputBox.Size = UDim2.new(1, -20, 0, 30)
    InputBox.Position = UDim2.new(0, 10, 0, 25)
    InputBox.PlaceholderText = "Enter number..."
    InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    InputBox.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    InputBox.TextSize = 14
    InputBox.Font = Enum.Font.Gotham
    InputBox.Parent = Container

    -- Sudut membulat untuk input
    local InputUICorner = Instance.new("UICorner")
    InputUICorner.CornerRadius = UDim.new(0, 8)
    InputUICorner.Parent = InputBox

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -20, 0, 30)
    Button.Position = UDim2.new(0, 10, 0, 60)
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 255)
    Button.Text = "Set " .. name
    Button.Font = Enum.Font.GothamSemibold
    Button.TextSize = 14
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Parent = Container

    -- Sudut membulat untuk tombol
    local ButtonUICorner = Instance.new("UICorner")
    ButtonUICorner.CornerRadius = UDim.new(0, 8)
    ButtonUICorner.Parent = Button

    -- Efek hover untuk tombol
    applyButtonEffects(Button)

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
CreateInputBox("JumpPower", UDim2.new(0, 30, 0, 70), function(value)
    if game.Players.LocalPlayer.Character then
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
    end
end)

CreateInputBox("Speed", UDim2.new(0, 30, 0, 170), function(value)
    if game.Players.LocalPlayer.Character then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
end)

-- Noclip
local NoclipEnabled = false
local NoclipConnection
CreateFeatureButton("Noclip (Toggle)", UDim2.new(0, 30, 0, 270), function()
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
CreateFeatureButton("InfJump (Toggle)", UDim2.new(0, 30, 0, 340), function()
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
    end
end)