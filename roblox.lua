-- Buat ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BidzzMod"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Frame utama
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 520) -- Increased height to fit all buttons
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -260)
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
    local goal = visible and {Size = UDim2.new(0, 320, 0, 520)} or {Size = UDim2.new(0, 320, 0, 0)}
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

-- Tombol toggle (modern)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 60, 0, 60)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 255) -- Warna biru
ToggleButton.Text = "MOD"
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 16
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
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

-- Variables for Fly and Teleport
local flyEnabled = false
local flyConnection
local bg, bv
local teleportEnabled = false

-- Fly function
local function toggleFly()
    flyEnabled = not flyEnabled
    if flyEnabled then
        local plr = game.Players.LocalPlayer
        local character = plr.Character or plr.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        local rootPart = character:WaitForChild("HumanoidRootPart")

        humanoid.PlatformStand = true

        bg = Instance.new("BodyGyro")
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.Parent = rootPart

        bv = Instance.new("BodyVelocity")
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Parent = rootPart

        local speed = 50
        local ctrl = {f = 0, b = 0, l = 0, r = 0, u = 0, d = 0}

        local uis = game:GetService("UserInputService")

        uis.InputBegan:Connect(function(input, gameProcessedEvent)
            if gameProcessedEvent then return end
            if input.KeyCode == Enum.KeyCode.W then
                ctrl.f = 1
            elseif input.KeyCode == Enum.KeyCode.S then
                ctrl.b = -1
            elseif input.KeyCode == Enum.KeyCode.A then
                ctrl.l = -1
            elseif input.KeyCode == Enum.KeyCode.D then
                ctrl.r = 1
            elseif input.KeyCode == Enum.KeyCode.Space then
                ctrl.u = 1
            elseif input.KeyCode == Enum.KeyCode.LeftControl then
                ctrl.d = -1
            end
        end)

        uis.InputEnded:Connect(function(input, gameProcessedEvent)
            if gameProcessedEvent then return end
            if input.KeyCode == Enum.KeyCode.W then
                ctrl.f = 0
            elseif input.KeyCode == Enum.KeyCode.S then
                ctrl.b = 0
            elseif input.KeyCode == Enum.KeyCode.A then
                ctrl.l = 0
            elseif input.KeyCode == Enum.KeyCode.D then
                ctrl.r = 0
            elseif input.KeyCode == Enum.KeyCode.Space then
                ctrl.u = 0
            elseif input.KeyCode == Enum.KeyCode.LeftControl then
                ctrl.d = 0
            end
        end)

        flyConnection = game:GetService("RunService").Stepped:Connect(function()
            if flyEnabled and character and humanoid and rootPart then
                local camera = workspace.CurrentCamera
                if camera then
                    local moveDirection = Vector3.new(ctrl.l + ctrl.r, ctrl.u + ctrl.d, ctrl.f + ctrl.b)
                    local moveVelocity = camera.CFrame:VectorToWorldSpace(moveDirection) * speed
                    bv.Velocity = moveVelocity
                    bg.CFrame = camera.CFrame
                end
            end
        end)
    else
        if flyConnection then
            flyConnection:Disconnect()
        end
        if bg then
            bg:Destroy()
        end
        if bv then
            bv:Destroy()
        end
        local plr = game.Players.LocalPlayer
        local character = plr.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.PlatformStand = false
            end
        end
    end
end

-- Teleport function
local function teleportToMouse()
    local plr = game.Players.LocalPlayer
    local character = plr.Character
    if character then
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            local mouse = plr:GetMouse()
            local ray = workspace.CurrentCamera:ScreenPointToRay(mouse.X, mouse.Y)
            local raycastParams = RaycastParams.new()
            raycastParams.FilterDescendantsInstances = {character}
            raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
            local result = workspace:Raycast(ray.Origin, ray.Direction * 1000, raycastParams)
            if result then
                rootPart.CFrame = CFrame.new(result.Position)
            else
                rootPart.CFrame = CFrame.new(ray.Origin + ray.Direction * 1000)
            end
        end
    end
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

-- Fly and Teleport buttons
CreateFeatureButton("Fly (Toggle)", UDim2.new(0, 30, 0, 400), toggleFly)
CreateFeatureButton("Teleport to Mouse", UDim2.new(0, 30, 0, 470), teleportToMouse)