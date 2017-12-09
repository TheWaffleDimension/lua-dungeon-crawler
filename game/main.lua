bump = require"lib.bump"
player = require"classes.player"
camera = require"classes.camera"
helper = require"lib.helper"
tml = require"classes.map_loader"
objHandler = require"classes.object_handler"
socket = require"socket"
sprite = require"classes.sprite"
Light = require"classes.light"
Shader = require"classes.shader"

scale = 4
tileSize = 32

controls = {up = 0, down = 0, left = 0, right = 0}

lights = {}

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
	
	local l = Light.new( {x = 50, y = 50}, {r = 1, g = 1, b = 1, a = 1}, 1, 256 )
	table.insert(lights, l)
	
	local l2 = Light.new( {x = player.x, y = player.y}, {r = 1, g = 1, b = 1, a = 1}, 0.5, 64 )
	table.insert(lights, l2)
	
	shader = Shader.load("light")
	
	print(shader:getWarnings())
end

function love.update(dt)
	map:update(dt)
	objHandler:update(dt)
	lights[2]:setPosition({ x = ((player.x / camera.scaleX)/camera.scaleX) + 4, y = ((player.y / camera.scaleY)/camera.scaleY) + 4 })
	camera:smoothMove(player.x, player.y, dt)
	for i=1,#lights do
		lights[i]:sendToShader(i-1, shader)
	end
end

function love.draw()
	love.graphics.setColor( 128, 128, 128 )
	love.graphics.setShader(shader)
	camera:set()
	map:draw(scale)
	objHandler:draw(scale)
	love.graphics.setShader()
	--love.graphics.circle("fill", lights[1]:getPosition().x, lights[1]:getPosition().y, 100)
	camera:unset()
	love.graphics.print(tostring(love.timer.getFPS()), 10, 10)
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