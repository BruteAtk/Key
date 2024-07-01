local Players = game:GetService("Players")

-- Function to create and apply highlights based on role for all players and C4Bomb parts
local function applyHighlightsForAll()
    -- Apply highlights for players
    for _, player in ipairs(Players:GetPlayers()) do
        local character = player.Character
        if character then
            -- Clear existing highlights
            for _, highlight in ipairs(character:GetChildren()) do
                if highlight:IsA("Highlight") then
                    highlight:Destroy()
                end
            end

            -- Check the player's role
            local publicStates = player:FindFirstChild("PublicStates")
            if publicStates then
                local roleValue = publicStates:FindFirstChild("Role")
                if roleValue and roleValue:IsA("StringValue") then
                    local role = roleValue.Value
                    local highlight = Instance.new("Highlight")
                    highlight.Adornee = character

                    -- Set color based on role
                    if role == "Imposter" then
                        highlight.FillColor = Color3.new(1, 0, 0) -- Red for Imposter
                        highlight.OutlineColor = Color3.new(1, 0, 0)
                    elseif role == "Crewmate" then
                        highlight.FillColor = Color3.new(0, 1, 0) -- Green for Crewmate
                        highlight.OutlineColor = Color3.new(0, 1, 0)
                    end

                    -- Set transparency to make it glow
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0

                    highlight.Parent = character
                end
            end
        end
    end

    -- Apply highlight for parts named "C4Bomb"
    for _, part in ipairs(game.Workspace:GetDescendants()) do
        if part:IsA("BasePart") and part.Name == "C4Bomb" then
            local highlight = Instance.new("Highlight")
            highlight.Adornee = part
            highlight.FillColor = Color3.new(1, 0, 0) -- Red for C4Bomb
            highlight.OutlineColor = Color3.new(1, 0, 0)
            highlight.FillTransparency = 0.5
            highlight.OutlineTransparency = 0
            highlight.Parent = part
        end
    end
end

-- Function to repeatedly apply highlights every 1 second
local function applyHighlightsLoop()
    while true do
        applyHighlightsForAll()
        wait(1)
    end
end

-- Apply highlights initially and start the loop
for _, player in ipairs(Players:GetPlayers()) do
    player.CharacterAdded:Connect(function(character)
        applyHighlightsForAll()
    end)
    if player.Character then
        applyHighlightsForAll()
    end
end

applyHighlightsLoop()
