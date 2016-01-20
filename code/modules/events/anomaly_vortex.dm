/datum/round_event_control/anomaly/anomaly_vortex
	name = "Anomaly: Vortex"
	typepath = /datum/round_event/anomaly/anomaly_vortex
	max_occurrences = 1
	weight = 2

/datum/round_event/anomaly/anomaly_vortex
	startWhen = 10
	announceWhen = 3
	endWhen = 70


/datum/round_event/anomaly/anomaly_vortex/announce()
	priority_announce("������� �������� ������� �������� ���������� �������� �������� ������� �������������. ��������� ����� �����������: [impact_area.name]", "�������! ��������!")

/datum/round_event/anomaly/anomaly_vortex/start()
	var/turf/T = safepick(get_area_turfs(impact_area))
	if(T)
		newAnomaly = new /obj/effect/anomaly/bhole(T)
