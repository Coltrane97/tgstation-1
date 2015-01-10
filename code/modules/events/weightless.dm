/datum/round_event_control/weightless
	name = "Gravity Systems Failure"
	typepath = /datum/round_event/weightless
	weight = 15

/datum/round_event/weightless
	startWhen = 5
	endWhen = 65
	announceWhen	= 1

/datum/round_event/weightless/setup()
	startWhen = rand(0,10)
	endWhen = rand(40,80)

/datum/round_event/weightless/announce()
	priority_announce("��������: ��������� � ������ ������� ������������� ����������. ����������, ������ �����, ���� ��� �������� ����������, ��� ����� �������� � ������������ �������������� ��������. ���������� ������ ��������� ���, ��� ���������������� ������������ �������� �� ���������� �������� ���������� ������ ��������� ����������� �������� � ������������ [rand(99,9999)][pick("a","b","c")]:subclause[rand(1,20)][pick("a","b","c")].")

/datum/round_event/weightless/start()
	for(var/area/A in world)
		A.gravitychange(0)

	if(control)
		control.weight *= 2

/datum/round_event/weightless/end()
	for(var/area/A in world)
		A.gravitychange(1)

	if(announceWhen >= 0)
		priority_announce("������������� ���������� ������ ������������� � ����������� �����������. ����������, ������������ ������ ������������ ��� ����� ��������� � ����� ����������� �� ���������� ������.")


