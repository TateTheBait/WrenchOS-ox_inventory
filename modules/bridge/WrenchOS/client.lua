local function reorderGroups(groups)
    groups = groups or {}
    for group, info in pairs(groups) do
        groups[group] = {"civ"}
    end
    return groups
end

RegisterNetEvent("WrenchOS:PlayerExiting", client.onLogout)

SetTimeout(500, function()
    if not player then return end
    client.setPlayerData("groups", reorderGroups())
end)

RegisterNetEvent("ND:characterLoaded", function(character)
    client.setPlayerData("groups", reorderGroups())
end)

RegisterNetEvent("ND:updateCharacter", function(character)
    client.setPlayerData("groups", reorderGroups())
end)

---@diagnostic disable-next-line: duplicate-set-field
function client.setPlayerStatus(values)

end