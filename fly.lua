local main = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local titleBar = Instance.new("Frame")
local titleLabel = Instance.new("TextLabel")
local up = Instance.new("TextButton")
local down = Instance.new("TextButton")
local onof = Instance.new("TextButton")
local plus = Instance.new("TextButton")
local speed = Instance.new("TextLabel")
local minus = Instance.new("TextButton")
local closebutton = Instance.new("TextButton")

-- ScreenGui Setup
main.Name = "BidzzFly"
main.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
main.ResetOnSpawn = false

-- Main Frame
Frame.Parent = main
Frame.BackgroundColor3 = Color3.fromRGB(0, 25, 50) -- Changed to dark blue
Frame.Size = UDim2.new(0, 300, 0, 180)
Frame.Position = UDim2.new(0.5, -150, 0.5, -90)
Frame.Active = true
Frame.Draggable = true
Frame.ClipsDescendants = true

-- UI Effects
local stroke = Instance.new("UIStroke")
stroke.Parent = Frame
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(0, 150, 255) -- Changed to bright blue
stroke.Transparency = 0.2

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = Frame

-- Title Bar
titleBar.Parent = Frame
titleBar.BackgroundColor3 = Color3.fromRGB(0, 35, 70) -- Changed to darker blue
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BorderSizePixel = 0

-- Title Label
titleLabel.Parent = titleBar
titleLabel.BackgroundColor3 = Color3.fromRGB(0, 45, 90) -- Changed to medium blue
titleLabel.BackgroundTransparency = 0.3
titleLabel.Size = UDim2.new(1, -40, 0, 25)
titleLabel.Position = UDim2.new(0, 10, 0, 5)
titleLabel.Font = Enum.Font.Code
titleLabel.Text = "BIDZZ FLY🕊️"
titleLabel.TextColor3 = Color3.fromRGB(80, 180, 255) -- Changed to light blue
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.TextStrokeTransparency = 0.6
titleLabel.TextStrokeColor3 = Color3.fromRGB(0, 120, 200) -- Changed to medium blue
local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 6)
titleCorner.Parent = titleLabel

-- Unified Button Styling Function
local function styleButton(btn)
    btn.BackgroundColor3 = Color3.fromRGB(0, 45, 90) -- Changed to medium blue
    btn.BorderColor3 = Color3.fromRGB(0, 120, 200) -- Changed to medium blue
    btn.Font = Enum.Font.Code
    btn.TextColor3 = Color3.fromRGB(80, 180, 255) -- Changed to light blue
    btn.TextSize = 16
    btn.TextStrokeTransparency = 0.6
    btn.TextStrokeColor3 = Color3.fromRGB(0, 120, 200) -- Changed to medium blue
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
end

-- Up Button
up.Name = "up"
up.Parent = Frame
up.Position = UDim2.new(0.07, 0, 0.28, 0)
up.Size = UDim2.new(0, 80, 0, 40)
up.Text = "UP"
styleButton(up)

-- Down Button
down.Name = "down"
down.Parent = Frame
down.Position = UDim2.new(0.07, 0, 0.62, 0)
down.Size = UDim2.new(0, 80, 0, 40)
down.Text = "DOWN"
styleButton(down)

-- Fly Toggle Button
onof.Name = "onof"
onof.Parent = Frame
onof.Position = UDim2.new(0.73, 0, 0.62, 0)
onof.Size = UDim2.new(0, 60, 0, 40)
onof.Text = "FLY"
styleButton(onof)

-- Speed Controls
plus.Name = "plus"
plus.Parent = Frame
plus.Position = UDim2.new(0.37, 0, 0.28, 0)
plus.Size = UDim2.new(0, 40, 0, 40)
plus.Text = "+"
plus.TextScaled = true
styleButton(plus)

speed.Name = "speed"
speed.Parent = Frame
speed.BackgroundColor3 = Color3.fromRGB(0, 35, 70) -- Changed to darker blue
speed.BorderColor3 = Color3.fromRGB(0, 120, 200) -- Changed to medium blue
speed.Position = UDim2.new(0.51, 0, 0.62, 0)
speed.Size = UDim2.new(0, 60, 0, 40)
speed.Font = Enum.Font.Code
speed.Text = "1"
speed.TextColor3 = Color3.fromRGB(80, 180, 255) -- Changed to light blue
speed.TextScaled = true
speed.TextStrokeTransparency = 0.6
speed.TextStrokeColor3 = Color3.fromRGB(0, 120, 200) -- Changed to medium blue
local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(0, 8)
speedCorner.Parent = speed

minus.Name = "minus"
minus.Parent = Frame
minus.Position = UDim2.new(0.37, 0, 0.62, 0)
minus.Size = UDim2.new(0, 40, 0, 40)
minus.Text = "-"
minus.TextScaled = true
styleButton(minus)

-- Window Controls
closebutton.Name = "Close"
closebutton.Parent = titleBar
closebutton.BackgroundColor3 = Color3.fromRGB(0, 70, 140) -- Changed to medium-dark blue
closebutton.Size = UDim2.new(0, 28, 0, 28)
closebutton.Position = UDim2.new(1, -33, 0, 3)
closebutton.Text = "X"
styleButton(closebutton)

-- Variables
speeds = 1
local speaker = game:GetService("Players").LocalPlayer
local chr = speaker.Character
local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
local nowe = false

-- Notification
game:GetService("StarterGui"):SetCore("SendNotification", { 
    Title = "BLUE FLY V1";
    Text = "BY BIDZZ";
    Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150";
    Duration = 5;
})

-- Fly Logic
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
                local hb = game:GetService("RunService").Heartbeat    
                tpwalking = true
                local chr = game.Players.LocalPlayer.Character
                local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                    if hum.MoveDirection.Magnitude > 0 then
                        chr:TranslateBy(hum.MoveDirection)
                    end
                end
            end)
        end
        game.Players.LocalPlayer.Character.Animate.Disabled = true
        local Char = game.Players.LocalPlayer.Character
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

    if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
        local plr = game.Players.LocalPlayer
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
        while nowe or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
            game:GetService("RunService").RenderStepped:Wait()
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
    else
        local plr = game.Players.LocalPlayer
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
        while nowe or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
            wait()
            if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                speed = speed + 0.5 + (speed/maxspeed)
                if speed > maxspeed then speed = maxspeed end
            elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
                speed = speed - 1
                if speed < 0 then speed = 0 end
            end
            if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVectorhellip; * (ctrl.f+ctrl.b)) + 
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
end)

-- Up/Down Controls
local tis
up.MouseButton1Down:Connect(function()
    tis = up.MouseEnter:Connect(function()
        while tis do
            wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,1,0)
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
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-1,0)
        end
    end)
end)
down.MouseLeave:Connect(function()
    if dis then dis:Disconnect() dis = nil end
end)

-- Character Reset
game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(char)
    wait(0.7)
    game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
    game.Players.LocalPlayer.Character.Animate.Disabled = false
end)

-- Speed Controls
plus.MouseButton1Down:Connect(function()
    speeds = speeds + 1
    speed.Text = speeds
    if nowe then
        tpwalking = false
        for i = 1, speeds do
            spawn(function()
                local hb = game:GetService("RunService").Heartbeat    
                tpwalking = true
                local chr = game.Players.LocalPlayer.Character
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
                    local hb = game:GetService("RunService").Heartbeat    
                    tpwalking = true
                    local chr = game.Players.LocalPlayer.Character
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

-- Window Controls
closebutton.MouseButton1Click:Connect(function()
    main:Destroy()
end)