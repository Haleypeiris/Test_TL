--[[
-- The code is designed to call addEvent multiple times with variations of the combat area to show the random
-- ice tornadoes occurring when casting 'exevo gran mas frigo'. The delay was added to ensure that the animation naturally
-- stops at different times. A random number generator was used to vary between which tornadoes were showing or not.
-- The random number generator would change each time a player starts the server, keeping the animation unique :)

-- Area 1 could have been copied multiple times using a function but that would mean the amount of memory needed would
-- increase on cast. For low spec computers or phones, it would be better if the memory doesn't change when running a
-- script. This is why there are 3 areas hardcoded.

-- TODO: increase the animation speed to better replicate the video.

]]

local combats = {}
local delay = 800
local areas = {
	-- Area 1
	{{0, 0, 0, 1, 0, 0, 0},
	 {0, 0, 1, 1, 1, 0, 0},
	 {0, 1, 1, 1, 1, 1, 0},
	 {1, 1, 1, 2, 1, 1, 1},
	 {0, 1, 1, 1, 1, 1, 0},
	 {0, 0, 1, 1, 1, 0, 0},
	 {0, 0, 0, 1, 0, 0, 0}},

	-- Area 2
	{{0, 0, 0, 1, 0, 0, 0},
	 {0, 0, 1, 1, 1, 0, 0},
	 {0, 1, 1, 1, 1, 1, 0},
	 {1, 1, 1, 2, 1, 1, 1},
	 {0, 1, 1, 1, 1, 1, 0},
	 {0, 0, 1, 1, 1, 0, 0},
	 {0, 0, 0, 1, 0, 0, 0}},

	-- Area 3
	{{0, 0, 0, 1, 0, 0, 0},
	 {0, 0, 1, 1, 1, 0, 0},
	 {0, 1, 1, 1, 1, 1, 0},
	 {1, 1, 1, 2, 1, 1, 1},
	 {0, 1, 1, 1, 1, 1, 0},
	 {0, 0, 1, 1, 1, 0, 0},
	 {0, 0, 0, 1, 0, 0, 0}},
}

for area, area_value in ipairs(areas) do
	for row, row_value in ipairs(area_value) do
		local zero_counter = 0
		for col, col_value in ipairs(row_value) do
			-- The counter ensures that there will be some times with the animation
			if(col_value == 1 and zero_counter<2) then
				local new_value = math.random(0,1)
				areas[area][row][col] = new_value
				zero_counter = new_value + zero_counter

			end
		end
	end
end

-- Cast spell multiple times with different areas
function onGetFormulaValues(player, level, magicLevel)
	local min = 0
	local max = 0
	return -min, -max
end

for i = 1, #areas do
	combats[i] = Combat()
	combats[i]:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
	combats[i]:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO )
	combats[i]:setArea(createCombatArea(areas[i]))

	function onGetFormulaValues(player, level, magicLevel)
		local min = 0
		local max = 0
		return -min, -max
	end
	combats[i]:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
end

local function castSpell(creatureId, variant, combatIndex)
	local creature = Creature(creatureId)
	if creature then
		combats[combatIndex]:execute(creature, variant)
	end
end

function onCastSpell(creature, variant)
	for i = 1, #areas do
		addEvent(castSpell, (delay * i)-delay, creature:getId(), variant, i)
	end
	return combats[1]:execute(creature, variant)
end
