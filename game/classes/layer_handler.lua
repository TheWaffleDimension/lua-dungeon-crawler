local layerHandler = {}

function layerHandler:newLayer(name, num, drawBool)
	map:addCustomLayer(tostring(name) or "Sprite Layer", tonumber(num) or 1)
	local layer = map.layers[tostring(name) or "Sprite Layer"]
	layer.objects = {}
	layer.drawBool = drawBool
	
	function layer:addObject(name, img, x, y, rot)
		if not self.objects[tostring(name) or "Default"] then
			self.objects[tostring(name) or "Default"] = {image = img, x = x, y = y, r = rot}
			return true
		end
		
		return false
	end
	
	function layer:update(dt)
		for i,v in pairs(self.objects) do
			local obj = objHandler:getObject(tostring(i))
			if obj then
				obj:update(dt)
				v.x = obj.x
				v.y = obj.y
			end
		end
	end
	
	function layer:draw()
		if self.drawBool then
			for i,v in pairs(self.objects) do
				local obj = objHandler:getObject(tostring(i))
				if obj then
					obj:draw()
				end
			end
		end
	end
	
	return layer
end

return layerHandler