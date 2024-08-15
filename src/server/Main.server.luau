local ServerStorage = game:GetService("ServerStorage")

local Assets = ServerStorage.Assets

local Modules = Assets.Modules

require(Modules.Initialization)
local Register = require(Modules.Register)

local IronOreRegister = Register.create("Ore", "IRON_ORE")
IronOreRegister.Test.new()
IronOreRegister.Test()

print(IronOreRegister)
IronOreRegister:refactor().Type().
                            add("N", false)
print(IronOreRegister)
IronOreRegister:refactor().Type().
                            add("N", true)
print(IronOreRegister)
