require("snake")
require("food")

local function isFoodEaten(a, b)
    if a.x + a.width > b.x and a.x < b.x + b.width and a.y + a.height > b.y and a.y < b.y + b.height then
        return true
    end

    return false
end

function love.load()
    Snake:load()
    Food:load()
end

function love.update(dt)
    Snake:update(dt)
    Food:update(dt)

    if isFoodEaten(Snake.parts[1], Food) then
        Food:load()
    end
end

function love.draw()
    Snake:draw()
    Food:draw()
end