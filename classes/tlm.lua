local tlm = {}

local quad = love.graphics.newQuad
local quads =
{
	quad(0, 0, 16, 16, 50, 16),
	quad(18, 0, 16, 16, 50, 16),
	quad(35, 0, 16, 16, 50, 16),
}

function tile(x, y, w, h, quad)
	local tile = {}
	
	tile.pos = require("classes.vec2"):new(x, y)
	tile.size = require("classes.vec2"):new(w, h)
	world:add(tile, x, y, w, h)
	tile.quad = quad
	
	return tile
end

function tlm:load()
	self.tiles = {}
	self.img = love.graphics.newImage("assets/images/tiles.png")
end

function tlm:draw()
	for i = 1,#self.tiles do
		for j = 1,#self.tiles[i] do
			
			if self.tiles[i][j] ~= nil then
				local tile = self.tiles[i][j]
				love.graphics.draw(self.img, tile.quad, tile.pos.x, tile.pos.y)
			end
			
		end
	end
end

function tlm:loadmap(mapname)
	local map = require("assets.maps."..mapname)
	
	for i = 1,map.height do self.tiles[i] = {} end
	
	for layer=1, #map.layers do
		local data = map.layers[layer].data
		local prop = map.layers[layer].prop
		
		for y = 1,map.height do
			for x = 1,map.width do
				
				local index = (y*map.height +(x+1)-map.width)+1
				
				if data[index] ~= 0 then
					
					local q = quads[data[index]]
					if q then
						self.tiles[y][x] = tile(16*x-16, 16*y-16, 16, 16, q)
					end
					
				end
				
			end
		end
	end
	
end

function tlm:destroy()
	
end

return tlm