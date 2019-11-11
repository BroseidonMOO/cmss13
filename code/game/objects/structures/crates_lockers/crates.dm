//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:32

/obj/structure/closet/crate
	name = "crate"
	desc = "A rectangular steel crate."
	icon = 'icons/obj/structures/crates.dmi'
	icon_state = "closed_basic"
	icon_opened = "open_basic"
	icon_closed = "closed_basic"
	climbable = 1
	climb_delay = 20 //Doesn't need as long to climb over a crate
	anchored = 0
	throwpass = 1 //prevents moving crates by hurling things at them
	store_mobs = FALSE
	flags_can_pass_all = PASS_OVER|PASS_AROUND
	var/rigged = 0

/obj/structure/closet/crate/can_open()
	return 1

/obj/structure/closet/crate/can_close()
	for(var/mob/living/L in get_turf(src)) //Can't close if someone is standing inside it. This is to prevent "crate traps" (let someone step in, close, open for 30 damage)
		return 0
	return 1

/obj/structure/closet/crate/BlockedPassDirs(atom/movable/mover, target_dir)
	for(var/obj/structure/S in get_turf(mover))
		if(S && S.climbable && !(S.flags_atom & ON_BORDER) && climbable && isliving(mover)) //Climbable non-border objects allow you to universally climb over others
			return NO_BLOCKED_MOVEMENT
	if(opened) //Open crate, you can cross over it
		return NO_BLOCKED_MOVEMENT
	
	return ..()

/obj/structure/closet/crate/open()
	if(opened)
		return 0
	if(!can_open())
		return 0

	if(rigged && locate(/obj/item/device/radio/electropack) in src)
		if(isliving(usr))
			var/mob/living/L = usr
			if(L.electrocute_act(17, src))
				var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
				s.set_up(5, 1, src)
				s.start()
				return 2

	playsound(src.loc, 'sound/machines/click.ogg', 15, 1)
	for(var/obj/O in src)
		O.loc = get_turf(src)
	opened = 1
	update_icon()
	if(climbable)
		structure_shaken()
		climbable = 0 //Open crate is not a surface that works when climbing around
	return 1

/obj/structure/closet/crate/close()
	if(!opened)
		return 0
	if(!can_close())
		return 0

	playsound(src.loc, 'sound/machines/click.ogg', 15, 1)
	var/itemcount = 0
	for(var/obj/O in get_turf(src))
		if(itemcount >= storage_capacity)
			break
		if(O.density || O.anchored || istype(O, /obj/structure/closet))
			continue
		if(istype(O, /obj/structure/bed)) //This is only necessary because of rollerbeds and swivel chairs.
			var/obj/structure/bed/B = O
			if(B.buckled_mob)
				continue
		O.loc = src
		itemcount++

	opened = 0
	climbable = 1
	update_icon()
	return 1

/obj/structure/closet/crate/attackby(obj/item/W as obj, mob/user as mob)
	if(W.flags_item & ITEM_ABSTRACT) return
	if(opened)
		if(isrobot(user))
			return
		user.drop_inv_item_to_loc(W, loc)
	else if(istype(W, /obj/item/packageWrap) || istype(W, /obj/item/stack/fulton))
		return
	else if(istype(W, /obj/item/stack/cable_coil))
		var/obj/item/stack/cable_coil/C = W
		if(rigged)
			to_chat(user, SPAN_NOTICE("[src] is already rigged!"))
			return
		if (C.use(1))
			to_chat(user, SPAN_NOTICE("You rig [src]."))
			rigged = 1
			return
	else if(istype(W, /obj/item/device/radio/electropack))
		if(rigged)
			to_chat(user, SPAN_NOTICE("You attach [W] to [src]."))
			user.drop_held_item()
			W.loc = src
			return
	else if(istype(W, /obj/item/tool/wirecutters))
		if(rigged)
			to_chat(user, SPAN_NOTICE("You cut away the wiring."))
			playsound(loc, 'sound/items/Wirecutter.ogg', 25, 1)
			rigged = 0
			return
	else return attack_hand(user)

/obj/structure/closet/crate/ex_act(severity)
	switch(severity)
		if(0 to EXPLOSION_THRESHOLD_LOW)
			if (prob(50))
				qdel(src)
			return
		if(EXPLOSION_THRESHOLD_LOW to EXPLOSION_THRESHOLD_MEDIUM)
			for(var/obj/O in src.contents)
				if(prob(50))
					qdel(O)
			qdel(src)
			return
		if(EXPLOSION_THRESHOLD_MEDIUM to INFINITY)
			for(var/obj/O in src.contents)
				qdel(O)
			qdel(src)
			return
		else
	return

/obj/structure/closet/crate/alpha
	name = "alpha squad crate"
	desc = "A crate with alpha squad's symbol on it. "
	icon_state = "closed_alpha"
	icon_opened = "open_alpha"
	icon_closed = "closed_alpha"

/obj/structure/closet/crate/ammo
	name = "ammunitions crate"
	desc = "A ammunitions crate"
	icon_state = "closed_ammo"
	icon_opened = "open_ammo"
	icon_closed = "closed_ammo"

/obj/structure/closet/crate/bravo
	name = "bravo squad crate"
	desc = "A crate with bravo squad's symbol on it. "
	icon_state = "closed_bravo"
	icon_opened = "open_bravo"
	icon_closed = "closed_bravo"

/obj/structure/closet/crate/charlie
	name = "charlie squad crate"
	desc = "A crate with charlie squad's symbol on it. "
	icon_state = "closed_charlie"
	icon_opened = "open_charlie"
	icon_closed = "closed_charlie"

/obj/structure/closet/crate/construction
	name = "construction crate"
	desc = "A construction crate"
	icon_state = "closed_construction"
	icon_opened = "open_construction"
	icon_closed = "closed_construction"

/obj/structure/closet/crate/delta
	name = "delta squad crate"
	desc = "A crate with delta squad's symbol on it. "
	icon_state = "closed_delta"
	icon_opened = "open_delta"
	icon_closed = "closed_delta"

/obj/structure/closet/crate/explosives
	name = "explosives crate"
	desc = "A explosives crate"
	icon_state = "closed_explosives"
	icon_opened = "open_explosives"
	icon_closed = "closed_explosives"

/obj/structure/closet/crate/freezer
	name = "freezer crate"
	desc = "A freezer crate."
	icon_state = "closed_freezer"
	icon_opened = "open_freezer"
	icon_closed = "closed_freezer"
	var/target_temp = T0C - 40
	var/cooling_power = 40


/obj/structure/closet/crate/hydroponics
	name = "hydroponics crate"
	desc = "All you need to destroy those pesky weeds and pests."
	icon_state = "closed_hydro"
	icon_opened = "open_hydro"
	icon_closed = "closed_hydro"

/obj/structure/closet/crate/hydroponics/prespawned
	//This exists so the prespawned hydro crates spawn with their contents.

	New()
		..()
		new /obj/item/reagent_container/spray/plantbgone(src)
		new /obj/item/reagent_container/spray/plantbgone(src)
		new /obj/item/tool/minihoe(src)

/obj/structure/closet/crate/internals
	name = "internals crate"
	desc = "A internals crate."
	icon_state = "closed_oxygen"
	icon_opened = "open_oxygen"
	icon_closed = "closed_oxygen"

/obj/structure/closet/crate/medical
	name = "medical crate"
	desc = "A medical crate."
	icon_state = "closed_medical"
	icon_opened = "open_medical"
	icon_closed = "closed_medical"

/obj/structure/closet/crate/plastic
	name = "plastic crate"
	desc = "A rectangular plastic crate."
	icon_state = "closed_plastic"
	icon_opened = "open_plastic"
	icon_closed = "closed_plastic"

/obj/structure/closet/crate/rcd
	name = "RCD crate"
	desc = "A crate for the storage of the RCD."

/obj/structure/closet/crate/rcd/New()
	..()
	new /obj/item/ammo_rcd(src)
	new /obj/item/ammo_rcd(src)
	new /obj/item/ammo_rcd(src)
	new /obj/item/device/rcd(src)

/obj/structure/closet/crate/freezer/rations //Fpr use in the escape shuttle
	desc = "A crate of emergency rations."
	name = "Emergency Rations"

/obj/structure/closet/crate/freezer/rations/New()
	..()
	new /obj/item/storage/box/donkpockets(src)
	new /obj/item/storage/box/donkpockets(src)

/* CM doesn't use this.
/obj/structure/closet/crate/bin
	desc = "A large bin."
	name = "Large bin"
	icon_state = "largebin"
	icon_opened = "largebinopen"
	icon_closed = "largebin"
*/

/obj/structure/closet/crate/radiation
	name = "radioactive gear crate"
	desc = "A crate with a radiation sign on it."
	icon_state = "closed_radioactive"
	icon_opened = "open_radioactive"
	icon_closed = "closed_radioactive"

/obj/structure/closet/crate/radiation/New()
	..()
	new /obj/item/clothing/suit/radiation(src)
	new /obj/item/clothing/head/radiation(src)
	new /obj/item/clothing/suit/radiation(src)
	new /obj/item/clothing/head/radiation(src)
	new /obj/item/clothing/suit/radiation(src)
	new /obj/item/clothing/head/radiation(src)
	new /obj/item/clothing/suit/radiation(src)
	new /obj/item/clothing/head/radiation(src)

/obj/structure/closet/crate/science
	name = "science crate"
	desc = "A science crate."
	icon_state = "closed_science"
	icon_opened = "open_science"
	icon_closed = "closed_science"

/obj/structure/closet/crate/supply
	name = "supply crate"
	desc = "A supply crate."
	icon_state = "closed_supply"
	icon_opened = "open_supply"
	icon_closed = "closed_supply"

/obj/structure/closet/crate/trashcart
	name = "Trash Cart"
	desc = "A heavy, metal trashcart with wheels."
	icon_state = "closed_trashcart"
	icon_opened = "open_trashcart"
	icon_closed = "closed_trashcart"

/obj/structure/closet/crate/wayland
	name = "Wayland crate"
	desc = "A crate with a Wayland insignia on it."
	icon_state = "closed_wayland"
	icon_opened = "open_wayland"
	icon_closed = "closed_wayland"

/obj/structure/closet/crate/weapon
	name = "weapons crate"
	desc = "A weapons crate."
	icon_state = "closed_weapons"
	icon_opened = "open_weapons"
	icon_closed = "closed_weapons"



/obj/structure/closet/crate/miningcar
	desc = "A mining car. This one doesn't work on rails, but has to be dragged."
	name = "Mining car (not for rails)"
	icon_state = "miningcar"
	density = 1
	icon_opened = "miningcaropen"
	icon_closed = "miningcar"

