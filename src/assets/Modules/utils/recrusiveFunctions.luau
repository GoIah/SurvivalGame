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
			[RecData._name] = function(...)
				Storage[FName][2](...)

				local ReturnTab = {}
				for _, FFname in pairs(RecData._returns) do
					for _, F in pairs(Storage.Functions[FFname]) do
						if typeof(F) == "function" then
							ReturnTab[Storage[FFname][1]] = F
						end
					end
				end

				return ReturnTab
			end,
		}

		if RecData._main then
			Storage.main = Storage.Functions[FName]
		end
	end

	return (Storage.main and Storage.main) or Storage
end

return Recursive
