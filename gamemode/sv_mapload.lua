function loadAtomicMap(mapTypes, fileName)
    local mapFile = file.Read(GM.Folder .. "/gamemode/maptypes/" .. fileName, "GAME")

    local jsonFile = util.JSONToTable(mapFile)

    map = {}
    map.name = fileName:sub(1, -6)
    map.description = jsonFile.name
    map.key = map.name

    map.startPositions = jsonFile.start_positions

    map.powerups = jsonFile.powerups

    function map:generateMap(grid)
        for x = 1, grid.maxx - grid.minx + 1 do
            for y = 1, grid.maxy - grid.miny + 1 do
                gridx = x + grid.minx - 1
                gridy = y + grid.miny - 1
                local brickType = jsonFile.grid[y][x]
                if brickType == "Brick" then
                    grid:setBox(gridx, gridy)
                elseif brickType == "Solid" then
                    grid:setWall(gridx, gridy)
                end
            end
        end
    end


    mapTypes[map.name] = map
end