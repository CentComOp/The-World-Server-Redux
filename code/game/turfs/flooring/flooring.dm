var/list/flooring_types

/proc/populate_flooring_types()
	flooring_types = list()
	for (var/flooring_path in typesof(/decl/flooring))
		flooring_types["[flooring_path]"] = new flooring_path

/proc/get_flooring_data(var/flooring_path)
	if(!flooring_types)
		flooring_types = list()
	if(!flooring_types["[flooring_path]"])
		flooring_types["[flooring_path]"] = new flooring_path
	return flooring_types["[flooring_path]"]

// State values:
// [icon_base]: initial base icon_state without edges or corners.
// if has_base_range is set, append 0-has_base_range ie.
//   [icon_base][has_base_range]
// [icon_base]_broken: damaged overlay.
// if has_damage_range is set, append 0-damage_range for state ie.
//   [icon_base]_broken[has_damage_range]
// [icon_base]_edges: directional overlays for edges.
// [icon_base]_corners: directional overlays for non-edge corners.

/decl/flooring
	var/name = "floor"
	var/desc
	var/icon
	var/icon_base

	var/has_base_range
	var/has_damage_range
	var/has_burn_range
	var/damage_temperature
	var/apply_thermal_conductivity
	var/apply_heat_capacity

	var/build_type      // Unbuildable if not set. Must be /obj/item/stack.
	var/build_cost = 1  // Stack units.
	var/build_time = 0  // BYOND ticks.

	var/descriptor = "tiles"
	var/flags
	var/can_paint
	var/list/footstep_sounds = list() // key=species name, value = list of soundss

	var/can_engrave = FALSE

/decl/flooring/grass
	name = "grass"
	desc = "Do they smoke grass out in space, Bowie? Or do they smoke AstroTurf?"
	icon = 'icons/turf/flooring/grass.dmi'
	icon_base = "grass"
	has_base_range = 3
	damage_temperature = T0C+80
	flags = TURF_HAS_EDGES | TURF_REMOVE_SHOVEL
	build_type = /obj/item/stack/tile/grass
	footstep_sounds = list("human" = list(
		'sound/effects/footstep/grass1.ogg',
		'sound/effects/footstep/grass2.ogg',
		'sound/effects/footstep/grass3.ogg',
		'sound/effects/footstep/grass4.ogg'))

/decl/flooring/grass/outdoors
	name = "grass"
	desc = "Do they smoke grass out in space, Bowie? Or do they smoke AstroTurf?"
	icon = 'icons/turf/outdoors.dmi'
	has_base_range = 2
	flags = TURF_CAN_BURN
	icon_base = "grass"
	footstep_sounds = list("human" = list(
		'sound/effects/footstep/grass1.ogg',
		'sound/effects/footstep/grass2.ogg',
		'sound/effects/footstep/grass3.ogg',
		'sound/effects/footstep/grass4.ogg'))

/decl/flooring/asteroid
	name = "coarse sand"
	desc = "Gritty and unpleasant."
	icon = 'icons/turf/flooring/asteroid.dmi'
	icon_base = "asteroid"
	flags = TURF_HAS_EDGES | TURF_REMOVE_SHOVEL
	build_type = null
	footstep_sounds = list("human" = list(
		'sound/effects/footstep/concrete1.ogg',
		'sound/effects/footstep/concrete2.ogg',
		'sound/effects/footstep/concrete3.ogg',
		'sound/effects/footstep/concrete4.ogg'))

/decl/flooring/water
	name = "shallow water"
	desc = "A body of water.  It seems shallow enough to walk through, if needed."
	icon = 'icons/turf/outdoors.dmi'
	icon_base = "seashallow"
	build_type = null
	footstep_sounds = list("human" = list(
		'sound/effects/footstep/slosh1.ogg',
		'sound/effects/footstep/slosh2.ogg',
		'sound/effects/footstep/slosh3.ogg',
		'sound/effects/footstep/slosh4.ogg'))

/decl/flooring/water/deep
	name = "deep water"
	desc = "A body of water.  It seems quite deep."
	icon = 'icons/turf/outdoors.dmi'
	icon_base = "seadeep"

/decl/flooring/snow
	name = "snow"
	desc = "A layer of many tiny bits of frozen water. It's hard to tell how deep it is."
	icon = 'icons/turf/snow_new.dmi'
	icon_base = "snow"
	footstep_sounds = list("human" = list(
		'sound/effects/footstep/snow1.ogg',
		'sound/effects/footstep/snow2.ogg',
		'sound/effects/footstep/snow3.ogg',
		'sound/effects/footstep/snow4.ogg',
		'sound/effects/footstep/snow5.ogg'))

/decl/flooring/dirt
	name = "dirt"
	desc = "Quite dirty!"
	icon = 'icons/turf/outdoors.dmi'
	icon_base = "dirt-dark"
	footstep_sounds = list("human" = list(
		'sound/effects/footstep/dirt1.ogg',
		'sound/effects/footstep/dirt2.ogg',
		'sound/effects/footstep/dirt3.ogg',
		'sound/effects/footstep/dirt4.ogg'))


/decl/flooring/snow/snow2
	name = "snow"
	desc = "A layer of many tiny bits of frozen water. It's hard to tell how deep it is."
	icon = 'icons/turf/snow.dmi'
	icon_base = "snow"
	flags = TURF_HAS_EDGES

/decl/flooring/snow/gravsnow
	name = "snow"
	icon_base = "gravsnow"

/decl/flooring/snow/plating
	name = "snowy plating"
	desc = "Steel plating coated with a light layer of snow."
	icon_base = "snowyplating"
	flags = null

/decl/flooring/snow/ice
	name = "ice"
	desc = "Looks slippery."
	icon_base = "ice"

/decl/flooring/snow/plating/drift
	icon_base = "snowyplayingdrift"

/decl/flooring/carpet
	name = "carpet"
	desc = "Imported and comfy."
	icon = 'icons/turf/flooring/carpet.dmi'
	icon_base = "carpet"
	build_type = /obj/item/stack/tile/carpet
	damage_temperature = T0C+200
	flags = TURF_HAS_EDGES | TURF_HAS_CORNERS | TURF_REMOVE_CROWBAR | TURF_CAN_BURN
	footstep_sounds = list("human" = list(
		'sound/effects/footstep/carpet1.ogg',
		'sound/effects/footstep/carpet2.ogg',
		'sound/effects/footstep/carpet3.ogg',
		'sound/effects/footstep/carpet4.ogg',
		'sound/effects/footstep/carpet5.ogg'))

/decl/flooring/carpet/bcarpet
	name = "black carpet"
	icon_base = "bcarpet"
	build_type = /obj/item/stack/tile/carpet/bcarpet

/decl/flooring/carpet/blucarpet
	name = "blue carpet"
	icon_base = "blucarpet"
	build_type = /obj/item/stack/tile/carpet/blucarpet

/decl/flooring/carpet/turcarpet
	name = "tur carpet"
	icon_base = "turcarpet"
	build_type = /obj/item/stack/tile/carpet/turcarpet

/decl/flooring/carpet/sblucarpet
	name = "silver blue carpet"
	icon_base = "sblucarpet"
	build_type = /obj/item/stack/tile/carpet/sblucarpet

/decl/flooring/carpet/gaycarpet
	name = "clown carpet"
	icon_base = "gaycarpet"
	build_type = /obj/item/stack/tile/carpet/gaycarpet

/decl/flooring/carpet/purcarpet
	name = "purple carpet"
	icon_base = "purcarpet"
	build_type = /obj/item/stack/tile/carpet/purcarpet

/decl/flooring/carpet/oracarpet
	name = "orange carpet"
	icon_base = "oracarpet"
	build_type = /obj/item/stack/tile/carpet/oracarpet

/decl/flooring/carpet/tealcarpet
	name = "teal carpet"
	icon_base = "tealcarpet"
	build_type = /obj/item/stack/tile/carpet/teal

/decl/flooring/tiling
	name = "floor"
	desc = "Scuffed from the passage of countless greyshirts."
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_base = "tiled"
	has_damage_range = 2
	damage_temperature = T0C+1400
	flags = TURF_REMOVE_CROWBAR | TURF_CAN_BREAK | TURF_CAN_BURN
	build_type = /obj/item/stack/tile/floor
	can_paint = 1
	footstep_sounds = list("human" = list(
		'sound/effects/footstep/floor1.ogg',
		'sound/effects/footstep/floor2.ogg',
		'sound/effects/footstep/floor3.ogg',
		'sound/effects/footstep/floor4.ogg',
		'sound/effects/footstep/floor5.ogg'))

	can_engrave = TRUE

/decl/flooring/tiling/tech
	desc = "Scuffed from the passage of countless greyshirts."
	icon = 'icons/turf/flooring/techfloor.dmi'
	icon_base = "techfloor_gray"
	build_type = /obj/item/stack/tile/floor/techgrey
	can_paint = null

/decl/flooring/tiling/tech/grid
	icon_base = "techfloor_grid"
	build_type = /obj/item/stack/tile/floor/techgrid

/decl/flooring/tiling/new_tile
	name = "floor"
	icon_base = "tile_full"
	flags = TURF_CAN_BREAK | TURF_CAN_BURN | TURF_IS_FRAGILE
	build_type = null

/decl/flooring/tiling/new_tile/cargo_one
	icon_base = "cargo_one_full"

/decl/flooring/tiling/new_tile/kafel
	icon_base = "kafel_full"

/decl/flooring/tiling/new_tile/techmaint
	icon_base = "techmaint"

/decl/flooring/tiling/new_tile/monofloor
	icon_base = "monofloor"

/decl/flooring/tiling/new_tile/monotile
	icon_base = "monotile"

/decl/flooring/tiling/new_tile/steel_grid
	icon_base = "steel_grid"

/decl/flooring/tiling/new_tile/steel_ridged
	icon_base = "steel_ridged"

/decl/flooring/linoleum
	name = "linoleum"
	desc = "It's like the 2390's all over again."
	icon = 'icons/turf/flooring/linoleum.dmi'
	icon_base = "lino"
	can_paint = 1
	build_type = /obj/item/stack/tile/linoleum
	flags = TURF_REMOVE_SCREWDRIVER

/decl/flooring/tiling/red
	name = "floor"
	icon_base = "white"
	has_damage_range = null
	flags = TURF_REMOVE_CROWBAR
	build_type = /obj/item/stack/tile/floor/red

/decl/flooring/tiling/steel
	name = "floor"
	icon_base = "steel"
	build_type = /obj/item/stack/tile/floor/steel

/decl/flooring/tiling/steel_dirty
	name = "floor"
	icon_base = "steel_dirty"
	build_type = /obj/item/stack/tile/floor/steel_dirty

/decl/flooring/tiling/asteroidfloor
	name = "floor"
	icon_base = "asteroidfloor"
	has_damage_range = null
	flags = TURF_REMOVE_CROWBAR
	build_type = /obj/item/stack/tile/floor/steel

/decl/flooring/tiling/white
	name = "floor"
	desc = "How sterile."
	icon_base = "white"
	build_type = /obj/item/stack/tile/floor/white

/decl/flooring/tiling/yellow
	name = "floor"
	icon_base = "white"
	has_damage_range = null
	flags = TURF_REMOVE_CROWBAR
	build_type = /obj/item/stack/tile/floor/yellow

/decl/flooring/tiling/dark
	name = "floor"
	desc = "How ominous."
	icon_base = "dark"
	has_damage_range = null
	flags = TURF_REMOVE_CROWBAR
	build_type = /obj/item/stack/tile/floor/dark

/decl/flooring/tiling/hydro
	name = "floor"
	icon_base = "hydrofloor"
	build_type = /obj/item/stack/tile/floor/steel

/decl/flooring/tiling/neutral
	name = "floor"
	icon_base = "neutral"
	build_type = /obj/item/stack/tile/floor/steel

/decl/flooring/tiling/freezer
	name = "floor"
	desc = "Don't slip."
	icon_base = "freezer"
	build_type = /obj/item/stack/tile/floor/freezer

/decl/flooring/wood
	name = "wooden floor"
	desc = "Polished wooden planks."
	icon = 'icons/turf/flooring/wood.dmi'
	icon_base = "wood"
	has_damage_range = 6
	damage_temperature = T0C+200
	descriptor = "planks"
	build_type = /obj/item/stack/tile/wood
	flags = TURF_CAN_BREAK | TURF_IS_FRAGILE | TURF_REMOVE_SCREWDRIVER
	footstep_sounds = list("human" = list(
		'sound/effects/footstep/wood1.ogg',
		'sound/effects/footstep/wood2.ogg',
		'sound/effects/footstep/wood3.ogg',
		'sound/effects/footstep/wood4.ogg',
		'sound/effects/footstep/wood5.ogg'))

/decl/flooring/wood/sif
	name = "alien wooden floor"
	desc = "Polished alien wood planks."
	icon = 'icons/turf/flooring/wood.dmi'
	icon_base = "sifwood"
	build_type = /obj/item/stack/tile/wood/sif

/decl/flooring/wood/pale
	name = "pale wooden floor"
	desc = "Old oak wood floor."
	icon = 'icons/turf/flooring/wood.dmi'
	icon_base = "palewood"
	build_type = /obj/item/stack/tile/wood

/decl/flooring/wood/mahogany
	icon_base = "mahogany"
	build_type = /obj/item/stack/tile/mahogany

/decl/flooring/wood/maple
	icon_base = "maple"
	build_type = /obj/item/stack/tile/maple

/decl/flooring/wood/ebony
	icon_base = "ebony"
	build_type = /obj/item/stack/tile/ebony

/decl/flooring/wood/walnut
	icon_base = "walnut"
	build_type = /obj/item/stack/tile/walnut


/decl/flooring/reinforced
	name = "reinforced floor"
	desc = "Heavily reinforced with steel rods."
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_base = "reinforced"
	flags = TURF_REMOVE_WRENCH | TURF_ACID_IMMUNE
	build_type = /obj/item/stack/rods
	build_cost = 2
	build_time = 30
	apply_thermal_conductivity = 0.025
	apply_heat_capacity = 325000
	can_paint = 1

/decl/flooring/reinforced/circuit
	name = "processing strata"
	icon = 'icons/turf/flooring/circuit.dmi'
	icon_base = "bcircuit"
	build_type = null
	flags = TURF_ACID_IMMUNE | TURF_CAN_BREAK | TURF_REMOVE_CROWBAR
	can_paint = 1

/decl/flooring/reinforced/circuit/green
	name = "processing strata"
	icon_base = "gcircuit"

/decl/flooring/reinforced/cult
	name = "engraved floor"
	desc = "Unsettling whispers waver from the surface..."
	icon = 'icons/turf/flooring/cult.dmi'
	icon_base = "cult"
	build_type = null
	has_damage_range = 6
	flags = TURF_ACID_IMMUNE | TURF_CAN_BREAK
	can_paint = null

/decl/flooring/pavement
	name = "pavement"
	icon = 'icons/turf/pavement.dmi'
	icon_base = "pavement"
	build_type = null
	footstep_sounds = list("human" = list(
		'sound/effects/footstep/pavement1.ogg',
		'sound/effects/footstep/pavement2.ogg',
		'sound/effects/footstep/pavement3.ogg',
		'sound/effects/footstep/pavement4.ogg'))

/decl/flooring/pavement/corner
	icon_base = "pave_corner"

/decl/flooring/pavement/invert_corner
	icon_base = "pave_invert_corner"

/decl/flooring/pavement/empty
	icon_base = "pave_empty"
	build_type = /obj/item/stack/tile/pavement

/decl/flooring/pavement/pave_tiling
	icon_base = "pave_tiling"
	build_type = /obj/item/stack/tile/pave_tiling

/decl/flooring/pavement/brick_paving
	icon_base = "brick_paving"
	build_type = /obj/item/stack/tile/brick_paving

/decl/flooring/road
	icon = 'icons/turf/roads.dmi'
	icon_base = "road"
	build_type = /obj/item/stack/tile/road
	flags = TURF_REMOVE_MINEREQUIP | TURF_ACID_IMMUNE
	footstep_sounds = list("human" = list(
		'sound/effects/footstep/pavement1.ogg',
		'sound/effects/footstep/pavement2.ogg',
		'sound/effects/footstep/pavement3.ogg',
		'sound/effects/footstep/pavement4.ogg'))

/decl/flooring/road/empty
	icon_base = "road_empty"

/decl/flooring/road/corner
	icon_base = "road_corner"

/decl/flooring/road/markings
	icon_base = "road_marking"

/decl/flooring/road/garage
	icon_base = "garage"
