/obj/item/clothing/head/bowknot
	name = "red bow-knot"
	desc = "A simple red bow."
	icon_state = "bow_knot"
	item_state = "helmet"
	item_color = "bow_knot"
	worn_icon = 'icons/mob/infinity_work.dmi'
	icon = 'icons/obj/clothing/infinity_work.dmi'

/obj/item/clothing/head/plast_helmet
	name = "plast helmet"
	desc = "Some unusual helmet."
	icon_state = "plast_helmet"
	item_state = "helmet"
	worn_icon = 'icons/mob/infinity_work.dmi'
	icon = 'icons/obj/clothing/infinity_work.dmi'
	armor = list(melee = 25, bullet = 25, laser = 30,energy = 25, bomb = 10, bio = 15, rad = 0)
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_HELM_MAX_TEMP_PROTECT
	flags = STOPSPRESSUREDMAGE|BLOCKHAIR
	strip_delay = 80
	flags_inv = HIDEEARS|HIDEEYES|HEADCOVERSMOUTH
	flags_cover = HEADCOVERSEYES
	burn_state = -1

/obj/item/clothing/head/blue_ny_hat
	name = "blue New Year hat"
	desc = "Ho ho ho!"
	icon_state = "blue_ny_hat"
	item_state = "helmet"
	item_color = "blue_ny_hat"
	worn_icon = 'icons/mob/infinity_work.dmi'
	icon = 'icons/obj/clothing/infinity_work.dmi'

/obj/item/clothing/head/helmet/space/bobafett_head
	name = "boba fett helmet"
	desc = "...In a Galaxy far far away."
	icon_state = "bobafett_head"
	item_state = "helmet"
	worn_icon = 'icons/mob/infinity_work.dmi'
	icon = 'icons/obj/clothing/infinity_work.dmi'
	flags = STOPSPRESSUREDMAGE|BLOCKHAIR|THICKMATERIAL
	max_heat_protection_temperature = SPACE_HELM_MAX_TEMP_PROTECT
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	armor = list(melee = 25, bullet = 25, laser = 30,energy = 25, bomb = 10, bio = 15, rad = 15)