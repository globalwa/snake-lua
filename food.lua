-- появление еды
-- сбор еды змейкой
-- отображение собранных очков

Food = {}

local function generatePositions(l, s)
    local positions = {}

    for i=0, (l-s), s do
        table.insert(positions, i)
    end

    return positions
end

function Food:load()
    self.color = {255, 0, 0, 1}
    self.width = 20
    self.height = self.width
    self.minTimer = 10
    self.maxTimer = 15
    self.reward = 100
    self.timer = 0
    self.isCreated = false
    self.isTaken = false

    self.chosenTimer = nil
    self.x = nil
    self.y = nil

    if not self.positions then
        self.positions = {
            x = generatePositions(love.graphics.getWidth(), self.width),
            y = generatePositions(love.graphics.getHeight(), Food.height)
        }
    end
end

function Food:update(dt)
    if not self.isCreated then
        self.chosenTimer = love.math.random(self.minTimer, self.maxTimer)
        self.timer = 0
        self.x = self.positions.x[love.math.random(1, #self.positions.x)]
        self.y = self.positions.y[love.math.random(1, #self.positions.y)]
        self.isCreated = true
    elseif self.isTaken then
        --
    else
        self.timer = self.timer + dt
        if self.timer >= self.chosenTimer then
            self.isCreated = false
        end
    end
end

function Food:draw()
    if self.isCreated then
        love.graphics.setColor(self.color)
        love.graphics.rectangle(
            "fill",
            self.x, self.y,
            self.width, self.height
        )
    end
end