local sprites = {}

function sprites:new(image, collumns, rows, durationInSeconds)
	durationInSeconds = durationInSeconds or 0
	if type(durationInSeconds) == "string" then
		durationInSeconds = helper:stringSplit(timing, ":")[1] or 0
	elseif type(durationInSeconds) == "table" then
		durationInSeconds = durationInSeconds[1] or 0
	end
	
	local sprite = {}
	sprite.image = image
	sprite.collumns = collumns
	sprite.rows = rows
	sprite.duration = math.abs(durationInSeconds)
	sprite.frames = helper:generateQuads(image:getWidth()/collumns, image:getHeight()/rows, image, 0, 0)
	sprite.currentTime = 0
	sprite.enabled = true
	
	function sprite:setEnabled(bool)
		self.enabled = bool
	end
	
	function sprite:update(dt)
		if self.duration > 0 and self.enabled then
			self.currentTime = self.currentTime + dt
			if self.currentTime >= self.duration then
				self.currentTime = self.currentTime - self.duration
			end
		end
	end
	
	function sprite:draw(x, y)
		local frameNum = math.floor((self.currentTime / self.duration) * #self.frames) + 1
		print(frameNum)
		love.graphics.draw(self.image, self.frames[frameNum], x, y, 0, tileSize/(image:getWidth()/collumns)*camera.scaleX, tileSize/(image:getHeight()/rows)*camera.scaleY)
	end
	
	return sprite
end

return sprites