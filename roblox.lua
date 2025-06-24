-- Buat ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BidzzMod"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Frame utama
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 420)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

-- Sudut membulat
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Outline (bayangan) dengan warna biru statis
local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(60, 60, 255) -- Warna biru statis
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = MainFrame

-- Animasi buka/tutup MainFrame
local TweenService = game:GetService("TweenService")
local function animateFrame(visible)
    local goal = visible and {Size = UDim2.new(0, 320, 0, 420)} or {Size = UDim2.new(0, 320, 0, 0)}
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
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
ModMenuLabel.Size = UDim2.new(1, 0, 0, 40)
ModMenuLabel.Position = UDim2.new(0, 0, 0, 10)
ModMenuLabel.Text = "Bidzz Mod Menu"
ModMenuLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ModMenuLabel.BackgroundTransparency = 1
ModMenuLabel.Font = Enum.Font.GothamBold
ModMenuLabel.TextSize = 20
ModMenuLabel.Parent = MainFrame

-- Tombol toggle (menggunakan ImageButton)
local ToggleButton = Instance.new("ImageButton")
ToggleButton.Size = UDim2.new(0, 60, 0, 60)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 255) -- Warna biru
ToggleButton.Image = "rbxassetid://1234567890" -- Ganti dengan Asset ID gambar Anda
ToggleButton.Parent = ScreenGui

-- Sudut membulat untuk tombol toggle
local ToggleUICorner = Instance.new("UICorner")
ToggleUICorner.CornerRadius = UDim.new(0, 16)
ToggleUICorner.Parent = ToggleButton

-- Efek hover untuk tombol toggle
ToggleButton.MouseEnter:Connect(function()
    TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 100, 255)}):Play()
end)
ToggleButton.MouseLeave:Connect(function()
    TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 255)}):Play()
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
    Button.Size = UDim2.new(0, 260, 0, 50)
    Button.Position = position
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    Button.Text = name
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 16
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Parent = MainFrame

    -- Sudut membulat
    local ButtonUICorner = Instance.new("UICorner")
    ButtonUICorner.CornerRadius = UDim.new(0, 8)
    ButtonUICorner.Parent = Button

    -- Efek hover
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 70, 75)}):Play()
    end)
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 55)}):Play()
    end)

    Button.MouseButton1Click:Connect(callback)
end

-- Fungsi membuat input box
local function CreateInputBox(name, position, callback)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(0, 260, 0, 80)
    Container.Position = position
    Container.BackgroundTransparency = 1
    Container.Parent = MainFrame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 20)
    Label.Position = UDim2.new(0, 0, 0, 0)
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 14
    Label.Parent = Container

    local InputBox = Instance.new("TextBox")
    InputBox.Size = UDim2.new(1, 0, 0, 30)
    InputBox.Position = UDim2.new(0, 0, 0, 25)
    InputBox.PlaceholderText = "Enter number..."
    InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    InputBox.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
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
    Button.BackgroundColor3 = Color3.fromRGB(60, 60, 255) -- Warna biru
    Button.Text = "Set " .. name
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 14
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Parent = Container

    -- Sudut membulat untuk tombol
    local ButtonUICorner = Instance.new("UICorner")
    ButtonUICorner.CornerRadius = UDim.new(0, 6)
    ButtonUICorner.Parent = Button

    -- Efek hover untuk tombol
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 100, 255)}):Play()
    end)
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 255)}):Play()
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
CreateInputBox("JumpPower", UDim2.new(0, 30, 0, 60), function(value)
    if game.Players.LocalPlayer.Character then
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
    end
end)

CreateInputBox("Speed", UDim2.new(0, 30, 0, 160), function(value)
    if game.Players.LocalPlayer.Character then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
end)

-- Noclip
local NoclipEnabled = false
local NoclipConnection
CreateFeatureButton("Noclip (Toggle)", UDim2.new(0, 30, 0, 260), function()
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
CreateFeatureButton("InfJump (Toggle)", UDim2.new(0, 30, 0, 330), function()
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