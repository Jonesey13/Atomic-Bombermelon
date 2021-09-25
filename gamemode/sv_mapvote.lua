util.AddNetworkString("map_type_list")
util.AddNetworkString("mb_mapvotes")

function GM:NetworkMapList()
	net.Start("map_type_list")
	for k, map in pairs(MapTypes) do
		net.WriteUInt(1, 8)
		net.WriteString(k)
		net.WriteString(map.name or k)
		net.WriteString(map.description or map.desc or "")
	end
	net.WriteUInt(0, 8)
	net.Broadcast()
end

function GM:NetworkMapVotes(ply)
	net.Start("mb_mapvotes")

	for k, map in pairs(self.MapVotes) do
		net.WriteUInt(1, 8)
		net.WriteEntity(k)
		net.WriteString(map.key)
	end
	net.WriteUInt(0, 8)


	if ply then
		net.Send(ply)
	else
		net.Broadcast()
	end
end

util.AddNetworkString("mb_votewinner")

function GM:DetermineVoteWinner()
	local maptype = table.Random(MapTypes)
	if self.MapVoting then
		self.MapVoting = false
		local votes = {}
		for ply, map in pairs(self.MapVotes) do
			if IsValid(ply) && ply:IsPlayer() then
				votes[map] = (votes[map] or 0) + 1
			end
		end

		local maxvotes = 0
		for k, v in pairs(votes) do
			if v > maxvotes then
				maxvotes = v
			end
		end

		local maps = {}
		for k, v in pairs(votes) do
			if v == maxvotes then
				table.insert(maps, k)
			end
		end

		if #maps > 0 then
			maptype = table.Random(maps)
			print("Map " .. maptype.key .. " selected with " .. maxvotes .. " votes")
		end
	end

	print("New map is: " .. (maptype.name or "error"))

	if self:GetGameState() == 3 then
		net.Start("mb_votewinner")

		net.WriteString(maptype.key)

		net.Broadcast()
	end

	self.CurrentMapType = maptype
end

concommand.Add("mb_votemap", function (ply, com, args)
	if GAMEMODE.MapVoting then
		if #args < 1 then
			return
		end

		local found
		for k, map in pairs(MapTypes) do
			if map.key == args[1] then
				found = map
				break
			end
		end
		if !found then
			ply:ChatPrint("Invalid map " .. args[1])
			return
		end

		GAMEMODE.MapVotes[ply] = found
		GAMEMODE:NetworkMapVotes()
	end
end)