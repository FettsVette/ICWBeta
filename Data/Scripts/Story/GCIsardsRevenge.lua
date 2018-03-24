--******************************************************************************
--     _______ __
--    |_     _|  |--.----.---.-.--.--.--.-----.-----.
--      |   | |     |   _|  _  |  |  |  |     |__ --|
--      |___| |__|__|__| |___._|________|__|__|_____|
--     ______
--    |   __ \.-----.--.--.-----.-----.-----.-----.
--    |      <|  -__|  |  |  -__|     |  _  |  -__|
--    |___|__||_____|\___/|_____|__|__|___  |_____|
--                                    |_____|
--*   @Author:              Corey
--*   @Date:                2017-11-24T12:43:51+01:00
--*   @Project:             Imperial Civil War
--*   @Filename:            GCShadowHandCampaign.lua
--*   @Last modified by:
--*   @Last modified time:  2018-02-03T12:22:17-05:00
--*   @License:             This source code may only be used with explicit permission from the developers
--*   @Copyright:           © TR: Imperial Civil War Development Team
--******************************************************************************



require("PGBase")
require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")
require("ChangeOwnerUtilities")

function Definitions()

  DebugMessage("%s -- In Definitions", tostring(Script))

  StoryModeEvents =
    {
      Determine_Faction_LUA = Find_Faction,
	  Requiem_Appears = Requiem_Spawn,
	  NR_Builds_Lusankya = NR_Lusankya,
	  Isard_Takes_Lusankya = CH_Lusankya
    }

end

function Find_Faction(message)
  if message == OnEnter then

    local p_newrep = Find_Player("Rebel")
    local p_empire = Find_Player("Empire")
   

    if p_newrep.Is_Human() then
      Story_Event("ENABLE_BRANCH_NEWREP_FLAG")
    elseif p_empire.Is_Human() then
      Story_Event("ENABLE_BRANCH_EMPIRE_FLAG")
    end
  end
end

function Requiem_Spawn(message)
  if message == OnEnter then

    local p_rebel = Find_Player("Rebel")
    local start_planet = FindPlanet("Ciutric")

    if start_planet.Get_Owner() ~= Find_Player("Rebel") then
      local allPlanets = FindPlanet.Get_All_Planets()
      local random = GameRandom(1, table.getn(allPlanets))
      local start_planet = allPlanets[random]
      while start_planet.Get_Owner() ~= Find_Player("Rebel") do
        local random = GameRandom(1, table.getn(allPlanets))
        local start_planet = allPlanets[random]
      end
    end

    local spawn_list_requiem = { "Requiem_Squadron_Space" }
    local RequiemSpawn = SpawnList(spawn_list_requiem, start_planet, p_rebel,false,false)

  end
end

function NR_Lusankya(message)
  if message == OnEnter then

    local p_rebel = Find_Player("Rebel")
    local start_planet = FindPlanet("Bilbringi")

    if start_planet.Get_Owner() ~= Find_Player("Rebel") then
      local allPlanets = FindPlanet.Get_All_Planets()
      local random = GameRandom(1, table.getn(allPlanets))
      local start_planet = allPlanets[random]
      while start_planet.Get_Owner() ~= Find_Player("Rebel") do
        local random = GameRandom(1, table.getn(allPlanets))
        local start_planet = allPlanets[random]
      end
    end

    local spawn_list_lusankya = { "Wedge_Lusankya" }
    local LusankyaSpawn = SpawnList(spawn_list_lusankya, start_planet, p_rebel,false,false)

  end
end

function CH_Lusankya(message)
  if message == OnEnter then

    local p_empire = Find_Player("Empire")
    local start_planet = FindPlanet("Bilbringi")

    if start_planet.Get_Owner() ~= Find_Player("Empire") then
      local allPlanets = FindPlanet.Get_All_Planets()
      local random = GameRandom(1, table.getn(allPlanets))
      local start_planet = allPlanets[random]
      while start_planet.Get_Owner() ~= Find_Player("Empire") do
        local random = GameRandom(1, table.getn(allPlanets))
        local start_planet = allPlanets[random]
      end
    end

    local spawn_list_lusankya = { "Lusankya", "TIE_Defender_Squadron_Buildable", "TIE_Defender_Squadron_Buildable" }
    local LusankyaSpawn = SpawnList(spawn_list_lusankya, start_planet, p_empire,false,false)

  end
end