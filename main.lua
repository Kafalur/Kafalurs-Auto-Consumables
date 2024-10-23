--- @class ConsumableManager
--- @description Manages consumable items including elixirs, incenses, and opals

local menu = require("menu")
local options = require("data.consumable_options")

--- Time tracking for potion usage cooldown
local last_potion_use_time = 0
--- Cooldown duration between potion uses (in seconds)
local potion_cooldown = 0.2

--- Checks for a specific buff on the player
--- @param buffs Buff[] Array of current player buffs
--- @param option string The buff name to search for
--- @return number Number of matching buffs found
local function check_for_player_buff(buffs, option)
  local count = 0
  for _, buff in ipairs(buffs) do
    if buff:name() == option then
      count = count + 1
    end
  end
  return count
end

--- Uses an item if cooldown period has elapsed
--- @param item Item The consumable item to use
--- @return nil
local function execute_with_cooldown(item)
  local current_time = get_time_since_inject()
  if current_time - last_potion_use_time >= potion_cooldown then
    use_item(item)
    last_potion_use_time = current_time
  end
end

--- Checks and uses consumables if conditions are met
--- @param elixir_options string[] Available consumable options
--- @param chosen_index number Selected option index (0-based)
--- @param elixir_toggle boolean Whether usage is enabled
--- @param buffs Buff[] Current player buffs
--- @param consumable_items Item[] Available consumable items
--- @return nil
local function check_consumables(elixir_options, chosen_index, elixir_toggle, buffs, consumable_items)
  if elixir_toggle then
    local elixir_name = elixir_options[chosen_index + 1]
    if check_for_player_buff(buffs, elixir_options[chosen_index + 1]) < 1 then
      for _, item in ipairs(consumable_items) do
        if item:get_name() == elixir_options[chosen_index + 1] then
          execute_with_cooldown(item)
        end
      end
    end
  end
end

--- Searches inventory for and uses temper items
--- @param inventory Item[] Player's inventory items
--- @return nil
local function check_inventory(inventory)
  for _, item in ipairs(inventory) do
    if string.find(string.lower(item:get_name()), "temper") then
      use_item(item)
    end
  end
end

--- Manages elixir buff maintenance
--- @param buffs Buff[] Current player buffs
--- @param consumable_items Item[] Available consumable items
--- @return nil
local function check_elixirs(buffs, consumable_items)
  local elixir_types = {
    {toggle = menu.elements.t1_elixir_toggle:get(), options = options.t1_elixir_options, chosen = menu.elements.t1_elixir_combo:get()},
    {toggle = menu.elements.t2_elixir_toggle:get(), options = options.t2_elixir_options, chosen = menu.elements.t2_elixir_combo:get()}
  }

  for _, elixir in ipairs(elixir_types) do
    if elixir.toggle then
      check_consumables(elixir.options, elixir.chosen, elixir.toggle, buffs, consumable_items)
      break -- Only use one type of elixir
    end
  end
end

--- Manages incense buff maintenance
--- @param buffs Buff[] Current player buffs
--- @param consumable_items Item[] Available consumable items
--- @return nil
local function check_incenses(buffs, consumable_items)
  local incense_types = {
    {toggle = menu.elements.t1_incense_toggle:get(), options = options.t1_incense_options, chosen = menu.elements.t1_incense_combo:get()},
    {toggle = menu.elements.t2_incense_toggle:get(), options = options.t2_incense_options, chosen = menu.elements.t2_incense_combo:get()},
    {toggle = menu.elements.t3_incense_toggle:get(), options = options.t3_incense_options, chosen = menu.elements.t3_incense_combo:get()}
  }

  for _, incense in ipairs(incense_types) do
    if incense.toggle then
      check_consumables(incense.options, incense.chosen, incense.toggle, buffs, consumable_items)
    end
  end
end

--- Manages opal buff maintenance
--- @param buffs Buff[] Current player buffs
--- @param consumable_items Item[] Available consumable items
--- @return nil
local function check_opals(buffs, consumable_items)
  if menu.elements.opal_toggle:get() then
    local chosen_opal = options.opal_options[menu.elements.opal_combo:get() + 1]
    if check_for_player_buff(buffs, chosen_opal) < 1 then
      for _, item in ipairs(consumable_items) do
        if item:get_name() == chosen_opal then
          execute_with_cooldown(item)
        end
      end
    end
  end
end

--- Main update callback function.
--- Handles player state checking and consumable management.
on_update(function()
  local local_player = get_local_player()

  if local_player then
    local player_position = get_player_position()
    local buffs = local_player:get_buffs()
    local consumable_items = local_player:get_consumable_items()
    local inventory_items = local_player:get_inventory_items()

    check_inventory(inventory_items)

    local closest_target = target_selector.get_target_closer(player_position, 10)

    if closest_target then
      check_elixirs(buffs, consumable_items)
      check_incenses(buffs, consumable_items)
      check_opals(buffs, consumable_items)
    end
  end
end)

--- Menu render callback function.
on_render_menu(menu.render)
