Food = {}

local function findFoodPositions(l, s)
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
    self.minTimer = 5
    self.maxTimer = 8
    self.reward = 64
    self.timer = 0
    self.isCreated = false

    self.chosenTimer = nil
    self.x = nil
    self.y = nil

    if not self.positions then
        self.positions = {
            x = findFoodPositions(love.graphics.getWidth(), self.width),
            y = findFoodPositions(love.graphics.getHeight(), Food.height)
        }
    end
end

function Food:update(dt)
    if not self.isCreated then
        self:create()
    else
        self.timer = self.timer + dt
        if self.timer >= self.chosenTimer then
            self.isCreated = false
        end
    end
end

function Food:create()
    self.chosenTimer = love.math.random(self.minTimer, self.maxTimer)
    self.isCreated = true
    self.timer = 0

    local x, y

    while true do
        local positionIsFound = true

        x = self.positions.x[love.math.random(1, #self.positions.x)]
        y = self.positions.y[love.math.random(1, #self.positions.y)]

        for _, part in ipairs(Snake.parts) do
            if part.x == x and part.y == y then
                positionIsFound = false
                break
            end
        end

        if positionIsFound then
            break
        end
    end

    self.x = x
    self.y = y
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