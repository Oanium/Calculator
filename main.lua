Class = require "class"
require "clickBox"

function love.load()
    dispBox = ClickBox(255, 100, 160, 50, "")
    
    numbers = {}

    --the tostring at the end is the data
    for i = 1, 3 do
        numbers[tostring(i)] = ClickBox(200+(i*55), 200, 50, 50, tostring(i))
    end

    for i = 4, 6 do
        numbers[tostring(i)] = ClickBox(200+(i*55)-(55*3), 255, 50, 50, tostring(i))
    end

    for i = 7, 9 do
        numbers[tostring(i)] = ClickBox(200+(i*55)-(55*6), 310, 50, 50, tostring(i))
    end

    numbers["0"] = ClickBox(310, 365, 50, 50, "0")

    operators  ={}
    operators['+'] = ClickBox(300, 200, 50, 50, '+')
    operators['-'] = ClickBox(300, 200, 50, 50, '-')
    operators['*'] = ClickBox(300, 200, 50, 50, '*')
    operators['/'] = ClickBox(300, 200, 50, 50, '/')


    numDisplayed = {}
end

function love.update(dt)
    dispBox:checkCollision()
    for i, v in pairs(numbers) do
        v:checkCollision()
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        for i, v in pairs(numbers) do
            if x >= v.x and
            x <= v.x + v.width and
            y >= v.y and
            y <= v.y + v.height then

                v.pressed = true
                addToNumDisp = tostring(v.number)
                table.insert(numDisplayed, addToNumDisp)
               -- print(v.number)
            end
        end
    end
end


function love.draw()
    dispBox:render()
    for i,v in pairs(numbers) do
        v:render()
        if v.pressed then
--            love.graphics.print(v.number, dispBox.x + dispBox.width-10, dispBox.y + dispBox.height-12)
            if numDisplayed ~= nil then
                for i,v in ipairs(numDisplayed) do
                    love.graphics.print(v, dispBox.x + dispBox.width-(i*10), dispBox.y + dispBox.height-12)
                end
            end
        end
    end

end


