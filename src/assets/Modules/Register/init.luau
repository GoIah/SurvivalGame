local ServerStorage = game:GetService("ServerStorage")

local Assets = ServerStorage.Assets
local Modules = Assets.Modules
local utils = Modules.utils

local Lib = require(script.Lib)
local Types = require(script.T)

local Recursive = require(utils.recrusiveFunctions)
local DeepCopy = require(utils.deepcopy)

local register: Types.registerImpl = {} :: Types.registerImpl
register.__index = register

warn("loading registers")

function register.create(Name: string, Type: string)
	--# debuging
	assert(Name, `register name must be provided`)
	assert(Type, `register type must be provided`)

	assert(Lib.registers[Name], `no register named {Name} found`)
	assert(Lib.types[Type], `no type named {Type} found`)

	local self = {}

	self.refactor = function()
		return Recursive.Create({
			Register_add = function() end,
			Type_add = function() end,
			Type = function() end,
			Register = function() end,
		}, {
			["Register_add"] = { ["_name"] = "add", ["_returns"] = { "Register_add" } },
			["Type_add"] = { ["_name"] = "add", ["_returns"] = { "Type_add", "Register" } },
			["Type"] = { ["_name"] = "Type", ["_main"] = true, ["_returns"] = { "Type_add", "Register" } },
			["Register"] = { ["_name"] = "Register", ["_returns"] = { "Register_add" } },
		})
	end

	self.Name = Name
	self.Registor = DeepCopy(Lib.registers[Name])
	self.Type = DeepCopy(Lib.types[Type])

	local Metatable = setmetatable(self, register)
	local Test = setmetatable({
		new = function()
			return self
		end,
	}, {
		__call = function(t, ...)
			return self
		end,
	})
	self.Test = Test

	return Metatable
end

function register:register() end

return register
