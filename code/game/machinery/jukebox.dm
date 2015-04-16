//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:32

datum/track
	var/title
	var/sound

datum/track/New(var/title_name, var/audio)
	title = title_name
	sound = audio

/obj/machinery/media/jukebox/
	name = "space jukebox"
	icon = 'icons/obj/jukebox.dmi'
	icon_state = "jukebox2-nopower"
	var/state_base = "jukebox2"
	anchored = 1
	density = 1
	power_channel = EQUIP
	use_power = 1
	idle_power_usage = 10
	active_power_usage = 100

	var/playing = 0

	var/datum/track/current_track
	var/list/datum/track/tracks = list(
		new/datum/track("Avicii - You Make Me", 'sound/playlist/avicii - you make me.ogg'),
		new/datum/track("Beastie Boys - Intergalactic", 'sound/playlist/beastie_boys - intergalactic.ogg'),
		new/datum/track("Boots Randolph - Yakety Sax", 'sound/playlist/boots_randolph - yakety sax.ogg'),
		new/datum/track("Chris Harfield - Space Oddity", 'sound/playlist/Chris Hadfield - Space Oddity.ogg'),
		new/datum/track("El Huervo - Daisuke", 'sound/playlist/el huervo - daisuke.ogg'),
		new/datum/track("Blazer Force - Electronic Santa Claus", 'sound/playlist/Electronic Santa Claus.ogg'),
		new/datum/track("Evanescence - My Immortal", 'sound/playlist/Evanescence - My Immortal.ogg'),
		new/datum/track("Gotye - Somebody That I Used To Know Miami 1984 Remix", 'sound/playlist/Gotye - somebody that i used to know.ogg'),
		new/datum/track("Orbital - The Box", 'sound/playlist/orbital - the box.ogg'),
		new/datum/track("Space Station 13 - Clown", 'sound/playlist/Space Station 13 - Clown.ogg'),
		new/datum/track("Taio Cruz feat. Flo-Rida � Hangover", 'sound/playlist/taio cruz - hangover.ogg'),
		new/datum/track("The Wanted - Chasing The Sun", 'sound/playlist/The-Wanted-Chasing-The-Sun.ogg'),
		new/datum/track("Timecop 1983 - Tonight", 'sound/playlist/timecop1983-tonight.ogg'),
		new/datum/track("Trust Me I'm an Engineer", 'sound/playlist/Trust me i m an engineer.ogg'),
		new/datum/track("����&#1013;�� - ����� � ����", 'sound/playlist/zemlyane - trava u doma.ogg'),
		new/datum/track("����&#1013;�� - �������� ������", 'sound/playlist/zemlyane - vzletnaya polosa.ogg'),
	)

/obj/machinery/media/jukebox/New()
	..()
	update_icon()

/obj/machinery/media/jukebox/Del()
	StopPlaying()
	..()

/obj/machinery/media/jukebox/power_change()
	if(!powered(power_channel) || !anchored)
		stat |= NOPOWER
	else
		stat &= ~NOPOWER

	if(stat & (NOPOWER|BROKEN) && playing)
		StopPlaying()
	update_icon()

/obj/machinery/media/jukebox/update_icon()
	overlays.Cut()
	if(stat & (NOPOWER|BROKEN) || !anchored)
		if(stat & BROKEN)
			icon_state = "[state_base]-broken"
		else
			icon_state = "[state_base]-nopower"
		return
	icon_state = state_base
	if(playing)
		overlays += "[state_base]-running"

/obj/machinery/media/jukebox/Topic(href, href_list)
	if(..() || !(Adjacent(usr) || istype(usr, /mob/living/silicon)))
		return

	if(!anchored)
		usr << "<span class='warning'>You must secure \the [src] first.</span>"
		return

	if(stat & (NOPOWER|BROKEN))
		usr << "\The [src] doesn't appear to function."
		return

	if(href_list["change_track"])
		for(var/datum/track/T in tracks)
			if(T.title == href_list["title"])
				current_track = T
				StartPlaying()
				break
	else if(href_list["stop"])
		StopPlaying()
	else if(href_list["play"])
		if(current_track == null)
			usr << "No track selected."
		else
			StartPlaying()

	return 1

/obj/machinery/media/jukebox/interact(mob/user)
	if(stat & (NOPOWER|BROKEN))
		usr << "\The [src] doesn't appear to function."
		return

	ui_interact(user)

/obj/machinery/media/jukebox/ui_interact(mob/user, ui_key = "jukebox", var/datum/nanoui/ui = null)
	var/title = "RetroBox - Space Style"
	var/data[0]

	if(!(stat & (NOPOWER|BROKEN)))
		data["current_track"] = current_track != null ? current_track.title : ""
		data["playing"] = playing

		var/list/nano_tracks = new
		for(var/datum/track/T in tracks)
			nano_tracks[++nano_tracks.len] = list("track" = T.title)

		data["tracks"] = nano_tracks

	// update the ui if it exists, returns null if no ui is passed/found
	ui = SSnano.try_update_ui(user, src, ui_key, ui, data)
	if (!ui)
		// the ui does not exist, so we'll create a new() one
        // for a list of parameters and their descriptions see the code docs in \code\modules\nano\nanoui.dm
		ui = new(user, src, ui_key, "jukebox.tmpl", title, 450, 600)
		// when the ui is first opened this is the data it will use
		ui.set_initial_data(data)
		// open the new ui window
		ui.open()

/obj/machinery/media/jukebox/attack_ai(mob/user as mob)
	return src.attack_hand(user)

/obj/machinery/media/jukebox/attack_hand(var/mob/user as mob)
	interact(user)

/obj/machinery/media/jukebox/attackby(obj/item/W as obj, mob/user as mob)
	src.add_fingerprint(user)

	if(istype(W, /obj/item/weapon/wrench))
		if(playing)
			StopPlaying()
		user.visible_message("<span class='warning'>[user] has [anchored ? "un" : ""]secured \the [src].</span>", "<span class='notice'>You [anchored ? "un" : ""]secure \the [src].</span>")
		anchored = !anchored
		playsound(src.loc, 'sound/items/Ratchet.ogg', 50, 1)
		power_change()
		update_icon()
		return

	return ..()

/obj/machinery/media/jukebox/proc/StopPlaying()
	var/area/A = get_area(src)
	// Always kill the current sound
	for(var/mob/living/M in mobs_in_area(A))
		M << sound(null, channel = 1)

	A.forced_ambience = null
	playing = 0
	use_power = 1
	update_icon()


/obj/machinery/media/jukebox/proc/StartPlaying()
	StopPlaying()
	if(!current_track)
		return

	var/area/A = get_area(src)
	A.forced_ambience = sound(current_track.sound, channel = 1, repeat = 1, volume = 25)

	for(var/mob/living/M in mobs_in_area(A))
		if(M.mind)
			A.play_ambience(M)

	playing = 1
	use_power = 2
	update_icon()
