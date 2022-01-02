require("part")

Snake = {}

function Snake:load()
    self.color = {35, 165, 35}
    self.length = 15
    self.speed = 300
    self.timer = 0
    self.rate = 0.3
    self.newDirection = nil

    self.parts = self:generate()
end

function Snake:generate()
    local parts = {}

    local width = 20
    local height = width
    local x = love.graphics.getWidth() / 2
    local y = love.graphics.getHeight() / 2
    local isHead = true

    for i = 1, self.length do

        if i ~= 1 then
            isHead = false
        end

        parts[i] = Part:new(
            width, height,
            x, y,
            "left", isHead
        )

        x = x + width
    end

    return parts
end


function Snake:update(dt)
    self.timer = self.timer + dt
    if self.timer >= self.rate then
        self:setNewDirection()
        self:move(dt)

        if self:checkBoundaries() or self:checkCollision() then
            self:load()
        end

        self.timer = 0
    end

    self:getNewDirection()
end

function Snake:move(dt)
    for _, part in ipairs(self.parts) do
        local position = part.positions[1]

        if position then
            local flag = false

            if part.direction == "up" and part.y <= position.y then
                flag = true
            elseif part.direction == "down" and part.y >= position.y then
                flag = true
            elseif part.direction == "left" and part.x <= position.x then
                flag = true
            elseif part.direction == "right" and part.x >= position.x then
                flag = true
            end

            if flag then
                part.direction = position.futureDirection
                part.x = position.x
                part.y = position.y

                table.remove(part.positions, 1)
            end
        end

        if part.direction == "up" then
            part.y = part.y - part.height
        elseif part.direction == "down" then
            part.y = part.y + part.height
        elseif part.direction == "left" then
            part.x = part.x - part.width
        elseif part.direction == "right" then
            part.x = part.x + part.width
        end
    end
end

function Snake:getNewDirection()
    local currentDirection = self.parts[1].direction
    local newDirection = nil

    if love.keyboard.isDown("up") and currentDirection ~= "down" then
        newDirection = "up"
    elseif love.keyboard.isDown("down") and currentDirection ~= "up" then
        newDirection = "down"
    elseif love.keyboard.isDown("left") and currentDirection ~= "right" then
        newDirection = "left"
    elseif love.keyboard.isDown("right") and currentDirection ~= "left" then
        newDirection = "right"
    end

    if newDirection and newDirection ~= currentDirection then
        self.newDirection = newDirection
    end
end

function Snake:setNewDirection()
    if self.newDirection then
        local position = nil

        for _, part in ipairs(self.parts) do
            if part.isHead then
                position = {
                    futureDirection = self.newDirection,
                    x = part.x,
                    y = part.y
                }
                part.direction = self.newDirection
            else
                table.insert(part.positions, #part.positions+1, position)
            end
        end

        self.newDirection = nil
    end
end

function Snake:checkBoundaries()
    local leadingPart = self.parts[1]

    if leadingPart.x < 0 then
        return true
    elseif leadingPart.x + leadingPart.width > love.graphics.getWidth() then
        return true
    elseif leadingPart.y < 0 then
        return true
    elseif leadingPart.y + leadingPart.height > love.graphics.getHeight() then        
        return true
    end

    return false
end

function Snake:checkCollision()
    local leadingPart = nil

    for i, part in ipairs(self.parts) do
        if i == 1 then
            leadingPart = part
        else
            if leadingPart.x == part.x and leadingPart.y == part.y then
                return true
            end
        end
    end

    return false
end


function Snake:draw()
    for _, part in ipairs(self.parts) do
        love.graphics.rectangle(
            "fill",
            part.x, part.y,
            part.width, part.height
        )
    end
end