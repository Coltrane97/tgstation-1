/mob/living/carbon/human/examine(mob/user)
//this is very slightly better than it was because you can use it more places. still can't do \his[src] though.
	var/t_He = p_they(TRUE)
	var/t_His = p_their(TRUE)
	var/t_his = p_their()
	var/t_him = p_them()
	var/t_has = p_have()
	var/t_is = p_are()
	// ������� ���������! ~bear1ake
	var/e_1	= p_e_1()
	var/e_2	= p_e_2()
	var/e_3	= p_e_3()
	var/e_4	= p_e_4()
	var/e_5 = p_e_5()
	var/obscure_name

	if(isliving(user))
		var/mob/living/L = user
		if(L.has_trait(TRAIT_PROSOPAGNOSIA))
			obscure_name = TRUE

	var/msg = "<span class='info'>*---------*\n��� is <EM>[!obscure_name ? name : "Unknown"]</EM>!\n"

	var/list/obscured = check_obscured_slots()
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))

	//uniform
	if(w_uniform && !(slot_w_uniform in obscured))
		//accessory
		var/accessory_msg
		if(istype(w_uniform, /obj/item/clothing/under))
			var/obj/item/clothing/under/U = w_uniform
			if(U.attached_accessory)
				accessory_msg += " c [icon2html(U.attached_accessory, user)] \a [U.attached_accessory]"

		msg += "[t_He] ����� [w_uniform.get_examine_string(user)][accessory_msg].\n"
	//head
	if(head)
		msg += "[t_He] ����� [head.get_examine_string(user)] on [t_his] head.\n"
	//suit/armor
	if(wear_suit)
		msg += "[t_He] ����� [wear_suit.get_examine_string(user)].\n"
		//suit/armor storage
		if(s_store)
			msg += "[t_He] ����� [s_store.get_examine_string(user)] on [t_his] [wear_suit.name].\n"
	//back
	if(back)
		msg += "[t_He] ����� [back.get_examine_string(user)] on [t_his] back.\n"

	//Hands
	for(var/obj/item/I in held_items)
		if(!(I.flags_1 & ABSTRACT_1))
			msg += "[t_He] ������ [I.get_examine_string(user)] in [t_his] [get_held_index_name(get_held_index_of_item(I))].\n"

	GET_COMPONENT(FR, /datum/component/forensics)
	//gloves
	if(gloves && !(slot_gloves in obscured))
		msg += "[t_He] ����� [gloves.get_examine_string(user)] on [t_his] hands.\n"
	else if(FR && length(FR.blood_DNA))
		var/hand_number = get_num_arms()
		if(hand_number)
			msg += "<span class='warning'>[t_him] ���[hand_number > 1 ? "�" : "�"] � �����!</span>\n"

	//handcuffed?

	//handcuffed?
	if(handcuffed)
		if(istype(handcuffed, /obj/item/restraints/handcuffs/cable))
			msg += "<span class='warning'>[t_He] [icon2html(handcuffed, user)] ��&#255;��� � ������� �����&#255;</span>\n"
		else
			msg += "<span class='warning'>[t_He] [icon2html(handcuffed, user)] � ����������!</span>\n"

	//belt
	if(belt)
		msg += "[t_He] ����� [belt.get_examine_string(user)] about [t_his] waist.\n"

	//shoes
	if(shoes && !(slot_shoes in obscured))
		msg += "[t_He] ����� wearing [shoes.get_examine_string(user)] on [t_his] feet.\n"

	//mask
	if(wear_mask && !(slot_wear_mask in obscured))
		msg += "[t_He] ����� [wear_mask.get_examine_string(user)] on [t_his] face.\n"

	if (wear_neck && !(slot_neck in obscured))
		msg += "[t_He] ����� [wear_neck.get_examine_string(user)] around [t_his] neck.\n"

	//eyes
	if(glasses && !(slot_glasses in obscured))
		msg += "[t_He] ����� [glasses.get_examine_string(user)] covering [t_his] eyes.\n"

	//ears
	if(ears && !(slot_ears in obscured))
		msg += "[t_He] ����� [ears.get_examine_string(user)] on [t_his] ears.\n"

	//ID
	if(wear_id)
		msg += "[t_He] ����� wearing [wear_id.get_examine_string(user)].\n"

	//Status effects
	msg += status_effect_examines()

	switch(jitteriness)
		if(300 to INFINITY)
			msg += "<span class='warning'><B>[t_He] ����� ������ ������!</B></span>\n"
		if(200 to 300)
			msg += "<span class='warning'>[t_He] ������ ������.</span>\n"
		if(100 to 200)
			msg += "<span class='warning'>[t_He] ����-���� ����������c&#255;.</span>\n"


	var/appears_dead = 0
	if(stat == DEAD || (has_trait(TRAIT_FAKEDEATH)))
		appears_dead = 1
		if(suiciding)
			msg += "<span class='warning'>[t_He], ������&#255;, ��������[e_1] ������������. �������� ����������.</span>\n"
		if(hellbound)
			msg += "<span class='warning'>[t_His] soul seems to have been ripped out of [t_his] body.  Revival is impossible.</span>\n"
		msg += "<span class='deadsay'>[t_He] ������[e_3] � �������������[e_2]; [t_He] �� ����� ��������� �����"
		if(getorgan(/obj/item/organ/brain))
			if(!key)
				var/foundghost = 0
				if(mind)
					for(var/mob/dead/observer/G in GLOB.player_list)
						if(G.mind == mind)
							foundghost = 1
							if (G.can_reenter_corpse == 0)
								foundghost = 0
							break
				if(!foundghost)
					msg += " � [t_his] ���� ������"
		msg += "...</span>\n"

	if(get_bodypart(BODY_ZONE_HEAD) && !getorgan(/obj/item/organ/brain))
		msg += "<span class='deadsay'>������&#255;, [t_his] ���� ������...</span>\n"

	var/temp = getBruteLoss() //no need to calculate each of these twice

	msg += "<span class='warning'>"

	var/list/missing = list(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		missing -= BP.body_zone
		for(var/obj/item/I in BP.embedded_objects)
			msg += "<B>[t_He] [t_has] [icon2html(I, user)] [I], �����&#255;���� � [t_his] [BP.name]!</B>\n"

	//stores missing limbs
	var/l_limbs_missing = 0
	var/r_limbs_missing = 0
	for(var/t in missing)
		if(t==BODY_ZONE_HEAD)
			msg += "<span class='deadsay'><B>[t_His] [parse_zone(t)] is missing!</B><span class='warning'>\n"
			continue
		if(t == BODY_ZONE_L_ARM || t == BODY_ZONE_L_LEG)
			l_limbs_missing++
		else if(t == BODY_ZONE_R_ARM || t == BODY_ZONE_R_LEG)
			r_limbs_missing++

		msg += "<B>[capitalize(t_his)] [parse_zone(t)] �����������!!</B>\n"

	var/rus_verb = ""
	switch(gender)
		if(MALE)
			rus_verb = "���"
		if(FEMALE)
			rus_verb = "����"
		if(PLURAL || NEUTER)
			rus_verb = "����"

	if(l_limbs_missing >= 2 && r_limbs_missing == 0)
		msg += "[t_He] [rus_verb]"
//	else if(l_limbs_missing || r_limbs_missing)
	//	msg += "[capitalize(t_him)] ����-�� �� �������..."

	if(!(user == src && src.hal_screwyhud == SCREWYHUD_HEALTHY)) //fake healthy
		if(temp)
			if(temp < 25)
				msg += "[t_He] [t_has] minor bruising.\n"
			else if(temp < 50)
				msg += "[t_He] [t_has] <b>moderate</b> bruising!\n"
			else
				msg += "<B>[t_He] [t_has] severe bruising!</B>\n"

		temp = getFireLoss()
		if(temp)
			if(temp < 25)
				msg += "[t_He] [t_has] minor burns.\n"
			else if (temp < 50)
				msg += "[t_He] [t_has] <b>moderate</b> burns!\n"
			else
				msg += "<B>[t_He] [t_has] severe burns!</B>\n"

		temp = getCloneLoss()
		if(temp)
			if(temp < 25)
				msg += "[t_He] [t_has] minor cellular damage.\n"
			else if(temp < 50)
				msg += "[t_He] [t_has] <b>moderate</b> cellular damage!\n"
			else
				msg += "<b>[t_He] [t_has] severe cellular damage!</b>\n"


	if(fire_stacks > 0)
		msg += "[t_He] � ���-�� �����������.\n"
	if(fire_stacks < 0)
		msg += "[t_He] ����&#255;��� ������� �������[e_4].\n"


	if(pulledby && pulledby.grab_state)
		msg += "[t_his] ���������� [pulledby].\n"

	if(nutrition < NUTRITION_LEVEL_STARVING - 50)
		msg += "[t_He] ������ ���������!\n"
	else if(nutrition >= NUTRITION_LEVEL_FAT)
		if(user.nutrition < NUTRITION_LEVEL_STARVING - 50)
			msg += "[t_He] ����[e_2] � ������ ����&#255;�� - ��� ������&#255; ��������&#255; ������, ������&#255; ������.\n"
		else
			msg += "[t_He] ������� ��������[e_1].\n"
	switch(disgust)
		if(DISGUST_LEVEL_GROSS to DISGUST_LEVEL_VERYGROSS)
			msg += "[t_He] look[p_s()] a bit grossed out.\n"
		if(DISGUST_LEVEL_VERYGROSS to DISGUST_LEVEL_DISGUSTED)
			msg += "[t_He] look[p_s()] really grossed out.\n"
		if(DISGUST_LEVEL_DISGUSTED to INFINITY)
			msg += "[t_He] look[p_s()] extremely disgusted.\n"

	if(blood_volume < BLOOD_VOLUME_SAFE)
		msg += "[t_He] ���������[e_1].\n"

	if(bleedsuppress)
		msg += "[t_He] �����&#255;���[e_1] ���-��.\n"
	else if(bleed_rate)
		if(reagents.has_reagent("heparin"))
			msg += "<b>[t_He] ������� ����������!</b>\n"
		else
			msg += "<B>[t_He] ����������!</B>\n"

	if(reagents.has_reagent("teslium"))
		msg += "[t_He] ��������� ������ ������� ��������!\n"

	if(islist(stun_absorption))
		for(var/i in stun_absorption)
			if(stun_absorption[i]["end_time"] > world.time && stun_absorption[i]["examine_message"])
				msg += "[t_He] [t_is][stun_absorption[i]["examine_message"]]\n"

	if(drunkenness && !skipface && !appears_dead) //Drunkenness
		switch(drunkenness)
			if(11 to 21)
				msg += "[t_He] �������� ��&#255;�[e_1].\n"
			if(21.01 to 41) //.01s are used in case drunkenness ends up to be a small decimal
				msg += "[t_He] ������� ��&#255;�[e_1].\n"
			if(41.01 to 51)
				msg += "[t_He] ��&#255;�[e_1] � �[t_his] ������� ������ ��������.\n"
			if(51.01 to 61)
				msg += "[t_He] ������ ��&#255;�[e_1] � [t_his] �������&#255; ��&#255;���, [t_his] ������� ������ ������ ���������.\n"
			if(61.01 to 91)
				msg += "[t_He] �����[e_5] � ����.\n"
			if(91.01 to INFINITY)
				msg += "[t_He] ��������� ��&#255;�[e_1], ��� ��� ����� �� �����. �������� [t_him]!\n"

	msg += "</span>"

	if(!appears_dead)
		if(stat == UNCONSCIOUS)
			msg += "[t_He] [t_is]n't responding to anything around [t_him] and seem[p_s()] to be asleep.\n"
		else
			if(has_trait(TRAIT_DUMB))
				msg += "[t_He] [t_has] a stupid expression on [t_his] face.\n"
			if(InCritical())
				msg += "[t_He] [t_is] barely conscious.\n"
		if(getorgan(/obj/item/organ/brain))
			if(!key)
				msg += "<span class='deadsay'>[t_He] �������� ����������. ������� ����� � �������� ������� �������� [t_his]. �������� ��&#255;� �� �������.</span>\n"
			else if(!client)
				msg += "[t_He] � ������. �������� ����� �������� ����&#255; [t_He] �����&#255;...\n"

		if(digitalcamo)
			msg += "[t_He] ������� ����� ����� ������ � �������������� �������.\n"

	temp = getFireLoss() + getBruteLoss()
	if(!skipface && temp<80 && !has_trait(TRAIT_HUSK))
		if(visual_age < AGE_MAX-10)
			msg += "[t_He] ����&#255;��� �� [visual_age-2]-[visual_age+2] ���.\n"
		else
			msg += "�� �� ������ ���������� [t_his] �������.\n"

	var/traitstring = get_trait_string()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		var/obj/item/organ/cyberimp/eyes/hud/CIH = H.getorgan(/obj/item/organ/cyberimp/eyes/hud)
		if(istype(H.glasses, /obj/item/clothing/glasses/hud) || CIH)
			var/perpname = get_face_name(get_id_name(""))
			if(perpname)
				var/datum/data/record/R = find_record("name", perpname, GLOB.data_core.general)
				if(R)
					msg += "<span class='deptradio'>Rank:</span> [R.fields["rank"]]<br>"
					msg += "<a href='?src=[REF(src)];hud=1;photo_front=1'>\[Front photo\]</a> "
					msg += "<a href='?src=[REF(src)];hud=1;photo_side=1'>\[Side photo\]</a><br>"
				if(istype(H.glasses, /obj/item/clothing/glasses/hud/health) || istype(CIH, /obj/item/organ/cyberimp/eyes/hud/medical))
					var/cyberimp_detect
					for(var/obj/item/organ/cyberimp/CI in internal_organs)
						if(CI.status == ORGAN_ROBOTIC && !CI.syndicate_implant)
							cyberimp_detect += "[name] is modified with a [CI.name].<br>"
					if(cyberimp_detect)
						msg += "Detected cybernetic modifications:<br>"
						msg += cyberimp_detect
					if(R)
						var/health_r = R.fields["p_stat"]
						msg += "<a href='?src=[REF(src)];hud=m;p_stat=1'>\[[health_r]\]</a>"
						health_r = R.fields["m_stat"]
						msg += "<a href='?src=[REF(src)];hud=m;m_stat=1'>\[[health_r]\]</a><br>"
					R = find_record("name", perpname, GLOB.data_core.medical)
					if(R)
						msg += "<a href='?src=[REF(src)];hud=m;evaluation=1'>\[Medical evaluation\]</a><br>"
					if(traitstring)
						msg += "<span class='info'>Detected physiological traits:<br></span>"
						msg += "<span class='info'>[traitstring]</span><br>"



				if(istype(H.glasses, /obj/item/clothing/glasses/hud/security) || istype(CIH, /obj/item/organ/cyberimp/eyes/hud/security))
					if(!user.stat && user != src)
					//|| !user.canmove || user.restrained()) Fluff: Sechuds have eye-tracking technology and sets 'arrest' to people that the wearer looks and blinks at.
						var/criminal = "None"

						R = find_record("name", perpname, GLOB.data_core.security)
						if(R)
							criminal = R.fields["criminal"]

						msg += "<span class='deptradio'>Criminal status:</span> <a href='?src=[REF(src)];hud=s;status=1'>\[[criminal]\]</a>\n"
						msg += "<span class='deptradio'>Security record:</span> <a href='?src=[REF(src)];hud=s;view=1'>\[View\]</a> "
						msg += "<a href='?src=[REF(src)];hud=s;add_crime=1'>\[Add crime\]</a> "
						msg += "<a href='?src=[REF(src)];hud=s;view_comment=1'>\[View comment log\]</a> "
						msg += "<a href='?src=[REF(src)];hud=s;add_comment=1'>\[Add comment\]</a>\n"
	else if(isobserver(user) && traitstring)
		msg += "<span class='info'><b>Traits:</b> [traitstring]</span><br>"

	if(print_flavor_text())
		msg += "[print_flavor_text()]\n"

	msg += "*---------*</span>"

	to_chat(user, msg)

/mob/living/proc/status_effect_examines(pronoun_replacement) //You can include this in any mob's examine() to show the examine texts of status effects!
	var/list/dat = list()
	if(!pronoun_replacement)
		pronoun_replacement = p_they(TRUE)
	for(var/V in status_effects)
		var/datum/status_effect/E = V
		if(E.examine_text)
			var/new_text = replacetext(E.examine_text, "SUBJECTPRONOUN", pronoun_replacement)
			new_text = replacetext(new_text, "[pronoun_replacement] is", "[pronoun_replacement] [p_are()]") //To make sure something become "They are" or "She is", not "They are" and "She are"
			dat += "[new_text]\n" //dat.Join("\n") doesn't work here, for some reason
	if(dat.len)
		return dat.Join()
