// PRESETS

// EMP
/obj/machinery/camera/emp_proof
	start_active = 1

/obj/machinery/camera/emp_proof/Initialize()
	. = ..()
	upgradeEmpProof()

// X-RAY

/obj/machinery/camera/xray
	start_active = 1
	icon_state = "xraycam" // Thanks to Krutchen for the icons.

/obj/machinery/camera/xray/Initialize()
	. = ..()
	upgradeXRay()

// MOTION
/obj/machinery/camera/motion
	start_active = 1
	name = "motion-sensitive security camera"

/obj/machinery/camera/motion/Initialize()
	. = ..()
	upgradeMotion()

// ALL UPGRADES
/obj/machinery/camera/all
	start_active = 1

/obj/machinery/camera/all/Initialize()
	. = ..()
	upgradeEmpProof()
	upgradeXRay()
	upgradeMotion()

// Thunderome's camera
/obj/machinery/camera/thunder
	start_active = 1
	obj_integrity = 500
	max_integrity = 500
	c_tag = "Arena"
	icon_state = "xraycam"

/obj/machinery/camera/thunder/New()
	..()
	upgradeEmpProof()
	upgradeXRay()


// AUTONAME

/obj/machinery/camera/autoname
	var/number = 0 //camera number in area

//This camera type automatically sets it's name to whatever the area that it's in is called.
/obj/machinery/camera/autoname/Initialize()
	..()
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/camera/autoname/LateInitialize()
	. = ..()
	number = 1
	var/area/A = get_area(src)
	if(A)
		for(var/obj/machinery/camera/autoname/C in GLOB.machines)
			if(C == src)
				continue
			var/area/CA = get_area(C)
			if(CA.type == A.type)
				if(C.number)
					number = max(number, C.number+1)
		c_tag = "[A.name] #[number]"

// CHECKS

/obj/machinery/camera/proc/isEmpProof()
	return upgrades & CAMERA_UPGRADE_EMP_PROOF

/obj/machinery/camera/proc/isXRay()
	return upgrades & CAMERA_UPGRADE_XRAY

/obj/machinery/camera/proc/isMotion()
	return upgrades & CAMERA_UPGRADE_MOTION

// UPGRADE PROCS

/obj/machinery/camera/proc/upgradeEmpProof()
	AddComponent(/datum/component/empprotection, EMP_PROTECT_SELF | EMP_PROTECT_WIRES | EMP_PROTECT_CONTENTS)
	assembly.upgrades.Add(new /obj/item/stack/sheet/mineral/plasma(assembly))
	upgrades |= CAMERA_UPGRADE_EMP_PROOF

/obj/machinery/camera/proc/upgradeXRay()
	assembly.upgrades.Add(new /obj/item/analyzer(assembly))
	upgrades |= CAMERA_UPGRADE_XRAY

// If you are upgrading Motion, and it isn't in the camera's Initialize(), add it to the machines list.
/obj/machinery/camera/proc/upgradeMotion()
	assembly.upgrades.Add(new /obj/item/assembly/prox_sensor(assembly))
	upgrades |= CAMERA_UPGRADE_MOTION
