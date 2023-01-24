FakeChatStorage.UI = Create("ScreenGui",{ResetOnSpawn = false,Parent = (gethui and gethui()) or CoreGui:FindFirstChildWhichIsA("ScreenGui") or CoreGui})
local UI = FakeChatStorage.UI
local CmdBarBackground = Create("Frame",{Parent = UI,BackgroundColor3 = Color3.fromRGB(0,0,0),BorderSizePixel = 0,Position = UDim2.new(0.5, -420/2, 1, 0),Size = UDim2.new(0, 420, 0, 40)})
local Main = Create("Frame",{Parent = CmdBarBackground,BackgroundTransparency = 1,Position = UDim2.new(0, 2, 0, 2),Size = UDim2.new(1, -4, 1, -4)})
local TextBox = Create("TextBox",{Parent = Main,BackgroundColor3 = Color3.fromRGB(81,87,98),BorderSizePixel = 0,BackgroundTransparency = 0.5,Size = UDim2.new(1, 0, 1, 0),Font = Enum.Font.Ubuntu,Text = "",TextColor3 = Color3.fromRGB(200,200,200),TextScaled = true,TextSize = 14.000,TextWrapped = true})
Create("UICorner",{CornerRadius = UDim.new(0, 5),Parent = CmdBarBackground})
Create("UICorner",{CornerRadius = UDim.new(0, 5),Parent = Main})


local info = TweenInfo.new(0.5, Enum.EasingStyle.Bounce)
local show = TweenService:Create(CmdBarBackground, info, {Position = UDim2.new(0.5, -CmdBarBackground.AbsoluteSize.X/2, 0.9, -60)})
local hide = TweenService:Create(CmdBarBackground, info, {Position = UDim2.new(0.5, -CmdBarBackground.AbsoluteSize.X/2, 1, 0)})
local tweening = false

function toggle()
    if not tweening then
        tweening = true
        if CmdBarBackground.Position.X.Offset == 0 then
            hide:Play()
            TextBox:ReleaseFocus()
            TextBox.Text = ''
            hide.Completed:Wait()
        else
            show:Play()
            TextBox:CaptureFocus()
            show.Completed:Wait()
        end
        tweening = false
    end
end

TextBox.FocusLost:Connect(function(enterPressed)
    tweening = true
    if enterPressed then
        local originalstring = TextBox.Text
        local args = originalstring:split(' ')
		if args[2] then
			local cmd = args[1]:lower()
			if #cmd+#args[2]+3 <= #originalstring then
				local msg = originalstring:sub(#cmd+#args[2]+3,#originalstring)
				
				if cmdlist[cmd] then
					cmdlist[cmd](originalstring,args,cmd,msg)
				end
			end
		end
    end
    hide:Play()
    TextBox:ReleaseFocus()
    TextBox.Text = ''
    hide.Completed:Wait()
    tweening = false
end)

UserInputService.InputBegan:Connect(function(input, gp)
    if not gp then
        if input.UserInputType == Enum.UserInputType.Keyboard then
            local key = input.KeyCode
            if key == Enum.KeyCode.Quote then
				rs.Heartbeat:Wait()
                toggle()
            end
        end
    end
end)
