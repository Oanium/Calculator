ClickBox = Class{}

function ClickBox:init(x, y, width, height, data)
	self.x = x
	self.y = y
	self.width = width
	self.height = height
	self.fill = "line"
	self.data = data
	self.pressed = false
end

function ClickBox:checkCollision()
	if love.mouse.getX() >= self.x and
        love.mouse.getX() <= self.x + self.width and
        love.mouse.getY() >= self.y and
        love.mouse.getY() <= self.y + self.height then
        self.fill = "fill"
    else 
    	self.fill = "line"
    end
end



function ClickBox:render()
	love.graphics.rectangle(self.fill, self.x, self.y, self.width, self.height)
	love.graphics.print(self.data, self.x+(self.width/2)-4, self.y+(self.height/2)-4)
end