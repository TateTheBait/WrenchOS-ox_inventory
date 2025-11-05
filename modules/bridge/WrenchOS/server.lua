local Inventory = require 'modules.inventory.server'



RegisterNetEvent('WrenchOS:PlayerExiting', server.playerDropped)

local function setCharacterInventory(character, plrid)
    character = {
        source = plrid,
        identifier = character.charid,
        name = ("%s %s"):format(character.firstname, character.lastname),
        dateofbirth = "",
        sex = "Male",
        groups = {character.job},
    }
    server.setPlayerInventory(character, json.decode(character.inventory))
    Inventory.SetItem(character.plrid, "money", character.cash)
end


RegisterNetEvent("WrenchOS:playerJoined", function(character)
    if not character then return end
	Wait(1000)
    setCharacterInventory(exports.WrenchOS:getPlayer(character), character)
end)

---@diagnostic disable-next-line: duplicate-set-field
function server.syncInventory(inv)
    local accounts = Inventory.GetAccountItemCounts(inv)

    if accounts then
        local player = exports.WrenchOS:getPlayer(inv.id)
        if player.cash < accounts.money then
			exports.WrenchOS:addMoney(inv.id, "cash", math.min(accounts.money-player.cash, 2147483647))
		elseif player.cash > accounts.money then
			exports.WrenchOS:withdrawMoney(inv.id, "cash", math.min(player.cash-accounts.money, 2147483647))
		end
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function server.setPlayerData(player)
    player.groups = {exports.WrenchOS:getPlayer(player.source).job}
    return player
end

---@diagnostic disable-next-line: duplicate-set-field
function server.hasLicense(inv, name)
	local player = exports.WrenchOS:getPlayer(inv.id)

    if not player then return end

	return true
end

---@diagnostic disable-next-line: duplicate-set-field
function server.buyLicense(inv, license)
	
end

---@diagnostic disable-next-line: duplicate-set-field
function server.isPlayerBoss(playerId, group, grade)
	local groupdata = false
	if exports.WrenchOS:getPlayer(playerId).job == "HIGHSTAFF" then
		groupdata = true
	end
	return groupdata
end

---@param entityId number
---@return number | string
---@diagnostic disable-next-line: duplicate-set-field
function server.getOwnedVehicleId(entityId)
    return true
end
