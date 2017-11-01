bump = require"lib.bump"
player = require"classes.player"
camera = require"classes.camera"
helper = require"lib.helper"
tlm = require "classes.tlm"

tileSize = 32

local controls = {up = 0, down = 0, left = 0, right = 0}
--local tiles = {{name = "solid", x = _G.tileSize, y = 0, w = _G.tileSize, h = _G.tileSize}}

function love.load()
	tlm:load()
	world = bump.newWorld(32)
	player:init(nil, 0, 0)
	world:add(player, player.x, player.y, _G.tileSize, _G.tileSize)
	--world:add(tiles[1], tiles[1].x, tiles[1].y, tiles[1].w, tiles[1].h)
	tlm:loadmap("level_1")
end

function love.update(dt)
	local xDir = controls.right - controls.left
	local yDir = controls.down - controls.up
	player.vx = xDir*player.speed
	player.vy = yDir*player.speed
	player:update(dt)
	local camX = (camera.x - player.x + love.graphics.getHeight()*0.5 + _G.tileSize) * dt * camera.speed
	local camY = (camera.y - player.y + love.graphics.getHeight()*0.5 + _G.tileSize) * dt * camera.speed
	camera:move(-1*camX, -1*camY)
end

function love.draw()
	camera:set()
	tlm:draw()
	love.graphics.setColor( 10, 255, 10, 0.9*255 )
	--love.graphics.rectangle("fill", _G.tileSize, 0, _G.tileSize, _G.tileSize)
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