local e = {}

e.id = 0

function e.new()
	local entity = {}
	entity.id = e.id
	entity.components = {}
	e.id = e.id + 1
	
	entity.init = function(self)
		
	end
	
	entity.update = function(self, dt)
		
	end
	
	entity.draw = function(self)
		
	end
	
end

return e