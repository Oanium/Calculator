Class = require "class"
require "clickBox"

function love.load()
    dispBox = ClickBox(55, 100, 160, 50, "")
    
    numbers = {}

    click = love.audio.newSource("click.ogg", "static")
    --the tostring at the end is the data
    for i = 1, 3 do
        numbers[tostring(i)] = ClickBox((i*55), 200, 50, 50, tostring(i))
    end

    for i = 4, 6 do
        numbers[tostring(i)] = ClickBox((i*55)-(55*3), 255, 50, 50, tostring(i))
    end

    for i = 7, 9 do
        numbers[tostring(i)] = ClickBox((i*55)-(55*6), 310, 50, 50, tostring(i))
    end

    numbers["0"] = ClickBox(110, 365, 50, 50, "0")

    operators  = {}
    operators['+'] = ClickBox(165+55, 200, 50, 50, '+')
    operators['-'] = ClickBox(165+110, 200, 50, 50, '-')
    operators['*'] = ClickBox(165+55, 255, 50, 50, '*')
    operators['/'] = ClickBox(165+110, 255, 50, 50, '/')
    operators['='] = ClickBox(165+55, 365, 50, 50, '=')
    operators['C'] = ClickBox(165+110, 365, 50, 50, 'C')

    currentPress = false

    numDisplayed = {}
    storeNumbers = {}
    stringConc = ""
    numResult = 0
    love.keyboard.keysPressed = {}
    operatorCount = 0

    love.graphics.setBackgroundColor(162/255, 157/255, 156/255)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    --[[
    dispBox:checkCollision()
    for i, v in pairs(numbers) do
        v:checkCollision()
    end
    for i, v in pairs(operators) do
        v:checkCollision()
    end

    ]]

    if numResult == nil then 
        numResult = 0
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

                love.audio.play(click)
                v.pressed = true
                addToNumDisp = tostring(v.data)
                if #numDisplayed <= 15 then
                    table.insert(numDisplayed, addToNumDisp)
                end            
            end
        end
        for i, v in pairs(operators) do
            if x >= v.x and
            x <= v.x + v.width and
            y >= v.y and
            y <= v.y + v.height then
                
                love.audio.play(click)
                if v.data == '+' then
                    wuhOp = '+'

                    storeNumbers = {unpack(numDisplayed)}

                    for k in pairs(numDisplayed) do
                        numDisplayed[k] = nil
                    end
                elseif v.data == '-' then
                    wuhOp = '-'
                    
                    storeNumbers = {unpack(numDisplayed)}

                    for k in pairs(numDisplayed) do
                        numDisplayed[k] = nil
                    end
                elseif v.data == '*' then
                    wuhOp = '*'
                    
                    storeNumbers = {unpack(numDisplayed)}

                    for k in pairs(numDisplayed) do
                        numDisplayed[k] = nil
                    end
                elseif v.data == '/' then
                    wuhOp = '/'

                    storeNumbers = {unpack(numDisplayed)}

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
                            if num1 ~= nil then 
                                numResult = num1 + num2
                            end
                        elseif wuhOp == '-' then
                            if num1 ~= nil then
                                numResult = num2 - num1
                            end
                        elseif wuhOp == '*' then
                            if num1 ~= nil then
                                numResult = num1 * num2
                            end
                        elseif wuhOp == '/' then
                            if num1 ~= nil then
                                numResult = num2 / num1
                            end
                        end

                    for k in pairs(storeNumbers) do
                        storeNumbers[k] = nil
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

function love.draw()
    love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", 55, 100, 160, 50)
    love.graphics.setColor(1, 1, 1)
    
    for i,v in pairs(numbers) do
        
        v:render()
        if v.pressed then
            if numDisplayed ~= nil then
                love.graphics.setColor(1, 1, 1)
                for i,v in ipairs(numDisplayed) do

                    love.graphics.print(v, dispBox.x + (i*10)-10, dispBox.y)
                end
            end
            if storeNumbers ~= nil then
                for i,v in ipairs(storeNumbers) do
                    love.graphics.print(v, dispBox.x + (i*10)-10, dispBox.y+14)
                end
            end
        end
    end

    if numResult ~= nil then
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(numResult, dispBox.x, dispBox.y + dispBox.height-14)
    end
    for i,v in pairs(operators) do
        v:render()
    end

end


