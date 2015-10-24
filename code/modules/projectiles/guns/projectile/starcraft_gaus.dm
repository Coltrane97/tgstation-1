/obj/item/weapon/gun/projectile/automatic/gause
	name = "Gause rifle"
	desc = "'� ��� ��������!'"
	icon_state = "gause"
	item_state = "gause"
	icon = 'icons/obj/starcraft.dmi'
	lefthand_file = 'icons/mob/starcraft/starcraft_righthand .dmi'
	righthand_file = 'icons/mob/starcraft/starcraft_lefthand.dmi'
	origin_tech = "combat=5;materials=3"
	pin = /obj/item/device/firing_pin
	mag_type = /obj/item/ammo_box/magazine/spine
	fire_sound = 'sound/weapons/Gunshot4.ogg'
	flags = NODROP
	slot_flags = 0
	can_suppress = 0
	burst_size = 6
	fire_delay = 1

/obj/item/ammo_casing/gause_spine
	desc = "A 0.85mm casing."
	caliber = "0.85"
	icon_state = "s-casing"
	projectile_type = /obj/item/projectile/bullet/gause_spine