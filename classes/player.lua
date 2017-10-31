local player = {}

player.vx = 0
player.vy = 0

player.maxSpd = 16

player.x = 0
player.y = 0

player.spr = nil

function player:init(x,y,spr,maxSpd)
	self.spr = spr
	self.x = x
	self.y = y
	self.maxSpd = maxSpd
end

function player:update(dt)
	self.x = self.x + (self.vx * dt)
	self.y = self.y + (self.vy * dt)
end

function player:draw()
	love.graphics.setColor( 220, 0, 10, 0.9*255 )
	love.graphics.rectangle(self.x, self.y, self.spr:getWidth(), self.spr:getHeight())
end

return player