/obj/item/clothing/shoes/jackboots/guard
	name = "jackboots"
	desc = "����������� ����� ���������� ���������, � ���������� � ���������� ��� ���� - �� �����, ��� ��� ��� �������..."
//	icon = //'������� ���� �� �����!'
//	icon_state = //"������� ���� �� �����!"
	strip_delay = 70
	put_on_delay = 50
	burn_state = FIRE_PROOF
	can_hold_items = 1

/obj/item/weapon/gun/energy/laser/guard
	name = "lasgun"
	desc = "����������� ������ ���������� ���������, ��� ������������� ��������, �����������, ��������, �����... �������, �� � ���������� ���������..."
	icon_state = "laser"
	item_state = "laser"
	w_class = 3
	materials = list(MAT_METAL=4500)
	origin_tech = "combat=5;magnets=3"
//	icon = //'������� ���� �� �����!'
//	icon_state = //"������� ���� �� �����!"
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun)
	ammo_x_offset = 1
	shaded_charge = 1
	cell_type = /obj/item/weapon/stock_parts/cell/ammo/high
	burn_state = FIRE_PROOF

/obj/item/weapon/gun/energy/laser/guard/sc_laser

/obj/item/weapon/gun/projectile/automatic/c20r/sc_laser/New()
	..()
	for(var/ammo in magazine.stored_ammo)
		if(prob(70)) //95% chance
			magazine.stored_ammo -= ammo

/obj/item/clothing/suit/armor/guard
	name = "Trooper Armor"
	desc = "� ���� ������� ����� � ����� ��������� �� �����... ����, ��� ��������?"
	worn_icon = 'icons/mob/uac/suit.dmi'
//	icon = //'������� ���� �� �����!'
//	icon_state = //"������� ���� �� �����!"
	strip_delay = 90
	put_on_delay = 100
	armor = list(melee = 45, bullet = 50, laser = 35, energy = 20, bomb = 35, bio = 0, rad = 0)
	burn_state = FIRE_PROOF

/obj/item/clothing/head/helmet/guard
	name = "helmet"
	desc = "Standard Security gear. Protects the head from impacts."
//	icon = //'������� ���� �� �����!'
//	icon_state = //"������� ���� �� �����!"
	flags = HEADBANGPROTECT | BLOCKHAIR
	armor = list(melee = 25, bullet = 15, laser = 25,energy = 10, bomb = 25, bio = 0, rad = 0)
	strip_delay = 30
	burn_state = FIRE_PROOF

/obj/item/clothing/under/warden_corporate
	name = "warden corporate uniform"
	desc = "Unusual warden's uniform."
//	icon = //'������� ���� �� �����!'
//	icon_state = //"������� ���� �� �����!"
//	worn_icon = //'������� ���� �� �����!'
	can_adjust = 0
	armor = list(melee = 10, bullet = 0, laser = 0,energy = 0, bomb = 0, bio = 0, rad = 0)
	alt_covers_chest = 1

/obj/structure/barricade/guard
	name = "guard barrier"
	desc = "����������� ������� ���������, ������������ ������ �� ��� ��� ��� ���������� ����������� ����� ���������� - �������� ���������������."
	icon = 'icons/obj/objects.dmi'
	icon_state = "barrier0"
	density = 1
	anchored = 1
	health = 9000
	maxhealth = 9000
	proj_pass_rate = 90
	unacidable = 1