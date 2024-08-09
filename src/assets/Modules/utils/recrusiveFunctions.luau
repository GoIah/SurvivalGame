local HttpService = game:GetService("HttpService")

local Recursive = {}

function Recursive.Create( Data: {any}, RecursiveData: {any} )
    local Storage = {
        Functions = {}
    }

    for FName, RecData in pairs(RecursiveData) do
        Storage[FName] = {[RecData._name] = Data[FName]}
    end
    for FName, RecData in pairs(RecursiveData) do
        Storage.Functions[FName] = function()
            Storage[FName][RecData._name]()

            local ReturnTab = {}

            for _,v in ipairs(RecData._returns) do

            end

            return ReturnTab
        end
    end

    print(Storage)
end


return Recursive