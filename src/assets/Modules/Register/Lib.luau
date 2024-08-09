local HttpService = game:GetService("HttpService")

local regLib = {}
regLib.registers = {}
regLib.types = {}

local allowedVariables = {
	"table",
	"string",
	"number",
	"Vector3",
	"Vector2",
	"Color3",
	"CFrame",
	"BrickColor",
	"boolean",
}

local Cache
Cache = {
	Update = function(Register)
		Cache[Register.ID] = {
			Register,
			os.clock(),
		}
	end,
	Get = function(Register)
		Cache[Register.ID][2] = os.clock()
		return Cache[Register.ID][1]
	end,
	GetLatest = function()
		local Latest

		for _, Register in pairs(Cache) do
			if (typeof(Register) == "table") and (Latest and (Register[2] > Latest[2]) or true) then
				Latest = Register
			end
		end
		Latest[2] = os.clock()

		return Latest[1]
	end,
	Remove = function(Register)
		Cache[Register.ID] = nil
	end,
	Wash = function()
		for i, v in pairs(Cache) do
			if typeof(v) == "table" then
				Cache[i] = nil
			end
		end
	end,
}

local Data
local Createfuncions = {
	Base = function(data: { any })
		Data = Cache.GetLatest()
		Cache.Remove(Data)

		if Data.Register then
			for name, v in pairs(data or {}) do
				if typeof(v) == "function" then
					Data.Data[name] = v
				end
			end

			regLib.registers[Data.Name] = Data.Data
		elseif Data.Type then
			for name, v in pairs(data or {}) do
				if table.find(allowedVariables, typeof(v)) then
					Data.Data[name] = v
				end
			end

			regLib.types[Data.Name] = Data.Data
		end
	end,

	Copy = function(from: string)
		local Data = Cache.GetLatest()
		Cache.Remove(Data)

		assert(from, `register must be provided`)
		if Data.Register then
			local register = regLib.registers[from]

			assert(register, `no register named {from} was found`)

			for name, v in pairs(register) do
				if typeof(v) == "function" then
					Data.Data[name] = v
				end
			end

			regLib.registers[Data.Name] = Data.Data
		elseif Data.Type then
			local _type = regLib.types[from]

			assert(_type, `no type named {from} was found`)

			for name, v in pairs(_type) do
				if table.find(allowedVariables, typeof(v)) then
					Data.Data[name] = v
				end
			end

			regLib.types[Data.Name] = Data.Data

			return {
				Properties = function(data: { any })
					for name, v in pairs(data) do
						if table.find(allowedVariables, typeof(v)) then
							regLib.types[Data.Name][name] = v
						end
					end
				end,
			}
		end
	end,
}
local CreateType = {
	Register = function()
		local Data = Cache.GetLatest()
		Data.Register = true

		return Createfuncions
	end,

	Type = function(strictAssigment: string)
		local Data = Cache.GetLatest()
		Data.Type = true

		Data.Data.strictAssigment = strictAssigment

		return Createfuncions
	end,
}

function regLib.Create(Name: string)
	local self = {
		ID = HttpService:GenerateGUID(false),
		Name = Name,

		Data = {},
	}

	Cache.Update(self)

	return CreateType
end

function regLib.Refactor(Name: number, Data)
	local Registor = regLib.registers[Name]

	if Registor then
		
	end
end

return regLib
