--[[
Redon Tech 2022
EVC
--]]

--------------------------------------------------------------------------------
-- Init --
--------------------------------------------------------------------------------

local Studio = settings():GetService("Studio")
local Is_RBXM = plugin.Name:find(".rbxm") ~= nil
local Functions = require(script.Parent.Modules.functions)

local function getName(name: string)
    if Is_RBXM then
        name ..= " (RBXM)"
    end
    return name
end

local Plugin_Name = getName("Emergency Vehicle Creator")
local Plugin_Description = "Create ELS for emergency vehicles!"
local Plugin_Icon = ""
local Widget_Name = getName("EVC")
local Button_Name = getName("EVC Button")

if not _G.RT then
    _G.RT = {Buttons = {}}
end

if not _G.RT.Buttons then
    _G.RT.Buttons = {}
end

if not _G.RT.RTToolbar then
    _G.RT.RTToolbar = plugin:CreateToolbar("Redon Tech Plugins")
end

--------------------------------------------------------------------------------
-- UI Init --
--------------------------------------------------------------------------------

local Config = DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Float, false, false, 1280, 720)
local GUI = plugin:CreateDockWidgetPluginGui(Widget_Name, Config)
GUI.ZIndexBehavior = Enum.ZIndexBehavior.Global
GUI.Title = Plugin_Name
GUI.Name = Widget_Name

local Button = nil
if table.find(_G.RT.Buttons, Button_Name) then
    Button = _G.RT.Buttons[Button_Name]
else
    Button = _G.RT.RTToolbar:CreateButton(Button_Name, Plugin_Description, Plugin_Icon)
    _G.RT.Buttons[Button_Name] = Button
end

local MainFrame = require(script.Parent.Modules.gui).CreateGui()
MainFrame.Parent = GUI
MainFrame.Confirm.TextLabel.RichText = true -- GUI -> Script doesnt convert this

--------------------------------------------------------------------------------
-- Handling --
--------------------------------------------------------------------------------

MainFrame:WaitForChild("Creator")
MainFrame:WaitForChild("Confirm")

local Locked, Pause = true, true
local MouseDown, Mouse2Down = false, false
local Color = 1
local Starting = nil
local RepColors = {
    [0] = Color3.fromRGB(40, 40, 40),
    [1] = Color3.fromRGB(47, 71, 255),
    [2] = Color3.fromRGB(185, 58, 60),
    [3] = Color3.fromRGB(253, 194, 66),
    [4] = Color3.fromRGB(255, 255, 255),
    [5] = Color3.fromRGB(75, 255, 75),
    [6] = Color3.fromRGB(188, 12, 211),
}
local ButColors = {
    [1] = "Blue",
    [2] = "Red",
    [3] = "Amber",
    [4] = "White",
    [5] = "Green",
    [6] = "Purple",
}

--Color Change Handler
local function changecolor(new_color: number)
    Color = new_color
    for i,v in pairs(MainFrame.Creator.Info.Buttons:GetChildren()) do
        if table.find(ButColors, v.Name) then
            v.TextColor3 = RepColors[table.find(ButColors, v.Name)]
        end
    end

    local ButColor = ButColors[new_color]
    if MainFrame.Creator.Info.Buttons[ButColor] then
        MainFrame.Creator.Info.Buttons[ButColor].TextColor3 = Color3.fromRGB(100, 100, 100)
    end
end
changecolor(1)

local function reset()
    MainFrame.Confirm.Visible = true
    MainFrame.Confirm.TextLabel.Text = "Are you sure you want to reset? <b>Any unsaved progress will be lost!</b>"
    local connect1, connect2 = nil, nil

    connect1 = MainFrame.Confirm.Yes.MouseButton1Click:Connect(function()
        MainFrame.Confirm.Visible = false
        
        for i,v in pairs(MainFrame.Creator.ScrollingFrame:GetDescendants()) do
            if v.Name ~= "Top" and v:IsA("ImageLabel") then
                v:SetAttribute("Color", 0)
                v.ImageColor3 = RepColors[0]
            end
        end

        connect1:Disconnect()
        connect2:Disconnect()
    end)

    connect2 = MainFrame.Confirm.No.MouseButton1Click:Connect(function()
        MainFrame.Confirm.Visible = false
        connect1:Disconnect()
        connect2:Disconnect()
    end)
end

-- Roblox forces us to use frames within plugins to get userinput
-- Because of this we use the mainframe to get inputs
MainFrame.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.R then
        reset()
    elseif input.KeyCode == Enum.KeyCode.P then
        Pause = not Pause
    elseif input.KeyCode == Enum.KeyCode.One then
        changecolor(1)
    elseif input.KeyCode == Enum.KeyCode.Two then
        changecolor(2)
    elseif input.KeyCode == Enum.KeyCode.Three then
        changecolor(3)
    elseif input.KeyCode == Enum.KeyCode.Four then
        changecolor(4)
    elseif input.KeyCode == Enum.KeyCode.Five then
        changecolor(5)
    elseif input.KeyCode == Enum.KeyCode.Six then
        changecolor(6)
    elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
        MouseDown = true
        Mouse2Down = false
    elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
        Mouse2Down = true
        MouseDown = false
    end
end)

MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        MouseDown = false
        Mouse2Down = false
        Starting = nil
    elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
        Mouse2Down = false
        MouseDown = false
        Starting = nil
    end
end)

-- Column button handler
local function addbutton(v: GuiBase2d, frame: GuiBase2d)
    if v.Name ~= "Top" and v:IsA("ImageLabel") then
        v:SetAttribute("Color", 0)
        v.ImageColor3 = RepColors[0]
        local enter

        v.MouseEnter:Connect(function()
            if MouseDown and Starting == nil then
                Starting = frame
                v:SetAttribute("Color", Color)
                v.ImageColor3 = RepColors[Color]
            elseif MouseDown and (Starting == frame or not Locked) then
                v:SetAttribute("Color", Color)
                v.ImageColor3 = RepColors[Color]
            elseif Mouse2Down and Starting == nil then
                Starting = frame
                v:SetAttribute("Color", 0)
                v.ImageColor3 = RepColors[0]
            elseif Mouse2Down and (Starting == frame or not Locked) then
                v:SetAttribute("Color", 0)
                v.ImageColor3 = RepColors[0]
            else
                enter = MainFrame.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        Starting = frame
                        v:SetAttribute("Color", Color)
                        v.ImageColor3 = RepColors[Color]
                    elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                        Starting = frame
                        v:SetAttribute("Color", 0)
                        v.ImageColor3 = RepColors[0]
                    end
                end)
            end
        end)

        v.MouseLeave:Connect(function()
            if enter then
                enter:Disconnect()
                enter = nil
            end
        end)
    end
end

-- Add/remove columns
for i,v in pairs(MainFrame.Creator.ScrollingFrame["1"]:GetChildren()) do
    addbutton(v, MainFrame.Creator.ScrollingFrame["1"])
end

MainFrame.Creator.ScrollingFrame.Last.Devider.add.MouseButton1Down:Connect(function()
    local clone = MainFrame.Creator.ScrollingFrame["1"]:Clone()
    clone.Name = #MainFrame.Creator.ScrollingFrame:GetChildren() - 1
    clone.LayoutOrder = 2
    for i,v in pairs(clone:GetChildren()) do
        addbutton(v, clone)
    end
    clone.Parent = MainFrame.Creator.ScrollingFrame
end)

MainFrame.Creator.ScrollingFrame.Last.Devider.subtract.MouseButton1Down:Connect(function()
    MainFrame.Confirm.Visible = true
    local number = #MainFrame.Creator.ScrollingFrame:GetChildren() - 2
    MainFrame.Confirm.TextLabel.Text = "Are you sure you want to destroy row <b>".. number .."</b>?"
    local connect1, connect2 = nil, nil

    connect1 = MainFrame.Confirm.Yes.MouseButton1Click:Connect(function()
        MainFrame.Confirm.Visible = false
        
        MainFrame.Creator.ScrollingFrame["" .. number]:Destroy()

        connect1:Disconnect()
        connect2:Disconnect()
    end)

    connect2 = MainFrame.Confirm.No.MouseButton1Click:Connect(function()
        MainFrame.Confirm.Visible = false
        connect1:Disconnect()
        connect2:Disconnect()
    end)
end)

local function ScrollingFrameChildrenChanged()
    local Desired = Vector2.new(0.005, 0)
    local Desired_Size = Vector2.new(0.066, 1)

    MainFrame:WaitForChild("Creator", 5) -- No comment, just errors without this

    local AbsoluteSize = MainFrame.Creator.ScrollingFrame.AbsoluteSize
    local Padding = Desired * AbsoluteSize
    Padding = UDim2.fromOffset(Padding.X, Padding.Y)
    local Size = Desired_Size * AbsoluteSize
    Size = UDim2.fromOffset(Size.X, Size.Y)
    MainFrame.Creator.ScrollingFrame.UIGridLayout.CellPadding = Padding
    MainFrame.Creator.ScrollingFrame.UIGridLayout.CellSize = Size
    MainFrame.Creator.ScrollingFrame.CanvasSize = UDim2.fromOffset(MainFrame.Creator.ScrollingFrame.UIGridLayout.AbsoluteContentSize.X + Padding.X.Offset + Size.X.Offset, 0)

    local number = #MainFrame.Creator.ScrollingFrame:GetChildren() - 2
    if number > 1 then
        MainFrame.Creator.ScrollingFrame.Last.Devider.subtract.Visible = true
    else
        MainFrame.Creator.ScrollingFrame.Last.Devider.subtract.Visible = false
    end
end

MainFrame.Creator.ScrollingFrame.ChildAdded:Connect(ScrollingFrameChildrenChanged)
MainFrame.Creator.ScrollingFrame.ChildRemoved:Connect(ScrollingFrameChildrenChanged)

-- Add/Remove Rows
-- TBD
-- local function addrows(start: number, end_num: number): nil
--     for i,v in pairs(MainFrame.Creator.ScrollingFrame:GetChildren()) do
--         if i >= start and i <= end_num then
--             local clone = v["1"]:Clone()
--             clone.Name = #v:GetChildren() - 2
--             clone.LayoutOrder = #v:GetChildren() + 1
--             clone.Parent = v
--             print(clone)
--             addbutton(clone, v)
--         end
--     end
-- end

-- local function removerows(start: number, end_num: number): nil
--     for i,v in pairs(MainFrame.Creator.ScrollingFrame:GetChildren()) do
--         if i >= start and i <= end_num then
--             v["" .. #v:GetChildren() - 2]:Destroy()
--             print(#v:GetChildren() - 2)
--         end
--     end
-- end

-- MainFrame.Creator.Pointer.Bottom.add.MouseButton1Down:Connect(function()
--     addrows(1, #MainFrame.Creator.ScrollingFrame:GetChildren() - 1)
-- end)

-- MainFrame.Creator.Pointer.Bottom.subtract.MouseButton1Down:Connect(function()
--     removerows(1, #MainFrame.Creator.ScrollingFrame:GetChildren() - 1)
-- end)

-- Buttons
for i,v in pairs(MainFrame.Creator.Info.Buttons:GetChildren()) do
    if table.find(ButColors, v.Name) then
        v.MouseButton1Down:Connect(function()
            changecolor(table.find(ButColors, v.Name))
        end)
    end
end

MainFrame.Creator.Info.Buttons.Reset.MouseButton1Down:Connect(function()
    reset()
end)

MainFrame.Creator.Info.Buttons.Lock.MouseButton1Down:Connect(function()
    if Locked then
        Locked = false
        MainFrame.Creator.Info.Buttons.Lock.ImageLabel.ImageColor3 = Color3.fromRGB(100, 100, 100)
    else
        Locked = true
        MainFrame.Creator.Info.Buttons.Lock.ImageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255)
    end
end)

Button.Click:Connect(function()
    GUI.Enabled = not GUI.Enabled
end)

GUI:GetPropertyChangedSignal("Enabled"):Connect(function()
    Button:SetActive(GUI.Enabled)
    Pause = true
end)

local function update(pointer: GuiBase2d, bpm: TextBox, start_column: number, end_column: number)
    print(pointer, bpm, start_column, end_column)
    local beats = tonumber(bpm.Text) or 700
    local Count = #MainFrame.Creator.Pointer:GetChildren() - 4
    local Current = 1
    local Pointer = MainFrame.Creator.Pointer["1"].Pointer
    print(beats, Count)
    bpm:GetPropertyChangedSignal("Text"):Connect(function()
        beats = tonumber(bpm.Text) or 700
    end)

    while task.wait(beats/6000) do
        if not Pause then
            Pointer.Parent = MainFrame.Creator.Pointer[Current]
            for i,v in pairs(MainFrame.Creator.ScrollingFrame:GetChildren()) do
                if i >= start_column and i <= end_column and v.Name ~= "Last" and v:IsA("Frame") then
                    v.Top.ImageColor3 = v[Current].ImageColor3
                end
            end

            if Current == Count then
                Current = 1
            else
                Current += 1
            end
        end
    end
end

local coro = coroutine.create(update(MainFrame.Creator.Pointer, MainFrame.Creator.Info.BPM, 1, 99))
coroutine.resume(coro)