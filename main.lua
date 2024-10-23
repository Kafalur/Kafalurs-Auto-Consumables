--- ConsumableManager
--- Manages automatic usage of consumable items including elixirs, incenses, and opals.
--- Handles buff tracking, cooldowns, and selective usage based on menu settings.

local menu = require("menu")
local options = require("data.consumable_options")

--- Global cooldown tracking for consumable usage
local last_potion_use_time = 0
--- Minimum time between consumable uses (in seconds)
local potion_cooldown = 0.2

--- Counts how many instances of a specific buff are active on the player
--- @param buffs Buff[] List of all active player buffs
--- @param option string Name of the buff to check for
--- @return number Count of matching buff instances
local function check_for_player_buff(buffs, option)
  local count = 0
  for _, buff in ipairs(buffs) do
    if buff:name() == option then
      count = count + 1
    end
  end
  return count
end

--- Attempts to use an item while respecting the global cooldown
--- @param item Item The consumable item to use
--- @return nil
local function execute_with_cooldown(item)
  local current_time = get_time_since_inject()
  if current_time - last_potion_use_time >= potion_cooldown then
    use_item(item)
    last_potion_use_time = current_time
  end
end

--- Core consumable usage logic shared by all consumable types
--- @param consumable_options string[] List of possible consumable names
--- @param chosen_index number Currently selected option in the menu (0-based)
--- @param usage_toggle boolean Whether this consumable type is enabled
--- @param buffs Buff[] Current player buffs
--- @param consumable_items Item[] Available consumable items in inventory
--- @return nil
local function check_consumables(consumable_options, chosen_index, usage_toggle, buffs, consumable_items)
  if usage_toggle then
    local consumable_name = consumable_options[chosen_index + 1]
    if check_for_player_buff(buffs, consumable_name) < 1 then
      for _, item in ipairs(consumable_items) do
        if item:get_name() == consumable_name then
          execute_with_cooldown(item)
        end
      end
    end
  end
end

--- Checks for and uses temper items in the inventory
--- @param inventory Item[] Complete list of inventory items
--- @return nil
local function check_inventory(inventory)
  for _, item in ipairs(inventory) do
    if string.find(string.lower(item:get_name()), "temper") then
      use_item(item)
    end
  end
end

--- Manages elixir usage based on menu settings
--- Only one tier of elixir can be active at a time
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
      break -- Only use one tier of elixir
    end
  end
end

--- Manages incense usage based on menu settings
--- Multiple tiers of incense can be active simultaneously
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

--- Manages opal usage based on menu settings
--- Only one type of opal can be active at a time
--- @param buffs Buff[] Current player buffs
--- @param consumable_items Item[] Available consumable items
--- @return nil
local function check_opals(buffs, consumable_items)
  local opal_types = {
    {toggle = menu.elements.opal_toggle:get(), options = options.opal_options, chosen = menu.elements.opal_combo:get()}
  }

  for _, opal in ipairs(opal_types) do
    if opal.toggle then
      check_consumables(opal.options, opal.chosen, opal.toggle, buffs, consumable_items)
      break  -- Only use one type of opal
    end
  end
end

--- Main update loop
--- Checks player state and manages all consumable usage
--- Only activates consumables when a target is within range
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

--- Renders the configuration menu
on_render_menu(menu.render)
