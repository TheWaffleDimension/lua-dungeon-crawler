local helper = {}

function helper:generateQuads(sizeX, sizeY, image, spacing, margin)
	size = size or tileSize
	spacing = spacing or 0
	margin = margin or 0
	local quads = {}
	local w = math.floor(image:getWidth() / sizeX)
	local h = math.floor(image:getHeight() / sizeY)
	
	for y = 0, h - 1 do
		for x = 0, w - 1 do
			table.insert(quads,
				love.graphics.newQuad(
					x*sizeX,
					y*sizeY,
					sizeX,
					sizeY,
					image:getWidth(),
					image:getHeight()
				)
			)
		end
	end
	
	return quads
end

function helper:stringSplit(str, sep)
   local sep, fields = sep or ":", {}
   local pattern = string.format("([^%s]+)", sep)
   str:gsub(pattern, function(c) fields[#fields+1] = c end)
   return fields
end

return helper