-- Super Smash Bros. Melee PopTracker Logic
-- Base ability checks

local function has(item)
    return Tracker:ProviderCountForCode(item) > 0
end

local function hasCount(item, amount)
    local object = Tracker:FindObjectForCode(item)
    if object == nil then
        return false
    end

    if object.Type == "consumable" then
        return object.AcquiredCount >= amount
    else
        return object.CurrentStage >= amount
    end
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

function HasClassicMode()
    return has("Classic Mode")
end

function HasAdventureMode()
    return has("Adventure Mode")
end

function HasAllStarMode()
    return has("All-Star Mode")
end

function HasAnyMain1P()
    return HasClassicMode() or HasAdventureMode() or HasAllStarMode()
end

function HasTargetTest()
    return has("Target Test")
end

function HasHomeRunContest()
    return has("Home-Run Contest")
end

function HasMultiManMelee()
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
local function hasAllBaseCharacters()
    return has_mario() and has_donkey_kong() and has_bowser() and has_peach() and
           has_captain_falcon() and has_yoshi() and has_fox() and has_ness() and
           has_ice_climbers() and has_kirby() and has_samus() and has_link() and
           has_pikachu() and has_zelda()
end

-- All secret characters
function HasAllSecretCharacters()
    return has_luigi() and has_jigglypuff() and has_mewtwo() and has_mr_game_and_watch() and
           has_marth() and has_roy() and has_pichu() and has_ganondorf() and
           has_dr_mario() and has_young_link() and has_falco()
end

-- Everyone except Game & Watch (needed for Mr. Game & Watch unlock)
local function hasEveryoneExceptGameWatch()
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

function HasAllRegularStages()
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
local function hasMeteorCharacter()
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
local function hasReflectCharacter()
    local reflect_chars = {"Mario", "Dr. Mario", "Fox", "Falco", "Ness"}

    for _, char in ipairs(reflect_chars) do
        if has(char) then
            return true
        end
    end
    return false
end

-- Good home run contest characters (can get over 1,400 ft)
local function hasGoodHrCharacter()
    local good_hr_chars = {"Ganondorf", "Yoshi", "Jigglypuff", "Roy"}

    for _, char in ipairs(good_hr_chars) do
        if has(char) then
            return true
        end
    end
    return false
end

-- Decent home run contest characters (can get over 1,312 ft)
local function hasDecentHrCharacter()
    return has("Dr. Mario") or hasGoodHrCharacter()
end

-- Good combo characters
local goodComboChars = {"Kirby", "Fox", "Pichu", "Pikachu", "Zelda"}
local function hasGoodComboCharacter()
    for _, char in ipairs(goodComboChars) do
        if has(char) then
            return true
        end
    end
    return false
end

local function hasAllGoodComboCharacter()
    local hasGood = true
    for _, char in ipairs(goodComboChars) do
        if not has(char) then
            hasGood = false
        end
    end
    return hasGood
end

-- Decent combo characters
local function hasDecentComboCharacter()
    return has("Yoshi") or has("Falco")
end

-- =====================================
-- TROPHY REQUIREMENTS
-- =====================================

function HasAllClassicTrophies()
    return hasCount("classic_trophies", 26)
end

function HasAllAdventureTrophies()
    return hasCount("adventure_trophies", 26)
end

function HasAllAllStarTrophies()
    return hasCount("allstar_trophies", 26)
end

function HasBirdoTrophy()
    return has("Birdo (Trophy)")
end

function HasKraidTrophy()
    return has("Kraid (Trophy)")
end

function HasFalconFlyerTrophy()
    return has("Falcon Flyer (Trophy)")
end

function HasUfoTrophy()
    return has("UFO (Trophy)")
end

function HasSudowoodoTrophy()
    return has("Sudowoodo (Trophy)")
end

-- =====================================
-- LOTTERY POOL ACCESS
-- =====================================

function HasBaseLottery()
    return true
end

function HasAdventureClassicLottery()
    if has("lottery_pool_mode_vanilla") then
        return HasClassicMode() and HasAdventureMode()
    else
        return hasCount("Lottery", 1) or has("Lottery Adventure+Classic")
    end
end

function HasVsMatchesLottery()
    if has("lottery_pool_mode_vanilla") then
        return true
    else
        return hasCount("Lottery", 2) or has("Lottery200VS")
    end
end

function HasSecretCharacterLottery()
    if has("lottery_pool_mode_vanilla") then
        return HasAllSecretCharacters()
    else
        return hasCount("Lottery", 3) or has("LotterySecret")
    end
end

function IsVisible250TrophyLottery()
    if has("lottery_pool_mode_vanilla") then
        return has("use_250_trophy_pool")
    else
        return true
    end
end

function Has250TrophyLottery()
    if has("lottery_pool_mode_vanilla") then
        return hasCount("total_trophies", 250)
    else
        return hasCount("Lottery", 4) or has("Lottery250")
    end
end

-- =====================================
-- SPECIAL ITEMS
-- =====================================

function HasPikminSavefile()
    return has("Pikmin Savefile")
end

-- =====================================
-- UNLOCK CONDITIONS
-- =====================================

-- Character unlock conditions based on the rules
function CanUnlockJigglypuff()
    return HasAnyMain1P() -- Any 1P mode
end

function CanUnlockDrMario()
    return HasAnyMain1P() and has_mario()
end

function CanUnlockPichu()
    return Events31To39Available() -- Event 37: Legendary Pokémon
end

function CanUnlockFalco()
    return HasMultiManMelee()
end

function CanUnlockMarth()
    return hasAllBaseCharacters()
end

function CanUnlockYoungLink()
    return HasAnyMain1P() and GroupUniqueCharacters10()
end

function CanUnlockGanondorf()
    return Events26To29Available() and CanDoTriforceGathering()
end

function CanUnlockMewtwo()
    return true -- VS matches or time
end

function CanUnlockLuigi()
    return HasAdventureMode()
end

function CanUnlockRoy()
    return HasAnyMain1P() and has_marth()
end

function CanUnlockMrGameWatch()
    return hasEveryoneExceptGameWatch() and (HasAnyMain1P() or HasTargetTest())
end

-- =====================================
-- MODE-SPECIFIC REQUIREMENTS
-- =====================================

-- Training mode combo requirements
function TrainingModeOptional()
    return has_bowser()
end

function CanDo125Combos()
    return hasAllGoodComboCharacter()
end

function CanDo10HitCombo()
    return hasDecentComboCharacter()
end

function CanDo20HitCombo()
    return hasGoodComboCharacter()
end

-- Home Run Contest requirements
function CanDoCombinedDistance()
    return GroupUniqueCharacters16()
end

function CanDo1312Feet()
    return hasDecentHrCharacter()
end

function CanDo1476Feet()
    return hasGoodHrCharacter()
end

-- Classic mode specific requirements
function CanDoGameWatchClassic()
    return has_mr_game_and_watch() and HasClassicMode()
end

-- =====================================
-- BONUS REQUIREMENTS
-- =====================================

-- Meteor-related bonuses
function CanGetMeteorBonus()
    return hasMeteorCharacter()
end

-- Reflection bonuses
function CanGetBankShotKo()
    return hasReflectCharacter()
end

-- Luigi-specific bonuses
function CanGetPoserBonus()
    return has_luigi()
end

function CanGetMetalBrosKo()
    return has_luigi()
end

-- Multi-KO bonuses (Adventure/All-Star have more enemies)
function CanGetQuadrupleKo()
    return HasAdventureMode() or HasAllStarMode()
end

function CanGetQuintupleKo()
    return HasAdventureMode() or HasAllStarMode()
end

-- All bonuses requirement (for Diskun trophy)
function CanGetAllBonuses()
    return HasAdventureMode() and HasAllStarMode() and HasClassicMode() and
           has_luigi() and hasMeteorCharacter() and hasReflectCharacter()
end

-- =====================================
-- TARGET TEST REQUIREMENTS
-- =====================================

-- Individual character target tests
function CanDoTargetTest(character)
    return has(character) and HasTargetTest()
end

-- Target test challenges requiring all characters
function CanDoAllTargets()
    return GroupUniqueCharacters25() and HasTargetTest()
end

-- Individual character multi-man melee
function CanDoMultiManMelee(character)
    return has(character) and HasMultiManMelee()
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
function CanGetClassicTrophy(character)
    return has(character) and HasClassicMode()
end

function CanGetAdventureTrophy(character)
    return has(character) and HasAdventureMode()
end

function CanGetAllStarTrophy(character)
    return has(character) and HasAllStarMode()
end

-- =====================================
-- MILESTONE REQUIREMENTS
-- =====================================

-- Character unlock milestones
function HasFirstSecretWave()
    return has_luigi() and has_jigglypuff() and has_mewtwo() and has_mr_game_and_watch() and has_marth()
end

function HasSecondSecretWave()
    return has_roy() and has_pichu() and has_ganondorf() and has_dr_mario() and has_young_link() and has_falco()
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
    return HasBaseLottery()
end

-- Check if player has enough characters for various challenges
local function has_sufficient_roster_for_challenges()
    return GroupUniqueCharacters16()
end