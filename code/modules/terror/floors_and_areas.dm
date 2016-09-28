///Areas///

/area/toxins/hss
	name = "High Secured Storage"
	icon = 'icons/turf/terror.dmi'
	icon_state = "hss"

/area/security/shower
	name = "Shower"
	icon_state = "red"

/area/security/gear
	name = "Gear Room"
	icon_state = "red"

/area/security/security_gear
	name = "Security Gear Room"
	icon_state = "red"

/area/security/break_room
	name = "Security Break Room"
	icon_state = "red"

/area/security/west
	name = "West brig's corridor"
	icon = 'icons/turf/terror.dmi'
	icon_state = "west"

/area/security/infirmary
	name = "Infirmary"
	icon_state = "red"

/area/security/center
	name = "Central brig's corridor"
	icon = 'icons/turf/terror.dmi'
	icon_state = "central"

/area/security/east
	name = "East brig's corridor"
	icon = 'icons/turf/terror.dmi'
	icon_state = "east"

/area/security/mass_cell
	name = "Mass cell"
	icon_state = "red"

/area/security/barracks
	name = "Barracks"
	icon = 'icons/turf/terror.dmi'
	icon_state = "barracks"

/area/security/top_level_post
	name = "Bunker's airlock"
	icon_state = "red"

/area/mine/bravo
	name = "Post Bravo"

/area/engine/rest_room
	name = "Engineering Rest Room"
	icon_state = "yellow"

/area/engine/equipment_room
	name = "Engineer equipment room"
	icon_state = "yellow"

/area/toxins/xeno_lobby
	name = "Xenobiology Lab's lobby"
	icon_state = "toxlab"

/area/engine/top_level_rtg
	name = "Top Level RTG"
	icon_state = "engine"

/area/crew_quarters/toilet/top
	name = "Top Level Toilets"
	icon_state = "toilet"

/area/hallway/primary/central/top
	name = "Top Level Lobby"
	icon_state = "hallC"

/area/quartermaster/hangar
	name = "Hangar"
	icon_state = "yellow"

/area/CP
	name = "Control Post"
	has_gravity = 1
	valid_territory = 0
	icon_state = "green"

/area/CP/library
	name = "Library"
	icon_state = "library"

/area/CP/arrival
	name = "Arrival area"

/area/CP/cafeteria
	name = "Cafeteria"
	icon_state = "dark"

/area/CP/CP1
	name = "Control Point One"
	icon_state = "yellow"

/area/CP/CP2
	name = "Control Point Two"
	icon_state = "yellow"

/area/CP/shuttle
	name = "CP Shuttle"
	requires_power = 0
	icon_state = "shuttle"

/area/shuttle/NTcruiser
	name = "Cruiser"
	blob_allowed = 0

/area/shuttle/lift_one
	name = "Service Lift"

/area/shuttle/life_two
	name = "Lift"

/area/mine/lab
	name = "Field Laboratory"
	icon_state = "medresearch"
	blob_allowed = 0

/area/mine/shelter
	name = "Lavaland shelter"
	icon_state = "green"
	blob_allowed = 0
	ambientsounds = list('sound/ambience/ambimine.ogg')

/area/mine/shelter/ash
	name = "Ash Walkers' village"
	icon_state = "red"

/area/crew_quarters/gym
	name = "Gym"

/area/construction/brig
	name = "Prison wing"
	icon_state = "yellow"

/area/toxins/telepad
	name = "Telepad control"
	icon = 'icons/turf/terror.dmi'
	icon_state = "tele"

/area/maintenance/xmaint
	name = "Xenolab Maintenance"
	icon_state = "green"

/area/security/punishment
	name = "Punishment room"
	icon_state = "sec_prison"

/area/ai_monitored/storage/AIlobby
	name = "AI Satellite Lobby"
	icon_state = "storage"

/area/zombie
	name = "Zombie"
	icon_state = "red"
	requires_power = 0
	has_gravity = 1

// CENTCOM

/area/centcom/lobby
	name = "Centcom Lobby"
	icon_state = "centcom"

/area/centcom/security
	name = "Centcom Security"
	icon_state = "security"


///Flors///

/turf/open/floor/plasteel/darkvault/delivary
	icon = 'icons/turf/infinity.dmi'
	icon_state = "darkdelivery"

/turf/open/floor/plasteel/terror
	icon = 'icons/turf/terror.dmi'

/turf/open/floor/plasteel/terror/red
	icon_state = "redfull_t"
/turf/open/floor/plasteel/terror/red/side
	icon_state = "red_t"
/turf/open/floor/plasteel/terror/red/corner
	icon_state = "redcorner_t"

/turf/open/floor/plasteel/terror/whitered
	icon_state = "whiteredfull_t"
/turf/open/floor/plasteel/terror/whitered/side
	icon_state = "whitered_t"
/turf/open/floor/plasteel/terror/whitered/corner
	icon_state = "whiteredcorner_t"

/turf/open/floor/plasteel/terror/darkred
	icon_state = "darkredfull_t"
/turf/open/floor/plasteel/terror/darkred/side
	icon_state = "darkred_t"
/turf/open/floor/plasteel/terror/darkred/corner
	icon_state = "darkredcorners_t"

//Necropolis//

/turf/closed/mineral/random/high_chance/volcanic
	environment_type = "basalt"
	mineralChance = 25
	mineralSpawnChanceList = list(
		/turf/closed/mineral/uranium = 35, /turf/closed/mineral/diamond = 30, /turf/closed/mineral/gold = 45,
		/turf/closed/mineral/silver = 50, /turf/closed/mineral/plasma = 50, /turf/closed/mineral/bscrystal = 20)
	initial_gas_mix = "o2=14;n2=23;TEMP=300"
	turf_type = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	baseturf = /turf/open/floor/plating/asteroid/basalt/lava_land_surface

/turf/closed/mineral/random/high_chance/New()
	icon_state = "rock"
	..()

/turf/open/floor/plasteel/terror/necro
	baseturf = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	icon = 'icons/turf/floors.dmi'

/turf/open/floor/plasteel/terror/necro/freezer
	icon_state = "freezerfloor"

/turf/open/floor/plasteel/terror/necro/cult
	icon_state = "cult"
	name = "engraved floor"
/turf/open/floor/plasteel/terror/necro/cult/outdoor
	initial_gas_mix = "o2=14;n2=23;TEMP=300"
	planetary_atmos = TRUE

/turf/open/floor/plasteel/terror/necro/bar
	icon_state = "bar"

/turf/open/floor/plasteel/terror/necro/darkred
	icon_state = "darkredfull"
/turf/open/floor/plasteel/terror/necro/darkred/side
	icon_state = "darkred"
/turf/open/floor/plasteel/terror/necro/darkred/corner
	icon_state = "darkredcorners"

/turf/open/floor/plasteel/terror/necro/red
	icon_state = "redfull"
/turf/open/floor/plasteel/terror/necro/red/side
	icon_state = "red"
/turf/open/floor/plasteel/terror/necro/red/corner
	icon_state = "redcorner"

/turf/open/floor/plasteel/terror/necro/blue
	icon_state = "bluefull"
/turf/open/floor/plasteel/terror/necro/blue/side
	icon_state = "blue"
/turf/open/floor/plasteel/terror/necro/blue/corner
	icon_state = "bluecorner"

/turf/open/floor/plasteel/terror/necro/neutral
	icon_state = "neutralfull"
/turf/open/floor/plasteel/terror/necro/neutral/side
	icon_state = "neutral"
/turf/open/floor/plasteel/terror/necro/neutral/corner
	icon_state = "neutralcorner"

/turf/open/floor/plasteel/terror/necro/darkvault
	icon_state = "vault"
/turf/open/floor/plasteel/terror/necro/darkvault/outdoor
	initial_gas_mix = "o2=14;n2=23;TEMP=300"
	planetary_atmos = TRUE

/turf/open/floor/plasteel/terror/necro/darkwarning
	icon_state = "warndark"
/turf/open/floor/plasteel/terror/necro/darkwarning/corner
	icon_state = "warndarkcorners"

/turf/open/floor/plasteel/terror/necro/darkwarning/outdoor
	initial_gas_mix = "o2=14;n2=23;TEMP=300"
	planetary_atmos = TRUE

/turf/open/floor/plasteel/terror/necro/darkwarning/corner/outdoor
	initial_gas_mix = "o2=14;n2=23;TEMP=300"
	planetary_atmos = TRUE

/turf/open/floor/plasteel/terror/necro/warning
	icon_state = "warning"
/turf/open/floor/plasteel/terror/necro/warning/corner
	icon_state = "warningcorner"

/turf/open/floor/plasteel/terror/necro/warnwhite
	icon_state = "warnwhite"
/turf/open/floor/plasteel/terror/necro/warnwhite/corner
	icon_state = "warnwhitecorner"

/turf/open/floor/plasteel/terror/necro/black
	icon_state = "dark"
	icon = 'icons/turf/infinity.dmi'
/turf/open/floor/plasteel/terror/necro/black/outdoor
	initial_gas_mix = "o2=14;n2=23;TEMP=300"
	planetary_atmos = TRUE

/turf/open/floor/plasteel/terror/necro/darkyellow
	icon_state = "darkbrownfull"
/turf/open/floor/plasteel/terror/necro/darkyellow/side
	icon_state = "darkbrown"
/turf/open/floor/plasteel/terror/necro/darkyellow/corner
	icon_state = "darkbrowncorners"

/turf/open/floor/plasteel/terror/necro/brown
	icon_state = "brown"
/turf/open/floor/plasteel/terror/necro/brown/corner
	icon_state = "browncorner"

/turf/open/floor/plating/lavaland
	baseturf = /turf/open/floor/plating/asteroid/basalt/lava_land_surface

/turf/open/floor/plating/lavaland/outdoor
	initial_gas_mix = "o2=14;n2=23;TEMP=300"
	planetary_atmos = TRUE

/turf/open/floor/plating/lavaland/outdoor/necropolis
	baseturf = /turf/open/indestructible/necropolis

turf/open/floor/plating/lavaland/outdoor/fall
	baseturf = /turf/open/chasm/straight_down/lava_land_surface

/turf/open/floor/plasteel/terror/necro/blackvault
	icon_state = "tvault"
	icon = 'icons/turf/infinity.dmi'
/turf/open/floor/plasteel/terror/necro/blackvault/corner
	icon_state = "tvaultcorner"

/turf/open/floor/plasteel/terror/necro/blackvault/outdoor
	initial_gas_mix = "o2=14;n2=23;TEMP=300"
	planetary_atmos = TRUE

/turf/open/floor/plasteel/terror/necro/blackvault/corner/outdoor
	initial_gas_mix = "o2=14;n2=23;TEMP=300"
	planetary_atmos = TRUE

/turf/open/floor/plasteel/terror/necro/whiteblue
	icon_state = "whitebluefull"
/turf/open/floor/plasteel/terror/necro/whiteblue/side
	icon_state = "whiteblue"
/turf/open/floor/plasteel/terror/necro/whiteblue/corner
	icon_state = "whitebluecorner"

/turf/open/floor/plasteel/terror/necro/stairs
	icon_state = "ramptop"
	icon = 'icons/turf/terror.dmi'
/turf/open/floor/plasteel/terror/necro/stairs/bottom
	icon_state = "rampbottom"
/turf/open/floor/plasteel/terror/necro/stairs/top
	icon_state = "ramptop"

/turf/open/floor/plasteel/terror/necro/freezer
	icon_state = "freezerfloor"

/turf/open/floor/plasteel/terror/necro/wood
	icon_state = "wood"
	floor_tile = /obj/item/stack/tile/wood
	broken_states = list("wood-broken", "wood-broken2", "wood-broken3", "wood-broken4", "wood-broken5", "wood-broken6", "wood-broken7")

/turf/open/floor/plasteel/terror/necro/white
	icon_state = "white"