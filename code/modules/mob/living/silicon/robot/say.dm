/mob/living/silicon/robot/say_quote(var/text)
	var/ending = copytext(text, length(text))

	if(ending == "?")
		return "����������, \"<span class = 'robot'>[text]</span>\"";
	else if(copytext(text, length(text) - 1) == "!!")
		return "����������, \"<span class = 'robot'><span class = 'yell'>[text]</span></span>\"";
	else if(ending == "!")
		return "���&#255;��&#255;��, \"<span class = 'robot'>[text]</span>\"";

	return "������������, \"<span class = 'robot'>[text]</span>\"";

/mob/living/silicon/robot/IsVocal()
	return !config.silent_borg
