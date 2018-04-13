/obj/structure/sign
	icon = 'icons/obj/decals.dmi'
	anchored = TRUE
	opacity = 0
	density = FALSE
	layer = SIGN_LAYER
	max_integrity = 100
	armor = list(melee = 50, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0, fire = 50, acid = 50)
	var/buildable_sign = 1 //unwrenchable and modifiable

/obj/structure/sign/basic
	name = "blank sign"
	desc = "How can signs be real if our eyes aren't real?"
	icon_state = "backing"

/obj/structure/sign/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(src.loc, 'sound/weapons/slash.ogg', 80, 1)
			else
				playsound(loc, 'sound/weapons/tap.ogg', 50, 1)
		if(BURN)
			playsound(loc, 'sound/items/welder.ogg', 80, 1)

/obj/structure/sign/attackby(obj/item/O, mob/user, params)
	if(istype(O, /obj/item/wrench) && buildable_sign)
		user.visible_message("<span class='notice'>[user] starts removing [src]...</span>", \
							 "<span class='notice'>You start unfastening [src].</span>")
		playsound(src, O.usesound, 50, 1)
		if(!do_after(user, 30*O.toolspeed, target = src))
			return
		playsound(src, 'sound/items/deconstruct.ogg', 50, 1)
		user.visible_message("<span class='notice'>[user] unfastens [src].</span>", \
							 "<span class='notice'>You unfasten [src].</span>")
		var/obj/item/sign_backing/SB = new (get_turf(user))
		SB.icon_state = icon_state
		SB.sign_path = type
		qdel(src)
	else if(istype(O, /obj/item/pen) && buildable_sign)
		var/list/sign_types = list("Secure Area", "Biohazard", "High Voltage", "Radiation", "Hard Vacuum Ahead", "Disposal: Leads To Space", "Danger: Fire", "No Smoking", "Medbay", "Science", "Chemistry", \
		"Hydroponics", "Xenobiology")
		var/obj/structure/sign/sign_type
		switch(input(user, "Select a sign type.", "Sign Customization") as null|anything in sign_types)
			if("Blank")
				sign_type = /obj/structure/sign/basic
			if("Secure Area")
				sign_type = /obj/structure/sign/securearea
			if("Biohazard")
				sign_type = /obj/structure/sign/biohazard
			if("High Voltage")
				sign_type = /obj/structure/sign/electricshock
			if("Radiation")
				sign_type = /obj/structure/sign/radiation
			if("Hard Vacuum Ahead")
				sign_type = /obj/structure/sign/vacuum
			if("Disposal: Leads To Space")
				sign_type = /obj/structure/sign/deathsposal
			if("Danger: Fire")
				sign_type = /obj/structure/sign/fire
			if("No Smoking")
				sign_type = /obj/structure/sign/nosmoking_1
			if("Medbay")
				sign_type = /obj/structure/sign/bluecross_2
			if("Science")
				sign_type = /obj/structure/sign/science
			if("Chemistry")
				sign_type = /obj/structure/sign/chemistry
			if("Hydroponics")
				sign_type = /obj/structure/sign/botany
			if("Xenobiology")
				sign_type = /obj/structure/sign/xenobio

		//Make sure user is adjacent still
		if(!Adjacent(user))
			return

		if(!sign_type)
			return

		//It's import to clone the pixel layout information
		//Otherwise signs revert to being on the turf and
		//move jarringly
		var/obj/structure/sign/newsign = new sign_type(get_turf(src))
		newsign.pixel_x = pixel_x
		newsign.pixel_y = pixel_y
		qdel(src)
	else
		return ..()

/obj/item/sign_backing
	name = "sign backing"
	desc = "A sign with adhesive backing."
	icon = 'icons/obj/decals.dmi'
	icon_state = "backing"
	w_class = WEIGHT_CLASS_NORMAL
	resistance_flags = FLAMMABLE
	var/sign_path = /obj/structure/sign/basic //the type of sign that will be created when placed on a turf

/obj/item/sign_backing/afterattack(atom/target, mob/user, proximity)
	if(isturf(target) && proximity)
		var/turf/T = target
		user.visible_message("<span class='notice'>[user] fastens [src] to [T].</span>", \
							 "<span class='notice'>You attach the sign to [T].</span>")
		playsound(T, 'sound/items/deconstruct.ogg', 50, 1)
		new sign_path(T)
		user.drop_item()
		qdel(src)
	else
		return ..()

/obj/structure/sign/map
	name = "station map"
	desc = "A framed picture of the station."
	max_integrity = 500

/obj/structure/sign/map/left
	icon_state = "map-left"

/obj/structure/sign/map/left/dream
	icon_state = "map-left-DS"
	desc = "A framed picture of the station.\nClockwise from the top, you see Engineering(<b>yellow</b>), Arrivals(<b>blue and white</b>), Atmospherics(<b>yellow</b>), Security(<b>red</b>), \
	Cargo(<b>brown</b>), Science(<b>purple</b>), Escape(<b>red and white</b>), and Medbay(<b>blue</b>).\nIn the center of the station, you see the Bridge(<b>dark blue</b>).\n\
	Around those, you see Hallways/Entrances(<b>light grey</b>), Public Areas(<b>grey</b>), and Maintenance(<b>dark grey</b>)."

/obj/structure/sign/map/right
	icon_state = "map-right"

/obj/structure/sign/map/right/dream
	icon_state = "map-right-DS"
	desc = "A framed picture of the station.\nClockwise from the top, you see Engineering(<b>yellow</b>), Arrivals(<b>blue and white</b>), Atmospherics(<b>yellow</b>), Security(<b>red</b>), \
	Cargo(<b>brown</b>), Science(<b>purple</b>), Escape(<b>red and white</b>), and Medbay(<b>blue</b>).\nIn the center of the station, you see the Bridge(<b>dark blue</b>).\n\
	Around those, you see Hallways/Entrances(<b>light grey</b>), Public Areas(<b>grey</b>), and Maintenance(<b>dark grey</b>)."

/obj/structure/sign/map/left/ceres
	icon_state = "map-CS"
	desc = "A framed picture of the station.\nClockwise from the top, you see Security (<b>red</b>), Dorms (<b>light-green</b>), Bridge (<b>dark-blue</b>), AI Core (<b>gray</b>), \
	Cargo (<b>brown</b>), Medbay (<b>blue</b>), Arrivals/Departures(<b>orange/cyan</b>), Research (<b>purple</b>), Service (<b>dark-green</b>), and Engineering in the center (<b>yellow</b>)."

/obj/structure/sign/securearea
	name = "\improper SECURE AREA"
	desc = "A warning sign which reads 'SECURE AREA'."
	icon_state = "securearea"

/obj/structure/sign/biohazard
	name = "\improper BIOHAZARD"
	desc = "A warning sign which reads 'BIOHAZARD'."
	icon_state = "bio"

/obj/structure/sign/electricshock
	name = "\improper HIGH VOLTAGE"
	desc = "A warning sign which reads 'HIGH VOLTAGE'."
	icon_state = "shock"

/obj/structure/sign/examroom
	name = "\improper EXAM ROOM"
	desc = "A guidance sign which reads 'EXAM ROOM'."
	icon_state = "examroom"

/obj/structure/sign/vacuum
	name = "\improper HARD VACUUM AHEAD"
	desc = "A warning sign which reads 'HARD VACUUM AHEAD'."
	icon_state = "space"

/obj/structure/sign/deathsposal
	name = "\improper DISPOSAL: LEADS TO SPACE"
	desc = "A warning sign which reads 'DISPOSAL: LEADS TO SPACE'."
	icon_state = "deathsposal"

/obj/structure/sign/pods
	name = "\improper ESCAPE PODS"
	desc = "A warning sign which reads 'ESCAPE PODS'."
	icon_state = "pods"

/obj/structure/sign/fire
	name = "\improper DANGER: FIRE"
	desc = "A warning sign which reads 'DANGER: FIRE'."
	icon_state = "fire"


/obj/structure/sign/nosmoking_1
	name = "\improper NO SMOKING"
	desc = "A warning sign which reads 'NO SMOKING'."
	icon_state = "nosmoking"


/obj/structure/sign/nosmoking_2
	name = "\improper NO SMOKING"
	desc = "A warning sign which reads 'NO SMOKING'."
	icon_state = "nosmoking2"

/obj/structure/sign/radiation
	name = "HAZARDOUS RADIATION"
	desc = "A warning sign alerting the user of potential radiation hazards."
	icon_state = "radiation"

/obj/structure/sign/bluecross
	name = "medbay"
	desc = "The Intergalactic symbol of Medical institutions. You'll probably get help here."
	icon_state = "bluecross"

/obj/structure/sign/bluecross_2
	name = "medbay"
	desc = "The Intergalactic symbol of Medical institutions. You'll probably get help here."
	icon_state = "bluecross2"

/obj/structure/sign/goldenplaque
	name = "The Most Robust Men Award for Robustness"
	desc = "To be Robust is not an action or a way of life, but a mental state. Only those with the force of Will strong enough to act during a crisis, saving friend from foe, are truly Robust. Stay Robust my friends."
	icon_state = "goldenplaque"

/obj/structure/sign/kiddieplaque
	name = "AI developers plaque"
	desc = "Next to the extremely long list of names and job titles, there is a drawing of a little child. The child appears to be retarded. Beneath the image, someone has scratched the word \"PACKETS\""
	icon_state = "kiddieplaque"

/obj/structure/sign/atmosplaque
	name = "\improper FEA Atmospherics Division plaque"
	desc = "This plaque commemorates the fall of the Atmos FEA division. For all the charred, dizzy, and brittle men who have died in its hands."
	icon_state = "atmosplaque"

/obj/structure/sign/nanotrasen
	name = "\improper Nanotrasen Logo"
	desc = "A sign with the Nanotrasen Logo on it. Glory to Nanotrasen!"
	icon_state = "nanotrasen"

/obj/structure/sign/science			//These 3 have multiple types, just var-edit the icon_state to whatever one you want on the map
	name = "\improper SCIENCE"
	desc = "A sign labelling an area where research and science is performed."
	icon_state = "science1"

/obj/structure/sign/chemistry
	name = "\improper CHEMISTRY"
	desc = "A sign labelling an area containing chemical equipment."
	icon_state = "chemistry1"

/obj/structure/sign/botany
	name = "\improper HYDROPONICS"
	desc = "A sign labelling an area as a place where plants are grown."
	icon_state = "hydro1"

/obj/structure/sign/xenobio
	name = "\improper XENOBIOLOGY"
	desc = "A sign labelling an area as a place where xenobiological entities are researched."
	icon_state = "xenobio"

/obj/structure/sign/directions
	name = "some direction"
	desc = "This way!"
	icon_state = "direction_sci"
	resistance_flags = FIRE_PROOF

/obj/structure/sign/evac
	name = "\improper EVACUATION"
	desc = "A sign labelling an area where evacuation procedures take place."
	icon_state = "evac"

/obj/structure/sign/custodian
	name = "\improper CUSTODIAN"
	desc = "A sign labelling an area where the custodian works."
	icon_state = "custodian"

/obj/structure/sign/engineering
	name = "\improper ENGINEERING"
	desc = "A sign labelling an area where engineers work."
	icon_state = "engine"

/obj/structure/sign/cargo
	name = "\improper CARGO"
	desc = "A sign labelling an area where cargo ships dock."
	icon_state = "cargo"

/obj/structure/sign/security
	name = "\improper SECURITY"
	desc = "A sign labelling an area where the law is law."
	icon_state = "security"

/obj/structure/sign/holy
	name = "\improper HOLY"
	desc = "A sign labelling a religious area."
	icon_state = "holy"

/obj/structure/sign/restroom
	name = "\improper RESTROOM"
	desc = "A sign labelling a restroom."
	icon_state = "restroom"

/obj/structure/sign/xeno_warning_mining
	name = "DANGEROUS ALIEN LIFE"
	desc = "A sign that warns would-be travellers of hostile alien life in the vicinity."
	icon = 'icons/obj/mining.dmi'
	icon_state = "xeno_warning"

/obj/structure/sign/enginesafety
	name = "\improper ENGINEERING SAFETY"
	desc = "A sign detailing the various safety protocols when working on-site to ensure a safe shift."
	icon_state = "safety"

/obj/structure/sign/directions/science
	name = "science department"
	desc = "A direction sign, pointing out which way the Science department is."
	icon_state = "direction_sci"

/obj/structure/sign/directions/engineering
	name = "engineering department"
	desc = "A direction sign, pointing out which way the Engineering department is."
	icon_state = "direction_eng"

/obj/structure/sign/directions/security
	name = "security department"
	desc = "A direction sign, pointing out which way the Security department is."
	icon_state = "direction_sec"

/obj/structure/sign/directions/medical
	name = "medical bay"
	desc = "A direction sign, pointing out which way the Medical Bay is."
	icon_state = "direction_med"

/obj/structure/sign/directions/evac
	name = "escape arm"
	desc = "A direction sign, pointing out which way the escape shuttle dock is."
	icon_state = "direction_evac"

/obj/structure/sign/directions/supply
	name = "cargo bay"
	desc = "A direction sign, pointing out which way the Cargo Bay is."
	icon_state = "direction_supply"

/obj/structure/sign/directions/command
	name = "command department"
	desc = "A direction sign, pointing out which way the Command department is."
	icon_state = "direction_bridge"

/obj/structure/sign/uac
	name = "\improper UAC emblem"
	desc = "A blue planet between three strange symbols..."
	icon = 'icons/obj/infinity_decals.dmi'
	icon_state = "uac"

/obj/structure/sign/terran
	name = "\improper Terran emblem"
	desc = "LOYALTY UNTIL DEATH!"
	icon = 'icons/obj/infinity_decals.dmi'
	icon_state = "terran"

/obj/structure/sign/skull
	name = "\improper skull emblem"
	desc = "Nobody get out alive."
	icon = 'icons/obj/infinity_decals.dmi'
	icon_state = "new_logo"

/obj/structure/sign/spiderclan
	name = "\improper spider clan emblem"
	desc = "Black widow between red polygon."
	icon = 'icons/obj/infinity_decals.dmi'
	icon_state = "spider_clan"

/obj/structure/sign/medbay_wall
	name = "MEDBAY"
	desc = "Big black words, what says it's a medbay."
	icon = 'icons/obj/wall_signs.dmi'
	icon_state = "med"

/obj/structure/sign/brig_wall
	name = "BRIG"
	desc = "Big black words, what says it's a brig."
	icon = 'icons/obj/wall_signs.dmi'
	icon_state = "brig"

/obj/structure/sign/cargo_wall
	name = "CARGO"
	desc = "Big black words, what says it's a cargo."
	icon = 'icons/obj/wall_signs.dmi'
	icon_state = "cargo"

/obj/structure/sign/bridge_wall
	name = "BRIDGE"
	desc = "Big black words, what says it's a bridge."
	icon = 'icons/obj/wall_signs.dmi'
	icon_state = "bridge"

/obj/structure/sign/rnd_wall
	name = "RESEARCH DIVISION"
	desc = "Big black words, what says it's a research division."
	icon = 'icons/obj/wall_signs.dmi'
	icon_state = "rnd"

/obj/structure/sign/engi_wall
	name = "ENGINEERING"
	desc = "Big black words, what says it's a engineering."
	icon = 'icons/obj/wall_signs_engi.dmi'
	icon_state = "engi"

/obj/structure/sign/nanotrasen
	name = "Nanotrasen Emblem"
	desc = "Nanotrasen Emblem - a two litters a front of blue background."
	icon_state = "NT"
	icon = 'icons/obj/infinity_decals.dmi'

/obj/structure/sign/directions/dock
	name = "docking port 1"
	desc = "A direction sign, pointing out which way the Docking port 1 is."
	icon_state = "dock_1"
	icon = 'icons/obj/infinity_decals.dmi'

/obj/structure/sign/directions/dock/two
	name = "docking port 2"
	desc = "A direction sign, pointing out which way the Docking port 2 is."
	icon_state = "dock_2"

/obj/structure/sign/directions/dock/three
	name = "docking port 3"
	desc = "A direction sign, pointing out which way the Docking port 3 is."
	icon_state = "dock_3"

/obj/structure/sign/directions/dock/four
	name = "docking port 4"
	desc = "A direction sign, pointing out which way the Docking port 4 is."
	icon_state = "dock_4"

/obj/structure/sign/directions/shuttle
	name = "shuttle sign"
	desc = "A direction sign, pointing out which way the shuttle."
	icon_state = "shuttle"
	icon = 'icons/obj/infinity_decals.dmi'

/obj/structure/sign/directions/cryo
	name = "cryo sign"
	icon = 'icons/obj/infinity_decals.dmi'
	desc = "Index, which tells that you are in the cryogenic room."
	icon_state = "cryo"

/obj/structure/sign/directions/ert
	name = "lead's equipment"
	icon = 'icons/obj/infinity_decals.dmi'
	desc = "Index, which tells that you are in the lead's room."
	icon_state = "commander"

/obj/structure/sign/directions/ert/security
	name = "security's equipment"
	desc = "Index, which tells that you are in the security's room."
	icon_state = "security"

/obj/structure/sign/directions/ert/engineer
	name = "engineer's equipment"
	desc = "Index, which tells that you are in the engineer's room."
	icon_state = "engineer"

/obj/structure/sign/directions/ert/medic
	name = "medical's equipment"
	desc = "Index, which tells that you are in the medical's room."
	icon_state = "medic"

/obj/structure/sign/synd
	name = "Syndicate emblem"
	desc = "That's our galaxy."
	icon = 'icons/obj/infinity_decals.dmi'
	icon_state = "synd_sim"

/obj/structure/sign/directions/s
	name = "S"
	desc = "That's just big a letter S..."
	icon = 'icons/obj/infinity_decals.dmi'
	icon_state = "S"
	layer = 2.1

/obj/structure/sign/directions/only
	name = "Only 1"
	desc = "Enter only by one."
	icon = 'icons/obj/infinity_decals.dmi'
	icon_state = "only"

/obj/structure/sign/directions/eva
	name = "EVA sign"
	desc = "EVA is here!"
	icon = 'icons/obj/infinity_decals.dmi'
	icon_state = "EVA"

/obj/structure/sign/directions/civilian
	name = "civilian pointer"
	icon = 'icons/obj/infinity_decals.dmi'
	desc = "Pointer, saying to you that in front will be civilian zone."
	icon_state = "civilian"

/obj/structure/sign/directions/personal
	name = "personal pointer"
	icon = 'icons/obj/infinity_decals.dmi'
	desc = "Pointer, saying to you that in front will be personal-only zone."
	icon_state = "personal"

/obj/structure/sign/directions/alien
	name = "alien sign"
	icon = 'icons/obj/infinity_alien.dmi'
	desc = "So cute images!"
	icon_state = "sign_1"

/obj/structure/sign/directions/administration
	name = "administration pointer"
	icon = 'icons/obj/infinity_decals.dmi'
	desc = "Pointer, saying to you that in front will be administrative-only zone."
	icon_state = "administration"

/obj/structure/sign/directions/numbers
	name = "One"
	icon = 'icons/obj/infinity_decals.dmi'
	desc = "Number one"
	icon_state = "one"

/obj/structure/sign/directions/numbers/two
	name = "Two"
	desc = "Number two"
	icon_state = "two"

/obj/structure/sign/directions/numbers/three
	name = "Three"
	desc = "Number three"
	icon_state = "three"

/obj/structure/sign/directions/numbers/four
	name = "Four"
	desc = "Number four"
	icon_state = "four"

/obj/structure/sign/experementor
	name = "E.X.P.E.R.I-MENTOR"
	desc = "E.X.P.E.R.I-MENTOR's part will be forward."
	icon_state = "experementor"
	icon = 'icons/obj/infinity_decals.dmi'

/obj/structure/sign/anabiosis
	name = "\improper Anabiosis emblem "
	desc = "���� ���������� '�������'. ������� ���'� �� ���� �������� �� ������������� ������������..."
	icon_state = "emblem"
	icon = 'icons/mob/infinity_anabiosis/anabiosis.dmi'

/obj/structure/sign/warning/airlock
	name = "\improper EXTERNAL AIRLOCK"
	icon = 'icons/obj/infinity_decals.dmi'
	icon_state = "doors"

/obj/structure/sign/warning/bomb_range
	name = "\improper BOMB RANGE"
	icon = 'icons/obj/infinity_decals.dmi'
	icon_state = "blast"

/obj/structure/sign/warning/compressed_gas
	name = "\improper COMPRESSED GAS"
	icon = 'icons/obj/infinity_decals.dmi'
	icon_state = "hikpa"

/obj/structure/sign/warning/fall
	name = "\improper FALL HAZARD"
	icon = 'icons/obj/infinity_decals.dmi'
	icon_state = "falling"

/obj/structure/sign/warning/lethal_turrets
	name = "\improper LETHAL TURRETS"
	icon = 'icons/obj/infinity_decals.dmi'
	icon_state = "turrets"

/obj/structure/sign/warning/lethal_turrets/New()
	..()
	desc += " Enter at own risk!."

/obj/structure/sign/warning/mail_delivery
	name = "\improper MAIL DELIVERY"
	icon = 'icons/obj/infinity_decals.dmi'
	icon_state = "mail"

/obj/structure/sign/warning/moving_parts
	name = "\improper MOVING PARTS"
	icon = 'icons/obj/infinity_decals.dmi'
	icon_state = "movingparts"

/obj/structure/sign/warning/armory
	name = "\improper ARMORY"
	icon = 'icons/obj/infinity_decals.dmi'
	icon_state = "armory"

/obj/structure/sign/warning/server_room
	name = "\improper SERVER ROOM"
	icon = 'icons/obj/infinity_decals.dmi'
	icon_state = "server"

/obj/structure/sign/goldenplaque/medical
	name = "medical certificate"
	desc = "A picture next to a long winded description of medical certifications and degrees."
	icon = 'icons/obj/infinity_decals.dmi'
	icon_state = "lightplaquealt"

/obj/structure/sign/science_2
	name = "\improper RESEARCH"
	desc = "A sign labelling an area where research is performed."
	icon = 'icons/obj/infinity_decals.dmi'
	icon_state = "science2"

/obj/structure/sign/xenobio_1
	name = "\improper XENOBIOLOGY"
	desc = "A sign labelling an area as a place where xenobiological entites are researched."
	icon = 'icons/obj/infinity_decals.dmi'
	icon_state = "xenobio"

/obj/structure/sign/xenobio_2
	name = "\improper XENOBIOLOGY"
	desc = "A sign labelling an area as a place where xenobiological entites are researched."
	icon = 'icons/obj/infinity_decals.dmi'
	icon_state = "xenobio2"

/obj/structure/sign/xenobio_3
	name = "\improper XENOBIOLOGY"
	desc = "A sign labelling an area as a place where xenobiological entites are researched."
	icon = 'icons/obj/infinity_decals.dmi'
	icon_state = "xenobio3"

/obj/structure/sign/xenobio_4
	name = "\improper XENOBIOLOGY"
	desc = "A sign labelling an area as a place where xenobiological entites are researched."
	icon = 'icons/obj/infinity_decals.dmi'
	icon_state = "xenobio4"

/obj/structure/sign/hydro
	name = "\improper HYDROPONICS"
	desc = "A sign labelling an area as a place where plants are grown."
	icon = 'icons/obj/infinity_decals.dmi'
	icon_state = "hydro1"

/obj/structure/sign/hydrostorage
	name = "\improper HYDROPONICS STORAGE"
	desc = "A sign labelling an area as a place where plant growing supplies are kept."
	icon = 'icons/obj/infinity_decals.dmi'
	icon_state = "hydro3"

/obj/structure/sign/deck/bridge
	name = "\improper Bridge Deck"
	icon = 'icons/obj/infinity_decals.dmi'
	icon_state = "deck-b"

/obj/structure/sign/deck/first
	name = "\improper First Deck"
	icon = 'icons/obj/infinity_decals.dmi'
	icon_state = "deck-1"

/obj/structure/sign/deck/second
	name = "\improper Second Deck"
	icon = 'icons/obj/infinity_decals.dmi'
	icon_state = "deck-2"

/obj/structure/sign/deck/third
	name = "\improper Third Deck"
	icon = 'icons/obj/infinity_decals.dmi'
	icon_state = "deck-3"

/obj/structure/sign/deck/fourth
	name = "\improper Fourth Deck"
	icon = 'icons/obj/infinity_decals.dmi'
	icon_state = "deck-4"

/obj/structure/sign/logo
	name = "station logo"
	desc = "A sign: SPACE STATION 13."
	icon_state = "ss13sign-1"
