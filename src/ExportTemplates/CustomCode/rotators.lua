--[[
	Generated By: Emergency Vehicle Creator
	For: [username]

	Redon Tech 2023
	EVC V2
--]]

local Car = script.Parent.Parent.Parent
local Lightbar = script.Parent

-- Colors, change this if you wish
local Colors = {
	[1] = Color3.fromRGB(47, 71, 255),
	[2] = Color3.fromRGB(185, 58, 60),
	[3] = Color3.fromRGB(253, 194, 66),
	[4] = Color3.fromRGB(255, 255, 255),
	[5] = Color3.fromRGB(75, 255, 75),
	[6] = Color3.fromRGB(188, 12, 211),
}

-- By default this light function will work with most light types, modify to make it if need be
local function light(LightName, Color)
	local Light = Lightbar[LightName]
	if Color == 0 then
		for i,v in pairs(Light:GetDescendants()) do
			if v:IsA("GuiObject") then
				v.Visible = false
			elseif v:IsA("Light") or v:IsA("SurfaceGui") then
				v.Enabled = false
			elseif v:IsA("ParticleEmitter") then
				v.Transparency = NumberSequence.new(1)
			end
		end
		Light.Transparency = 1
	else
		for i,v in pairs(Light:GetDescendants()) do
			if v:IsA("GuiObject") then
				v.Visible = true
				v.ImageColor3 = Colors[Color]
			elseif v:IsA("Light") then
				v.Enabled = true
				v.Color = Colors[Color]
			elseif v:IsA("SurfaceGui") then
				v.Enabled = true
			elseif v:IsA("ParticleEmitter") then
				v.Transparency = NumberSequence.new(0)
				v.Color = ColorSequence.new(Colors[Color])
			end
		end
		Light.Transparency = 0
		Light.Color = Colors[Color]
	end
end

local function registerRotator(lightName:string)
	local motorPart = Instance.new("Part")
	motorPart.Name = `motor{lightName}`
	motorPart.Size = Vector3.new(.1,.1,.1)
	motorPart.CFrame = Lightbar[lightName].CFrame
	motorPart.Transparency = 1
	local weld = Instance.new("Weld")
	weld.Part0 = Car.DriveSeat
	weld.Part1 = motorPart
	weld.C0 = Car.DriveSeat.CFrame:Inverse()*Car.DriveSeat.CFrame 
	weld.C1 = motorPart.CFrame:Inverse()*Car.DriveSeat.CFrame 
	weld.Parent = Car.DriveSeat

	local Center = if Lightbar[lightName]:FindFirstChild("inverse") ~= nil then CFrame.new(Lightbar[lightName].inverse.Position) else CFrame.new(Lightbar[lightName].Position)
	local XYZ = if Lightbar[lightName]:FindFirstChild("inverse") ~= nil then CFrame.Angles(Lightbar[lightName].inverse.CFrame:toEulerAnglesXYZ()) else CFrame.Angles(Lightbar[lightName].CFrame:toEulerAnglesXYZ())
	local motor = Instance.new("Motor6D")
	motor.Name = "Motor"
	motor.Part0 = motorPart
	motor.Part1 = Lightbar[lightName]
	motor.C0 = (motorPart.CFrame:Inverse() * Center) * XYZ
	motor.C1 = (Lightbar[lightName].CFrame:Inverse() * Center) * XYZ
	motor.Parent = motorPart

	for i,v in pairs(Car.DriveSeat:GetChildren()) do
		if v:IsA("Weld") and v.Part1 == Lightbar[lightName] then
			v:Destroy()
		end
	end

	motorPart.Parent = Lightbar
end


-- Main Loops
--------------
-- To use the function above do
--		registerRotator("L1")
--      light("L1", 0)
-- The above will create the rotators motor and turn off said light
--      light("L1", 1)
-- The above will turn on said light and change its color to said color defined in the color table
--      Lightbar.motorL1.Motor.MaxVelocity = 0.1
--      Lightbar.motorL1.Motor.DesiredAngle = math.rad(90)
-- The above will rotate the light to 90 degrees with a velocity of 0.1 per heartbeat
--------------
--[rotators]