//Koala
/mob/living/simple_animal/pet/koala
	name = "space koala"
	desc = "A little grey bear, now much time he gonna sleep today?"
	icon = 'icons/mob/infinity_mob.dmi'
	icon_state = "koala"
	icon_living = "koala"
	icon_dead = "koala_dead"
	maxHealth = 45
	health = 45
	speed = 10
	speak = list("Rrr", "Wraarh...", "Pfrrr...")
	speak_emote = list("roar")
	emote_hear = list("grunting.","rustling.", "slowly yawns.")
	emote_see = list("slowly turns around his head.", "rises to his feet, and lays to the ground on all fours.")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 3)
	response_help = "pets"
	response_disarm = "gently pushes aside"
	response_harm = "kicks"
	gold_core_spawnable = 2
	stop_automated_movement_when_pulled = 1

//Haradrim, the koala :D
/mob/living/simple_animal/pet/koala/haradrim
	name = "Harri"
	desc = "Lovable koala, named by man who love eucalyptus."
	gender = MALE
	unsuitable_atmos_damage = 2
	gold_core_spawnable = 0
	ventcrawler = 2