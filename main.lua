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
    operators['='] = ClickBox(420, 365+55, 50, 50, '=')
    operators['C'] = ClickBox(420+55, 200, 50, 50, 'C')

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
                
                
                if v.data == '+' then
                    wuhOp = '+'
                    
                    for i, v in ipairs(numDisplayed) do
                        storeNumbers[i] = v
                    end

                    for k in pairs(numDisplayed) do
                        numDisplayed[k] = nil
                    end
                elseif v.data == '-' then
                    wuhOp = '-'
                    
                    for i, v in ipairs(numDisplayed) do
                        storeNumbers[i] = v
                    end

                    for k in pairs(numDisplayed) do
                        numDisplayed[k] = nil
                    end
                elseif v.data == '*' then
                    wuhOp = '*'
                    
                    for i, v in ipairs(numDisplayed) do
                        storeNumbers[i] = v
                    end

                    for k in pairs(numDisplayed) do
                        numDisplayed[k] = nil
                    end
                elseif v.data == '/' then
                    wuhOp = '/'

                    for i, v in ipairs(numDisplayed) do
                        storeNumbers[i] = v
                    end

                    for k in pairs(numDisplayed) do
                        numDisplayed[k] = nil
                    end
                elseif v.data == '=' then

                    if #storeNumbers == 0 then
                        stringConc = ""
                        for i,v in ipairs(numDisplayed) do
                            stringConc = stringConc .. v
                        end
                        numResult = tonumber(stringConc)

                        break
                    end
                    stringConc = ""
                    for i,v in ipairs(numDisplayed) do
                        stringConc = stringConc .. v
                    end
                    num1 = tonumber(stringConc)

                    

                    stringConc  = ""
                    for i,v in ipairs(storeNumbers) do
                        stringConc = stringConc .. v
                    end
                    num2 = tonumber(stringConc)
                    
                    numResult = 0
                        if wuhOp == '+' then
                            numResult = num1 + num2
                        elseif wuhOp == '-' then
                            numResult = num2 - num1
                        elseif wuhOp == '*' then
                            numResult = num1 * num2
                        elseif wuhOp == '/' then
                            numResult = num2 / num1
                        end
                    for k in pairs(numDisplayed) do
                        numDisplayed[k] = nil
                    end
                elseif v.data == 'C' then
                    if #numDisplayed ~= 0 then
                        for v in pairs(numDisplayed) do
                            numDisplayed[v] = nil
                        end
                    end

                    if #storeNumbers ~= 0 then
                        for v in pairs(storeNumbers) do
                            storeNumbers[v] = nil
                        end
                    end

                    numResult = 0
                end
            end
        end
    end
end

function check1()
    for i, v in ipairs(numDisplayed) do
       print(v)
    end
    for i, v in ipairs(storeNumbers) do
       print(v)
    end
end


function whenEqualPressed()

end

function love.draw()
    love.graphics.rectangle("line", 255, 100, 160, 50)
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

    love.graphics.print(numResult, 100, 100)

    for i,v in pairs(operators) do
        v:render()
    end

end


