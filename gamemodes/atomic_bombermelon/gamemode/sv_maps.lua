
include("sv_mapvote.lua")
include("sv_mapload.lua")

MapTypes = {}

// inherit from _G
local meta = {}
meta.__index = _G
meta.__newindex = _G

local SGrid = class()
MapMakerGrid = SGrid

function SGrid:initialize(minx, miny, maxx, maxy)
	self.grid = {}
	self.minx = minx
	self.miny = miny
	self.maxx = maxx
	self.maxy = maxy
end

function SGrid:getEmpty(x, y)
	return self.grid[x .. ":" .. y] != nil
end

function SGrid:setEmpty(x, y)
	self.grid[x .. ":" .. y] = nil
end

function SGrid:setWall(x, y)
	self.grid[x .. ":" .. y] = "w"
end

function SGrid:isWall(x, y)
	return self.grid[x .. ":" .. y] == "w"
end

function SGrid:setBox(x, y)
	self.grid[x .. ":" .. y] = "b"
end

function SGrid:isBox(x, y)
	return self.grid[x .. ":" .. y] == "b"
end

function SGrid:setHardBox(x, y)
	self.grid[x .. ":" .. y] = "h"
end

function SGrid:isHardBox(x, y)
	return self.grid[x .. ":" .. y] == "h"
end

function SGrid:setExplosiveBox(x, y)
	self.grid[x .. ":" .. y] = "e"
end

function SGrid:isExplosiveBox(x, y)
	return self.grid[x .. ":" .. y] == "e"
end

function SGrid:getPrintChar(x, y)
	local c = self.grid[x .. ":" .. y]
	if c == nil then return " " end
	if c == "w" then return "#" end
	if c == "b" then return "." end
	if c == "h" then return "&" end

	return "?"
end

function SGrid:print()
	local c = Color(150, 150, 150)
	for y = self.miny, self.maxy do
		for x = self.minx, self.maxx do
			MsgC(c, self:getPrintChar(x, y))
		end
		MsgC(c, "\n")
	end
end

local function loadMaps(rootFolder)
	local files, dirs = file.Find("data_static/*.txt", "GAME")
	for k, mapFile in ipairs(files) do
		loadAtomicMap(MapTypes, mapFile)
		local path = "materials/melonbomber/maptypes/" .. mapFile .. ".png"
		if file.Exists(path, "GAME") then
			resource.AddSingleFile(path)
		end
	end
end

function GM:LoadMaps()
	loadMaps()
end

GM:LoadMaps()