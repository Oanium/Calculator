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

    operators  = {}
    operators['+'] = ClickBox(420, 200, 50, 50, '+')
    operators['-'] = ClickBox(420, 255, 50, 50, '-')
    operators['*'] = ClickBox(420, 310, 50, 50, '*')
    operators['/'] = ClickBox(420, 365, 50, 50, '/')


    currentPress = false

    numDisplayed = {}
    storeNumbers = {}
    stringConc = ""
    numResult = 0
    love.keyboard.keysPressed = {}
    operatorCount = 0
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    dispBox:checkCollision()
    for i, v in pairs(numbers) do
        v:checkCollision()
    end
    for i, v in pairs(operators) do
        v:checkCollision()
    end
    if love.keyboard.wasPressed('up') then
        check1()
    end

    love.keyboard.keysPressed = {}
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        for i, v in pairs(numbers) do
            if x >= v.x and
            x <= v.x + v.width and
            y >= v.y and
            y <= v.y + v.height then

                v.pressed = true
                addToNumDisp = tostring(v.data)
                table.insert(numDisplayed, addToNumDisp)
                
            end
        end
        for i, v in pairs(operators) do
            if x >= v.x and
            x <= v.x + v.width and
            y >= v.y and
            y <= v.y + v.height then

                operatorCount = operatorCount + 1

                if operatorCount == 2 then
                    numResult = 0

                    if v.data == '+' then
                        stringConc = ""
                        for i,v in ipairs(numDisplayed) do
                            stringConc = stringConc .. v
                        end
                        numResult = numResult + tonumber(stringConc)
                        stringConc = ""
                        for i, v in ipairs(storeNumbers) do
                           stringConc = stringConc .. v
                        end
                        
                        numResult = numResult + tonumber(stringConc)
                        operatorCount = 0

                    elseif v.data == '-' then
                        stringConc = ""
                        for i,v in ipairs(numDisplayed) do
                            stringConc = stringConc .. v
                        end
                        numResult = numResult + tonumber(stringConc)
                        stringConc = ""
                        for i, v in ipairs(storeNumbers) do
                           stringConc = stringConc .. v
                        end
                        
                        numResult = numResult - tonumber(stringConc)
                        operatorCount = 0 
                    elseif v.data == '*' then
                        stringConc = ""
                        for i,v in ipairs(numDisplayed) do
                            stringConc = stringConc .. v
                        end
                        numResult = numResult + tonumber(stringConc)
                        stringConc = ""
                        for i, v in ipairs(storeNumbers) do
                           stringConc = stringConc .. v
                        end
                        
                        numResult = numResult * tonumber(stringConc) 
                        operatorCount = 0
                    elseif v.data == '/' then
                        local num1 = 0
                        local num2 = 0
                        stringConc = ""

                        for i,v in ipairs(numDisplayed) do
                            stringConc = stringConc .. v
                        end
                        num1 = tonumber(stringConc)

                        stringConc = ""
                        for i, v in ipairs(storeNumbers) do
                           stringConc = stringConc .. v
                        end

                        num2 = tonumber(stringConc)
                        numResult = num1/num2

                        operatorCount = 0
                    end

                end
                storeNumbers = numDisplayed
                for k in pairs(numDisplayed) do
                    numDisplayed[k] = nil
                end
            end
        end
    end
end

function check1()
    for i, v in ipairs(numDisplayed) do
       print(v)
    end
end


function love.draw()
    dispBox:render()
    for i,v in pairs(numbers) do
        v:render()
        if v.pressed then
            if numDisplayed ~= nil then
                for i,v in ipairs(numDisplayed) do
                    love.graphics.print(v, dispBox.x + (i*10), dispBox.y + dispBox.height-12)
                end
            end
        end
    end

    love.graphics.print(tostring(numResult), 100, 100)

    for i,v in pairs(operators) do
        v:render()
    end

end


