local bump = require"libs/bump"
local player = require"classes/player"
local camera = require"classes/camera"

local controls = {up = 0, down = 0, left = 0, right = 0}

function love.load()
	world = bump.newWorld(32)
	player:init(0, 0)
end

function love.update(dt)
	local xDir = right - left
	local yDir = down - up
	local rotDir = (90 * xDir) + math.max((180 * yDir), 0)
	player.vx = vx + (math.sin(rotDir)*1)
	player.vy = vy + (math.cos(rotDir)*1)
	player:update(dt)
	camera:setPosition(player.x, player.y)
end

function love.draw()
	camera:set()
	player:draw()
	camera:unset()
end

function love.keypressed(key)
    if key=="w" or key=="up" then
        controls.up = 1
    end 
	if key == "s" or key == "down" then
		controls.down = 1
	end
	if key == "a" or key == "left" then
		controls.left = 1
	end
	if key == "d" or key == "right" then
		controls.right = 1
	end
end

function love.keyreleased(key)
    if key=="w" or key=="up" then
        controls.up = 0
    end 
	if key == "s" or key == "down" then
		controls.down = 0
	end
	if key == "a" or key == "left" then
		controls.left = 0
	end
	if key == "d" or key == "right" then
		controls.right = 0
	end
end