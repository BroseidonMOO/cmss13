/datum/supply_packs/armor_leader
	name = "B12 pattern marine armor crate (x1 helmet, x1 armor)"
	contains = list(
					/obj/item/clothing/head/helmet/marine/leader,
					/obj/item/clothing/suit/storage/marine/leader
					)
	cost = 20
	containertype = /obj/structure/closet/crate
	containername = "B12 pattern marine armor crate"
	group = "Armor"

/datum/supply_packs/armor_rto
	name = "M4 pattern marine armor crate (x1 helmet, x1 armor)"
	contains = list(/obj/item/clothing/head/helmet/marine/rto,
					/obj/item/clothing/suit/storage/marine/rto)
	cost = 20
	containertype = /obj/structure/closet/crate
	containername = "M4 pattern marine armor crate"
	group = "Armor"
	
/datum/supply_packs/clothing/merc
	contains = list()
	name = "black market clothing crate(x1)"
	cost = 30
	contraband = 1
	containertype = /obj/structure/largecrate/merc/clothing
	containername = "\improper black market clothing crate"
	group = "Clothing"
