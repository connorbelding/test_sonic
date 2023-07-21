local green_hill_data = require('graphics/levels/green_hill/data')
local green_hill_img = love.graphics.newImage('/graphics/levels/green_hill/greenhillzone.png')
local first = green_hill_data[1]
local second = green_hill_data[2]
---@diagnostic disable-next-line: missing-parameter, param-type-mismatch
local first_piece = love.graphics.newQuad(first.x_pos, first.y_pos, first.width, first.height, green_hill_img)
---@diagnostic disable-next-line: missing-parameter, param-type-mismatch
local second_piece = love.graphics.newQuad(second.x_pos, second.y_pos, second.width, second.height, green_hill_img)
local SCALE = 2.5
local CAMERA_OFFSET = { x = 0, y = 0 }
local ARROW_ISDOWN = {
    up = false,
    down = false,
    left = false,
    right = false
}
local PLAYER = {
    height = 180,
    width = 130,
    x = 0,
    y = 0
}
local TESTFLOOR = {
    0, 418,
    354, 422,
    544, 388,
    775, 381,
    994, 427,
    1240, 472,
    1349, 474,
    1567, 463,
    1745, 445,
    1846, 443,
    1920, 450,
    1920, 437,
    0, 437
}

function love.load()
    love.graphics.setBackgroundColor(0.4, 0.6, 0.5, 1)
end

function love.draw(t)
    love.graphics.setColor(0.2, 0.3, 0.7, 1)
    love.graphics.polygon("fill", TESTFLOOR)
    love.graphics.setColor(0.4, 0.4, 0.4, 1)
    love.graphics.rectangle('fill', PLAYER.x - CAMERA_OFFSET.x, PLAYER.y - CAMERA_OFFSET.y, PLAYER.width, PLAYER.height)
end

function love.update(t)
    if ARROW_ISDOWN.up == true then
        CAMERA_OFFSET.y = CAMERA_OFFSET.y - 1
    end
    if ARROW_ISDOWN.down == true then
        CAMERA_OFFSET.y = CAMERA_OFFSET.y + 1
    end
    if ARROW_ISDOWN.left == true then
        CAMERA_OFFSET.x = CAMERA_OFFSET.x - 1
    end
    if ARROW_ISDOWN.right == true then
        CAMERA_OFFSET.x = CAMERA_OFFSET.x + 1
    end
    if IsArrowKeydown() then
        LevelFunc(TESTFLOOR)
    end
end

function love.keypressed(key)
    if (key == 'up') then
        if ARROW_ISDOWN.down then
            return
        end
        ARROW_ISDOWN.up = true
        print('up')
    end
    if (key == 'down') then
        if ARROW_ISDOWN.up then
            return
        end
        ARROW_ISDOWN.down = true
        print('down')
    end
    if (key == 'left') then
        if ARROW_ISDOWN.right then
            return
        end
        ARROW_ISDOWN.left = true
        print('left')
    end
    if (key == 'right') then
        if ARROW_ISDOWN.left then
            return
        end
        ARROW_ISDOWN.right = true
        print('right')
    end
end

function love.keyreleased(key)
    if (key == 'up') then
        ARROW_ISDOWN.up = false
        print('up released')
    end
    if (key == 'down') then
        ARROW_ISDOWN.down = false
        print('down released')
    end
    if (key == 'left') then
        ARROW_ISDOWN.left = false
        print('left released')
    end
    if (key == 'right') then
        ARROW_ISDOWN.right = false
        print('right released')
    end
end

-----------------
function LevelFunc(table)
    if (type(table) ~= 'table') then
        error("first arg must be a table")
    end
    for index, value in pairs(table) do
        if index % 2 > 0 then
            table[index] = value - CAMERA_OFFSET.x
        else
            table[index] = value - CAMERA_OFFSET.y
        end
    end
end

function IsArrowKeydown()
    local isDown = false
    for k, v in pairs(ARROW_ISDOWN) do
        if v == true then
            isDown = true
            break
        end
    end
    return isDown
end
