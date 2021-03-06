/mob/new_player/Login()
	if(config.password_login)
		if(input(src, "Enter password to join") != config.password_login)
			qdel(src.client)
			return

	if(!mind)
		mind = new /datum/mind(key)
		mind.active = 1
		mind.current = src

	..()

	if(join_motd)
		to_chat(src, "<div class=\"motd\">[join_motd]</div>")

	if(admin_notice)
		to_chat(src, "<span class='notice'><b>Admin Notice:</b>\n \t [admin_notice]</span>")

	if(config.soft_popcap && living_player_count() >= config.soft_popcap)
		to_chat(src, "<span class='notice'><b>Server Notice:</b>\n \t [config.soft_popcap_message]</span>")

	sight |= SEE_TURFS

/*
	var/list/watch_locations = list()
	for(var/obj/effect/landmark/landmark in landmarks_list)
		if(landmark.tag == "landmark*new_player")
			watch_locations += landmark.loc

	if(watch_locations.len>0)
		forceMove(pick(watch_locations))
*/
	client.donate_money = SScontent.get_user_money(ckey)

	new_player_panel()

	spawn(40)
		if(client)
			client.playtitlemusic()