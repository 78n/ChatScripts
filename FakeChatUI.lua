local UI = {}

local function Create(instance, properties, children)
    local obj = Instance.new(instance)

    for i, v in next, properties or {} do
        obj[i] = v
        for _, child in next, children or {} do
            child.Parent = obj;
        end
    end
    return obj;
end

local CmdBarBackground = Create("Frame",{Parent = FakeChatStorage.UI,BackgroundColor3 = Color3.fromRGB(0,0,0),BorderSizePixel = 0,Position = UDim2.new(0.5, -420/2, 1, 0),Size = UDim2.new(0, 420, 0, 40)})
local Main = Create("Frame",{Parent = CmdBarBackground,BackgroundTransparency = 1,Position = UDim2.new(0, 2, 0, 2),Size = UDim2.new(1, -4, 1, -4)})
local TextBox = Create("TextBox",{Parent = Main,BackgroundColor3 = Color3.fromRGB(81,87,98),BorderSizePixel = 0,BackgroundTransparency = 0.5,Size = UDim2.new(1, 0, 1, 0),Font = Enum.Font.Ubuntu,Text = "",TextColor3 = Color3.fromRGB(200,200,200),TextScaled = true,TextSize = 14.000,TextWrapped = true})
Create("UICorner",{CornerRadius = UDim.new(0, 5),Parent = CmdBarBackground})
Create("UICorner",{CornerRadius = UDim.new(0, 5),Parent = Main})

function UI:SetText(text)
	TextBox.Text = text
end

function UI:GetTextBox()
    return TextBox
end

function UI:GetFrame()
    return Main
end

function UI:GetBackground()
    return CmdBarBackground
end

return UI
