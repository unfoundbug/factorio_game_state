require "handler_core"

-- Game hooks
script.on_init(function()
    Values_Initialise()
end)

script.on_load(function()
    Values_Cleanup()
end)

script.on_nth_tick(settings.startup["ufb-web-refresh-time"], function ()
    Values_Update()
end )

-- event interception

script.on_event(defines.events.on_player_joined_game, function(index)
    Player_Joined(index.player_index)
end)
script.on_event(defines.events.on_player_left_game, function(index)
    Player_Left(index.player_index)
end)
script.on_event(defines.events.on_player_ammo_inventory_changed, function(index)
    Player_Updated_Ammo(index.player_index);
end)
script.on_event(defines.events.on_player_main_inventory_changed, function(index)
    Player_Updated_Main(index.player_index);
end)