--[[
Redon Tech 2023
EVC V2
--]]

return function(colors: { number:Color3 }, colorLabels: { number:string })
	local color = Instance.new("ScrollingFrame")
	color.Name = "Color"
	color.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	color.CanvasSize = UDim2.new()
	color.ScrollBarThickness = 5
	color.ScrollingDirection = Enum.ScrollingDirection.Y
	color.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	color.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
	color.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left
	color.AnchorPoint = Vector2.new(0.5, 0)
	color.BackgroundColor3 = Color3.fromRGB(64, 64, 64)
	color.BorderSizePixel = 0
	color.LayoutOrder = 1
	color.Position = UDim2.new(0.5, 0, 0, 170)
	color.Size = UDim2.new(1, 0, 0, 100)
	color.ZIndex = 2
	color.Visible = false

	local uICorner = Instance.new("UICorner")
	uICorner.Name = "UICorner"
	uICorner.CornerRadius = UDim.new(0, 5)
	uICorner.Parent = color

	local uIListLayout = Instance.new("UIListLayout")
	uIListLayout.Name = "UIListLayout"
	uIListLayout.Padding = UDim.new(0, 5)
	uIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	uIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	uIListLayout.Parent = color

	local function canvasSize()
		color.CanvasSize = UDim2.fromOffset(0, uIListLayout.AbsoluteContentSize.Y)
	end
	uIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(canvasSize)

	for i: number,v: Color3 in pairs(colors) do
		local textButton = Instance.new("TextButton")
		textButton.Name = colorLabels[i]
		textButton.FontFace = Font.new(
			"rbxasset://fonts/families/Arial.json",
			Enum.FontWeight.Bold,
			Enum.FontStyle.Normal
		)
		textButton.Text = colorLabels[i]
		textButton.TextColor3 = v
		textButton.TextScaled = true
		textButton.TextSize = 14
		textButton.TextWrapped = true
		textButton.Active = true
		textButton.AnchorPoint = Vector2.new(0.5, 0.5)
		textButton.BackgroundTransparency = 1
		textButton.Position = UDim2.fromScale(0.5, 0.5)
		textButton.Selectable = true
		textButton.Size = UDim2.new(1, 0, 0, 15)
		textButton.ZIndex = 3
		textButton.LayoutOrder = i

		local uITextSizeConstraint = Instance.new("UITextSizeConstraint")
		uITextSizeConstraint.Name = "UITextSizeConstraint"
		uITextSizeConstraint.MaxTextSize = 25
		uITextSizeConstraint.Parent = textButton

		textButton.Parent = color
	end

	return color
end