-- Super Smash Bros. Melee PopTracker Logic
-- Base ability checks

local function has(item)
    return Tracker:ProviderCountForCode(item) > 0
end

local function hasCount(item, amount)
    local count = Tracker:ProviderCountForCode(item)
    return count >= amount
end

-- =====================================
-- CHARACTER CHECKS
-- =====================================

-- Starting roster
local function has_mario()
    return has("Mario")
end

local function has_donkey_kong()
    return has("Donkey Kong")
end

local function has_link()
    return has("Link")
end

local function has_samus()
    return has("Samus")
end

local function has_yoshi()
    return has("Yoshi")
end

local function has_kirby()
    return has("Kirby")
end

local function has_fox()
    return has("Fox")
end

local function has_pikachu()
    return has("Pikachu")
end

local function has_ness()
    return has("Ness")
end

local function has_captain_falcon()
    return has("Captain Falcon")
end

-- Secret characters
local function has_bowser()
    return has("Bowser")
end

local function has_peach()
    return has("Peach")
end

local function has_ice_climbers()
    return has("Ice Climbers")
end

local function has_zelda()
    return has("Zelda")
end

local function has_luigi()
    return has("Luigi")
end

local function has_jigglypuff()
    return has("Jigglypuff")
end

local function has_mewtwo()
    return has("Mewtwo")
end

local function has_marth()
    return has("Marth")
end

local function has_mr_game_and_watch()
    return has("Mr. Game & Watch")
end

local function has_dr_mario()
    return has("Dr. Mario")
end

local function has_ganondorf()
    return has("Ganondorf")
end

local function has_falco()
    return has("Falco")
end

local function has_young_link()
    return has("Young Link")
end

local function has_pichu()
    return has("Pichu")
end

local function has_roy()
    return has("Roy")
end

-- =====================================
-- GAME MODE ACCESS
-- =====================================

local function has_adventure_mode()
    return has("Adventure Mode")
end

local function has_classic_mode()
    return has("Classic Mode")
end

local function has_all_star_mode()
    return has("All-Star Mode")
end

local function has_target_test()
    return has("Target Test")
end

local function has_home_run_contest()
    return has("Home-Run Contest")
end

local function has_multi_man_melee()
    return has("Multi-Man Melee")
end

-- =====================================
-- EVENT MATCH PROGRESSION
-- =====================================

function EventsRequired()
    return has(ItemSettings.Eventsanity) or has("goal_all_events")
end

function Events1To10Available()
    return has("Event10")
end

function Events11To15Available()
    return has("Event15")
end

function Events16To20Available()
    return has("Event20")
end

function Events21To25Available()
    return has("Event25")
end

function Events26To29Available()
    return has("Event29")
end

function Events30Available()
    return has("Event30")
end

function Events31To39Available()
    return has("Event39")
end

function Events40To50Available()
    return has("Event50")
end

function Events51Available()
    return has("Event51")
end

-- =====================================
-- CHARACTER GROUP CHECKS
-- =====================================

-- Base characters (14 total)
local function has_all_base_characters()
    return has_mario() and has_donkey_kong() and has_bowser() and has_peach() and
           has_captain_falcon() and has_yoshi() and has_fox() and has_ness() and
           has_ice_climbers() and has_kirby() and has_samus() and has_link() and
           has_pikachu() and has_zelda()
end

-- All secret characters
local function has_all_secret_characters()
    return has_luigi() and has_jigglypuff() and has_mewtwo() and has_mr_game_and_watch() and
           has_marth() and has_roy() and has_pichu() and has_ganondorf() and
           has_dr_mario() and has_young_link() and has_falco()
end

-- Everyone except Game & Watch (needed for Mr. Game & Watch unlock)
local function has_everyone_except_gamewatch()
    return has_dr_mario() and has_mario() and has_luigi() and has_bowser() and
           has_peach() and has_yoshi() and has_donkey_kong() and has_captain_falcon() and
           has_ganondorf() and has_falco() and has_fox() and has_ness() and
           has_ice_climbers() and has_kirby() and has_samus() and has_zelda() and
           has_link() and has_young_link() and has_pichu() and has_pikachu() and
           has_jigglypuff() and has_mewtwo() and has_marth() and has_roy()
end

-- Character count checks
function GroupUniqueCharacters10()
    local count = 0
    local characters = {"Mario", "Donkey Kong", "Bowser", "Peach", "Captain Falcon",
                       "Yoshi", "Fox", "Ness", "Ice Climbers", "Kirby", "Samus", "Link",
                       "Pikachu", "Zelda", "Luigi", "Jigglypuff", "Mewtwo", "Mr. Game & Watch",
                       "Marth", "Roy", "Pichu", "Ganondorf", "Dr. Mario", "Young Link", "Falco"}

    for _, char in ipairs(characters) do
        if has(char) then
            count = count + 1
        end
    end
    return count >= 10
end

function GroupUniqueCharacters16()
    local count = 0
    local characters = {"Mario", "Donkey Kong", "Bowser", "Peach", "Captain Falcon",
                       "Yoshi", "Fox", "Ness", "Ice Climbers", "Kirby", "Samus", "Link",
                       "Pikachu", "Zelda", "Luigi", "Jigglypuff", "Mewtwo", "Mr. Game & Watch",
                       "Marth", "Roy", "Pichu", "Ganondorf", "Dr. Mario", "Young Link", "Falco"}

    for _, char in ipairs(characters) do
        if has(char) then
            count = count + 1
        end
    end
    return count >= 16
end

function GroupUniqueCharacters25()
    local count = 0
    local characters = {"Mario", "Donkey Kong", "Bowser", "Peach", "Captain Falcon",
                       "Yoshi", "Fox", "Ness", "Ice Climbers", "Kirby", "Samus", "Link",
                       "Pikachu", "Zelda", "Luigi", "Jigglypuff", "Mewtwo", "Mr. Game & Watch",
                       "Marth", "Roy", "Pichu", "Ganondorf", "Dr. Mario", "Young Link", "Falco"}

    for _, char in ipairs(characters) do
        if has(char) then
            count = count + 1
        end
    end
    return count >= 25
end

-- =====================================
-- STAGE ACCESS
-- =====================================

local function has_regular_stages()
    return has("Mushroom Kingdom II") and has("Poké Floats") and has("Big Blue") and
           has("Flat Zone") and has("Fourside") and has("Brinstar Depths")
end

function GroupUniqueStages11()
    local count = 0
    local stages = {"Brinstar Depths", "Fourside", "Big Blue", "Poké Floats",
                   "Mushroom Kingdom II", "Dream Land (Past)", "Kongo Jungle (Past)",
                   "Yoshi's Island (Past)", "Battlefield", "Final Destination", "Flat Zone"}

    for _, stage in ipairs(stages) do
        if has(stage) then
            count = count + 1
        end
    end
    return count >= 11
end

-- =====================================
-- SPECIAL CHARACTER ABILITIES
-- =====================================

-- Characters that can meteor smash
local function has_meteor_character()
    local meteor_chars = {"Captain Falcon", "Donkey Kong", "Falco", "Fox", "Ganondorf",
                          "Ice Climbers", "Kirby", "Link", "Luigi", "Young Link",
                          "Mario", "Marth", "Mewtwo", "Mr. Game & Watch", "Ness",
                          "Peach", "Roy", "Samus", "Yoshi", "Zelda"}

    for _, char in ipairs(meteor_chars) do
        if has(char) then
            return true
        end
    end
    return false
end

-- Characters that can reflect projectiles
local function has_reflect_character()
    local reflect_chars = {"Mario", "Dr. Mario", "Fox", "Falco", "Ness"}

    for _, char in ipairs(reflect_chars) do
        if has(char) then
            return true
        end
    end
    return false
end

-- Good home run contest characters (can get over 1,400 ft)
local function has_good_hr_character()
    local good_hr_chars = {"Ganondorf", "Yoshi", "Jigglypuff", "Roy"}

    for _, char in ipairs(good_hr_chars) do
        if has(char) then
            return true
        end
    end
    return false
end

-- Decent home run contest characters (can get over 1,312 ft)
local function has_decent_hr_character()
    return has("Dr. Mario") or has_good_hr_character()
end

-- Good combo characters
local function has_good_combo_character()
    local good_combo_chars = {"Kirby", "Fox", "Pichu", "Pikachu", "Zelda"}

    for _, char in ipairs(good_combo_chars) do
        if has(char) then
            return true
        end
    end
    return false
end

-- Decent combo characters
local function has_decent_combo_character()
    return has("Yoshi") or has("Falco") or has_good_combo_character()
end

-- =====================================
-- TROPHY REQUIREMENTS
-- =====================================

local function has_birdo_trophy()
    return has("Birdo (Trophy)")
end

local function has_kraid_trophy()
    return has("Kraid (Trophy)")
end

local function has_falcon_flyer_trophy()
    return has("Falcon Flyer (Trophy)")
end

local function has_ufo_trophy()
    return has("UFO (Trophy)")
end

local function has_sudowoodo_trophy()
    return has("Sudowoodo (Trophy)")
end

-- =====================================
-- LOTTERY POOL ACCESS
-- =====================================

local function has_base_lottery()
    return has("Progressive Lottery Pool")
end

local function has_adventure_classic_lottery()
    return has("Lottery Pool Upgrade (Adventure/Classic Clear)")
end

local function has_secret_character_lottery()
    return has("Lottery Pool Upgrade (Secret Characters)")
end

local function has_vs_matches_lottery()
    return has("Lottery Pool Upgrade (200 Vs. Matches)")
end

local function has_250_trophy_lottery()
    return has("Lottery Pool Upgrade (250 Trophies)")
end

-- =====================================
-- SPECIAL ITEMS
-- =====================================

local function has_pikmin_savefile()
    return has("Pikmin Savefile")
end

-- =====================================
-- UNLOCK CONDITIONS
-- =====================================

-- Character unlock conditions based on the rules
local function can_unlock_jigglypuff()
    return true -- Any 1P mode
end

local function can_unlock_dr_mario()
    return has_mario()
end

local function can_unlock_pichu()
    return true -- Event matches
end

local function can_unlock_falco()
    return has_multi_man_melee()
end

local function can_unlock_marth()
    return has_all_base_characters()
end

local function can_unlock_young_link()
    return GroupUniqueCharacters10()
end

local function can_unlock_ganondorf()
    return has_link()
end

local function can_unlock_mewtwo()
    return true -- VS matches or time
end

local function can_unlock_luigi()
    return has_adventure_mode()
end

local function can_unlock_roy()
    return has_marth()
end

local function can_unlock_mr_game_and_watch()
    return has_everyone_except_gamewatch() and (has_adventure_mode() or has_all_star_mode() or has_classic_mode() or has_target_test())
end

-- =====================================
-- MODE-SPECIFIC REQUIREMENTS
-- =====================================

-- Training mode combo requirements
local function can_do_125_combos()
    return has_good_combo_character() and has_bowser()
end

local function can_do_10_hit_combo()
    return has_decent_combo_character() and has_bowser()
end

local function can_do_20_hit_combo()
    return has_good_combo_character() and has_bowser()
end

-- Home Run Contest requirements
local function can_do_combined_distance()
    return GroupUniqueCharacters16()
end

local function can_do_1312_feet()
    return has_decent_hr_character()
end

local function can_do_1476_feet()
    return has_good_hr_character()
end

-- All-Star mode specific requirements
local function can_access_all_star()
    return has_all_star_mode()
end

-- Classic mode specific requirements
local function can_do_gamewatch_classic()
    return has_mr_game_and_watch() and has_classic_mode()
end

-- =====================================
-- BONUS REQUIREMENTS
-- =====================================

-- Meteor-related bonuses
local function can_get_meteor_bonus()
    return has_meteor_character()
end

-- Reflection bonuses
local function can_get_bank_shot_ko()
    return has_reflect_character()
end

-- Luigi-specific bonuses
local function can_get_poser_bonus()
    return has_luigi()
end

local function can_get_metal_bros_ko()
    return has_luigi()
end

-- Multi-KO bonuses (Adventure/All-Star have more enemies)
local function can_get_quadruple_ko()
    return has_adventure_mode() or has_all_star_mode()
end

local function can_get_quintuple_ko()
    return has_adventure_mode() or has_all_star_mode()
end

-- All bonuses requirement (for Diskun trophy)
local function can_get_all_bonuses()
    return has_adventure_mode() and has_all_star_mode() and has_classic_mode() and
           has_luigi() and has_meteor_character() and has_reflect_character()
end

-- =====================================
-- TARGET TEST REQUIREMENTS
-- =====================================

-- Individual character target tests
local function can_do_target_test(character)
    return has(character) and has_target_test()
end

-- Target test challenges requiring all characters
local function can_do_all_targets()
    return GroupUniqueCharacters25() and has_target_test()
end

-- =====================================
-- EVENT MATCH REQUIREMENTS
-- =====================================

-- Event matches with specific character requirements
function CanDoTroubleKing()
    return has_mario()
end

function CanDoLordOfJungle()
    return has_donkey_kong()
end

function CanDoSpareChange()
    return has_ness()
end

function CanDoYoshisEgg()
    return has_yoshi()
end

function CanDoKirbysAirRaid()
    return has_kirby()
end

function CanDoBountyHunters()
    return has_samus()
end

function CanDoLinksAdventure()
    return has_link()
end

function CanDoPeachsPeril()
    return has_mario()
end

function CanDoGargantuans()
    return has_bowser()
end

function CanDoColdArmor()
    return has_samus()
end

function CanDoTriforceGathering()
    return has_link()
end

function CanDoTargetAcquired()
    return has_falco()
end

function CanDoLethalMarathon()
    return has_captain_falcon()
end

function CanDoSevenYears()
    return has_young_link()
end

function CanDoTimeForCheckup()
    return has_luigi()
end

function CanDoSpaceTravelers()
    return has_ness()
end

function CanDoJigglypuffLive()
    return has_jigglypuff()
end

function CanDoEnGarde()
    return has_marth()
end

function CanDoTroubleKing2()
    return has_luigi()
end

function CanDoBirdsOfPrey()
    return has_fox()
end

function CanDoGameWatchForever()
    return has_mr_game_and_watch()
end

-- =====================================
-- TROPHY UNLOCK CONDITIONS
-- =====================================

-- Character trophy unlocks require having the character AND the mode
local function can_get_adventure_trophy(character)
    return has(character) and has_adventure_mode()
end

local function can_get_classic_trophy(character)
    return has(character) and has_classic_mode()
end

local function can_get_allstar_trophy(character)
    return has(character) and has_all_star_mode()
end

-- Special trophy requirements
local function has_required_special_trophies()
    return has_birdo_trophy() and has_kraid_trophy() and has_falcon_flyer_trophy() and
           has_ufo_trophy() and has_sudowoodo_trophy()
end

-- =====================================
-- MILESTONE REQUIREMENTS
-- =====================================

-- Character unlock milestones
local function has_first_secret_wave()
    return has_luigi() and has_jigglypuff() and has_mewtwo() and has_mr_game_and_watch() and has_marth()
end

local function has_second_secret_wave()
    return has_roy() and has_pichu() and has_ganondorf() and has_dr_mario() and has_young_link() and has_falco()
end

-- Stage unlock milestone
local function has_all_regular_stages()
    return has_regular_stages()
end

-- =====================================
-- GOAL CONDITIONS
-- =====================================

-- Goal: All Events Clear
local function can_complete_all_events()
    local event_chars = {"Mario", "Donkey Kong", "Ness", "Yoshi", "Kirby", "Samus",
                         "Link", "Bowser", "Falco", "Captain Falcon", "Young Link",
                         "Luigi", "Jigglypuff", "Marth", "Fox", "Mr. Game & Watch"}

    for _, char in ipairs(event_chars) do
        if not has(char) then
            return false
        end
    end
    return true
end

-- Goal: All Targets Clear
local function can_complete_all_targets()
    return GroupUniqueCharacters25()
end

-- =====================================
-- UTILITY FUNCTIONS
-- =====================================

-- Check if player has access to lottery system
local function has_lottery_access()
    return has_base_lottery()
end

-- Check if player can access special Pikmin content
local function can_access_pikmin_content()
    return has_pikmin_savefile()
end

-- Check if player has enough characters for various challenges
local function has_sufficient_roster_for_challenges()
    return GroupUniqueCharacters16()
end