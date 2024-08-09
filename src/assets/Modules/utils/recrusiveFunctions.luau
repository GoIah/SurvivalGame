local Recursive = {}

function Recursive.Create(Data: { any }, RecursiveData: { any })
	local Storage = {
		Functions = {},
	}

	for FName, RecData in pairs(RecursiveData) do
		Storage[FName] = { [1] = RecData._name, [2] = Data[FName] }
	end
	for FName, RecData in pairs(RecursiveData) do
		Storage.Functions[FName] = { [RecData._name] = function() end }
	end
	for FName, RecData in pairs(RecursiveData) do
		Storage.Functions[FName] = {
			[RecData._name] = function()
				Storage[FName][RecData._name]()

				local ReturnTab = {}

				for _, Fname in ipairs(RecData._returns) do
					ReturnTab[Storage.Functions[Fname]] = Storage.Functions[Fname]
				end

				return ReturnTab
			end,
		}

		if RecData._main then
			Storage.main = Storage.Functions[FName]
		end
	end
	print(Storage)

	return (Storage.main and Storage.main) or Storage
end

return Recursive
