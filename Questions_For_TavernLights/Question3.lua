--[[
	@brief removes a member from the player's party

	@param playerId, Name of the player of interest
	@param membername, Name of the member that is needed to be removed
	@return true if successful, false otherwise
]]
function removeMemberFromPlayerParty(playerId, membername)
	-- Assuming calling Player(playerID) accesses the correct player object
	player = Player(playerId)
	local party = player:getParty()

	-- Sanity check
	if (player == nil or membername == nil) then
		return false
	end

	for k,member in pairs(party:getMembers()) do
		if member == Player(membername) then
			party:removeMember(Player(membername))
			return true
		end
	end
	--Returns false if member name wasn't found in the party
	return false

end
