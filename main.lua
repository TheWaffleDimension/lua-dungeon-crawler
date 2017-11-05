bump = require"lib.bump"
player = require"classes.player"
camera = require"classes.camera"
helper = require"lib.helper"
sti = require"lib.sti"
tml = require"classes.map_loader"
objHandler = require"classes.object_handler"
socket = require"socket"

scale = 2
tileSize = 32

controls = {up = 0, down = 0, left = 0, right = 0}

function wait(s)
	s = tonumber(s) or 0.01
	local ntime = os.clock() + s
	repeat until os.clock() > ntime
end

function love.load()
	love.graphics.setDefaultFilter( "nearest", "nearest", 1 )
	camera:scale(scale, scale)
	world = bump.newWorld(tileSize)
	player:init(nil, 0, 0, nil, tileSize*scale*1.25, tileSize*scale*1.25)
	map = tml:load("test")
	objHandler:newObject(player)
	wait()
	world:add(player, player.x, player.y, tileSize, tileSize)
end

function love.update(dt)
	objHandler:update(dt)
	local camX = (camera.x - player.x*camera.scaleX + love.graphics.getWidth()*0.5*camera.scaleX + tileSize*2*camera.scaleX) * dt * camera.speed
	local camY = (camera.y - player.y*camera.scaleY + love.graphics.getHeight()*0.5*camera.scaleY - tileSize*0.5*camera.scaleY) * dt * camera.speed
	camera:move(-1*camX, -1*camY)
	--map:update(dt)
end

function love.draw()
	love.graphics.setColor( 255, 255, 255 )
	--map:draw(-camera.x, -camera.y, camera.scaleX, camera.scaleY)
	--map:bump_draw(world, -camera.x, -camera.y, scale, scale)
	camera:set()
	map:draw(scale)
	--player:draw()
	objHandler:draw()
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