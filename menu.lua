local plugin_label = "AUTO_CONSUMABLES"
local menu = {}
local consumables = require("data.consumable")

-- Create name arrays from the consumable tables
local function extract_names(consumable_table)
    local names = {}
    for _, item in ipairs(consumable_table) do
        table.insert(names, item.name)
    end
    return names
end

menu.elements = {
  main_tree = tree_node:new(0),
  main_toggle = checkbox:new(false, get_hash(plugin_label .. "_main_toggle")),

  opal_tree = tree_node:new(1),
  elixir_tree = tree_node:new(1),
  incense_tree = tree_node:new(1),

  opal_combo = combo_box:new(0, get_hash(plugin_label .. "_opal_combo")),
  opal_toggle = checkbox:new(false, get_hash(plugin_label .. "_opal_toggle")),

  t1_elixir_combo = combo_box:new(0, get_hash(plugin_label .. "_t1_elixir_combo")),
  t1_elixir_toggle = checkbox:new(false, get_hash(plugin_label .. "_t1_elixir_toggle")),

  t2_elixir_combo = combo_box:new(0, get_hash(plugin_label .. "_t2_elixir_combo")),
  t2_elixir_toggle = checkbox:new(false, get_hash(plugin_label .. "_t2_elixir_toggle")),

  t1_incense_combo = combo_box:new(0, get_hash(plugin_label .. "_t1_incense_combo")),
  t1_incense_toggle = checkbox:new(false, get_hash(plugin_label .. "_t1_incense_toggle")),

  t2_incense_combo = combo_box:new(0, get_hash(plugin_label .. "_t2_incense_combo")),
  t2_incense_toggle = checkbox:new(false, get_hash(plugin_label .. "_t2_incense_toggle")),

  t3_incense_combo = combo_box:new(0, get_hash(plugin_label .. "_t3_incense_combo")),
  t3_incense_toggle = checkbox:new(false, get_hash(plugin_label .. "_t3_incense_toggle")),
}

function menu.render()
  if not menu.elements.main_tree:push("KafalursAuto Consumables") then
    return
  end

  menu.elements.main_toggle:render("Enable", "Toggles Potion Buff on/off")
  if not menu.elements.main_toggle:get() then
    menu.elements.main_tree:pop()
    return
  end

  if menu.elements.opal_tree:push("Opals") then
    menu.elements.opal_combo:render("Opals", extract_names(consumables.opals), "Which opal do you want to use?")
    menu.elements.opal_toggle:render("Opal Toggle", "Toggles Opal Potions on/off")
    menu.elements.opal_tree:pop()
  end

  if menu.elements.elixir_tree:push("Elixirs") then
    menu.elements.t1_elixir_combo:render("T1 Elixirs", extract_names(consumables.t1_elixirs), "Which T1 elixir do you want to use?")
    menu.elements.t1_elixir_toggle:render("T1 Elixir Toggle", "Toggles T1 Elixir Potions on/off")
    menu.elements.t2_elixir_combo:render("T2 Elixirs", extract_names(consumables.t2_elixirs), "Which T2 elixir do you want to use?")
    menu.elements.t2_elixir_toggle:render("T2 Elixir Toggle", "Toggles T2 Elixir Potions on/off")
    menu.elements.elixir_tree:pop()
  end

  if menu.elements.incense_tree:push("Incenses") then
    menu.elements.t1_incense_combo:render("T1 Incenses", extract_names(consumables.t1_incense), "Which T1 incense do you want to use?")
    menu.elements.t1_incense_toggle:render("T1 Incense Toggle", "Toggles T1 Incenses on/off")
    menu.elements.t2_incense_combo:render("T2 Incenses", extract_names(consumables.t2_incense), "Which T2 incense do you want to use?")
    menu.elements.t2_incense_toggle:render("T2 Incense Toggle", "Toggles T2 Incenses on/off")
    menu.elements.t3_incense_combo:render("T3 Incenses", extract_names(consumables.t3_incense), "Which T3 incense do you want to use?")
    menu.elements.t3_incense_toggle:render("T3 Incense Toggle", "Toggles T3 Incenses on/off")
    menu.elements.incense_tree:pop()
  end

  menu.elements.main_tree:pop()
end

return menu
