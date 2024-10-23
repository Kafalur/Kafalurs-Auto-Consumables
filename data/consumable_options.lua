--- @class ConsumableOptions
--- @description Configuration table defining all available consumable options and their display names
---              for the auto-consumables system
---
--- @field t1_elixir_options string[] Tier 1 elixir internal names
--- @field t2_elixir_options string[] Tier 2 elixir internal names
--- @field t1_incense_options string[] Tier 1 incense internal names
--- @field t2_incense_options string[] Tier 2 incense internal names
--- @field t3_incense_options string[] Tier 3 incense internal names
--- @field opal_options string[] Opal internal names
--- @field t1_elixir_names string[] Tier 1 elixir display names
--- @field t2_elixir_names string[] Tier 2 elixir display names
--- @field t1_incense_names string[] Tier 1 incense display names
--- @field t2_incense_names string[] Tier 2 incense display names
--- @field t3_incense_names string[] Tier 3 incense display names
--- @field opal_names string[] Opal display names
local consumable_options = {
  --- Tier 1 elixir internal names
  t1_elixir_options = {
    "Elixir_Precision_1",     -- Elixir of Precision
    "Elixir_SpeedAndLuck_1",  -- Elixir of Speed and Luck (Elixir of Advantage)
    "Elixir_Destruction_1",   -- Elixir of Destruction
    "Elixir_Resources_1",     -- Elixir of Resource Enhancement
    "Elixir_MaxLife_1",       -- Elixir of Maximum Life (Elixir of Fortitude)
    "Elixir_Ironbarb_1",      -- Elixir of Iron Barbs
    "Elixir_ShadowResist_1",  -- Elixir of Shadow Resistance
    "Elixir_PoisonResist_1",  -- Elixir of Poison Resistance
    "Elixir_LightningResist_1", -- Elixir of Lightning Resistance
    "Elixir_FireResist_1",    -- Elixir of Fire Resistance
    "Elixir_ColdResist_1",    -- Elixir of Cold Resistance
  },

  --- Tier 2 elixir internal names
  t2_elixir_options = {
    "Elixir_Precision_5",     -- Elixir of Precision II
    "Elixir_SpeedAndLuck_2",  -- Elixir of Elixir of Advantage II
    "Elixir_Destruction_2",   -- Elixir of Destruction II
    "Elixir_Resources_2",     -- Elixir of Resource Enhancement II
    "Elixir_MaxLife_2",       -- Elixir of Elixir of Fortitude II
    "Elixir_Ironbarb_5",      -- Elixir of Iron Barbs II
    "Elixir_ShadowResist_5",  -- Elixir of Shadow Resistance II
    "Elixir_PoisonResist_5",  -- Elixir of Poison Resistance II
    "Elixir_LightningResist_5", -- Elixir of Lightning Resistance II
    "Elixir_FireResist_5",     -- Elixir of Fire Resistance II
    "Elixir_ColdResist_5",     -- Elixir of Cold Resistance II
  },

  --- Tier 1 incense internal names
  t1_incense_options = {
    "Incense_I_00",  -- Storm of the Wilds
    "Incense_I_01",  -- Desert Escape
    "Incense_I_02",  -- Song of the Mountain
    "Incense_I_03",  -- Spirit Dance
    "Incense_I_04",  -- Ancient Times
    "Incense_I_05",  -- Sage's Whisper
    "Incense_I_06",  -- Queen's Supreme
    "Incense_I_07",  -- Blessed Guide
  },

  --- Tier 2 incense internal names
  t2_incense_options = {
    "Incense_II_00", -- Reddamine Buzz
    "Incense_II_01", -- Soothing Spices
    "Incense_II_02", -- Spiral Morning
    "Incense_II_03", -- Scents of the Desert Afternoon
  },

  --- Tier 3 incense internal names
  t3_incense_options = {
    "Incense_III_00", -- Chorus of War
    "Incense_III_01", -- The Creatures of Night
  },

  --- Opal internal names
  opal_options = {
    "S06_Realmwalker_ConsumableBuff_00",  -- Seething Opal of Gold
    "S06_RealmWalker_ConsumableBuff_01",  -- Seething Opal of Equipment
    "S06_RealmWalker_ConsumableBuff_02",  -- Seething Opal of Socketables
    "S06_RealmWalker_ConsumableBuff_03",  -- Seething Opal of Materials
    "S06_RealmWalker_ConsumableBuff_04",  -- Seething Opal of Torment
  },

  --- Tier 1 elixir display names
  t1_elixir_names = {
    "Precision",
    "Advantage",
    "Cold Resist",
    "Destruction",
    "Fire Resist",
    "Fortitude",
    "Iron Barbs",
    "Lightning Resist",
    "Poison Resist",
    "Resource",
    "Shadow Resist",
  },

  --- Tier 2 elixir display names
  t2_elixir_names = {
    "Precision II",
    "Advantage II",
    "Cold Resist II",
    "Destruction II",
    "Fire Resist II",
    "Fortitude II",
    "Iron Barbs II",
    "Lightning Resist II",
    "Poison Resist II",
    "Resource II",
    "Shadow Resist II",
  },

  --- Tier 1 incense display names
  t1_incense_names = {
    "Storm of the Wilds",
    "Desert Escape",
    "Song of the Mountain",
    "Spirit Dance",
    "Ancient Times",
    "Sage's Whisper",
    "Queen's Supreme",
    "Blessed Guide",
  },

  --- Tier 2 incense display names
  t2_incense_names = {
    "Reddamine Buzz",
    "Soothing Spices",
    "Spiral Morning",
    "Scents of the Desert Afternoon",
  },

  --- Tier 3 incense display names
  t3_incense_names = {
    "Chorus of War",
    "The Creatures of Night",
  },
  --- Opal display names
  opal_names = {
    "Opal of Gold",
    "Opal of Equipment",
    "Opal of Socketables",
    "Opal of Materials",
    "Opal of Torment",
  },
}

return consumable_options
