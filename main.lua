require("snake")
require("food")
require("interface")

local function isFoodEaten(a, b)
    return a.x + a.width > b.x and a.x < b.x + b.width and a.y + a.height > b.y and a.y < b.y + b.height
end

function love.load()
    Snake:load()
    Food:load()
    Interface:load()
end

function love.update(dt)
    Snake:update(dt)
    Food:update(dt)

    local snakeHead = Snake.parts[1]
    if isFoodEaten(snakeHead, Food) then
        Snake:extend()
        Snake:getReward(Food.timer, Food.rate, Food.reward)
        Food:load()
    end

    Interface:update()
end

function love.draw()
    Snake:draw()
    Food:draw()
    Interface:draw()
end