require("trlib-std/class")
require("PGStoryMode")
StoryUtil = require("trlib-util/StoryUtil")


---@class MissionRepConquerPlanet
MissionRepConquerPlanet = class()

function MissionRepConquerPlanet:new(player_agnostic_plot)

end

function MissionRepConquerPlanet:begin()

	if ConquerObserverThread then

	else

		dialog = "MISSION_DIALOG_REP_CONQUER_PLANET"
		
		plot = Get_Story_Plot("Conquests\\MissionFiles\\Intervention_Conquer_Planet_Rep.xml")

		target = StoryUtil.FindFriendlyPlanet(Find_Player("Rebel"))
		
		reward_unit = Find_Object_Type("Generic_Acclamator_Assault_Ship_I")
		reward_count = 4
		
		event = plot.Get_Event("Conquer_Planet_00")
		event.Set_Dialog(dialog)
		event.Clear_Dialog_Text()
		event.Add_Dialog_Text("TEXT_INTERVENTION_OBJECTIVE_CONQUER_TARGET", target)
		event.Add_Dialog_Text("TEXT_INTERVENTION_REWARD", reward_unit, reward_count)
		
		
		event = plot.Get_Event("Conquer_Planet_01")
		event.Set_Event_Parameter(0, target)

		plot.Activate()

		ConquerObserverThread = Create_Thread("Conquer_Observer_Rep")
	end

end

function Conquer_Observer_Rep()

	while not Check_Story_Flag(Find_Player("Empire"), "CONQUER_PLANETS_NOTIFICATION_00", nil, true) do
		Sleep(1)
	end	

	plot = Get_Story_Plot("Conquests\\MissionFiles\\Intervention_Conquer_Planet_Rep.xml")

	reward_location = StoryUtil.FindFriendlyPlanet(Find_Player("Empire"))

	event = plot.Get_Event("Conquer_Planet_04")
	event.Set_Event_Parameter(0, target)
	event.Set_Reward_Parameter(0, reward_unit)
	event.Set_Reward_Parameter(1, reward_location)
	event.Set_Reward_Parameter(2, reward_count)
	event.Set_Dialog(dialog)
	event.Clear_Dialog_Text()
	event.Add_Dialog_Text("TEXT_INTERVENTION_REWARD", reward_unit, reward_count) 

	republic = Find_Player("Empire")

	republic = Find_Player("Empire")
	spawn_list_reward = { "Generic_Acclamator_Assault_Ship_I" , "Generic_Acclamator_Assault_Ship_I", "Generic_Acclamator_Assault_Ship_I", "Generic_Acclamator_Assault_Ship_I" }
	SpawnList(spawn_list_reward, reward_location, republic, true, false)

	currentSupport = GlobalValue.Get("RepublicApprovalRating")
	GlobalValue.Set("RepublicApprovalRating", currentSupport + 2)

	plot.Suspend()

	plot.Reset()

	if ConquerObserverThread then
		Thread.Kill(ConquerObserverThread)
		ConquerObserverThread = nil
	end

end

return MissionRepConquerPlanet
