Info = {}

function Info:load()
    self.color = {255, 255, 255, 1}
end

function Info:draw()
    love.graphics.setColor(self.color)
    love.graphics.print(Snake.score)
end