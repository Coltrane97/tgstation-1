#define MAX_WARNS 3
#define AUTOBANTIME 20

/client/proc/warn(warned_ckey)
	if(!check_rights(R_ADMIN))
		return
	if(!warned_ckey || !istext(warned_ckey))
		return
	if(warned_ckey in GLOB.admin_datums)
		usr << "<font color='red'>Error: warn(): You can't warn admins.</font>"
		return

	var/datum/preferences/D
	var/client/C = GLOB.directory[warned_ckey]
	if(C)
		D = C.prefs
	else
		D = GLOB.preferences_datums[warned_ckey]

	if(!D)
		src << "<font color='red'>Error: warn(): No such ckey found.</font>"
		return

	if(++D.warns >= MAX_WARNS)					//uh ohhhh...you'reee iiiiin trouuuubble O:)
		ban_unban_log_save("[ckey] warned [warned_ckey], resulting in a [AUTOBANTIME] minute autoban.")
		if(C)
			message_admins("[key_name_admin(src)] has warned [key_name_admin(C)] resulting in a [AUTOBANTIME] minute ban.")
			C << "<font color='red'><BIG><B>�� �������� ������� ��-�� �������������&#255; �������������� [ckey].</B></BIG><br>��� ��������� ���, �� �������� ����� [AUTOBANTIME] �����."
			del(C)
		else
			message_admins("[key_name_admin(src)] has warned [warned_ckey] resulting in a [AUTOBANTIME] minute ban.")
		AddBan(warned_ckey, D.last_id, "������� � ���������� ������������� ��������������", ckey, 1, AUTOBANTIME)
	else
		var/count = MAX_WARNS - D.warns
		if(C)
			C << "<font color='red'><BIG>��� ������ ��������������</BIG><br>���������� �������������&#255; ����� �������� � ��������</font>"
			message_admins("[key_name_admin(src)] has warned [key_name_admin(C)]. They have [count] strikes remaining.")
		else
			message_admins("[key_name_admin(src)] has warned [warned_ckey] (DC). They have [count] strikes remaining.")


#undef MAX_WARNS
#undef AUTOBANTIME