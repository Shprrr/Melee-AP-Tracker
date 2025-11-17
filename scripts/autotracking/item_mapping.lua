-- Super Smash Bros. Melee Item Mapping for Archipelago
ITEM_MAPPING = {
    -- Characters (progression items)
    [1] = {"Jigglypuff", "toggle"},
    [2] = {"Dr. Mario", "toggle"},
    [3] = {"Pichu", "toggle"},
    [4] = {"Falco", "toggle"},
    [5] = {"Marth", "toggle"},
    [6] = {"Young Link", "toggle"},
    [7] = {"Ganondorf", "toggle"},
    [8] = {"Mewtwo", "toggle"},
    [9] = {"Luigi", "toggle"},
    [10] = {"Roy", "toggle"},
    [11] = {"Mr. Game & Watch", "toggle"},
    [12] = {"Mario", "toggle"},
    [13] = {"Bowser", "toggle"},
    [14] = {"Peach", "toggle"},
    [15] = {"Yoshi", "toggle"},
    [16] = {"Donkey Kong", "toggle"},
    [17] = {"Captain Falcon", "toggle"},
    [18] = {"Fox", "toggle"},
    [19] = {"Ness", "toggle"},
    [20] = {"Ice Climbers", "toggle"},
    [21] = {"Kirby", "toggle"},
    [22] = {"Samus", "toggle"},
    [23] = {"Zelda", "toggle"},
    [24] = {"Link", "toggle"},
    [25] = {"Pikachu", "toggle"},

    -- Stages
    [26] = {"Brinstar Depths", "toggle"},
    [27] = {"Fourside", "toggle"},
    [28] = {"Big Blue", "toggle"},
    [29] = {"Poke Floats", "toggle"},
    [30] = {"Mushroom Kingdom II", "toggle"},
    [31] = {"Dream Land", "toggle"},
    [32] = {"Kongo Jungle Past", "toggle"},
    [33] = {"Yoshi's Island Past", "toggle"},
    [34] = {"Battlefield", "toggle"},
    [35] = {"Final Destination", "toggle"},
    [36] = {"Flat Zone", "toggle"},

    -- 1P Modes
    [37] = {"Adventure Mode", "toggle"},
    [38] = {"Classic Mode", "toggle"},
    [39] = {"All-Star Mode", "toggle"},
    [40] = {"Target Test", "toggle"},
    [41] = {"Home-Run Contest", "toggle"},
    [42] = {"Multi-Man Melee", "toggle"},
    [43] = {"Events", "progressive"},

    -- Character Trophies (examples - there are many more)
    [0x2C] = {"Mario (Trophy)", "toggle"},
    [0x2D] = {"Mario (Smash Trophy)", "toggle"},
    [0x2E] = {"Mario (Smash Alt Trophy)", "toggle"},

    -- Lottery Pool Upgrades
    [337] = {"Lottery", "progressive"},
    [338] = {"Lottery Pool Upgrade (Adventure/Classic Clear)", "toggle"},
    [339] = {"Lottery Pool Upgrade (Secret Characters)", "toggle"},
    [340] = {"Lottery Pool Upgrade (200 Vs. Matches)", "toggle"},
    [341] = {"Lottery Pool Upgrade (250 Trophies)", "toggle"},

    -- Special items
    [345] = {"Pikmin Savefile", "toggle"},

    -- Trophy items (examples)
    ["Birdo (Trophy)"] = {"Birdo (Trophy)", "toggle"},
    ["Kraid (Trophy)"] = {"Kraid (Trophy)", "toggle"},
    ["Falcon Flyer (Trophy)"] = {"Falcon Flyer (Trophy)", "toggle"},
    ["UFO (Trophy)"] = {"UFO (Trophy)", "toggle"},
    ["Sudowoodo (Trophy)"] = {"Sudowoodo (Trophy)", "toggle"}
}

ItemSettings = {
    GoalTrophies = "total_trophies_required",
    GoalGigaBowser = "giga_bowser_required",
    GoalCrazyHand = "crazy_hand_required",
    GoalEvent51 = "goal_evn_51",
    GoalAllEvents = "goal_all_events",
    GoalAllTargets = "targets_required",
    LotteryPoolMode = "lottery_pool_mode"
}

LotteryPoolMode = {
    Vanilla = 0,
    Progressive = 1,
    NonProgressive = 2
}

-- "N/A", 1 = "Progressive", 2 = "Static"
LOTTERY_POOL_MODE_MAPPING = {
    ["N/A"] = LotteryPoolMode.Vanilla,
    ["Progressive"] = LotteryPoolMode.Progressive,
    ["Static"] = LotteryPoolMode.NonProgressive
}

-- Helper function to get tracker code from item description
local function get_tracker_code_for_item(item_description)
    if ITEM_MAPPING[item_description] then
        if type(ITEM_MAPPING[item_description]) == "string" then
            return ITEM_MAPPING[item_description]
        elseif type(ITEM_MAPPING[item_description]) == "table" then
            return ITEM_MAPPING[item_description][1]
        end
    end

    -- Try numeric lookup
    local item_id = tonumber(item_description)
    if item_id and ITEM_MAPPING[item_id] then
        if type(ITEM_MAPPING[item_id]) == "table" then
            return ITEM_MAPPING[item_id][1]
        end
    end

    return nil
end

-- Helper function to get item type from tracker code
local function get_item_type(tracker_code)
    for _, mapping in pairs(ITEM_MAPPING) do
        if type(mapping) == "table" and mapping[1] == tracker_code then
            return mapping[2]
        end
    end
    return "toggle" -- Default to toggle
end

-- Function to update trophy counters when trophies are received
local function updateTrophyCounters(item_name)
    if not item_name then return end

    -- Check if it's a trophy item
    if item_name:find("Trophy") then
        local total_counter = Tracker:FindObjectForCode("total_trophies")
        if total_counter then
            total_counter.AcquiredCount = total_counter.AcquiredCount + 1
            print("Total trophies: " .. total_counter.AcquiredCount)
        end

        -- Check if it's a character trophy
        if item_name:find("Smash Trophy") or item_name:find("Smash Alt Trophy") or
           (item_name:find("Trophy") and not item_name:find("(")) then
            local char_counter = Tracker:FindObjectForCode("character_trophies")
            if char_counter then
                char_counter.AcquiredCount = char_counter.AcquiredCount + 1
                print("Character trophies: " .. char_counter.AcquiredCount)
            end
        end
    end
end