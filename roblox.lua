-- Buat ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BidzzMod"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Warna RGB dinamis berbasis biru
local function RGBColor()
    local r = 50 + math.abs(math.sin(tick() * 2)) * 50
    local g = 100 + math.abs(math.sin(tick() * 2 + 2)) * 50
    local b = 200 + math.abs(math.sin(tick() * 2 + 4)) * 55
    return Color3.fromRGB(r, g, b)
end

-- Frame utama
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 340, 0, 460)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -230)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 30, 50) -- Biru tua
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

-- Sudut membulat
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = MainFrame

-- Gradien
local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 30, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 50, 80))
})
UIGradient.Parent = MainFrame

-- Outline efek
local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Color = RGBColor()
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = MainFrame

-- Perbarui warna outline secara dinamis
spawn(function()
    while task.wait() do
        UIStroke.Color = RGBColor()
    end
end)

-- Animasi Service
local TweenService = game:GetService("TweenService")

-- Fungsi animasi buka/tutup
local function animateFrame(visible)
    local goal = {
        Size = visible and UDim2.new(0, 340, 0, 460) or UDim2.new(0, 340, 0, 0),
        BackgroundTransparency = visible ? 0 : 0.5
    }
    local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local tween = TweenService:Create(MainFrame, tweenInfo, goal)
    tween:Play()
    MainFrame.Visible = true
    if not visible then
        tween.Completed:Connect(function()
            MainFrame.Visible = false
        end)
    end
end

-- Animasi fade-in untuk anak
local function animateChildren(frame, visible)
    for _, child in ipairs(frame:GetChildren()) do
        if child:IsA("GuiObject") then
            TweenService:Create(child, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Transparency = visible ? 0 : 1}):Play()
        end
    end
end

-- Nama Mod Menu
local ModMenuLabel = Instance.new("TextLabel")
ModMenuLabel.Size = UDim2.new(1, 0, 0, 50)
ModMenuLabel.Position = UDim2.new(0, 0, 0, 10)
ModMenuLabel.Text = "Bidzz Mod Menu"
ModMenuLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
ModMenuLabel.BackgroundTransparency = 1
ModMenuLabel.Font = Enum.Font.GothamBlack
ModMenuLabel.TextSize = 24
ModMenuLabel.Parent = MainFrame

-- Tombol Close di frame
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -40, 0, 10)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Parent = MainFrame

-- Sudut membulat untuk tombol Close
local CloseUICorner = Instance.new("UICorner")
CloseUICorner.CornerRadius = UDim.new(0, 8)
CloseUICorner.Parent = CloseButton

-- Efek hover untuk tombol Close
CloseButton.MouseEnter:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 100, 100)}):Play()
end)
CloseButton.MouseLeave:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 50, 50)}):Play()
end)

-- Ikon toggle (ImageButton)
local ToggleButton = Instance.new("ImageButton")
ToggleButton.Size = UDim2.new(0, 60, 0, 60)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 100, 200) -- Biru aksen
ToggleButton.Image = "https://raw.githubusercontent.com/Muhammadabid7/payment/refs/heads/main/IMG_20250624_000530_043-removebg-preview.png"
ToggleButton.ScaleType = Enum.ScaleType.Fit
ToggleButton.BackgroundTransparency = 0
ToggleButton.Parent = ScreenGui

-- Sudut membulat untuk tombol toggle
local ToggleUICorner = Instance.new("UICorner")
ToggleUICorner.CornerRadius = UDim.new(0, 16)
ToggleUICorner.Parent = ToggleButton

-- Efek hover dan animasi untuk tombol toggle
ToggleButton.MouseEnter:Connect(function()
    TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 120, 220), Size = UDim2.new(0, 65, 0, 65)}):Play()
end)
ToggleButton.MouseLeave:Connect(function()
    TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 100, 200), Size = UDim2.new(0, 60, 0, 60)}):Play()
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
local function toggleMenu()
    isOpen = not isOpen
    animateFrame(isOpen)
    animateChildren(MainFrame, isOpen)
    -- Animasi rotasi ikon
    TweenService:Create(ToggleButton, TweenInfo.new(0.3), {Rotation = isOpen ? 360 : 0}):Play()
end

ToggleButton.MouseButton1Click:Connect(toggleMenu)
CloseButton.MouseButton1Click:Connect(toggleMenu)

-- Container untuk fitur (dengan UIListLayout)
local FeatureContainer = Instance.new("Frame")
FeatureContainer.Size = UDim2.new(1, -20, 1, -70)
FeatureContainer.Position = UDim2.new(0, 10, 0, 60)
FeatureContainer.BackgroundTransparency = 1
FeatureContainer.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.FillDirection = Enum.FillDirection.Vertical
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Parent = FeatureContainer

-- Fungsi membuat tombol fitur
local function CreateFeatureButton(name, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 300, 0, 50)
    Button.BackgroundColor3 = Color3.fromRGB(40, 60, 100) -- Biru gelap
    Button.Text = name
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 16
    Button.TextColor3 = Color3.fromRGB(220, 220, 255)
    Button.Parent = FeatureContainer

    -- Sudut membulat
    local ButtonUICorner = Instance.new("UICorner")
    ButtonUICorner.CornerRadius = UDim.new(0, 8)
    ButtonUICorner.Parent = Button

    -- Gradien untuk tombol
    local ButtonUIGradient = Instance.new("UIGradient")
    ButtonUIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 60, 100)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 80, 120))
    })
    ButtonUIGradient.Parent = Button

    -- Efek hover
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 80, 120), Size = UDim2.new(0, 305, 0, 55)}):Play()
    end)
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 60, 100), Size = UDim2.new(0, 300, 0, 50)}):Play()
    end)

    Button.MouseButton1Click:Connect(callback)
end

-- Fungsi membuat input box
local function CreateInputBox(name, callback)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(0, 300, 0, 90)
    Container.BackgroundTransparency = 1
    Container.Parent = FeatureContainer

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 20)
    Label.Position = UDim2.new(0, 0, 0, 0)
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(220, 220, 255)
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 14
    Label.Parent = Container

    local InputBox = Instance.new("TextBox")
    InputBox.Size = UDim2.new(1, 0, 0, 30)
    InputBox.Position = UDim2.new(0, 0, 0, 25)
    InputBox.PlaceholderText = "Enter number..."
    InputBox.TextColor3 = Color3.fromRGB(220, 220, 255)
    InputBox.BackgroundColor3 = Color3.fromRGB(30, 50, 80)
    InputBox.TextSize = 14
    InputBox.Font = Enum.Font.Gotham
    InputBox.Parent = Container

    -- Sudut membulat untuk input
    local InputUICorner = Instance.new("UICorner")
    InputUICorner.CornerRadius = UDim.new(0, 6)
    InputUICorner.Parent = InputBox

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 30)
    Button.Position = UDim2.new(0, 0, 0, 60)
    Button.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
    Button.Text = "Set " .. name
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 14
    Button.TextColor3 = Color3.fromRGB(220, 220, 255)
    Button.Parent = Container

    -- Sudut membulat untuk tombol
    local ButtonUICorner = Instance.new("UICorner")
    ButtonUICorner.CornerRadius = UDim.new(0, 6)
    ButtonUICorner.Parent = Button

    -- Gradien untuk tombol
    local ButtonUIGradient = Instance.new("UIGradient")
    ButtonUIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 100, 200)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 120, 220))
    })
    ButtonUIGradient.Parent = Button

    -- Efek hover untuk tombol
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 120, 220)}):Play()
    end)
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 100, 200)}):Play()
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
CreateInputBox("JumpPower", function(value)
    if game.Players.LocalPlayer.Character then
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
    end
end)

CreateInputBox("Speed", function(value)
    if game.Players.LocalPlayer.Character then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
end)

-- Noclip
local NoclipEnabled = false
local NoclipConnection
CreateFeatureButton("Noclip (Toggle)", function()
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
CreateFeatureButton("InfJump (Toggle)", function()
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
