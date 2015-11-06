
////////////////
// BASE TYPE //
////////////////

//Do not spawn
/mob/living/simple_animal/hostile/blob
	icon = 'icons/mob/blob.dmi'
	pass_flags = PASSBLOB
	faction = list("blob")
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = 360
	var/mob/camera/blob/overmind = null

/mob/living/simple_animal/hostile/blob/proc/adjustcolors(a_color)
	if(a_color)
		color = a_color

/mob/living/simple_animal/hostile/blob/blob_act()
	return

////////////////
// BLOB SPORE //
////////////////

/mob/living/simple_animal/hostile/blob/blobspore
	name = "blob"
	desc = "A floating, fragile spore."
	icon_state = "blobpod"
	icon_living = "blobpod"
	health = 20
	maxHealth = 20
	melee_damage_lower = 2
	melee_damage_upper = 4
	attacktext = "hits"
	attack_sound = 'sound/weapons/genhit1.ogg'
	speak_emote = list("pulses")
	see_in_dark = 8
	see_invisible = SEE_INVISIBLE_MINIMUM
	var/obj/effect/blob/factory/factory = null
	var/list/human_overlays = list()
	var/is_zombie = 0
	gold_core_spawnable = 1

/mob/living/simple_animal/hostile/blob/blobspore/fire_act(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	..()
	adjustBruteLoss(Clamp(exposed_temperature, 1, 10))


/mob/living/simple_animal/hostile/blob/blobspore/CanPass(atom/movable/mover, turf/target, height=0)
	if(istype(mover, /obj/effect/blob))
		return 1
	return ..()

/mob/living/simple_animal/hostile/blob/blobspore/New(loc, var/obj/effect/blob/factory/linked_node)
	if(istype(linked_node))
		factory = linked_node
		factory.spores += src
	..()

/mob/living/simple_animal/hostile/blob/blobspore/Life()

	if(!is_zombie && isturf(src.loc))
		for(var/mob/living/carbon/human/H in oview(src,1)) //Only for corpse right next to/on same tile
			if(H.stat == DEAD)
				Zombify(H)
				break
	if(factory && z != factory.z)
		death()
	..()

/mob/living/simple_animal/hostile/blob/blobspore/proc/Zombify(mob/living/carbon/human/H)
	is_zombie = 1
	if(H.wear_suit)
		var/obj/item/clothing/suit/armor/A = H.wear_suit
		if(A.armor && A.armor["melee"])
			maxHealth += A.armor["melee"] //That zombie's got armor, I want armor!
	maxHealth += 40
	health = maxHealth
	name = "blob zombie ([rand(100,999)])"
	real_name = name
	desc = "A shambling corpse animated by the blob."
	melee_damage_lower = 10
	melee_damage_upper = 15
	icon = H.icon
	speak_emote = list("groans")
	icon_state = "zombie_s"
	H.hair_style = null
	H.update_hair()
	human_overlays = H.overlays
	update_icons()
	H.loc = src
	loc.visible_message("<span class='warning'>The corpse of [H.name] suddenly rises!</span>")

/mob/living/simple_animal/hostile/blob/blobspore/attack_ghost(mob/user)
	if(is_zombie && !key && !client)
		if(user.client.banprisoned)
			return
		var/be_zombie = alert("�� ������ ����� ����-�����? (��������, ��� �� ������ �����������!)",,"��","���")
		if(be_zombie == "���" || gc_destroyed)
			return
		if(be_zombie == "��")
			key = user.key


/mob/living/simple_animal/hostile/blob/blobspore/death(gibbed)
	..(1)
	// On death, create a small smoke of harmful gas (s-Acid)
	var/datum/effect_system/smoke_spread/chem/S = new
	var/turf/location = get_turf(src)

	// Create the reagents to put into the air
	create_reagents(10)

	if(overmind && overmind.blob_reagent_datum)
		reagents.add_reagent(overmind.blob_reagent_datum.id, 10)
	else
		reagents.add_reagent("spore", 10)

	// Attach the smoke spreader and setup/start it.
	S.attach(location)
	S.set_up(reagents, 0, location, silent=1)
	S.start()

	ghostize()
	qdel(src)


/mob/living/simple_animal/hostile/blob/blobspore/Destroy()
	if(factory)
		factory.spores -= src
	factory = null
	if(contents)
		for(var/mob/M in contents)
			M.loc = src.loc
	return ..()


/mob/living/simple_animal/hostile/blob/blobspore/update_icons()
	..()

	if(overmind && overmind.blob_reagent_datum)
		adjustcolors(overmind.blob_reagent_datum.color)
	else
		adjustcolors(color) //to ensure zombie/other overlays update


/mob/living/simple_animal/hostile/blob/blobspore/adjustcolors(a_color)
	color = a_color

	if(is_zombie)
		overlays.Cut()
		overlays = human_overlays
		var/image/I = image('icons/mob/blob.dmi', icon_state = "blob_head")
		I.color = color
		color = initial(color)//looks better.
		overlays += I

/mob/living/simple_animal/hostile/blob/blobspore/say(var/message)
	if (!message)
		return

	if (src.client)
		if(client.prefs.muted & MUTE_IC)
			src << "You cannot send IC messages (muted)."
			return
		if (src.client.handle_spam_prevention(message,MUTE_IC))
			return

	if (stat)
		return

	blob_talk(message)

/mob/living/simple_animal/hostile/blob/blobspore/proc/blob_talk(message)
	log_say("[key_name(src)] : [message]")

	message = trim(copytext(sanitize(message), 1, MAX_MESSAGE_LEN))

	if (!message)
		return

	var/message_a = say_quote(message, get_spans())
	var/rendered = "<font color=\"#EE4000\"><i><span class='game say'>Blob Telepathy, <span class='name'>[name]</span> <span class='message'>[message_a]</span></span></i></font>"

	for (var/mob/M in mob_list)
		if(isovermind(M) || isobserver(M) || isblobzombie(M))
			M.show_message(rendered, 2)


/////////////////
// BLOBBERNAUT //
/////////////////

/mob/living/simple_animal/hostile/blob/blobbernaut
	name = "blobbernaut"
	desc = "A hulking, mobile chunk of blobmass."
	icon_state = "blobbernaut"
	icon_living = "blobbernaut"
	icon_dead = "blobbernaut_dead"
	health = 240
	maxHealth = 240
	melee_damage_lower = 20
	melee_damage_upper = 20
	attacktext = "hits"
	attack_sound = 'sound/effects/blobattack.ogg'
	speak_emote = list("gurgles")
	minbodytemp = 0
	maxbodytemp = 360
	force_threshold = 10
	environment_smash = 3
	mob_size = MOB_SIZE_LARGE
	gold_core_spawnable = 1

/mob/living/simple_animal/hostile/blob/blobbernaut/blob_act()
	return


/mob/living/simple_animal/hostile/blob/blobbernaut/death(gibbed)
	..(gibbed)
	flick("blobbernaut_death", src)
