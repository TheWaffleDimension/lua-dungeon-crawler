_G.bump = require"lib.bump"
_G.player = require"classes.player"
_G.camera = require"classes.camera"
_G.helper = require"lib.helper"

local controls = {up = 0, down = 0, left = 0, right = 0}

function love.load()
	world = bump.newWorld(32)
	player:init(0, 0)
end

function love.update(dt)
	local xDir = controls.right - controls.left
	local yDir = controls.down - controls.up
	player.vx = xDir*8
	player.vy = yDir*8
	player:update(dt)
	camera:setPosition(player.x - love.graphics.getWidth()/2 + 16, player.y - love.graphics.getHeight()/2 + 16)
end

function love.draw()
	camera:set()
	love.graphics.setColor( 10, 255, 10, 0.9*255 )
	love.graphics.rectangle("fill", 0, 0, 32, 32)
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