--[[
	Generated By: Emergency Vehicle Creator
	For: Emergency Vehicle Creator Plugin V2

	Redon Tech 2023
	EVC V2
--]]

--------------------------------------------------------------------------------
-- Init --
--------------------------------------------------------------------------------

local Settings, Lights

--------------------------------------------------------------------------------
-- Data --
--------------------------------------------------------------------------------

Settings = {
	-- The time between each light flash
	WaitTime = 0.1,
	
	-- Determins which lights can override each other
	-- For example lightbars should be 1 and traffic advisors 2
	-- This allows the traffic advisor to override the back of the lightbar
	-- If multiple are the same then the light will default to the first loaded
	Weight = 1,

	-- If for whatever reason you need to override the colors change the nil to a new table
	-- You can find a template for the table in the settings under the plugin
	Colors = nil,

	-- If for whatever reason you need to override the light function change nil to the new function
	-- You can find a template for the function in the settings under the plugin
	Light = nil,
}

--[[
	Example of how lights should look
	["LightName"] = {
		1,0,2,0,3,0,4,0,5,0,6, -- Refrenced to the color table above, **0 = Off**
	},
]]
Lights = {}

--[[
	Example of how rotators should look
	["LightName"] = {
		[1] = {
			Color = 1,
			Angle = 45,
			Velocity = 0.1
		},
		[2] = {
			Color = 2,
			Angle = -45,
			Velocity = 0.1
		},
	},
]]
Rotators = {}

--[[
	Example of how faders should look
	["LightName"] = {
		[1] = {
			Color = 1,
			Transparency = 1,
			Time = 0.5,
			EasingStyle = Enum.EasingStyle.Linear,
			EasingDirection = Enum.EasingDirection.InOut,
			RepeatCount = 0,
			Reverses = true,
			TimeDelay = 0,
		},
	},
]]
Faders = {}

--------------------------------------------------------------------------------
-- Return Value --
--------------------------------------------------------------------------------

return {
	Settings = Settings,
	Lights = Lights,
	Rotators = Rotators,
	Faders = Faders,
}