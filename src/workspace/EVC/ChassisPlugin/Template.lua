--[[
Generated By: Emergency Vehicle Creator
For: Emergency Vehicle Creator Plugin

Redon Tech 2022
EVC
--]]

--------------------------------------------------------------------------------
-- Init --
--------------------------------------------------------------------------------

local Settings, Lights, SpecialtyLights

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

	-- DO NOT CHANGE
	-- THIS IS AUTOMATICALLY GENERATED
	PluginVersion = "1.1.0",
	-- THIS IS FOR THE CHASSIS PLUGIN AND SHOULD NOT MATCH THE STUDIO PLUGIN
}

--[[
	Example of how lights should look
	["LightName"] = {
		1,0,2,0,3,0,4,0,5,0,6, -- Refrenced to the color table above, **0 = Off**
	},
]]
Lights = {}


--[[
	Example of how specialty lights should look
	["LightName"] = { -- Rotators
		type = "Rotator",
		speed = 1,
		function = "Limited", -- Limited or Unlmited
		settings = { -- Only modify if Limited
			reverse = true,
			angles = {[1] = 15, [2] = 15}, -- Degrees left, Degrees right
			-- TODO: Add more settings (I forgot the rest)
		},
	},

	["LightName"] = { -- Faders
		type = "Faders",
		fadetime = 1,
		delaytime = 0,
		easingstyle = Enum.EasingStyle.Linear,
		easingdirection = Enum.EasingDirection.InOut,
		offinfo = {
			Transparency = 1,
			Color = Color3.fromRGB(47, 71, 255),
		},
		goal = {
			Transparency = 0,
		},
	}
]]
SpecialtyLights = {}

--------------------------------------------------------------------------------
-- Return Value --
--------------------------------------------------------------------------------

return {
	Settings = Settings,
	Lights = Lights
}