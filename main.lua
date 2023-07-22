local SONIC_FRAME_DATA = require('graphics/characters/sonic/data')
local SONIC_IMG = love.graphics.newImage('graphics/characters/sonic/sonic1_sonic.png')
local SCALE = 3.5
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
local SONIC_ANIM_GROUP_NAMES = {
    IDLE = 'idle'
}
local CURRENT_QUAD = nil

local CURRENT_SONIC_FRAME = nil
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
    CURRENT_SONIC_FRAME = Get_Sonic_Frame(SONIC_FRAME_DATA, SONIC_ANIM_GROUP_NAMES.IDLE, 1)
    CURRENT_QUAD = love.graphics.newQuad(CURRENT_SONIC_FRAME.x_pos, CURRENT_SONIC_FRAME.y_pos, CURRENT_SONIC_FRAME.width,
        CURRENT_SONIC_FRAME.height, SONIC_IMG)
end

function love.draw(t)
    love.graphics.scale(SCALE, SCALE)
    love.graphics.draw(SONIC_IMG, CURRENT_QUAD, 0, 0)
end

function love.update(t)

end

function love.keypressed(key)

end

function love.keyreleased(key)

end

-------------
function Get_Sonic_Frame(t, k, index)
    if type(t) ~= 'table' then
        error("first arg must be table")
    end

    if not Key_In_Table_Check(t, k) then
        error("second arg key does not exist in sonic frames data")
    end

    if index > #SONIC_FRAME_DATA[k] then
        error("index is larger than length of subtable")
    end


    local x = t[k][index]
    x['index'] = index

    return x
end

function Key_In_Table_Check(t, key)
    return t[key] ~= nil
end
