Part = {}

function Part:new(width, height, x, y, direction, isHead)
    local obj = {}
        obj.width = width
        obj.height = height
        obj.x = x
        obj.y = y
        obj.direction = direction
        obj.isHead = isHead
        obj.positions = {}

    setmetatable(obj, self)
    self.__index = self
    return obj
end