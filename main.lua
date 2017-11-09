bump = require"lib.bump"
player = require"classes.player"
camera = require"classes.camera"
helper = require"lib.helper"
tml = require"classes.map_loader"
objHandler = require"classes.object_handler"
socket = require"socket"
sprite = require"classes.sprite"

scale = 4
tileSize = 32

controls = {up = 0, down = 0, left = 0, right = 0}

function wait(s)
	s = tonumber(s) or 0.01
	local ntime = os.clock() + s
	repeat until os.clock() > ntime
end

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest", 1)
	camera:scale(scale, scale)
	world = bump.newWorld(tileSize)
	local playerMove = sprite:new(love.graphics.newImage("assets/images/mage-move.png"), 8, 1, 1)
	local playerStrafe = sprite:new(love.graphics.newImage("assets/images/mage-move.png"), 8, 1, 1)
	player:init(nil, 0, 0, {playerMove, playerStrafe, playerMove, playerStrafe}, tileSize*scale*1.5, tileSize*scale*1.5)
	map = tml:load("test")
	objHandler:newObject(player)
	wait()
	world:add(player, player.x, player.y, tileSize*camera.scaleX, tileSize*camera.scaleY)
end

function love.update(dt)
	--map:update(dt)
	objHandler:update(dt)
	camera:smoothMove(player.x, player.y, dt)
end

function love.draw()
	love.graphics.setColor( 255, 255, 255 )
	love.graphics.print(tostring(love.timer.getFPS()), 10, 10)
	camera:set()
	map:draw(scale)
	objHandler:draw(scale)
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