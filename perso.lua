perso = {}
listePerso = {}
function printListe()
    print("Liste des personnages:")
    for i, name in ipairs(listePerso) do
        print(i .. ": " .. name)
    end
end

function perso:newPerso(name, posX, posY, img)
    table.insert(listePerso, name)
    local newP = {}
    newP.name = name
    newP.posX = posX
    newP.posY = posY
    newP.hasPlan = true
    points = {{10, 10}, {10, 200}, {100, 200}, {100, 10}}
    newP.target = points[1]
    newP.ind = 1
    newP.speed = 0
    newP.isVisible = true
    print("create new personnage: " .. newP.name)

    if img then 
        newP.image = img
    else
        newP.image = love.graphics.newImage("assets/persoInit.png")
    end
    
    function newP:draw()
        if self.isVisible then
            --love.graphics.setColor(1, 1, 1)
            love.graphics.draw(self.image, self.posX, self.posY, 0, 1, 1)
            --print(self.name .. "drawn at " .. self.posX .. " , " .. self.posY)
        end
    end

    function newP:move(dx, dy)
        self.posX = self.posX + dx
        self.posY = self.posY + dy
    end
    
    function newP:moveToPoint(pointX, pointY)
        local dx = pointX - self.posX
        local dy = pointY - self.posY
        local distance = math.sqrt(dx * dx + dy * dy)

        if distance > 0.1 then
            local speed = 30
            local moveX = dx / distance * speed * love.timer.getDelta()
            local moveY = dy / distance * speed * love.timer.getDelta()

            self.posX = self.posX + moveX
            self.posY = self.posY + moveY
        else -- Arrivé à la cible
            self.posX = pointX
            self.posY = pointY --next target
            self.ind = self.ind % #points + 1
            self.target = points[self.ind]
        end
        --print(self.index)
    end


    function newP:update(dt)
        if self.hasPlan then
            self:moveToPoint(self.target[1], self.target[2])                      
        end

    end
    function newP:updateHero(dt)
        local dx = 0
        local dy = 0
        print("update hero in perso.lua!")
        if love.keyboard.isDown("up") then dy = - 100 * dt end
        if love.keyboard.isDown("down") then dy = 100 * dt end
        if love.keyboard.isDown("left") then dx = - 100 * dt end
        if love.keyboard.isDown("right") then dx = 100 * dt end 
        self:move(dx, dy)
    end

    return newP
end

return perso