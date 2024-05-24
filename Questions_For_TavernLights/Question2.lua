
--[[
	@brief print names of all guilds that have less than memberCount max members

	@param memberCount, The threshold value that allows guilds less than the value to be printed
	@return void
]]
function printSmallGuildNames(memberCount)
	-- Ensures memberCount is a positive integer
	local threshold = (memberCount > 0) and math.floor(memberCount) or 0
	local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < %d;"
	local resultId = db.storeQuery(string.format(selectGuildQuery, threshold))

	if resultId ~= nil then
		repeat
			local guildName = result.getString("name")
			print(guildName .. "\n")

		until result.next(resultId) == nil
		result.free(resultID)
	else
		print(string.format("No guilds have less than %i \n", threshold))
	end
end
