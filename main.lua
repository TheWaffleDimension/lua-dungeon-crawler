local bump = require"libs/bump"
local player = require"classes/player"
local camera = require"classes/camera"

function love.load()
	world = bump.newWorld(32)
	player:init(0, 0)
end

function love.update(dt)
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
        up = true
    end 
	if key == "s" or key == "down" then
		down = true
	end
end