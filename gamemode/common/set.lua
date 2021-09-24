Set = {}

function Set.new (t)
    local set = {}
    for _, l in ipairs(t) do 
        set[l] = true 
    end
    return set
end

function Set.union (a,b)
    local res = Set.new{}
    for k in pairs(a) do res[k] = true end
    for k in pairs(b) do res[k] = true end
    return res
end

function Set.intersection (a,b)
    local res = Set.new{}
    for k in pairs(a) do
        res[k] = b[k]
    end
    return res
end

function Set.difference (a,b)
    local res = Set.new{}
    for k in pairs(a) do
        if b[k] == nil then res[k] = true end
    end
    return res
end