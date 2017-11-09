local tml = {}

local maps = {}
local tilesets = {}

function tml:getMap(name)
	
end

local function loadLayer(layerData)
	if not layerData then return nil end
	
	local layer = {}
	
	layer.name = tostring(layerData.name):lower()
	layer.type = layerData.type
	
	layer.x = layerData.x
	layer.y = layerData.y
	layer.offsetX = layerData.offsetx
	layer.offsetY = layerData.offsety
	
	layer.w = layerData.width
	layer.h = layerData.height
	
	layer.data = layerData.data
	
	layer.solid = false
	
	if layer.name == "solid" or layerData.properties["solid"] == true then
		layer.solid = true
	end
	
	layer.transparency = ( 1 - layerData.opacity)
	layer.visible = layerData.visible
	
	return layer
end

function tml:load(name)
	local map = {}
	local mapFile = require("assets.maps." .. name)
	map.id = mapFile.properties["id"] or nil
	
	if not tilesets[mapFile.tilesets[1].name] then
		map.tileset = mapFile.tilesets[1]
		local fileName = helper:stringSplit(map.tileset.image, "/")[#helper:stringSplit(map.tileset.image, "/")]
		map.tileset.image = love.graphics.newImage("assets/images/" .. fileName)
		tilesets[map.tileset.name] = map.tileset
	else
		map.tileset = tilesets[mapFile.tilesets[1].name]
	end
	
	map.layers = {}
	map.tiles = {}
	map.solid_tiles = {}
	
	map.tsX = mapFile.tilewidth
	map.tsY = mapFile.tileheight
	
	map.scaleFactor = tileSize / ((map.tsX + map.tsY)/2)
	
	map.properties = {}
	for i,v in pairs(mapFile.properties) do
		map.properties[tostring(i)] = v
	end
	
	map.quads = helper:generateQuads(
		math.floor(map.tsX),
		math.floor(map.tsY),
		map.tileset.image,
		map.tileset.spacing,
		map.tileset.margin
	)
	
	for i,v in pairs(mapFile.layers) do
		local layer = loadLayer(v)
		if layer ~= nil then
			local numOfTilesInLayer = layer.w * layer.h
			for y = 0, layer.h - 1 do
				for x = 0, layer.w - 1 do
					local tile = {}
					tile.x = x
					tile.y = y
					tile.id = ((x + (y * layer.w)) + 1)
					tile.image = layer.data[tile.id]
					tile.layer = layer
					if tile.image ~= 0 then
						if layer.solid == true then
							table.insert(map.solid_tiles, tile)
							print(#map.solid_tiles)
						end
						
						map.tiles[tile.id * 10^((i - 1)*10)] = tile
					end
				end
			end
			
			table.insert(map.layers, layer)
		end
	end
	
	for i,v in pairs(map.solid_tiles) do
		world:add(v, ((v.x * map.tsX) + v.layer.offsetX) * map.scaleFactor * camera.scaleX, ((v.y * map.tsY) + v.layer.offsetY) * map.scaleFactor * camera.scaleY, tileSize*camera.scaleX, tileSize*camera.scaleY)
	end
	
	function map:draw(optionalScale)
		local skipped = {}
	
		optionalScale = optionalScale*2 or 1
		for i,v in pairs(self.tiles) do
			if v.image ~= 0 then
				if v.layer.solid then
					table.insert(skipped, v)
				else
					love.graphics.draw(self.tileset.image, self.quads[v.image], ((v.x * self.tsX) + v.layer.offsetX) * optionalScale, ((v.y * self.tsY) + v.layer.offsetY) * optionalScale, 0, optionalScale, optionalScale)
				end
			end
		end
		
		for i,v in pairs(skipped) do
			if v.image ~= 0 then
				love.graphics.draw(self.tileset.image, self.quads[v.image], ((v.x * self.tsX) + v.layer.offsetX) * optionalScale, ((v.y * self.tsY) + v.layer.offsetY) * optionalScale, 0, optionalScale, optionalScale)
			end
		end
	end
	
	function map:update(dt)
		for i,v in pairs(self.solid_tiles) do
			--love.graphics.draw(self.tileset.image, self.quads[v.image], ((v.x * self.tsX) + v.layer.offsetX) * optionalScale, ((v.y * self.tsY) + v.layer.offsetY) * optionalScale, 0, optionalScale, optionalScale)
			local exists = world:hasItem(v)
			if exists then
				world:update(v, ((v.x * self.tsX) + v.layer.offsetX) * self.scaleFactor, ((v.y * self.tsY) + v.layer.offsetY) * self.scaleFactor, tileSize*camera.scaleX, tileSize*camera.scaleY)
			end
		end
	end
	
	function map:unload()
		for i,v in pairs(self.solid_tiles) do
			--love.graphics.draw(self.tileset.image, self.quads[v.image], ((v.x * self.tsX) + v.layer.offsetX) * optionalScale, ((v.y * self.tsY) + v.layer.offsetY) * optionalScale, 0, optionalScale, optionalScale)
			local exists = world:hasItem(v)
			if exists then
				world:remove(v)
			end
		end
	end
	
	table.insert(maps, map)
	return map
end

return tml