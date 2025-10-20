local shared = odh_shared_plugins

local Players = game:GetService("Players")
local client = Players.LocalPlayer
local workspace = game:GetService("Workspace")

if not shared or shared.executor == "Unknown" then return end

local notify = shared.Notify
local sct = shared.AddSection("Spam Open/Close Doors Manor")

sct:AddLabel("It will spam open/close all doors in Manor map 🤡")

local spam_doors_enabled = false

local function spamAllDoors()
    while spam_doors_enabled do
        local manor = workspace:FindFirstChild("Manor")
        local keyDoors = manor and manor:FindFirstChild("KeyDoors")
        if keyDoors then
            for _, door in pairs(keyDoors:GetChildren()) do
                local doorModel = door:FindFirstChild("Door")
                local interactiveBox = doorModel and doorModel:FindFirstChild("InteractiveBox")
                local interact = interactiveBox and interactiveBox:FindFirstChild("Interact")
                if interact then
                    pcall(function()
                        interact:FireServer()
                    end)
                end
            end
        end
        task.wait(0.1)
    end
end

sct:AddToggle("Spam All Doors", function(state)
    spam_doors_enabled = state
    if state then
        notify("Spamming all doors in Manor!", 1)
        task.spawn(spamAllDoors)
    else
        notify("Stopped spamming doors.", 4)
    end
end)

notify("Spam Open/Close Doors Manor loaded.", 1)
