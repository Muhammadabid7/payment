-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BidzzMod"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true -- Ensure GUI respects screen boundaries
ScreenGui.ResetOnSpawn = false -- Prevent GUI from resetting on player respawn

-- Loading Screen
local function createLoadingScreen()
    local LoadingFrame = Instance.new("Frame")
    LoadingFrame.Size = UDim2.new(1, 0, 1, 0)
    LoadingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    LoadingFrame.BackgroundTransparency = 0.3
    LoadingFrame.Parent = ScreenGui
    LoadingFrame.ZIndex = 100

    local UIGradient = Instance.new("UIGradient")
    UIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 0, 160))
    })
    UIGradient.Rotation = 90
    UIGradient.Parent = LoadingFrame

    local LoadingText = Instance.new("TextLabel")
    LoadingText.Size = UDim2.new(0, 500, 0, 80)
    LoadingText.Position = UDim2.new(0.5, -250, 0.5, -40)
    LoadingText.BackgroundTransparency = 1
    LoadingText.Text = "BY BIDZZ OFFICIAL 🇮🇩"
    LoadingText.TextColor3 = Color3.fromRGB(0, 255, 255)
    LoadingText.Font = Enum.Font.Code
    LoadingText.TextSize = 40
    LoadingText.TextStrokeTransparency = 0.7
    LoadingText.TextStrokeColor3 = Color3.fromRGB(128, 0, 255)
    LoadingText.Parent = LoadingFrame

    local function pulseText()
        TweenService:Create(LoadingText, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            TextTransparency = 0.2
        }):Play()
    end
    pulseText()

    for i = 1, 6 do
        local Particle = Instance.new("Frame")
        Particle.Size = UDim2.new(0, 15, 0, 15)
        Particle.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        Particle.BackgroundTransparency = 0.4
        Particle.Parent = LoadingFrame
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0.5, 0)
        UICorner.Parent = Particle

        local angle = i * (360 / 6)
        RunService.RenderStepped:Connect(function(delta)
            angle = angle + delta * 120
            Particle.Position = UDim2.new(0.5, math.cos(math.rad(angle)) * 120, 0.5, math.sin(math.rad(angle)) * 120)
            TweenService:Create(Particle, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
                BackgroundTransparency = 0.4 + 0.3 * math.sin(tick() * 2)
            }):Play()
        end)
    end

    task.delay(2.5, function()
        TweenService:Create(LoadingFrame, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play()
        TweenService:Create(LoadingText, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = 1
        }):Play()
        for _, particle in pairs(LoadingFrame:GetChildren()) do
            if particle:IsA("Frame") then
                TweenService:Create(particle, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(0, 0, 0, 0)
                }):Play()
            end
        end
        task.delay(0.8, function()
            LoadingFrame:Destroy()
        end)
    end)
end

createLoadingScreen()

-- UI Helper Functions
local function addUICorner(instance, cornerRadius)
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, cornerRadius)
    UICorner.Parent = instance
end

local function addGlow(instance)
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Thickness = 1.5
    UIStroke.Color = Color3.fromRGB(0, 255, 255)
    UIStroke.Transparency = 0.3
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke.Parent = instance
    return UIStroke
end

local function addGradient(instance)
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(128, 0, 255))
    })
    UIGradient.Rotation = 90
    UIGradient.Parent = instance
end

-- Toggle Button (Moved Slightly Down)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Parent = ScreenGui
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 10, 0, 50) -- Moved 50 pixels down
ToggleButton.Text = "☰"
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.TextColor3 = Color3.fromRGB(0, 255, 255)
ToggleButton.Font = Enum.Font.Code
ToggleButton.TextSize = 20
ToggleButton.ZIndex = 10 -- High ZIndex for clickability
addUICorner(ToggleButton, 10)
local toggleGlow = addGlow(ToggleButton)
addGradient(ToggleButton)

ToggleButton.MouseEnter:Connect(function()
    TweenService:Create(ToggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, 55, 0, 55),
        BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    }):Play()
    TweenService:Create(toggleGlow, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        Thickness = 2,
        Transparency = 0.1
    }):Play()
end)
ToggleButton.MouseLeave:Connect(function()
    TweenService:Create(ToggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, 50, 0, 50),
        BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    }):Play()
    TweenService:Create(toggleGlow, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        Thickness = 1.5,
        Transparency = 0.3
    }):Play()
end)

-- Main Frame (ScrollingFrame, Centered)
local MainFrame = Instance.new("ScrollingFrame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 300, 0, 500)
MainFrame.Position = UDim2.new(0, -300, 0.5, -250) -- Start off-screen
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BackgroundTransparency = 0.1
MainFrame.ScrollBarThickness = 4
MainFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 255)
MainFrame.Visible = false
MainFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
MainFrame.ZIndex = 5
addUICorner(MainFrame, 10)
addGlow(MainFrame)

-- UI List Layout
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = MainFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Title
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.Font = Enum.Font.Code
Title.TextSize = 24
Title.Text = "Bidzz Mod"
Title.TextStrokeTransparency = 0.7
Title.TextStrokeColor3 = Color3.fromRGB(128, 0, 255)
addUICorner(Title, 8)

-- Button Creation with Enhanced Status Indicator
local function createButton(parent, text, color, callback)
    local ButtonFrame = Instance.new("Frame")
    ButtonFrame.Parent = parent
    ButtonFrame.Size = UDim2.new(0, 260, 0, 40)
    ButtonFrame.BackgroundTransparency = 1

    local Button = Instance.new("TextButton")
    Button.Parent = ButtonFrame
    Button.Size = UDim2.new(0, 220, 0, 40)
    Button.Position = UDim2.new(0, 0, 0, 0)
    Button.BackgroundColor3 = color
    Button.TextColor3 = Color3.fromRGB(0, 255, 255)
    Button.Font = Enum.Font.Code
    Button.TextSize = 16
    Button.Text = text
    Button.ZIndex = 6
    addUICorner(Button, 8)
    local buttonGlow = addGlow(Button)
    addGradient(Button)

    -- Status Frame
    local StatusFrame = Instance.new("Frame")
    StatusFrame.Parent = ButtonFrame
    StatusFrame.Size = UDim2.new(0, 34, 0, 34)
    StatusFrame.Position = UDim2.new(1, -36, 0, 3)
    StatusFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    StatusFrame.BackgroundTransparency = 0.5
    StatusFrame.ZIndex = 6
    addUICorner(StatusFrame, 8)
    addGlow(StatusFrame)
    addGradient(StatusFrame)

    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Parent = StatusFrame
    StatusLabel.Size = UDim2.new(0, 30, 0, 30)
    StatusLabel.Position = UDim2.new(0.5, -15, 0.5, -15)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Text = "Off"
    StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    StatusLabel.Font = Enum.Font.Code
    StatusLabel.TextSize = 12
    StatusLabel.ZIndex = 7

    local function updateStatus(state)
        StatusLabel.Text = state and "On" or "Off"
        TweenService:Create(StatusLabel, TweenInfo.new(0.4, Enum.EasingStyle.Sine), {
            TextColor3 = state and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        }):Play()
        TweenService:Create(StatusFrame, TweenInfo.new(0.4, Enum.EasingStyle.Elastic), {
            Size = state and UDim2.new(0, 36, 0, 36) or UDim2.new(0, 34, 0, 34)
        }):Play()
    end

    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, 230, 0, 45),
            BackgroundColor3 = Color3.fromRGB(color.R * 255 + 20, color.G * 255 + 20, color.B * 255 + 20)
        }):Play()
        TweenService:Create(buttonGlow, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            Thickness = 2,
            Transparency = 0.1
        }):Play()
    end)
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, 220, 0, 40),
            BackgroundColor3 = color
        }):Play()
        TweenService:Create(buttonGlow, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            Thickness = 1.5,
            Transparency = 0.3
        }):Play()
    end)

    Button.MouseButton1Click:Connect(function()
        print("Button clicked: " .. text) -- Debug print
        callback(updateStatus)
    end)

    return ButtonFrame, updateStatus
end

-- Text Boxes
local InputFrame = Instance.new("Frame")
InputFrame.Parent = MainFrame
InputFrame.Size = UDim2.new(0, 260, 0, 120)
InputFrame.BackgroundTransparency = 1
InputFrame.LayoutOrder = 1

local InputLayout = Instance.new("UIListLayout")
InputLayout.Parent = InputFrame
InputLayout.SortOrder = Enum.SortOrder.LayoutOrder
InputLayout.Padding = UDim.new(0, 8)
InputLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local SpeedBox = Instance.new("TextBox")
SpeedBox.Parent = InputFrame
SpeedBox.Size = UDim2.new(0, 240, 0, 30)
SpeedBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SpeedBox.TextColor3 = Color3.fromRGB(0, 255, 255)
SpeedBox.Font = Enum.Font.Code
SpeedBox.TextSize = 14
SpeedBox.PlaceholderText = "WalkSpeed"
SpeedBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
SpeedBox.ZIndex = 6
addUICorner(SpeedBox, 6)
addGlow(SpeedBox)

local JumpBox = Instance.new("TextBox")
JumpBox.Parent = InputFrame
JumpBox.Size = UDim2.new(0, 240, 0, 30)
JumpBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
JumpBox.TextColor3 = Color3.fromRGB(0, 255, 255)
JumpBox.Font = Enum.Font.Code
JumpBox.TextSize = 14
JumpBox.PlaceholderText = "JumpPower"
JumpBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
JumpBox.ZIndex = 6
addUICorner(JumpBox, 6)
addGlow(JumpBox)

local GravityBox = Instance.new("TextBox")
GravityBox.Parent = InputFrame
GravityBox.Size = UDim2.new(0, 240, 0, 30)
GravityBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
GravityBox.TextColor3 = Color3.fromRGB(0, 255, 255)
GravityBox.Font = Enum.Font.Code
GravityBox.TextSize = 14
GravityBox.PlaceholderText = "Gravity"
GravityBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
GravityBox.ZIndex = 6
addUICorner(GravityBox, 6)
addGlow(GravityBox)

-- Speed and Jump Handlers
SpeedBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local speed = tonumber(SpeedBox.Text)
        if speed and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = speed
        end
    end
end)

JumpBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local jump = tonumber(JumpBox.Text)
        if jump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = jump
        end
    end
end)

-- Gravity
local gravityEnabled = false
local gravityValue = workspace.Gravity
local gravityButton, gravityUpdateStatus = createButton(MainFrame, "Gravity Function", Color3.fromRGB(40, 40, 40), function(updateStatus)
    gravityEnabled = not gravityEnabled
    if gravityEnabled then
        workspace.Gravity = gravityValue
    else
        workspace.Gravity = 0
    end
    updateStatus(gravityEnabled)
end)

GravityBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local gravity = tonumber(GravityBox.Text)
        if gravity then
            gravityValue = gravity
            if gravityEnabled then
                workspace.Gravity = gravityValue
            end
        end
    end
end)

-- ESP
local espEnabled = false
local highlights = {}
local function addHighlight(player)
    if player ~= LocalPlayer and player.Character then
        local highlight = Instance.new("Highlight")
        highlight.Adornee = player.Character
        highlight.FillColor = Color3.fromRGB(0, 255, 255)
        highlight.Parent = player.Character
        highlights[player] = highlight
    end
    player.CharacterAdded:Connect(function(character)
        if espEnabled and player ~= LocalPlayer then
            local highlight = Instance.new("Highlight")
            highlight.Adornee = character
            highlight.FillColor = Color3.fromRGB(0, 255, 255)
            highlight.Parent = character
            highlights[player] = highlight
        end
    end)
end

local function removeHighlight(player)
    if highlights[player] then
        highlights[player]:Destroy()
        highlights[player] = nil
    end
end

local espButton, espUpdateStatus = createButton(MainFrame, "HOLOGRAM", Color3.fromRGB(40, 40, 40), function(updateStatus)
    espEnabled = not espEnabled
    if espEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            addHighlight(player)
        end
    else
        for player, _ in pairs(highlights) do
            removeHighlight(player)
        end
    end
    updateStatus(espEnabled)
end)

Players.PlayerAdded:Connect(function(player)
    if espEnabled then
        addHighlight(player)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    removeHighlight(player)
end)

-- Infinite Jump
local infiniteJump = false
local jumpConnection
local infiniteJumpButton, infiniteJumpUpdateStatus = createButton(MainFrame, "Infinite Jump", Color3.fromRGB(40, 40, 40), function(updateStatus)
    infiniteJump = not infiniteJump
    if infiniteJump and not jumpConnection then
        jumpConnection = UserInputService.JumpRequest:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid:ChangeState("Jumping")
            end
        end)
    elseif jumpConnection then
        jumpConnection:Disconnect()
        jumpConnection = nil
    end
    updateStatus(infiniteJump)
end)

-- Noclip
local noclip = false
local noclipConnection
local noclipButton, noclipUpdateStatus = createButton(MainFrame, "Noclip", Color3.fromRGB(40, 40, 40), function(updateStatus)
    noclip = not noclip
    if noclip then
        noclipConnection = RunService.Stepped:Connect(function()
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    elseif noclipConnection then
        noclipConnection:Disconnect()
        noclipConnection = nil
    end
    updateStatus(noclip)
end)

-- God Mode
local godMode = false
local godModeButton, godModeUpdateStatus = createButton(MainFrame, "God Mode", Color3.fromRGB(40, 40, 40), function(updateStatus)
    godMode = not godMode
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local humanoid = LocalPlayer.Character.Humanoid
        if godMode then
            humanoid.MaxHealth = math.huge
            humanoid.Health = math.huge
        else
            humanoid.MaxHealth = 100
            humanoid.Health = 100
        end
    end
    updateStatus(godMode)
end)

-- Hitbox
local hitboxEnabled = false
local hitboxButton, hitboxUpdateStatus = createButton(MainFrame, "Hitbox x6", Color3.fromRGB(40, 40, 40), function(updateStatus)
    hitboxEnabled = not hitboxEnabled
    if LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                if hitboxEnabled then
                    part.Size = part.Size * 6
                    part.Massless = true
                else
                    part.Size = part.Size / 6
                    part.Massless = false
                end
            end
        end
    end
    updateStatus(hitboxEnabled)
end)

-- AimBot
local aimEnabled = false
local aimIndicator = Instance.new("Frame")
aimIndicator.Size = UDim2.new(0, 10, 0, 10)
aimIndicator.Position = UDim2.new(0.5, -5, 0.5, -5)
aimIndicator.BackgroundColor3 = Color3.fromRGB(128, 0, 255)
aimIndicator.Visible = false
aimIndicator.ZIndex = 10
addUICorner(aimIndicator, 5)
addGlow(aimIndicator)
aimIndicator.Parent = ScreenGui

local function getClosestPlayer()
    local closestPlayer = nil
    local closestDistance = math.huge
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestPlayer = player
            end
        end
    end
    return closestPlayer
end

local aimConnection
local aimBotButton, aimBotUpdateStatus = createButton(MainFrame, "AimBot", Color3.fromRGB(40, 40, 40), function(updateStatus)
    aimEnabled = not aimEnabled
    aimIndicator.Visible = aimEnabled
    if aimEnabled then
        aimConnection = RunService.RenderStepped:Connect(function()
            local closestPlayer = getClosestPlayer()
            if closestPlayer and closestPlayer.Character then
                local head = closestPlayer.Character:FindFirstChild("Head")
                if head then
                    workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, head.Position)
                end
            end
        end)
    else
        if aimConnection then
            aimConnection:Disconnect()
            aimConnection = nil
        end
        workspace.CurrentCamera.CameraSubject = LocalPlayer.Character
    end
    updateStatus(aimEnabled)
end)

-- Spin
local flingEnabled = false
local flingConnection
local function toggleFling()
    flingEnabled = not flingEnabled
    if flingEnabled then
        flingConnection = RunService.Heartbeat:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(100), 0)
            end
        end)
    else
        if flingConnection then
            flingConnection:Disconnect()
            flingConnection = nil
        end
    end
end

local spinButton, spinUpdateStatus = createButton(MainFrame, "Spin", Color3.fromRGB(40, 40, 40), function(updateStatus)
    toggleFling()
    updateStatus(flingEnabled)
end)

-- Particle Burst
local particleBurstEnabled = false
local particleConnection
local particleButton, particleUpdateStatus = createButton(MainFrame, "Particle Burst", Color3.fromRGB(40, 40, 40), function(updateStatus)
    particleBurstEnabled = not particleBurstEnabled
    if particleBurstEnabled then
        particleConnection = RunService.Heartbeat:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local rootPart = LocalPlayer.Character.HumanoidRootPart
                for i = 1, 3 do
                    local particle = Instance.new("Part")
                    particle.Size = Vector3.new(0.5, 0.5, 0.5)
                    particle.Shape = Enum.PartType.Ball
                    particle.BrickColor = BrickColor.new(Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)))
                    particle.Material = Enum.Material.Neon
                    particle.Anchored = true
                    particle.CanCollide = false
                    particle.Position = rootPart.Position + Vector3.new(math.random(-5, 5), math.random(0, 5), math.random(-5, 5))
                    particle.Parent = workspace

                    local velocity = Vector3.new(math.random(-10, 10), math.random(5, 15), math.random(-10, 10))
                    TweenService:Create(particle, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Position = particle.Position + velocity,
                        Transparency = 1
                    }):Play()
                    task.delay(1, function()
                        particle:Destroy()
                    end)
                end
            end
        end)
    elseif particleConnection then
        particleConnection:Disconnect()
        particleConnection = nil
    end
    updateStatus(particleBurstEnabled)
end)

-- Fly
local flyEnabled = false
local flyButton, flyUpdateStatus = createButton(MainFrame, "Fly", Color3.fromRGB(40, 40, 40), function(updateStatus)
    flyEnabled = not flyEnabled
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Muhammadabid7/payment/refs/heads/main/fly.lua"))()
    updateStatus(flyEnabled)
end)

-- Sus
local susEnabled = false
local susButton, susUpdateStatus = createButton(MainFrame, "Sus", Color3.fromRGB(40, 40, 40), function(updateStatus)
    susEnabled = not susEnabled
    loadstring(game:HttpGet("https://raw.githubusercontent.com/RbxNoobScripter/nahhhbrrr/refs/heads/main/base.lua"))()
    updateStatus(susEnabled)
end)

-- InfiniteYield
local infiniteYieldEnabled = false
local infiniteYieldButton, infiniteYieldUpdateStatus = createButton(MainFrame, "InfiniteYield", Color3.fromRGB(40, 40, 40), function(updateStatus)
    infiniteYieldEnabled = not infiniteYieldEnabled
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    updateStatus(infiniteYieldEnabled)
end)

-- Freecam
local freecamEnabled = false
local freecamButton, freecamUpdateStatus = createButton(MainFrame, "Freecam", Color3.fromRGB(40, 40, 40), function(updateStatus)
    freecamEnabled = not freecamEnabled
    _G.freecamEnabled = freecamEnabled
    local camera = workspace.CurrentCamera
    local speed = 50
    local mouse = LocalPlayer:GetMouse()
    local moveDirection = Vector3.new()

    if freecamEnabled then
        local originalSubject = camera.CameraSubject
        local originalType = camera.CameraType
        camera.CameraType = Enum.CameraType.Scriptable
        camera.CFrame = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart.CFrame or camera.CFrame

        local connection
        connection = RunService.RenderStepped:Connect(function(dt)
            if not freecamEnabled then
                connection:Disconnect()
                return
            end
            moveDirection = Vector3.new(
                (UserInputService:IsKeyDown(Enum.KeyCode.D) and 1 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.A) and 1 or 0),
                (UserInputService:IsKeyDown(Enum.KeyCode.E) and 1 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.Q) and 1 or 0),
                (UserInputService:IsKeyDown(Enum.KeyCode.S) and 1 or 0) - (UserInputService:IsKeyDown(Enum.KeyCode.W) and 1 or 0)
            ).Unit * speed * dt
            camera.CFrame = camera.CFrame * CFrame.Angles(0, -mouse.Delta.X * 0.002, 0)
            camera.CFrame = camera.CFrame * CFrame.Angles(-mouse.Delta.Y * 0.002, 0, 0)
            camera.CFrame = camera.CFrame + camera.CFrame:VectorToWorldSpace(moveDirection)
        end)
        game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer("Freecam activated!", "All")
    else
        camera.CameraType = Enum.CameraType.Custom
        camera.CameraSubject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") or nil
        game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer("Freecam off!", "All")
    end
    updateStatus(freecamEnabled)
end)

-- XRay
local isInvisible = false
local xrayButton, xrayUpdateStatus = createButton(MainFrame, "XRay", Color3.fromRGB(40, 40, 40), function(updateStatus)
    isInvisible = not isInvisible
    for _, object in pairs(game:GetDescendants()) do
        if (object:IsA("BasePart") or object:IsA("Decal") or object:IsA("Texture")) and
           not object:IsDescendantOf(game.Players) and not object:IsA("SpawnLocation") then
            object.Transparency = isInvisible and 0.8 or 0
        end
    end
    updateStatus(isInvisible)
end)

-- Rejoin
local rejoinButton, rejoinUpdateStatus = createButton(MainFrame, "Rejoin Game", Color3.fromRGB(40, 40, 40), function(updateStatus)
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
    updateStatus(false)
end)

-- Teleport to Player
local teleportFrame = Instance.new("Frame")
teleportFrame.Parent = MainFrame
teleportFrame.Size = UDim2.new(0, 260, 0, 0)
teleportFrame.BackgroundTransparency = 1
teleportFrame.ClipsDescendants = true
teleportFrame.Visible = false
teleportFrame.ZIndex = 5

local teleportLayout = Instance.new("UIListLayout")
teleportLayout.Parent = teleportFrame
teleportLayout.SortOrder = Enum.SortOrder.LayoutOrder
teleportLayout.Padding = UDim.new(0, 8)
teleportLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local teleportVisible = false
local teleportButtons = {}
local function updateTeleportButtons()
    for _, button in pairs(teleportButtons) do button:Destroy() end
    teleportButtons = {}
    if teleportVisible then
        teleportFrame.Visible = true
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local button, _ = createButton(teleportFrame, "Bidzz TP " .. player.Name, Color3.fromRGB(40, 40, 40), function()
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                    end
                end)
                table.insert(teleportButtons, button)
            end
        end
        teleportFrame.Size = UDim2.new(0, 260, 0, teleportLayout.AbsoluteContentSize.Y)
    else
        teleportFrame.Visible = false
        teleportFrame.Size = UDim2.new(0, 260, 0, 0)
    end
end

local teleportButton, teleportUpdateStatus = createButton(MainFrame, "Teleport to Player", Color3.fromRGB(40, 40, 40), function(updateStatus)
    teleportVisible = not teleportVisible
    updateTeleportButtons()
    updateStatus(teleportVisible)
end)

Players.PlayerAdded:Connect(function(player)
    if teleportVisible then updateTeleportButtons() end
end)
Players.PlayerRemoving:Connect(function(player)
    if teleportVisible then updateTeleportButtons() end
end)

-- GUI Toggle with Debug Print
local guiVisible = false
ToggleButton.MouseButton1Click:Connect(function()
    print("ToggleButton clicked, guiVisible: " .. tostring(guiVisible)) -- Debug print
    guiVisible = not guiVisible
    if guiVisible then
        MainFrame.Visible = true
        TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, -150, 0.5, -250),
            BackgroundTransparency = 0.1
        }):Play()
        TweenService:Create(ToggleButton, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
            Text = "✖",
            Rotation = 90
        }):Play()
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.In), {
            Position = UDim2.new(0, -300, 0.5, -250),
            BackgroundTransparency = 0.5
        }):Play()
        TweenService:Create(ToggleButton, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
            Text = "☰",
            Rotation = 0
        }):Play()
        task.delay(0.5, function()
            MainFrame.Visible = false
        end)
    end
end)

-- Canvas Size Update
UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    MainFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 20)
end)