require("snake")
require("food")
require("info")

local function isFoodEaten(a, b)
    if a.x + a.width > b.x and a.x < b.x + b.width and a.y + a.height > b.y and a.y < b.y + b.height then
        return true
    end

    return false
end

function love.load()
    Snake:load()
    Food:load()
    Info:load()
end

function love.update(dt)
    Snake:update(dt)
    Food:update(dt)

    if isFoodEaten(Snake.parts[1], Food) then
        Snake:extend()
        Snake:addPoints(Food.timer, Food.chosenTimer, Food.reward)
        Food:load()
    end
end

function love.draw()
    Snake:draw()
    Food:draw()
    Info:draw()
end