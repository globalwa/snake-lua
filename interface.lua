Interface = {}

function Interface:load()
    self.color = {255, 255, 255, 1}
end

function Interface:update()
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
end

function Interface:draw()
    love.graphics.setColor(self.color)
    love.graphics.print(Snake.score)
end