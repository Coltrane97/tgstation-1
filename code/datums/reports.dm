/datum/report
	var/info
	var/time
	var/title

/proc/send_report(datum/report/R, mob/Sender)
	if(!R)
		return
	if(!istype(R))
		return

	var/msg
	for(var/client/X in GLOB.admins)
		if(X.prefs.toggles & SOUND_ADMINHELP)
			X << 'sound/effects/adminhelp.ogg'
	msg = "<span class='adminnotice'><b><font color=orange>STATION REPORT:</font>[key_name_admin(Sender)] (<A HREF='?_src_=holder;adminmoreinfo=\ref[Sender]'>?</A>) (<A HREF='?_src_=holder;adminplayeropts=\ref[Sender]'>PP</A>) (<A HREF='?_src_=vars;Vars=\ref[Sender]'>VV</A>) (<A HREF='?_src_=holder;subtlemessage=\ref[Sender]'>SM</A>) (<A HREF='?_src_=holder;adminplayerobservefollow=\ref[Sender]'>FLW</A>) (<A HREF='?_src_=holder;traitor=\ref[Sender]'>TP</A>) (<A HREF='?_src_=holder;BlueSpaceArtillery=\ref[Sender]'>BSA</A>) (<A HREF='?_src_=holder;CentcomReply=\ref[Sender]'>RPLY</A>):</b> �����: <A HREF='?_src_=holder;show_report=\ref[R]'>[R.title]</A></span>"
	to_chat(GLOB.admins, msg)
	for(var/obj/machinery/computer/communications/C in GLOB.machines)
		C.overrideCooldown()

/client/proc/show_reports()
	set category = "Admin"
	set name = "Show reports"

	if(!holder)
		to_chat(src, "<font color='red'>Error: Freeze: Only administrators may use this command.</font>")
		return

	var/dat = "<b>������ �� ������� �� ������� �����</b><BR>"

	for(var/i in SSticker.reports)
		var/datum/report/R = i
		var/temp_time = time2text(R.time - GLOB.timezoneOffset + 432000, "hh:mm:ss")
		dat += "[temp_time] - <A HREF='?_src_=holder;show_report=\ref[R]'>[R.title]</A><BR>"

	usr << browse(dat, "window=show_reports")

/client/proc/show_report(datum/report/R)
	if(!holder)
		return
	if(!R)
		return
	if(!istype(R))
		return

	var/datum/asset/assets = get_asset_datum(/datum/asset/simple/paper)
	assets.send(usr)

	var/dat = R.info
	usr << browse(dat, "window=show_report")
	onclose(usr, "[R.title]")
