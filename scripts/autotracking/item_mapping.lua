-- Super Smash Bros. Melee Item Mapping for Archipelago
ITEM_MAPPING = {
    -- Characters (progression items)
    [0x01] = {"Jigglypuff", "toggle"},
    [0x02] = {"Dr. Mario", "toggle"},
    [0x03] = {"Pichu", "toggle"},
    [0x04] = {"Falco", "toggle"},
    [0x05] = {"Marth", "toggle"},
    [0x06] = {"Young Link", "toggle"},
    [0x07] = {"Ganondorf", "toggle"},
    [0x08] = {"Mewtwo", "toggle"},
    [0x09] = {"Luigi", "toggle"},
    [0x0A] = {"Roy", "toggle"},
    [0x0B] = {"Mr. Game & Watch", "toggle"},
    [0x0C] = {"Mario", "toggle"},
    [0x0D] = {"Bowser", "toggle"},
    [0x0E] = {"Peach", "toggle"},
    [0x0F] = {"Yoshi", "toggle"},
    [0x10] = {"Donkey Kong", "toggle"},
    [0x11] = {"Captain Falcon", "toggle"},
    [0x12] = {"Fox", "toggle"},
    [0x13] = {"Ness", "toggle"},
    [0x14] = {"Ice Climbers", "toggle"},
    [0x15] = {"Kirby", "toggle"},
    [0x16] = {"Samus", "toggle"},
    [0x17] = {"Zelda", "toggle"},
    [0x18] = {"Link", "toggle"},
    [0x19] = {"Pikachu", "toggle"},

    -- Stages
    [0x1A] = {"Brinstar Depths", "toggle"},
    [0x1B] = {"Fourside", "toggle"},
    [0x1C] = {"Big Blue", "toggle"},
    [0x1D] = {"Poke Floats", "toggle"},
    [0x1E] = {"Mushroom Kingdom II", "toggle"},
    [0x1F] = {"Dream Land", "toggle"},
    [0x20] = {"Kongo Jungle Past", "toggle"},
    [0x21] = {"Yoshi's Island Past", "toggle"},
    [0x22] = {"Battlefield", "toggle"},
    [0x23] = {"Final Destination", "toggle"},
    [0x24] = {"Flat Zone", "toggle"},

    -- 1P Modes
    [0x25] = {"Adventure Mode", "toggle"},
    [0x26] = {"Classic Mode", "toggle"},
    [0x27] = {"All-Star Mode", "toggle"},
    [0x28] = {"Target Test", "toggle"},
    [0x29] = {"Home-Run Contest", "toggle"},
    [0x2A] = {"Multi-Man Melee", "toggle"},
    [0x2B] = {"Events"},

    -- Character Trophies (examples - there are many more)
    [0x2C] = {"Mario (Trophy)", "toggle"},
    [0x2D] = {"Mario (Smash Trophy)", "toggle"},
    [0x2E] = {"Mario (Smash Alt Trophy)", "toggle"},

    -- Lottery Pool Upgrades
    [0x151] = {"Lottery", "progressive"},
    [0x152] = {"Lottery Pool Upgrade (Adventure/Classic Clear)", "toggle"},
    [0x153] = {"Lottery Pool Upgrade (Secret Characters)", "toggle"},
    [0x154] = {"Lottery Pool Upgrade (200 Vs. Matches)", "toggle"},
    [0x155] = {"Lottery Pool Upgrade (250 Trophies)", "toggle"},

    -- Special items
    [0x159] = {"Pikmin Savefile", "toggle"},

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
    LotteryPoolMode = "lottery_pool_mode",
    Eventsanity = "event_checks",
    HardModesClear = "hard_modes_clear",
    AnnoyingMultiManChecks = "enable_annoying_multiman_checks",
    AllClassicTrophies = "all_classic_trophies",
    AllAdventureTrophies = "all_adventure_trophies",
    AllAllStarTrophies = "all_allstar_trophies"
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
