function tableMap(tbl, f)
    local t = {}
    for k,v in pairs(tbl) do
        t[k] = f(k, v)
    end
    return t
end

function tableLength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
  end
  