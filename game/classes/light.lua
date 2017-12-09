local l = {}

function l.new(pos, c, br, r)
	local light = {}
	local position, color, brightness, range = pos or {x = 0, y = 0}, c or {r = 1, g = 1, b = 1, a = 1}, br or 1, r or 1
	
	function light.setPosition(self, newPos)
		position = newPos or {x = 0, y = 0}
	end
	
	function light.setColor(self, newCol)
		color = newCol or {r = 1, g = 1, b = 1, a = 1}
	end
	
	function light.setBrightness(self, newBrightness)
		brightness = newBrightness or 1
	end
	
	function light.setRange(self, newRange)
		range = newRange or 1
	end
	
	function light.getPosition(self)
		return position or {x = 0, y = 0}
	end
	
	function light.getColor(self)
		return color or {r = 0, g = 0, b = 0, a = 0}
	end
	
	function light.getBrightness(self)
		return brightness or 1
	end
	
	function light.getRange(self)
		return range or 1
	end
	
	function light.sendToShader(self, index, shader)
		shader:send("lights[" .. index .. "].position", {(position.x * camera.scaleX) - (camera.x / camera.scaleX), (position.y * camera.scaleY) - (camera.y / camera.scaleY)})
		shader:send("lights[" .. index .. "].color", {color.r, color.g, color.b, color.a})
		shader:send("lights[" .. index .. "].brightness", self:getBrightness())
		shader:send("lights[" .. index .. "].range", self:getRange())
	end
	
	return light
end

return l