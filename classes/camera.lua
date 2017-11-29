camera = {}
camera.name = "Camera"
camera.x = 0
camera.y = 0
camera.scaleX = 1
camera.scaleY = 1
camera.rotation = 0
camera.speed = 0.1

function camera:set()
  love.graphics.push()
  love.graphics.rotate(-self.rotation)
  love.graphics.scale(1 / self.scaleX, 1 / self.scaleY)
  love.graphics.translate(-self.x, -self.y)
end

function camera:unset()
  love.graphics.pop()
end

function camera:smoothMove(targetX, targetY, dt)
	local w = love.graphics.getWidth()
	local h = love.graphics.getHeight()
	
	local delta_x = (self.x - targetX) + (w/2 + tileSize/2)*self.scaleX
	local delta_y = (self.y - targetY) + (h/2 + tileSize/2)*self.scaleY
	
	self:move(-1 * delta_x * self.speed * dt, -1 * delta_y * self.speed * dt)
end

function camera:move(dx, dy)
  self.x = self.x + (dx or 0)
  self.y = self.y + (dy or 0)
end

function camera:rotate(dr)
  self.rotation = self.rotation + dr
end

function camera:scale(sx, sy)
  sx = sx or 1
  self.scaleX = self.scaleX * sx
  self.scaleY = self.scaleY * (sy or sx)
end

function camera:setSpeed(spd)
	self.speed = spd
end

function camera:setPosition(x, y)
  self.x = x or self.x
  self.y = y or self.y
end

function camera:setScale(sx, sy)
  self.scaleX = sx or self.scaleX
  self.scaleY = sy or self.scaleY
end

return camera