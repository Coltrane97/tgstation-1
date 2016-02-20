/obj/machinery/vending/terranstation
	name = "\improper Terran Station"
	desc = "����������� ���������� ����������� ������� - �������� ����� � � ��������, ������ �������."
	icon_state = "cart"
	req_access_txt = "0"
	product_slogans = "�����, ����� ���!;���������� ��������� � ��������� �����!;��������� ������ �� �������!;����������������� ������� � ������!;������ � �������� - ����� � �����.;��������� ������!"
	product_ads = "������� ������ ��������� ����������, ����������� - ���� ������.;���� ����� �� �������, � ������������ � �� ��� ����, ����� ������ ������ ����� ��� ���!."
	vend_reply = "������ ��� ������!;������� �� �����������!;���� �������!"
	products = list(/obj/item/weapon/gun/projectile/automatic/gause = 10,/obj/item/ammo_box/magazine/spine = 40)
	premium = list(/obj/item/weapon/gun/projectile/automatic/shotgun/bulldog/unrestricted = 2,/obj/item/ammo_box/magazine/m12g = 4)
	contraband = list(/obj/item/weapon/gun/projectile/revolver/mateba = 1)

/obj/machinery/light/small/floor
	icon_state = "floor1"
	base_state = "floor"
	fitting = "floor"
	brightness = 4
	layer = 2
	desc = "A small floor lighting fixture."
	light_type = /obj/item/weapon/light/bulb



/obj/machinery/computer/shuttle/remote_controlled_pod
	name = "Remote Controlled Pod One"
	desc = "Used to control the White ShipRemote Controlled Pod."
	shuttleId = "whiteship"
	possible_destinations = "whiteship_away;whiteship_home;whiteship_z4"
	circuit = /obj/machinery/computer/shuttle/remote_controlled_pod

/obj/machinery/computer/shuttle/remote_controlled_pod/two
	name = "Remote Controlled Pod Two"
	shuttleId = "whiteship"
	possible_destinations = "whiteship_away;whiteship_home;whiteship_z4"
	circuit = /obj/item/weapon/circuitboard/remote_controlled_pod/two

/obj/item/weapon/circuitboard/remote_controlled_pod
	name = "circuit board (Remote Controlled Pod One)"
	build_path = /obj/machinery/computer/shuttle/remote_controlled_pod

/obj/item/weapon/circuitboard/remote_controlled_pod/two
	name = "circuit board (Remote Controlled Pod Two)"
	build_path = /obj/machinery/computer/shuttle/remote_controlled_pod/two