local ServerStorage = game:GetService("ServerStorage")

local Assets = ServerStorage.Assets
local Modules = Assets.Modules
local regLib = require(Modules.Register.Lib)

-- Registers
regLib.Create("Ore").Register().Base();
regLib.Create("Item").Register().Base();

-- Types
regLib.Create("ORE").Type("Ore").Base({
	["strength"] = 4, ["volume"] = 42});
	
regLib.Create("IRON_ORE").Type().Copy("ORE");
regLib.Create("COAL_ORE").Type().Copy("ORE");
regLib.Create("GOLD_ORE").Type().Copy("ORE");

return {}