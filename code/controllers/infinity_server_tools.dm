/proc/changemap_alt(var/datum/votablemap/VM)
	if (!istype(VM))
		return
	if (ticker.update_waiting)
		return

	log_game("Changing map to [VM.name]([VM.friendlyname])")
	. = shell("sh map_rotate.sh [VM.name]")
	switch (.)
		if (null)
			message_admins("Failed to change map: Could not run map rotator")
			log_game("Failed to change map: Could not run map rotator")
		if (0)
			log_game("Changed to map [VM.friendlyname]")
			nextmap = VM

		//1x: file errors
		if (1)
			message_admins("Compile failed")
			log_game("Compile failed")

/client/proc/update_server()
	set category = "Server"
	set name = "Update Server"
	if (!usr.client.holder)
		return
	var/confirm = alert("End the round and update server?", "End Round", "Yes", "Cancel")
	if(confirm == "Cancel")
		return
	if(confirm == "Yes")
		message_admins("[key_name_admin(usr)] ��������(�) ���������� �������.")
		log_game("[key_name_admin(usr)] ��������(�) ���������� �������.")
		ticker.force_ending = 1
		sleep(20)
		force_update_server()

/client/proc/update_server_round_end()
	set category = "Server"
	set name = "Update Server at Round End"
	if (!usr.client.holder)
		return
	var/confirm = alert("������������ ���������� � ����� ������?", "End Round", "Yes", "Cancel")
	if(confirm == "Cancel")
		return
	if(confirm == "Yes")
		message_admins("[key_name_admin(usr)] �����������(�) ���������� ������� � ����� �������� ������.")
		log_game("[key_name_admin(usr)] �����������(�) ���������� ������� � ����� �������� ������.")
		world << "<span class='adminooc'>������������� [usr.key] �����������(�) ���������� ������� � ����� �������� ������.</span>"
		ticker.updater_ckey = usr.key
		ticker.update_waiting = 1

/proc/force_update_server()
	if(ticker.current_state != GAME_STATE_FINISHED)
		return 0
	world << "<span class='adminooc'><FONT size=5>��������! ������ ����������� ����� 10 ������! ������ �� ����� �������� ��������� �����!</FONT><br>���������� � ����� ������ ������������ ��������������� [ticker.updater_ckey]</span>."
	var/sound/update_sound = sound('sound/effects/alarm.ogg', repeat = 0, wait = 0, channel = 0, vol = 100)
	update_sound.priority = 250
	update_sound.status = SOUND_UPDATE|SOUND_STREAM
	for(var/mob/M in player_list)
		M << update_sound
	sleep(100)
	shell("sh update.sh")