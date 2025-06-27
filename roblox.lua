local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BidzzAdminHub"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- UI Helper Functions
local function addUICorner(instance, cornerRadius)
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, cornerRadius or 8)
    UICorner.Parent = instance
end

local function addGlow(instance, thickness)
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Thickness = thickness or 2
    UIStroke.Color = Color3.fromRGB(0, 255, 255)
    UIStroke.Transparency = 0.4
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke.Parent = instance
end

local function addGradient(instance, color1, color2)
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, color1 or Color3.fromRGB(30, 30, 60)),
        ColorSequenceKeypoint.new(1, color2 or Color3.fromRGB(80, 0, 160))
    })
    UIGradient.Rotation = 45
    UIGradient.Parent = instance
end

local function addShadow(instance)
    local Shadow = Instance.new("UIStroke")
    Shadow.Thickness = 3
    Shadow.Color = Color3.fromRGB(0, 0, 0)
    Shadow.Transparency = 0.7
    Shadow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    Shadow.Parent = instance
end

-- Loading Screen
local function createLoadingScreen()
    local LoadingFrame = Instance.new("Frame")
    LoadingFrame.Size = UDim2.new(1, 0, 1, 0)
    LoadingFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    LoadingFrame.BackgroundTransparency = 0.1
    LoadingFrame.Parent = ScreenGui
    LoadingFrame.ZIndex = 100
    addGradient(LoadingFrame, Color3.fromRGB(10, 10, 30), Color3.fromRGB(60, 0, 120))
    addShadow(LoadingFrame)

    local LoadingText = Instance.new("TextLabel")
    LoadingText.Size = UDim2.new(0, 500, 0, 80)
    LoadingText.Position = UDim2.new(0.5, -250, 0.45, -40)
    LoadingText.BackgroundTransparency = 1
    LoadingText.Text = "Initializing Bidzz Official AdminHub..."
    LoadingText.TextColor3 = Color3.fromRGB(0, 255, 255)
    LoadingText.Font = Enum.Font.SourceSansBold
    LoadingText.TextSize = 40
    LoadingText.TextStrokeTransparency = 0.7
    LoadingText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    LoadingText.Parent = LoadingFrame
    addShadow(LoadingText)

    local function floatText()
        TweenService:Create(LoadingText, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            Position = UDim2.new(0.5, -250, 0.45, -20)
        }):Play()
    end
    floatText()

    for i = 1, 10 do
        local Particle = Instance.new("Frame")
        Particle.Size = UDim2.new(0, 12, 0, 12)
        Particle.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        Particle.BackgroundTransparency = 0.3
        Particle.Parent = LoadingFrame
        addUICorner(Particle, 12)

        local angle = i * (360 / 10)
        RunService.RenderStepped:Connect(function(delta)
            angle = angle + delta * 120
            Particle.Position = UDim2.new(0.5, math.cos(math.rad(angle)) * 120, 0.5, math.sin(math.rad(angle)) * 120)
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
                    BackgroundTransparency = 1
                }):Play()
            end
        end
        task.delay(0.8, function()
            LoadingFrame:Destroy()
        end)
    end)
end

createLoadingScreen()

-- Toggle Button
local ToggleButton = Instance.new("TextButton")
ToggleButton.Parent = ScreenGui
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 20, 0, 20)
ToggleButton.Text = "☰"
ToggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
ToggleButton.TextColor3 = Color3.fromRGB(0, 255, 255)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 28
addUICorner(ToggleButton, 12)
addGlow(ToggleButton)
addGradient(ToggleButton)
addShadow(ToggleButton)

ToggleButton.MouseEnter:Connect(function()
    TweenService:Create(ToggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, 55, 0, 55),
        BackgroundColor3 = Color3.fromRGB(40, 40, 80)
    }):Play()
end)
ToggleButton.MouseLeave:Connect(function()
    TweenService:Create(ToggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0, 50, 0, 50),
        BackgroundColor3 = Color3.fromRGB(20, 20, 40)
    }):Play()
end)

-- Main Frame
local MainFrame = Instance.new("ScrollingFrame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 400, 0, 500)
MainFrame.Position = UDim2.new(0, 90, 0, 20)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
MainFrame.BackgroundTransparency = 0.05
MainFrame.ScrollBarThickness = 4
MainFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 255)
MainFrame.Visible = true
MainFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
addUICorner(MainFrame, 16)
addGlow(MainFrame, 2.5)
addGradient(MainFrame)
addShadow(MainFrame)

-- UI List Layout
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = MainFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Title
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, -20, 0, 60)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 32
Title.Text = "Bidzz Official AdminHub V3"
Title.TextStrokeTransparency = 0.7
Title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
addUICorner(Title, 8)
addShadow(Title)

local function floatTitle()
    TweenService:Create(Title, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        Position = UDim2.new(0, 0, 0, 5)
    }):Play()
end
floatTitle()

-- Text Boxes
local function createTextBox(parent, placeholder, size)
    local TextBox = Instance.new("TextBox")
    TextBox.Parent = parent
    TextBox.Size = size or UDim2.new(1, -30, 0, 40)
    TextBox.BackgroundColor3 = Color3.fromRGB(25, 25, 50)
    TextBox.TextColor3 = Color3.fromRGB(0, 255, 255)
    TextBox.Font = Enum.Font.SourceSans
    TextBox.TextSize = 18
    TextBox.PlaceholderText = placeholder
    TextBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 150)
    TextBox.ClearTextOnFocus = false
    addUICorner(TextBox, 10)
    addGlow(TextBox)
    addShadow(TextBox)
    return TextBox
end

local SpeedBox = createTextBox(MainFrame, "Enter WalkSpeed")
local JumpBox = createTextBox(MainFrame, "Enter JumpPower")
local GravityBox = createTextBox(MainFrame, "Set Gravity Value")

-- Button Creation
local function createButton(parent, text, color, callback)
    local Button = Instance.new("TextButton")
    Button.Parent = parent
    Button.Size = UDim2.new(1, -30, 0, 50)
    Button.BackgroundColor3 = color or Color3.fromRGB(40, 40, 80)
    Button.TextColor3 = Color3.fromRGB(0, 255, 255)
    Button.Font = Enum.Font.SourceSansBold
    Button.TextSize = 18
    Button.Text = text
    addUICorner(Button, 10)
    addGlow(Button)
    addGradient(Button)
    addShadow(Button)

    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            Size = UDim2.new(1, -20, 0, 55),
            BackgroundColor3 = Color3.fromRGB(color.R * 255 + 30, color.G * 255 + 30, color.B * 255 + 30)
        }):Play()
    end)
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            Size = UDim2.new(1, -30, 0, 50),
            BackgroundColor3 = color
        }):Play()
    end)

    Button.MouseButton1Click:Connect(callback)
    return Button
end

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
local gravityEnabled = true
local gravityValue = workspace.Gravity

createButton(MainFrame, "Toggle Gravity", Color3.fromRGB(40, 40, 80), function()
    gravityEnabled = not gravityEnabled
    if gravityEnabled then
        workspace.Gravity = gravityValue
    else
        workspace.Gravity = 0
    end
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

createButton(MainFrame, "ESP", Color3.fromRGB(40, 40, 80), function()
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
createButton(MainFrame, "Infinite Jump", Color3.fromRGB(40, 40, 80), function()
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
end)

-- Noclip
local noclip = false
local noclipConnection
createButton(MainFrame, "Noclip/Clip", Color3.fromRGB(40, 40, 80), function()
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
end)

-- God Mode
local godMode = false
createButton(MainFrame, "God Mode", Color3.fromRGB(40, 40, 80), function()
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
end)

-- Hitbox
local hitboxEnabled = false
createButton(MainFrame, "Hitbox x6", Color3.fromRGB(40, 40, 80), function()
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
end)

-- Tool Size
local toolSizeMultiplier = false
createButton(MainFrame, "Tool Size x4", Color3.fromRGB(40, 40, 80), function()
    toolSizeMultiplier = not toolSizeMultiplier
    for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
        if tool:IsA("Tool") then
            for _, part in pairs(tool:GetDescendants()) do
                if part:IsA("BasePart") then
                    if toolSizeMultiplier then
                        part.Size = part.Size * 4
                    else
                        part.Size = part.Size / 4
                    end
                end
            end
        end
    end
end)

-- Spawn Objects
local spawnObjectsEnabled = true
createButton(MainFrame, "Spawn Objects", Color3.fromRGB(40, 40, 80), function()
    spawnObjectsEnabled = not spawnObjectsEnabled
    if spawnObjectsEnabled then
        local objectTypes = {"Ball", "Cube"}
        local spawnObject = function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local humanoidRootPart = LocalPlayer.Character.HumanoidRootPart
                local objectType = objectTypes[math.random(1, #objectTypes)]
                local newObject

                if objectType == "Ball" then
                    newObject = Instance.new("Part")
                    newObject.Shape = Enum.PartType.Ball
                elseif objectType == "Cube" then
                    newObject = Instance.new("Part")
                end

                if newObject then
                    newObject.Size = Vector3.new(5, 5, 5)
                    newObject.Position = humanoidRootPart.Position + humanoidRootPart.CFrame.LookVector * 5
                    newObject.BrickColor = BrickColor.Random()
                    newObject.Material = Enum.Material.Neon
                    newObject.Anchored = false
                    newObject.Parent = workspace
                end
            end
        end
        spawnObject()
    end
end)

-- Random Colors
local randomizeColorsEnabled = false
local randomizeConnection
createButton(MainFrame, "Random Colors", Color3.fromRGB(40, 40, 80), function()
    randomizeColorsEnabled = not randomizeColorsEnabled
    if randomizeColorsEnabled then
        randomizeConnection = RunService.Heartbeat:Connect(function()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    obj.BrickColor = BrickColor.Random()
                end
            end
        end)
    elseif randomizeConnection then
        randomizeConnection:Disconnect()
        randomizeConnection = nil
    end
end)

-- Players Visibility
local playersInvisible = false
createButton(MainFrame, "Players Visibility", Color3.fromRGB(40, 40, 80), function()
    playersInvisible = not playersInvisible
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            for _, part in pairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = playersInvisible and 1 or 0
                    part.CanCollide = not playersInvisible
                elseif part:IsA("Decal") then
                    part.Transparency = playersInvisible and 1 or 0
                end
            end
        end
    end
end)

-- AimBot
local aimEnabled = false
local aimIndicator = Instance.new("Frame")
aimIndicator.Size = UDim2.new(0, 8, 0, 8)
aimIndicator.Position = UDim2.new(0.5, -4, 0.5, -4)
aimIndicator.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
aimIndicator.Visible = false
addUICorner(aimIndicator, 8)
addGlow(aimIndicator)
addGradient(aimIndicator)
addShadow(aimIndicator)
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
createButton(MainFrame, "AimBot", Color3.fromRGB(40, 40, 80), function()
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

createButton(MainFrame, "Spin", Color3.fromRGB(40, 40, 80), function()
    toggleFling()
end)

-- Particle Burst
local particleBurstEnabled = false
local particleConnection
createButton(MainFrame, "Particle Burst", Color3.fromRGB(40, 40, 80), function()
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
end)

-- External Scripts
createButton(MainFrame, "Black Hole", Color3.fromRGB(40, 40, 80), function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/RbxNoobScripter/Shhh-/refs/heads/main/Basic.lua"))()
end)

createButton(MainFrame, "Telekinesis", Color3.fromRGB(40, 40, 80), function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/RbxNoobScripter/REAL-SIGMA-SCRIPT-/refs/heads/main/Main.lua"))()
end)

createButton(MainFrame, "Fly", Color3.fromRGB(40, 40, 80), function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/RbxNoobScripter/FlyingSigma/refs/heads/main/Goida.lua"))()
end)

createButton(MainFrame, "SCP BY G10", Color3.fromRGB(40, 40, 80), function()
    loadstring(game:HttpGet("https://pastefy.app/YsJgITXR/raw"))()
end)

createButton(MainFrame, "Sus", Color3.fromRGB(40, 40, 80), function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/RbxNoobScripter/nahhhbrrr/refs/heads/main/base.lua"))()
end)

createButton(MainFrame, "InfiniteYield", Color3.fromRGB(40, 40, 80), function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

-- Screen Flash
createButton(MainFrame, "Screen Flash", Color3.fromRGB(40, 40, 80), function()
    local flash = Instance.new("Frame")
    flash.Size = UDim2.new(1, 0, 1, 0)
    flash.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    flash.BackgroundTransparency = 0
    flash.Parent = ScreenGui
    flash.ZIndex = 10
    addGradient(flash)
    addShadow(flash)

    for i = 1, 10 do
        local particle = Instance.new("Frame")
        particle.Size = UDim2.new(0, 5, 0, 5)
        particle.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
        particle.Position = UDim2.new(0.5, 0, 0.5, 0)
        particle.Parent = flash
        addUICorner(particle, 5)
        TweenService:Create(particle, TweenInfo.new(0.5), {
            Position = UDim2.new(0.5, math.random(-200, 200), 0.5, math.random(-200, 200)),
            BackgroundTransparency = 1
        }):Play()
        task.delay(0.5, function()
            particle:Destroy()
        end)
    end

    TweenService:Create(flash, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
        BackgroundTransparency = 1
    }):Play()
    task.delay(0.5, function()
        flash:Destroy()
    end)

    game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer("FLASH!", "All")
end)

-- Freecam
createButton(MainFrame, "Freecam", Color3.fromRGB(40, 40, 80), function()
    local freecamEnabled = not _G.freecamEnabled
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
end)

-- Timer
local activeTimerGui = nil
createButton(MainFrame, "Timer", Color3.fromRGB(40, 40, 80), function()
    if activeTimerGui then
        activeTimerGui:Destroy()
        activeTimerGui = nil
        return
    end

    local TimerScreenGui = Instance.new("ScreenGui")
    TimerScreenGui.Parent = LocalPlayer.PlayerGui
    activeTimerGui = TimerScreenGui

    local TimerFrame = Instance.new("Frame")
    TimerFrame.Size = UDim2.new(0, 350, 0, 500)
    TimerFrame.Position = UDim2.new(0.5, -175, 0.5, -250)
    TimerFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
    TimerFrame.BackgroundTransparency = 0.05
    TimerFrame.Parent = TimerScreenGui
    addUICorner(TimerFrame, 16)
    addGlow(TimerFrame, 2.5)
    addGradient(TimerFrame)
    addShadow(TimerFrame)

    TweenService:Create(TimerFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -175, 0.5, -250)
    }):Play()

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
    Title.Text = "Bidzz Official Timer"
    Title.TextColor3 = Color3.fromRGB(0, 255, 255)
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 24
    Title.Parent = TimerFrame
    addUICorner(Title, 10)
    addShadow(Title)

    local TimeDisplay = Instance.new("TextLabel")
    TimeDisplay.Size = UDim2.new(1, 0, 0, 100)
    TimeDisplay.Position = UDim2.new(0, 0, 0, 60)
    TimeDisplay.BackgroundTransparency = 1
    TimeDisplay.Text = "00:00:00"
    TimeDisplay.TextColor3 = Color3.fromRGB(0, 255, 255)
    TimeDisplay.Font = Enum.Font.SourceSansBold
    TimeDisplay.TextSize = 48
    TimeDisplay.Parent = TimerFrame

    local BestTimeLabel = Instance.new("TextLabel")
    BestTimeLabel.Size = UDim2.new(1, 0, 0, 30)
    BestTimeLabel.Position = UDim2.new(0, 0, 0, 170)
    BestTimeLabel.BackgroundTransparency = 1
    BestTimeLabel.Text = "Best: --:--:--"
    BestTimeLabel.TextColor3 = Color3.fromRGB(100, 100, 150)
    BestTimeLabel.Font = Enum.Font.SourceSans
    BestTimeLabel.TextSize = 20
    BestTimeLabel.Parent = TimerFrame

    local timeElapsed = 0
    local isRunning = false
    local bestTime = math.huge
    local lapTimes = {}

    local StartPauseButton = createButton(TimerFrame, "Start", Color3.fromRGB(40, 40, 80), function()
        isRunning = not isRunning
        StartPauseButton.Text = isRunning and "Pause" or "Start"
    end)
    StartPauseButton.Position = UDim2.new(0, 10, 0, 210)
    StartPauseButton.Size = UDim2.new(0, 100, 0, 40)

    local ResetButton = createButton(TimerFrame, "Reset", Color3.fromRGB(40, 40, 80), function()
        isRunning = false
        timeElapsed = 0
        TimeDisplay.Text = "00:00:00"
        StartPauseButton.Text = "Start"
    end)
    ResetButton.Position = UDim2.new(0, 120, 0, 210)
    ResetButton.Size = UDim2.new(0, 100, 0, 40)

    local LapButton = createButton(TimerFrame, "Lap", Color3.fromRGB(40, 40, 80), function()
        if isRunning and timeElapsed > 0 then
            table.insert(lapTimes, timeElapsed)
            for i, lapLabel in pairs(TimerFrame:GetChildren()) do
                if lapLabel.Name:match("LapLabel") then
                    lapLabel:Destroy()
                end
            end
            for i, lapTime in ipairs(lapTimes) do
                if i <= 5 then
                    local lapLabel = Instance.new("TextLabel")
                    lapLabel.Name = "LapLabel" .. i
                    lapLabel.Size = UDim2.new(1, 0, 0, 20)
                    lapLabel.Position = UDim2.new(0, 0, 0, 250 + (i-1)*25)
                    lapLabel.BackgroundTransparency = 1
                    lapLabel.Text = string.format("Lap %d: %s", i, formatTime(lapTime))
                    lapLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
                    lapLabel.Font = Enum.Font.SourceSans
                    lapLabel.TextSize = 16
                    lapLabel.Parent = TimerFrame
                end
            end
        end
    end)
    LapButton.Position = UDim2.new(0, 230, 0, 210)
    LapButton.Size = UDim2.new(0, 100, 0, 40)

    local CloseButton = createButton(TimerFrame, "X", Color3.fromRGB(40, 40, 80), function()
        TimerScreenGui:Destroy()
        activeTimerGui = nil
    end)
    CloseButton.Position = UDim2.new(1, -30, 0, 10)
    CloseButton.Size = UDim2.new(0, 20, 0, 20)

    local function formatTime(time)
        local minutes = math.floor(time / 60)
        local seconds = math.floor(time % 60)
        local milliseconds = math.floor((time * 100) % 100)
        return string.format("%02d:%02d:%02d", minutes, seconds, milliseconds)
    end

    RunService.Heartbeat:Connect(function(deltaTime)
        if isRunning then
            timeElapsed = timeElapsed + deltaTime
            TimeDisplay.Text = formatTime(timeElapsed)
            if timeElapsed > 0 and (timeElapsed < bestTime or bestTime == math.huge) and not isRunning then
                bestTime = timeElapsed
                BestTimeLabel.Text = "Best: " .. formatTime(bestTime)
            end
        end
    end)
end)

-- Random Text
createButton(MainFrame, "Random Text", Color3.fromRGB(40, 40, 80), function()
    local fonts = {
        Enum.Font.SourceSans, Enum.Font.Cartoon, Enum.Font.Code, Enum.Font.Arcade,
        Enum.Font.Fantasy, Enum.Font.Highway, Enum.Font.SourceSansBold, Enum.Font.Bodoni,
        Enum.Font.Garamond, Enum.Font.AmaticSC, Enum.Font.FredokaOne, Enum.Font.Bangers
    }
    local randomFont = fonts[math.random(1, #fonts)]
    for _, object in pairs(game:GetDescendants()) do
        if object:IsA("TextLabel") or object:IsA("TextButton") or object:IsA("TextBox") then
            local fadeOut = TweenService:Create(object, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {TextTransparency = 1})
            fadeOut:Play()
            fadeOut.Completed:Connect(function()
                object.Font = randomFont
                local fadeIn = TweenService:Create(object, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {TextTransparency = 0})
                fadeIn:Play()
            end)
        end
    end
end)

-- XRay
local isInvisible = false
createButton(MainFrame, "XRay", Color3.fromRGB(40, 40, 80), function()
    isInvisible = not isInvisible
    for _, object in pairs(game:GetDescendants()) do
        if (object:IsA("BasePart") or object:IsA("Decal") or object:IsA("Texture")) and
           not object:IsDescendantOf(game.Players) and not object:IsA("SpawnLocation") then
            object.Transparency = isInvisible and 0.8 or 0
        end
    end
end)

-- SpamBot + Walk-Bot
createButton(MainFrame, "SpamBot + Walk-Bot", Color3.fromRGB(40, 40, 80), function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/RbxNoobScripter/Admin-panel-Script-/refs/heads/main/qwerty.lua"))()
end)

-- Lua IDE
createButton(MainFrame, "Lua IDE", Color3.fromRGB(40, 40, 80), function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/RbxNoobScripter/Admin-panel-Script-/refs/heads/main/ytrewq1234556666.lua"))()
end)

-- Rejoin
createButton(MainFrame, "Rejoin Game", Color3.fromRGB(40, 40, 80), function()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

-- Teleport to Player
local teleportVisible = false
local teleportButtons = {}
local function updateTeleportButtons()
    for _, button in pairs(teleportButtons) do button:Destroy() end
    teleportButtons = {}
    if teleportVisible then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                local button = createButton(MainFrame, "TP to " .. player.Name, Color3.fromRGB(40, 40, 80), function()
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                    end
                end)
                table.insert(teleportButtons, button)
            end
        end
    end
end

createButton(MainFrame, "Teleport to Player", Color3.fromRGB(40, 40, 80), function()
    teleportVisible = not teleportVisible
    updateTeleportButtons()
end)

Players.PlayerAdded:Connect(function(player)
    if teleportVisible then updateTeleportButtons() end
end)
Players.PlayerRemoving:Connect(function(player)
    if teleportVisible then updateTeleportButtons() end
end)

-- GUI Toggle
local guiVisible = true
ToggleButton.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    if guiVisible then
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, 90, 0, 20)
        }):Play()
        MainFrame.Visible = true
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(0, 90, -1, 0)
        }):Play()
        task.delay(0.4, function()
            MainFrame.Visible = false
        end)
    end
end)

-- Canvas Size Update
UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    MainFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 40)
end)