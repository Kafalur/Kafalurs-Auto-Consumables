# Kafalur's Auto-Consumables

## Description
Kafalur's Auto-Consumables is a Lua script designed to automate the use of consumable items in D4.

## Features
- Automatic use of consumables when enemies are nearby
- Support for different tiers of Elixirs and Incenses
- Opal usage management
- Customizable settings through an in-game menu
- Cooldown system to prevent excessive item usage
- Buff checking to avoid redundant consumable use

## Consumable Types
1. **Elixirs**: Two tiers (T1 and T2) with various effects
2. **Incenses**: Three tiers (T1, T2, and T3) with different properties
3. **Opals**: Special consumables with unique effects

## Usage
1. Enable the plugin using the main toggle in the menu
2. Configure your preferred consumables for each category
3. Toggle on/off specific tiers or types of consumables as needed
4. The script will automatically use the selected consumables when enemies are within range

## How It Works
1. The script checks for nearby enemies within a 10-unit range
2. If an enemy is detected, it cycles through the enabled consumable types
3. For each enabled consumable, it checks if the buff is already active
4. If the buff is not active and the item is in the inventory, it uses the consumable
5. A 1-second cooldown is applied between consumable uses to prevent spam
