-- Super Smash Bros. Melee  Auto-tracking Script for Archipelago

-- Configuration
CUR_INDEX = -1
SLOT_DATA = nil
DEBUG_ENABLED = true

-- Helper function for debug messages
local function debugPrint(message)
    if DEBUG_ENABLED then
        print("[SSBM DEBUG] " .. message)
    end
end
local function dump_table(o, depth)
    if depth == nil then
        depth = 0
    end
    if type(o) == 'table' then
        local tabs = ('\t'):rep(depth)
        local tabs2 = ('\t'):rep(depth + 1)
        local s = '{\n'
        for k, v in pairs(o) do
            if type(k) ~= 'number' then
                k = '"' .. k .. '"'
            end
            s = s .. tabs2 .. '[' .. k .. '] = ' .. dump_table(v, depth + 1) .. ',\n'
        end
        return s .. tabs .. '}'
    else
        return tostring(o)
    end
end

-- Character item IDs to character codes mapping (from your item data)
local CHARACTER_ITEM_MAPPING = {
    -- Secret characters (hex format)
    [0x01] = "Jigglypuff",
    [0x02] = "Dr. Mario",
    [0x03] = "Pichu",
    [0x04] = "Falco",
    [0x05] = "Marth",
    [0x06] = "Young Link",
    [0x07] = "Ganondorf",
    [0x08] = "Mewtwo",
    [0x09] = "Luigi",
    [0x0A] = "Roy",
    [0x0B] = "Mr. Game & Watch",

    -- Starting characters (locked in randomizer until found) (hex format)
    [0x0C] = "Mario",
    [0x0D] = "Bowser",
    [0x0E] = "Peach",
    [0x0F] = "Yoshi",
    [0x10] = "Donkey Kong",
    [0x11] = "Captain Falcon",
    [0x12] = "Fox",
    [0x13] = "Ness",
    [0x14] = "Ice Climbers",
    [0x15] = "Kirby",
    [0x16] = "Samus",
    [0x17] = "Zelda",
    [0x18] = "Link",
    [0x19] = "Pikachu",
}

-- Function to update character unlock from item receipt
local function updateCharacterFromItem(item_id, item_name)
    debugPrint("Attempting character unlock - ID: " .. tostring(item_id) .. ", Name: " .. tostring(item_name))

    local character_code = nil

    -- Try ID-based mapping first (both hex and decimal)
    if item_id and CHARACTER_ITEM_MAPPING[item_id] then
        character_code = CHARACTER_ITEM_MAPPING[item_id]
        debugPrint("Found character by ID: " .. character_code)
    end

    if character_code then
        local character_obj = Tracker:FindObjectForCode(character_code)
        if character_obj then
            if not character_obj.Active then
                character_obj.Active = true
                debugPrint("SUCCESS: Character unlocked via item: " .. character_code)

                -- Update character counter
                local unlock_counter = Tracker:FindObjectForCode("characters_unlocked")
                if unlock_counter then
                    unlock_counter.AcquiredCount = unlock_counter.AcquiredCount + 1
                    debugPrint("Total characters unlocked: " .. unlock_counter.AcquiredCount)
                end
                return true
            else
                debugPrint("Character already unlocked: " .. character_code)
            end
        else
            debugPrint("ERROR: Could not find tracker object for character: " .. character_code)
        end
    else
        debugPrint("No character mapping found for ID: " .. tostring(item_id) .. ", Name: " .. tostring(item_name))
    end
    return false
end

-- Function to update trophy counters when trophies are received
local function updateTrophyCounters(item_id, item_name)
    if not item_name then return false end

    -- Check if it's a trophy item
    if item_name:find("Trophy") then
        local total_counter = Tracker:FindObjectForCode("total_trophies")
        if total_counter then
            total_counter.AcquiredCount = total_counter.AcquiredCount + 1
            debugPrint("Total trophies: " .. total_counter.AcquiredCount)
        end

        -- Check if it's a character trophy
        if item_id >= 0x2C and item_id <= 0x79 then
            -- Character trophies - determine type by pattern (every 3rd is classic, adventure, all-star)
            -- 0x2C == Classic Mario Trophy
            -- 0x2D == Adventure Mario Trophy
            -- 0x2E == All-Star Mario Trophy
            -- 0x79 == All-Star Roy Trophy
            local trophy_index = ((item_id - 0x2C) % 3)
            local category_counter = nil

            if trophy_index == 0 then -- Classic trophy
                category_counter = Tracker:FindObjectForCode("classic_trophies")
            elseif trophy_index == 1 then -- Adventure trophy
                category_counter = Tracker:FindObjectForCode("adventure_trophies")
            elseif trophy_index == 2 then -- All-Star trophy
                category_counter = Tracker:FindObjectForCode("allstar_trophies")
            end

            if category_counter then
                category_counter.AcquiredCount = category_counter.AcquiredCount + 1
            end
        end

        return true
    end

    return false
end

-- resets an item to its initial state
local function resetItem(item_code, item_type)
    local obj = Tracker:FindObjectForCode(item_code)
    if obj then
        item_type = item_type or obj.Type
        debugPrint(string.format("resetItem: resetting item %s of type %s", item_code, item_type))
        if item_type == "toggle" or item_type == "toggle_badged" then
            obj.Active = false
        elseif item_type == "progressive" or item_type == "progressive_toggle" then
            obj.CurrentStage = 0
            obj.Active = false
        elseif item_type == "consumable" then
            obj.AcquiredCount = 0
        elseif item_type == "custom" then
            -- your code for your custom lua items goes here
        elseif item_type == "static" then
            debugPrint(string.format("resetItem: tried to reset static item %s", item_code))
        elseif item_type == "composite_toggle" then
            debugPrint(string.format(
                "resetItem: tried to reset composite_toggle item %s but composite_toggle cannot be accessed via lua." ..
                "Please use the respective left/right toggle item codes instead.", item_code))
        else
            debugPrint(string.format("resetItem: unknown item type %s for code %s", item_type, item_code))
        end
    else
        debugPrint(string.format("resetItem: could not find item object for code %s", item_code))
    end
end

-- advances the state of an item
local function incrementItem(item_code, item_type, multiplier)
    local obj = Tracker:FindObjectForCode(item_code)
    if obj then
        item_type = item_type or obj.Type
        debugPrint(string.format("incrementItem: code: %s, type %s", item_code, item_type))
        if item_type == "toggle" or item_type == "toggle_badged" then
            obj.Active = true
        elseif item_type == "progressive" or item_type == "progressive_toggle" then
            if obj.Active then
                obj.CurrentStage = obj.CurrentStage + 1
            else
                obj.Active = true
            end
        elseif item_type == "consumable" then
            obj.AcquiredCount = obj.AcquiredCount + obj.Increment * multiplier
        elseif item_type == "custom" then
            -- your code for your custom lua items goes here
        elseif item_type == "static" then
            debugPrint(string.format("incrementItem: tried to increment static item %s", item_code))
        elseif item_type == "composite_toggle" then
            debugPrint(string.format(
                "incrementItem: tried to increment composite_toggle item %s but composite_toggle cannot be access via lua." ..
                "Please use the respective left/right toggle item codes instead.", item_code))
        else
            debugPrint(string.format("incrementItem: unknown item type %s for code %s", item_type, item_code))
        end
    else
        debugPrint(string.format("incrementItem: could not find object for code %s", item_code))
    end
end

-- Function to update bonus achievement counters
local function updateBonusCounters(location_id)
    -- Check if it's a bonus achievement (0x01-0xF6 range)
    if location_id >= 0x01 and location_id <= 0xF6 then
        local total_bonus_counter = Tracker:FindObjectForCode("bonus_achievements")
        if total_bonus_counter then
            total_bonus_counter.AcquiredCount = total_bonus_counter.AcquiredCount + 1
            debugPrint("Total bonus achievements: " .. total_bonus_counter.AcquiredCount)
        end
    end
end

-- Function to update event/target counters
local function updateEventTargetCounters(location_id)
    -- Event matches (0xF7-0x129 range)
    if location_id >= 0xF7 and location_id <= 0x129 then
        local event_counter = Tracker:FindObjectForCode("events_cleared")
        if event_counter then
            event_counter.AcquiredCount = event_counter.AcquiredCount + 1
            debugPrint("Events cleared: " .. event_counter.AcquiredCount)
        end
    end

    -- Target tests (0x184-0x19C range)
    if location_id >= 0x184 and location_id <= 0x19C then
        local target_counter = Tracker:FindObjectForCode("targets_cleared")
        if target_counter then
            target_counter.AcquiredCount = target_counter.AcquiredCount + 1
            debugPrint("Target tests cleared: " .. target_counter.AcquiredCount)
        end
    end
end

-- Main location handler
local function onLocation(location_id, location_name)
    debugPrint("=== LOCATION CLEARED ===")
    debugPrint("ID: " .. tostring(location_id) .. ", Name: " .. tostring(location_name or "unknown"))

    -- Update counters first
    updateBonusCounters(location_id)
    updateEventTargetCounters(location_id)

    -- Handle location mapping from your existing system
    if LOCATION_TO_TRACKER_MAP[location_id] then
        local tracker_code = LOCATION_TO_TRACKER_MAP[location_id]
        debugPrint("Using mapped tracker code: " .. tracker_code)

        local obj = Tracker:FindObjectForCode(tracker_code)
        if obj then
            if obj.AvailableChestCount and obj.AvailableChestCount > 0 then
                obj.AvailableChestCount = obj.AvailableChestCount - 1
                debugPrint("SUCCESS: Decremented chest count for: " .. tracker_code)
                return
            elseif obj.Owner and obj.Owner.AvailableChestCount and obj.Owner.AvailableChestCount > 0 then
                obj.Owner.AvailableChestCount = obj.Owner.AvailableChestCount - 1
                debugPrint("SUCCESS: Decremented parent chest count for: " .. tracker_code)
                return
            elseif obj.Active ~= nil then
                obj.Active = true
                debugPrint("SUCCESS: Activated: " .. tracker_code)
                return
            end
        else
            debugPrint("ERROR: Could not find object for mapped code: " .. tracker_code)
        end
    else
        debugPrint("WARNING: No mapping found for location ID: " .. tostring(location_id))
    end
end

-- Main item handler
local function onItem(index, item_id, item_name, player_number)
    debugPrint("=== ITEM HANDLER CALLED ===")
    debugPrint("Index: " .. tostring(index) .. ", CUR_INDEX: " .. tostring(CUR_INDEX))
    debugPrint("Item ID: " .. tostring(item_id) .. ", Name: " .. tostring(item_name or "unknown"))
    debugPrint("Player: " .. tostring(player_number) .. ", Local Player: " .. tostring(Archipelago.PlayerNumber or "unknown"))

    -- Update index tracking
    if index > CUR_INDEX then
        CUR_INDEX = index
    end

    -- Check if this is for a local player
    local is_local = (player_number == Archipelago.PlayerNumber) or (Archipelago.PlayerNumber == nil)
    debugPrint("Is local item: " .. tostring(is_local))


    debugPrint("Processing item...")

    -- Handle character unlocks
    local success = updateCharacterFromItem(item_id, item_name)
    if success then
        debugPrint("Character unlock successful!")
        return
    end

    if updateTrophyCounters(item_id, item_name) then
        if not ITEM_MAPPING[item_id] then return end -- Not all trophies have mapping entries
    end

    -- Handle other item types (coins, etc.)
    if item_name == "Coin" then
        local coin_counter = Tracker:FindObjectForCode("coins_collected")
        if coin_counter then
            coin_counter.AcquiredCount = coin_counter.AcquiredCount + 1
            debugPrint("Added 1 coin, total: " .. coin_counter.AcquiredCount)
        end
    elseif item_name == "10 Coins" then
        local coin_counter = Tracker:FindObjectForCode("coins_collected")
        if coin_counter then
            coin_counter.AcquiredCount = coin_counter.AcquiredCount + 10
            debugPrint("Added 10 coins, total: " .. coin_counter.AcquiredCount)
        end
    elseif item_name == "20 Coins" then
        local coin_counter = Tracker:FindObjectForCode("coins_collected")
        if coin_counter then
            coin_counter.AcquiredCount = coin_counter.AcquiredCount + 20
            debugPrint("Added 20 coins, total: " .. coin_counter.AcquiredCount)
        end
    end

    local mapping_entry = ITEM_MAPPING[item_id]
    if not mapping_entry then
        debugPrint(string.format("onItem: could not find item mapping for id %s", item_id))
        return
    end
    incrementItem(mapping_entry[1], mapping_entry[2], mapping_entry[3] or 1)
end

-- Clear handler for reset
local function onClear(slot_data)
    debugPrint("=== CLEARING TRACKER STATE ===")
    SLOT_DATA = slot_data
    CUR_INDEX = -1

    -- Gets all settings
    debugPrint("Dump slot_data:".. dump_table(slot_data))
    Tracker:FindObjectForCode(ItemSettings.GoalTrophies).AcquiredCount = slot_data[ItemSettings.GoalTrophies]
    Tracker:FindObjectForCode(ItemSettings.GoalGigaBowser).Active = slot_data[ItemSettings.GoalGigaBowser] == 1
    Tracker:FindObjectForCode(ItemSettings.GoalCrazyHand).Active = slot_data[ItemSettings.GoalCrazyHand] == 1
    Tracker:FindObjectForCode(ItemSettings.GoalEvent51).Active = slot_data[ItemSettings.GoalEvent51] == 1
    Tracker:FindObjectForCode(ItemSettings.GoalAllEvents).Active = slot_data[ItemSettings.GoalAllEvents] == 1
    Tracker:FindObjectForCode(ItemSettings.GoalAllTargets).Active = slot_data[ItemSettings.GoalAllTargets] == 1
    local lotteryModeIndex = LOTTERY_POOL_MODE_MAPPING[slot_data[ItemSettings.LotteryPoolMode]]
    if lotteryModeIndex == nil then
        debugPrint("WARNING: Invalid Lottery Pool Mode in slot data: " .. tostring(slot_data[ItemSettings.LotteryPoolMode]))
        lotteryModeIndex = 1 -- Default to first option
    end
    Tracker:FindObjectForCode(ItemSettings.LotteryPoolMode).CurrentStage = lotteryModeIndex

    -- Gets settings deduced from available locations
    local allLocations = {}
    for _, locationId in ipairs(Archipelago.CheckedLocations) do
        allLocations[locationId] = true
    end
    for _, locationId in ipairs(Archipelago.MissingLocations) do
        allLocations[locationId] = true
    end
    Tracker:FindObjectForCode(ItemSettings.Bonussanity).Active = allLocations[0x01] or false -- Bonus - Dedicated Specialist
    Tracker:FindObjectForCode(ItemSettings.BonusHardChecks).Active = allLocations[0x09] or false -- Bonus - All Variations
    Tracker:FindObjectForCode(ItemSettings.BonusExtremeChecks).Active = allLocations[0x26] or false -- Bonus - Power Shielder
    Tracker:FindObjectForCode(ItemSettings.Eventsanity).Active = allLocations[0xF7] or false -- Event Match 1 - Trouble King
    Tracker:FindObjectForCode(ItemSettings.TenManSanity).Active = allLocations[0x273] or false -- Multi Man Melee - Mario 10-Man
    Tracker:FindObjectForCode(ItemSettings.HardModesClear).Active = allLocations[0x182] or false -- Classic Mode - Hard/Continueless Clear
    Tracker:FindObjectForCode(ItemSettings.AnnoyingMultiManChecks).Active = allLocations[0x1A0] or false -- Multi-Man Melee - 15 Minute Melee Clear
    Tracker:FindObjectForCode(ItemSettings.TargetClearChecks).Active = allLocations[0x184] or false -- Target Test - Mario
    Tracker:FindObjectForCode(ItemSettings.LongTargetTestChecks).Active = allLocations[0x19D] or false -- Target Test - All Characters, Sub 12:30 Total Time
    Tracker:FindObjectForCode(ItemSettings.MewtwoUnlockCheck).Active = allLocations[0x1C0] or false -- Melee - Mewtwo Unlock Match
    Tracker:FindObjectForCode(ItemSettings.RarePokemonChecks).Active = allLocations[0x1A8] or false -- Melee - See Mew
    Tracker:FindObjectForCode(ItemSettings.VSCountChecks).Active = allLocations[0x1C4] or false -- Melee - 10 VS. Matches
    Tracker:FindObjectForCode(ItemSettings.DiskunTrophyCheck).Active = allLocations[0x1A4] or false -- Melee - All Bonuses
    Tracker:FindObjectForCode(ItemSettings.AllClassicTrophies).Active = allLocations[0x183] or false -- Classic Mode - All Character Trophies
    Tracker:FindObjectForCode(ItemSettings.AllAdventureTrophies).Active = allLocations[0x17B] or false -- Adventure Mode - All Character Trophies
    Tracker:FindObjectForCode(ItemSettings.AllAllStarTrophies).Active = allLocations[0x180] or false -- All-Star Mode - All Character Trophies
    Tracker:FindObjectForCode(ItemSettings.Use250TrophyPool).Active = allLocations[0x25C] or false -- Lottery (250 Trophies) - GCN

    -- Reset all items
    for _, mapping_entry in pairs(ITEM_MAPPING) do
        if mapping_entry then
            resetItem(mapping_entry[1], mapping_entry[2])
        end
    end

    -- Reset counters
    local counters = {
        "total_trophies", "bonus_achievements", "events_cleared",
        "targets_cleared", "classic_trophies", "adventure_trophies",
        "allstar_trophies", "characters_unlocked", "coins_collected"
    }

    for _, counter_code in ipairs(counters) do
        local counter = Tracker:FindObjectForCode(counter_code)
        if counter then
            counter.AcquiredCount = 0
        end
    end

    -- Set character counter to 1 (starting with 1 random character)
    local unlock_counter = Tracker:FindObjectForCode("characters_unlocked")
    if unlock_counter then
        unlock_counter.AcquiredCount = 1
        debugPrint("Reset complete - starting with 1 character unlocked")
    end

    debugPrint("=== TRACKER RESET COMPLETE ===")
end

-- Helper function to count table entries
local function table_length(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

-- Initialize autotracking
if Archipelago then
    Archipelago:AddClearHandler("ssbm_clear", onClear)
    Archipelago:AddItemHandler("ssbm_item", onItem)
    Archipelago:AddLocationHandler("ssbm_location", onLocation)

    print("==========================================")
    print("Super Smash Bros. Melee Auto-Tracker")
    print("Character tracking")
    print("Location mappings: " .. table_length(LOCATION_TO_TRACKER_MAP))
    print("Character items: " .. table_length(CHARACTER_ITEM_MAPPING))
    print("Counter tracking: ENABLED")
    print("Debug mode: " .. tostring(DEBUG_ENABLED))
    print("==========================================")
else
    print("ERROR: Archipelago object not found!")
end