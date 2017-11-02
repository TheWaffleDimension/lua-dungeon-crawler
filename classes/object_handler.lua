local handler = {}

local objects = {}

function handler:newObject(object)
	local id = #objects + 1
	objects[id] = object
	return id
end

function handler:getObject(idOrName)
	local obj = nil
	if type(idOrName) == "string" then
		for i,v in pairs(objects) do
			if v.name == name then
				obj = v
				break
			end
		end
	elseif type(idOrName) == "number" then
		obj = objects[idOrName]
	end
	
	if obj then
		return obj
	end
end

function handler:removeObject(idOrName)
	local id = nil
	
	if type(idOrName) == "number" then
		id = idOrName
	elseif type(idOrName) == "string" then
		for i,v in pairs(objects) do
			if v.name == name then
				id = i
				break
			end
		end
	end
	
	if id then
		table.remove(objects, id)
	end
end

function handler:update(dt)
	for i,v in pairs(objects) do
		v:update(dt)
	end
end

function handler:draw()
	for i,v in pairs(objects) do
		v:draw()
	end
end

return handler