local plr = game:GetService("Players").LocalPlayer
local char = plr.Character
local root = char.HumanoidRootPart
local Plrs = game:GetService("Players")
local MyPlr = Plrs.LocalPlayer
local MyChar = MyPlr.Character
local UIS = game:GetService'UserInputService'
local RepStor = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local Run = game:GetService("RunService")
local mouse = game.Players.LocalPlayer:GetMouse()
local human = plr.Character:WaitForChild("Humanoid")
local Humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid
local Backpack = plr.Backpack
local camera = game.Workspace.CurrentCamera
local Workspace = game:GetService("Workspace")
local wc = workspace[plr.Name] 
human:UnequipTools()
local FSTool = Backpack.FSTool
local PPTool = Backpack.PPTool

-- Anti Idle --
local VirtualUser=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
	VirtualUser:CaptureController()
	VirtualUser:ClickButton2(Vector2.new())
end)

workspace[plr.Name].HumanoidRootPart.Anchored = false

showtopplayersactive = false
showtopplayersfistactive = false
showtopplayersbodyactive = false
showtopplayersspeedactive = false
showtopplayersjumpactive = false
showtopplayerspsychicactive = false
settplocation = false
playerdied = false
deathreturnactive = false
resetplayerstat = false
killplayeractive = false
autoclick = false

ESPEnabled = false
ESPLength = 5000

CharAddedEvent = { }

Plrs.PlayerAdded:connect(function(plr)
	if CharAddedEvent[plr.Name] == nil then
		CharAddedEvent[plr.Name] = plr.CharacterAdded:connect(function(char)
			if ESPEnabled then
				RemoveESP(plr)
				CreateESP(plr)
			end
		end)
	end
end)

Plrs.PlayerRemoving:connect(function(plr)
	if CharAddedEvent[plr.Name] ~= nil then
		CharAddedEvent[plr.Name]:Disconnect()
		CharAddedEvent[plr.Name] = nil
	end
	RemoveESP(plr)
end)

function CreateESP(plr)
	if plr ~= nil then
		local GetChar = plr.Character
		if not GetChar then return end
		local GetHead do
			repeat wait() until GetChar:FindFirstChild("Head")
		end
		GetHead = GetChar.Head
		
		local bb = Instance.new("BillboardGui", CoreGui)
		bb.Adornee = GetHead
		bb.ExtentsOffset = Vector3.new(0, 1, 0)
		bb.AlwaysOnTop = true
		bb.Size = UDim2.new(0, 5, 0, 5)
		bb.StudsOffset = Vector3.new(0, 3, 0)
		bb.Name = "ESP_" .. plr.Name
		
		local frame = Instance.new("Frame", bb)
		frame.ZIndex = 10
		frame.BackgroundTransparency = 1
		frame.Size = UDim2.new(1, 0, 1, 0)
		
		local TxtName = Instance.new("TextLabel", frame)
		TxtName.Name = "Names"
		TxtName.ZIndex = 10
		TxtName.Text = plr.Name
		TxtName.BackgroundTransparency = 1
		TxtName.Position = UDim2.new(0, 0, 0, -45)
		TxtName.Size = UDim2.new(1, 0, 10, 0)
		TxtName.Font = "SourceSansBold"
		TxtName.TextColor3 = Color3.new(0, 0, 0)
		TxtName.TextSize = 14
		TxtName.TextStrokeTransparency = 0.5
		
		local TxtDist = Instance.new("TextLabel", frame)
		TxtDist.Name = "Dist"
		TxtDist.ZIndex = 10
		TxtDist.Text = ""
		TxtDist.BackgroundTransparency = 1
		TxtDist.Position = UDim2.new(0, 0, 0, -35)
		TxtDist.Size = UDim2.new(1, 0, 10, 0)
		TxtDist.Font = "SourceSansBold"
		TxtDist.TextColor3 = Color3.new(0, 0, 0)
		TxtDist.TextSize = 15
		TxtDist.TextStrokeTransparency = 0.5

		local TxtFist = Instance.new("TextLabel", frame)
		TxtFist.Name = "Fist"
		TxtFist.ZIndex = 10
		TxtFist.Text = ""
		TxtFist.BackgroundTransparency = 1
		TxtFist.Position = UDim2.new(0, 0, 0, -25)
		TxtFist.Size = UDim2.new(1, 0, 10, 0)
		TxtFist.Font = "SourceSansBold"
		TxtFist.TextColor3 = Color3.new(0, 0, 0)
		TxtFist.TextSize = 15
		TxtFist.TextStrokeTransparency = 0.5

		local TxtBody = Instance.new("TextLabel", frame)
		TxtBody.Name = "BT"
		TxtBody.ZIndex = 10
		TxtBody.Text = ""
		TxtBody.BackgroundTransparency = 1
		TxtBody.Position = UDim2.new(0, 0, 0, -15)
		TxtBody.Size = UDim2.new(1, 0, 10, 0)
		TxtBody.Font = "SourceSansBold"
		TxtBody.TextColor3 = Color3.new(0, 0, 0)
		TxtBody.TextSize = 15
		TxtBody.TextStrokeTransparency = 0.5
	end
end

function UpdateESP(plr)
	local Find = CoreGui:FindFirstChild("ESP_" .. plr.Name)
	if Find then
		local plrStatus = game.Players[plr.Name].leaderstats.Status
		if plrStatus.Value == "Criminal" then
			Find.Frame.Names.TextColor3 = Color3.fromRGB(255, 113, 106)
		elseif plrStatus.Value == "Lawbreaker" then
			Find.Frame.Names.TextColor3 = Color3.fromRGB(255, 142, 100)
		elseif plrStatus.Value == "Guardian" then
			Find.Frame.Names.TextColor3 = Color3.fromRGB(3, 12, 255)
		elseif plrStatus.Value == "Protector" then
			Find.Frame.Names.TextColor3 = Color3.fromRGB(0, 144, 211)
		elseif plrStatus.Value == "SuperVillian" then
			Find.Frame.Names.TextColor3 = Color3.fromRGB(187, 0, 250)
		elseif plrStatus.Value == "Superhero" then
			Find.Frame.Names.TextColor3 = Color3.fromRGB(209, 255, 59)
		else
			Find.Frame.Names.TextColor3 = Color3.fromRGB(255, 255, 255)
		end
		Find.Frame.Dist.TextColor3 = Color3.new(1, 1, 1)
		Find.Frame.Fist.TextColor3 = Color3.new(1, 1, 1)
		Find.Frame.BT.TextColor3 = Color3.new(1, 1, 1)
		local GetChar = plr.Character
		if MyChar and GetChar then
			local Find2 = MyChar:FindFirstChild("HumanoidRootPart")
			local Find3 = GetChar:FindFirstChild("HumanoidRootPart")
			local Find4 = GetChar:FindFirstChildOfClass("Humanoid")
			if Find2 and Find3 then
				local pos = Find3.Position
				local Dist = (Find2.Position - pos).magnitude
				if Dist > ESPLength then
					Find.Frame.Names.Visible = false
					Find.Frame.Dist.Visible = false
					Find.Frame.Fist.Visible = false
					Find.Frame.BT.Visible = false
					return
				else
					Find.Frame.Names.Visible = true
					Find.Frame.Dist.Visible = true
					Find.Frame.Fist.Visible = true
					Find.Frame.BT.Visible = true
				end
				Find.Frame.Dist.Text = "Distance: " .. string.format("%.0f", Dist)
				if Find4 then
					Find.Frame.Fist.Text = "Fist: " ..converttoletter(string.format("%.0f", game.Players[plr.Name].PlayerFolder.DataFolder.FS.Value))
					Find.Frame.BT.Text = "Body: " ..converttoletter(string.format("%.0f", game.Players[plr.Name].PlayerFolder.DataFolder.BT.Value))
				else
					Find.Frame.Fist.Text = ""
					Find.Frame.BT.Text = ""
				end
			end
		end
	end
end

function RemoveESP(plr)
	local ESP = CoreGui:FindFirstChild("ESP_" .. plr.Name)
	if ESP then
		ESP:Destroy()
	end
end

local MainGUI = Instance.new("ScreenGui")
local TopFrame = Instance.new("Frame")
local MainFrame = Instance.new("Frame")
local MainFrame1 = Instance.new("Frame")
local Open = Instance.new("TextButton")
local Close = Instance.new("TextButton")
local Close1 = Instance.new("TextButton")
local Minimize = Instance.new("TextButton")
local Enable = Instance.new("TextButton", MainGUI)
local Disable = Instance.new("TextButton", MainGUI)

-- Teleports

local WayPoints = Instance.new("TextButton")
local WayPointsFrame = Instance.new("Frame")
local SafeZone = Instance.new("TextButton")

-- FS

local FS1k = Instance.new("TextButton")
local FS100k100M = Instance.new("TextButton")
local FS1B = Instance.new("TextButton")
local FS100B = Instance.new("TextButton")
local FS1T = Instance.new("TextButton")
local FS100T = Instance.new("TextButton")
local FS5Qa = Instance.new("TextButton")
local FS35Qa = Instance.new("TextButton")
local FS500Qa = Instance.new("TextButton")
local FS5Qi = Instance.new("TextButton")
local FS350Qi = Instance.new("TextButton")

-- BT

local BT1k = Instance.new("TextButton")
local BT100k = Instance.new("TextButton")
local BT1M = Instance.new("TextButton")
local BT100M = Instance.new("TextButton")
local BT1B = Instance.new("TextButton")
local BT100B = Instance.new("TextButton")
local LocationBody1B = Instance.new("TextButton")
local BT1T = Instance.new("TextButton")
local BT100T = Instance.new("TextButton")
local BT5Qa = Instance.new("TextButton")
local BT35Qa = Instance.new("TextButton")
local BT500Qa = Instance.new("TextButton")
local BT5Qi = Instance.new("TextButton")
local BT350Qi = Instance.new("TextButton")

-- PP

local PP10k = Instance.new("TextButton")
local PP1M = Instance.new("TextButton")
local PP1B = Instance.new("TextButton")
local PP1T = Instance.new("TextButton")
local PP1Qa = Instance.new("TextButton")
local PP350Qa = Instance.new("TextButton")
local PP3Qi = Instance.new("TextButton")
local PP50Qi = Instance.new("TextButton")
local PP1Sx = Instance.new("TextButton")

-- Farm

local FarmExp = Instance.new("TextButton")
local FarmExpFrame = Instance.new("Frame")
local FarmFist = Instance.new("TextButton")
local FarmBody = Instance.new("TextButton")
local FarmPsychic = Instance.new("TextButton")

-- Others

local FarmBody = Instance.new("TextButton") -- For example button
local SavePosition = Instance.new("TextLabel")
local FarmBodyLabel = Instance.new("TextLabel") -- For example button
local esptrack = Instance.new("TextButton")
local ESPLength = Instance.new("TextBox")

-- Top players

local PlayerInfo = Instance.new("TextButton")
local PlayerInfoFrame = Instance.new("Frame")
local ShowTopPlayers = Instance.new("TextButton")
local PlayerInfoStatsFrame = Instance.new("Frame")
local PlayerInfoStatsClose = Instance.new("TextButton")
local StatBestFistText1 = Instance.new("TextLabel")
local StatBestBodyText1 = Instance.new("TextLabel")
local StatBestSpeedText1 = Instance.new("TextLabel")
local StatBestJumpText1 = Instance.new("TextLabel")
local StatBestPsychicText1 = Instance.new("TextLabel")
local PlayerInfoStatsText1 = Instance.new("TextLabel")
local ShowStatsFist1 = Instance.new("TextLabel")
local ShowStatsBody1 = Instance.new("TextLabel")
local ShowStatsSpeed1 = Instance.new("TextLabel")
local ShowStatsJump1 = Instance.new("TextLabel")
local ShowStatsPsychic1 = Instance.new("TextLabel")
local ShowStatsFist2 = Instance.new("TextLabel")
local ShowStatsBody2 = Instance.new("TextLabel")
local ShowStatsSpeed2 = Instance.new("TextLabel")
local ShowStatsJump2 = Instance.new("TextLabel")
local ShowStatsPsychic2 = Instance.new("TextLabel")

-- Stats Checker

local PlayerName = Instance.new("TextLabel")
local StatsFrame = Instance.new("Frame")
local ShowStats1 = Instance.new("TextLabel")
local ShowStats2 = Instance.new("TextLabel")

local PlayerName1 = Instance.new("TextBox")
local StatsFrame1 = Instance.new("Frame")
local ShowStats3 = Instance.new("TextLabel")
local ShowStats4 = Instance.new("TextLabel")

-- Properties

MainGUI.Name = "MainGUI"
MainGUI.Parent = game.CoreGui
MainGUI.ResetOnSpawn = false
local MainCORE = game.CoreGui["MainGUI"]

TopFrame.Name = "TopFrame"
TopFrame.Parent = MainGUI
TopFrame.BackgroundColor3 = Color3.new(0, 0, 0)
TopFrame.BorderColor3 = Color3.new(0, 0, 0)
TopFrame.BackgroundTransparency = 1
TopFrame.Position = UDim2.new(0.5, -30, 0, -27)
TopFrame.Size = UDim2.new(0, 80, 0, 20)
TopFrame.Visible = false

Open.Name = "Open"
Open.Parent = TopFrame
Open.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Open.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
Open.Size = UDim2.new(0, 60, 0, 20)
Open.Font = Enum.Font.Fantasy
Open.Text = "Open"
Open.TextColor3 = Color3.new(1, 1, 1)
Open.TextSize = 18
Open.Selectable = true
Open.TextWrapped = true

MainFrame.Name = "MainFrame"
MainFrame.Parent = MainGUI
MainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
MainFrame.BackgroundTransparency = 0.5
MainFrame.BorderColor3 = Color3.new(1, 1, 1)
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.5, -232.5, 0, -32)
MainFrame.Size = UDim2.new(0, 491, 0, 30)

MainFrame1.Name = "MainFrame1"
MainFrame1.Parent = MainGUI
MainFrame1.BackgroundColor3 = Color3.new(0, 0, 0)
MainFrame1.BackgroundTransparency = 0.5
MainFrame1.BorderColor3 = Color3.new(1, 1, 1)
MainFrame1.BorderSizePixel = 2
MainFrame1.Position = UDim2.new(0.5, 720, 0, 400)
MainFrame1.Size = UDim2.new(0, 235, 0, 30)

Close.Name = "Close"
Close.Parent = MainFrame
Close.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Close.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
Close.Position = UDim2.new(0, 10, 0, 5)
Close.Size = UDim2.new(0, 20, 0, 20)
Close.Font = Enum.Font.Fantasy
Close.Text = "X"
Close.TextColor3 = Color3.new(1, 0, 0)
Close.TextSize = 17
Close.TextScaled = true
Close.TextWrapped = true

Minimize.Name = "Minimize"
Minimize.Parent = MainFrame
Minimize.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Minimize.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
Minimize.Position = UDim2.new(0, 35, 0, 5)
Minimize.Size = UDim2.new(0, 20, 0, 20)
Minimize.Font = Enum.Font.Fantasy
Minimize.Text = "-"
Minimize.TextColor3 = Color3.new(0, 0.5, 1)
Minimize.TextSize = 18
Minimize.TextScaled = true
Minimize.TextWrapped = true

-- Teleports

WayPoints.Name = "WayPoints"
WayPoints.Parent = MainFrame
WayPoints.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
WayPoints.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
WayPoints.Position = UDim2.new(0, 60, 0, 5)
WayPoints.Size = UDim2.new(0, 65, 0, 20)
WayPoints.Font = Enum.Font.Fantasy
WayPoints.TextColor3 = Color3.new(1, 1, 1)
WayPoints.Text = "Teleport"
WayPoints.TextSize = 17
WayPoints.TextWrapped = true

WayPointsFrame.Name = "WayPointsFrame"
WayPointsFrame.Parent = MainFrame
WayPointsFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
WayPointsFrame.BorderColor3 = Color3.new(0, 0, 0)
WayPointsFrame.BackgroundTransparency = 0.2
WayPointsFrame.Position = UDim2.new(0, -100, 0, 33)
WayPointsFrame.Size = UDim2.new(0, 375, 0, 855)
WayPointsFrame.Visible = false

SafeZone.Name = "SafeZone"
SafeZone.Parent = WayPointsFrame
SafeZone.BackgroundColor3 = Color3.new(255/255, 94/255, 40/255)
SafeZone.TextColor3 = Color3.new(1, 1, 1)
SafeZone.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
SafeZone.Position = UDim2.new(0, 5, 0, 5)
SafeZone.Size = UDim2.new(0, 365, 0, 20)
SafeZone.Font = Enum.Font.Fantasy
SafeZone.Text = "Teleport to Safe Zone"
SafeZone.TextWrapped = true
SafeZone.TextSize = 16

-- FS

FS1k.Name = "FS1k"
FS1k.Parent = WayPointsFrame
FS1k.BackgroundColor3 = Color3.new(195/255, 0, 39/255)
FS1k.TextColor3 = Color3.new(1, 1, 1)
FS1k.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
FS1k.Position = UDim2.new(0, 5, 0, 30)
FS1k.Size = UDim2.new(0, 365, 0, 20)
FS1k.Font = Enum.Font.Fantasy
FS1k.Text = "Tp to Rock [10 x Fist Strength] 1k+ FS required"
FS1k.TextWrapped = true
FS1k.TextSize = 16

FS100k100M.Name = "FS100k100M"
FS100k100M.Parent = WayPointsFrame
FS100k100M.BackgroundColor3 = Color3.new(195/255, 0, 39/255)
FS100k100M.TextColor3 = Color3.new(1, 1, 1)
FS100k100M.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
FS100k100M.Position = UDim2.new(0, 5, 0, 55)
FS100k100M.Size = UDim2.new(0, 365, 0, 20)
FS100k100M.Font = Enum.Font.Fantasy
FS100k100M.Text = "Tp to Crystals [50-1k x FS] 100k+ FS required"
FS100k100M.TextWrapped = true
FS100k100M.TextSize = 16

FS1B.Name = "FS1B"
FS1B.Parent = WayPointsFrame
FS1B.BackgroundColor3 = Color3.new(195/255, 0, 39/255)
FS1B.TextColor3 = Color3.new(1, 1, 1)
FS1B.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
FS1B.Position = UDim2.new(0, 5, 0, 80)
FS1B.Size = UDim2.new(0, 365, 0, 20)
FS1B.Font = Enum.Font.Fantasy
FS1B.Text = "Tp to Blue Star [10k x FS] 1B+ FS required"
FS1B.TextWrapped = true
FS1B.TextSize = 16

FS100B.Name = "FS100B"
FS100B.Parent = WayPointsFrame
FS100B.BackgroundColor3 = Color3.new(195/255, 0, 39/255)
FS100B.TextColor3 = Color3.new(1, 1, 1)
FS100B.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
FS100B.Position = UDim2.new(0, 5, 0, 105)
FS100B.Size = UDim2.new(0, 365, 0, 20)
FS100B.Font = Enum.Font.Fantasy
FS100B.Text = "Tp to Green Star [50k x FS] 100B+ FS required"
FS100B.TextWrapped = true
FS100B.TextSize = 16

FS1T.Name = "FS1T"
FS1T.Parent = WayPointsFrame
FS1T.BackgroundColor3 = Color3.new(195/255, 0, 39/255)
FS1T.TextColor3 = Color3.new(1, 1, 1)
FS1T.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
FS1T.Position = UDim2.new(0, 5, 0, 130)
FS1T.Size = UDim2.new(0, 365, 0, 20)
FS1T.Font = Enum.Font.Fantasy
FS1T.Text = "Tp to Orange Star [500k x FS] 1T+ FS required"
FS1T.TextWrapped = true
FS1T.TextSize = 16

FS100T.Name = "FS100T"
FS100T.Parent = WayPointsFrame
FS100T.BackgroundColor3 = Color3.new(195/255, 0, 39/255)
FS100T.TextColor3 = Color3.new(1, 1, 1)
FS100T.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
FS100T.Position = UDim2.new(0, 5, 0, 155)
FS100T.Size = UDim2.new(0, 365, 0, 20)
FS100T.Font = Enum.Font.Fantasy
FS100T.Text = "Tp to Red Star [3M x FS] 100T+ FS required"
FS100T.TextWrapped = true
FS100T.TextSize = 16

FS5Qa.Name = "FS5Qa"
FS5Qa.Parent = WayPointsFrame
FS5Qa.BackgroundColor3 = Color3.new(195/255, 0, 39/255)
FS5Qa.TextColor3 = Color3.new(1, 1, 1)
FS5Qa.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
FS5Qa.Position = UDim2.new(0, 5, 0, 180)
FS5Qa.Size = UDim2.new(0, 365, 0, 20)
FS5Qa.Font = Enum.Font.Fantasy
FS5Qa.Text = "Tp to Magma Crystal [50M x FS] 5Qa+ FS required"
FS5Qa.TextWrapped = true
FS5Qa.TextSize = 16

FS35Qa.Name = "FS35Qa"
FS35Qa.Parent = WayPointsFrame
FS35Qa.BackgroundColor3 = Color3.new(195/255, 0, 39/255)
FS35Qa.TextColor3 = Color3.new(1, 1, 1)
FS35Qa.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
FS35Qa.Position = UDim2.new(0, 5, 0, 205)
FS35Qa.Size = UDim2.new(0, 365, 0, 20)
FS35Qa.Font = Enum.Font.Fantasy
FS35Qa.Text = "Tp to Pink Crystal [200M x FS] 35Qa+ FS required"
FS35Qa.TextWrapped = true
FS35Qa.TextSize = 16

FS500Qa.Name = "FS500Qa"
FS500Qa.Parent = WayPointsFrame
FS500Qa.BackgroundColor3 = Color3.new(195/255, 0, 39/255)
FS500Qa.TextColor3 = Color3.new(1, 1, 1)
FS500Qa.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
FS500Qa.Position = UDim2.new(0, 5, 0, 230)
FS500Qa.Size = UDim2.new(0, 365, 0, 20)
FS500Qa.Font = Enum.Font.Fantasy
FS500Qa.Text = "Tp to Purple Star [1B x FS] 500Qa+ FS required"
FS500Qa.TextWrapped = true
FS500Qa.TextSize = 16

FS5Qi.Name = "FS5Qi"
FS5Qi.Parent = WayPointsFrame
FS5Qi.BackgroundColor3 = Color3.new(195/255, 0, 39/255)
FS5Qi.TextColor3 = Color3.new(1, 1, 1)
FS5Qi.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
FS5Qi.Position = UDim2.new(0, 5, 0, 255)
FS5Qi.Size = UDim2.new(0, 365, 0, 20)
FS5Qi.Font = Enum.Font.Fantasy
FS5Qi.Text = "Tp to Green Star [5B x FS] 5Qi+ FS required"
FS5Qi.TextWrapped = true
FS5Qi.TextSize = 16

FS350Qi.Name = "FS350Qi"
FS350Qi.Parent = WayPointsFrame
FS350Qi.BackgroundColor3 = Color3.new(195/255, 0, 39/255)
FS350Qi.TextColor3 = Color3.new(1, 1, 1)
FS350Qi.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
FS350Qi.Position = UDim2.new(0, 5, 0, 280)
FS350Qi.Size = UDim2.new(0, 365, 0, 20)
FS350Qi.Font = Enum.Font.Fantasy
FS350Qi.Text = "Tp to Orange Star [25B x FS] 350Qi+ FS required"
FS350Qi.TextWrapped = true
FS350Qi.TextSize = 16

-- BT

BT1k.Name = "BT1k"
BT1k.Parent = WayPointsFrame
BT1k.BackgroundColor3 = Color3.new(70/255, 105/255, 0)
BT1k.TextColor3 = Color3.new(1, 1, 1)
BT1k.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
BT1k.Position = UDim2.new(0, 5, 0, 305)
BT1k.Size = UDim2.new(0, 365, 0, 20)
BT1k.Font = Enum.Font.Fantasy
BT1k.Text = "Tp to Pool [10 x BT] 1K+ BT required"
BT1k.TextWrapped = true
BT1k.TextSize = 16

BT100k.Name = "BT100k"
BT100k.Parent = WayPointsFrame
BT100k.BackgroundColor3 = Color3.new(70/255, 105/255, 0)
BT100k.TextColor3 = Color3.new(1, 1, 1)
BT100k.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
BT100k.Position = UDim2.new(0, 5, 0, 330)
BT100k.Size = UDim2.new(0, 365, 0, 20)
BT100k.Font = Enum.Font.Fantasy
BT100k.Text = "Tp to Ice Mountain [50 x BT] 100K+ BT required"
BT100k.TextWrapped = true
BT100k.TextSize = 16

BT1M.Name = "BT1M"
BT1M.Parent = WayPointsFrame
BT1M.BackgroundColor3 = Color3.new(70/255, 105/255, 0)
BT1M.TextColor3 = Color3.new(1, 1, 1)
BT1M.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
BT1M.Position = UDim2.new(0, 5, 0, 355)
BT1M.Size = UDim2.new(0, 365, 0, 20)
BT1M.Font = Enum.Font.Fantasy
BT1M.Text = "Tp to Tornado [100 x BT] 1M+ BT required"
BT1M.TextWrapped = true
BT1M.TextSize = 16

BT100M.Name = "BT100M"
BT100M.Parent = WayPointsFrame
BT100M.BackgroundColor3 = Color3.new(70/255, 105/255, 0)
BT100M.TextColor3 = Color3.new(1, 1, 1)
BT100M.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
BT100M.Position = UDim2.new(0, 5, 0, 380)
BT100M.Size = UDim2.new(0, 365, 0, 20)
BT100M.Font = Enum.Font.Fantasy
BT100M.Text = "Tp to Volcano [1k x BT] 100M+ BT required"
BT100M.TextWrapped = true
BT100M.TextSize = 16

BT1B.Name = "BT1B"
BT1B.Parent = WayPointsFrame
BT1B.BackgroundColor3 = Color3.new(70/255, 105/255, 0)
BT1B.TextColor3 = Color3.new(1, 1, 1)
BT1B.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
BT1B.Position = UDim2.new(0, 5, 0, 405)
BT1B.Size = UDim2.new(0, 365, 0, 20)
BT1B.Font = Enum.Font.Fantasy
BT1B.Text = "Tp to Electrical wiring [10k x BT] 1B+ BT required"
BT1B.TextWrapped = true
BT1B.TextSize = 16

BT100B.Name = "BT100B"
BT100B.Parent = WayPointsFrame
BT100B.BackgroundColor3 = Color3.new(70/255, 105/255, 0)
BT100B.TextColor3 = Color3.new(1, 1, 1)
BT100B.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
BT100B.Position = UDim2.new(0, 5, 0, 430)
BT100B.Size = UDim2.new(0, 365, 0, 20)
BT100B.Font = Enum.Font.Fantasy
BT100B.Text = "Tp to Stone Pool [50k x BT] 100B+ BT required"
BT100B.TextWrapped = true
BT100B.TextSize = 16

BT1T.Name = "BT1T"
BT1T.Parent = WayPointsFrame
BT1T.BackgroundColor3 = Color3.new(70/255, 105/255, 0)
BT1T.TextColor3 = Color3.new(1, 1, 1)
BT1T.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
BT1T.Position = UDim2.new(0, 5, 0, 455)
BT1T.Size = UDim2.new(0, 365, 0, 20)
BT1T.Font = Enum.Font.Fantasy
BT1T.Text = "Tp to Dark Smoke [100k x BT] 1T+ BT required"
BT1T.TextWrapped = true
BT1T.TextSize = 16

BT100T.Name = "BT100T"
BT100T.Parent = WayPointsFrame
BT100T.BackgroundColor3 = Color3.new(70/255, 105/255, 0)
BT100T.TextColor3 = Color3.new(1, 1, 1)
BT100T.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
BT100T.Position = UDim2.new(0, 5, 0, 480)
BT100T.Size = UDim2.new(0, 365, 0, 20)
BT100T.Font = Enum.Font.Fantasy
BT100T.Text = "Tp to Dance Pad [500k x BT] 100T+ BT required"
BT100T.TextWrapped = true
BT100T.TextSize = 16

BT5Qa.Name = "BT5Qa"
BT5Qa.Parent = WayPointsFrame
BT5Qa.BackgroundColor3 = Color3.new(70/255, 105/255, 0)
BT5Qa.TextColor3 = Color3.new(1, 1, 1)
BT5Qa.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
BT5Qa.Position = UDim2.new(0, 5, 0, 505)
BT5Qa.Size = UDim2.new(0, 365, 0, 20)
BT5Qa.Font = Enum.Font.Fantasy
BT5Qa.Text = "Tp to Pool of Blood [50M x BT] 5Qa+ BT required"
BT5Qa.TextWrapped = true
BT5Qa.TextSize = 16

BT35Qa.Name = "BT35Qa"
BT35Qa.Parent = WayPointsFrame
BT35Qa.BackgroundColor3 = Color3.new(70/255, 105/255, 0)
BT35Qa.TextColor3 = Color3.new(1, 1, 1)
BT35Qa.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
BT35Qa.Position = UDim2.new(0, 5, 0, 530)
BT35Qa.Size = UDim2.new(0, 365, 0, 20)
BT35Qa.Font = Enum.Font.Fantasy
BT35Qa.Text = "Tp to Purple Pool [200M x BT] 35Qa+ BT required"
BT35Qa.TextWrapped = true
BT35Qa.TextSize = 16

BT500Qa.Name = "BT500Qa"
BT500Qa.Parent = WayPointsFrame
BT500Qa.BackgroundColor3 = Color3.new(70/255, 105/255, 0)
BT500Qa.TextColor3 = Color3.new(1, 1, 1)
BT500Qa.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
BT500Qa.Position = UDim2.new(0, 5, 0, 555)
BT500Qa.Size = UDim2.new(0, 365, 0, 20)
BT500Qa.Font = Enum.Font.Fantasy
BT500Qa.Text = "Tp to Strong Light [1B x BT] 500Qa+ BT required"
BT500Qa.TextWrapped = true
BT500Qa.TextSize = 16

BT5Qi.Name = "BT5Qi"
BT5Qi.Parent = WayPointsFrame
BT5Qi.BackgroundColor3 = Color3.new(70/255, 105/255, 0)
BT5Qi.TextColor3 = Color3.new(1, 1, 1)
BT5Qi.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
BT5Qi.Position = UDim2.new(0, 5, 0, 580)
BT5Qi.Size = UDim2.new(0, 365, 0, 20)
BT5Qi.Font = Enum.Font.Fantasy
BT5Qi.Text = "Tp to Blue Magma [5B x BT] 5Qi+ BT required"
BT5Qi.TextWrapped = true
BT5Qi.TextSize = 16

BT350Qi.Name = "BT350Qi"
BT350Qi.Parent = WayPointsFrame
BT350Qi.BackgroundColor3 = Color3.new(70/255, 105/255, 0)
BT350Qi.TextColor3 = Color3.new(1, 1, 1)
BT350Qi.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
BT350Qi.Position = UDim2.new(0, 5, 0, 605)
BT350Qi.Size = UDim2.new(0, 365, 0, 20)
BT350Qi.Font = Enum.Font.Fantasy
BT350Qi.Text = "Tp to Pink Fire [25B x BT] 350Qi+ BT required"
BT350Qi.TextWrapped = true
BT350Qi.TextSize = 16

-- PP

PP10k.Name = "PP10k"
PP10k.Parent = WayPointsFrame
PP10k.BackgroundColor3 = Color3.new(66/255, 0, 165/255)
PP10k.TextColor3 = Color3.new(1, 1, 1)
PP10k.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
PP10k.Position = UDim2.new(0, 5, 0, 630)
PP10k.Size = UDim2.new(0, 365, 0, 20)
PP10k.Font = Enum.Font.Fantasy
PP10k.Text = "Tp to Island [10 x PP] 10k+ PP required"
PP10k.TextWrapped = true
PP10k.TextSize = 16

PP1M.Name = "PP1M"
PP1M.Parent = WayPointsFrame
PP1M.BackgroundColor3 = Color3.new(66/255, 0, 165/255)
PP1M.TextColor3 = Color3.new(1, 1, 1)
PP1M.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
PP1M.Position = UDim2.new(0, 5, 0, 655)
PP1M.Size = UDim2.new(0, 365, 0, 20)
PP1M.Font = Enum.Font.Fantasy
PP1M.Text = "Tp to Tree [100 x PP] 1M+ PP required"
PP1M.TextWrapped = true
PP1M.TextSize = 16

PP1B.Name = "PP1B"
PP1B.Parent = WayPointsFrame
PP1B.BackgroundColor3 = Color3.new(66/255, 0, 165/255)
PP1B.TextColor3 = Color3.new(1, 1, 1)
PP1B.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
PP1B.Position = UDim2.new(0, 5, 0, 680)
PP1B.Size = UDim2.new(0, 365, 0, 20)
PP1B.Font = Enum.Font.Fantasy
PP1B.Text = "Tp to Tree [10k x PP] 1B+ PP required"
PP1B.TextWrapped = true
PP1B.TextSize = 16

PP1T.Name = "PP1T"
PP1T.Parent = WayPointsFrame
PP1T.BackgroundColor3 = Color3.new(66/255, 0, 165/255)
PP1T.TextColor3 = Color3.new(1, 1, 1)
PP1T.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
PP1T.Position = UDim2.new(0, 5, 0, 705)
PP1T.Size = UDim2.new(0, 365, 0, 20)
PP1T.Font = Enum.Font.Fantasy
PP1T.Text = "Tp to Waterfall [10M x PP] 1T+ PP required"
PP1T.TextWrapped = true
PP1T.TextSize = 16

PP1Qa.Name = "PP1Qa"
PP1Qa.Parent = WayPointsFrame
PP1Qa.BackgroundColor3 = Color3.new(66/255, 0, 165/255)
PP1Qa.TextColor3 = Color3.new(1, 1, 1)
PP1Qa.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
PP1Qa.Position = UDim2.new(0, 5, 0, 730)
PP1Qa.Size = UDim2.new(0, 365, 0, 20)
PP1Qa.Font = Enum.Font.Fantasy
PP1Qa.Text = "Tp to Tree [100M x PP] 1Qa+ PP required"
PP1Qa.TextWrapped = true
PP1Qa.TextSize = 16

PP350Qa.Name = "PP350Qa"
PP350Qa.Parent = WayPointsFrame
PP350Qa.BackgroundColor3 = Color3.new(66/255, 0, 165/255)
PP350Qa.TextColor3 = Color3.new(1, 1, 1)
PP350Qa.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
PP350Qa.Position = UDim2.new(0, 5, 0, 755)
PP350Qa.Size = UDim2.new(0, 365, 0, 20)
PP350Qa.Font = Enum.Font.Fantasy
PP350Qa.Text = "Tp to Tree [1B x PP] 350Qa+ PP required"
PP350Qa.TextWrapped = true
PP350Qa.TextSize = 16

PP3Qi.Name = "PP3Qi"
PP3Qi.Parent = WayPointsFrame
PP3Qi.BackgroundColor3 = Color3.new(66/255, 0, 165/255)
PP3Qi.TextColor3 = Color3.new(1, 1, 1)
PP3Qi.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
PP3Qi.Position = UDim2.new(0, 5, 0, 780)
PP3Qi.Size = UDim2.new(0, 365, 0, 20)
PP3Qi.Font = Enum.Font.Fantasy
PP3Qi.Text = "Tp to Bridge [10B x PP] 3Qi+ PP required"
PP3Qi.TextWrapped = true
PP3Qi.TextSize = 16

PP50Qi.Name = "PP50Qi"
PP50Qi.Parent = WayPointsFrame
PP50Qi.BackgroundColor3 = Color3.new(66/255, 0, 165/255)
PP50Qi.TextColor3 = Color3.new(1, 1, 1)
PP50Qi.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
PP50Qi.Position = UDim2.new(0, 5, 0, 805)
PP50Qi.Size = UDim2.new(0, 365, 0, 20)
PP50Qi.Font = Enum.Font.Fantasy
PP50Qi.Text = "Tp to Bridge [100B x PP] 50Qi+ PP required"
PP50Qi.TextWrapped = true
PP50Qi.TextSize = 16

PP1Sx.Name = "PP1Sx"
PP1Sx.Parent = WayPointsFrame
PP1Sx.BackgroundColor3 = Color3.new(66/255, 0, 165/255)
PP1Sx.TextColor3 = Color3.new(1, 1, 1)
PP1Sx.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
PP1Sx.Position = UDim2.new(0, 5, 0, 830)
PP1Sx.Size = UDim2.new(0, 365, 0, 20)
PP1Sx.Font = Enum.Font.Fantasy
PP1Sx.Text = "Tp to Sakura Tree [1T x PP] 1Sx+ PP required"
PP1Sx.TextWrapped = true
PP1Sx.TextSize = 16

-- Farm

FarmExp.Name = "FarmExp"
FarmExp.Parent = MainFrame
FarmExp.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
FarmExp.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
FarmExp.Position = UDim2.new(0, 135, 0, 5)
FarmExp.Size = UDim2.new(0, 45, 0, 20)
FarmExp.Font = Enum.Font.Fantasy
FarmExp.TextColor3 = Color3.new(1, 1, 1)
FarmExp.Text = "Farm"
FarmExp.TextSize = 17
FarmExp.TextWrapped = true

FarmExpFrame.Name = "FarmExpFrame"
FarmExpFrame.Parent = MainFrame
FarmExpFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
FarmExpFrame.BorderColor3 = Color3.new(0, 0, 0)
FarmExpFrame.BackgroundTransparency = 0.2
FarmExpFrame.Position = UDim2.new(0, 60.5, 0, 33)
FarmExpFrame.Size = UDim2.new(0, 210, 0, 80)
FarmExpFrame.Visible = false

FarmFist.Name = "FarmFist"
FarmFist.Parent = FarmExpFrame
FarmFist.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
FarmFist.TextColor3 = Color3.new(1, 1, 1)
FarmFist.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
FarmFist.Position = UDim2.new(0, 5, 0, 5)
FarmFist.Size = UDim2.new(0, 200, 0, 20)
FarmFist.Font = Enum.Font.Fantasy
FarmFist.Text = "Farm Fist Strength: OFF"
FarmFist.TextWrapped = true
FarmFist.TextSize = 16

FarmBody.Name = "FarmBody"
FarmBody.Parent = FarmExpFrame
FarmBody.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
FarmBody.TextColor3 = Color3.new(1, 1, 1)
FarmBody.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
FarmBody.Position = UDim2.new(0, 5, 0, 30)
FarmBody.Size = UDim2.new(0, 200, 0, 20)
FarmBody.Font = Enum.Font.Fantasy
FarmBody.Text = "Farm Body Toughness: OFF"
FarmBody.TextWrapped = true
FarmBody.TextSize = 16

FarmPsychic.Name = "FarmPsychic"
FarmPsychic.Parent = FarmExpFrame
FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
FarmPsychic.TextColor3 = Color3.new(1, 1, 1)
FarmPsychic.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
FarmPsychic.Position = UDim2.new(0, 5, 0, 55)
FarmPsychic.Size = UDim2.new(0, 200, 0, 20)
FarmPsychic.Font = Enum.Font.Fantasy
FarmPsychic.Text = "Farm Psychic Power: OFF"
FarmPsychic.TextWrapped = true
FarmPsychic.TextSize = 16


-- Others

esptrack.Name = "esptrack"
esptrack.Parent = MainFrame
esptrack.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
esptrack.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
esptrack.Position = UDim2.new(0, 190, 0, 5)
esptrack.Size = UDim2.new(0, 35, 0, 20)
esptrack.TextColor3 = Color3.new(1, 1, 1)
esptrack.Font = Enum.Font.Fantasy
esptrack.Text = "ESP"
esptrack.TextSize = 16
esptrack.TextWrapped = true

-- Top Players

PlayerInfo.Name = "PlayerInfo"
PlayerInfo.Parent = MainFrame
PlayerInfo.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
PlayerInfo.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
PlayerInfo.Position = UDim2.new(0, 235, 0, 5)
PlayerInfo.Size = UDim2.new(0, 85, 0, 20)
PlayerInfo.TextColor3 = Color3.new(1, 1, 1)
PlayerInfo.Font = Enum.Font.Fantasy
PlayerInfo.Text = "Top Players"
PlayerInfo.TextSize = 16
PlayerInfo.TextWrapped = true

PlayerInfoFrame.Name = "PlayerInfoFrame"
PlayerInfoFrame.Parent = MainFrame
PlayerInfoFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
PlayerInfoFrame.BorderColor3 = Color3.new(0, 0, 0)
PlayerInfoFrame.BackgroundTransparency = 0.2
PlayerInfoFrame.Position = UDim2.new(0, 377.5, 0, 33)
PlayerInfoFrame.Size = UDim2.new(0, 160, 0, 225)
PlayerInfoFrame.Visible = false

ShowTopPlayers.Name = "ShowTopPlayers"
ShowTopPlayers.Parent = PlayerInfoFrame
ShowTopPlayers.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ShowTopPlayers.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
ShowTopPlayers.Position = UDim2.new(0, 5, 0, 5)
ShowTopPlayers.Size = UDim2.new(0, 150, 0, 20)
ShowTopPlayers.TextColor3 = Color3.new(1, 1, 1)
ShowTopPlayers.Font = Enum.Font.Fantasy
ShowTopPlayers.Text = "Top Players in Server"
ShowTopPlayers.TextSize = 16
ShowTopPlayers.TextWrapped = true

PlayerInfoStatsFrame.Name = "PlayerInfoStatsFrame"
PlayerInfoStatsFrame.Parent = MainGUI
PlayerInfoStatsFrame.BackgroundColor3 = Color3.new(0, 0, 0)
PlayerInfoStatsFrame.BorderColor3 = Color3.new(0.5, 0.5, 0.5)
PlayerInfoStatsFrame.BackgroundTransparency = 0
PlayerInfoStatsFrame.Position = UDim2.new(0.5, -427.5, 1, -120)
PlayerInfoStatsFrame.Size = UDim2.new(0, 855, 0, 115)
PlayerInfoStatsFrame.Active = true
PlayerInfoStatsFrame.Selectable = true
PlayerInfoStatsFrame.Draggable = true
PlayerInfoStatsFrame.ZIndex = 8
PlayerInfoStatsFrame.Visible = false

PlayerInfoStatsClose.Name = "PlayerInfoStatsClose"
PlayerInfoStatsClose.Parent = PlayerInfoStatsFrame
PlayerInfoStatsClose.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
PlayerInfoStatsClose.BorderColor3 = Color3.new(0.6, 0.6, 0.6)
PlayerInfoStatsClose.Position = UDim2.new(0, 5, 0, 5)
PlayerInfoStatsClose.Size = UDim2.new(0, 20, 0, 20)
PlayerInfoStatsClose.Font = Enum.Font.Fantasy
PlayerInfoStatsClose.Text = "X"
PlayerInfoStatsClose.TextColor3 = Color3.new(1, 0, 0)
PlayerInfoStatsClose.TextSize = 17
PlayerInfoStatsClose.ZIndex = 8
PlayerInfoStatsClose.TextScaled = true
PlayerInfoStatsClose.TextWrapped = true

StatBestFistText1.Name = "StatBestFistText1"
StatBestFistText1.Parent = PlayerInfoStatsFrame
StatBestFistText1.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
StatBestFistText1.BackgroundTransparency = 1
StatBestFistText1.Position = UDim2.new(0, 30, 0, 2)
StatBestFistText1.Size = UDim2.new(0, 160, 0, 20)
StatBestFistText1.TextColor3 = Color3.new(1, 1, 1)
StatBestFistText1.Font = Enum.Font.Fantasy
StatBestFistText1.Text = "Top Fist Player"
StatBestFistText1.ZIndex = 8
StatBestFistText1.TextSize = 13

ShowStatsFist1.Name = "ShowStatsFist1"
ShowStatsFist1.Parent = PlayerInfoStatsFrame
ShowStatsFist1.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ShowStatsFist1.BackgroundTransparency = 1
ShowStatsFist1.Position = UDim2.new(0, 30, 0, 22)
ShowStatsFist1.Size = UDim2.new(0, 50, 0, 90)
ShowStatsFist1.Font = Enum.Font.Fantasy
ShowStatsFist1.TextColor3 = Color3.new(1, 1, 0)
ShowStatsFist1.Text = "Fist:\nBody:\nSpeed:\nJump:\nPsychic:"
ShowStatsFist1.TextSize = 14
ShowStatsFist1.ZIndex = 8
ShowStatsFist1.TextXAlignment = Enum.TextXAlignment.Right

ShowStatsFist2.Name = "ShowStatsFist2"
ShowStatsFist2.Parent = PlayerInfoStatsFrame
ShowStatsFist2.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ShowStatsFist2.BackgroundTransparency = 1
ShowStatsFist2.Position = UDim2.new(0, 85, 0, 22)
ShowStatsFist2.Size = UDim2.new(0, 105, 0, 90)
ShowStatsFist2.Font = Enum.Font.Fantasy
ShowStatsFist2.TextColor3 = Color3.new(1, 1, 1)
ShowStatsFist2.Text = "Stats"
ShowStatsFist2.TextSize = 14
ShowStatsFist2.ZIndex = 8
ShowStatsFist2.TextXAlignment = Enum.TextXAlignment.Right

StatBestBodyText1.Name = "StatBestBodyText1"
StatBestBodyText1.Parent = PlayerInfoStatsFrame
StatBestBodyText1.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
StatBestBodyText1.BackgroundTransparency = 1
StatBestBodyText1.Position = UDim2.new(0, 195, 0, 2)
StatBestBodyText1.Size = UDim2.new(0, 160, 0, 20)
StatBestBodyText1.TextColor3 = Color3.new(1, 1, 1)
StatBestBodyText1.Font = Enum.Font.Fantasy
StatBestBodyText1.Text = "Top Body Player"
StatBestBodyText1.ZIndex = 8
StatBestBodyText1.TextSize = 13

ShowStatsBody1.Name = "ShowStatsBody1"
ShowStatsBody1.Parent = PlayerInfoStatsFrame
ShowStatsBody1.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ShowStatsBody1.BackgroundTransparency = 1
ShowStatsBody1.Position = UDim2.new(0, 195, 0, 22)
ShowStatsBody1.Size = UDim2.new(0, 50, 0, 90)
ShowStatsBody1.Font = Enum.Font.Fantasy
ShowStatsBody1.TextColor3 = Color3.new(1, 1, 0)
ShowStatsBody1.Text = "Fist:\nBody:\nSpeed:\nJump:\nPsychic:"
ShowStatsBody1.TextSize = 14
ShowStatsBody1.ZIndex = 8
ShowStatsBody1.TextXAlignment = Enum.TextXAlignment.Right

ShowStatsBody2.Name = "ShowStatsBody2"
ShowStatsBody2.Parent = PlayerInfoStatsFrame
ShowStatsBody2.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ShowStatsBody2.BackgroundTransparency = 1
ShowStatsBody2.Position = UDim2.new(0, 250, 0, 22)
ShowStatsBody2.Size = UDim2.new(0, 105, 0, 90)
ShowStatsBody2.Font = Enum.Font.Fantasy
ShowStatsBody2.TextColor3 = Color3.new(1, 1, 1)
ShowStatsBody2.Text = "Stats"
ShowStatsBody2.TextSize = 14
ShowStatsBody2.ZIndex = 8
ShowStatsBody2.TextXAlignment = Enum.TextXAlignment.Right

StatBestSpeedText1.Name = "StatBestSpeedText1"
StatBestSpeedText1.Parent = PlayerInfoStatsFrame
StatBestSpeedText1.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
StatBestSpeedText1.BackgroundTransparency = 1
StatBestSpeedText1.Position = UDim2.new(0, 360, 0, 2)
StatBestSpeedText1.Size = UDim2.new(0, 160, 0, 20)
StatBestSpeedText1.TextColor3 = Color3.new(1, 1, 1)
StatBestSpeedText1.Font = Enum.Font.Fantasy
StatBestSpeedText1.Text = "Top Speed Player"
StatBestSpeedText1.ZIndex = 8
StatBestSpeedText1.TextSize = 13

ShowStatsSpeed1.Name = "ShowStatsSpeed1"
ShowStatsSpeed1.Parent = PlayerInfoStatsFrame
ShowStatsSpeed1.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ShowStatsSpeed1.BackgroundTransparency = 1
ShowStatsSpeed1.Position = UDim2.new(0, 360, 0, 22)
ShowStatsSpeed1.Size = UDim2.new(0, 50, 0, 90)
ShowStatsSpeed1.Font = Enum.Font.Fantasy
ShowStatsSpeed1.TextColor3 = Color3.new(1, 1, 0)
ShowStatsSpeed1.Text = "Fist:\nBody:\nSpeed:\nJump:\nPsychic:"
ShowStatsSpeed1.TextSize = 14
ShowStatsSpeed1.ZIndex = 8
ShowStatsSpeed1.TextXAlignment = Enum.TextXAlignment.Right

ShowStatsSpeed2.Name = "ShowStatsSpeed2"
ShowStatsSpeed2.Parent = PlayerInfoStatsFrame
ShowStatsSpeed2.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ShowStatsSpeed2.BackgroundTransparency = 1
ShowStatsSpeed2.Position = UDim2.new(0, 415, 0, 22)
ShowStatsSpeed2.Size = UDim2.new(0, 105, 0, 90)
ShowStatsSpeed2.Font = Enum.Font.Fantasy
ShowStatsSpeed2.TextColor3 = Color3.new(1, 1, 1)
ShowStatsSpeed2.Text = "Stats"
ShowStatsSpeed2.TextSize = 14
ShowStatsSpeed2.ZIndex = 8
ShowStatsSpeed2.TextXAlignment = Enum.TextXAlignment.Right

StatBestJumpText1.Name = "StatBestJumpText1"
StatBestJumpText1.Parent = PlayerInfoStatsFrame
StatBestJumpText1.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
StatBestJumpText1.BackgroundTransparency = 1
StatBestJumpText1.Position = UDim2.new(0, 525, 0, 2)
StatBestJumpText1.Size = UDim2.new(0, 160, 0, 20)
StatBestJumpText1.TextColor3 = Color3.new(1, 1, 1)
StatBestJumpText1.Font = Enum.Font.Fantasy
StatBestJumpText1.Text = "Top Jump Player"
StatBestJumpText1.ZIndex = 8
StatBestJumpText1.TextSize = 13

ShowStatsJump1.Name = "ShowStatsJump1"
ShowStatsJump1.Parent = PlayerInfoStatsFrame
ShowStatsJump1.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ShowStatsJump1.BackgroundTransparency = 1
ShowStatsJump1.Position = UDim2.new(0, 525, 0, 22)
ShowStatsJump1.Size = UDim2.new(0, 50, 0, 90)
ShowStatsJump1.Font = Enum.Font.Fantasy
ShowStatsJump1.TextColor3 = Color3.new(1, 1, 0)
ShowStatsJump1.Text = "Fist:\nBody:\nSpeed:\nJump:\nPsychic:"
ShowStatsJump1.TextSize = 14
ShowStatsJump1.ZIndex = 8
ShowStatsJump1.TextXAlignment = Enum.TextXAlignment.Right

ShowStatsJump2.Name = "ShowStatsJump2"
ShowStatsJump2.Parent = PlayerInfoStatsFrame
ShowStatsJump2.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ShowStatsJump2.BackgroundTransparency = 1
ShowStatsJump2.Position = UDim2.new(0, 580, 0, 22)
ShowStatsJump2.Size = UDim2.new(0, 105, 0, 90)
ShowStatsJump2.Font = Enum.Font.Fantasy
ShowStatsJump2.TextColor3 = Color3.new(1, 1, 1)
ShowStatsJump2.Text = "Stats"
ShowStatsJump2.TextSize = 14
ShowStatsJump2.ZIndex = 8
ShowStatsJump2.TextXAlignment = Enum.TextXAlignment.Right

StatBestPsychicText1.Name = "StatBestPsychicText1"
StatBestPsychicText1.Parent = PlayerInfoStatsFrame
StatBestPsychicText1.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
StatBestPsychicText1.BackgroundTransparency = 1
StatBestPsychicText1.Position = UDim2.new(0, 690, 0, 2)
StatBestPsychicText1.Size = UDim2.new(0, 160, 0, 20)
StatBestPsychicText1.TextColor3 = Color3.new(1, 1, 1)
StatBestPsychicText1.Font = Enum.Font.Fantasy
StatBestPsychicText1.Text = "Top Psychic Player"
StatBestPsychicText1.ZIndex = 8
StatBestPsychicText1.TextSize = 13

ShowStatsPsychic1.Name = "ShowStatsPsychic1"
ShowStatsPsychic1.Parent = PlayerInfoStatsFrame
ShowStatsPsychic1.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ShowStatsPsychic1.BackgroundTransparency = 1
ShowStatsPsychic1.Position = UDim2.new(0, 690, 0, 22)
ShowStatsPsychic1.Size = UDim2.new(0, 50, 0, 90)
ShowStatsPsychic1.Font = Enum.Font.Fantasy
ShowStatsPsychic1.TextColor3 = Color3.new(1, 1, 0)
ShowStatsPsychic1.Text = "Fist:\nBody:\nSpeed:\nJump:\nPsychic:"
ShowStatsPsychic1.TextSize = 14
ShowStatsPsychic1.ZIndex = 8
ShowStatsPsychic1.TextXAlignment = Enum.TextXAlignment.Right

ShowStatsPsychic2.Name = "ShowStatsPsychic2"
ShowStatsPsychic2.Parent = PlayerInfoStatsFrame
ShowStatsPsychic2.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ShowStatsPsychic2.BackgroundTransparency = 1
ShowStatsPsychic2.Position = UDim2.new(0, 745, 0, 22)
ShowStatsPsychic2.Size = UDim2.new(0, 105, 0, 90)
ShowStatsPsychic2.Font = Enum.Font.Fantasy
ShowStatsPsychic2.TextColor3 = Color3.new(1, 1, 1)
ShowStatsPsychic2.Text = "Stats"
ShowStatsPsychic2.TextSize = 14
ShowStatsPsychic2.ZIndex = 8
ShowStatsPsychic2.TextXAlignment = Enum.TextXAlignment.Right

-- Stats Checker

PlayerName.Name = "PlayerName"
PlayerName.Parent = MainFrame
PlayerName.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
PlayerName.BackgroundTransparency = 0
PlayerName.BorderColor3 = Color3.new(1, 1, 1)
PlayerName.BorderSizePixel = 1
PlayerName.Position = UDim2.new(0, 335, 0, 5)
PlayerName.Size = UDim2.new(0, 150, 0, 20)
PlayerName.Font = Enum.Font.Fantasy
PlayerName.TextColor3 = Color3.new(1, 1, 1)
PlayerName.Text = tostring(MyPlr.Name)
PlayerName.TextSize = 15
PlayerName.TextScaled = true
PlayerName.TextWrapped = false

StatsFrame.Name = "StatsFrame"
StatsFrame.Parent = MainFrame
StatsFrame.Active = true
StatsFrame.Draggable = true
StatsFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
StatsFrame.BorderColor3 = Color3.new(1, 1, 1)
StatsFrame.BackgroundTransparency = 0.5
StatsFrame.BorderSizePixel = 2
StatsFrame.Position = UDim2.new(0, 330, 0, 33)
StatsFrame.Size = UDim2.new(0, 161, 0, 90)
StatsFrame.Visible = false

ShowStats1.Name = "ShowStats1"
ShowStats1.Parent = StatsFrame
ShowStats1.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ShowStats1.BackgroundTransparency = 1
ShowStats1.Position = UDim2.new(0, 0, 0, 0)
ShowStats1.Size = UDim2.new(0, 50, 0, 90)
ShowStats1.Font = Enum.Font.Fantasy
ShowStats1.TextColor3 = Color3.new(1, 1, 1)
ShowStats1.Text = " "
ShowStats1.TextSize = 15
ShowStats1.TextXAlignment = Enum.TextXAlignment.Right

ShowStats2.Name = "ShowStats2"
ShowStats2.Parent = StatsFrame
ShowStats2.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ShowStats2.BackgroundTransparency = 1
ShowStats2.Position = UDim2.new(0, 55, 0, 0)
ShowStats2.Size = UDim2.new(0, 103, 0, 90)
ShowStats2.Font = Enum.Font.Fantasy
ShowStats2.TextColor3 = Color3.new(1, 1, 1)
ShowStats2.Text = "Stats"
ShowStats2.TextSize = 15
ShowStats2.TextXAlignment = Enum.TextXAlignment.Right

PlayerName1.Name = "PlayerName1"
PlayerName1.Parent = MainFrame1
PlayerName1.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
PlayerName1.BackgroundTransparency = 0
PlayerName1.BorderColor3 = Color3.new(1, 1, 1)
PlayerName1.BorderSizePixel = 1
PlayerName1.Position = UDim2.new(0, 45, 0, 5)
PlayerName1.Size = UDim2.new(0, 150, 0, 20)
PlayerName1.Font = Enum.Font.Fantasy
PlayerName1.TextColor3 = Color3.new(1, 1, 1)
PlayerName1.Text = tostring(MyPlr.Name)
PlayerName1.TextSize = 15
PlayerName1.TextScaled = true
PlayerName1.TextWrapped = false

StatsFrame1.Name = "StatsFrame1"
StatsFrame1.Parent = MainFrame1
StatsFrame1.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
StatsFrame1.BorderColor3 = Color3.new(1, 1, 1)
StatsFrame1.BackgroundTransparency = 0.5
StatsFrame1.BorderSizePixel = 2
StatsFrame1.Position = UDim2.new(0, 0, 0, 33)
StatsFrame1.Size = UDim2.new(0, 235, 0, 120)
StatsFrame1.Visible = false

ShowStats3.Name = "ShowStats3"
ShowStats3.Parent = StatsFrame1
ShowStats3.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ShowStats3.BackgroundTransparency = 1
ShowStats3.Position = UDim2.new(0, 15, 0, 15)
ShowStats3.Size = UDim2.new(0, 50, 0, 90)
ShowStats3.Font = Enum.Font.Fantasy
ShowStats3.TextColor3 = Color3.new(1, 1, 1)
ShowStats3.Text = " "
ShowStats3.TextSize = 20
ShowStats3.TextXAlignment = Enum.TextXAlignment.Right

ShowStats4.Name = "ShowStats4"
ShowStats4.Parent = StatsFrame1
ShowStats4.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ShowStats4.BackgroundTransparency = 1
ShowStats4.Position = UDim2.new(0, 130, 0, 15)
ShowStats4.Size = UDim2.new(0, 103, 0, 90)
ShowStats4.Font = Enum.Font.Fantasy
ShowStats4.TextColor3 = Color3.new(1, 1, 1)
ShowStats4.Text = "Stats"
ShowStats4.TextSize = 20
ShowStats4.TextXAlignment = Enum.TextXAlignment.Right

-- Close --

Open.MouseButton1Down:connect(function()
	TopFrame.Visible = false
	MainFrame.Visible = true
	if autoclick == false then
		Enable.Visible = true
	elseif autoclick == true then
		Disable.Visible = true
	end
end)

Minimize.MouseButton1Down:connect(function()
	TopFrame.Visible = true
	MainFrame.Visible = false
	Enable.Visible = false
	Disable.Visible = false
end)

Close.MouseButton1Down:connect(function()
	MainGUI:Destroy()
	farmpsychicactive = false
	farmfistactive = false
	farmbodyactive = false
	workspace[plr.Name].HumanoidRootPart.Anchored = false
	playerdied = false
	deathreturnactive = false
	autoclick = false
	RemoveESP()
end)

-- Menus --

local Menus = {
	[WayPoints] = WayPointsFrame;
	[FarmExp] = FarmExpFrame;
}
for button,frame in pairs(Menus) do
	button.MouseButton1Click:connect(function()
		if frame.Visible then
			frame.Visible = false
			return
		end
		for k,v in pairs(Menus) do
			v.Visible = v == frame
		end
	end)
end

-- FarmBody.MouseEnter:connect(function()
-- 	FarmBodyLabel.Visible = true
-- end)

-- Round Number to decimal places and convert to letter value --

function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end
		
function converttoletter(num)
	if num / 1e57 >=1 then
		newnum = num / 1e57
		return round(newnum, 3).. "OcDe"
	elseif num / 1e54 >=1 then
		newnum = num / 1e54
		return round(newnum, 3).. "SpDe"
	elseif num / 1e51 >=1 then
		newnum = num / 1e51
		return round(newnum, 3).. "SxDe"
	elseif num / 1e48 >=1 then
		newnum = num / 1e48
		return round(newnum, 3).. "QiDe"
	elseif num / 1e45 >=1 then
		newnum = num / 1e45
		return round(newnum, 3).. "QaDe"
	elseif num / 1e42 >=1 then
		newnum = num / 1e42
		return round(newnum, 3).. "TDe"
	elseif num / 1e39 >=1 then
		newnum = num / 1e39
		return round(newnum, 3).. "DDe"
	elseif num / 1e36 >=1 then
		newnum = num / 1e36
		return round(newnum, 3).. "Un"
	elseif num / 1e33 >=1 then
		newnum = num / 1e33
		return round(newnum, 3).. "De"
	elseif num / 1e30 >=1 then
		newnum = num / 1e30
		return round(newnum, 3).. "No"
	elseif num / 1e27 >=1 then
		newnum = num / 1e27
		return round(newnum, 3).. "Oc"
	elseif num / 1e24 >=1 then
		newnum = num / 1e24
		return round(newnum, 3).. "Sp"
	elseif num / 1e21 >=1 then
		newnum = num / 1e21
		return round(newnum, 3).. "Sx"
	elseif num / 1e18 >=1 then
		newnum = num / 1e18
		return round(newnum, 3).. "Qi"
	elseif num / 1e15 >=1 then
		newnum = num / 1e15
		return round(newnum, 3).. "Qa"
	elseif num / 1e12 >=1 then
		newnum = num / 1e12
		return round(newnum, 3).. "T"
	elseif num / 1e09 >=1 then
		newnum = num / 1e09
		return round(newnum, 3).. "B"
	elseif num / 1e06 >=1 then
		newnum = num / 1e06
		return round(newnum, 3).. "M"
	elseif num / 1e03 >=1 then
		newnum = num / 1e03
		return round(newnum, 3).. "K"
	else return num
	end
end

-- Waypoints

SafeZone.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-190.5, 50, 28)
	WayPointsFrame.Visible = false
end)

-- FS

FS1k.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-92, 60, -66)
	WayPointsFrame.Visible = false
end)

FS100k100M.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2425, 55, -2297)
	WayPointsFrame.Visible = false
end)

FS1B.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-143, 1558, -68)
	WayPointsFrame.Visible = false
end)

FS100B.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(179, 2520, -466)
	WayPointsFrame.Visible = false
end)

FS1T.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(207, 3500, 113)
	WayPointsFrame.Visible = false
end)

FS100T.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(812, 5581, -1697)
	WayPointsFrame.Visible = false
end)

FS5Qa.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1135, 1816, 985)
	WayPointsFrame.Visible = false
end)

FS35Qa.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-224, 513, 328)
	WayPointsFrame.Visible = false
end)

FS500Qa.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2300, 7290, 2636)
	WayPointsFrame.Visible = false
end)

FS5Qi.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1926, 13220, 2144)
	WayPointsFrame.Visible = false
end)

FS350Qi.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2790, 21225, -2944)
	WayPointsFrame.Visible = false
end)

-- BT

BT1k.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-225, 45, -288)
	WayPointsFrame.Visible = false
end)

BT100k.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1479, 52, 1108)
	WayPointsFrame.Visible = false
end)

BT1M.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-502, 270, -1255)
	WayPointsFrame.Visible = false
end)

BT100M.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2440.62, 558.521, -2338.16)
	WayPointsFrame.Visible = false
end)

BT1B.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-242, 40, -320)
	WayPointsFrame.Visible = false
end)

BT100B.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-248, 40, -350)
	WayPointsFrame.Visible = false
end)

BT1T.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-80, 40, -325)
	WayPointsFrame.Visible = false
end)

BT100T.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-82, 45, -370)
	WayPointsFrame.Visible = false
end)

BT5Qa.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-78, 44, -412)
	WayPointsFrame.Visible = false
end)

BT35Qa.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-245, 40, -404)
	WayPointsFrame.Visible = false
end)

BT500Qa.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1805, 45, 653)
	WayPointsFrame.Visible = false
end)

BT5Qi.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1810, 60, 756)
	WayPointsFrame.Visible = false
end)

BT350Qi.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1823, 61, 802)
	WayPointsFrame.Visible = false
end)

-- PP

PP10k.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-108, 774, -86)
	WayPointsFrame.Visible = false
end)

PP1M.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-340, 1055, -263)
	WayPointsFrame.Visible = false
end)

PP1B.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-352, 1055, -133)
	WayPointsFrame.Visible = false
end)

PP1T.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-323, 1067, -196)
	WayPointsFrame.Visible = false
end)

PP1Qa.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-423, 1120, -267)
	WayPointsFrame.Visible = false
end)

PP350Qa.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-429, 1120, -140)
	WayPointsFrame.Visible = false
end)

PP3Qi.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-425, 1144, -200)
	WayPointsFrame.Visible = false
end)

PP50Qi.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-496, 1234, -209)
	WayPointsFrame.Visible = false
end)

PP1Sx.MouseButton1Click:connect(function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(462, 1010, -844)
	WayPointsFrame.Visible = false
end)

-- ESP Stuff --

Run:BindToRenderStep("UpdateESP", Enum.RenderPriority.Character.Value, function()
	for _, v in next, Plrs:GetPlayers() do
		UpdateESP(v)
	end
end)

-- Clicker

Enable.Name = "Enable"
Enable.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Enable.BackgroundTransparency = 0.5
Enable.BorderColor3 = Color3.new(1, 1, 1)
Enable.BorderSizePixel = 2
Enable.Size = UDim2.new(0, 90, 0, 30)
Enable.Position = UDim2.new(0.32, 0, 0, -32)
Enable.Font = Enum.Font.Fantasy
Enable.Text = "Disabled"
Enable.TextColor3 = Color3.new(1, 1, 1)
Enable.TextSize = 18
Enable.Visible = true

Disable.Name = "Disable"
Disable.BackgroundColor3 = Color3.new(0, 0.5, 0)
Disable.BackgroundTransparency = 0.5
Disable.BorderColor3 = Color3.new(1, 1, 1)
Disable.BorderSizePixel = 2
Disable.Size = UDim2.new(0, 90, 0, 30)
Disable.Position = UDim2.new(0.32, 0, 0, -32)
Disable.Font = Enum.Font.Fantasy
Disable.Text = "Enabled"
Disable.TextColor3 = Color3.new(1, 1, 1)
Disable.TextSize = 18
Disable.Visible = false


Disable.MouseButton1Down:connect(function()
	autoclick = false
	deathreturnactive = false
	print("Clicker: " ..tostring(autoclick))
	Disable.Visible = false
	Enable.Visible = true
end)

Enable.MouseButton1Down:connect(function()
	autoclick = true
	deathreturnactive = true
	print("Clicker: " ..tostring(autoclick))
	Disable.Visible = true
	Enable.Visible = false
end)

spawn(function()
	while true do
		if autoclick == true then
    		VirtualUser:CaptureController()
    		VirtualUser:ClickButton1(Vector2.new())
		end
		wait(1)
	end
	wait(1)
end)

-- Farm Exp --
FarmFist.MouseButton1Click:Connect(function()
	if farmfistactive ~= true then
		farmfistactive = true
		FarmFist.BackgroundColor3 = Color3.new(0, 0.5, 0)
		FarmFist.Text = "Farm Fist Strength: ON"
		deathreturnactive = false
		if tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.FS.Value)) >= 350e18 then
			workspace[plr.Name].HumanoidRootPart.Anchored = false
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2790, 21225, -2944)
			wait(0.1)
			workspace[plr.Name].HumanoidRootPart.Anchored = true
			loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/FSToolEquip"))()
		elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.FS.Value)) >= 5e18 then
			workspace[plr.Name].HumanoidRootPart.Anchored = false
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1926, 13220, 2144)
			wait(0.1)
			workspace[plr.Name].HumanoidRootPart.Anchored = true
			loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/FSToolEquip"))()
		elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.FS.Value)) >= 500e15 then
			workspace[plr.Name].HumanoidRootPart.Anchored = false
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2300, 7290, 2636)
			wait(0.1)
			workspace[plr.Name].HumanoidRootPart.Anchored = true
			loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/FSToolEquip"))()
		elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.FS.Value)) >= 35e15 then
			workspace[plr.Name].HumanoidRootPart.Anchored = false
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-224, 513, 328)
			wait(0.1)
			workspace[plr.Name].HumanoidRootPart.Anchored = true
			loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/FSToolEquip"))()
		elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.FS.Value)) >= 5e15 then
			workspace[plr.Name].HumanoidRootPart.Anchored = false
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1135, 1816, 985)
			wait(0.1)
			workspace[plr.Name].HumanoidRootPart.Anchored = true
			loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/FSToolEquip"))()
		elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.FS.Value)) >= 100e12 then
			workspace[plr.Name].HumanoidRootPart.Anchored = false
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(812, 5581, -1697)
			wait(0.1)
			workspace[plr.Name].HumanoidRootPart.Anchored = true
			loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/FSToolEquip"))()
		elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.FS.Value)) >= 1e12 then
			workspace[plr.Name].HumanoidRootPart.Anchored = false
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(207, 3500, 113)
			wait(0.1)
			workspace[plr.Name].HumanoidRootPart.Anchored = true
			loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/FSToolEquip"))()
		elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.FS.Value)) >= 100e09 then
			workspace[plr.Name].HumanoidRootPart.Anchored = false
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(179, 2520, -466)
			wait(0.1)
			workspace[plr.Name].HumanoidRootPart.Anchored = true
			loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/FSToolEquip"))()
		elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.FS.Value)) >= 1e09 then
			workspace[plr.Name].HumanoidRootPart.Anchored = false
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-143, 1558, -68)
			wait(0.1)
			workspace[plr.Name].HumanoidRootPart.Anchored = true
			loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/FSToolEquip"))()
		elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.FS.Value)) >= 100e06 then
			workspace[plr.Name].HumanoidRootPart.Anchored = false
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2476, 54, -2369)
			workspace[plr.Name].HumanoidRootPart.Anchored = true
			loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/FSToolEquip"))()
		elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.FS.Value)) >= 1e06 then
			workspace[plr.Name].HumanoidRootPart.Anchored = false
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2400, 54, -2325)
			workspace[plr.Name].HumanoidRootPart.Anchored = true
			loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/FSToolEquip"))()
		elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.FS.Value)) >= 100e03 then
			workspace[plr.Name].HumanoidRootPart.Anchored = false
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2468, 54, -2309)
			workspace[plr.Name].HumanoidRootPart.Anchored = true
			loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/FSToolEquip"))()
		elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.FS.Value)) >= 1e03 then
			workspace[plr.Name].HumanoidRootPart.Anchored = false
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-92, 50, -66)
			wait(0.1)
			workspace[plr.Name].HumanoidRootPart.Anchored = true
			loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/FSToolEquip"))()
		end
	else 
		farmfistactive = false
		FarmFist.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
		FarmFist.Text = "Farm Fist Strength: OFF"
		workspace[plr.Name].HumanoidRootPart.Anchored = false
		deathreturnactive = false
		wait(1)
		human:UnequipTools()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-190.5, 50, 28)
	end
end)

FarmBody.MouseButton1Click:Connect(function()
	if farmbodyactive ~= true then
		farmbodyactive = true
		FarmBody.BackgroundColor3 = Color3.new(0, 0.5, 0)
		FarmBody.Text = "Farm Body Toughness: ON"
		workspace[plr.Name].HumanoidRootPart.Anchored = false
		deathreturnactive = true
	else
		farmbodyactive = false
		FarmBody.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
		FarmBody.Text = "Farm Body Toughness: OFF"
		workspace[plr.Name].HumanoidRootPart.Anchored = false
		deathreturnactive = false
		wait(1)
		human:UnequipTools()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-190.5, 50, 28)
	end
end)

FarmPsychic.MouseButton1Click:Connect(function()
	if farmpsychicactive ~= true then
		farmpsychicactive = true
		FarmPsychic.BackgroundColor3 = Color3.new(0, 0.5, 0)
		FarmPsychic.Text = "Farm Psychic Power: ON"
		workspace[plr.Name].HumanoidRootPart.Anchored = false
		deathreturnactive = true
	else
		farmpsychicactive = false
		FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
		FarmPsychic.Text = "Farm Psychic Power: OFF"
		workspace[plr.Name].HumanoidRootPart.Anchored = false
		deathreturnactive = false
		wait(1)
		human:UnequipTools()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-190.5, 50, 28)
	end
end)

spawn(function()
	while true do
		while farmfistactive and not playerdied do
			loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/FSToolEquip"))()
			wait(1)
			if tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.FS.Value)) >= 350e18 then
				farmpsychicactive = false
				farmbodyactive = false 
				FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmPsychic.Text = "Farm Psychic Power: OFF"
				FarmBody.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmBody.Text = "Farm Body Toughness: OFF"
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2790, 21025, -2944)
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.FS.Value)) >= 5e18 then
				farmpsychicactive = false
				farmbodyactive = false 
				FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmPsychic.Text = "Farm Psychic Power: OFF"
				FarmBody.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmBody.Text = "Farm Body Toughness: OFF"
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1926, 13100, 2144)
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.FS.Value)) >= 500e15 then
				farmpsychicactive = false
				farmbodyactive = false 
				FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmPsychic.Text = "Farm Psychic Power: OFF"
				FarmBody.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmBody.Text = "Farm Body Toughness: OFF"
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2300, 7100, 2636)
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.FS.Value)) >= 35e15 then
				farmpsychicactive = false
				farmbodyactive = false 
				FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmPsychic.Text = "Farm Psychic Power: OFF"
				FarmBody.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmBody.Text = "Farm Body Toughness: OFF"
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-233, 523, 321)
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.FS.Value)) >= 5e15 then
				farmpsychicactive = false
				farmbodyactive = false 
				FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmPsychic.Text = "Farm Psychic Power: OFF"
				FarmBody.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmBody.Text = "Farm Body Toughness: OFF"
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1125, 1846, 985)
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.FS.Value)) >= 100e12 then
				farmpsychicactive = false
				farmbodyactive = false 
				FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmPsychic.Text = "Farm Psychic Power: OFF"
				FarmBody.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmBody.Text = "Farm Body Toughness: OFF"
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(820, 5481, -1697)
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.FS.Value)) >= 1e12 then
				farmpsychicactive = false
				farmbodyactive = false 
				FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmPsychic.Text = "Farm Psychic Power: OFF"
				FarmBody.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmBody.Text = "Farm Body Toughness: OFF"
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(207, 3450, 113)
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.FS.Value)) >= 100e09 then
				farmpsychicactive = false
				farmbodyactive = false 
				FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmPsychic.Text = "Farm Psychic Power: OFF"
				FarmBody.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmBody.Text = "Farm Body Toughness: OFF"
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(179, 2480, -466)
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.FS.Value)) >= 1e09 then
				farmpsychicactive = false
				farmbodyactive = false 
				FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmPsychic.Text = "Farm Psychic Power: OFF"
				FarmBody.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmBody.Text = "Farm Body Toughness: OFF"
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-143, 1528, -68)
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.FS.Value)) >= 100e06 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2476, 54, -2369)
				workspace[plr.Name].HumanoidRootPart.Anchored = false
				workspace[plr.Name].HumanoidRootPart.Anchored = true
				farmpsychicactive = false
				farmbodyactive = false 
				FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmPsychic.Text = "Farm Psychic Power: OFF"
				FarmBody.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmBody.Text = "Farm Body Toughness: OFF"
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.FS.Value)) >= 1e06 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2400, 54, -2325)
				workspace[plr.Name].HumanoidRootPart.Anchored = false
				workspace[plr.Name].HumanoidRootPart.Anchored = true
				farmpsychicactive = false
				farmbodyactive = false 
				FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmPsychic.Text = "Farm Psychic Power: OFF"
				FarmBody.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmBody.Text = "Farm Body Toughness: OFF"
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.FS.Value)) >= 100e03 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2468, 54, -2309)
				workspace[plr.Name].HumanoidRootPart.Anchored = false
				workspace[plr.Name].HumanoidRootPart.Anchored = true
				farmpsychicactive = false
				farmbodyactive = false 
				FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmPsychic.Text = "Farm Psychic Power: OFF"
				FarmBody.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmBody.Text = "Farm Body Toughness: OFF"
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.FS.Value)) >= 1e03 then
				farmpsychicactive = false
				farmbodyactive = false 
				FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmPsychic.Text = "Farm Psychic Power: OFF"
				FarmBody.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmBody.Text = "Farm Body Toughness: OFF"
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-92, 30, -66)
			end
			wait(0.5)
			FSTool:Activate()
		end
		wait(1)
	end
end)

spawn(function()
	while true do
		if farmbodyactive and game.Players.LocalPlayer.Character:WaitForChild("Humanoid") then
			if tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.BT.Value)) >= 60e18 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1823, 59, 802)
				workspace[plr.Name].HumanoidRootPart.Anchored = false
				farmpsychicactive = false
				farmfistactive = false 
				FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmPsychic.Text = "Farm Psychic Power: OFF"
				FarmFist.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmFist.Text = "Farm Fist Strength: OFF"
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.BT.Value)) >= 1e18 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1810, 58, 756)
				workspace[plr.Name].HumanoidRootPart.Anchored = false
				farmpsychicactive = false
				farmfistactive = false  
				FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmPsychic.Text = "Farm Psychic Power: OFF"
				FarmFist.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmFist.Text = "Farm Fist Strength: OFF"
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.BT.Value)) >= 100e15 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1805, 45, 653)
				workspace[plr.Name].HumanoidRootPart.Anchored = false
				farmpsychicactive = false
				farmfistactive = false 
				FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmPsychic.Text = "Farm Psychic Power: OFF"
				FarmFist.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmFist.Text = "Farm Fist Strength: OFF"
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.BT.Value)) >= 5e15 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-245, 33, -404)
				workspace[plr.Name].HumanoidRootPart.Anchored = false
				farmpsychicactive = false
				farmfistactive = false 
				FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmPsychic.Text = "Farm Psychic Power: OFF"
				FarmFist.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmFist.Text = "Farm Fist Strength: OFF"
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.BT.Value)) >= 1e15 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-78, 33, -412)
				workspace[plr.Name].HumanoidRootPart.Anchored = false
				farmpsychicactive = false
				farmfistactive = false 
				FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmPsychic.Text = "Farm Psychic Power: OFF"
				FarmFist.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmFist.Text = "Farm Fist Strength: OFF"
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.BT.Value)) >= 50e12 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-82, 37, -370)
				workspace[plr.Name].HumanoidRootPart.Anchored = false
				farmpsychicactive = false
				farmfistactive = false 
				FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmPsychic.Text = "Farm Psychic Power: OFF"
				FarmFist.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmFist.Text = "Farm Fist Strength: OFF"
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.BT.Value)) >= 500e09 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-80, 37, -325)
				workspace[plr.Name].HumanoidRootPart.Anchored = false
				farmpsychicactive = false
				farmfistactive = false 
				FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmPsychic.Text = "Farm Psychic Power: OFF"
				FarmFist.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmFist.Text = "Farm Fist Strength: OFF"
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.BT.Value)) >= 50e09 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-248, 38, -350)
				workspace[plr.Name].HumanoidRootPart.Anchored = false
				farmpsychicactive = false
				farmfistactive = false  
				FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmPsychic.Text = "Farm Psychic Power: OFF"
				FarmFist.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmFist.Text = "Farm Fist Strength: OFF"
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.BT.Value)) >= 500e06 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-242, 38, -320)
				workspace[plr.Name].HumanoidRootPart.Anchored = false
				farmpsychicactive = false
				farmfistactive = false 
				FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmPsychic.Text = "Farm Psychic Power: OFF"
				FarmFist.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmFist.Text = "Farm Fist Strength: OFF"
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.BT.Value)) >= 50e06 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2440.62, 535, -2338.16)
				workspace[plr.Name].HumanoidRootPart.Anchored = false
				farmpsychicactive = false
				farmfistactive = false 
				FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmPsychic.Text = "Farm Psychic Power: OFF"
				FarmFist.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmFist.Text = "Farm Fist Strength: OFF"
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.BT.Value)) >= 500e03 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-502, 262, -1255)
				workspace[plr.Name].HumanoidRootPart.Anchored = false
				farmpsychicactive = false
				farmfistactive = false 
				FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmPsychic.Text = "Farm Psychic Power: OFF"
				FarmFist.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmFist.Text = "Farm Fist Strength: OFF"
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.BT.Value)) >= 50e03 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1479, 30, 1108)
				workspace[plr.Name].HumanoidRootPart.Anchored = false
				farmpsychicactive = false
				farmfistactive = false 
				FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmPsychic.Text = "Farm Psychic Power: OFF"
				FarmFist.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmFist.Text = "Farm Fist Strength: OFF"
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.BT.Value)) >= 5e02 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-225, 30, -288)
				workspace[plr.Name].HumanoidRootPart.Anchored = false
				farmpsychicactive = false
				farmfistactive = false  
				FarmPsychic.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmPsychic.Text = "Farm Psychic Power: OFF"
				FarmFist.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmFist.Text = "Farm Fist Strength: OFF"
			end
		end
		wait(1)
	end
	deathreturnactive = false
end)

spawn(function()
	while true do
		if farmpsychicactive and game.Players.LocalPlayer.Character:WaitForChild("Humanoid") then
			if tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.PP.Value)) >= 1e21 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(462, 1010, -844)
				workspace[plr.Name].HumanoidRootPart.Anchored = false
				farmfistactive = false
				farmbodyactive = false
				FarmBody.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmBody.Text = "Farm Body Toughness: OFF"
				FarmFist.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmFist.Text = "Farm Fist Strength: OFF"
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.PP.Value)) >= 50e18 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-496, 1234, -209)
				workspace[plr.Name].HumanoidRootPart.Anchored = false
				farmfistactive = false
				farmbodyactive = false
				FarmBody.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmBody.Text = "Farm Body Toughness: OFF"
				FarmFist.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmFist.Text = "Farm Fist Strength: OFF"
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.PP.Value)) >= 3e18 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-425, 1144, -200)
				workspace[plr.Name].HumanoidRootPart.Anchored = false
				farmfistactive = false
				farmbodyactive = false
				FarmBody.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmBody.Text = "Farm Body Toughness: OFF"
				FarmFist.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmFist.Text = "Farm Fist Strength: OFF"
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.PP.Value)) >= 350e15 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-429, 1120, -140)
				workspace[plr.Name].HumanoidRootPart.Anchored = false
				farmfistactive = false
				farmbodyactive = false
				FarmBody.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmBody.Text = "Farm Body Toughness: OFF"
				FarmFist.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmFist.Text = "Farm Fist Strength: OFF"
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.PP.Value)) >= 1e15 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-423, 1120, -267)
				workspace[plr.Name].HumanoidRootPart.Anchored = false
				farmfistactive = false
				farmbodyactive = false
				FarmBody.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmBody.Text = "Farm Body Toughness: OFF"
				FarmFist.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmFist.Text = "Farm Fist Strength: OFF"
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.PP.Value)) >= 1e12 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-323, 1067, -196)
				workspace[plr.Name].HumanoidRootPart.Anchored = false
				farmfistactive = false
				farmbodyactive = false
				FarmBody.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmBody.Text = "Farm Body Toughness: OFF"
				FarmFist.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmFist.Text = "Farm Fist Strength: OFF"
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.PP.Value)) >= 1e09 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-352, 1055, -133)
				workspace[plr.Name].HumanoidRootPart.Anchored = false
				farmfistactive = false
				farmbodyactive = false
				FarmBody.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmBody.Text = "Farm Body Toughness: OFF"
				FarmFist.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmFist.Text = "Farm Fist Strength: OFF"
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.PP.Value)) >= 1e06 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-340, 1055, -263)
				workspace[plr.Name].HumanoidRootPart.Anchored = false
				farmfistactive = false
				farmbodyactive = false
				FarmBody.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmBody.Text = "Farm Body Toughness: OFF"
				FarmFist.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmFist.Text = "Farm Fist Strength: OFF"
			elseif tonumber(string.format("%.0f", game.Players.LocalPlayer.PlayerFolder.DataFolder.PP.Value)) >= 10e03 then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-108, 774, -86)
				workspace[plr.Name].HumanoidRootPart.Anchored = false
				farmfistactive = false
				farmbodyactive = false
				FarmBody.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmBody.Text = "Farm Body Toughness: OFF"
				FarmFist.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
				FarmFist.Text = "Farm Fist Strength: OFF"
			end
			wait(0.1)
			loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/PPToolEquip"))()
		end
		wait(1)
	end
	deathreturnactive = false
end)

-- Return On Death

spawn(function()
	while true do
		if deathreturnactive then
			player = game:GetService("Players").LocalPlayer
			player.Character.Humanoid.Died:connect(function()
				playerdied = true
			end)
		end
		if not playerdied then
			wait(1)
			lastlocationx = game.Players.LocalPlayer.Character.HumanoidRootPart.Position.x
			lastlocationy = game.Players.LocalPlayer.Character.HumanoidRootPart.Position.y
			lastlocationz = game.Players.LocalPlayer.Character.HumanoidRootPart.Position.z
			wait(0.5)
		end
		if playerdied then
			--print("Player " ..tostring(game.Players.LocalPlayer.Name).. " Died")
			--print(tostring(SavePosition.Text))
			wait(0.25)
			game:GetService("ReplicatedStorage").RespawnEvent:FireServer()
			wait(0.5)
            game.Players.LocalPlayer.PlayerGui.plrstats.Enabled = true
            wait(0.5)
            camera.CameraType = Enum.CameraType.Track
            wait(0.25)
			loadstring(game:HttpGet("https://raw.githubusercontent.com/Dimanoname/1/main/Trash"))()
			while game.Players.LocalPlayer.PlayerGui.Play.Enabled == true do
            	game.Players.LocalPlayer.PlayerGui.Play.Enabled = false
        	end
			wait(0.5)
			--print("screengui disabled")
			repeat wait(0.5) until game.Players.LocalPlayer.Character.Humanoid
			--print("Teleporting back to " ..tostring(SavePosition.Text))
			if deathreturnactive then
				wait(1)
				local FindHum = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(lastlocationx, lastlocationy, lastlocationz)
			end
			playerdied = false
		end
		wait(1)
	end		
end)


-- ESP --

esptrack.MouseButton1Click:connect(function()
	ESPEnabled = not ESPEnabled
	if ESPEnabled then
		esptrack.BackgroundColor3 = Color3.new(0, 0.5, 0)
		for _, v in next, Plrs:GetPlayers() do
			if v ~= MyPlr then
				if CharAddedEvent[v.Name] == nil then
					CharAddedEvent[v.Name] = v.CharacterAdded:connect(function(Char)
						if ESPEnabled then
							RemoveESP(v)
							CreateESP(v)
						end
						repeat wait() until Char:FindFirstChild("HumanoidRootPart")
					end)
				end
				RemoveESP(v)
				CreateESP(v)
			end
		end
	else
		esptrack.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
		for _, v in next, Plrs:GetPlayers() do
			RemoveESP(v)
		end
	end
end)

-- Server Player Stats --

PlayerInfo.MouseButton1Click:connect(function()
	if not showtopplayersactive then
		showtopplayersactive = true
		showtopplayersfistactive = true
		showtopplayersbodyactive = true
		showtopplayersspeedactive = true
		showtopplayersjumpactive = true
		showtopplayerspsychicactive = true
		PlayerInfoStatsFrame.Visible = true
	else
		showtopplayersactive = false
		PlayerInfoStatsFrame.Visible = false
		showtopplayersfistactive = false
		showtopplayersbodyactive = false
		showtopplayersspeedactive = false
		showtopplayersjumpactive = false
		showtopplayerspsychicactive = false
	end
end)

PlayerInfoStatsClose.MouseButton1Click:connect(function()
	showtopplayersactive = false
	PlayerInfoStatsFrame.Visible = false
	showtopplayersfistactive = false
	showtopplayersbodyactive = false
	showtopplayersspeedactive = false
	showtopplayersjumpactive = false
	showtopplayerspsychicactive = false
end)

spawn(function()
	while true do
		if showtopplayersfistactive then
			BestPlayerFist = 1
			PlayerFistName = false
			for i,v in pairs(game:GetService("Players"):GetChildren()) do
				local PlayerFist = tonumber(game.Players[v.Name].PlayerFolder.DataFolder.FS.Value)
				if PlayerFist > tonumber(BestPlayerFist) then 
					BestPlayerFist = PlayerFist
					PlayerFistName = tostring(v.Name)
				end
			end
			StatBestFistText1.Text = "Fist: " ..tostring(PlayerFistName)
			local fistplrStatus = game.Players[PlayerFistName].leaderstats.Status
			if fistplrStatus.Value == "Criminal" then
				StatBestFistText1.TextColor3 = Color3.new(1, 0.1, 1)
			elseif fistplrStatus.Value == "Lawbreaker" then
				StatBestFistText1.TextColor3 = Color3.new(1, 0.1, 0.1)
			elseif fistplrStatus.Value == "Guardian" then
				StatBestFistText1.TextColor3 = Color3.new(0.1, 0.8, 1)
			elseif fistplrStatus.Value == "Protector" then
				StatBestFistText1.TextColor3 = Color3.new(0.1, 0.1, 1)
			elseif fistplrStatus.Value == "SuperVillian" then
				StatBestFistText1.TextColor3 = Color3.new(0.3, 0.1, 0.1)
			elseif fistplrStatus.Value == "Superhero" then
				StatBestFistText1.TextColor3 = Color3.new(0.8, 0.8, 0)
			else
				StatBestFistText1.TextColor3 = Color3.new(1, 1, 1)
			end
			local FindHum = game.Players[PlayerFistName].Character.Humanoid
			local FistPlayerFist = converttoletter(string.format("%.0f", game.Players[PlayerFistName].PlayerFolder.DataFolder.FS.Value))
			local FistPlayerBody = converttoletter(string.format("%.0f", game.Players[PlayerFistName].PlayerFolder.DataFolder.BT.Value))
			local FistPlayerSpeed = converttoletter(string.format("%.0f", game.Players[PlayerFistName].PlayerFolder.DataFolder.WS.Value))
			local FistPlayerJump = converttoletter(string.format("%.0f", game.Players[PlayerFistName].PlayerFolder.DataFolder.JF.Value))
			local FistPlayerPsychic = converttoletter(string.format("%.0f", game.Players[PlayerFistName].PlayerFolder.DataFolder.PP.Value))
			ShowStatsFist2.Text = tostring(FistPlayerFist.. "\n" ..FistPlayerBody.. "\n" ..FistPlayerSpeed.. "\n" ..FistPlayerJump.. "\n" ..FistPlayerPsychic)
		end
		wait(0.3)
	end
end)

spawn(function()
	while true do
		if showtopplayersbodyactive then
			BestPlayerBody = 1
			PlayerBodyName = false
			for i,v in pairs(game:GetService("Players"):GetChildren()) do
				local PlayerBody = tonumber(game.Players[v.Name].PlayerFolder.DataFolder.BT.Value)
				if PlayerBody > tonumber(BestPlayerBody) then 
					BestPlayerBody = PlayerBody
					PlayerBodyName = tostring(v.Name)
				end
			end
			StatBestBodyText1.Text = "Body: " ..tostring(PlayerBodyName)
			local bodyplrStatus = game.Players[PlayerBodyName].leaderstats.Status
			if bodyplrStatus.Value == "Criminal" then
				StatBestBodyText1.TextColor3 = Color3.new(1, 0.1, 1)
			elseif bodyplrStatus.Value == "Lawbreaker" then
				StatBestBodyText1.TextColor3 = Color3.new(1, 0.1, 0.1)
			elseif bodyplrStatus.Value == "Guardian" then
				StatBestBodyText1.TextColor3 = Color3.new(0.1, 0.8, 1)
			elseif bodyplrStatus.Value == "Protector" then
				StatBestBodyText1.TextColor3 = Color3.new(0.1, 0.1, 1)
			elseif bodyplrStatus.Value == "SuperVillian" then
				StatBestBodyText1.TextColor3 = Color3.new(0.3, 0.1, 0.1)
			elseif bodyplrStatus.Value == "Superhero" then
				StatBestBodyText1.TextColor3 = Color3.new(0.8, 0.8, 0)
			else
				StatBestBodyText1.TextColor3 = Color3.new(1, 1, 1)
			end
			local FindHum = game.Players[PlayerBodyName].Character.Humanoid
			local BodyPlayerFist = converttoletter(string.format("%.0f", game.Players[PlayerBodyName].PlayerFolder.DataFolder.FS.Value))
			local BodyPlayerBody = converttoletter(string.format("%.0f", game.Players[PlayerBodyName].PlayerFolder.DataFolder.BT.Value))
			local BodyPlayerSpeed = converttoletter(string.format("%.0f", game.Players[PlayerBodyName].PlayerFolder.DataFolder.WS.Value))
			local BodyPlayerJump = converttoletter(string.format("%.0f", game.Players[PlayerBodyName].PlayerFolder.DataFolder.JF.Value))
			local BodyPlayerPsychic = converttoletter(string.format("%.0f", game.Players[PlayerBodyName].PlayerFolder.DataFolder.PP.Value))
			ShowStatsBody2.Text = tostring(BodyPlayerFist.. "\n" ..BodyPlayerBody.. "\n" ..BodyPlayerSpeed.. "\n" ..BodyPlayerJump.. "\n" ..BodyPlayerPsychic)
		end
		wait(0.3)
	end
end)

spawn(function()
	while true do
		if showtopplayersspeedactive then
			BestPlayerSpeed = 1
			PlayerSpeedName = false
			for i,v in pairs(game:GetService("Players"):GetChildren()) do
				local PlayerSpeed = tonumber(game.Players[v.Name].PlayerFolder.DataFolder.WS.Value)
				if PlayerSpeed > tonumber(BestPlayerSpeed) then 
					BestPlayerSpeed = PlayerSpeed
					PlayerSpeedName = tostring(v.Name)
				end
			end
			StatBestSpeedText1.Text = "Speed: " ..tostring(PlayerSpeedName)
			local speedplrStatus = game.Players[PlayerSpeedName].leaderstats.Status
			if speedplrStatus.Value == "Criminal" then
				StatBestSpeedText1.TextColor3 = Color3.new(1, 0.1, 1)
			elseif speedplrStatus.Value == "Lawbreaker" then
				StatBestSpeedText1.TextColor3 = Color3.new(1, 0.1, 0.1)
			elseif speedplrStatus.Value == "Guardian" then
				StatBestSpeedText1.TextColor3 = Color3.new(0.1, 0.8, 1)
			elseif speedplrStatus.Value == "Protector" then
				StatBestSpeedText1.TextColor3 = Color3.new(0.1, 0.1, 1)
			elseif speedplrStatus.Value == "SuperVillian" then
				StatBestSpeedText1.TextColor3 = Color3.new(0.3, 0.1, 0.1)
			elseif speedplrStatus.Value == "Superhero" then
				StatBestSpeedText1.TextColor3 = Color3.new(0.8, 0.8, 0)
			else
				StatBestSpeedText1.TextColor3 = Color3.new(1, 1, 1)
			end
			local FindHum = game.Players[PlayerSpeedName].Character.Humanoid
			local SpeedPlayerFist = converttoletter(string.format("%.0f", game.Players[PlayerSpeedName].PlayerFolder.DataFolder.FS.Value))
			local SpeedPlayerBody = converttoletter(string.format("%.0f", game.Players[PlayerSpeedName].PlayerFolder.DataFolder.BT.Value))
			local SpeedPlayerSpeed = converttoletter(string.format("%.0f", game.Players[PlayerSpeedName].PlayerFolder.DataFolder.WS.Value))
			local SpeedPlayerJump = converttoletter(string.format("%.0f", game.Players[PlayerSpeedName].PlayerFolder.DataFolder.JF.Value))
			local SpeedPlayerPsychic = converttoletter(string.format("%.0f", game.Players[PlayerSpeedName].PlayerFolder.DataFolder.PP.Value))
			ShowStatsSpeed2.Text = tostring(SpeedPlayerFist.. "\n" ..SpeedPlayerBody.. "\n" ..SpeedPlayerSpeed.. "\n" ..SpeedPlayerJump.. "\n" ..SpeedPlayerPsychic)
		end
		wait(0.3)
	end
end)

spawn(function()
	while true do
		if showtopplayersjumpactive then
			BestPlayerJump = 1
			PlayerJumpName = false
			for i,v in pairs(game:GetService("Players"):GetChildren()) do
				local PlayerJump = tonumber(game.Players[v.Name].PlayerFolder.DataFolder.JF.Value)
				if PlayerJump > tonumber(BestPlayerJump) then 
					BestPlayerJump = PlayerJump
					PlayerJumpName = tostring(v.Name)
				end
			end
			StatBestJumpText1.Text = "Jump: " ..tostring(PlayerJumpName)
			local JumpplrStatus = game.Players[PlayerJumpName].leaderstats.Status
			if JumpplrStatus.Value == "Criminal" then
				StatBestJumpText1.TextColor3 = Color3.new(1, 0.1, 1)
			elseif JumpplrStatus.Value == "Lawbreaker" then
				StatBestJumpText1.TextColor3 = Color3.new(1, 0.1, 0.1)
			elseif JumpplrStatus.Value == "Guardian" then
				StatBestJumpText1.TextColor3 = Color3.new(0.1, 0.8, 1)
			elseif JumpplrStatus.Value == "Protector" then
				StatBestJumpText1.TextColor3 = Color3.new(0.1, 0.1, 1)
			elseif JumpplrStatus.Value == "SuperVillian" then
				StatBestJumpText1.TextColor3 = Color3.new(0.3, 0.1, 0.1)
			elseif JumpplrStatus.Value == "Superhero" then
				StatBestJumpText1.TextColor3 = Color3.new(0.8, 0.8, 0)
			else
				StatBestJumpText1.TextColor3 = Color3.new(1, 1, 1)
			end
			local FindHum = game.Players[PlayerJumpName].Character.Humanoid
			local JumpPlayerFist = converttoletter(string.format("%.0f", game.Players[PlayerJumpName].PlayerFolder.DataFolder.FS.Value))
			local JumpPlayerBody = converttoletter(string.format("%.0f", game.Players[PlayerJumpName].PlayerFolder.DataFolder.BT.Value))
			local JumpPlayerSpeed = converttoletter(string.format("%.0f", game.Players[PlayerJumpName].PlayerFolder.DataFolder.WS.Value))
			local JumpPlayerJump = converttoletter(string.format("%.0f", game.Players[PlayerJumpName].PlayerFolder.DataFolder.JF.Value))
			local JumpPlayerPsychic = converttoletter(string.format("%.0f", game.Players[PlayerJumpName].PlayerFolder.DataFolder.PP.Value))
			ShowStatsJump2.Text = tostring(JumpPlayerFist.. "\n" ..JumpPlayerBody.. "\n" ..JumpPlayerSpeed.. "\n" ..JumpPlayerJump.. "\n" ..JumpPlayerPsychic)
		end
		wait(0.3)
	end
end)

spawn(function()
	while true do
		if showtopplayerspsychicactive then
			BestPlayerPsychic = 1
			PlayerPsychicName = false
			for i,v in pairs(game:GetService("Players"):GetChildren()) do
				local PlayerPsychic = tonumber(game.Players[v.Name].PlayerFolder.DataFolder.PP.Value)
				if PlayerPsychic > tonumber(BestPlayerPsychic) then 
					BestPlayerPsychic = PlayerPsychic
					PlayerPsychicName = tostring(v.Name)
				end
			end
			StatBestPsychicText1.Text = "Psy: " ..tostring(PlayerPsychicName)
			local PsychicplrStatus = game.Players[PlayerPsychicName].leaderstats.Status
			if PsychicplrStatus.Value == "Criminal" then
				StatBestPsychicText1.TextColor3 = Color3.new(1, 0.1, 1)
			elseif PsychicplrStatus.Value == "Lawbreaker" then
				StatBestPsychicText1.TextColor3 = Color3.new(1, 0.1, 0.1)
			elseif PsychicplrStatus.Value == "Guardian" then
				StatBestPsychicText1.TextColor3 = Color3.new(0.1, 0.8, 1)
			elseif PsychicplrStatus.Value == "Protector" then
				StatBestPsychicText1.TextColor3 = Color3.new(0.1, 0.1, 1)
			elseif PsychicplrStatus.Value == "SuperVillian" then
				StatBestPsychicText1.TextColor3 = Color3.new(0.3, 0.1, 0.1)
			elseif PsychicplrStatus.Value == "Superhero" then
				StatBestPsychicText1.TextColor3 = Color3.new(0.8, 0.8, 0)
			else
				StatBestPsychicText1.TextColor3 = Color3.new(1, 1, 1)
			end
			local FindHum = game.Players[PlayerPsychicName].Character.Humanoid
			local PsychicPlayerFist = converttoletter(string.format("%.0f", game.Players[PlayerPsychicName].PlayerFolder.DataFolder.FS.Value))
			local PsychicPlayerBody = converttoletter(string.format("%.0f", game.Players[PlayerPsychicName].PlayerFolder.DataFolder.BT.Value))
			local PsychicPlayerSpeed = converttoletter(string.format("%.0f", game.Players[PlayerPsychicName].PlayerFolder.DataFolder.WS.Value))
			local PsychicPlayerJump = converttoletter(string.format("%.0f", game.Players[PlayerPsychicName].PlayerFolder.DataFolder.JF.Value))
			local PsychicPlayerPsychic = converttoletter(string.format("%.0f", game.Players[PlayerPsychicName].PlayerFolder.DataFolder.PP.Value))
			ShowStatsPsychic2.Text = tostring(PsychicPlayerFist.. "\n" ..PsychicPlayerBody.. "\n" ..PsychicPlayerSpeed.. "\n" ..PsychicPlayerJump.. "\n" ..PsychicPlayerPsychic)
		end
		wait(0.3)
	end
end)

-- Display Player Info --

spawn(function()
	while true do
		statplayer = tostring(PlayerName.Text)
		StatsFrame.Visible = false
		if playerdied == true then repeat wait(0.5) until playerdied == false end
		for i,v in pairs(game:GetService("Players"):GetChildren()) do
			if string.lower(v.Name) == string.lower(statplayer) then
				StatsFrame.Visible = true
				local FindHum = v.Character:WaitForChild("Humanoid")
				local PlayerFist = converttoletter(string.format("%.0f", game.Players[v.Name].PlayerFolder.DataFolder.FS.Value))
				local PlayerBody = converttoletter(string.format("%.0f", game.Players[v.Name].PlayerFolder.DataFolder.BT.Value))
				local PlayerSpeed = converttoletter(string.format("%.0f", game.Players[v.Name].PlayerFolder.DataFolder.WS.Value))
				local PlayerJump = converttoletter(string.format("%.0f", game.Players[v.Name].PlayerFolder.DataFolder.JF.Value))
				local PlayerPsychic = converttoletter(string.format("%.0f", game.Players[v.Name].PlayerFolder.DataFolder.PP.Value))
				local PlayerTokens = converttoletter(string.format("%.0f", game.Players[v.Name].PlayerFolder.DataFolder.Tokens.Value))
				ShowStats1.Text = "Fist:\nBody:\nSpeed:\nJump:\nPsychic:\nTokens:"
				ShowStats2.Text = PlayerFist.. "\n" ..PlayerBody.. "\n" ..PlayerSpeed.. "\n" ..PlayerJump.. "\n" ..PlayerPsychic.. "\n" ..PlayerTokens
				break
			end
		end
		wait(0.25)
	end
end)

-- Display Player Info (2nd) --

function converttoletter1(num)
	if num / 1e57 >=1 then
		newnum = num / 1e303
		return round(newnum, 5).. "Ce"
	elseif num / 1e57 >=1 then
		newnum = num / 1e57
		return round(newnum, 1).. "OcDe"
	elseif num / 1e54 >=1 then
		newnum = num / 1e54
		return round(newnum, 1).. "SpDe"
	elseif num / 1e51 >=1 then
		newnum = num / 1e51
		return round(newnum, 1).. "SxDe"
	elseif num / 1e48 >=1 then
		newnum = num / 1e48
		return round(newnum, 1).. "QiDe"
	elseif num / 1e45 >=1 then
		newnum = num / 1e45
		return round(newnum, 1).. "QaDe"
	elseif num / 1e42 >=1 then
		newnum = num / 1e42
		return round(newnum, 1).. "TDe"
	elseif num / 1e39 >=1 then
		newnum = num / 1e39
		return round(newnum, 1).. "DDe"
	elseif num / 1e36 >=1 then
		newnum = num / 1e36
		return round(newnum, 1).. "Un"
	elseif num / 1e33 >=1 then
		newnum = num / 1e33
		return round(newnum, 1).. "De"
	elseif num / 1e30 >=1 then
		newnum = num / 1e30
		return round(newnum, 1).. "No"
	elseif num / 1e27 >=1 then
		newnum = num / 1e27
		return round(newnum, 1).. "Oc"
	elseif num / 1e24 >=1 then
		newnum = num / 1e24
		return round(newnum, 1).. "Sp"
	elseif num / 1e21 >=1 then
		newnum = num / 1e21
		return round(newnum, 1).. "Sx"
	elseif num / 1e18 >=1 then
		newnum = num / 1e18
		return round(newnum, 1).. "Qi"
	elseif num / 1e15 >=1 then
		newnum = num / 1e15
		return round(newnum, 1).. "Qa"
	elseif num / 1e12 >=1 then
		newnum = num / 1e12
		return round(newnum, 1).. "T"
	elseif num / 1e09 >=1 then
		newnum = num / 1e09
		return round(newnum, 1).. "B"
	elseif num / 1e06 >=1 then
		newnum = num / 1e06
		return round(newnum, 1).. "M"
	elseif num / 1e03 >=1 then
		newnum = num / 1e03
		return round(newnum, 1).. "K"
	else return num
	end
end

function converttoletter2(num)
	if num / 1e57 >=1 then
		newnum = num / 1e303
		return round(newnum, 5).. "Ce"
	elseif num / 1e57 >=1 then
		newnum = num / 1e57
		return round(newnum, 0).. "OcDe"
	elseif num / 1e54 >=1 then
		newnum = num / 1e54
		return round(newnum, 0).. "SpDe"
	elseif num / 1e51 >=1 then
		newnum = num / 1e51
		return round(newnum, 0).. "SxDe"
	elseif num / 1e48 >=1 then
		newnum = num / 1e48
		return round(newnum, 0).. "QiDe"
	elseif num / 1e45 >=1 then
		newnum = num / 1e45
		return round(newnum, 0).. "QaDe"
	elseif num / 1e42 >=1 then
		newnum = num / 1e42
		return round(newnum, 0).. "TDe"
	elseif num / 1e39 >=1 then
		newnum = num / 1e39
		return round(newnum, 0).. "DDe"
	elseif num / 1e36 >=1 then
		newnum = num / 1e36
		return round(newnum, 0).. "Un"
	elseif num / 1e33 >=1 then
		newnum = num / 1e33
		return round(newnum, 0).. "De"
	elseif num / 1e30 >=1 then
		newnum = num / 1e30
		return round(newnum, 0).. "No"
	elseif num / 1e27 >=1 then
		newnum = num / 1e27
		return round(newnum, 0).. "Oc"
	elseif num / 1e24 >=1 then
		newnum = num / 1e24
		return round(newnum, 0).. "Sp"
	elseif num / 1e21 >=1 then
		newnum = num / 1e21
		return round(newnum, 0).. "Sx"
	elseif num / 1e18 >=1 then
		newnum = num / 1e18
		return round(newnum, 0).. "Qi"
	elseif num / 1e15 >=1 then
		newnum = num / 1e15
		return round(newnum, 0).. "Qa"
	elseif num / 1e12 >=1 then
		newnum = num / 1e12
		return round(newnum, 0).. "T"
	elseif num / 1e09 >=1 then
		newnum = num / 1e09
		return round(newnum, 0).. "B"
	elseif num / 1e06 >=1 then
		newnum = num / 1e06
		return round(newnum, 0).. "M"
	elseif num / 1e03 >=1 then
		newnum = num / 1e03
		return round(newnum, 0).. "K"
	else return num
	end
end

spawn(function()
	while true do
		statplayer = tostring(PlayerName1.Text)
		StatsFrame1.Visible = false
		if playerdied == true then repeat wait(0.5) until playerdied == false end
		for i,v in pairs(game:GetService("Players"):GetChildren()) do
			if string.lower(v.Name) == string.lower(statplayer) then
				StatsFrame1.Visible = true
				local FindHum = v.Character:WaitForChild("Humanoid")
				local PlayerFist = converttoletter1(string.format("%.0f", game.Players[v.Name].PlayerFolder.DataFolder.FS.Value))
				local PlayerFistMP = converttoletter2(string.format("%.0f", game.Players[v.Name].PlayerFolder.Multipliers.FSMulti.Value))
				local PlayerBody = converttoletter1(string.format("%.0f", game.Players[v.Name].PlayerFolder.DataFolder.BT.Value))
				local PlayerBodyMP = converttoletter2(string.format("%.0f", game.Players[v.Name].PlayerFolder.Multipliers.BTMulti.Value))
				local PlayerSpeed = converttoletter1(string.format("%.0f", game.Players[v.Name].PlayerFolder.DataFolder.WS.Value))
				local PlayerSpeedMP = converttoletter2(string.format("%.0f", game.Players[v.Name].PlayerFolder.Multipliers.WSMulti.Value))
				local PlayerJump = converttoletter1(string.format("%.0f", game.Players[v.Name].PlayerFolder.DataFolder.JF.Value))
				local PlayerJumpMP = converttoletter2(string.format("%.0f", game.Players[v.Name].PlayerFolder.Multipliers.JFMulti.Value))
				local PlayerPsychic = converttoletter1(string.format("%.0f", game.Players[v.Name].PlayerFolder.DataFolder.PP.Value))
				local PlayerPsychicMP= converttoletter2(string.format("%.0f", game.Players[v.Name].PlayerFolder.Multipliers.PPMulti.Value))
				local PlayerTokens = converttoletter1(string.format("%.0f", game.Players[v.Name].PlayerFolder.DataFolder.Tokens.Value))
				ShowStats3.Text = "Fist:\nBody:\nSpeed:\nJump:\nPsychic:\nTokens:"
				ShowStats4.Text = PlayerFist.. " | " ..PlayerFistMP.. "\n" ..PlayerBody.. " | " ..PlayerBodyMP.. "\n" ..PlayerSpeed.. " | " ..PlayerSpeedMP.. "\n" ..PlayerJump.. " | " ..PlayerJumpMP.. "\n" ..PlayerPsychic.. " | " ..PlayerPsychicMP.. "\n" ..PlayerTokens
				break
			end
		end
		wait(0.25)
	end
end)