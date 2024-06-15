--[[
	Generated By: Emergency Vehicle Creator
	For: [username]

	Redon Tech 2023-2024
	EVC V2
--]]

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


-- Main Loop
--------------
-- To use the function above do
--      light("L1", 0)
-- The above will turn off said light
--      light("L1", 1)
-- The above will turn on said light and change its color to said color defined in the color table
--------------
while game["Run Service"].Heartbeat:Wait() do
	--[lights]
end