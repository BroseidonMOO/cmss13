/*
 * Platforms
 */
/obj/structure/platform
	name = "platform"
	desc = "A square metal surface resting on four legs."
	icon = 'icons/obj/structures/props/platforms.dmi'
	icon_state = "platform"
	climbable = TRUE
	anchored = TRUE
	density = 1
	throwpass = TRUE //You can throw objects over this, despite its density.
	layer = OBJ_LAYER
	climb_delay = 20 //Leaping a barricade is universally much faster than clumsily climbing on a table or rack
	breakable = FALSE
	flags_can_pass_all = PASS_OVER
	flags_atom = ON_BORDER
	unacidable = TRUE

/obj/structure/platform/New()
	var/image/I = image(icon, src, "platform_overlay", LADDER_LAYER, dir)//ladder layer puts us just above weeds.
	switch(dir)
		if(SOUTH)
			layer = ABOVE_MOB_LAYER+0.1
			I.pixel_y = -16
		if(NORTH)
			I.pixel_y = 16
		if(EAST)
			I.pixel_x = 16
			layer = ABOVE_MOB_LAYER+0.1
		if(WEST)
			I.pixel_x = -16
			layer = ABOVE_MOB_LAYER+0.1
	overlays += I
	..()

/obj/structure/platform/BlockedExitDirs(atom/movable/mover, target_dir)
	if(mover && mover.throwing)
		return NO_BLOCKED_MOVEMENT

	return ..()

/obj/structure/platform/BlockedPassDirs(atom/movable/mover, target_dir)
	if(mover && mover.throwing)
		return NO_BLOCKED_MOVEMENT

	var/obj/structure/S = locate(/obj/structure) in get_turf(mover)
	if(S && S.climbable && !(S.flags_atom & ON_BORDER) && climbable && isliving(mover)) //Climbable objects allow you to universally climb over others
		return 1

	return ..()

/obj/structure/platform/ex_act()
	return

obj/structure/platform_decoration
	name = "platform"
	desc = "A square metal surface resting on four legs."
	icon = 'icons/obj/structures/props//platforms.dmi'
	icon_state = "platform_deco"
	anchored = TRUE
	density = 0
	throwpass = TRUE
	layer = 3.5
	breakable = FALSE
	flags_can_pass_all = PASS_OVER
	flags_atom = ON_BORDER
	unacidable = TRUE

/obj/structure/platform_decoration/New()
	switch(dir)
		if (NORTH)
			layer = ABOVE_MOB_LAYER+0.1
		if (SOUTH)
			layer = ABOVE_MOB_LAYER+0.1
		if (SOUTHEAST)
			layer = ABOVE_MOB_LAYER+0.1
		if (SOUTHWEST)
			layer = ABOVE_MOB_LAYER+0.1
	.. ()

/obj/structure/platform/ex_act()
	return