local s = {}

function s.load(name)
	local text = ""
	for line in love.filesystem.lines("shaders/" .. name .. ".glsl") do
		text = text .. line .. "\n"
	end
	
	return love.graphics.newShader(text)
end

return s