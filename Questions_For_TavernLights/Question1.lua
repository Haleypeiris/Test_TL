-- TODO: write a local descriptive name for -1
local function releaseStorage(player, storage)
	player:setStorageValue(storage, -1)
end

--[[
	@brief Adds an event to release the storage from a player

	@param player, Player object
	@return true if onLogout was successful, false otherwise
]]
function onLogout(player)

	if (player ~= nil) then
		local storage = 1000
		if player:getStorageValue(storage) == 1 then
			addEvent(releaseStorage, storage, player)
		end
		return true
	else
		return false

	end
end
