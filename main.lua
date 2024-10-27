local menu = require("menu")
local consumables = require("data.consumable")

-- Utility Functions
local function check_for_player_buff(buffs, buff_hash)
    local count = 0
    for _, buff in ipairs(buffs) do
        if buff and buff.name_hash == buff_hash then
            count = count + 1
        end
    end
    return count
end

-- Add at the top with other variables
local last_use_time = 0
local USE_COOLDOWN = 1.0  -- 1 second cooldown between uses

local function check_consumables(consumable_table, selected_index, buffs, consumable_names, inventory_items)
    -- Check if enough time has passed since last use
    local current_time = get_gametime()
    if current_time - last_use_time < USE_COOLDOWN then
        return
    end
    
    -- Handle "Any" option for opals
    if selected_index == 0 and consumable_table == consumables.opals then
            for _, item in ipairs(inventory_items) do
                for _, opal in ipairs(consumable_table) do
                    -- Check if any opal buff is already active
                    if check_for_player_buff(buffs, opal.powerup) > 0 then
                        return
                    end

                    if item:get_sno_id() == opal.snoid then
                        loot_manager.use_item(item)
                        last_use_time = current_time  -- Update the last use time
                        return
                    end
                end
            end
        return
    end
    
    local selected_item = consumable_table[selected_index + 1]
    if not selected_item then 
        return 
    end

    -- Check if buff is already active
    local buff_count = check_for_player_buff(buffs, selected_item.powerup)
    if buff_count > 0 then
        return
    end
    
    for _, item in ipairs(inventory_items) do
        local item_snoid = item:get_sno_id()
        if item_snoid == selected_item.snoid then
            loot_manager.use_item(item)
            last_use_time = current_time  -- Update the last use time
            return
        end
    end
end

-- Main update loop
on_update(function()
    -- Add main toggle check at the start
    if not menu.elements.main_toggle:get() then 
        return 
    end

    local local_player = get_local_player()
    if not local_player then 
        return 
    end

    -- Get current player data
    local player_position = get_player_position()
    local buffs = local_player:get_buffs()
    local consumable_names = local_player:get_consumables_names()
    local inventory_items = local_player:get_consumable_items()
    
    if not inventory_items then
        return
    end
    
    -- Search for enemies within 10 units range
    local target = target_selector.get_target_closer(player_position, 10)
    
    if not target then
        return
    end
    
    -- Only perform consumable checks if an enemy is nearby
    if target then
        -- Check and use Opals if enabled
        if menu.elements.opal_toggle:get() then
            check_consumables(
                consumables.opals,
                menu.elements.opal_combo:get(),
                buffs,
                consumable_names,
                inventory_items
            )
        end
        
        -- Check and use T2 (high-tier) Elixirs
        if menu.elements.t2_elixir_toggle:get() then
            check_consumables(
                consumables.t2_elixirs,
                menu.elements.t2_elixir_combo:get(),
                buffs,
                consumable_names,
                inventory_items
            )
        -- If T2 Elixirs are disabled, check T1 (low-tier) Elixirs
        elseif menu.elements.t1_elixir_toggle:get() then
            check_consumables(
                consumables.t1_elixirs,
                menu.elements.t1_elixir_combo:get(),
                buffs,
                consumable_names,
                inventory_items
            )
        end
        
        -- Check and use Incense (all tiers independently)
        -- T3 (highest-tier) Incense
        if menu.elements.t3_incense_toggle:get() then
            check_consumables(
                consumables.t3_incense,
                menu.elements.t3_incense_combo:get(),
                buffs,
                consumable_names,
                inventory_items
            )
        end
        
        -- T2 (high-tier) Incense
        if menu.elements.t2_incense_toggle:get() then
            check_consumables(
                consumables.t2_incense,
                menu.elements.t2_incense_combo:get(),
                buffs,
                consumable_names,
                inventory_items
            )
        end
        
        -- T1 (low-tier) Incense
        if menu.elements.t1_incense_toggle:get() then
            check_consumables(
                consumables.t1_incense,
                menu.elements.t1_incense_combo:get(),
                buffs,
                consumable_names,
                inventory_items
            )
        end
    end
end)

console.print("Kafalurs Auto-Consumables V1.0");

-- Menu rendering
on_render_menu(function()
    menu.render()
end)
