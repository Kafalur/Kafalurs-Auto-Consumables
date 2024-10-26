local menu = {}
local consumables = require("data.consumable")
local plugin_version = "1.0.2"
local plugin_label = "Auto Consumables | Kafalur | V" .. plugin_version

-- Create name arrays from the consumable tables
local function extract_names(consumable_table)
    local names = {}
    for _, item in ipairs(consumable_table) do
        table.insert(names, item.name)
    end
    return names
end

local function remove_prefix(names, prefix)
    local result = {}
    for _, name in ipairs(names) do
        result[#result + 1] = name:gsub("^" .. prefix, "")
    end
    return result
end

menu.elements = {
  main_tree = tree_node:new(0),
  main_toggle = checkbox:new(false, get_hash(plugin_label .. "_main_toggle")),

  opal_tree = tree_node:new(1),
  elixir_tree = tree_node:new(1),
  incense_tree = tree_node:new(1),

  opal_toggle = checkbox:new(false, get_hash(plugin_label .. "_opal_toggle")),
  opal_combo = combo_box:new(0, get_hash(plugin_label .. "_opal_combo")),

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
}

function menu.render()
  if not menu.elements.main_tree:push(plugin_label) then
    return
  end

  menu.elements.main_toggle:render("Enable Plugin", "Toggles Potion Buff on/off")

  -- Elixirs
  if menu.elements.elixir_tree:push("Elixirs") then
    menu.elements.t1_elixir_toggle:render("T1 Elixir Toggle", "Toggles T1 Elixir Potions on/off")
    menu.elements.t1_elixir_combo:render("T1 Elixirs", remove_prefix(extract_names(consumables.t1_elixirs), "Elixir of "), "Which T1 elixir do you want to use?")
    
    menu.elements.t2_elixir_toggle:render("T2 Elixir Toggle", "Toggles T2 Elixir Potions on/off")
    menu.elements.t2_elixir_combo:render("T2 Elixirs", remove_prefix(extract_names(consumables.t2_elixirs), "Elixir of "), "Which T2 elixir do you want to use?")
    menu.elements.elixir_tree:pop()
  end

  -- Incenses
  if menu.elements.incense_tree:push("Incenses") then
    menu.elements.t1_incense_toggle:render("T1 Incense Toggle", "Toggles T1 Incenses on/off")
    menu.elements.t1_incense_combo:render("T1 Incenses", extract_names(consumables.t1_incense), "Which T1 incense do you want to use?")
    
    menu.elements.t2_incense_toggle:render("T2 Incense Toggle", "Toggles T2 Incenses on/off")
    menu.elements.t2_incense_combo:render("T2 Incenses", extract_names(consumables.t2_incense), "Which T2 incense do you want to use?")
  
    menu.elements.t3_incense_toggle:render("T3 Incense Toggle", "Toggles T3 Incenses on/off")
    menu.elements.t3_incense_combo:render("T3 Incenses", extract_names(consumables.t3_incense), "Which T3 incense do you want to use?")
    menu.elements.incense_tree:pop()
  end

  -- Opals
  if menu.elements.opal_tree:push("Opals") then
    menu.elements.opal_toggle:render("Opal Toggle", "Toggles Opal Potions on/off")
    menu.elements.opal_combo:render("Opals", remove_prefix(extract_names(consumables.opals), "Seething Opal of "), "Which opal do you want to use?")
    menu.elements.opal_tree:pop()
  end

  menu.elements.main_tree:pop()
end

return menu
