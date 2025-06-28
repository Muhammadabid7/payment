local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local isR6 = character:FindFirstChild("Torso") ~= nil

-- Notification Function
local function showNotification(message)
    local notificationGui = Instance.new("ScreenGui")
    notificationGui.Name = "NotificationGui"
    notificationGui.Parent = game.CoreGui

    local notificationFrame = Instance.new("Frame")
    notificationFrame.Size = UDim2.new(0, 300, 0, 50)
    notificationFrame.Position = UDim2.new(0.5, -150, 1, -60)
    notificationFrame.AnchorPoint = Vector2.new(0.5, 1)
    notificationFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 50) -- Dark Blue
    notificationFrame.BorderSizePixel = 0
    notificationFrame.Parent = notificationGui

    local uicorner = Instance.new("UICorner")
    uicorner.CornerRadius = UDim.new(0, 10)
    uicorner.Parent = notificationFrame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(50, 100, 255) -- Light Blue
    stroke.Thickness = 1
    stroke.Parent = notificationFrame

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, -20, 1, 0)
    textLabel.Position = UDim2.new(0, 10, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = message .. " | by Bidzz"
    textLabel.TextColor3 = Color3.fromRGB(50, 100, 255) -- Light Blue
    textLabel.Font = Enum.Font.Code
    textLabel.TextSize = 18
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Parent = notificationFrame

    notificationFrame.BackgroundTransparency = 1
    textLabel.TextTransparency = 1

    TweenService:Create(
        notificationFrame,
        TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        {BackgroundTransparency = 0}
    ):Play()

    TweenService:Create(
        textLabel,
        TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        {TextTransparency = 0}
    ):Play()

    task.delay(5, function()
        TweenService:Create(
            notificationFrame,
            TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
            {BackgroundTransparency = 1}
        ):Play()

        TweenService:Create(
            textLabel,
            TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
            {TextTransparency = 1}
        ):Play()

        task.delay(0.5, function()
            notificationGui:Destroy()
        end)
    end)
end

-- Show notification based on rig type
if isR6 then
    showNotification("🐿 R6 detected!")
else
    showNotification("❨ R15 detected!")
end

-- Create Screen GUI
local gui = Instance.new("ScreenGui")
gui.Name = "BlueTerminalGui"
gui.Parent = game.CoreGui

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 360)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 50) -- Deep Blue
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(50, 100, 255) -- Light Blue
stroke.Thickness = 1.5
stroke.Transparency = 0.3
stroke.Parent = mainFrame

local uicorner = Instance.new("UICorner")
uicorner.CornerRadius = UDim.new(0, 10)
uicorner.Parent = mainFrame

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(0, 0, 70) -- Slightly Lighter Blue
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "BLUE TERMINAL - Script Sus"
title.TextColor3 = Color3.fromRGB(50, 100, 255) -- Light Blue
title.Font = Enum.Font.Code
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

-- Close Button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 100) -- Darker Blue
closeButton.Text = "X"
closeButton.Font = Enum.Font.Code
closeButton.TextSize = 18
closeButton.TextColor3 = Color3.fromRGB(50, 100, 255) -- Light Blue
closeButton.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Minimize Button
local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -70, 0, 5)
minimizeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 90) -- Slightly Darker Blue
minimizeButton.Text = "-"
minimizeButton.Font = Enum.Font.Code
minimizeButton.TextSize = 18
minimizeButton.TextColor3 = Color3.fromRGB(50, 100, 255) -- Light Blue
minimizeButton.Parent = titleBar

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 8)
minimizeCorner.Parent = minimizeButton

local minimized = false
minimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        mainFrame:TweenSize(UDim2.new(0, 320, 0, 40), Enum.EasingDirection.In, Enum.EasingStyle.Quint, 0.5)
    else
        mainFrame:TweenSize(UDim2.new(0, 320, 0, 360), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, 0.5)
    end)
end)

-- Scrolling Frame
local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Size = UDim2.new(1, -20, 1, -50)
scrollingFrame.Position = UDim2.new(0, 10, 0, 45)
scrollingFrame.BackgroundTransparency = 1
scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 300)
scrollingFrame.ScrollBarThickness = 4
scrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(50, 100, 255) -- Light Blue
scrollingFrame.Parent = mainFrame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 10)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.Parent = scrollingFrame

-- Button Functions
local function bang()
    -- Bang GUI
    local bangGui = Instance.new("ScreenGui")
    bangGui.Name = "BangGUI"
    bangGui.Parent = game.CoreGui

    local bangFrame = Instance.new("Frame")
    bangFrame.Parent = bangGui
    bangFrame.Size = UDim2.new(0, 300, 0, 150)
    bangFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
    bangFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 50) -- Dark Blue
    bangFrame.BorderSizePixel = 0
    bangFrame.Draggable = true
    bangFrame.Active = true

    local bangCorner = Instance.new("UICorner")
    bangCorner.CornerRadius = UDim.new(0, 20)
    bangCorner.Parent = bangFrame

    local bangTitleBar = Instance.new("Frame")
    bangTitleBar.Parent = bangFrame
    bangTitleBar.Size = UDim2.new(1, 0, 0, 25)
    bangTitleBar.BackgroundColor3 = Color3.fromRGB(0, 0, 70) -- Slightly Lighter Blue
    bangTitleBar.BorderSizePixel = 0

    local bangTitleLabel = Instance.new("TextLabel")
    bangTitleLabel.Parent = bangTitleBar
    bangTitleLabel.Size = UDim2.new(0, 50, 1, 0)
    bangTitleLabel.Position = UDim2.new(0, 5, 0, 0)
    bangTitleLabel.Text = "Bang V2"
    bangTitleLabel.TextColor3 = Color3.fromRGB(50, 100, 255) -- Light Blue
    bangTitleLabel.BackgroundTransparency = 1
    bangTitleLabel.TextSize = 14

    local bangCloseButton = Instance.new("TextButton")
    bangCloseButton.Parent = bangTitleBar
    bangCloseButton.Size = UDim2.new(0, 25, 1, 0)
    bangCloseButton.Position = UDim2.new(1, -25, 0, 0)
    bangCloseButton.Text = "X"
    bangCloseButton.TextColor3 = Color3.fromRGB(50, 100, 255)
    bangCloseButton.BackgroundColor3 = Color3.fromRGB(0, 0, 100) -- Darker Blue
    bangCloseButton.BorderSizePixel = 0
    bangCloseButton.MouseButton1Click:Connect(function()
        bangGui:Destroy()
    end)

    local bangMinimizeButton = Instance.new("TextButton")
    bangMinimizeButton.Parent = bangTitleBar
    bangMinimizeButton.Size = UDim2.new(0, 50, 1, 0)
    bangMinimizeButton.Position = UDim2.new(1, -75, 0, 0)
    bangMinimizeButton.Text = "Hide"
    bangMinimizeButton.TextColor3 = Color3.fromRGB(50, 100, 255)
    bangMinimizeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 90) -- Slightly Darker Blue
    bangMinimizeButton.BorderSizePixel = 0

    local bangMinimized = false
    bangMinimizeButton.MouseButton1Click:Connect(function()
        if not bangMinimized then
            bangFrame.Size = UDim2.new(0, 300, 0, 25)
            bangMinimizeButton.Text = "Show"
        else
            bangFrame.Size = UDim2.new(0, 300, 0, 150)
            bangMinimizeButton.Text = "Hide"
        end
        bangMinimized = not bangMinimized
    end)

    local targetTextBox = Instance.new("TextBox")
    targetTextBox.Parent = bangFrame
    targetTextBox.Size = UDim2.new(0.9, 0, 0, 30)
    targetTextBox.Position = UDim2.new(0.05, 0, 0.3, 0)
    targetTextBox.PlaceholderText = "Enter target name"
    targetTextBox.Text = ""
    targetTextBox.TextColor3 = Color3.fromRGB(50, 100, 255)
    targetTextBox.BackgroundColor3 = Color3.fromRGB(0, 0, 70)
    targetTextBox.BorderSizePixel = 0

    local toggleButton = Instance.new("TextButton")
    toggleButton.Parent = bangFrame
    toggleButton.Size = UDim2.new(0.9, 0, 0, 30)
    toggleButton.Position = UDim2.new(0.05, 0, 0.6, 0)
    toggleButton.Text = "Start"
    toggleButton.TextColor3 = Color3.fromRGB(50, 100, 255)
    toggleButton.BackgroundColor3 = Color3.fromRGB(0, 50, 120)
    toggleButton.BorderSizePixel = 0

    local following = false
    local targetPlayer = nil
    local animationId = isR6 and "189854234" or "182789003"

    toggleButton.MouseButton1Click:Connect(function()
        if not following then
            local targetName = targetTextBox.Text:lower()
            targetPlayer = nil
            
            for _, player in pairs(Players:GetPlayers()) do
                if player.Name:lower():find(targetName) or player.DisplayName:lower():find(targetName) then
                    targetPlayer = player
                    break
                end
            end
            
            if targetPlayer and targetPlayer.Character then
                following = true
                toggleButton.Text = "Stop"
                
                local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                local animation = Instance.new("Animation")
                animation.AnimationId = "rbxassetid://" .. animationId
                local animator = humanoid:LoadAnimation(animation)

                coroutine.wrap(function()
                    local lastCFrame = nil
                    while following do
                        local targetCharacter = targetPlayer.Character
                        if targetCharacter and targetCharacter.PrimaryPart then
                            local targetCFrame = targetCharacter.PrimaryPart.CFrame
                            local followCFrame = targetCFrame * CFrame.new(0, 0, 1.2)
                            
                            if not lastCFrame or (followCFrame.Position - lastCFrame.Position).Magnitude > 0.1 or
                                (followCFrame.LookVector - lastCFrame.LookVector).Magnitude > 0.1 then
                                lastCFrame = followCFrame
                                LocalPlayer.Character:SetPrimaryPartCFrame(
                                    CFrame.new(followCFrame.Position) *
                                    CFrame.Angles(0, math.atan2(-targetCFrame.LookVector.X, -targetCFrame.LookVector.Z), 0)
                                )
                            end
                            
                            animator:Play()
                            task.wait(0.1)
                            animator:Stop()
                            task.wait(0.1)
                        else
                            following = false
                            toggleButton.Text = "Start"
                            break
                        end
                    end
                end)()
                showNotification("Executing Bang")
            else
                print("Target not found!")
            end
        else
            following = false
            toggleButton.Text = "Start"
        end
    end)
end

local function sus()
    local susGui = Instance.new("ScreenGui")
    susGui.Name = "GetSuckedGUI"
    susGui.Parent = game.CoreGui
    susGui.ResetOnSpawn = false

    local susFrame = Instance.new("Frame")
    susFrame.Name = "MainFrame"
    susFrame.Parent = susGui
    susFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 50)
    susFrame.Size = UDim2.new(0, 300, 0, 150)
    susFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
    susFrame.Active = true
    susFrame.Draggable = true
    susFrame.ClipsDescendants = true
    local susCorner = Instance.new("UICorner", susFrame)
    susCorner.CornerRadius = UDim.new(0, 15)

    local susTitleBar = Instance.new("Frame")
    susTitleBar.Name = "TitleBar"
    susTitleBar.Parent = susFrame
    susTitleBar.BackgroundColor3 = Color3.fromRGB(0, 0, 70)
    susTitleBar.Size = UDim2.new(1, 0, 0, 30)
    local titleBarCorner = Instance.new("UICorner", susTitleBar)
    titleBarCorner.CornerRadius = UDim.new(0, 15)

    local susTitle = Instance.new("TextLabel")
    susTitle.Name = "Title"
    susTitle.Parent = susTitleBar
    susTitle.BackgroundTransparency = 1
    susTitle.Size = UDim2.new(1, -60, 1, 0)
    susTitle.Font = Enum.Font.GothamBold
    susTitle.Text = "Get Sucked"
    susTitle.TextColor3 = Color3.fromRGB(50, 100, 255)
    susTitle.TextSize = 14
    susTitle.TextXAlignment = Enum.TextXAlignment.Left
    susTitle.Position = UDim2.new(0, 10, 0, 0)

    local susCloseButton = Instance.new("TextButton")
    susCloseButton.Name = "CloseButton"
    susCloseButton.Parent = susTitleBar
    susCloseButton.BackgroundColor3 = Color3.fromRGB(0, 0, 100)
    susCloseButton.Size = UDim2.new(0, 30, 1, 0)
    susCloseButton.Position = UDim2.new(1, -30, 0, 0)
    susCloseButton.Font = Enum.Font.GothamBold
    susCloseButton.Text = "X"
    susCloseButton.TextColor3 = Color3.fromRGB(50, 100, 255)
    susCloseButton.TextSize = 14
    local closeButtonCorner = Instance.new("UICorner", susCloseButton)
    closeButtonCorner.CornerRadius = UDim.new(0, 15)

    local susMinimizeButton = Instance.new("TextButton")
    susMinimizeButton.Name = "MinimizeButton"
    susMinimizeButton.Parent = susTitleBar
    susMinimizeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 90)
    susMinimizeButton.Size = UDim2.new(0, 30, 1, 0)
    susMinimizeButton.Position = UDim2.new(1, -60, 0, 0)
    susMinimizeButton.Font = Enum.Font.GothamBold
    susMinimizeButton.Text = "-"
    susMinimizeButton.TextColor3 = Color3.fromRGB(50, 100, 255)
    susMinimizeButton.TextSize = 14
    local minimizeButtonCorner = Instance.new("UICorner", susMinimizeButton)
    minimizeButtonCorner.CornerRadius = UDim.new(0, 15)

    local usernameBox = Instance.new("TextBox")
    usernameBox.Name = "UsernameBox"
    usernameBox.Parent = susFrame
    usernameBox.BackgroundColor3 = Color3.fromRGB(0, 0, 70)
    usernameBox.Size = UDim2.new(0, 260, 0, 30)
    usernameBox.Position = UDim2.new(0.5, -130, 0.5, -20)
    usernameBox.Font = Enum.Font.Gotham
    usernameBox.PlaceholderText = "Target's Username"
    usernameBox.Text = ""
    usernameBox.TextColor3 = Color3.fromRGB(50, 100, 255)
    usernameBox.TextSize = 14
    local usernameBoxCorner = Instance.new("UICorner", usernameBox)
    usernameBoxCorner.CornerRadius = UDim.new(0, 15)

    local susToggleButton = Instance.new("TextButton")
    susToggleButton.Name = "ToggleButton"
    susToggleButton.Parent = susFrame
    susToggleButton.BackgroundColor3 = Color3.fromRGB(0, 50, 120)
    susToggleButton.Size = UDim2.new(0, 260, 0, 30)
    susToggleButton.Position = UDim2.new(0.5, -130, 0.5, 20)
    susToggleButton.Font = Enum.Font.GothamBold
    susToggleButton.Text = "Start"
    susToggleButton.TextColor3 = Color3.fromRGB(50, 100, 255)
    susToggleButton.TextSize = 14
    local toggleButtonCorner = Instance.new("UICorner", susToggleButton)
    toggleButtonCorner.CornerRadius = UDim.new(0, 15)

    local susMinimized = false
    local running = false
    local originalGravity
    local attachmentLoop
    local animTrack
    local targetPlayer

    susMinimizeButton.MouseButton1Click:Connect(function()
        susMinimized = not susMinimized
        susFrame.Size = susMinimized and UDim2.new(0, 300, 0, 30) or UDim2.new(0, 300, 0, 150)
    end)

    susCloseButton.MouseButton1Click:Connect(function()
        susGui:Destroy()
    end)

    susToggleButton.MouseButton1Click:Connect(function()
        if not running then
            susToggleButton.Text = "Stop"
            susToggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 100)
            running = true

            local victim = usernameBox.Text:lower()

            for _, player in pairs(Players:GetPlayers()) do
                if string.find(player.Name:lower(), victim) or string.find(player.DisplayName:lower(), victim) then
                    targetPlayer = player
                    break
                end
            end

            if targetPlayer then
                local localPlayer = LocalPlayer
                local humanoidRootPart = localPlayer.Character:FindFirstChild("HumanoidRootPart")
                local targetRootPart = targetPlayer.Character:FindFirstChild("HumanoidRootPart")

                if humanoidRootPart and targetRootPart then
                    originalGravity = workspace.Gravity
                    workspace.Gravity = 0

                    while running and humanoidRootPart and targetRootPart and humanoidRootPart.Position.Y <= 44 do
                        wait()
                        humanoidRootPart.CFrame = humanoidRootPart.CFrame * CFrame.new(0, 1.5, 0)
                    end

                    wait(1)

                    attachmentLoop = RunService.Stepped:Connect(function()
                        humanoidRootPart.CFrame = targetRootPart.CFrame * CFrame.new(0, 2.3, -1.1) * CFrame.Angles(0, math.pi, 0)
                        humanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                    end)

                    wait(1)

                    local animationId = "rbxassetid://148840371"
                    local animation = Instance.new('Animation')
                    animation.AnimationId = animationId

                    local humanoid = localPlayer.Character:FindFirstChild("Humanoid")
                    if humanoid then
                        animTrack = humanoid:LoadAnimation(animation)
                        animTrack:Play()
                        animTrack:AdjustSpeed(3)
                    end
                end
            end
            showNotification("Executing Sus")
        else
            susToggleButton.Text = "Start"
            susToggleButton.BackgroundColor3 = Color3.fromRGB(0, 50, 120)
            running = false
            if originalGravity then
                workspace.Gravity = originalGravity
            end
            if attachmentLoop then
                attachmentLoop:Disconnect()
            end
            if animTrack then
                animTrack:Stop()
            end
        end
    end)
end

local function susyHell()
    local flyGui = Instance.new("ScreenGui")
    flyGui.Name = "BlueTerminalFly"
    flyGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    flyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    flyGui.ResetOnSpawn = false

    local flyFrame = Instance.new("Frame")
    flyFrame.Parent = flyGui
    flyFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 50)
    flyFrame.Size = UDim2.new(0, 300, 0, 180)
    flyFrame.Position = UDim2.new(0.5, -150, 0.5, -90)
    flyFrame.Active = true
    flyFrame.Draggable = true
    flyFrame.ClipsDescendants = true

    local stroke = Instance.new("UIStroke")
    stroke.Parent = flyFrame
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(50, 100, 255)
    stroke.Transparency = 0.2

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = flyFrame

    local flyTitleBar = Instance.new("Frame")
    flyTitleBar.Parent = flyFrame
    flyTitleBar.BackgroundColor3 = Color3.fromRGB(0, 0, 70)
    flyTitleBar.Size = UDim2.new(1, 0, 0, 35)
    flyTitleBar.BorderSizePixel = 0

    local flyTitleLabel = Instance.new("TextLabel")
    flyTitleLabel.Parent = flyTitleBar
    flyTitleLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 70)
    flyTitleLabel.BackgroundTransparency = 0.3
    flyTitleLabel.Size = UDim2.new(1, -40, 0, 25)
    flyTitleLabel.Position = UDim2.new(0, 10, 0, 5)
    flyTitleLabel.Font = Enum.Font.Code
    flyTitleLabel.Text = "BLUE FLY V3 - Bidzz"
    flyTitleLabel.TextColor3 = Color3.fromRGB(50, 100, 255)
    flyTitleLabel.TextSize = 18
    flyTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    flyTitleLabel.TextStrokeTransparency = 0.6
    flyTitleLabel.TextStrokeColor3 = Color3.fromRGB(0, 50, 200)
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 6)
    titleCorner.Parent = flyTitleLabel

    local function styleButton(btn)
        btn.BackgroundColor3 = Color3.fromRGB(0, 0, 70)
        btn.BorderColor3 = Color3.fromRGB(0, 50, 200)
        btn.Font = Enum.Font.Code
        btn.TextColor3 = Color3.fromRGB(50, 100, 255)
        btn.TextSize = 16
        btn.TextStrokeTransparency = 0.6
        btn.TextStrokeColor3 = Color3.fromRGB(0, 50, 200)
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 8)
        btnCorner.Parent = btn
    end

    local up = Instance.new("TextButton")
    up.Name = "up"
    up.Parent = flyFrame
    up.Position = UDim2.new(0.07, 0, 0.28, 0)
    up.Size = UDim2.new(0, 80, 0, 40)
    up.Text = "UP"
    styleButton(up)

    local down = Instance.new("TextButton")
    down.Name = "down"
    down.Parent = flyFrame
    down.Position = UDim2.new(0.07, 0, 0.62, 0)
    down.Size = UDim2.new(0, 80, 0, 40)
    down.Text = "DOWN"
    styleButton(down)

    local onof = Instance.new("TextButton")
    onof.Name = "onof"
    onof.Parent = flyFrame
    onof.Position = UDim2.new(0.73, 0, 0.62, 0)
    onof.Size = UDim2.new(0, 60, 0, 40)
    onof.Text = "FLY"
    styleButton(onof)

    local plus = Instance.new("TextButton")
    plus.Name = "plus"
    plus.Parent = flyFrame
    plus.Position = UDim2.new(0.37, 0, 0.28, 0)
    plus.Size = UDim2.new(0, 40, 0, 40)
    plus.Text = "+"
    plus.TextScaled = true
    styleButton(plus)

    local speed = Instance.new("TextLabel")
    speed.Name = "speed"
    speed.Parent = flyFrame
    speed.BackgroundColor3 = Color3.fromRGB(0, 0, 70)
    speed.BorderColor3 = Color3.fromRGB(0, 50, 200)
    speed.Position = UDim2.new(0.51, 0, 0.62, 0)
    speed.Size = UDim2.new(0, 60, 0, 40)
    speed.Font = Enum.Font.Code
    speed.Text = "1"
    speed.TextColor3 = Color3.fromRGB(50, 100, 255)
    speed.TextScaled = true
    speed.TextStrokeTransparency = 0.6
    speed.TextStrokeColor3 = Color3.fromRGB(0, 50, 200)
    local speedCorner = Instance.new("UICorner")
    speedCorner.CornerRadius = UDim.new(0, 8)
    speedCorner.Parent = speed

    local minus = Instance.new("TextButton")
    minus.Name = "minus"
    minus.Parent = flyFrame
    minus.Position = UDim2.new(0.37, 0, 0.62, 0)
    minus.Size = UDim2.new(0, 40, 0, 40)
    minus.Text = "-"
    minus.TextScaled = true
    styleButton(minus)

    local closebutton = Instance.new("TextButton")
    closebutton.Name = "Close"
    closebutton.Parent = flyTitleBar
    closebutton.BackgroundColor3 = Color3.fromRGB(0, 0, 100)
    closebutton.Size = UDim2.new(0, 28, 0, 28)
    closebutton.Position = UDim2.new(1, -33, 0, 3)
    closebutton.Text = "X"
    styleButton(closebutton)

    local speeds = 1
    local speaker = LocalPlayer
    local chr = speaker.Character
    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
    local nowe = false

    StarterGui:SetCore("SendNotification", { 
        Title = "BLUE FLY V1";
        Text = "BY Bidzz";
        Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150";
        Duration = 5;
    })

    onof.MouseButton1Down:Connect(function()
        if nowe then
            nowe = false
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying, true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics, true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, true)
            speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
        else 
            nowe = true
            for i = 1, speeds do
                spawn(function()
                    local hb = RunService.Heartbeat    
                    tpwalking = true
                    local chr = speaker.Character
                    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                    while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                        if hum.MoveDirection.Magnitude > 0 then
                            chr:TranslateBy(hum.MoveDirection)
                        end
                    end
                end)
            end
            speaker.Character.Animate.Disabled = true
            local Char = speaker.Character
            local Hum = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController")
            for i,v in next, Hum:GetPlayingAnimationTracks() do
                v:AdjustSpeed(0)
            end
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying, false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed, false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics, false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
            speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
        end

        if isR6 then
            local plr = LocalPlayer
            local torso = plr.Character.Torso
            local flying = true
            local deb = true
            local ctrl = {f = 0, b = 0, l = 0, r = 0}
            local lastctrl = {f = 0, b = 0, l = 0, r = 0}
            local maxspeed = 50
            local speed = 0
            local bg = Instance.new("BodyGyro", torso)
            bg.P = 9e4
            bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            bg.cframe = torso.CFrame
            local bv = Instance.new("BodyVelocity", torso)
            bv.velocity = Vector3.new(0,0.1,0)
            bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
            if nowe then plr.Character.Humanoid.PlatformStand = true end
            while nowe and plr.Character.Humanoid.Health > 0 do
                RunService.RenderStepped:Wait()
                if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                    speed = speed + 0.5 + (speed/maxspeed)
                    if speed > maxspeed then speed = maxspeed end
                elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
                    speed = speed - 1
                    if speed < 0 then speed = 0 end
                end
                if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                    bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + 
                                  ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - 
                                   game.Workspace.CurrentCamera.CoordinateFrame.p)) * speed
                    lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
                else
                    bv.velocity = Vector3.new(0,0,0)
                end
                bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
            end
            ctrl = {f = 0, b = 0, l = 0, r = 0}
            lastctrl = {f = 0, b = 0, l = 0, r = 0}
            speed = 0
            bg:Destroy()
            bv:Destroy()
            plr.Character.Humanoid.PlatformStand = false
            game.Players.LocalPlayer.Character.Animate.Disabled = false
            tpwalking = false
        else
            local plr = LocalPlayer
            local UpperTorso = plr.Character.UpperTorso
            local flying = true
            local deb = true
            local ctrl = {f = 0, b = 0, l = 0, r = 0}
            local lastctrl = {f = 0, b = 0, l = 0, r = 0}
            local maxspeed = 50
            local speed = 0
            local bg = Instance.new("BodyGyro", UpperTorso)
            bg.P = 9e4
            bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            bg.cframe = UpperTorso.CFrame
            local bv = Instance.new("BodyVelocity", UpperTorso)
            bv.velocity = Vector3.new(0,0.1,0)
            bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
            if nowe then plr.Character.Humanoid.PlatformStand = true end
            while nowe and plr.Character.Humanoid.Health > 0 do
                wait()
                if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                    speed = speed + 0.5 + (speed/maxspeed)
                    if speed > maxspeed then speed = maxspeed end
                elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
                    speed = speed - 1
                    if speed < 0 then speed = 0 end
                end
                if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                    bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + 
                                  ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - 
                                   game.Workspace.CurrentCamera.CoordinateFrame.p)) * speed
                    lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
                elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
                    bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + 
                                  ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - 
                                   game.Workspace.CurrentCamera.CoordinateFrame.p)) * speed
                else
                    bv.velocity = Vector3.new(0,0,0)
                end
                bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
            end
            ctrl = {f = 0, b = 0, l = 0, r = 0}
            lastctrl = {f = 0, b = 0, l = 0, r = 0}
            speed = 0
            bg:Destroy()
            bv:Destroy()
            plr.Character.Humanoid.PlatformStand = false
            game.Players.LocalPlayer.Character.Animate.Disabled = false
            tpwalking = false
        end
        showNotification("Executing SusyHell")
    end)

    local tis
    up.MouseButton1Down:Connect(function()
        tis = up.MouseEnter:Connect(function()
            while tis do
                wait()
                LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,1,0)
            end
        end)
    end)
    up.MouseLeave:Connect(function()
        if tis then tis:Disconnect() tis = nil end
    end)

    local dis
    down.MouseButton1Down:Connect(function()
        dis = down.MouseEnter:Connect(function()
            while dis do
                wait()
                LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1,0)
            end
        end)
    end)
    down.MouseLeave:Connect(function()
        if dis then dis:Disconnect() dis = nil end
    end)

    LocalPlayer.CharacterAdded:Connect(function(char)
        wait(0.7)
        LocalPlayer.Character.Humanoid.PlatformStand = false
        LocalPlayer.Character.Animate.Disabled = false
    end)

    plus.MouseButton1Down:Connect(function()
        speeds = speeds + 1
        speed.Text = speeds
        if nowe then
            tpwalking = false
            for i = 1, speeds do
                spawn(function()
                    local hb = RunService.Heartbeat    
                    tpwalking = true
                    local chr = LocalPlayer.Character
                    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                    while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                        if hum.MoveDirection.Magnitude > 0 then
                            chr:TranslateBy(hum.MoveDirection)
                        end
                    end
                end)
            end
        end
    end)

    minus.MouseButton1Down:Connect(function()
        if speeds == 1 then
            speed.Text = "MIN"
            wait(1)
            speed.Text = speeds
        else
            speeds = speeds - 1
            speed.Text = speeds
            if nowe then
                tpwalking = false
                for i = 1, speeds do
                    spawn(function()
                        local hb = RunService.Heartbeat    
                        tpwalking = true
                        local chr = LocalPlayer.Character
                        local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                        while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                            if hum.MoveDirection.Magnitude > 0 then
                                chr:TranslateBy(hum.MoveDirection)
                            end
                        end
                    end)
                end
            end
        end
    end)

    closebutton.MouseButton1Click:Connect(function()
        flyGui:Destroy()
    end)
end

-- Buttons Data
local buttons = {
    {name = "🐿 Bang", func = bang},
    {name = "😍 Sus", func = sus},
    {name = "♥ SusyHell", func = susyHell}
}

for i, buttonData in ipairs(buttons) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.9, 0, 0, 50)
    button.BackgroundColor3 = Color3.fromRGB(0, 0, 70)
    button.Text = buttonData.name
    button.Font = Enum.Font.Code
    button.TextSize = 20
    button.TextColor3 = Color3.fromRGB(50, 100, 255)
    button.TextStrokeTransparency = 0.7
    button.TextStrokeColor3 = Color3.fromRGB(0, 50, 200)
    button.Parent = scrollingFrame

    local uicorner = Instance.new("UICorner")
    uicorner.CornerRadius = UDim.new(0, 8)
    uicorner.Parent = button

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(0, 50, 200)
    stroke.Thickness = 1
    stroke.Parent = button

    button.MouseEnter:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.2),
            {BackgroundColor3 = Color3.fromRGB(0, 0, 90)}
        ):Play()
    end)

    button.MouseLeave:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.2),
            {BackgroundColor3 = Color3.fromRGB(0, 0, 70)}
        ):Play()
    end)

    button.MouseButton1Click:Connect(function()
        buttonData.func()
    end)
end