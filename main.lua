local menu = require("menu")
local consumables = require("data.consumable")

-- Utility Functions
local function check_for_player_buff(buffs, option)
    local count = 0
    for _, buff in ipairs(buffs) do
        if buff and buff:name_hash() == option then
            count = count + 1
        end
    end
    return count
end

local function check_consumables(consumable_table, selected_index, buffs, consumable_item_ids)
    if not menu.elements.main_toggle:get() then return end
    
    -- Get the selected item from the consumable table using index+1
    local selected_item = consumable_table[selected_index + 1]
    if not selected_item then return end

    -- Check if player already has the buff from this item active
    -- selected_item.powerup contains the buff ID granted by the item
    local buff_count = check_for_player_buff(buffs, selected_item.powerup)
    if buff_count >= 1 then return end  -- If buff is active, don't use item
    
    -- If no buff is active, search for the item in inventory
    -- selected_item.snoid contains the unique item ID
    for _, item_id in ipairs(consumable_item_ids) do
        if item_id == selected_item.snoid then
            -- Item found -> consume it
            loot_manager.use_item(item_id)
            return
        end
    end
end

-- Main update loop
on_update(function()
    -- Get reference to local player
    local local_player = get_local_player()

    -- Check if player exists
    if local_player then
        -- Get current player data
        local player_position = get_player_position()        -- Player's position
        local buffs = local_player:get_buffs()              -- Player's active buffs
        local consumable_item_ids = local_player:get_consumables_ids() -- Available consumable items
        -- Search for enemies within 10 units range
        local target = target_selector.get_target_closer(player_position, 10)
        
        -- Only perform consumable checks if an enemy is nearby
        if target then
            -- Check and use Opals if enabled
            if menu.elements.opal_toggle:get() then
                check_consumables(
                    consumables.opals,           -- Opal table
                    menu.elements.opal_combo:get(), -- Selected opal type
                    buffs,                       -- Current buffs
                    consumable_item_ids          -- Available items
                )
            end
            
            -- Check and use T2 (high-tier) Elixirs
            if menu.elements.t2_elixir_toggle:get() then
                check_consumables(
                    consumables.t2_elixirs,      -- T2 Elixir table
                    menu.elements.t2_elixir_combo:get(),
                    buffs,
                    consumable_item_ids
                )
            -- If T2 Elixirs are disabled, check T1 (low-tier) Elixirs
            elseif menu.elements.t1_elixir_toggle:get() then
                check_consumables(
                    consumables.t1_elixirs,      -- T1 Elixir table
                    menu.elements.t1_elixir_combo:get(),
                    buffs,
                    consumable_item_ids
                )
            end
            
            -- Check and use Incense (all tiers independently)
            -- T3 (highest-tier) Incense
            if menu.elements.t3_incense_toggle:get() then
                check_consumables(
                    consumables.t3_incense,
                    menu.elements.t3_incense_combo:get(),
                    buffs,
                    consumable_item_ids
                )
            end
            
            -- T2 (high-tier) Incense
            if menu.elements.t2_incense_toggle:get() then
                check_consumables(
                    consumables.t2_incense,
                    menu.elements.t2_incense_combo:get(),
                    buffs,
                    consumable_item_ids
                )
            end
            
            -- T1 (low-tier) Incense
            if menu.elements.t1_incense_toggle:get() then
                check_consumables(
                    consumables.t1_incense,
                    menu.elements.t1_incense_combo:get(),
                    buffs,
                    consumable_item_ids
                )
            end
        end
    end
end)

-- Menu rendering
on_render_menu(function()
    menu.render()
end)
