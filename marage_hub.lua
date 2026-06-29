-- ตั้งค่าตัวแปรภาษาเริ่มต้น (ถ้าไม่มีการตั้งค่าไว้ล่วงหน้า จะเป็นภาษาไทย "TH")
if not getgenv().MARAGE_Lang then
    getgenv().MARAGE_Lang = "TH"
end
local lang = getgenv().MARAGE_Lang

-- โหลด Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
 
-- Main Window (ปรับดีไซน์ชื่อเป็นเวอร์ชัน Beta มีวงเล็บตามสั่ง)
local Window = Rayfield:CreateWindow({
    Name = "MARAGE Hub (Beta)",
    LoadingTitle = "Loading MARAGE Hub (Beta)...",
    LoadingSubtitle = lang == "TH" and "โดย MARAGE" or "by MARAGE",
    Theme = "Ocean",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "MARAGE",
        FileName = "Config"
    }
})
 
-- Tabs (ระบบแปลภาษาหัวข้อเมนู)
local SettingsTab = Window:CreateTab(lang == "TH" and "ตั้งค่า" or "Settings")
local MainTab     = Window:CreateTab(lang == "TH" and "เมนูหลัก" or "Main Menu")
local TeleportTab = Window:CreateTab(lang == "TH" and "เทเลพอร์ต" or "Teleport")
local VisualsTab  = Window:CreateTab(lang == "TH" and "มองต่างๆ" or "Visuals")
local ExtraTab    = Window:CreateTab(lang == "TH" and "ของเสริม" or "Extras")
local FPSTab      = Window:CreateTab(lang == "TH" and "FPS" or "FPS")
local EventTab    = Window:CreateTab(lang == "TH" and "เกี่ยวกับอีเว้น" or "Events")
local MapTab      = Window:CreateTab(lang == "TH" and "เเพ" or "Maps")
 
-- =========================
-- ระบบเปลี่ยนภาษา (Language Settings)
-- =========================
SettingsTab:CreateDropdown({
    Name = lang == "TH" and "เปลี่ยนภาษา (Language)" or "Change Language",
    Options = {"ภาษาไทย (Thai)", "English"},
    CurrentOption = lang == "TH" and "ภาษาไทย (Thai)" or "English",
    MultipleOptions = false,
    Callback = function(option)
        local chosen = "TH"
        if option == "English" then chosen = "EN" end
        
        if chosen ~= getgenv().MARAGE_Lang then
            getgenv().MARAGE_Lang = chosen
            Rayfield:Notify({
                Title = chosen == "TH" and "เปลี่ยนภาษาสำเร็จ" or "Language Changed",
                Content = chosen == "TH" and "กรุณารันสคริปต์ใหม่อีกครั้งเพื่อเปลี่ยนเป็นภาษาไทย" or "Please re-execute the script to apply English.",
                Duration = 5
            })
        end
    end
})

---

-- Auto Bhop
local autoBhop = false
local floatingBhopButton
local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer
 
-- สร้าง FloatingGui สำหรับจัดการปุ่มลอยทั้งหมด
local FloatingGui = game:GetService("CoreGui"):FindFirstChild("FloatingGui")
if not FloatingGui then
    FloatingGui = Instance.new("ScreenGui")
    FloatingGui.Name = "FloatingGui"
    FloatingGui.ResetOnSpawn = false
    FloatingGui.Parent = game:GetService("CoreGui")
end
 
-- ฟังก์ชันดีไซน์ปุ่มลอยแบบใหม่ (Sleek Dark Neon)
local function styleFloatingButton(btn, text, defaultColor)
    btn.Size = UDim2.new(0, 145, 0, 50)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
    btn.BackgroundTransparency = 0.2
    btn.TextColor3 = defaultColor or Color3.fromRGB(255, 255, 255)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.Active = true
    btn.Draggable = true
 
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 12)
 
    local stroke = Instance.new("UIStroke", btn)
    stroke.Thickness = 2
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Color = Color3.fromRGB(0, 180, 255)
 
    return stroke
end

-- อนิเมชั่นขอบไฟวิ่งสำหรับปุ่มทั่วไป
local function animateStroke(stroke, color1, color2)
    task.spawn(function()
        while stroke and stroke.Parent do
            TweenService:Create(stroke, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Color = color1}):Play()
            task.wait(1)
            TweenService:Create(stroke, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Color = color2}):Play()
            task.wait(1)
        end
    end)
end
 
-- ปุ่มลอย Auto Bhop
local function createBhopFloatingButton()
    if floatingBhopButton then return end
 
    local btn = Instance.new("TextButton")  
    btn.Position = UDim2.new(0.3, -70, 0.8, 0)  
    btn.AnchorPoint = Vector2.new(0.5, 0)  
    btn.Parent = FloatingGui  
    
    local function getBhopText()
        if lang == "TH" then
            return autoBhop and "Auto Bhop: เปิด" or "Auto Bhop: ปิด"
        else
            return autoBhop and "Auto Bhop: ON" or "Auto Bhop: OFF"
        end
    end

    local stroke = styleFloatingButton(btn, getBhopText())
    animateStroke(stroke, Color3.fromRGB(0, 120, 255), Color3.fromRGB(0, 255, 200))
 
    btn.MouseButton1Click:Connect(function()  
        autoBhop = not autoBhop  
        btn.Text = getBhopText()
        btn.TextColor3 = autoBhop and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(255, 255, 255)
    end)  
 
    floatingBhopButton = btn
end
 
local function removeBhopFloatingButton()
    if floatingBhopButton then
        floatingBhopButton:Destroy()
        floatingBhopButton = nil
    end
end
 
-- Toggle ปกติ Auto Jump
MainTab:CreateToggle({
    Name = lang == "TH" and "กระโดดอัตโนมัติ" or "Auto Jump",
    CurrentValue = false,
    Callback = function(state)
        autoBhop = state
    end
})
 
-- Toggle ปุ่มลอย Auto Jump
MainTab:CreateToggle({
    Name = lang == "TH" and "กระโดดอัตโนมัติ (ปุ่มลอย)" or "Auto Jump (Floating Button)",
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
                local result = workspace:Raycast(root.Position, Vector3.new(0, -rayDistance, 0), rayParams)  
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
            local _ = math.random()
        end
    end
end
 
-- ปุ่มใน Tab Lag Switch
MainTab:CreateButton({
    Name = lang == "TH" and "แลคสวิตช์ (ปกติ)" or "Lag Switch (Normal)",
    Callback = function()
        lagSwitch(0.5)
    end
})
 
-- ปุ่มลอย Lag Switch
local function createLagFloatingButton()
    if floatingLagButton then return end
 
    local btn = Instance.new("TextButton")  
    btn.Position = UDim2.new(0.7, -70, 0.8, 0)  
    btn.AnchorPoint = Vector2.new(0.5, 0)  
    btn.Parent = FloatingGui  
 
    local stroke = styleFloatingButton(btn, lang == "TH" and "แลคสวิตช์" or "Lag Switch")
    animateStroke(stroke, Color3.fromRGB(255, 50, 50), Color3.fromRGB(255, 150, 0))
 
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
 
-- Toggle ปุ่มลอย Lag Switch
MainTab:CreateToggle({
    Name = lang == "TH" and "แลคสวิตช์ (ปุ่มลอย)" or "Lag Switch (Floating Button)",
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
-- Auto Bounce
-- =========================  
local autoBounce = false  
local floatingBounceButton  
local bouncePower = 150 
local groundCheckDistance = 6 
 
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
 
-- Toggle ปกติ Auto Bounce
MainTab:CreateToggle({  
    Name= lang == "TH" and "ออโต้เด้ง (ปกติ)" or "Auto Bounce (Normal)",  
    CurrentValue=false,  
    Callback=function(state) autoBounce = state end  
})  
 
-- Slider ปรับความสูงการเด้ง
MainTab:CreateSlider({  
    Name = lang == "TH" and "ปรับความสูงการเด้ง" or "Adjust Bounce Height",  
    Range = {50, 300},  
    Increment = 5,  
    Suffix = "studs",  
    CurrentValue = bouncePower,  
    Callback = function(value)  
        bouncePower = value  
    end  
})  
 
-- ปุ่มลอย Auto Bounce
local function createBounceFloatingButton()
    if floatingBounceButton then return end
 
    local btn = Instance.new("TextButton")
    btn.Position = UDim2.new(0.5, -70, 0.85, 0)
    btn.AnchorPoint = Vector2.new(0.5, 0)
    btn.Parent = FloatingGui
 
    local function getBounceText()
        if lang == "TH" then
            return autoBounce and "ออโต้เด้ง: เปิด" or "ออโต้เด้ง: ปิด"
        else
            return autoBounce and "Auto Bounce: ON" or "Auto Bounce: OFF"
        end
    end

    local stroke = styleFloatingButton(btn, getBounceText())
    animateStroke(stroke, Color3.fromRGB(0, 255, 150), Color3.fromRGB(0, 150, 255))
 
    btn.MouseButton1Click:Connect(function()
        autoBounce = not autoBounce
        btn.Text = getBounceText()
        btn.TextColor3 = autoBounce and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(255, 255, 255)
    end)
 
    floatingBounceButton = btn
end
 
local function removeBounceFloatingButton()
    if floatingBounceButton then
        floatingBounceButton:Destroy()
        floatingBounceButton = nil
    end
end
 
-- Toggle ปุ่มลอย Auto Bounce
MainTab:CreateToggle({
    Name = lang == "TH" and "ออโต้เด้ง (ปุ่มลอย)" or "Auto Bounce (Floating Button)",
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
-- Auto Respawn (Fake Revive)
-- =========================
getgenv().AutoRespawnEnabled = false
local autoRespawnMethod = "Fake Revive"
local lastSavedPosition
local floatingRespawnButton
 
-- ฟังก์ชันสร้างปุ่มลอย รีสปอน
local function createRespawnFloatingButton()
    if floatingRespawnButton then return end
 
    local btn = Instance.new("TextButton")
    btn.Position = UDim2.new(0.7, -70, 0.85, 0)
    btn.AnchorPoint = Vector2.new(0.5, 0)
    btn.Parent = FloatingGui
    btn.ZIndex = 10
 
    local function getRespawnText()
        if lang == "TH" then
            return getgenv().AutoRespawnEnabled and "รีสปอน: เปิด" or "รีสปอน: ปิด"
        else
            return getgenv().AutoRespawnEnabled and "Respawn: ON" or "Respawn: OFF"
        end
    end

    local stroke = styleFloatingButton(btn, getRespawnText(), Color3.fromRGB(255, 100, 100))
    animateStroke(stroke, Color3.fromRGB(255, 50, 50), Color3.fromRGB(255, 100, 200))
 
    btn.MouseButton1Click:Connect(function()
        getgenv().AutoRespawnEnabled = not getgenv().AutoRespawnEnabled
        btn.Text = getRespawnText()
        btn.TextColor3 = getgenv().AutoRespawnEnabled and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
    end)
 
    floatingRespawnButton = btn
end
 
local function removeRespawnFloatingButton()
    if floatingRespawnButton then
        floatingRespawnButton:Destroy()
        floatingRespawnButton = nil
    end
end
 
-- ฟังก์ชันตั้งค่า Auto Revive
local function setupAutoRevive(character)
    task.defer(function()
        character:WaitForChild("HumanoidRootPart", 5)
        character:WaitForChild("Humanoid", 5)
 
        task.spawn(function()
            while character and character.Parent do
                local hrp = character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    character:SetAttribute("LastPosition", hrp.Position)
                end
                task.wait(0.2)
            end
        end)
 
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
                    game:GetService("ReplicatedStorage"):WaitForChild("Events", 9e9)
                        :WaitForChild("Player", 9e9)
                        :WaitForChild("ChangePlayerMode", 9e9)
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
 
if player.Character then setupAutoRevive(player.Character) end
player.CharacterAdded:Connect(setupAutoRevive)
 
MainTab:CreateToggle({
    Name = lang == "TH" and "ออโต้รีสปอน (ปกติ)" or "Auto Respawn (Normal)",
    CurrentValue = false,
    Callback = function(state)
        getgenv().AutoRespawnEnabled = state
    end
})
 
MainTab:CreateDropdown({
    Name = lang == "TH" and "วิธีรีสปอน" or "Respawn Method",
    Options = {"Random", "Fake Revive"},
    CurrentOption = autoRespawnMethod,
    MultipleOptions = false,
    Callback = function(option)
        autoRespawnMethod = option
    end
})
 
MainTab:CreateToggle({
    Name = lang == "TH" and "ออโต้รีสปอน (ปุ่มลอย)" or "Auto Respawn (Floating Button)",
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
-- Warp Up
-- =========================
TeleportTab:CreateButton({
    Name = lang == "TH" and "วาร์ปขึ้นบน" or "Warp Up",
    Callback = function()
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(0, 1200, 0)
        end
    end
})
 
local floatingWarpButton
 
local function createWarpFloatingButton()
    if floatingWarpButton then return end
 
    local btn = Instance.new("TextButton")
    btn.Position = UDim2.new(0.5, -70, 0.7, 0)
    btn.AnchorPoint = Vector2.new(0.5, 0)
    btn.Parent = FloatingGui
 
    local stroke = styleFloatingButton(btn, lang == "TH" and "วาร์ปขึ้นบน" or "Warp Up")
    animateStroke(stroke, Color3.fromRGB(200, 0, 255), Color3.fromRGB(0, 150, 255))
 
    btn.MouseButton1Click:Connect(function()
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = char.HumanoidRootPart.CFrame + Vector3.new(0, 1200, 0)
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
 
TeleportTab:CreateToggle({
    Name = lang == "TH" and "วาร์ปขึ้นบน (Floating Button)" or "Warp Up (Floating Button)",
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
-- Auto Farm Money
-- =========================
local autoFarm = false
local farmPart
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer
 
local function createPart()
    if farmPart then return end
    farmPart = Instance.new("Part")
    farmPart.Size = Vector3.new(10, 1, 10)
    farmPart.Anchored = true
    farmPart.Position = Vector3.new(0, 1200, 0)
    farmPart.Name = "FarmPart"
    farmPart.Parent = workspace
end
 
RunService.Heartbeat:Connect(function()
    if autoFarm then
        createPart()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = farmPart.CFrame + Vector3.new(0, 3, 0)
        end
    end
end)
 
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    if autoFarm and farmPart then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = farmPart.CFrame + Vector3.new(0, 3, 0)
        end
    end
end)
 
LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)
 
TeleportTab:CreateToggle({
    Name = lang == "TH" and "ออโต้ฟาร์มเงิน" or "Auto Farm Money",
    CurrentValue = false,
    Callback = function(state)
        autoFarm = state
    end
})
 
-- =========================
-- วาร์ปไปคนล้มแล้วเด้งกลับ
-- =========================
local function teleportToDowned()
    local myChar = LocalPlayer.Character
    if not (myChar and myChar:FindFirstChild("HumanoidRootPart")) then return end
 
    local myRoot = myChar.HumanoidRootPart
    local oldCFrame = myRoot.CFrame 
 
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local hum = plr.Character:FindFirstChild("Humanoid")
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
 
            if hum and root and hum.Health <= 0 then
                myRoot.CFrame = root.CFrame + Vector3.new(0, 3, 0) 
                task.delay(1, function()
                    if myRoot then myRoot.CFrame = oldCFrame end
                end)
                return
            end
        end
    end
end
 
TeleportTab:CreateButton({
    Name = lang == "TH" and "วาร์ปไปยังผู้เล่นที่ล้ม" or "Warp to Downed Player",
    Callback = function()
        teleportToDowned()
    end
})
 
local floatingDownedWarpButton
 
local function createDownedWarpFloatingButton()
    if floatingDownedWarpButton then return end
 
    local btn = Instance.new("TextButton")
    btn.Position = UDim2.new(0.7, -70, 0.7, 0)
    btn.AnchorPoint = Vector2.new(0.5, 0)
    btn.Parent = FloatingGui
 
    local stroke = styleFloatingButton(btn, lang == "TH" and "วาร์ปไปผู้เล่นล้ม" or "Warp to Downed")
    animateStroke(stroke, Color3.fromRGB(0, 255, 200), Color3.fromRGB(0, 100, 255))
 
    btn.MouseButton1Click:Connect(function()
        teleportToDowned()
    end)
 
    floatingDownedWarpButton = btn
end
 
local function removeDownedWarpFloatingButton()
    if floatingDownedWarpButton then
        floatingDownedWarpButton:Destroy()
        floatingDownedWarpButton = nil
    end
end
 
TeleportTab:CreateToggle({
    Name = lang == "TH" and "วาร์ปหาคนล้ม (Floating)" or "Warp to Downed (Floating)",
    CurrentValue = false,
    Callback = function(state)
        if state then
            createDownedWarpFloatingButton()
        else
            removeDownedWarpFloatingButton()
        end
    end
})
 
-- =========================
-- ESP Player
-- =========================
local ESPTable = {}
 
local function addESP(plr)
    if ESPTable[plr] or not plr.Character then return end
    local char = plr.Character
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
 
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Billboard"
    billboard.Adornee = root
    billboard.Size = UDim2.new(0, 100, 0, 50)
    billboard.AlwaysOnTop = true
    billboard.Parent = char
 
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.fromRGB(0, 150, 255)
    textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    textLabel.TextStrokeTransparency = 0
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextScaled = true
    textLabel.Text = plr.Name
    textLabel.Parent = billboard
 
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_Highlight"
    highlight.Adornee = char
    highlight.FillTransparency = 1
    highlight.OutlineTransparency = 0
    highlight.OutlineColor = Color3.fromRGB(0, 150, 255)
    highlight.Parent = char
 
    ESPTable[plr] = {Billboard = billboard, Highlight = highlight}
end
 
local function removeESP(plr)
    if ESPTable[plr] then
        local data = ESPTable[plr]
        if data.Billboard then data.Billboard:Destroy() end
        if data.Highlight then data.Highlight:Destroy() end
        ESPTable[plr] = nil
    end
end
 
local function updateESP()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            if not ESPTable[plr] then addESP(plr) end
        end
    end
    for plr, _ in pairs(ESPTable) do
        if not Players:FindFirstChild(plr.Name) then removeESP(plr) end
    end
end
 
local ESPEnabled = false
 
VisualsTab:CreateToggle({
    Name = lang == "TH" and "มองหาผู้เล่น" or "Player ESP",
    CurrentValue = false,
    Callback = function(state)
        ESPEnabled = state
        if not state then
            for plr, _ in pairs(ESPTable) do removeESP(plr) end
        else
            updateESP()
        end
    end
})
 
RunService.Heartbeat:Connect(function()
    if ESPEnabled then updateESP() end
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
                                billboard.Size = UDim2.new(0, 180, 0, 25)
                                billboard.StudsOffset = Vector3.new(0, 3.2, 0)
                                billboard.AlwaysOnTop = true
                                billboard.Parent = part
 
                                local label = Instance.new("TextLabel")
                                label.Name = "Label"
                                label.Size = UDim2.new(1, 0, 1, 0)
                                label.BackgroundTransparency = 1
                                label.TextScaled = true
                                label.TextColor3 = Color3.fromRGB(255, 50, 50)
                                label.Font = Enum.Font.GothamSemibold
                                label.Parent = billboard
                            end
                            local label = billboard:FindFirstChild("Label")
                            if label then
                                local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                local dist = hrp and (part.Position - hrp.Position).Magnitude
                                label.Text = dist and npc.Name.." ("..math.floor(dist)..")" or npc.Name
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
 
VisualsTab:CreateToggle({
    Name = lang == "TH" and "มองเน็กบอท" or "Nextbot ESP",
    CurrentValue = false,
    Callback = function(state)
        nextbotESPEnabled = state
        if state then startNextbotESP() else removeNextbotESP() end
    end
})
 
local function createNextbotFloating()
    if floatingNextbotButton then return end
    local btn = Instance.new("TextButton")
    btn.Position = UDim2.new(0.5, 0, 0.6, 0)
    btn.Parent = FloatingGui
 
    local function getNextbotText()
        if lang == "TH" then
            return nextbotESPEnabled and "เน็กบอท: เปิด" or "เน็กบอท: ปิด"
        else
            return nextbotESPEnabled and "Nextbot: ON" or "Nextbot: OFF"
        end
    end

    local stroke = styleFloatingButton(btn, getNextbotText())
    animateStroke(stroke, Color3.fromRGB(255, 0, 50), Color3.fromRGB(255, 150, 0))
 
    btn.MouseButton1Click:Connect(function()
        nextbotESPEnabled = not nextbotESPEnabled
        btn.Text = getNextbotText()
        btn.TextColor3 = nextbotESPEnabled and Color3.fromRGB(255, 50, 50) or Color3.fromRGB(255, 255, 255)
        if nextbotESPEnabled then startNextbotESP() else removeNextbotESP() end
    end)
    floatingNextbotButton = btn
end
 
VisualsTab:CreateToggle({
    Name = lang == "TH" and "ESP Nextbot (Floating)" or "Nextbot ESP (Floating)",
    CurrentValue = false,
    Callback = function(state)
        if state then createNextbotFloating() else if floatingNextbotButton then floatingNextbotButton:Destroy() floatingNextbotButton = nil end end
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
    billboard.Size = UDim2.new(0, 180, 0, 25)
    billboard.StudsOffset = Vector3.new(0, 3.2, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = part
 
    local label = Instance.new("TextLabel")
    label.Name = "Ticket"
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextStrokeTransparency = 0.25
    label.TextScaled = true
    label.Font = Enum.Font.GothamSemibold
    label.TextColor3 = Color3.fromRGB(255, 255, 150)
    label.Text = "Ticket"
    label.Parent = billboard
    return billboard
end
 
local function removeTicketESP()
    local folder = workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Effects") and workspace.Game.Effects:FindFirstChild("Tickets")
    if folder then
        for _, v in ipairs(folder:GetChildren()) do
            local part = v:FindFirstChildWhichIsA("BasePart")
            if part then local esp = part:FindFirstChild("TicketESP") if esp then esp:Destroy() end end
        end
    end
end
 
local function startTicketESP()
    if ticketESPThread then return end
    ticketESPThread = task.spawn(function()
        while ticketESPEnabled do
            local folder = workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Effects") and workspace.Game.Effects:FindFirstChild("Tickets")
            if folder then
                for _, v in ipairs(folder:GetChildren()) do
                    local part = v:FindFirstChildWhichIsA("BasePart")
                    if part then
                        local billboard = part:FindFirstChild("TicketESP") or createTicketESP(part)
                        local label = billboard:FindFirstChild("Ticket")
                        if label then
                            local dist = getDistance(part.Position)
                            label.Text = dist and v.Name.." ("..math.floor(dist)..")" or v.Name
                        end
                    end
                end
            end
            task.wait(0.5)
        end
        ticketESPThread = nil
    end)
end
 
EventTab:CreateToggle({
    Name = lang == "TH" and "มองตั๋ว (ESP Ticket)" or "Ticket ESP",
    CurrentValue = false,
    Callback = function(state)
        ticketESPEnabled = state
        if state then startTicketESP() else removeTicketESP() end
    end
})
 
local function createTicketFloating()
    if floatingTicketButton then return end
    local btn = Instance.new("TextButton")
    btn.Position = UDim2.new(0.3, 0, 0.5, 0)
    btn.Parent = FloatingGui
 
    local function getTicketText()
        if lang == "TH" then
            return ticketESPEnabled and "ตั๋ว: เปิด" or "ตั๋ว: ปิด"
        else
            return ticketESPEnabled and "Ticket ESP: ON" or "Ticket ESP: OFF"
        end
    end

    local stroke = styleFloatingButton(btn, getTicketText())
    animateStroke(stroke, Color3.fromRGB(255, 255, 0), Color3.fromRGB(0, 255, 100))
 
    btn.MouseButton1Click:Connect(function()
        ticketESPEnabled = not ticketESPEnabled
        btn.Text = getTicketText()
        btn.TextColor3 = ticketESPEnabled and Color3.fromRGB(255, 255, 100) or Color3.fromRGB(255, 255, 255)
        if ticketESPEnabled then startTicketESP() else removeTicketESP() end
    end)
    floatingTicketButton = btn
end
 
EventTab:CreateToggle({
    Name = lang == "TH" and "ESP Ticket (Floating)" or "Ticket ESP (Floating)",
    CurrentValue = false,
    Callback = function(state)
        if state then createTicketFloating() else if floatingTicketButton then floatingTicketButton:Destroy() floatingTicketButton = nil end end
    end
})
 
VisualsTab:CreateToggle({
    Name = lang == "TH" and "มองตั๋ว (ESP Ticket) " or "Ticket ESP ",
    CurrentValue = false,
    Callback = function(state)
        ticketESPEnabled = state
        if state then startTicketESP() else removeTicketESP() end
    end
})
 
-- =========================
-- Noclip
-- =========================
local noclipEnabled = false
local noclipConnection
 
local function startNoclip()
    if noclipConnection then return end
    noclipConnection = game:GetService("RunService").Stepped:Connect(function()
        if noclipEnabled then
            local char = LocalPlayer.Character
            if char then
                for _, v in pairs(char:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end
            end
        end
    end)
end
 
local function stopNoclip()
    if noclipConnection then noclipConnection:Disconnect() noclipConnection = nil end
    local char = LocalPlayer.Character
    if char then
        for _, v in pairs(char:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = true end end
    end
end
 
ExtraTab:CreateToggle({
    Name = lang == "TH" and "ทะลุกำแพง" or "Noclip",
    CurrentValue = false,
    Callback = function(state)
        noclipEnabled = state
        if state then startNoclip() else stopNoclip() end
    end
})
 
-- =========================
-- Moon Mode
-- =========================
local moonEnabled = false
local moonGravity = 0.3 
local moonConnection
 
local function startMoon()
    if moonConnection then return end
    moonConnection = RunService.Heartbeat:Connect(function()
        if not moonEnabled then return end
        local char = LocalPlayer.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        if root.Velocity.Y < -1 then
            root.Velocity = Vector3.new(root.Velocity.X, root.Velocity.Y * moonGravity, root.Velocity.Z)
        end
    end)
end
 
local function stopMoon()
    if moonConnection then moonConnection:Disconnect() moonConnection = nil end
end
 
ExtraTab:CreateToggle({
    Name = lang == "TH" and "โหมดดวงจันทร์" or "Moon Mode",
    CurrentValue = false,
    Callback = function(state)
        moonEnabled = state
        if state then startMoon() else stopMoon() end
    end
})
 
ExtraTab:CreateInput({
    Name = lang == "TH" and "แรงโน้มถ่วง (ยิ่งน้อยยิ่งลอย)" or "Gravity (Lower = Floatier)",
    PlaceholderText = lang == "TH" and "เช่น 0.3" or "e.g. 0.3",
    RemoveTextAfterFocusLost = false,
    Callback = function(txt)
        local num = tonumber(txt)
        if num then moonGravity = math.clamp(num, 0, 1) end
    end
})
 
-- =========================
-- Map Spawner System
-- =========================
local currentMap = nil
 
local function spawnMap(assetId, height)
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
 
    if currentMap and currentMap.Parent then currentMap:Destroy() currentMap = nil end
 
    local success, model = pcall(function() return game:GetObjects("rbxassetid://" .. assetId)[1] end)
    if not success or not model then warn("โหลดแมพไม่สำเร็จ") return end
 
    model.Parent = workspace
    currentMap = model
    local cf = model:GetPivot()
    model:PivotTo(cf + Vector3.new(0, height, 0))
    task.wait(0.2)
    hrp.CFrame = model:GetPivot() * CFrame.new(0, 3, 0)
end
 
MapTab:CreateButton({ Name = "Map: Grow a Garden", Callback = function() spawnMap(105019154044298, 270) end })
MapTab:CreateButton({ Name = "Map: Brookhaven", Callback = function() spawnMap(108186045609746, 250) end })
MapTab:CreateButton({ Name = "Map: Free Fire", Callback = function() spawnMap(136952494452456, 250) end })
 
-- =========================
-- Warp to Most Still Player
-- =========================
local warpFloatingBtn = nil
 
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
                if vel < minVel then minVel = vel target = plr end
            end
        end
    end
    return target
end
 
local function warpToPlayer(player)
    if not player or not player.Character then return end
    local myChar = LocalPlayer.Character
    if not myChar then return end
    local myHRP = myChar:FindFirstChild("HumanoidRootPart")
    local targetHRP = player.Character:FindFirstChild("HumanoidRootPart")
    if myHRP and targetHRP then myHRP.CFrame = targetHRP.CFrame + Vector3.new(0, 3, 0) end
end
 
local function createWarpStillFloatingButton()
    if warpFloatingBtn then return end
    local btn = Instance.new("TextButton")
    btn.Position = UDim2.new(0.3, -70, 0.8, 0)
    btn.AnchorPoint = Vector2.new(0.5, 0)
    btn.Parent = FloatingGui
 
    local stroke = styleFloatingButton(btn, lang == "TH" and "วาร์ปผู้เล่นนิ่งสุด" or "Warp to Stillest Player")
    animateStroke(stroke, Color3.fromRGB(150, 0, 255), Color3.fromRGB(0, 255, 200))
 
    btn.MouseButton1Click:Connect(function()
        local target = getMostStillPlayer()
        if target then warpToPlayer(target) end
    end)
    warpFloatingBtn = btn
end
 
TeleportTab:CreateToggle({
    Name = lang == "TH" and "วาร์ปผู้เล่นนิ่งสุด" or "Warp to Most Still Player",
    CurrentValue = false,
    Callback = function(state)
        if state then local target = getMostStillPlayer() if target then warpToPlayer(target) end end
    end
})
 
TeleportTab:CreateToggle({
    Name = lang == "TH" and "วาร์ปผู้เล่นนิ่งสุด (ลอย)" or "Warp to Stillest Player (Floating)",
    CurrentValue = false,
    Callback = function(state)
        if state then createWarpStillFloatingButton() if warpFloatingBtn then warpFloatingBtn.Visible = true end else if warpFloatingBtn then warpFloatingBtn.Visible = false end end
    end
})
 
-- =========================
-- FPS Display
-- =========================
local fpsLabel = nil
local fpsEnabled = false
 
local function createFPSLabel()
    if fpsLabel then return end
    local screenGui = game:GetService("CoreGui"):FindFirstChild("ScreenGui") or Instance.new("ScreenGui", game:GetService("CoreGui"))
    fpsLabel = Instance.new("TextLabel")
    fpsLabel.Size = UDim2.new(0, 120, 0, 30)
    fpsLabel.Position = UDim2.new(0, 10, 0, 10)
    fpsLabel.BackgroundTransparency = 1
    fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
    fpsLabel.TextStrokeTransparency = 0.25
    fpsLabel.Font = Enum.Font.GothamBold
    fpsLabel.TextSize = 18
    fpsLabel.Text = "FPS: 0"
    fpsLabel.TextXAlignment = Enum.TextXAlignment.Left
    fpsLabel.Parent = screenGui
end
 
task.spawn(function()
    local lastTime = tick()
    local frameCount = 0
    game:GetService("RunService").RenderStepped:Connect(function() if fpsEnabled then frameCount += 1 end end)
    while true do
        task.wait(1)
        if fpsEnabled and fpsLabel then
            local now = tick()
            local delta = now - lastTime
            fpsLabel.Text = "FPS: "..math.floor(frameCount / delta + 0.5)
            frameCount = 0
            lastTime = now
        end
    end
end)
 
FPSTab:CreateToggle({
    Name = lang == "TH" and "เเสงดงFPS" or "Show FPS",
    CurrentValue = false,
    Callback = function(state)
        fpsEnabled = state
        if state then createFPSLabel() else if fpsLabel then fpsLabel:Destroy() fpsLabel = nil end end
    end
})
 
-- =========================
-- Click Teleport
-- =========================
local clickTPEnabled = false
local clickTPFloatingBtn = nil
local UserInputService = game:GetService("UserInputService")
local Mouse = LocalPlayer:GetMouse()
 
local function teleportToPosition(position)
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local raycast = workspace:Raycast(position + Vector3.new(0, 50, 0), Vector3.new(0, -200, 0))
    hrp.CFrame = CFrame.new(raycast and raycast.Position + Vector3.new(0, 3, 0) or position + Vector3.new(0, 3, 0))
end
 
UserInputService.InputBegan:Connect(function(input, processed)
    if not clickTPEnabled or processed then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        teleportToPosition(Mouse.Hit.Position)
    end
end)
 
local function createClickTPFloating()
    if clickTPFloatingBtn then return end
    local btn = Instance.new("TextButton")
    btn.Position = UDim2.new(0.5, 0, 0.75, 0)
    btn.AnchorPoint = Vector2.new(0.5, 0)
    btn.Parent = FloatingGui
 
    local function getClickTPText()
        if lang == "TH" then
            return clickTPEnabled and "คลิกวาร์ป: เปิด" or "คลิกวาร์ป: ปิด"
        else
            return clickTPEnabled and "Click TP: ON" or "Click TP: OFF"
        end
    end

    local stroke = styleFloatingButton(btn, getClickTPText())
    animateStroke(stroke, Color3.fromRGB(0, 150, 255), Color3.fromRGB(0, 255, 150))
 
    btn.MouseButton1Click:Connect(function()
        clickTPEnabled = not clickTPEnabled
        btn.Text = getClickTPText()
        btn.TextColor3 = clickTPEnabled and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(255, 255, 255)
    end)
    clickTPFloatingBtn = btn
end
 
TeleportTab:CreateToggle({ Name = lang == "TH" and "คลิก เทเลพอร์ต" or "Click Teleport", CurrentValue = false, Callback = function(state) clickTPEnabled = state end })
TeleportTab:CreateToggle({
    Name = lang == "TH" and "คลิก เทเลพอร์ต (ลอย)" or "Click Teleport (Floating)",
    CurrentValue = false,
    Callback = function(state)
        if state then createClickTPFloating() if clickTPFloatingBtn then clickTPFloatingBtn.Visible = true end else if clickTPFloatingBtn then clickTPFloatingBtn.Visible = false clickTPEnabled = false end end
    end
})
 
-- =========================
-- Low Graphics Mode
-- =========================
local lowGfxEnabled = false
local originalSettings = {}
local Lighting = game:GetService("Lighting")
local Terrain = workspace:FindFirstChildOfClass("Terrain")
 
local function saveOriginal()
    originalSettings.FogEnd = Lighting.FogEnd
    originalSettings.Brightness = Lighting.Brightness
    originalSettings.GlobalShadows = Lighting.GlobalShadows
end
 
local function enableLowGraphics()
    for _, v in pairs(Lighting:GetChildren()) do if v:IsA("PostEffect") or v:IsA("Atmosphere") or v:IsA("Sky") or v:IsA("BloomEffect") or v:IsA("SunRaysEffect") then v:Destroy() end end
    Lighting.FogEnd = 100000
    Lighting.GlobalShadows = false
    Lighting.Brightness = 1
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then obj.Material = Enum.Material.SmoothPlastic obj.Reflectance = 0 end
        if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") then obj.Enabled = false end
        if obj:IsA("Decal") or obj:IsA("Texture") then obj:Destroy() end
    end
    if Terrain then Terrain.WaterWaveSize = 0 Terrain.WaterWaveSpeed = 0 Terrain.WaterReflectance = 0 Terrain.WaterTransparency = 1 end
end
 
FPSTab:CreateToggle({
    Name = lang == "TH" and "ลดกราฟฟิก" or "Low Graphics Mode",
    CurrentValue = false,
    Callback = function(state)
        lowGfxEnabled = state
        if state then saveOriginal() enableLowGraphics() else if originalSettings.FogEnd then Lighting.FogEnd = originalSettings.FogEnd Lighting.Brightness = originalSettings.Brightness Lighting.GlobalShadows = originalSettings.GlobalShadows end end
    end
})
 
-- =========================
-- Dash Smooth
-- =========================
local dashEnabled = false
local dashSpeed = 80
local dashVelocity = nil
local floatingDashButton = nil
 
local function resetDash()
    dashEnabled = false
    if dashVelocity then dashVelocity:Destroy() dashVelocity = nil end
end
 
player.CharacterAdded:Connect(function() task.wait(0.3) resetDash() end)
 
local function startDash()
    if dashVelocity then return end
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end
 
    dashVelocity = Instance.new("BodyVelocity")
    dashVelocity.MaxForce = Vector3.new(999999, 0, 999999)
    dashVelocity.P = 1250
    dashVelocity.Parent = root
 
    task.spawn(function()
        while dashEnabled do
            local curChar = player.Character
            local curRoot = curChar and curChar:FindFirstChild("HumanoidRootPart")
            local cam = workspace.CurrentCamera
            if not curRoot or not cam then break end
            local dir = cam.CFrame.LookVector
            dir = Vector3.new(dir.X, 0, dir.Z)
            if dir.Magnitude > 0 then dir = dir.Unit end
            dashVelocity.Velocity = dir * dashSpeed
            task.wait(0.03)
        end
        resetDash()
    end)
end
 
SettingsTab:CreateToggle({ Name = lang == "TH" and "Dash Smooth" or "Dash Smooth", CurrentValue = false, Callback = function(state) dashEnabled = state if state then startDash() else resetDash() end end })
SettingsTab:CreateInput({ Name = lang == "TH" and "ความเร็วแดช" or "Dash Speed", PlaceholderText = lang == "TH" and "ค่าเริ่มต้น 80" or "Default 80", RemoveTextAfterFocusLost = false, Callback = function(txt) local num = tonumber(txt) if num then dashSpeed = num end end })
 
local function createDashFloatingButton()
    if floatingDashButton then return end
    local btn = Instance.new("TextButton")
    btn.Position = UDim2.new(0.5, -70, 0.75, 0)
    btn.AnchorPoint = Vector2.new(0.5, 0)
    btn.Parent = FloatingGui
 
    local function getDashText()
        if lang == "TH" then
            return dashEnabled and "แดช: เปิด" or "แดช: ปิด"
        else
            return dashEnabled and "Dash: ON" or "Dash: OFF"
        end
    end

    local stroke = styleFloatingButton(btn, getDashText())
    animateStroke(stroke, Color3.fromRGB(0, 150, 255), Color3.fromRGB(200, 0, 255))
 
    btn.MouseButton1Click:Connect(function()
        dashEnabled = not dashEnabled
        btn.Text = getDashText()
        btn.TextColor3 = dashEnabled and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(255, 255, 255)
        if dashEnabled then startDash() else resetDash() end
    end)
    floatingDashButton = btn
end
 
SettingsTab:CreateToggle({ Name = lang == "TH" and "ปุ่มลอยแดช" or "Dash Floating Button", CurrentValue = false, Callback = function(state) if state then createDashFloatingButton() else if floatingDashButton then floatingDashButton:Destroy() floatingDashButton = nil end end end })
 
-- =========================
-- Auto Carry
-- =========================
getgenv().autoCarryEnabled = false
getgenv().autoCarryConnection = nil
getgenv().floatingCarryButton = nil
local ReplicatedStorage = game:GetService("ReplicatedStorage")
 
local function startAutoCarry()
    if getgenv().autoCarryConnection then return end
    getgenv().autoCarryConnection = RunService.Heartbeat:Connect(function()
        if not getgenv().autoCarryEnabled then return end
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local otherHRP = plr.Character.HumanoidRootPart
                if (hrp.Position - otherHRP.Position).Magnitude <= 20 then
                    pcall(function() ReplicatedStorage.Events.Character.Interact:FireServer("Carry", nil, plr.Name) end)
                    task.wait(0.05)
                end
            end
        end
    end)
end
 
local function stopAutoCarry() if getgenv().autoCarryConnection then getgenv().autoCarryConnection:Disconnect() getgenv().autoCarryConnection = nil end end
player.CharacterAdded:Connect(function() task.wait(0.3) getgenv().autoCarryEnabled = false stopAutoCarry() end)
 
MainTab:CreateToggle({
    Name = lang == "TH" and "อุ้มอัตโนมัติ (Auto Carry)" or "Auto Carry",
    CurrentValue = false,
    Callback = function(state)
        getgenv().autoCarryEnabled = state
        if state then startAutoCarry() else stopAutoCarry() end
        if getgenv().floatingCarryButton then 
            if lang == "TH" then
                getgenv().floatingCarryButton.Text = state and "อุ้มอัตโนมัติ: เปิด" or "อุ้มอัตโนมัติ: ปิด"
            else
                getgenv().floatingCarryButton.Text = state and "Auto Carry: ON" or "Auto Carry: OFF"
            end
        end
    end
})
 
local function createCarryFloatingButton()
    if getgenv().floatingCarryButton then return end
    local btn = Instance.new("TextButton")
    btn.Position = UDim2.new(0.25, 0, 0.75, 0)
    btn.AnchorPoint = Vector2.new(0.5, 0)
    btn.Parent = FloatingGui
 
    local function getCarryText()
        if lang == "TH" then
            return getgenv().autoCarryEnabled and "อุ้มอัตโนมัติ: เปิด" or "อุ้มอัตโนมัติ: ปิด"
        else
            return getgenv().autoCarryEnabled and "Auto Carry: ON" or "Auto Carry: OFF"
        end
    end

    local stroke = styleFloatingButton(btn, getCarryText())
    animateStroke(stroke, Color3.fromRGB(0, 255, 150), Color3.fromRGB(0, 120, 255))
 
    btn.MouseButton1Click:Connect(function()
        getgenv().autoCarryEnabled = not getgenv().autoCarryEnabled
        if getgenv().autoCarryEnabled then startAutoCarry() else stopAutoCarry() end
        btn.Text = getCarryText()
        btn.TextColor3 = getgenv().autoCarryEnabled and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(255, 255, 255)
    end)
    getgenv().floatingCarryButton = btn
end
 
MainTab:CreateToggle({ Name = lang == "TH" and "ปุ่มลอยอุ้ม" or "Carry Floating Button", CurrentValue = false, Callback = function(state) if state then createCarryFloatingButton() else if getgenv().floatingCarryButton then getgenv().floatingCarryButton:Destroy() getgenv().floatingCarryButton = nil end end end })
 
FPSTab:CreateButton({ Name = lang == "TH" and "เพิ่มแสงหน้าจอ" or "Increase Brightness", Callback = function() Lighting.Brightness = (Lighting.Brightness or 2) + 1 end })
 
-- =========================
-- Infinite Slide
-- =========================
local infiniteSlideEnabled = false
local slideFrictionValue = -8
local cachedTables, plrModel, slideConnection, floatingSlideButton
local keys = {"Friction","AirStrafeAcceleration","JumpHeight","RunDeaccel","JumpSpeedMultiplier","JumpCap","SprintCap","WalkSpeedMultiplier","BhopEnabled","Speed","AirAcceleration","RunAccel","SprintAcceleration"}
 
local function hasAll(tbl) if type(tbl) ~= "table" then return false end for _, k in ipairs(keys) do if rawget(tbl, k) == nil then return false end end return true end
local function setFriction(value) if not cachedTables then return end for _, t in ipairs(cachedTables) do pcall(function() t.Friction = value end) end end
local function updatePlayerModel() local folder = workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Players") plrModel = folder and folder:FindFirstChild(player.Name) or nil end
 
local function onHeartbeat()
    if not plrModel then setFriction(5) return end
    local success, state = pcall(function() return plrModel:GetAttribute("State") end)
    if success and state then
        if state == "Slide" then pcall(function() plrModel:SetAttribute("State", "EmotingSlide") end)
        elseif state == "EmotingSlide" then setFriction(slideFrictionValue)
        else setFriction(5) end
    else setFriction(5) end
end
 
local function toggleInfiniteSlide()
    infiniteSlideEnabled = not infiniteSlideEnabled
    if slideConnection then slideConnection:Disconnect() slideConnection = nil end
    if infiniteSlideEnabled then
        cachedTables = {}
        for _, obj in ipairs(getgc(true)) do local s, r = pcall(function() if hasAll(obj) then return obj end end) if s and r then table.insert(cachedTables, r) end end
        updatePlayerModel()
        slideConnection = RunService.Heartbeat:Connect(onHeartbeat)
    else
        cachedTables = nil plrModel = nil setFriction(5)
    end
    if floatingSlideButton then
        if lang == "TH" then
            floatingSlideButton.Text = infiniteSlideEnabled and "สไลด์: เปิด" or "สไลด์: ปิด"
        else
            floatingSlideButton.Text = infiniteSlideEnabled and "Slide: ON" or "Slide: OFF"
        end
        floatingSlideButton.TextColor3 = infiniteSlideEnabled and Color3.fromRGB(0, 255, 150) or Color3.fromRGB(255, 255, 255)
    end
end
 
MainTab:CreateToggle({ Name = lang == "TH" and "อินฟีนีตี้สไลด์" or "Infinite Slide", CurrentValue = false, Callback = function() toggleInfiniteSlide() end })
 
local function createFloatingSlideButton()
    if floatingSlideButton then return end
    local btn = Instance.new("TextButton")
    btn.Position = UDim2.new(0.5, -70, 0.4, 0)
    btn.AnchorPoint = Vector2.new(0.5, 0)
    btn.Parent = FloatingGui
 
    local function getSlideText()
        if lang == "TH" then
            return infiniteSlideEnabled and "สไลด์: เปิด" or "สไลด์: ปิด"
        else
            return infiniteSlideEnabled and "Slide: ON" or "Slide: OFF"
        end
    end

    local stroke = styleFloatingButton(btn, getSlideText())
    animateStroke(stroke, Color3.fromRGB(0, 255, 150), Color3.fromRGB(0, 150, 255))
 
    btn.MouseButton1Click:Connect(toggleInfiniteSlide)
    floatingSlideButton = btn
end
 
MainTab:CreateButton({ Name = lang == "TH" and "ปุ่มลอย Infinite Slide" or "Infinite Slide Floating Button", Callback = createFloatingSlideButton })
 
-- =========================
-- มองหาผู้เล่นล้ม
-- =========================
local fallenESPEnabled = false
local fallenESPLabels = {}
 
local function clearFallenLabels() for _, lbl in pairs(fallenESPLabels) do if lbl and lbl.Parent then lbl:Destroy() end end fallenESPLabels = {} end
local function updateFallenESP()
    clearFallenLabels()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("Humanoid") then
            if plr.Character.Humanoid.Health <= 0 then
                local head = plr.Character:FindFirstChild("Head")
                if head then
                    local bill = Instance.new("BillboardGui", head)
                    bill.Size = UDim2.new(0, 100, 0, 50)
                    bill.AlwaysOnTop = true
                    local txt = Instance.new("TextLabel", bill)
                    txt.Size = UDim2.new(1, 0, 1, 0)
                    txt.BackgroundTransparency = 1
                    txt.TextColor3 = Color3.fromRGB(255, 0, 0)
                    txt.Font = Enum.Font.GothamBold
                    txt.TextScaled = true
                    txt.Text = lang == "TH" and "ล้ม" or "Downed"
                    table.insert(fallenESPLabels, bill)
                end
            end
        end
    end
end
 
VisualsTab:CreateToggle({ Name = lang == "TH" and "มองหาผู้เล่นล้ม" or "Fallen Player ESP", CurrentValue = false, Callback = function(state) fallenESPEnabled = state if not state then clearFallenLabels() end end })
RunService.Heartbeat:Connect(function() if fallenESPEnabled then updateFallenESP() end end)
 
-- =========================
-- Speed / JumpCap
-- =========================
local currentSettings = { Speed = 1500, JumpCap = 1, AirStrafeAcceleration = 187 }
local requiredFields = { Friction=true, AirStrafeAcceleration=true, JumpHeight=true, RunDeaccel=true, JumpSpeedMultiplier=true, JumpCap=true, SprintCap=true, WalkSpeedMultiplier=true, BhopEnabled=true, Speed=true, AirAcceleration=true, RunAccel=true, SprintAcceleration=true }
 
local function getMatchingTables()
    local matched = {}
    for _, obj in pairs(getgc(true)) do if typeof(obj) == "table" then local ok = true for f in pairs(requiredFields) do if rawget(obj, f) == nil then ok = false break end end if ok then table.insert(matched, obj) end end end
    return matched
end
 
local function applyToTables()
    for _, tbl in ipairs(getMatchingTables()) do pcall(function() tbl.Speed = currentSettings.Speed tbl.JumpCap = currentSettings.JumpCap tbl.AirStrafeAcceleration = currentSettings.AirStrafeAcceleration end) end
end
 
SettingsTab:CreateSlider({ Name = lang == "TH" and "ความเร็ว (Speed)" or "Speed", Range = {1450, 5000}, Increment = 10, CurrentValue = currentSettings.Speed, Callback = function(val) currentSettings.Speed = val applyToTables() end })
SettingsTab:CreateSlider({ Name = lang == "TH" and "ขีดจำกัดการกระโดด (Jump Cap)" or "Jump Cap", Range = {0.1, 5000}, Increment = 0.1, CurrentValue = currentSettings.JumpCap, Callback = function(val) currentSettings.JumpCap = val applyToTables() end })
SettingsTab:CreateSlider({ Name = lang == "TH" and "ความเร่งกลางอากาศ (Strafe Accel)" or "Strafe Acceleration", Range = {200, 1000}, Increment = 10, CurrentValue = currentSettings.AirStrafeAcceleration, Callback = function(val) currentSettings.AirStrafeAcceleration = val applyToTables() end })
 
getgenv().ApplyMode = "Not Optimized"
SettingsTab:CreateDropdown({ Name = lang == "TH" and "วิธีใช้งานสคริปต์" or "Apply Method", Options = {"Not Optimized", "Optimized"}, CurrentOption = "Not Optimized", MultipleOptions = false, Callback = function(option) getgenv().ApplyMode = option end })
player.CharacterAdded:Connect(function() task.wait(1) applyToTables() end)
 
-- =========================
-- วาปหนีบอท
-- =========================
local warpBotActive = false
local warpBotConnection = nil
 
local function warpBotLoop()
    if warpBotConnection then return end
    warpBotConnection = RunService.Heartbeat:Connect(function()
        if not warpBotActive then return end
        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local folder = workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Players")
        if folder then
            for _, npc in ipairs(folder:GetChildren()) do
                if npc:GetAttribute("Team") == "Nextbot" then
                    local npcPart = npc:FindFirstChild("Root") or npc:FindFirstChild("HumanoidRootPart")
                    if npcPart and (npcPart.Position - root.Position).Magnitude <= 10 then
                        local targetPlayer = nil
                        local maxY = -math.huge
                        for _, p in ipairs(Players:GetPlayers()) do
                            if p ~= player and p.Character then
                                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                                if hrp and hrp.Position.Y > maxY then maxY = hrp.Position.Y targetPlayer = hrp end
                            end
                        end
                        if targetPlayer then root.CFrame = targetPlayer.CFrame + Vector3.new(0, 2, 0) end
                    end
                end
            end
        end
    end)
end
 
ExtraTab:CreateToggle({ Name = lang == "TH" and "วาปหนีบอท" or "Warp Away From Bot", CurrentValue = false, Callback = function(state) warpBotActive = state if state then warpBotLoop() else if warpBotConnection then warpBotConnection:Disconnect() warpBotConnection = nil end end end })
ExtraTab:CreateButton({ Name = lang == "TH" and "เปลี่ยนเป็นกลางวัน" or "Change to Day", Callback = function() Lighting.ClockTime = 12 end })
ExtraTab:CreateButton({ Name = lang == "TH" and "เปลี่ยนเป็นกลางคืน" or "Change to Night", Callback = function() Lighting.ClockTime = 22 end })
 
-- =============================
-- ของเสริม : Korblox / Headless
-- =============================
local extraStatus = { Korblox = false, Headless = false }
local applying = false
 
local function applyBodyMod()
    if applying then return end applying = true
    getgenv().Setting = { ["Body"] = { ["Korblox"] = extraStatus.Korblox, ["Headless"] = extraStatus.Headless } }
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/khen791/script-khen/refs/heads/main/KorbloxAndHeadless.txt"))() end)
    task.wait(0.5) applying = false
end
 
player.CharacterAdded:Connect(function() task.wait(1.2) applyBodyMod() end)
ExtraTab:CreateToggle({ Name = lang == "TH" and "ขากุด (Korblox)" or "Korblox Leg", CurrentValue = false, Callback = function(state) extraStatus.Korblox = state applyBodyMod() end })
ExtraTab:CreateToggle({ Name = lang == "TH" and "หัวล่องหน (Headless)" or "Headless Head", CurrentValue = false, Callback = function(state) extraStatus.Headless = state applyBodyMod() end })
 
ExtraTab:CreateButton({
    Name = lang == "TH" and "ลบมืดออก" or "Remove Darkness",
    Callback = function()
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
        Lighting.Brightness = 3
        Lighting.ExposureCompensation = 1
        Lighting.GlobalShadows = false
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("ColorCorrectionEffect") or v:IsA("DepthOfFieldEffect") or v:IsA("BloomEffect") or v:IsA("SunRaysEffect") or v:IsA("Atmosphere") or v:IsA("Sky") then v:Destroy() end
        end
    end
})
 
-- =========================
-- [อัปเดตใหม่] ระบบสกินหน้าร้านเสก Emote (MARAGE Hub)
-- =========================
local emoteScriptLoaded = false
ExtraTab:CreateToggle({
    Name = lang == "TH" and "เปิดแฟ้มอีโมท(เสกท่า)" or "Open Emote Menu",
    CurrentValue = false,
    Callback = function(state)
        if state and not emoteScriptLoaded then
            task.spawn(function()
                local success, code = pcall(function() return game:HttpGet("https://pastebin.com/raw/rS9i9tmt") end)
                if success and code then
                    -- 1. ล้างชื่อเก่าออก เปลี่ยนเป็น MARAGE Hub (Beta) ทั้งหมดแบบ Dynamic
                    code = code:gsub("KOMAT Unity Hub", "MARAGE Hub (Beta)")
                    code = code:gsub("KOMAT Hub", "MARAGE Hub (Beta)")
                    code = code:gsub("Komat Hub", "MARAGE Hub (Beta)")
                    code = code:gsub("KOMAT", "MARAGE")
                    code = code:gsub("komat", "MARAGE")
                    
                    -- 2. ประมวลผลโค้ดตัวเสกท่า
                    local func = loadstring(code)
                    if func then 
                        func() 
                        emoteScriptLoaded = true 
                    end
                    
                    -- 3. ระบบ Auto UI Skinning เปลี่ยนกล่องเชยๆ ให้กลายเป็นโมเดิร์นไซเบอร์พังค์
                    task.wait(0.3)
                    local targetGui = nil
                    local searchSources = {game:GetService("CoreGui"), game.Players.LocalPlayer:FindFirstChild("PlayerGui")}
                    for _, source in ipairs(searchSources) do
                        if source then
                            for _, child in ipairs(source:GetChildren()) do
                                if child:IsA("ScreenGui") and (child:FindFirstChild("ตกลง", true) or child:FindFirstChild("รีเซ็ต", true) or child:FindFirstChild("MARAGE Hub (Beta)", true)) then
                                    targetGui = child
                                    break
                                end
                            end
                        end
                        if targetGui then break end
                    end
                    
                    if targetGui then
                        for _, obj in ipairs(targetGui:GetDescendants()) do
                            if obj:IsA("Frame") then
                                -- ชุบพื้นหลังให้ดูลึกขึ้นแบบกระจกดำ
                                obj.BackgroundColor3 = Color3.fromRGB(15, 15, 24)
                                obj.BackgroundTransparency = 0.15
                                
                                local corner = obj:FindFirstChildOfClass("UICorner") or Instance.new("UICorner", obj)
                                corner.CornerRadius = UDim.new(0, 14)
                                
                                -- ทำขอบเรืองแสงไฟนีออนวิ่งรอบกล่องเมนู
                                local stroke = obj:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke", obj)
                                stroke.Thickness = 2
                                stroke.Color = Color3.fromRGB(0, 180, 255)
                                stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                                
                                task.spawn(function()
                                    local ts = game:GetService("TweenService")
                                    while stroke and stroke.Parent do
                                        ts:Create(stroke, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Color = Color3.fromRGB(0, 120, 255)}):Play()
                                        task.wait(1.2)
                                        ts:Create(stroke, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Color = Color3.fromRGB(0, 255, 200)}):Play()
                                        task.wait(1.2)
                                    end
                                end)
                                
                            elseif obj:IsA("TextBox") then
                                -- ปรับเปลี่ยนช่อง Input กรอกชื่อท่าให้เรียบหรู คมชัด สบายตา
                                obj.BackgroundColor3 = Color3.fromRGB(28, 28, 40)
                                obj.BackgroundTransparency = 0.4
                                obj.TextColor3 = Color3.fromRGB(255, 255, 255)
                                obj.Font = Enum.Font.GothamMedium
                                obj.TextSize = 14
                                local c = obj:FindFirstChildOfClass("UICorner") or Instance.new("UICorner", obj)
                                c.CornerRadius = UDim.new(0, 8)
                                local s = obj:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke", obj)
                                s.Thickness = 1
                                s.Color = Color3.fromRGB(65, 65, 85)
                                
                            elseif obj:IsA("TextButton") then
                                local c = obj:FindFirstChildOfClass("UICorner") or Instance.new("UICorner", obj)
                                c.CornerRadius = UDim.new(0, 10)
                                
                                -- ปรับปุ่ม "ตกลง" และ "รีเซ็ต" ให้สดใส มีมิติ
                                if obj.Text == "ตกลง" then
                                    obj.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
                                    obj.BackgroundTransparency = 0.1
                                    obj.TextColor3 = Color3.fromRGB(255, 255, 255)
                                    obj.Font = Enum.Font.GothamBold
                                elseif obj.Text == "รีเซ็ต" then
                                    obj.BackgroundColor3 = Color3.fromRGB(190, 45, 60)
                                    obj.BackgroundTransparency = 0.1
                                    obj.TextColor3 = Color3.fromRGB(255, 255, 255)
                                    obj.Font = Enum.Font.GothamBold
                                elseif obj.Text == "X" or obj.Text == "x" or obj.Name:lower():find("close") then
                                    obj.TextColor3 = Color3.fromRGB(255, 75, 75)
                                    obj.Font = Enum.Font.GothamBold
                                    obj.BackgroundTransparency = 1
                                end
                                
                            elseif obj:IsA("TextLabel") then
                                obj.Font = Enum.Font.GothamBold
                                if string.find(obj.Text, "MARAGE") then
                                    obj.TextColor3 = Color3.fromRGB(0, 255, 220) -- เน้นสีแบรนด์ใหม่เด่นๆ
                                else
                                    obj.TextColor3 = Color3.fromRGB(230, 230, 240)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
})
 
-- =========================
-- ลบ/คืนค่า Barrier
-- =========================
local hiddenParts = {}
local function findParts()
    local found = {}
    for _, obj in ipairs(workspace:GetDescendants()) do if obj:IsA("BasePart") and (obj.Name == "Barrier" or obj.Name == "MapBarrier") then table.insert(found, obj) end end
    return found
end
 
MainTab:CreateToggle({
    Name = lang == "TH" and "ลบ/คืนค่า Barrier" or "Remove/Restore Barrier",
    CurrentValue = false,
    Callback = function(state)
        if state then
            for _, part in ipairs(findParts()) do
                if part and part.Parent and not hiddenParts[part] then
                    hiddenParts[part] = { Parent = part.Parent, CFrame = part.CFrame, Transparency = part.Transparency, CanCollide = part.CanCollide }
                    part.Parent = nil
                end
            end
        else
            for part, data in pairs(hiddenParts) do if part then pcall(function() part.Parent = data.Parent part.CFrame = data.CFrame part.Transparency = data.Transparency part.CanCollide = data.CanCollide end) end end
            hiddenParts = {}
        end
    end
})
 
-- =========================
-- พื้นใส
-- =========================
local originalParts = {}
ExtraTab:CreateToggle({
    Name = lang == "TH" and "พื้นใส" or "Transparent Floor",
    CurrentValue = false,
    Callback = function(state)
        if state then
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    if not originalParts[obj] then originalParts[obj] = { Material = obj.Material, Reflectance = obj.Reflectance } end
                    obj.Material = Enum.Material.SmoothPlastic
                    obj.Reflectance = 0.3
                end
            end
        else
            for obj, data in pairs(originalParts) do if obj and obj.Parent then obj.Material = data.Material obj.Reflectance = data.Reflectance end end
            originalParts = {}
        end
    end
})
