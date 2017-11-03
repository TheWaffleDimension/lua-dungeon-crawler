local tml = {}

local cache = {}
local maps = {}

local function get_decompressed_data(data)
	local ffi     = require "ffi"
	local d       = {}
	local decoded = ffi.cast("uint32_t*", data)

	for i = 0, data:len() / ffi.sizeof("uint32_t") do
		table.insert(d, tonumber(decoded[i]))
	end

	return d
end

local function layer_load(layer)
	local layerData = {}
	if layer.encoding then
		if layer.encoding == "base64" then
			assert(require "ffi", "Compressed maps require LuaJIT FFI.\nPlease Switch your interperator to LuaJIT or your Tile Layer Format to \"CSV\".")
			local fd  = love.filesystem.newFileData(layer.data, "data", "base64"):getString()

			if not layer.compression then
				layerData.data = get_decompressed_data(fd)
			else
				assert(love.math.decompress, "zlib and gzip compression require LOVE 0.10.0+.\nPlease set your Tile Layer Format to \"Base64 (uncompressed)\" or \"CSV\".")

				if layer.compression == "zlib" then
					local data = love.math.decompress(fd, "zlib")
					layerData.data = get_decompressed_data(data)
				end

				if layer.compression == "gzip" then
					local data = love.math.decompress(fd, "gzip")
					layerData.data = get_decompressed_data(data)
				end
			end
		end
	end
	
	layerData.x = (layer.x or 0) + layer.offsetx
	layerData.y = (layer.y or 0) + layer.offsety
	layerData.solid = layer.properties["collidable"]
	
	return layerData
end

function tml:load(name)
	local map = {}
	local mapFile = require("assets.maps." .. name)
	map.id = mapFile.properties["id"] or nil
	map.tileset = love.graphics.newImage(mapFile.tileSets[1].image)
	map.layers = {}
	map.tiles = {}
	map.solid_tiles = {}
	
	for i,v in pairs(mapFile.layers) do
		table.insert(map.layers, layer_load(v))
		
	end
end
