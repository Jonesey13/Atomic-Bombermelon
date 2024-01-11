local function TurnSearchDirection(x, y)
    local newx, newy
    if y == 0 then
        newx = 0
        newy = -x
    else
        newx = y
        newy = 0
    end

    return newx, newy
end

function GM:GenerateDefaultDeathBlockPattern(grid)
    local deathblocks = {}
    local x, y = -grid.sizeLeft, grid.sizeUp
	local dirx, diry = 1 , 0
    local empty = grid:generateBlank()
    local nextSquare

    repeat
        empty:setSquare(x, y, nil)
        table.insert(deathblocks, {x = x, y = y})
        local newx, newy = x + dirx, y + diry
        nextSquare = empty:getSquare(newx, newy)
        
        if nextSquare == nil then
            dirx, diry = TurnSearchDirection(dirx, diry)
            newx, newy = x + dirx, y + diry
            nextSquare = empty:getSquare(newx, newy)
        end

        x, y = newx, newy

    until nextSquare == nil

    return deathblocks
end

