local player = {}

player.name = "Player"

player.vx = 0
player.vy = 0

player.speed = 64
player.maxSpd = 64

player.x = 0
player.y = 0

player.spr = nil

local function filter(item, other)
	
end

function player:init(name,x,y,spr,speed,maxSpd)
	self.name = name or self.name
	self.spr = spr
	self.x = x
	self.y = y
	self.speed = speed or self.speed
	self.maxSpd = maxSpd or self.maxSpd
end

function player:update(dt)
	local xDir = controls.right - controls.left
	local yDir = controls.down - controls.up
	player.vx = xDir*player.speed
	player.vy = yDir*player.speed
	self.vx = math.max(-1 * self.maxSpd, math.min(self.vx, self.maxSpd))
	self.vy = math.max(-1 * self.maxSpd, math.min(self.vy, self.maxSpd))
	self.x = self.x + (self.vx * dt)
	self.y = self.y + (self.vy * dt)
	local actualX, actualY, cols, length = world:move(player, self.x, self.y)
	self.x = actualX
	self.y = actualY
end

function player:draw()
	love.graphics.setColor( 220, 0, 10, 0.9*255 )
	love.graphics.rectangle("fill", self.x*scale, self.y*scale, 32*scale, 32*scale)
end

return player