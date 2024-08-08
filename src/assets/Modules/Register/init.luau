local Lib = require(script.Lib)

local register = {}
register.__index = register

warn("loading registers")

function register.create(Name: string, Type: string)
	local self = {}

	assert(Name, `register name must be provided`)
	assert(Type, `register type must be provided`)

	assert(Lib.registers[Name], `no register named {Name} found`)
	assert(Lib.types[Type], `no type named {Type} found`)

	return setmetatable(self, register)
end

function register.register() end

register.refactor = setmetatable({}, {
	__index = register,
	__call = function(t)
		print(t)
	end,
})
register.refactor.new = function()
	-- new
end
print(Lib)

return register
