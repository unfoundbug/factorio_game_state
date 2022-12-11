-- webcore.lua

-- utility
json = require "json"
html_const = require "html_const"

local function get_max_count(item)
    if global.max_lookup[item] == nil then
       local proto = game.item_prototypes[item]
       global.max_lookup[item] = proto.stack_size
    end

    return global.max_lookup[item]
end

-- mod logic

Values_Update = function()
    local biter_force = game.forces[2]
    global.game_details["evolution"] = biter_force.evolution_factor
    global.game_details["evolution_factor_by_pollution "] = biter_force.evolution_factor_by_pollution
    global.game_details["evolution_factor_by_time"] = biter_force.evolution_factor_by_time
    global.game_details["evolution_factor_by_killing_spawners"] = biter_force.evolution_factor_by_killing_spawners

    local rendered_object = {}
    rendered_object["evolution"] = global.game_details
    rendered_object["players"] = {}
    local playerCount = 1;
    for player, player_value in pairs(global.players) do
        rendered_object["players"][playerCount] = {}
        rendered_object["players"][playerCount]["name"] = player_value.name
        if player_value.ammo ~= nil then
            rendered_object["players"][playerCount]["slots"] = {}
            for ammo, ammo_value in pairs(player_value.ammo) do
                rendered_object["players"][playerCount]["slots"][ammo] = ammo_value
            end
        end
    end

    local resultString = json.encode(rendered_object)
    outFile = "factorio_facts.html"
    renderedFile = factorio_facts_header .. "000000" .. factorio_facts_header_2 .. "FFFFFF" .. factorio_facts_header_3 .. "16" .. factorio_facts_pre_json .. resultString .. factorio_facts_post_json
    game.write_file(outFile, renderedFile, false);

end

Player_Joined = function(player_id)
    global.players[player_id] = {};
    local player = game.get_player(player_id)
    global.players[player_id]["name"] = player.name
    Player_Updated_Ammo(player_id);
end

Player_Left = function(player_id)
    global.players[player_id] = nil;
end

Player_Updated_Ammo = function(player_id)
    activePlayer = game.get_player(player_id);

    if(global.players[player_id] == nil) then
        Player_Joined(player_id)
    end

    active_ammo = activePlayer.get_inventory(defines.inventory.character_ammo);
    if active_ammo ~= nil then
        slots = #active_ammo;
        
        global.players[player_id].ammo = {}

        for i = 1, slots, 1 do
            local item = active_ammo[i]
            if item.valid_for_read then
                global.players[player_id].ammo[i] = {}
                global.players[player_id].ammo[i]["slot"] = i
                global.players[player_id].ammo[i]["name"] = activePlayer.request_translation(item.prototype.localised_name)
                global.players[player_id].ammo[i]["current"] = item.count
                global.players[player_id].ammo[i]["max"] = get_max_count(item.name)
                global.players[player_id].ammo[i]["perc"] = item.count / get_max_count(item.name) * 100
            else
                global.players[player_id].ammo[i] = {}
                global.players[player_id].ammo[i]["slot"] = i
                global.players[player_id].ammo[i]["name"] = "Empty"
                global.players[player_id].ammo[i]["current"] = 0
                global.players[player_id].ammo[i]["max"] = 0
                global.players[player_id].ammo[i]["perc"] = 0
            end
        end
    end
end

Player_Updated_Main = function(player_id)
end

Values_Initialise = function ()
    global.forces = {}
    global.players = {}
    global.game_details = {}
    global.max_lookup = {}
end

Values_Cleanup = function()
end