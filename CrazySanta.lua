-- ═══════════════════════════════════════════════
--   CRAZYSANTA 2026 - НОВОГОДНИЙ ЧИТ МЕНЮ (26 функций)
--   Чистый LocalScript для Roblox Studio
--   Стиль dramGUI v3.0 + снежинки + градиент
-- ═══════════════════════════════════════════════

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local TS = game:GetService("TweenService")
local plr = Players.LocalPlayer
local mouse = plr:GetMouse()

local function waitForCharacter()
    if not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") then
        plr.CharacterAdded:Wait()
    end
    return plr.Character or plr.CharacterAdded:Wait()
end

local char = waitForCharacter()
local hum = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")

-- === GUI ===
local sg = Instance.new("ScreenGui")
sg.Name = "CrazySanta2026"
sg.ResetOnSpawn = false
sg.Parent = plr:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 380, 0, 620)
frame.Position = UDim2.new(0.5, -190, 0.5, -310)
frame.BackgroundColor3 = Color3.fromRGB(15, 0, 35)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Visible = false
frame.Parent = sg

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 20)

local gradient = Instance.new("UIGradient", frame)
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 50, 100)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 100, 200))
}
gradient.Rotation = 45

local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 4
stroke.Color = Color3.new(1,1,1)
stroke.Transparency = 0.3

-- Title Bar
local titleBar = Instance.new("Frame", frame)
titleBar.Size = UDim2.new(1,0,0,60)
titleBar.BackgroundColor3 = Color3.fromRGB(10,0,25)
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0,20)

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(1,-100,1,0)
title.Position = UDim2.new(0,15,0,0)
title.BackgroundTransparency = 1
title.Text = "CrazySanta 2026"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBlack
title.TextSize = 36
title.TextXAlignment = Enum.TextXAlignment.Left

-- Кнопки минимизации и закрытия
local minBtn = Instance.new("TextButton", titleBar)
minBtn.Size = UDim2.new(0,45,0,45)
minBtn.Position = UDim2.new(1,-90,0,7)
minBtn.BackgroundColor3 = Color3.fromRGB(255,180,0)
minBtn.Text = "−"
minBtn.TextSize = 40
minBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0,12)

local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0,45,0,45)
closeBtn.Position = UDim2.new(1,-45,0,7)
closeBtn.BackgroundColor3 = Color3.fromRGB(255,50,50)
closeBtn.Text = "X"
closeBtn.TextSize = 34
closeBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0,12)

-- Снежинки
local function snow()
    for i = 1, 80 do
        local p = Instance.new("ParticleEmitter", frame)
        p.Texture = "rbxassetid://241353019"
        p.Rate = 0
        p.Lifetime = NumberRange.new(8)
        p.Speed = NumberRange.new(15,40)
        p.RotSpeed = NumberRange.new(-200,200)
        p:Emit(1)
        game.Debris:AddItem(p, 9)
    end
end

-- Минимизация
local minimized = false
minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    frame:TweenSize(minimized and UDim2.new(0,380,0,60) or UDim2.new(0,380,0,620), "Out", "Quad", 0.4, true)
    minBtn.Text = minimized and "+" or "−"
end)

closeBtn.MouseButton1Click:Connect(function()
    sg:Destroy()
end)

-- Скролл
local scroll = Instance.new("ScrollingFrame", frame)
scroll.Size = UDim2.new(0.94,0,0,540)
scroll.Position = UDim2.new(0.03,0,0,70)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 10
scroll.CanvasSize = UDim2.new(0,0,0,80*26)
scroll.Parent = frame

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0,10)
layout.SortOrder = Enum.SortOrder.LayoutOrder

-- Создание кнопки
local function createButton(name, callback)
    local b = Instance.new("TextButton", scroll)
    b.Size = UDim2.new(1,-10,0,70)
    b.BackgroundColor3 = Color3.fromRGB(255,255,255)
    b.BackgroundTransparency = 0.85
    b.Text = name
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 28
    b.TextScaled = true
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,16)
    
    b.MouseButton1Click:Connect(callback)
    b.MouseEnter:Connect(function() TS:Create(b, TweenInfo.new(0.2), {BackgroundTransparency = 0.6}):Play() end)
    b.MouseLeave:Connect(function() TS:Create(b, TweenInfo.new(0.2), {BackgroundTransparency = 0.85}):Play() end)
end

-- Состояния
local fly = false
local noclip = false
local infjump = false

-- 26 функций
createButton("Godmode", function() hum.Health = math.huge end)
createButton("Speed 250", function() hum.WalkSpeed = 250 end)
createButton("Jump 500", function() hum.JumpPower = 500 end)
createButton("Бесконечный прыжок", function()
    infjump = not infjump
    if infjump then
        UIS.JumpRequest:Connect(function() hum:ChangeState("Jumping") end)
    end
end)
createButton("Полёт (E/Q)", function()
    fly = not fly
    local bv = Instance.new("BodyVelocity", root)
    bv.MaxForce = fly and Vector3.new(1e5,1e5,1e5) or Vector3.new(0,0,0)
    if fly then
        spawn(function()
            while fly do
                local dir = Vector3.new()
                if UIS:IsKeyDown(Enum.KeyCode.E) then dir = dir + Vector3.new(0,1,0) end
                if UIS:IsKeyDown(Enum.KeyCode.Q) then dir = dir - Vector3.new(0,1,0) end
                if UIS:IsKeyDown(Enum.KeyCode.W) then dir = dir + workspace.CurrentCamera.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.S) then dir = dir - workspace.CurrentCamera.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.A) then dir = dir - workspace.CurrentCamera.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.D) then dir = dir + workspace.CurrentCamera.CFrame.RightVector end
                bv.Velocity = dir.Unit * 200
                RS.Heartbeat:Wait()
            end
            bv:Destroy()
        end)
    end
end)
createButton("Noclip", function()
    noclip = not noclip
end)
createButton("Телепорт к курсору", function() root.CFrame = CFrame.new(mouse.Hit.p + Vector3.new(0,5,0)) end)
createButton("ESP", function()
    for _, p in Players:GetPlayers() do
        if p ~= plr and p.Character then
            local hl = Instance.new("Highlight", p.Character)
            hl.FillColor = Color3.fromRGB(255,0,0)
            hl.OutlineColor = Color3.fromRGB(255,255,0)
        end
    end
end)
createButton("Fullbright", function() game.Lighting.Brightness = 10 end)
createButton("FOV 120", function() workspace.CurrentCamera.FieldOfView = 120 end)
createButton("Невидимка", function() for _,v in char:GetDescendants() do if v:IsA("BasePart") then v.Transparency = 0.7 end end end)
createButton("Неон", function() for _,v in char:GetDescendants() do if v:IsA("BasePart") then v.Material = Enum.Material.Neon v.Color = Color3.fromRGB(0,255,255) end end end)
createButton("Большая голова", function() char.Head.Size = Vector3.new(12,12,12) end)
createButton("Спинбот", function() while task.wait() do root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(30), 0) end end)
createButton("Радужный", function() while task.wait(0.1) do for _,v in char:GetDescendants() do if v:IsA("BasePart") then v.Color = Color3.fromHSV(tick()%5/5,1,1) end end end end)
createButton("Без гравитации", function() workspace.Gravity = 0 end)
createButton("Заморозить всех", function() for _,p in Players:GetPlayers() do if p.Character then p.Character.HumanoidRootPart.Anchored = true end end end)
createButton("Взорвать всех", function() for _,p in Players:GetPlayers() do if p.Character then local ex = Instance.new("Explosion", workspace) ex.Position = p.Character.HumanoidRootPart.Position end end end)
createButton("Speed 600", function() hum.WalkSpeed = 600 end)
createButton("Jump 1500", function() hum.JumpPower = 1500 end)
createButton("Fly + Noclip", function() fly = true noclip = true end)
createButton("Удалить двери", function() for _,v in workspace:GetDescendants() do if string.find(v.Name:lower(),"door") then v:Destroy() end end end)
createButton("Авто-кликер", function() while task.wait() do for _,v in workspace:GetDescendants() do if v:IsA("ClickDetector") then fireclickdetector(v) end end end end)
createButton("Снег 2026!", function() snow() end)
createButton("С Новым 2026!", function() snow() end)

-- Noclip обновление
RS.Stepped:Connect(function()
    if noclip then
        for _, v in char:GetDescendants() do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)

-- Открытие меню
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        frame.Visible = not frame.Visible
        if frame.Visible then snow() end
    end
end)

-- Двойной тап для телефонов
local taps = 0
UIS.TouchTap:Connect(function()
    taps = taps + 1
    task.wait(0.3)
    if taps >= 2 then
        frame.Visible = not frame.Visible
        if frame.Visible then snow() end
        taps = 0
    end
end)

print("CrazySanta 2026 успешно загружен! Insert или двойной тап - открыть меню")
