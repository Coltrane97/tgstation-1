/datum/round_event_control/meteor_wave/meaty
	name = "Meaty Ore Wave"
	typepath = /datum/round_event/meteor_wave/meaty
	weight = 0
	max_occurrences = 0

/datum/round_event/meteor_wave/meaty/announce()
	priority_announce("������ ����� ���������� ����� �� ����� �������.", "�� ����, ������ �����.",'sound/AI/meteors.ogg')

/datum/round_event/meteor_wave/meaty/tick()
	if(IsMultiple(activeFor, 3))
		spawn_meteors(5, meteorsB) //meteor list types defined in gamemode/meteor/meteors.dm