perso = {}

function perso:newPerso(name, posX, posY, img)
    local newP = {}
    newP.name = name

    newP.posX = posX
    newP.posY = posY
    if img then 
        newP.image = img
    else
        newP.image = love.graphics.newImage("assets/persoInit.png")
    end
    newP.speed = 0
    newP.isVisible = true



    function newP:draw()
        if self.isVisible then
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(self.image, self.posX, self.posY, 0, 1, 1)
            --print(self.name .. "drawn at " .. self.posX .. " , " .. self.posY)
        end
    end

    function newP:move(dx, dy)
        self.posX = self.psX + dx
        self.posY = self.posY + dy
    end
    
    
    newP.hasPlan = true
    points = {{10, 10}, {10, 200}, {100, 200}, {100, 10}}
    newP.target = points[1]
    newP.index = 1

    function newP:moveToPoint(pointX, pointY)
        local dx = pointX - self.posX
        local dy = pointY - self.posY
        local distance = math.sqrt(dx * dx + dy * dy)

        if distance > 0.1 then
            local speed = 20
            local moveX = dx / distance * speed * love.timer.getDelta()
            local moveY = dy / distance * speed * love.timer.getDelta()

            self.posX = self.posX + moveX
            self.posY = self.posY + moveY
        else -- Arrivé à la cible
            self.posX = pointX
            self.posY = pointY --next target
            self.index = self.index % #points + 1
            self.target = points[self.index]
        end
        print(self.index)
    end


    function newP:update(dt)
        if self.hasPlan then
            self:moveToPoint(self.target[1], self.target[2])           
        end
    end


    return newP
end

return perso
