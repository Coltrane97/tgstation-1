/obj/item/clothing/shoes/jackboots/guard
	name = "jackboots"
	desc = "����������� ����� ���������� ���������, � ���������� � ���������� ��� ����."
	icon_state = "jackboots"
	item_state = "jackboots"
	item_color = "hosred"
	strip_delay = 50
	put_on_delay = 50
	burn_state = FIRE_PROOF
	can_hold_items = 1

/obj/item/weapon/gun/energy/laser/guard
	name = "laser gun"
	desc = "����������� ������ ���������� ���������, ��� ������������� ��������, �����������, ��������... �������, �� � ���������� ���������..."
	icon_state = "laser"
	item_state = "laser"
	w_class = 3
	materials = list(MAT_METAL=4500)
	origin_tech = "combat=5;magnets=3"
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun)
	ammo_x_offset = 1
	shaded_charge = 1
	mag_type = /obj/item/weapon/stock_parts/cell/ammo/high