--- @class ConsumableMenu
--- Manages the UI menu for auto-consumables configuration
--- Provides a hierarchical menu structure for configuring various consumable options
--- including elixirs, incenses, and opals with their respective tiers

--- Plugin identifier used for hash generation
local plugin_label = "KAFALURS_AUTO_CONSUMABLES"
local menu = {}
local options = require("data.consumable_options")

--- Menu UI elements configuration
--- @field main_tree TreeNode Root menu container for all consumable options
--- @field main_toggle Checkbox Global enable/disable toggle for the entire plugin
--- @field elixir_tree TreeNode Container for all elixir-related options
--- @field incense_tree TreeNode Container for all incense-related options
--- @field opal_tree TreeNode Container for all opal-related options
--- @field t1_elixir_toggle Checkbox Enable/disable toggle for tier 1 elixirs
--- @field t1_elixir_combo ComboBox Selection dropdown for tier 1 elixir types
--- @field t2_elixir_toggle Checkbox Enable/disable toggle for tier 2 elixirs
--- @field t2_elixir_combo ComboBox Selection dropdown for tier 2 elixir types
--- @field t1_incense_toggle Checkbox Enable/disable toggle for tier 1 incenses
--- @field t1_incense_combo ComboBox Selection dropdown for tier 1 incense types
--- @field t2_incense_toggle Checkbox Enable/disable toggle for tier 2 incenses
--- @field t2_incense_combo ComboBox Selection dropdown for tier 2 incense types
--- @field t3_incense_toggle Checkbox Enable/disable toggle for tier 3 incenses
--- @field t3_incense_combo ComboBox Selection dropdown for tier 3 incense types
--- @field opal_toggle Checkbox Enable/disable toggle for opals
--- @field opal_combo ComboBox Selection dropdown for opal types
menu.elements = {
  main_tree = tree_node:new(0),
  main_toggle = checkbox:new(false, get_hash(plugin_label .. "_main_toggle")),

  elixir_tree = tree_node:new(1),
  incense_tree = tree_node:new(1),
  opal_tree = tree_node:new(1),

  t1_elixir_toggle = checkbox:new(false, get_hash(plugin_label .. "_t1_elixir_toggle")),
  t1_elixir_combo = combo_box:new(0, get_hash(plugin_label .. "_t1_elixir_combo")),
  
  t2_elixir_toggle = checkbox:new(false, get_hash(plugin_label .. "_t2_elixir_toggle")),
  t2_elixir_combo = combo_box:new(0, get_hash(plugin_label .. "_t2_elixir_combo")),

  t1_incense_toggle = checkbox:new(false, get_hash(plugin_label .. "_t1_incense_toggle")),
  t1_incense_combo = combo_box:new(0, get_hash(plugin_label .. "_t1_incense_combo")),

  t2_incense_toggle = checkbox:new(false, get_hash(plugin_label .. "_t2_incense_toggle")),
  t2_incense_combo = combo_box:new(0, get_hash(plugin_label .. "_t2_incense_combo")),

  t3_incense_toggle = checkbox:new(false, get_hash(plugin_label .. "_t3_incense_toggle")),
  t3_incense_combo = combo_box:new(0, get_hash(plugin_label .. "_t3_incense_combo")),
  
  opal_toggle = checkbox:new(false, get_hash(plugin_label .. "_opal_toggle")),
  opal_combo = combo_box:new(0, get_hash(plugin_label .. "_opal_combo")),
}

--- Renders the consumables configuration menu
--- Creates a hierarchical menu structure with collapsible sections for different consumable types.
--- Each section contains toggles to enable/disable specific tiers and dropdowns to select consumable variants.
--- The menu is only active when the main toggle is enabled.
--- @return nil
function menu.render()
  -- Main menu tree
  if not menu.elements.main_tree:push("Kafalurs Auto Consumables") then
    return
  end

  -- Main toggle
  menu.elements.main_toggle:render("Enable", "Toggles Potion Buff on/off")
  if not menu.elements.main_toggle:get() then
    menu.elements.main_tree:pop()
    return
  end

  -- Elixir submenu
  if menu.elements.elixir_tree:push("Elixirs") then
    -- T1 Elixir options
    menu.elements.t1_elixir_toggle:render("T1 Elixir Toggle", "Toggles T1 Elixir Potions on/off")
    if menu.elements.t1_elixir_toggle:get() then
      menu.elements.t1_elixir_combo:render("T1 Elixirs", options.t1_elixir_names, "Which elixir do you want to use?")
    end

    -- T2 Elixir options
    menu.elements.t2_elixir_toggle:render("T2 Elixir Toggle", "Toggles T2 Elixir Potions on/off")
    if menu.elements.t2_elixir_toggle:get() then
      menu.elements.t2_elixir_combo:render("T2 Elixirs", options.t2_elixir_names, "Which elixir do you want to use?")
    end

    menu.elements.elixir_tree:pop()
  end

  -- Incense submenu
  if menu.elements.incense_tree:push("Incenses") then
    -- T1 Incense options
    menu.elements.t1_incense_toggle:render("T1 Incense Toggle", "Toggles T1 Incenses on/off")
    if menu.elements.t1_incense_toggle:get() then
      menu.elements.t1_incense_combo:render("T1 Incenses", options.t1_incense_names, "Which T1 incense do you want to use?")
    end

    -- T2 Incense options
    menu.elements.t2_incense_toggle:render("T2 Incense Toggle", "Toggles T2 Incenses on/off")
    if menu.elements.t2_incense_toggle:get() then
      menu.elements.t2_incense_combo:render("T2 Incenses", options.t2_incense_names, "Which T2 incense do you want to use?")
    end

    -- T3 Incense options
    menu.elements.t3_incense_toggle:render("T3 Incense Toggle", "Toggles T3 Incenses on/off")
    if menu.elements.t3_incense_toggle:get() then
      menu.elements.t3_incense_combo:render("T3 Incenses", options.t3_incense_names, "Which T3 incense do you want to use?")
    end

    menu.elements.incense_tree:pop()
  end

  -- Opal submenu
  if menu.elements.opal_tree:push("Opals") then
    menu.elements.opal_toggle:render("Opal Toggle", "Toggles Opals on/off")
    if menu.elements.opal_toggle:get() then
      menu.elements.opal_combo:render("Opals", options.opal_names, "Which opal do you want to use?")
    end
    menu.elements.opal_tree:pop()
  end

  menu.elements.main_tree:pop()
end

return menu
