bump = require"lib.bump"
player = require"classes.player"
camera = require"classes.camera"
helper = require"lib.helper"
sti = require"lib.sti"

scale = 2
tileSize = 32

local controls = {up = 0, down = 0, left = 0, right = 0}
--local tiles = {{name = "solid", x = _G.tileSize, y = 0, w = _G.tileSize, h = _G.tileSize}}

function love.load()
	love.graphics.setDefaultFilter( "nearest", "nearest", 1 )
	camera:scale(scale, scale)
	world = bump.newWorld(tileSize)
	player:init(nil, 0, 0, tileSize*2*scale, tileSize*2*scale)
	world:add(player, player.x, player.y, _G.tileSize, _G.tileSize)
	--world:add(tiles[1], tiles[1].x, tiles[1].y, tiles[1].w, tiles[1].h)
	map = sti("assets/maps/test.lua")
	
	for i,v in pairs(map.tiles) do
		if v.properties.solid == true then
			world:add(v, v.offset.x, v.offset.y, v.width, v.height)
		end
	end
end

function love.update(dt)
	local xDir = controls.right - controls.left
	local yDir = controls.down - controls.up
	player.vx = xDir*player.speed
	player.vy = yDir*player.speed
	player:update(dt)
	local camX = (camera.x - player.x*camera.scaleX + love.graphics.getWidth()*0.5*camera.scaleX + tileSize*2*camera.scaleX) * dt * camera.speed
	local camY = (camera.y - player.y*camera.scaleY + love.graphics.getHeight()*0.5*camera.scaleY - tileSize*0.5*camera.scaleY) * dt * camera.speed
	camera:move(-1*camX, -1*camY)
	map:update(dt)
end

function love.draw()
	love.graphics.setColor( 255, 255, 255 )
	map:draw(-camera.x, -camera.y, scale, scale)
	camera:set()
	love.graphics.setColor( 10, 255, 10, 0.9*255 )
	--love.graphics.rectangle("fill", tileSize, 0, tileSize, tileSize)
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
	if key == "escape" then
		love.event.quit()
	end
end