--[[
	Redon Tech 2023
	EVC V2
--]]

--------------------------------------------------------------------------------
-- Init --
--------------------------------------------------------------------------------

local Car = script.Parent.Car.Value
local Event = Car:WaitForChild("EVCRemote")
local UserInputService = game:GetService("UserInputService")
-- local Values = script.Parent.Values

--------------------------------------------------------------------------------
-- Handling --
--------------------------------------------------------------------------------

--Values.PBrake:GetPropertyChangedSignal("Value"):Connect(function()
--	Event:FireServer("ParkMode", Values.PBrake.Value)
--end)

local function input(InputObj: InputObject, gameProcessedEvent: BoolValue)
	if not gameProcessedEvent and InputObj.UserInputType == Enum.UserInputType.Keyboard then
		Event:FireServer("Input", InputObj.UserInputState, InputObj.UserInputType, InputObj.KeyCode)
	end
end

UserInputService.InputBegan:Connect(input)
UserInputService.InputChanged:Connect(input)
UserInputService.InputEnded:Connect(input)