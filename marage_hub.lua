-- โหลด Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
 
-- Main Window
local Window = Rayfield:CreateWindow({
Name = "AetherVox hub (beta)",
LoadingTitle = "Loading...",
LoadingSubtitle = "by AetherVox",
ConfigurationSaving = {
Enabled = true,
FolderName = "AetherVox	",
FileName = "Config"
}
})
 
-- Tabs
local SettingsTab = Window:CreateTab("ตั้งค่า")
local MainTab     = Window:CreateTab("เมนูหลัก")
local TeleportTab = Window:CreateTab("เทเลพอร์ต")
local VisualsTab  = Window:CreateTab("มองต่างๆ")
local ExtraTab    = Window:CreateTab("ของเสริม")
local FPSTab      = Window:CreateTab("FPS")
local EventTab    = Window:CreateTab("เกี่ยวกับอีเว้น")
local MapTab      = Window:CreateTab("เเมพ")
 
-- Auto Bhop
local autoBhop = false
local floatingBhopButton
local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer
 
-- สร้าง FloatingGui
local FloatingGui = game:GetService("CoreGui"):FindFirstChild("FloatingGui")
if not FloatingGui then
FloatingGui = Instance.new("ScreenGui")
FloatingGui.Name = "FloatingGui"
FloatingGui.Parent = game:GetService("CoreGui")
end
 
-- ปุ่มลอย
local function createBhopFloatingButton()
if floatingBhopButton then return end
 
local btn = Instance.new("TextButton")  
btn.Size = UDim2.new(0,140,0,52)  
btn.Position = UDim2.new(0.3,-70,0.8,0)  
btn.AnchorPoint = Vector2.new(0.5,0)  
btn.BackgroundColor3 = Color3.fromRGB(15,20,35)  
btn.BackgroundTransparency = 0.35  
btn.TextColor3 = Color3.fromRGB(0,70,150)  
btn.Text = "Auto Bhop: OFF"  
btn.Font = Enum.Font.GothamBold  
btn.TextSize = 14  
btn.Parent = FloatingGui  
btn.Active = true  
btn.Draggable = true  
 
local corner = Instance.new("UICorner", btn)  
corner.CornerRadius = UDim.new(0,18)  
 
local stroke = Instance.new("UIStroke", btn)  
stroke.Thickness = 2.5  
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border  
stroke.Color = Color3.fromRGB(0,120,255)  
 
task.spawn(function()  
    while btn.Parent do  
        TweenService:Create(stroke, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Color = Color3.fromRGB(0,80,255)}):Play()  
        task.wait(0.8)  
        TweenService:Create(stroke, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Color = Color3.fromRGB(160,230,255)}):Play()  
        task.wait(0.8)  
    end  
end)  
 
btn.MouseButton1Click:Connect(function()  
    autoBhop = not autoBhop  
    btn.Text = autoBhop and "Auto Bhop: ON" or "Auto Bhop: OFF"  
end)  
 
floatingBhopButton = btn
 
end
 
local function removeBhopFloatingButton()
if floatingBhopButton then
floatingBhopButton:Destroy()
floatingBhopButton = nil
end
end
 
-- Toggle ปกติ
MainTab:CreateToggle({
Name = "Auto Jump",
CurrentValue = false,
Callback = function(state)
autoBhop = state
end
})
 
-- Toggle ปุ่มลอย
MainTab:CreateToggle({
Name = "Auto Jump (Floating Button)",
CurrentValue = false,
Callback = function(state)
if state then
createBhopFloatingButton()
else
removeBhopFloatingButton()
autoBhop = false
end
end
})
 
-- ระบบ Auto Bhop
task.spawn(function()
local RunService = game:GetService("RunService")
local rayDistance = 4
local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Blacklist
 
while true do  
    RunService.Heartbeat:Wait()  
    if autoBhop then  
        local char = player.Character or player.CharacterAdded:Wait()  
        local humanoid = char:FindFirstChildOfClass("Humanoid")  
        local root = char:FindFirstChild("HumanoidRootPart")  
        if humanoid and root then  
            rayParams.FilterDescendantsInstances = {char}  
            local result = workspace:Raycast(root.Position, Vector3.new(0,-rayDistance,0), rayParams)  
            if result then  
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)  
            end  
        end  
    end  
end
 
end)
 
-- =========================
-- Lag Switch
-- =========================
local floatingLagButton
 
local function lagSwitch(duration)
local start = tick()
while tick() - start < duration do
for i = 1, 1e7 do
local a = math.random()
end
end
end
 
-- ปุ่มใน Tab
MainTab:CreateButton({
Name = "Lag Switch (ปกติ)",
Callback = function()
lagSwitch(0.5)
end
})
 
-- =========================
-- ปุ่มลอยสไตล์มึง
-- =========================
local function createLagFloatingButton()
if floatingLagButton then return end
 
local btn = Instance.new("TextButton")  
btn.Size = UDim2.new(0,140,0,52)  
btn.Position = UDim2.new(0.7,-70,0.8,0)  
btn.AnchorPoint = Vector2.new(0.5,0)  
btn.BackgroundColor3 = Color3.fromRGB(15,20,35)  
btn.BackgroundTransparency = 0.35  
btn.TextColor3 = Color3.fromRGB(0,70,150)  
btn.Text = "Lag Switch"  
btn.Font = Enum.Font.GothamBold  
btn.TextSize = 14  
btn.Parent = FloatingGui  
btn.Active = true  
btn.Draggable = true  
 
-- มุมโค้ง  
local corner = Instance.new("UICorner", btn)  
corner.CornerRadius = UDim.new(0,18)  
 
-- ขอบ  
local stroke = Instance.new("UIStroke", btn)  
stroke.Thickness = 2.5  
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border  
stroke.Color = Color3.fromRGB(0,120,255)  
 
-- ไล่สี  
task.spawn(function()  
    while btn.Parent do  
        TweenService:Create(  
            stroke,  
            TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),  
            {Color = Color3.fromRGB(0,80,255)}  
        ):Play()  
        task.wait(0.8)  
 
        TweenService:Create(  
            stroke,  
            TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),  
            {Color = Color3.fromRGB(160,230,255)}  
        ):Play()  
        task.wait(0.8)  
    end  
end)  
 
-- กดปุ่ม  
btn.MouseButton1Click:Connect(function()  
    lagSwitch(0.5)  
end)  
 
floatingLagButton = btn
 
end
 
local function removeLagFloatingButton()
if floatingLagButton then
floatingLagButton:Destroy()
floatingLagButton = nil
end
end
 
-- Toggle ปุ่มลอย
MainTab:CreateToggle({
Name = "Lag Switch (Floating Button)",
CurrentValue = false,
Callback = function(state)
if state then
createLagFloatingButton()
else
removeLagFloatingButton()
end
end
})
 
-- =========================  
-- Auto Bounce (แม่นยำสูง + ปรับความสูงได้ + ปุ่มลอยสไตล์ Auto Jump)  
-- =========================  
local autoBounce = false  
local floatingBounceButton  
local bouncePower = 150 -- ค่าเริ่มต้น  
local groundCheckDistance = 6 -- ระยะเช็คใกล้พื้น (studs)  
local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer
 
-- ระบบเด้ง
task.spawn(function()  
    local RunService = game:GetService("RunService")  
    while true do  
        RunService.Heartbeat:Wait()
        if autoBounce then  
            local char = player.Character  
            if char then  
                local root = char:FindFirstChild("HumanoidRootPart")  
                local humanoid = char:FindFirstChildOfClass("Humanoid")  
                if root and humanoid then  
                    local rayOrigin = root.Position  
                    local rayDirection = Vector3.new(0, -groundCheckDistance, 0)  
                    local raycastParams = RaycastParams.new()  
                    raycastParams.FilterDescendantsInstances = {char}  
                    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist  
 
                    local ray = workspace:Raycast(rayOrigin, rayDirection, raycastParams)  
 
                    if ray and root.Velocity.Y < -5 then  
                        root.Velocity = Vector3.new(root.Velocity.X, bouncePower, root.Velocity.Z)  
                    end  
                end  
            end  
        end  
    end  
end)  
 
-- Toggle ปกติ
MainTab:CreateToggle({  
    Name="ออโต้เด้ง (ปกติ)",  
    CurrentValue=false,  
    Callback=function(state) autoBounce = state end  
})  
 
-- Slider ปรับความสูง
MainTab:CreateSlider({  
    Name = "ปรับความสูงการเด้ง",  
    Range = {50, 300},  
    Increment = 5,  
    Suffix = "studs",  
    CurrentValue = bouncePower,  
    Callback = function(value)  
        bouncePower = value  
    end  
})  
 
-- =========================
-- ปุ่มลอยสไตล์ Auto Jump
-- =========================
local function createBounceFloatingButton()
    if floatingBounceButton then return end
 
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,140,0,52)
    btn.Position = UDim2.new(0.5,-70,0.85,0)
    btn.AnchorPoint = Vector2.new(0.5,0)
    btn.BackgroundColor3 = Color3.fromRGB(180,220,255)
    btn.BackgroundTransparency = 0.35
    btn.TextColor3 = Color3.fromRGB(0,70,150)
    btn.Text = autoBounce and "Auto Bounce: ON" or "Auto Bounce: OFF"
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = FloatingGui
    btn.Active = true
    btn.Draggable = true
 
    -- มุมโค้ง
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0,18)
 
    -- ขอบ
    local stroke = Instance.new("UIStroke", btn)
    stroke.Thickness = 2.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Color = Color3.fromRGB(0,120,255)
 
    -- ไล่สีเหมือน Auto Jump
    task.spawn(function()
        while btn.Parent do
            TweenService:Create(
                stroke,
                TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                {Color = Color3.fromRGB(0,80,255)}
            ):Play()
            task.wait(0.8)
            TweenService:Create(
                stroke,
                TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                {Color = Color3.fromRGB(160,230,255)}
            ):Play()
            task.wait(0.8)
        end
    end)
 
    -- กดปุ่ม
    btn.MouseButton1Click:Connect(function()
        autoBounce = not autoBounce
        btn.Text = autoBounce and "Auto Bounce: ON" or "Auto Bounce: OFF"
    end)
 
    floatingBounceButton = btn
end
 
local function removeBounceFloatingButton()
    if floatingBounceButton then
        floatingBounceButton:Destroy()
        floatingBounceButton = nil
    end
end
 
-- Toggle ปุ่มลอย
MainTab:CreateToggle({
    Name = "ออโต้เด้ง (ปุ่มลอย)",
    CurrentValue = false,
    Callback = function(state)
        if state then
            createBounceFloatingButton()
        else
            removeBounceFloatingButton()
            autoBounce = false
        end
    end
})
 
-- =========================
-- Auto Respawn (Fake Revive) + ปุ่มลอยสไตล์ Hub
-- =========================
getgenv().AutoRespawnEnabled = false
local autoRespawnMethod = "Fake Revive"
local lastSavedPosition
local floatingRespawnButton
local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
 
-- ฟังก์ชันสร้างปุ่มลอย
local function createRespawnFloatingButton()
    if floatingRespawnButton then return end
 
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,140,0,52)
    btn.Position = UDim2.new(0.7,-70,0.85,0)
    btn.AnchorPoint = Vector2.new(0.5,0)
    btn.BackgroundColor3 = Color3.fromRGB(255,80,80)
    btn.BackgroundTransparency = 0.35
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Text = getgenv().AutoRespawnEnabled and "Auto Respawn: ON" or "Auto Respawn: OFF"
    btn.Parent = FloatingGui
    btn.Active = true
    btn.Draggable = true
    btn.ZIndex = 10
 
    -- มุมโค้ง
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0,18)
 
    -- ขอบ
    local stroke = Instance.new("UIStroke", btn)
    stroke.Thickness = 2.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Color = Color3.fromRGB(255,120,120)
 
    -- ไล่สีสไตล์เดียวกับ Auto Jump/Bounce
    task.spawn(function()
        while btn.Parent do
            TweenService:Create(stroke, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Color = Color3.fromRGB(255,60,60)}):Play()
            task.wait(0.8)
            TweenService:Create(stroke, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Color = Color3.fromRGB(255,150,150)}):Play()
            task.wait(0.8)
        end
    end)
 
    btn.MouseButton1Click:Connect(function()
        getgenv().AutoRespawnEnabled = not getgenv().AutoRespawnEnabled
        btn.Text = getgenv().AutoRespawnEnabled and "Auto Respawn: ON" or "Auto Respawn: OFF"
        btn.BackgroundColor3 = getgenv().AutoRespawnEnabled and Color3.fromRGB(80,255,80) or Color3.fromRGB(255,80,80)
    end)
 
    floatingRespawnButton = btn
end
 
local function removeRespawnFloatingButton()
    if floatingRespawnButton then
        floatingRespawnButton:Destroy()
        floatingRespawnButton = nil
    end
end
 
-- ฟังก์ชันตั้งค่า Auto Revive สำหรับตัวละคร
local function setupAutoRevive(character)
    task.defer(function()
        character:WaitForChild("HumanoidRootPart",5)
        character:WaitForChild("Humanoid",5)
 
        -- เก็บตำแหน่งล่าสุด
        task.spawn(function()
            while character and character.Parent do
                local hrp = character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    character:SetAttribute("LastPosition", hrp.Position)
                end
                task.wait(0.2)
            end
        end)
 
        -- ตรวจ Downed
        character:GetAttributeChangedSignal("Downed"):Connect(function()
            if not getgenv().AutoRespawnEnabled then return end
            if character:GetAttribute("Downed") ~= true then return end
            if autoRespawnMethod ~= "Fake Revive" then return end
 
            local hrp = character:FindFirstChild("HumanoidRootPart")
            if hrp then lastSavedPosition = hrp.Position end
 
            task.wait(3)
            local start = tick()
            repeat
                pcall(function()
                    game:GetService("ReplicatedStorage"):WaitForChild("Events",9e9)
                        :WaitForChild("Player",9e9)
                        :WaitForChild("ChangePlayerMode",9e9)
                        :FireServer(true)
                end)
                task.wait(1)
            until character:GetAttribute("Downed") ~= true or tick() - start > 1
 
            local newChar
            repeat
                newChar = player.Character
                task.wait()
            until newChar and newChar:FindFirstChild("HumanoidRootPart")
 
            local newHRP = newChar:FindFirstChild("HumanoidRootPart")
            if lastSavedPosition and newHRP then
                newHRP.CFrame = CFrame.new(lastSavedPosition)
                task.wait(0.5)
            end
        end)
    end)
end
 
-- เรียก setup สำหรับตัวละครปัจจุบันและใหม่
if player.Character then setupAutoRevive(player.Character) end
player.CharacterAdded:Connect(setupAutoRevive)
 
-- =========================
-- ปุ่มปกติ (แก้แล้ว)
-- =========================
MainTab:CreateToggle({
    Name = "ออโต้รีสปอน (ปกติ)",
    CurrentValue = false,
    Callback = function(state)
        getgenv().AutoRespawnEnabled = state
    end
})
 
-- =========================
-- Dropdown (Rayfield ต้องใช้ CreateDropdown)
-- =========================
MainTab:CreateDropdown({
    Name = "วิธีรีสปอน",
    Options = {"Random","Fake Revive"},
    CurrentOption = autoRespawnMethod,
    MultipleOptions = false,
    Callback = function(option)
        autoRespawnMethod = option
    end
})
 
-- =========================
-- Toggle ปุ่มลอย (แก้แล้ว)
-- =========================
MainTab:CreateToggle({
    Name = "ออโต้รีสปอน (ปุ่มลอย)",
    CurrentValue = false,
    Callback = function(state)
        if state then
            createRespawnFloatingButton()
        else
            removeRespawnFloatingButton()
            getgenv().AutoRespawnEnabled = false
        end
    end
})
 
-- =========================
-- Warp Up ปกติ
-- =========================
TeleportTab:CreateButton({
    Name = "วาร์ปขึ้นบน",
    Callback = function()
        local player = game.Players.LocalPlayer
        local char = player.Character
        if char then
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                root.CFrame = root.CFrame + Vector3.new(0,1200,0)
            end
        end
    end
})
 
-- =========================
-- Warp Up Floating Button
-- =========================
local floatingWarpButton
 
local function createWarpFloatingButton()
    if floatingWarpButton then return end
 
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,140,0,52)
    btn.Position = UDim2.new(0.5,-70,0.7,0)
    btn.AnchorPoint = Vector2.new(0.5,0)
    btn.BackgroundColor3 = Color3.fromRGB(180,220,255)  -- สีฟ้า
    btn.BackgroundTransparency = 0.35
    btn.TextColor3 = Color3.fromRGB(0,70,150)
    btn.Text = "วาร์ปขึ้นบน"
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = FloatingGui
    btn.Active = true
    btn.Draggable = true
 
    -- มุมโค้ง
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0,18)
 
    -- ขอบน้ำเงิน
    local stroke = Instance.new("UIStroke", btn)
    stroke.Thickness = 2.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Color = Color3.fromRGB(0,120,255)
 
    -- ไล่สีสไตล์ Floating Button อื่น
    task.spawn(function()
        while btn.Parent do
            TweenService:Create(stroke, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Color = Color3.fromRGB(0,80,255)}):Play()
            task.wait(0.8)
            TweenService:Create(stroke, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Color = Color3.fromRGB(0,120,255)}):Play()
            task.wait(0.8)
        end
    end)
 
    -- กดปุ่ม
    btn.MouseButton1Click:Connect(function()
        local player = game.Players.LocalPlayer
        local char = player.Character
        if char then
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                root.CFrame = root.CFrame + Vector3.new(0,1200,0)
            end
        end
    end)
 
    floatingWarpButton = btn
end
 
local function removeWarpFloatingButton()
    if floatingWarpButton then
        floatingWarpButton:Destroy()
        floatingWarpButton = nil
    end
end
 
-- Toggle ปุ่มลอย
TeleportTab:CreateToggle({
    Name = "วาร์ปขึ้นบน (Floating Button)",
    CurrentValue = false,
    Callback = function(state)
        if state then
            createWarpFloatingButton()
        else
            removeWarpFloatingButton()
        end
    end
})
 
-- =========================
-- VARIABLES
-- =========================
local autoFarm = false
local farmPart
 
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
 
local LocalPlayer = Players.LocalPlayer
 
-- =========================
-- CREATE PART
-- =========================
local function createPart()
    if farmPart then return end
 
    farmPart = Instance.new("Part")
    farmPart.Size = Vector3.new(10,1,10)
    farmPart.Anchored = true
    farmPart.Position = Vector3.new(0,1200,0)
    farmPart.Name = "FarmPart"
    farmPart.Parent = workspace
end
 
-- =========================
-- LOOP FARM
-- =========================
RunService.Heartbeat:Connect(function()
    if autoFarm then
        createPart()
 
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = farmPart.CFrame + Vector3.new(0,3,0)
        end
    end
end)
 
-- =========================
-- RESPAWN FIX
-- =========================
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    if autoFarm and farmPart then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = farmPart.CFrame + Vector3.new(0,3,0)
        end
    end
end)
 
-- =========================
-- ANTI AFK
-- =========================
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)
 
TeleportTab:CreateToggle({
    Name = "ออโต้ฟาร์มเงิน",
    CurrentValue = false,
    Callback = function(state)
        autoFarm = state
 
        if state then
            print("ฟาร์ม ON สัส")
        else
            print("ฟาร์ม OFF")
        end
    end
})
 
-- =========================
-- SERVICES
-- =========================
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
 
-- =========================
-- FUNCTION วาร์ปไปคนล้มแล้วเด้งกลับ
-- =========================
local function teleportToDowned()
    local myChar = LocalPlayer.Character
    if not (myChar and myChar:FindFirstChild("HumanoidRootPart")) then return end
 
    local myRoot = myChar.HumanoidRootPart
    local oldCFrame = myRoot.CFrame -- จำตำแหน่งเดิม
 
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local hum = plr.Character:FindFirstChild("Humanoid")
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
 
            if hum and root and hum.Health <= 0 then
                myRoot.CFrame = root.CFrame + Vector3.new(0,3,0) -- วาร์ปไป
                print("วาร์ปไปหา "..plr.Name)
 
                -- รอ 1 วิ แล้วเด้งกลับ
                task.delay(1, function()
                    if myRoot then
                        myRoot.CFrame = oldCFrame
                        print("กลับที่เดิม")
                    end
                end)
 
                return
            end
        end
    end
 
    print("ไม่มีคนล้ม")
end
 
-- =========================
-- ปุ่มปกติ
-- =========================
TeleportTab:CreateButton({
    Name = "วาร์ปไปยังผู้เล่นที่ล้ม",
    Callback = function()
        teleportToDowned()
    end
})
 
-- =========================
-- FLOATING BUTTON
-- =========================
local floatingWarpButton
 
local function createWarpFloatingButton()
    if floatingWarpButton then return end
 
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,160,0,52)
    btn.Position = UDim2.new(0.7,-70,0.7,0)
    btn.AnchorPoint = Vector2.new(0.5,0)
    btn.BackgroundColor3 = Color3.fromRGB(180,220,255)
    btn.BackgroundTransparency = 0.35
    btn.TextColor3 = Color3.fromRGB(0,70,150)
    btn.Text = "วาร์ปไปผู้เล่นล้ม"
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = FloatingGui
    btn.Active = true
    btn.Draggable = true
 
    -- มุมโค้ง
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0,18)
 
    -- ขอบ
    local stroke = Instance.new("UIStroke", btn)
    stroke.Thickness = 2.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Color = Color3.fromRGB(0,120,255)
 
    -- ไล่สีขอบ
    task.spawn(function()
        while btn.Parent do
            TweenService:Create(
                stroke,
                TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                {Color = Color3.fromRGB(0,80,255)}
            ):Play()
            task.wait(0.8)
 
            TweenService:Create(
                stroke,
                TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                {Color = Color3.fromRGB(160,230,255)}
            ):Play()
            task.wait(0.8)
        end
    end)
 
    -- กดปุ่ม
    btn.MouseButton1Click:Connect(function()
        teleportToDowned()
    end)
 
    floatingWarpButton = btn
end
 
local function removeWarpFloatingButton()
    if floatingWarpButton then
        floatingWarpButton:Destroy()
        floatingWarpButton = nil
    end
end
 
-- =========================
-- TOGGLE ปุ่มลอย
-- =========================
TeleportTab:CreateToggle({
    Name = "วาร์ปหาคนล้ม (Floating)",
    CurrentValue = false,
    Callback = function(state)
        if state then
            createWarpFloatingButton()
        else
            removeWarpFloatingButton()
        end
    end
})
 
-- =========================
-- SERVICES
-- =========================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
 
-- =========================
-- TABLE เก็บ ESP
-- =========================
local ESPTable = {}
 
-- =========================
-- FUNCTION เพิ่ม ESP ให้ผู้เล่น
-- =========================
local function addESP(plr)
    if ESPTable[plr] or not plr.Character then return end
    local char = plr.Character
    local hum = char:FindFirstChild("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not hum or not root then return end
 
    -- BillboardGui สำหรับชื่อ
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Billboard"
    billboard.Adornee = root
    billboard.Size = UDim2.new(0,100,0,50)
    billboard.AlwaysOnTop = true
    billboard.Parent = char
 
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1,0,1,0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.fromRGB(0,150,255)
    textLabel.TextStrokeColor3 = Color3.fromRGB(0,0,0)
    textLabel.TextStrokeTransparency = 0
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextScaled = true
    textLabel.Text = plr.Name
    textLabel.Parent = billboard
 
    -- ESP ขอบตัว
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.Adornee = char
    highlight.FillTransparency = 1
    highlight.OutlineTransparency = 0
    highlight.OutlineColor = Color3.fromRGB(0,150,255)
    highlight.Parent = char
 
    ESPTable[plr] = {Billboard = billboard, Highlight = highlight}
end
 
-- =========================
-- FUNCTION ลบ ESP
-- =========================
local function removeESP(plr)
    if ESPTable[plr] then
        local data = ESPTable[plr]
        if data.Billboard then data.Billboard:Destroy() end
        if data.Highlight then data.Highlight:Destroy() end
        ESPTable[plr] = nil
    end
end
 
-- =========================
-- ฟังก์ชันอัปเดตผู้เล่น
-- =========================
local function updateESP()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            if not ESPTable[plr] then
                addESP(plr)
            end
        end
    end
    -- ลบผู้เล่นที่ออก
    for plr, _ in pairs(ESPTable) do
        if not Players:FindFirstChild(plr.Name) then
            removeESP(plr)
        end
    end
end
 
-- =========================
-- Toggle Visuals
-- =========================
local ESPEnabled = false
 
VisualsTab:CreateToggle({
    Name = "มองหาผู้เล่น",
    CurrentValue = false,
    Callback = function(state)
        ESPEnabled = state
        if not state then
            -- ปิด ESP ทั้งหมด
            for plr, _ in pairs(ESPTable) do
                removeESP(plr)
            end
        else
            updateESP()
        end
    end
})
 
-- =========================
-- Heartbeat ตรวจผู้เล่นใหม่ / อัปเดตทุกเฟรม
-- =========================
RunService.Heartbeat:Connect(function()
    if ESPEnabled then
        updateESP()
    end
end)
 
 
-- =========================
-- ESP Nextbot
-- =========================
local nextbotESPEnabled = false
local nextbotThread
local floatingNextbotButton
 
local function removeNextbotESP()
    local folder = workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Players")
    if folder then
        for _, npc in ipairs(folder:GetChildren()) do
            local part = npc:FindFirstChildWhichIsA("BasePart")
            if part then
                local esp = part:FindFirstChild("NextbotESP")
                if esp then esp:Destroy() end
            end
        end
    end
end
 
local function startNextbotESP()
    if nextbotThread then return end
 
    nextbotThread = task.spawn(function()
        while nextbotESPEnabled do
            local folder = workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Players")
 
            if folder then
                for _, npc in ipairs(folder:GetChildren()) do
                    if npc:GetAttribute("Team") == "Nextbot" then
                        local part = npc:FindFirstChildWhichIsA("BasePart")
                        if part then
                            local billboard = part:FindFirstChild("NextbotESP")
 
                            if not billboard then
                                billboard = Instance.new("BillboardGui")
                                billboard.Name = "NextbotESP"
                                billboard.Adornee = part
                                billboard.Size = UDim2.new(0,180,0,25)
                                billboard.StudsOffset = Vector3.new(0,3.2,0)
                                billboard.AlwaysOnTop = true
                                billboard.Parent = part
 
                                local label = Instance.new("TextLabel")
                                label.Name = "Label"
                                label.Size = UDim2.new(1,0,1,0)
                                label.BackgroundTransparency = 1
                                label.TextScaled = true
                                label.Font = Enum.Font.GothamSemibold
                                label.Parent = billboard
                            end
 
                            local label = billboard:FindFirstChild("Label")
                            if label then
                                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                local dist = hrp and (part.Position - hrp.Position).Magnitude
 
                                if dist then
                                    label.Text = npc.Name.." ("..math.floor(dist)..")"
                                else
                                    label.Text = npc.Name
                                end
                            end
                        end
                    end
                end
            end
            task.wait(0.5)
        end
        nextbotThread = nil
    end)
end
 
-- Toggle ปกติ
VisualsTab:CreateToggle({
    Name = "มองเน็กบอท",
    CurrentValue = false,
    Callback = function(state)
        nextbotESPEnabled = state
        if state then
            startNextbotESP()
        else
            removeNextbotESP()
        end
    end
})
 
-- ปุ่มลอย
local function createNextbotFloating()
    if floatingNextbotButton then return end
 
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,150,0,50)
    btn.Position = UDim2.new(0.5,0,0.6,0)
    btn.BackgroundColor3 = Color3.fromRGB(180,220,255)
    btn.TextColor3 = Color3.fromRGB(0,70,150)
    btn.Text = "Nextbot: OFF"
    btn.Parent = FloatingGui
    btn.Active = true
    btn.Draggable = true
 
    local stroke = Instance.new("UIStroke",btn)
    stroke.Color = Color3.fromRGB(0,120,255)
 
    btn.MouseButton1Click:Connect(function()
        nextbotESPEnabled = not nextbotESPEnabled
        btn.Text = nextbotESPEnabled and "Nextbot: ON" or "Nextbot: OFF"
 
        if nextbotESPEnabled then
            startNextbotESP()
        else
            removeNextbotESP()
        end
    end)
 
    floatingNextbotButton = btn
end
 
VisualsTab:CreateToggle({
    Name = "ESP Nextbot (Floating)",
    CurrentValue = false,
    Callback = function(state)
        if state then
            createNextbotFloating()
        else
            if floatingNextbotButton then
                floatingNextbotButton:Destroy()
                floatingNextbotButton = nil
            end
        end
    end
})
 
-- =========================
-- ESP Ticket
-- =========================
local ticketESPEnabled = false
local ticketESPThread
local floatingTicketButton
 
local function getDistance(pos)
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    return hrp and (pos - hrp.Position).Magnitude or nil
end
 
local function createTicketESP(part)
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "TicketESP"
    billboard.Adornee = part
    billboard.Size = UDim2.new(0,180,0,25)
    billboard.StudsOffset = Vector3.new(0,3.2,0)
    billboard.AlwaysOnTop = true
    billboard.Parent = part
 
    local label = Instance.new("TextLabel")
    label.Name = "Ticket"
    label.Size = UDim2.new(1,0,1,0)
    label.BackgroundTransparency = 1
    label.TextStrokeTransparency = 0.25
    label.TextScaled = true
    label.Font = Enum.Font.GothamSemibold
    label.TextColor3 = Color3.fromRGB(255,255,150)
    label.Text = "Ticket"
    label.Parent = billboard
 
    return billboard
end
 
local function removeTicketESP()
    local folder = workspace:FindFirstChild("Game")
        and workspace.Game:FindFirstChild("Effects")
        and workspace.Game.Effects:FindFirstChild("Tickets")
 
    if folder then
        for _, v in ipairs(folder:GetChildren()) do
            local part = v:FindFirstChildWhichIsA("BasePart")
            if part then
                local esp = part:FindFirstChild("TicketESP")
                if esp then esp:Destroy() end
            end
        end
    end
end
 
local function startTicketESP()
    if ticketESPThread then return end
 
    ticketESPThread = task.spawn(function()
        while ticketESPEnabled do
            local folder = workspace:FindFirstChild("Game")
                and workspace.Game:FindFirstChild("Effects")
                and workspace.Game.Effects:FindFirstChild("Tickets")
 
            if folder then
                for _, v in ipairs(folder:GetChildren()) do
                    local part = v:FindFirstChildWhichIsA("BasePart")
                    if part then
                        local billboard = part:FindFirstChild("TicketESP") or createTicketESP(part)
                        local label = billboard:FindFirstChild("Ticket")
 
                        if label then
                            local dist = getDistance(part.Position)
                            if dist then
                                label.Text = v.Name.." ("..math.floor(dist)..")"
                            else
                                label.Text = v.Name
                            end
                        end
                    end
                end
            end
            task.wait(0.5)
        end
        ticketESPThread = nil
    end)
end
 
-- Toggle ปกติ
EventTab:CreateToggle({
    Name = "มองตั๋ว (ESP Ticket)",
    CurrentValue = false,
    Callback = function(state)
        ticketESPEnabled = state
        if state then
            startTicketESP()
        else
            removeTicketESP()
        end
    end
})
 
-- ปุ่มลอย
local function createTicketFloating()
    if floatingTicketButton then return end
 
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,150,0,50)
    btn.Position = UDim2.new(0.3,0,0.5,0)
    btn.BackgroundColor3 = Color3.fromRGB(180,220,255)
    btn.TextColor3 = Color3.fromRGB(0,70,150)
    btn.Text = "Ticket ESP: OFF"
    btn.Parent = FloatingGui
    btn.Active = true
    btn.Draggable = true
 
    local stroke = Instance.new("UIStroke",btn)
    stroke.Color = Color3.fromRGB(0,120,255)
 
    btn.MouseButton1Click:Connect(function()
        ticketESPEnabled = not ticketESPEnabled
        btn.Text = ticketESPEnabled and "Ticket ESP: ON" or "Ticket ESP: OFF"
 
        if ticketESPEnabled then
            startTicketESP()
        else
            removeTicketESP()
        end
    end)
 
    floatingTicketButton = btn
end
 
EventTab:CreateToggle({
    Name = "ESP Ticket (Floating)",
    CurrentValue = false,
    Callback = function(state)
        if state then
            createTicketFloating()
        else
            if floatingTicketButton then
                floatingTicketButton:Destroy()
                floatingTicketButton = nil
            end
        end
    end
})
 
-- =========================
-- Toggle ซ้ำใน VisualsTab
-- =========================
VisualsTab:CreateToggle({
    Name = "มองตั๋ว (ESP Ticket)",
    CurrentValue = false,
    Callback = function(state)
        ticketESPEnabled = state
 
        if state then
            startTicketESP()
        else
            removeTicketESP()
        end
    end
})
 
-- =========================
-- Noclip (ทะลุกำแพง)
-- =========================
local noclipEnabled = false
local noclipConnection
 
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
 
local function startNoclip()
    if noclipConnection then return end
 
    noclipConnection = game:GetService("RunService").Stepped:Connect(function()
        if noclipEnabled then
            local char = LocalPlayer.Character
            if char then
                for _, v in pairs(char:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end
    end)
end
 
local function stopNoclip()
    if noclipConnection then
        noclipConnection:Disconnect()
        noclipConnection = nil
    end
 
    -- คืนค่าการชนกลับ
    local char = LocalPlayer.Character
    if char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = true
            end
        end
    end
end
 
-- =========================
-- Toggle ปกติ
-- =========================
ExtraTab:CreateToggle({
    Name = "ทะลุกำแพง",
    CurrentValue = false,
    Callback = function(state)
        noclipEnabled = state
 
        if state then
            startNoclip()
        else
            stopNoclip()
        end
    end
})
 
 
-- =========================
-- Moon Mode (ตกช้า)
-- =========================
local moonEnabled = false
local moonGravity = 0.3 -- ค่ายิ่งน้อย = ยิ่งลอย
local moonConnection
 
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
 
local function startMoon()
    if moonConnection then return end
 
    moonConnection = RunService.Heartbeat:Connect(function()
        if not moonEnabled then return end
 
        local char = LocalPlayer.Character
        if not char then return end
 
        local root = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChild("Humanoid")
        if not root or not hum then return end
 
        -- ถ้ากำลังตก
        if root.Velocity.Y < -1 then
            root.Velocity = Vector3.new(
                root.Velocity.X,
                root.Velocity.Y * moonGravity,
                root.Velocity.Z
            )
        end
    end)
end
 
local function stopMoon()
    if moonConnection then
        moonConnection:Disconnect()
        moonConnection = nil
    end
end
 
-- =========================
-- Toggle
-- =========================
ExtraTab:CreateToggle({
    Name = "โหมดดวงจันทร์",
    CurrentValue = false,
    Callback = function(state)
        moonEnabled = state
 
        if state then
            startMoon()
        else
            stopMoon()
        end
    end
})
 
-- =========================
-- ปรับความลอย
-- =========================
ExtraTab:CreateInput({
    Name = "แรงโน้มถ่วง (ยิ่งน้อยยิ่งลอย)",
    PlaceholderText = "เช่น 0.3",
    RemoveTextAfterFocusLost = false,
    Callback = function(txt)
        local num = tonumber(txt)
        if num then
            moonGravity = math.clamp(num, 0, 1)
        end
    end
})
 
-- =========================
-- Map Spawner System
-- =========================
local currentMap = nil
 
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
 
local function spawnMap(assetId, height)
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
 
    -- ลบแมพเก่า
    if currentMap and currentMap.Parent then
        currentMap:Destroy()
        currentMap = nil
    end
 
    -- โหลดแมพใหม่
    local success, model = pcall(function()
        return game:GetObjects("rbxassetid://" .. assetId)[1]
    end)
 
    if not success or not model then
        warn("โหลดแมพไม่สำเร็จ")
        return
    end
 
    model.Parent = workspace
    currentMap = model
 
    -- ยกแมพขึ้น
    local cf = model:GetPivot()
    model:PivotTo(cf + Vector3.new(0, height, 0))
 
    task.wait(0.2)
 
    -- วาร์ปไปบนแมพ
    hrp.CFrame = model:GetPivot() * CFrame.new(0, 3, 0)
end
 
-- =========================
-- Grow a Garden
-- =========================
MapTab:CreateButton({
    Name = "Map: Grow a Garden",
    Callback = function()
        spawnMap(105019154044298, 270)
    end
})
 
-- =========================
-- Brookhaven (แก้ ID แล้ว)
-- =========================
MapTab:CreateButton({
    Name = "Map: Brookhaven",
    Callback = function()
        spawnMap(108186045609746, 250)
    end
})
 
-- =========================
-- Free Fire
-- =========================
MapTab:CreateButton({
    Name = "Map: Free Fire",
    Callback = function()
        spawnMap(136952494452456, 250)
    end
})
 
-- =========================
-- Warp to Most Still Player (Toggle Style Single Press)
-- =========================
local warpFloatingBtn = nil
 
-- หา "ผู้เล่นนิ่งสุด"
local function getMostStillPlayer()
    local myChar = LocalPlayer.Character
    if not myChar then return nil end
 
    local myHRP = myChar:FindFirstChild("HumanoidRootPart")
    if not myHRP then return nil end
 
    local minVel = math.huge
    local target = nil
 
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local vel = hrp.Velocity.Magnitude
                if vel < minVel then
                    minVel = vel
                    target = plr
                end
            end
        end
    end
 
    return target
end
 
-- วาร์ปไปหา player
local function warpToPlayer(player)
    if not player or not player.Character then return end
 
    local myChar = LocalPlayer.Character
    if not myChar then return end
 
    local myHRP = myChar:FindFirstChild("HumanoidRootPart")
    local targetHRP = player.Character:FindFirstChild("HumanoidRootPart")
 
    if myHRP and targetHRP then
        myHRP.CFrame = targetHRP.CFrame + Vector3.new(0,3,0)
    end
end
 
-- =========================
-- ปุ่มลอย
-- =========================
local function createWarpFloatingButton()
    if warpFloatingBtn then return end
 
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,140,0,52)
    btn.Position = UDim2.new(0.3,-70,0.8,0)
    btn.AnchorPoint = Vector2.new(0.5,0)
    btn.BackgroundColor3 = Color3.fromRGB(180,220,255)
    btn.BackgroundTransparency = 0.35
    btn.TextColor3 = Color3.fromRGB(0,70,150)
    btn.Text = "วาร์ปผู้เล่นนิ่งสุด"
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = FloatingGui
    btn.Active = true
    btn.Draggable = true
    btn.AutoButtonColor = false
 
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0,18)
 
    local stroke = Instance.new("UIStroke", btn)
    stroke.Thickness = 2.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Color = Color3.fromRGB(0,120,255)
 
    task.spawn(function()
        while btn.Parent do
            TweenService:Create(stroke, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Color = Color3.fromRGB(0,80,255)
            }):Play()
            task.wait(0.8)
            TweenService:Create(stroke, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Color = Color3.fromRGB(160,230,255)
            }):Play()
            task.wait(0.8)
        end
    end)
 
    btn.MouseButton1Click:Connect(function()
        local target = getMostStillPlayer()
        if target then
            warpToPlayer(target)
        end
    end)
 
    warpFloatingBtn = btn
end
 
-- =========================
-- Toggle ปกติใน TeleportTab
-- =========================
TeleportTab:CreateToggle({
    Name = "วาร์ปผู้เล่นนิ่งสุด",
    CurrentValue = false,
    Callback = function(state)
        if state then
            local target = getMostStillPlayer()
            if target then
                warpToPlayer(target)
            end
        end
    end
})
 
-- =========================
-- Toggle ปุ่มลอยใน TeleportTab
-- =========================
TeleportTab:CreateToggle({
    Name = "วาร์ปผู้เล่นนิ่งสุด (ลอย)",
    CurrentValue = false,
    Callback = function(state)
        if state then
            createWarpFloatingButton()
            if warpFloatingBtn then
                warpFloatingBtn.Visible = true
            end
        else
            if warpFloatingBtn then
                warpFloatingBtn.Visible = false
            end
        end
    end
})
 
-- =========================
-- FPS Display ปรับมือถือ
-- =========================
local fpsLabel = nil
local fpsEnabled = false
 
local function createFPSLabel()
    if fpsLabel then return end
 
    local screenGui = game:GetService("CoreGui"):FindFirstChild("ScreenGui")
    if not screenGui then
        screenGui = Instance.new("ScreenGui")
        screenGui.Parent = game:GetService("CoreGui")
    end
 
    fpsLabel = Instance.new("TextLabel")
    fpsLabel.Size = UDim2.new(0,120,0,30)
    fpsLabel.Position = UDim2.new(0,10,0,10)
    fpsLabel.BackgroundTransparency = 1
    fpsLabel.TextColor3 = Color3.fromRGB(0,120,255)
    fpsLabel.TextStrokeTransparency = 0.25
    fpsLabel.Font = Enum.Font.GothamBold
    fpsLabel.TextSize = 20
    fpsLabel.Text = "FPS: 0"
    fpsLabel.TextScaled = true
    fpsLabel.TextXAlignment = Enum.TextXAlignment.Left
    fpsLabel.Parent = screenGui
end
 
local function removeFPSLabel()
    if fpsLabel then
        fpsLabel:Destroy()
        fpsLabel = nil
    end
end
 
-- อัปเดต FPS ทุก 1 วิ
task.spawn(function()
    local lastTime = tick()
    local frameCount = 0
 
    game:GetService("RunService").RenderStepped:Connect(function()
        if fpsEnabled then
            frameCount += 1
        end
    end)
 
    while true do
        task.wait(1) -- ตรวจทุก 1 วิ
        if fpsEnabled and fpsLabel then
            local now = tick()
            local delta = now - lastTime
            local fps = math.floor(frameCount / delta + 0.5) -- ปรับให้อิงความลื่น
            fpsLabel.Text = "FPS: "..fps
            frameCount = 0
            lastTime = now
        end
    end
end)
 
-- Toggle ใน FPSTab
FPSTab:CreateToggle({
    Name = "เเสดงFPS",
    CurrentValue = false,
    Callback = function(state)
        fpsEnabled = state
        if state then
            createFPSLabel()
        else
            removeFPSLabel()
        end
    end
})
 
-- =========================
-- SERVICES
-- =========================
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
 
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
 
-- =========================
-- SETTINGS
-- =========================
local clickTPEnabled = false
local floatingBtn = nil
 
-- =========================
-- FUNCTION: วาร์ปไปตำแหน่งที่กด
-- =========================
local function teleportToPosition(position)
    local char = LocalPlayer.Character
    if not char then return end
 
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
 
    -- ยิง Ray ลงพื้น (กันวาร์ปลอย)
    local rayOrigin = position + Vector3.new(0,50,0)
    local rayDir = Vector3.new(0,-200,0)
 
    local raycast = Workspace:Raycast(rayOrigin, rayDir)
    if raycast then
        hrp.CFrame = CFrame.new(raycast.Position + Vector3.new(0,3,0))
    else
        hrp.CFrame = CFrame.new(position + Vector3.new(0,3,0))
    end
end
 
-- =========================
-- CLICK DETECT (มือถือ + PC)
-- =========================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not clickTPEnabled then return end
    if gameProcessed then return end
 
    if input.UserInputType == Enum.UserInputType.MouseButton1 
    or input.UserInputType == Enum.UserInputType.Touch then
 
        local pos = Mouse.Hit.Position
        teleportToPosition(pos)
    end
end)
 
-- =========================
-- FLOATING BUTTON
-- =========================
local function createFloatingButton()
    if floatingBtn then return end
 
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,150,0,52)
    btn.Position = UDim2.new(0.5,0,0.75,0)
    btn.AnchorPoint = Vector2.new(0.5,0)
    btn.BackgroundColor3 = Color3.fromRGB(180,220,255)
    btn.BackgroundTransparency = 0.35
    btn.TextColor3 = Color3.fromRGB(0,70,150)
    btn.Text = "Click TP: OFF"
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = FloatingGui
    btn.Active = true
    btn.Draggable = true
    btn.AutoButtonColor = false
 
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0,18)
 
    local stroke = Instance.new("UIStroke", btn)
    stroke.Thickness = 2.5
    stroke.Color = Color3.fromRGB(0,120,255)
 
    -- สีขอบวิ่ง
    task.spawn(function()
        while btn.Parent do
            TweenService:Create(stroke, TweenInfo.new(0.8), {
                Color = Color3.fromRGB(0,80,255)
            }):Play()
            task.wait(0.8)
            TweenService:Create(stroke, TweenInfo.new(0.8), {
                Color = Color3.fromRGB(160,230,255)
            }):Play()
            task.wait(0.8)
        end
    end)
 
    -- กดเปิด/ปิด
    btn.MouseButton1Click:Connect(function()
        clickTPEnabled = not clickTPEnabled
        btn.Text = clickTPEnabled and "Click TP: ON" or "Click TP: OFF"
    end)
 
    floatingBtn = btn
end
 
-- =========================
-- TOGGLE ใน TeleportTab
-- =========================
TeleportTab:CreateToggle({
    Name = "คลิก เทเลพอร์ต",
    CurrentValue = false,
    Callback = function(state)
        clickTPEnabled = state
    end
})
 
-- =========================
-- TOGGLE ปุ่มลอย
-- =========================
TeleportTab:CreateToggle({
    Name = "คลิก เทเลพอร์ต (ลอย)",
    CurrentValue = false,
    Callback = function(state)
        if state then
            createFloatingButton()
            if floatingBtn then floatingBtn.Visible = true end
        else
            if floatingBtn then floatingBtn.Visible = false end
            clickTPEnabled = false
        end
    end
})
 
-- =========================
-- Low Graphics Mode
-- =========================
local lowGfxEnabled = false
local originalSettings = {}
 
local Lighting = game:GetService("Lighting")
local Terrain = workspace:FindFirstChildOfClass("Terrain")
 
-- เก็บค่าเดิม
local function saveOriginal()
    originalSettings.FogEnd = Lighting.FogEnd
    originalSettings.Brightness = Lighting.Brightness
    originalSettings.GlobalShadows = Lighting.GlobalShadows
end
 
-- เปิด Low Graphics
local function enableLowGraphics()
    -- ลบเอฟเฟคใน Lighting
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("PostEffect") or v:IsA("Atmosphere") or v:IsA("Sky") or v:IsA("BloomEffect") or v:IsA("SunRaysEffect") then
            v:Destroy()
        end
    end
 
    -- ปิดหมอก
    Lighting.FogEnd = 100000
    Lighting.GlobalShadows = false
    Lighting.Brightness = 1
 
    -- ทำ Part เรียบ
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.Material = Enum.Material.SmoothPlastic
            obj.Reflectance = 0
        end
 
        -- ปิดอนุภาค/เอฟเฟค
        if obj:IsA("ParticleEmitter") 
        or obj:IsA("Trail") 
        or obj:IsA("Smoke") 
        or obj:IsA("Fire") then
            obj.Enabled = false
        end
 
        -- ปิด Decal/Texture (ลบลาย)
        if obj:IsA("Decal") or obj:IsA("Texture") then
            obj:Destroy()
        end
    end
 
    -- Terrain เรียบ
    if Terrain then
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 1
    end
end
 
-- ปิด Low Graphics
local function disableLowGraphics()
    -- คืนค่า Lighting บางส่วน
    if originalSettings.FogEnd then
        Lighting.FogEnd = originalSettings.FogEnd
        Lighting.Brightness = originalSettings.Brightness
        Lighting.GlobalShadows = originalSettings.GlobalShadows
    end
end
 
-- =========================
-- Toggle ใน FPSTab
-- =========================
FPSTab:CreateToggle({
    Name = "ลดกราฟฟิก",
    CurrentValue = false,
    Callback = function(state)
        lowGfxEnabled = state
        if state then
            saveOriginal()
            enableLowGraphics()
        else
            disableLowGraphics()
        end
    end
})
 
-- =========================
-- DASH SMOOTH (FULL VERSION)
-- =========================
local dashEnabled = false
local dashSpeed = 80
local dashVelocity = nil
local floatingDashButton = nil
 
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
 
-- =========================
-- RESET กันบัค
-- =========================
local function resetDash()
    dashEnabled = false
 
    if dashVelocity then
        dashVelocity:Destroy()
        dashVelocity = nil
    end
end
 
player.CharacterAdded:Connect(function()
    task.wait(0.3)
    resetDash()
end)
 
-- =========================
-- START DASH
-- =========================
local function startDash()
    if dashVelocity then return end
 
    local char = player.Character
    if not char then return end
 
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
 
    dashVelocity = Instance.new("BodyVelocity")
    dashVelocity.MaxForce = Vector3.new(999999,0,999999)
    dashVelocity.P = 1250
    dashVelocity.Parent = root
 
    task.spawn(function()
        while dashEnabled do
            local char = player.Character
            if not char then break end
 
            local root = char:FindFirstChild("HumanoidRootPart")
            local cam = workspace.CurrentCamera
 
            if not root or not cam then break end
 
            local dir = cam.CFrame.LookVector
            dir = Vector3.new(dir.X,0,dir.Z)
 
            if dir.Magnitude > 0 then
                dir = dir.Unit
            end
 
            dashVelocity.Velocity = dir * dashSpeed
            task.wait(0.03)
        end
 
        if dashVelocity then
            dashVelocity:Destroy()
            dashVelocity = nil
        end
    end)
end
 
-- =========================
-- 🔘 Toggle ปกติ
-- =========================
SettingsTab:CreateToggle({
    Name = "Dash Smooth",
    CurrentValue = false,
    Callback = function(state)
        dashEnabled = state
 
        if state then
            startDash()
        else
            resetDash()
        end
    end
})
 
-- =========================
-- 🔧 ปรับความเร็ว
-- =========================
SettingsTab:CreateInput({
    Name = "Dash Speed",
    PlaceholderText = "ค่าเริ่มต้น 80",
    RemoveTextAfterFocusLost = false,
    Callback = function(txt)
        local num = tonumber(txt)
        if num then
            dashSpeed = num
        end
    end
})
 
-- =========================
-- 🟦 FLOATING BUTTON (สไตล์เดียวกับ Bounce)
-- =========================
local function createDashFloatingButton()
    if floatingDashButton then return end
 
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,140,0,52)
    btn.Position = UDim2.new(0.5,-70,0.75,0)
    btn.AnchorPoint = Vector2.new(0.5,0)
    btn.BackgroundColor3 = Color3.fromRGB(180,220,255)
    btn.BackgroundTransparency = 0.35
    btn.TextColor3 = Color3.fromRGB(0,70,150)
    btn.Text = dashEnabled and "Dash: ON" or "Dash: OFF"
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = FloatingGui
    btn.Active = true
    btn.Draggable = true
 
    -- มุมโค้ง
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0,18)
 
    -- ขอบ
    local stroke = Instance.new("UIStroke", btn)
    stroke.Thickness = 2.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Color = Color3.fromRGB(0,120,255)
 
    -- ไล่สี
    task.spawn(function()
        while btn.Parent do
            TweenService:Create(
                stroke,
                TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                {Color = Color3.fromRGB(0,80,255)}
            ):Play()
            task.wait(0.8)
            TweenService:Create(
                stroke,
                TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                {Color = Color3.fromRGB(160,230,255)}
            ):Play()
            task.wait(0.8)
        end
    end)
 
    -- กดปุ่ม (Toggle จริง)
    btn.MouseButton1Click:Connect(function()
        dashEnabled = not dashEnabled
        btn.Text = dashEnabled and "Dash: ON" or "Dash: OFF"
 
        if dashEnabled then
            startDash()
        else
            resetDash()
        end
    end)
 
    floatingDashButton = btn
end
 
local function removeDashFloatingButton()
    if floatingDashButton then
        floatingDashButton:Destroy()
        floatingDashButton = nil
    end
end
 
-- =========================
-- 🔘 Toggle ปุ่มลอย
-- =========================
SettingsTab:CreateToggle({
    Name = "Dash Floating Button",
    CurrentValue = false,
    Callback = function(state)
        if state then
            createDashFloatingButton()
        else
            removeDashFloatingButton()
        end
    end
})
 
-- =========================
-- SYSTEM: Auto Carry Logic
-- =========================
 
getgenv().autoCarryEnabled = false
getgenv().autoCarryConnection = nil
getgenv().floatingCarryButton = nil
 
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
 
local localPlayer = Players.LocalPlayer
 
-- =========================
-- START
-- =========================
local function startAutoCarry()
    if getgenv().autoCarryConnection then return end
 
    getgenv().autoCarryConnection = RunService.Heartbeat:Connect(function()
        if not getgenv().autoCarryEnabled then return end
 
        local char = localPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
 
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= localPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local otherHRP = plr.Character.HumanoidRootPart
                local dist = (hrp.Position - otherHRP.Position).Magnitude
 
                if dist <= 20 then
                    pcall(function()
                        ReplicatedStorage.Events.Character.Interact:FireServer("Carry", nil, plr.Name)
                    end)
                    task.wait(0.05)
                end
            end
        end
    end)
end
 
-- =========================
-- STOP
-- =========================
local function stopAutoCarry()
    if getgenv().autoCarryConnection then
        getgenv().autoCarryConnection:Disconnect()
        getgenv().autoCarryConnection = nil
    end
end
 
-- =========================
-- RESET กันบัคตอนตาย
-- =========================
local function resetCarry()
    getgenv().autoCarryEnabled = false
    stopAutoCarry()
end
 
localPlayer.CharacterAdded:Connect(function()
    task.wait(0.3)
    resetCarry()
end)
 
-- =========================
-- 🔘 Toggle ในเมนู
-- =========================
MainTab:CreateToggle({
    Name = "Auto Carry",
    CurrentValue = false,
    Callback = function(state)
        getgenv().autoCarryEnabled = state
 
        if state then
            startAutoCarry()
        else
            stopAutoCarry()
        end
 
        if getgenv().floatingCarryButton then
            getgenv().floatingCarryButton.Text =
                state and "Auto Carry: ON" or "Auto Carry: OFF"
        end
    end
})
 
-- =========================
-- 🟦 FLOATING BUTTON (สไตล์เดียวกับมึง)
-- =========================
local PlayerGui = localPlayer:WaitForChild("PlayerGui")
 
local FloatingGui = PlayerGui:FindFirstChild("EvadeFloatingGui")
if not FloatingGui then
    FloatingGui = Instance.new("ScreenGui")
    FloatingGui.Name = "EvadeFloatingGui"
    FloatingGui.ResetOnSpawn = false
    FloatingGui.Parent = PlayerGui
end
 
local function createCarryFloatingButton()
    if getgenv().floatingCarryButton then return end
 
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,140,0,52)
    btn.Position = UDim2.new(0.25,0,0.75,0)
    btn.AnchorPoint = Vector2.new(0.5,0)
    btn.BackgroundColor3 = Color3.fromRGB(180,220,255)
    btn.BackgroundTransparency = 0.35
    btn.TextColor3 = Color3.fromRGB(0,70,150)
    btn.Text = getgenv().autoCarryEnabled and "Auto Carry: ON" or "Auto Carry: OFF"
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = FloatingGui
    btn.Active = true
    btn.Draggable = true
 
    -- มุมโค้ง
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0,18)
 
    -- ขอบ
    local stroke = Instance.new("UIStroke", btn)
    stroke.Thickness = 2.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Color = Color3.fromRGB(0,120,255)
 
    -- ไล่สี (เหมือน Dash / Bounce)
    task.spawn(function()
        while btn.Parent do
            TweenService:Create(
                stroke,
                TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                {Color = Color3.fromRGB(0,80,255)}
            ):Play()
            task.wait(0.8)
 
            TweenService:Create(
                stroke,
                TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                {Color = Color3.fromRGB(160,230,255)}
            ):Play()
            task.wait(0.8)
        end
    end)
 
    -- กด = Toggle
    btn.MouseButton1Click:Connect(function()
        getgenv().autoCarryEnabled = not getgenv().autoCarryEnabled
 
        if getgenv().autoCarryEnabled then
            startAutoCarry()
        else
            stopAutoCarry()
        end
 
        btn.Text =
            getgenv().autoCarryEnabled and "Auto Carry: ON" or "Auto Carry: OFF"
    end)
 
    getgenv().floatingCarryButton = btn
end
 
local function removeCarryFloatingButton()
    if getgenv().floatingCarryButton then
        getgenv().floatingCarryButton:Destroy()
        getgenv().floatingCarryButton = nil
    end
end
 
-- =========================
-- 🔘 Toggle ปุ่มลอย
-- =========================
MainTab:CreateToggle({
    Name = "Carry Floating Button",
    CurrentValue = false,
    Callback = function(state)
        if state then
            createCarryFloatingButton()
        else
            removeCarryFloatingButton()
        end
    end
})
 
 
 
-- =========================
-- ปุ่ม เพิ่มแสงหน้าจอ
-- =========================
FPSTab:CreateButton({
    Name = "เพิ่มแสงหน้าจอ",
    Callback = function()
        local Lighting = game:GetService("Lighting")
        Lighting.Brightness = (Lighting.Brightness or 2) + 1 -- เพิ่มทีละ 1
        print("✅ เพิ่มแสงเรียบร้อย")
    end
})
 
-- =========================
-- Infinite Slide (MainTab + Floating)
-- =========================
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
 
-- ตัวแปรเก็บสถานะ
local infiniteSlideEnabled = false
local slideFrictionValue = -8
local cachedTables
local plrModel
local slideConnection
local floatingSlideButton
 
-- ฟังก์ชันช่วย
local keys = {
    "Friction","AirStrafeAcceleration","JumpHeight","RunDeaccel",
    "JumpSpeedMultiplier","JumpCap","SprintCap","WalkSpeedMultiplier",
    "BhopEnabled","Speed","AirAcceleration","RunAccel","SprintAcceleration"
}
 
local function hasAll(tbl)
    if type(tbl) ~= "table" then return false end
    for _, k in ipairs(keys) do if rawget(tbl, k) == nil then return false end end
    return true
end
 
local function setFriction(value)
    if not cachedTables then return end
    for _, t in ipairs(cachedTables) do
        pcall(function() t.Friction = value end)
    end
end
 
local function updatePlayerModel()
    local GameFolder = workspace:FindFirstChild("Game")
    local PlayersFolder = GameFolder and GameFolder:FindFirstChild("Players")
    if PlayersFolder then
        plrModel = PlayersFolder:FindFirstChild(player.Name)
    else
        plrModel = nil
    end
end
 
local function onHeartbeat()
    if not plrModel then setFriction(5); return end
    local success, currentState = pcall(function() return plrModel:GetAttribute("State") end)
    if success and currentState then
        if currentState == "Slide" then
            pcall(function() plrModel:SetAttribute("State", "EmotingSlide") end)
        elseif currentState == "EmotingSlide" then
            setFriction(slideFrictionValue)
        else
            setFriction(5)
        end
    else
        setFriction(5)
    end
end
 
-- ฟังก์ชันเปิด/ปิด Infinite Slide
local function toggleInfiniteSlide()
    infiniteSlideEnabled = not infiniteSlideEnabled
 
    if slideConnection then slideConnection:Disconnect(); slideConnection=nil end
 
    if infiniteSlideEnabled then
        cachedTables = {}
        for _, obj in ipairs(getgc(true)) do
            local success, result = pcall(function() if hasAll(obj) then return obj end end)
            if success and result then table.insert(cachedTables, result) end
        end
        updatePlayerModel()
        slideConnection = RunService.Heartbeat:Connect(onHeartbeat)
        player.CharacterAdded:Connect(function() wait(0.1); updatePlayerModel() end)
    else
        cachedTables = nil
        plrModel = nil
        setFriction(5)
    end
 
    -- อัปเดตปุ่มลอย
    if floatingSlideButton then
        floatingSlideButton.BackgroundColor3 = infiniteSlideEnabled and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
        floatingSlideButton.Text = infiniteSlideEnabled and "Infinite Slide: ON" or "Infinite Slide: OFF"
    end
end
 
-- =========================
-- ปุ่มปกติใน MainTab
MainTab:CreateToggle({
    Name="อินฟีนีตี้สไลด์",
    CurrentValue=false,
    Callback=function(state)
        toggleInfiniteSlide()
    end
})
 
-- =========================
-- ปุ่มลอย (Floating)
local PlayerGui = player:WaitForChild("PlayerGui")
local FloatingGui = PlayerGui:FindFirstChild("EvadeFloatingGui")
if not FloatingGui then
    FloatingGui = Instance.new("ScreenGui")
    FloatingGui.Name = "EvadeFloatingGui"
    FloatingGui.ResetOnSpawn = false
    FloatingGui.Parent = PlayerGui
end
 
local function createFloatingSlideButton()
    if floatingSlideButton then return end
 
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,140,0,52)
    btn.Position = UDim2.new(0.5,-70,0.4,0)
    btn.AnchorPoint = Vector2.new(0.5,0)
    btn.BackgroundColor3 = infiniteSlideEnabled and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Text = infiniteSlideEnabled and "Infinite Slide: ON" or "Infinite Slide: OFF"
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Active = true
    btn.Draggable = true
    btn.Parent = FloatingGui
 
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0,18)
 
    local stroke = Instance.new("UIStroke", btn)
    stroke.Thickness = 2.5
    stroke.Color = Color3.fromRGB(0,120,255)
 
    -- ไล่สีขอบ
    task.spawn(function()
        while btn.Parent do
            TweenService:Create(stroke,TweenInfo.new(0.8,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{Color=Color3.fromRGB(0,80,255)}):Play()
            task.wait(0.8)
            TweenService:Create(stroke,TweenInfo.new(0.8,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{Color=Color3.fromRGB(160,230,255)}):Play()
            task.wait(0.8)
        end
    end)
 
    btn.MouseButton1Click:Connect(toggleInfiniteSlide)
 
    floatingSlideButton = btn
end
 
MainTab:CreateButton({
    Name = "ปุ่มลอย Infinite Slide",
    Callback = createFloatingSlideButton
})
 
-- =========================
-- มองหาผู้เล่นล้ม (VisualsTab)
-- =========================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VisualsTab = VisualsTab -- มึงต้องมี tab นี้อยู่แล้ว
local localPlayer = Players.LocalPlayer
local fallenESPEnabled = false
local fallenESPLabels = {}
 
-- ฟังก์ชันลบป้ายเก่า
local function clearFallenLabels()
    for _, lbl in pairs(fallenESPLabels) do
        if lbl and lbl.Parent then lbl:Destroy() end
    end
    fallenESPLabels = {}
end
 
-- ฟังก์ชันอัปเดต ESP
local function updateFallenESP()
    clearFallenLabels()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= localPlayer and plr.Character and plr.Character:FindFirstChild("Humanoid") then
            local humanoid = plr.Character.Humanoid
            if humanoid.Health <= 0 then
                local head = plr.Character:FindFirstChild("Head")
                if head then
                    local bill = Instance.new("BillboardGui")
                    bill.Size = UDim2.new(0,100,0,50)
                    bill.Adornee = head
                    bill.AlwaysOnTop = true
                    bill.Parent = head
 
                    local txt = Instance.new("TextLabel")
                    txt.Size = UDim2.new(1,0,1,0)
                    txt.BackgroundTransparency = 1
                    txt.TextColor3 = Color3.fromRGB(255,0,0)
                    txt.TextScaled = true
                    txt.Font = Enum.Font.GothamBold
                    txt.Text = "ล้ม"
                    txt.Parent = bill
 
                    table.insert(fallenESPLabels, bill)
                end
            end
        end
    end
end
 
-- =========================
-- Toggle ปุ่มใน VisualsTab
VisualsTab:CreateToggle({
    Name = "มองหาผู้เล่นล้ม",
    CurrentValue = false,
    Callback = function(state)
        fallenESPEnabled = state
        if not state then
            clearFallenLabels()
        end
    end
})
 
-- =========================
-- เชื่อม RunService
RunService.Heartbeat:Connect(function()
    if fallenESPEnabled then
        updateFallenESP()
    end
end)
 
-- =========================
-- ตัวแปรหลัก
-- =========================
local Players = game:GetService("Players")
local player = Players.LocalPlayer
 
local currentSettings = {
    Speed = 1500,
    JumpCap = 1,
    AirStrafeAcceleration = 187
}
 
-- =========================
-- ฟังก์ชันค้นหา Table
-- =========================
local requiredFields = {
    Friction=true, AirStrafeAcceleration=true, JumpHeight=true, RunDeaccel=true,
    JumpSpeedMultiplier=true, JumpCap=true, SprintCap=true, WalkSpeedMultiplier=true,
    BhopEnabled=true, Speed=true, AirAcceleration=true, RunAccel=true, SprintAcceleration=true
}
 
local function getMatchingTables()
    local matched = {}
    for _, obj in pairs(getgc(true)) do
        if typeof(obj) == "table" then
            local ok = true
            for field in pairs(requiredFields) do
                if rawget(obj, field) == nil then ok = false break end
            end
            if ok then
                table.insert(matched, obj)
            end
        end
    end
    return matched
end
 
-- =========================
-- Apply ค่า
-- =========================
local function applyToTables()
    local tables = getMatchingTables()
    for _, tbl in ipairs(tables) do
        pcall(function()
            tbl.Speed = currentSettings.Speed
            tbl.JumpCap = currentSettings.JumpCap
            tbl.AirStrafeAcceleration = currentSettings.AirStrafeAcceleration
        end)
    end
end
 
-- =========================
-- Slider (ปรับ Max แล้ว)
-- =========================
 
-- Speed
SettingsTab:CreateSlider({
    Name = "Speed",
    Range = {1450, 5000},
    Increment = 10,
    CurrentValue = currentSettings.Speed,
    Callback = function(val)
        currentSettings.Speed = val
        applyToTables()
    end
})
 
-- JumpCap
SettingsTab:CreateSlider({
    Name = "Jump Cap",
    Range = {0.1, 5000},
    Increment = 0.1,
    CurrentValue = currentSettings.JumpCap,
    Callback = function(val)
        currentSettings.JumpCap = val
        applyToTables()
    end
})
 
-- Strafe Acceleration
SettingsTab:CreateSlider({
    Name = "Strafe Acceleration",
    Range = {200, 1000},
    Increment = 10,
    CurrentValue = currentSettings.AirStrafeAcceleration,
    Callback = function(val)
        currentSettings.AirStrafeAcceleration = val
        applyToTables()
    end
})
 
-- =========================
-- Dropdown Apply Method
-- =========================
getgenv().ApplyMode = "Not Optimized"
 
SettingsTab:CreateDropdown({
    Name = "Apply Method",
    Options = {"Not Optimized", "Optimized"},
    CurrentOption = "Not Optimized",
    MultipleOptions = false,
    Callback = function(option)
        getgenv().ApplyMode = option
    end
})
 
-- =========================
-- Apply ตอนเกิดใหม่
-- =========================
player.CharacterAdded:Connect(function()
    task.wait(1)
    applyToTables()
end)
 
 
 
-- =========================
-- วาปหนีบอท (Toggle)
-- =========================
local warpBotActive = false
local warpBotConnection = nil
 
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
 
-- ฟังก์ชันหลัก
local function warpBotLoop()
	if warpBotConnection then return end
	warpBotConnection = RunService.Heartbeat:Connect(function()
		if not warpBotActive then return end
		local char = LocalPlayer.Character
		if not char then return end
		local root = char:FindFirstChild("HumanoidRootPart")
		if not root then return end
 
		local folder = Workspace:FindFirstChild("Game") and Workspace.Game:FindFirstChild("Players")
		if folder then
			for _, npc in ipairs(folder:GetChildren()) do
				if npc:GetAttribute("Team") == "Nextbot" then
					local npcPart = npc:FindFirstChild("Root") or npc:FindFirstChild("HumanoidRootPart")
					if npcPart and (npcPart.Position - root.Position).Magnitude <= 10 then
						local targetPlayer = nil
						local maxY = -math.huge
						for _, plr in ipairs(Players:GetPlayers()) do
							if plr ~= LocalPlayer and plr.Character then
								local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
								if hrp and hrp.Position.Y > maxY then
									maxY = hrp.Position.Y
									targetPlayer = hrp
								end
							end
						end
						if targetPlayer then
							root.CFrame = targetPlayer.CFrame + Vector3.new(0,2,0)
						end
					end
				end
			end
		end
	end)
end
 
-- ฟังก์ชันปิดระบบ
local function stopWarpBot()
	if warpBotConnection then
		warpBotConnection:Disconnect()
		warpBotConnection = nil
	end
end
 
-- =========================
-- ปุ่ม Toggle ใน ExtraTab
-- =========================
ExtraTab:CreateToggle({
	Name = "วาปหนีบอท",
	CurrentValue = false,
	Callback = function(state)
		warpBotActive = state
		if state then
			warpBotLoop()
		else
			stopWarpBot()
		end
	end
})
 
ExtraTab:CreateButton({
    Name = "เปลี่ยนเป็นกลางวัน",
    Callback = function()
        game:GetService("Lighting").ClockTime = 12
    end
})
 
ExtraTab:CreateButton({
    Name = "เปลี่ยนเป็นกลางคืน",
    Callback = function()
        game:GetService("Lighting").ClockTime = 22
    end
})
 
-- =============================
-- ของเสริม : Korblox / Headless (Rayfield Version)
-- =============================
 
local Players = game:GetService("Players")
local player = Players.LocalPlayer
 
-- สถานะ
local extraStatus = {
    Korblox = false,
    Headless = false,
}
 
local applying = false
 
-- ฟังก์ชันใช้ของเสริม
local function applyBodyMod()
    if applying then return end
    applying = true
 
    getgenv().Setting = {
        ["Body"] = {
            ["Korblox"] = extraStatus.Korblox,
            ["Headless"] = extraStatus.Headless,
        },
    }
 
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/khen791/script-khen/refs/heads/main/KorbloxAndHeadless.txt"))()
    end)
 
    task.wait(0.5)
    applying = false
end
 
-- =============================
-- ติดตอนเกิดใหม่ (กันหาย)
-- =============================
player.CharacterAdded:Connect(function(char)
    task.wait(1.2) -- รอโหลดตัวละคร
    applyBodyMod()
end)
 
-- =============================
-- Toggle Korblox
-- =============================
ExtraTab:CreateToggle({
    Name = "ขากุด (Korblox)",
    CurrentValue = false,
    Callback = function(state)
        extraStatus.Korblox = state
        applyBodyMod()
    end
})
 
-- =============================
-- Toggle Headless
-- =============================
ExtraTab:CreateToggle({
    Name = "หัวล่องหน (Headless)",
    CurrentValue = false,
    Callback = function(state)
        extraStatus.Headless = state
        applyBodyMod()
    end
})
 
-- =========================
-- ปุ่มลบความมืด / เพิ่มแสง
-- =========================
ExtraTab:CreateButton({
    Name = "ลบมืดออก",
    Callback = function()
        local Lighting = game:GetService("Lighting")
 
        -- ปรับแสงให้สว่าง
        Lighting.Ambient = Color3.new(1,1,1)
        Lighting.OutdoorAmbient = Color3.new(1,1,1)
        Lighting.Brightness = 3
        Lighting.ExposureCompensation = 1
 
        -- ปิด Shadow
        Lighting.GlobalShadows = false
 
        -- ลบเอฟเฟกต์มืดทั้งหมด
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("ColorCorrectionEffect")
            or v:IsA("DepthOfFieldEffect")
            or v:IsA("BloomEffect")
            or v:IsA("SunRaysEffect")
            or v:IsA("Atmosphere")
            or v:IsA("Sky") then
                v:Destroy()
            end
        end
 
        print("Map สว่างขึ้นแล้วสัส") -- แจ้งเตือนใน Output
    end
})
 
-- =========================
-- TOGGLE รัน Emote Script (Rayfield)
-- =========================
local emoteScriptLoaded = false
 
ExtraTab:CreateToggle({
    Name = "เปิดแฟ้มอีโมท(เสกท่า)",
    CurrentValue = false,
    Callback = function(state)
        if state then
            -- เปิด
            if not emoteScriptLoaded then
                local url = "https://pastebin.com/raw/QmVcFD9B"
 
                local success, err = pcall(function()
                    loadstring(game:HttpGet(url))()
                end)
 
                if success then
                    emoteScriptLoaded = true
                    print("โหลด Emote Script แล้วสัส")
                else
                    warn("รันไม่ได้: "..tostring(err))
                end
            else
                print("สคริปมันโหลดไปแล้วนะสัส")
            end
        else
            -- ปิด (ทำได้แค่แจ้งเตือน เพราะ Pastebin ส่วนใหญ่ปิดไม่ได้)
            print("ปิดไม่ได้จริง แค่หยุดใช้เฉยๆสัส")
        end
    end
})
 
 
-- =========================
-- ลบ/คืนค่า Barrier & MapBarrier (MainTab)
-- =========================
 
local workspace = game:GetService("Workspace")
 
local hiddenParts = {}
local deleteToggle = false
 
-- หา Part ทั้งแมพ
local function findParts()
    local found = {}
 
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name == "Barrier" or obj.Name == "MapBarrier") then
            table.insert(found, obj)
        end
    end
 
    return found
end
 
-- ลบทั้งหมด
local function deleteAll()
    for _, part in ipairs(findParts()) do
        if part and part.Parent and not hiddenParts[part] then
            hiddenParts[part] = {
                Parent = part.Parent,
                CFrame = part.CFrame,
                Transparency = part.Transparency,
                CanCollide = part.CanCollide
            }
 
            part.Parent = nil
        end
    end
end
 
-- คืนค่าทั้งหมด
local function restoreAll()
    for part, data in pairs(hiddenParts) do
        if part then
            pcall(function()
                part.Parent = data.Parent
                part.CFrame = data.CFrame
                part.Transparency = data.Transparency
                part.CanCollide = data.CanCollide
            end)
        end
    end
 
    hiddenParts = {}
end
 
-- =========================
-- TOGGLE (MainTab)
-- =========================
MainTab:CreateToggle({
    Name = "ลบ/คืนค่า Barrier",
    CurrentValue = false,
    Callback = function(state)
        deleteToggle = state
 
        if state then
            deleteAll()
            print("ลบ Barrier หมดแล้วสัส")
        else
            restoreAll()
            print("คืนค่า Barrier แล้วสัส")
        end
    end
})
 
-- =========================
-- พื้นใส (Reflectance Toggle) - เข้ากับสไตล์ของมึง
-- =========================
local floorReflectOn = false
local originalParts = {}
 
local function enableFloorReflect()
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") then
			-- เก็บค่าเดิม
			if not originalParts[obj] then
				originalParts[obj] = {
					Material = obj.Material,
					Reflectance = obj.Reflectance
				}
			end
			obj.Material = Enum.Material.SmoothPlastic
			obj.Reflectance = 0.3
		end
	end
end
 
local function disableFloorReflect()
	for obj, data in pairs(originalParts) do
		if obj and obj.Parent then
			obj.Material = data.Material
			obj.Reflectance = data.Reflectance
		end
	end
	originalParts = {}
end
 
-- =========================
-- Toggle ใน ExtraTab
-- =========================
ExtraTab:CreateToggle({
	Name = "พื้นใส",
	CurrentValue = false,
	Callback = function(state)
		floorReflectOn = state
		if state then
			enableFloorReflect()
			print("เปิดพื้นใสแล้วสัส")
		else
			disableFloorReflect()
			print("ปิดพื้นใสแล้วสัส")
		end
	end
})
