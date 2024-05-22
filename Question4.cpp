/**
 * @brief Add an item to the player
 *
 * @param recipient, Name of the player in interest
 * @param itemId, ID of the item that needs to be added 
 * @return void
 */
void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
	bool shouldMemoryBeDeallocated = false;
	Player* player = g_game.getPlayerByName(recipient);
	if (!player)
	{
		player = new Player(nullptr);
		if (!IOLoginData::loadPlayerByName(player, recipient))
		{
			Return;
		}
		shouldMemoryBeDeallocated = true;
	}


	Item* item = Item::CreateItem(itemId);
	if (!item)
	{
		Return;
	}

	// Adds Item to player
	g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);


	if (player->isOffline())
	{
		IOLoginData::savePlayer(player);
	}

	//Clear any memory that was allocated
	if (shouldMemoryBeDeallocated)
	{
		delete player;
	}
}
