local controls = {}
local keys = {}

function controls:getKeys()
	return keys
end

function love.keypressed(key)
	keys[key] = true
end

function love.keyreleased(key)
	keys[key] = false
end

return controls