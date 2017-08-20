/obj/machinery/computer/holo/station_alert
	name = "Station Alert Console"
	desc = "Used to access the station's automated alert system."
	icon_screen = "screen_generic"
	icon_screen_contents = "alerts"
	circuit = /obj/item/circuitboard/computer/stationalert
	light_color = LIGHT_COLOR_CYAN

	var/alarms = list("Fire" = list(), "Atmosphere" = list(), "Power" = list())

	light_color = LIGHT_COLOR_CYAN

/obj/machinery/computer/holo/station_alert/ui_interact(mob/user, ui_key = "main", datum/tgui/ui = null, force_open = 0, \
									datum/tgui/master_ui = null, datum/ui_state/state = GLOB.default_state)
	ui = SStgui.try_update_ui(user, src, ui_key, ui, force_open)
	if(!ui)
		ui = new(user, src, ui_key, "station_alert", name, 300, 500, master_ui, state)
		ui.open()

/obj/machinery/computer/holo/station_alert/ui_data(mob/user)
	var/list/data = list()

	data["alarms"] = list()
	for(var/class in alarms)
		data["alarms"][class] = list()
		for(var/area in alarms[class])
			data["alarms"][class] += area

	return data

/obj/machinery/computer/holo/station_alert/proc/triggerAlarm(class, area/A, O, obj/source)
	if(source.z != z)
		return
	if(stat & (BROKEN))
		return

	var/list/L = alarms[class]
	for(var/I in L)
		if (I == A.name)
			var/list/alarm = L[I]
			var/list/sources = alarm[3]
			if (!(source in sources))
				sources += source
			return 1
	var/obj/machinery/camera/C = null
	var/list/CL = null
	if(O && istype(O, /list))
		CL = O
		if (CL.len == 1)
			C = CL[1]
	else if(O && istype(O, /obj/machinery/camera))
		C = O
	L[A.name] = list(A, (C ? C : O), list(source))
	return 1


/obj/machinery/computer/holo/station_alert/proc/cancelAlarm(class, area/A, obj/origin)
	if(stat & (BROKEN))
		return
	var/list/L = alarms[class]
	var/cleared = 0
	for (var/I in L)
		if (I == A.name)
			var/list/alarm = L[I]
			var/list/srcs  = alarm[3]
			if (origin in srcs)
				srcs -= origin
			if (srcs.len == 0)
				cleared = 1
				L -= I
	return !cleared


/obj/machinery/computer/holo/station_alert/process()
	..()

/obj/machinery/computer/holo/station_alert/update_icon()
	..()
	if(stat & (NOPOWER|BROKEN))
		return
	var/active_alarms = FALSE
	for(var/cat in alarms)
		var/list/L = alarms[cat]
		if(L.len)
			active_alarms = TRUE
	if(active_alarms)
		overlays += "alert_1"