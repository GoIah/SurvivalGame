local Initializer = {}

for _,v in ipairs(script:GetChildren()) do
    require(v)
end

return Initializer