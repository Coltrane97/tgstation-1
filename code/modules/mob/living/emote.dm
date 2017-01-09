//The code execution of the emote datum is located at code/datums/emotes.dm
/mob/living/emote(act, m_type = null, message = null)
	act = lowertext(act)
	var/param = message
	var/custom_param = findchar(act, " ")
	if(custom_param)
		param = copytext(act, custom_param + 1, length(act) + 1)
		act = copytext(act, 1, custom_param)

	var/datum/emote/E = emote_list[act]
	if(!E)
		src << "<span class='notice'>Unusable emote '[act]'. Say *help for a list.</span>"
		return
	E.run_emote(src, param, m_type)

/* EMOTE DATUMS */
/datum/emote/living
	mob_type_allowed_typecache = list(/mob/living)
	mob_type_blacklist_typecache = list(/mob/living/simple_animal/slime, /mob/living/brain)

/datum/emote/living/blush
	key = "blush"
	key_third_person = "blushes"
	message = "��������."

/datum/emote/living/bow
	key = "bow"
	key_third_person = "bows"
	message = "bows."
	message_param = "��������� %t."

/datum/emote/living/burp
	key = "burp"
	key_third_person = "burps"
	message = "������."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/choke
	key = "choke"
	key_third_person = "chokes"
	message = "�������!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/cross
	key = "cross"
	key_third_person = "crosses"
	if(gender == FEMALE)
		message = "��������� ���� � ���� �� �����."
	else
		message = "�������� ���� � ���� �� �����."
	restraint_check = TRUE

/datum/emote/living/chuckle
	key = "chuckle"
	key_third_person = "chuckles"
	message = "��������."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/collapse
	key = "collapse"
	key_third_person = "collapses"
	if(gender == FEMALE)
		message = "�����!"
	else
		message = "����!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/collapse/run_emote(mob/user, params)
	. = ..()
	if(.)
		user.Paralyse(2)

/datum/emote/living/cough
	key = "cough"
	key_third_person = "coughs"
	message = "�������!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/dance
	key = "dance"
	key_third_person = "dances"
	message = "�������."
	restraint_check = TRUE

/datum/emote/living/deathgasp
	key = "deathgasp"
	key_third_person = "deathgasps"
	message = "��������, ���������� �������������, ����� ���������� ������� � �������������..."
	message_robot = "c����� ����������� � ����� ��������� ��������� ���������������, ��� ����� �������� �������/"
	message_AI = "������, ������� ���������� �����, ������ ������� ���� ���������� ��������. ����� ������ �������."
	message_alien = "������ ��������� ������, ����� ������ �� ����� ���. ������ ������� � ���������� �������� ������� �� ��� �����."
	message_larva = "��������� ����������� �������, �������� �� ���� ������� �������, ����� ���� ��������� ��������� � ������ �� ���."
	message_monkey = "lets out a faint chimper as it collapses and stops moving..."
	stat_allowed = UNCONSCIOUS

/datum/emote/living/deathgasp/run_emote(mob/user, params)
	. = ..()
	if(. && isalienadult(user))
		playsound(user.loc, 'sound/voice/hiss6.ogg', 80, 1, 1)

/datum/emote/living/drool
	key = "drool"
	key_third_person = "drools"
	message = "����� ������."

/datum/emote/living/faint
	key = "faint"
	key_third_person = "faints"
	message = "������ � �������."

/datum/emote/living/faint/run_emote(mob/user, params)
	. = ..()
	if(.)
		user.SetSleeping(10)

/datum/emote/living/flap
	key = "flap"
	key_third_person = "flaps"
	message = "������� ������ ��������."
	var/wing_time = 20

/datum/emote/living/flap/run_emote(mob/user, params)
	. = ..()
	if(. && ishuman(user))
		var/mob/living/carbon/human/H = user
		var/open = FALSE
		if(H.dna.features["wings"] != "None")
			if("wingsopen" in H.dna.species.mutant_bodyparts)
				open = TRUE
				H.CloseWings()
			else
				H.OpenWings()
			addtimer(CALLBACK(H, open ? /mob/living/carbon/human.proc/OpenWings : /mob/living/carbon/human.proc/CloseWings), wing_time)

/datum/emote/living/flap/aflap
	key = "aflap"
	key_third_person = "aflaps"
	message = "� ������ ������� ������ ��������!"
	wing_time = 10

/datum/emote/living/flip
	key = "flip"
	key_third_person = "flips"
	restraint_check = TRUE

/datum/emote/living/flip/run_emote(mob/user, params)
	. = ..()
	if(!.)
		user.SpinAnimation(7,1)

/datum/emote/living/frown
	key = "frown"
	key_third_person = "frowns"
	message = "��������."

/datum/emote/living/gag
	key = "gag"
	key_third_person = "gags"
	message = "��������."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/gasp
	key = "gasp"
	key_third_person = "gasps"
	message = "����������!"
	emote_type = EMOTE_AUDIBLE
	stat_allowed = UNCONSCIOUS

/datum/emote/living/giggle
	key = "giggle"
	key_third_person = "giggles"
	message = "giggles."
	message_mime = "���� �������!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/glare
	key = "glare"
	key_third_person = "glares"
	message = "glares."
	message_param = "���������� ������� �� %t."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/grin
	key = "grin"
	key_third_person = "grins"
	message = "����������."

/datum/emote/living/groan
	key = "groan"
	key_third_person = "groans"
	message = "������!"
	message_mime = "������ ���, ��� ������!"

/datum/emote/living/grimace
	key = "grimace"
	key_third_person = "grimaces"
	message = "������������."

/datum/emote/living/jump
	key = "jump"
	key_third_person = "jumps"
	message = "�������!"
	restraint_check = TRUE

/datum/emote/living/kiss
	key = "kiss"
	key_third_person = "kisses"
	message = "�������� ��������� �������."
	message_param = "�������� ��������� ������� %t."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/laugh
	key = "laugh"
	key_third_person = "laughs"
	message = "�������."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/look
	key = "look"
	key_third_person = "looks"
	message = "�������."
	message_param = "������� �� %t."

/datum/emote/living/nod
	key = "nod"
	key_third_person = "nods"
	message = "������."
	message_param = "������ %t."

/datum/emote/living/point
	key = "point"
	key_third_person = "points"
	message = "���������."
	message_param = "��������� �� %t."
	restraint_check = TRUE

/datum/emote/living/pout
	key = "pout"
	key_third_person = "pouts"
	message = "����� ����."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/scream
	key = "scream"
	key_third_person = "screams"
	message = "������."
	message_mime = "������ ���, ��� ������!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/scowl
	key = "scowl"
	key_third_person = "scowls"
	message = "��������."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/shake
	key = "shake"
	key_third_person = "shakes"
	message = "������ �������."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/sigh
	key = "sigh"
	key_third_person = "sighs"
	message = "��������."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/sit
	key = "sit"
	key_third_person = "sits"
	message = "�������."

/datum/emote/living/smile
	key = "smile"
	key_third_person = "smiles"
	message = "���������."

/datum/emote/living/sneeze
	key = "sneeze"
	key_third_person = "sneezes"
	message = "������."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/smug
	key = "smug"
	key_third_person = "smugs"
	message = "������������ ����������."

/datum/emote/living/sniff
	key = "sniff"
	key_third_person = "sniffs"
	message = "�����."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/snore
	key = "snore"
	key_third_person = "snores"
	message = "������."
	message_mime = "������ ����."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/stare
	key = "stare"
	key_third_person = "stares"
	message = "���������."
	message_param = "��������� �� %t."

/datum/emote/living/strech
	key = "stretch"
	key_third_person = "stretches"
	message = "��������� ���� ����."

/datum/emote/living/sulk
	key = "sulk"
	key_third_person = "sulks"
	message = "�������."

/datum/emote/living/surrender
	key = "surrender"
	key_third_person = "surrenders"
	message = "������ ���� �� ������ � �������� ������� �� ���!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/surrender/run_emote(mob/user, params)
	. = ..()
	if(.)
		user.Weaken(20)

/datum/emote/living/sway
	key = "sway"
	key_third_person = "sways"
	message = "������������"

/datum/emote/living/tremble
	key = "tremble"
	key_third_person = "trembles"
	message = "�������� � ������!"

/datum/emote/living/twitch
	key = "twitch"
	key_third_person = "twitches"
	message = "���������."

/datum/emote/living/twitch_s
	key = "twitch_s"
	message = "twitches."

/datum/emote/living/wave
	key = "wave"
	key_third_person = "waves"
	message = "�����."

/datum/emote/living/whimper
	key = "whimper"
	key_third_person = "whimpers"
	message = "������."
	message_mime = "��� ���� ���������� ��������, � �� ���� ������ ������������ �����."

/datum/emote/living/wsmile
	key = "wsmile"
	key_third_person = "wsmiles"
	message = "����� ���������."

/datum/emote/living/yawn
	key = "yawn"
	key_third_person = "yawns"
	message = "������."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/custom
	key = "me"
	key_third_person = "custom"
	message = null

/datum/emote/living/custom/proc/check_invalid(mob/user, input)
	. = TRUE
	if(copytext(input,1,5) == "says")
		user << "<span class='danger'>Invalid emote.</span>"
	else if(copytext(input,1,9) == "exclaims")
		user << "<span class='danger'>Invalid emote.</span>"
	else if(copytext(input,1,6) == "yells")
		user << "<span class='danger'>Invalid emote.</span>"
	else if(copytext(input,1,5) == "asks")
		user << "<span class='danger'>Invalid emote.</span>"
	else
		. = FALSE

/datum/emote/living/custom/run_emote(mob/user, params, type_override = null)
	if(jobban_isbanned(user, "emote"))
		user << "You cannot send custom emotes (banned)."
		return FALSE
	else if(user.client && user.client.prefs.muted & MUTE_IC)
		user << "You cannot send IC messages (muted)."
		return FALSE
	else if(!params)
		var/custom_emote = copytext(sanitize(input("Choose an emote to display.") as text|null), 1, MAX_MESSAGE_LEN)
		if(custom_emote && !check_invalid(user, custom_emote))
			var/type = input("Is this a visible or hearable emote?") as null|anything in list("Visible", "Hearable")
			switch(type)
				if("Visible")
					emote_type = EMOTE_VISIBLE
				if("Hearable")
					emote_type = EMOTE_AUDIBLE
				else
					alert("Unable to use this emote, must be either hearable or visible.")
					return
			message = custom_emote
	else
		message = params
		if(type_override)
			emote_type = type_override
	. = ..()
	message = null
	emote_type = EMOTE_VISIBLE

/datum/emote/living/help
	key = "help"

/datum/emote/living/help/run_emote(mob/user, params)
	var/list/keys = list()
	var/list/message = list("Available emotes, you can use them with say \"*emote\": ")

	for(var/e in emote_list)
		if(e in keys)
			continue
		var/datum/emote/E = emote_list[e]
		if(E.can_run_emote(user, TRUE))
			keys += E.key

	keys = sortList(keys)

	for(var/emote in keys)
		if(LAZYLEN(message) > 1)
			message += ", [emote]"
		else
			message += "[emote]"

	message += "."

	message = jointext(message, "")

	user << message

/datum/emote/sound/beep
	key = "beep"
	key_third_person = "beeps"
	message = "�����."
	message_param = "beeps at %t."
	sound = 'sound/machines/twobeep.ogg'