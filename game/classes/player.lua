local player = {}

player.name = "Player"

player.vx = 0
player.vy = 0

player.speed = 64
player.maxSpd = 64

player.x = 0
player.y = 0

player.sprites = nil
player.sprite = nil
player.facing = 0 -- 0 = Up; 1 = Right; 2 = Down; 3 = Left
player.state = "idle"

local states = {
				["idle"] = nil,
				["attack"] = attack,
				["move"] = move

}

local function filter(item, other)
	
end

local function state(stateString)
	if states[stateString] == nil then return end
	
	states[stateString]()
end

function player:init(name,x,y,spritesTable,speed,maxSpd)
	self.name = name or self.name
	self.sprites = spritesTable
	self.sprite = self.sprites[self.facing + 1]
	self.x = x
	self.y = y
	self.speed = speed or self.speed
	self.maxSpd = maxSpd or self.maxSpd
end

function player:update(dt)
	local xDir = controls.right - controls.left
	local yDir = controls.down - controls.up
	
	self.vx = xDir*self.speed
	self.vy = yDir*self.speed
	
	if xDir ~= 0 and yDir ~= 0 then
		self.vx = self.vx / math.sqrt(2)
		self.vy = self.vy / math.sqrt(2)
	end
	
	self.vx = math.max(-1 * self.maxSpd, math.min(self.vx, self.maxSpd))
	self.vy = math.max(-1 * self.maxSpd, math.min(self.vy, self.maxSpd))
	
	if math.abs(self.vx) > math.abs(self.vy) then
		if self.vx < 0 then self.facing = 3 elseif self.vx > 0 then self.facing = 1 end
	else
		if self.vy < 0 then self.facing = 0 elseif self.vy > 0 then self.facing = 2 end
	end
	
	self.sprite = self.sprites[self.facing + 1]
	if self.sprite then
		if math.abs(self.vx) ~= 0 or math.abs(self.vy) ~= 0 then
			self.sprite:setEnabled(true)
		else
			self.sprite:setEnabled(false)
		end
		self.sprite:update(dt)
	end
	
	self.x = self.x + (self.vx * dt)
	self.y = self.y + (self.vy * dt)
	local actualX, actualY, cols, length = world:move(self, self.x, self.y)
	self.x = actualX
	self.y = actualY
end

function player:draw(scale)
	love.graphics.setColor( 225, 255, 255, 255 )
	--love.graphics.rectangle("fill", self.x*scale, self.y*scale, 32*scale, 32*scale)
	if self.sprite then
		self.sprite:draw(self.x, self.y)
	end
end

return player