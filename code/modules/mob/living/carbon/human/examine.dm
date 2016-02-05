/mob/living/carbon/human/examine(mob/user)

	var/list/obscured = check_obscured_slots()
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))

	// crappy hacks because you can't do \his[src] etc. I'm sorry this proc is so unreadable, blame the text macros :<
	var/t_He = "It" //capitalised for use at the start of each line.
	var/t_his = "its"
	var/t_him = "it"
	var/t_has = "has"
	var/t_is = "is"

	var/msg = "<span class='info'>*---------*\n��� "

	if( (slot_w_uniform in obscured) && skipface ) //big suits/masks/helmets make it hard to tell their gender
		t_He = "��"
		t_his = "Ÿ"
		t_him = "��"
		t_has = "�����"
		t_is = "���"
	else
		switch(gender)
			if(MALE)
				t_He = "��"
				t_his = "���"
				t_him = "���"
			if(FEMALE)
				t_He = "���"
				t_his = "�"
				t_him = "�"

	msg += "<EM>[src.name]</EM>!\n"

	//uniform
	if(w_uniform && !(slot_w_uniform in obscured))
		//Ties
		var/tie_msg
		if(istype(w_uniform,/obj/item/clothing/under))
			var/obj/item/clothing/under/U = w_uniform
			if(U.hastie)
				tie_msg += " with \icon[U.hastie] \a [U.hastie]"

		if(w_uniform.blood_DNA)
			msg += "<span class='warning'>[t_He] ����� \icon[w_uniform] [w_uniform.gender==PLURAL?"some":"a"] ������������ [w_uniform.name][tie_msg]!</span>\n"
		else
			msg += "[t_He] ����� \icon[w_uniform] \ [w_uniform][tie_msg].\n"

	//head
	if(head)
		if(head.blood_DNA)
			msg += "<span class='warning'>[t_He] ����� \icon[head] [head.gender==PLURAL?"some":"a"] ������������ [head.name] �� ������!</span>\n"
		else
			msg += "[t_He] ����� \icon[head] \a [head]\n"

	//suit/armor
	if(wear_suit)
		if(wear_suit.blood_DNA)
			msg += "<span class='warning'>[t_He] ����� \icon[wear_suit] [wear_suit.gender==PLURAL?"some":"a"] ������������� [wear_suit.name]!</span>\n"
		else
			msg += "[t_He] ����� \icon[wear_suit] \a [wear_suit].\n"

		//suit/armor storage
		if(s_store)
			if(s_store.blood_DNA)
				msg += "<span class='warning'>[t_He] ����� \icon[s_store] [s_store.gender==PLURAL?"some":"a"] ������������ [s_store.name] �� [wear_suit.name]!</span>\n"
			else
				msg += "[t_He] ����� \icon[s_store] \a [s_store] �� [wear_suit.name].\n"

	//back
	if(back)
		if(back.blood_DNA)
			msg += "<span class='warning'>[t_He] ����� \icon[back] [back.gender==PLURAL?"some":"a"] ������������ [back] �� �����.</span>\n"
		else
			msg += "[t_He] ����� \icon[back] \ [back] �� �����.\n"

	//left hand
	if(l_hand && !(l_hand.flags&ABSTRACT))
		if(l_hand.blood_DNA)
			msg += "<span class='warning'>[t_He] ������ \icon[l_hand] [l_hand.gender==PLURAL?"some":"a"] ������������ [l_hand.name] � ����� ����!</span>\n"
		else
			msg += "[t_He] ������ \icon[l_hand] \ [l_hand] � ����� ����.\n"

	//������ ����
	if(r_hand && !(r_hand.flags&ABSTRACT))
		if(r_hand.blood_DNA)
			msg += "<span class='warning'>[t_He] ������ \icon[r_hand] [r_hand.gender==PLURAL?"some":"a"] ������������ [r_hand.name] � ������ ����!</span>\n"
		else
			msg += "[t_He] ������ \icon[r_hand] \a [r_hand] � ������ ����.\n"

	//gloves
	if(gloves && !(slot_gloves in obscured))
		if(gloves.blood_DNA)
			msg += "<span class='warning'>[t_He] �����\icon[gloves] [gloves.gender==PLURAL?"some":"a"] ������������ [gloves.name]</span>\n"
		else
			msg += "[t_He] ����� \icon[gloves] \ [gloves] \n"
	else if(blood_DNA)
		msg += "<span class='warning'>[t_him] ���� � ����� </span>\n"

	//handcuffed?

	//handcuffed?
	if(handcuffed)
		if(istype(handcuffed, /obj/item/weapon/restraints/handcuffs/cable))
			msg += "<span class='warning'>[t_He] \icon[handcuffed] ������ � ������� ������</span>\n"
		else
			msg += "<span class='warning'>[t_He] \icon[handcuffed] � ����������!</span>\n"

	//belt
	if(belt)
		if(belt.blood_DNA)
			msg += "<span class='warning'>[t_He] ����� \icon[belt] [belt.gender==PLURAL?"some":"a"] ������������ [belt.name]</span>\n"
		else
			msg += "[t_He] ����� \icon[belt] \ [belt]\n"

	//shoes
	if(shoes && !(slot_shoes in obscured))
		if(shoes.blood_DNA)
			msg += "<span class='warning'>[t_He] ����� \icon[shoes] [shoes.gender==PLURAL?"some":"a"] ������������ [shoes.name]</span>\n"
		else
			msg += "[t_He] ����� \icon[shoes] \ [shoes]\n"

	//mask
	if(wear_mask && !(slot_wear_mask in obscured))
		if(wear_mask.blood_DNA)
			msg += "<span class='warning'>[t_He] �����\icon[wear_mask] [wear_mask.gender==PLURAL?"some":"a"] ������������ [wear_mask.name] </span>\n"
		else
			msg += "[t_He] �����\icon[wear_mask] \ [wear_mask]\n"

	//eyes
	if(glasses && !(slot_glasses in obscured))
		if(glasses.blood_DNA)
			msg += "<span class='warning'>[t_He] �����\icon[glasses] [glasses.gender==PLURAL?"some":"a"] ������������ [glasses]</span>\n"
		else
			msg += "[t_He] ����� \icon[glasses] \ [glasses]\n"

	//ears
	if(ears && !(slot_ears in obscured))
		msg += "[t_He] ����� �� ���  \icon[ears] \ [ears] \n"

	//ID
	if(wear_id)
		/*var/id
		if(istype(wear_id, /obj/item/device/pda))
			var/obj/item/device/pda/pda = wear_id
			id = pda.owner
		else if(istype(wear_id, /obj/item/weapon/card/id)) //just in case something other than a PDA/ID card somehow gets in the ID slot :[
			var/obj/item/weapon/card/id/idcard = wear_id
			id = idcard.registered_name
		if(id && (id != real_name) && (get_dist(src, user) <= 1) && prob(10))
			msg += "<span class='warning'>[t_He] [t_is] wearing \icon[wear_id] \a [wear_id] yet something doesn't seem right...</span>\n"
		else*/
		msg += "[t_He] �����  \icon[wear_id] \ [wear_id].\n"
	//Jitters


	switch(jitteriness)
		if(300 to INFINITY)
			msg += "<span class='warning'><B>[t_He] [t_is] convulsing violently!</B></span>\n"
		if(200 to 300)
			msg += "<span class='warning'>[t_He] [t_is] extremely jittery.</span>\n"
		if(100 to 200)
			msg += "<span class='warning'>[t_He] [t_is] twitching ever so slightly.</span>\n"



	if(gender_ambiguous) //someone fucked up a gender reassignment surgery
		if (gender == MALE)
			msg += "[t_He] has a strange feminine quality to [t_him].\n"
		else
			msg += "[t_He] has a strange masculine quality to [t_him].\n"

	var/appears_dead = 0
	if(stat == DEAD || (status_flags & FAKEDEATH))
		appears_dead = 1
		if(getorgan(/obj/item/organ/internal/brain))//Only perform these checks if there is no brain
			if(suiciding)
				msg += "<span class='warning'>[t_He] appears to have commited suicide... there is no hope of recovery.</span>\n"
			msg += "<span class='deadsay'>[t_He] [t_is] limp and unresponsive; there are no signs of life"
			if(!key)
				var/foundghost = 0
				if(mind)
					for(var/mob/dead/observer/G in player_list)
						if(G.mind == mind)
							foundghost = 1
							if (G.can_reenter_corpse == 0)
								foundghost = 0
							break
				if(!foundghost)
					msg += " and [t_his] soul has departed"
			msg += "...</span>\n"
		else//Brain is gone, doesn't matter if they are AFK or present
			msg += "<span class='deadsay'>It appears that [t_his] brain is missing...</span>\n"

	var/temp = getBruteLoss() //no need to calculate each of these twice

	msg += "<span class='warning'>"

	if(temp)
		if(temp < 30)
			msg += "[t_He] [t_has] minor bruising.\n"
		else
			msg += "<B>[t_He] [t_has] severe bruising!</B>\n"

	temp = getFireLoss()
	if(temp)
		if(temp < 30)
			msg += "[t_He] [t_has] minor burns.\n"
		else
			msg += "<B>[t_He] [t_has] severe burns!</B>\n"

	temp = getCloneLoss()
	if(temp)
		if(temp < 30)
			msg += "[t_He] [t_has] minor cellular damage.\n"
		else
			msg += "<B>[t_He] [t_has] severe cellular damage.</B>\n"


	for(var/obj/item/organ/limb/L in organs)
		for(var/obj/item/I in L.embedded_objects)
			msg += "<B>[t_He] [t_has] \a \icon[I] [I] embedded in [t_his] [L.getDisplayName()]!</B>\n"


	if(fire_stacks > 0)
		msg += "[t_He] [t_is] covered in something flammable.\n"
	if(fire_stacks < 0)
		msg += "[t_He] looks a little soaked.\n"


	if(nutrition < NUTRITION_LEVEL_STARVING - 50)
		msg += "[t_He] [t_is] severely malnourished.\n"
	else if(nutrition >= NUTRITION_LEVEL_FAT)
		if(user.nutrition < NUTRITION_LEVEL_STARVING - 50)
			msg += "[t_He] [t_is] plump and delicious looking - Like a fat little piggy. A tasty piggy.\n"
		else
			msg += "[t_He] [t_is] quite chubby.\n"

	if(pale)
		msg += "[t_He] [t_has] pale skin.\n"

	if(bleedsuppress)
		msg += "[t_He] [t_is] bandaged with something.\n"
	if(blood_max)
		if(reagents.has_reagent("heparin"))
			msg += "<b>[t_He] [t_is] bleeding uncontrollably!</b>\n"
		else
			msg += "<B>[t_He] [t_is] bleeding!</B>\n"

	if(reagents.has_reagent("teslium"))
		msg += "[t_He] is emitting a gentle blue glow!\n"

	msg += "</span>"

	if(!appears_dead)
		if(stat == UNCONSCIOUS)
			msg += "[t_He] [t_is]n't responding to anything around [t_him] and seems to be asleep.\n"
		else if(getBrainLoss() >= 60)
			msg += "[t_He] [t_has] a stupid expression on [t_his] face.\n"

		if(getorgan(/obj/item/organ/internal/brain))
			if(istype(src,/mob/living/carbon/human/interactive))
				msg += "<span class='deadsay'>[t_He] [t_is] appears to be some sort of sick automaton, [t_his] eyes are glazed over and [t_his] mouth is slightly agape.</span>\n"
			else if(!key)
				msg += "<span class='deadsay'>[t_He] [t_is] totally catatonic. The stresses of life in deep-space must have been too much for [t_him]. Any recovery is unlikely.</span>\n"
			else if(!client)
				msg += "[t_He] [t_has] a vacant, braindead stare...\n"

		if(digitalcamo)
			msg += "[t_He] [t_is] moving [t_his] body in an unnatural and blatantly inhuman manner.\n"

	if(!skipface && is_thrall(src) && in_range(user,src))
		msg += "Their features seem unnaturally tight and drawn.\n"

	switch(age)
		if(15 to 19)
			msg += "����&#255;��� �� 15-19 ���. \n"
		if(20 to 29)
			msg += "����&#255;��� �� 20-29 ���. \n"
		if(30 to 40)
			msg += "����&#255;��� �� 30-40 ���. \n"
		if(41 to 50)
			msg += "����&#255;��� �� 41-50 ���. \n"
		if(51 to 65)
			msg += "����&#255;��� �� 51-65 ���. \n"
		if(66 to 80)
			msg += "����&#255;��� �� 66-80 ���. \n"
		if(81 to INFINITY)
			msg += "��� ������� �������, ������� �������� �� �� ������ ����������. \n"

	if(istype(user, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = user
		var/obj/item/organ/internal/cyberimp/eyes/hud/CIH = H.getorgan(/obj/item/organ/internal/cyberimp/eyes/hud)
		if(istype(H.glasses, /obj/item/clothing/glasses/hud) || CIH)
			var/perpname = get_face_name(get_id_name(""))
			if(perpname)
				var/datum/data/record/R = find_record("name", perpname, data_core.general)
				if(R)
					msg += "<span class='deptradio'>Rank:</span> [R.fields["rank"]]<br>"
					msg += "<a href='?src=\ref[src];hud=1;photo_front=1'>\[Front photo\]</a> "
					msg += "<a href='?src=\ref[src];hud=1;photo_side=1'>\[Side photo\]</a><br>"
				if(istype(H.glasses, /obj/item/clothing/glasses/hud/health) || istype(CIH,/obj/item/organ/internal/cyberimp/eyes/hud/medical))
					var/implant_detect
					for(var/obj/item/organ/internal/cyberimp/CI in internal_organs)
						if(CI.status == ORGAN_ROBOTIC)
							implant_detect += "[name] is modified with a [CI.name].<br>"
					if(implant_detect)
						msg += "Detected cybernetic modifications:<br>"
						msg += implant_detect
					if(R)
						var/health = R.fields["p_stat"]
						msg += "<a href='?src=\ref[src];hud=m;p_stat=1'>\[[health]\]</a>"
						health = R.fields["m_stat"]
						msg += "<a href='?src=\ref[src];hud=m;m_stat=1'>\[[health]\]</a><br>"
					R = find_record("name", perpname, data_core.medical)
					if(R)
						msg += "<a href='?src=\ref[src];hud=m;evaluation=1'>\[Medical evaluation\]</a><br>"


				if(istype(H.glasses, /obj/item/clothing/glasses/hud/security) || istype(CIH,/obj/item/organ/internal/cyberimp/eyes/hud/security))
					if(!user.stat && user != src)
					//|| !user.canmove || user.restrained()) Fluff: Sechuds have eye-tracking technology and sets 'arrest' to people that the wearer looks and blinks at.
						var/criminal = "None"

						R = find_record("name", perpname, data_core.security)
						if(R)
							criminal = R.fields["criminal"]

						msg += "<span class='deptradio'>Criminal status:</span> <a href='?src=\ref[src];hud=s;status=1'>\[[criminal]\]</a>\n"
						msg += "<span class='deptradio'>Security record:</span> <a href='?src=\ref[src];hud=s;view=1'>\[View\]</a> "
						msg += "<a href='?src=\ref[src];hud=s;add_crime=1'>\[Add crime\]</a> "
						msg += "<a href='?src=\ref[src];hud=s;view_comment=1'>\[View comment log\]</a> "
						msg += "<a href='?src=\ref[src];hud=s;add_comment=1'>\[Add comment\]</a>\n"




	if(print_flavor_text()) msg += "[print_flavor_text()]\n"

	msg += "*---------*</span>"

	user << msg
