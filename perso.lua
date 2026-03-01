perso = {}
listePerso = {}
sfxComida = love.audio.newSource("assets/sons/comida.wav", "static")
ball1 = love.graphics.newImage("assets/ennemi/ball1.png")
ball2 = love.graphics.newImage("assets/ennemi/ball2.png")
ball3 = love.graphics.newImage("assets/ennemi/ball3.png")
ball4 = love.graphics.newImage("assets/ennemi/ball4.png")
ball5 = love.graphics.newImage("assets/ennemi/ball5.png")
ball6 = love.graphics.newImage("assets/ennemi/ball6.png")
ball7 = love.graphics.newImage("assets/ennemi/ball7.png")
ball8 = love.graphics.newImage("assets/ennemi/ball8.png")
framesBall = {}
framesBall = {ball1, ball2, ball3, ball4, ball5, ball6, ball7, ball8 }
currentFrame = 1
nextFrame = 1

function perso:newPerso(name, posX, posY, img, plan, madimg)
    
    local newP = {}
    newP.name = name
    newP.posX = posX
    newP.posY = posY
    newP.speed = 1
    if madimg then newP.madimg = madimg else newP.madimg = img end
        
    points1 = {{10, 10}, {10, 200}, {100, 200}, {100, 10}}
    points2 = {{40, 180}, {500, 180}}
    points3 = {{10, 470}, {500, 470}}
    newP.points = {}

    if plan == 0 then newP.hasPlan = false
    else  newP.hasPlan = true
        if plan == 1 then newP.points = points1 end
        if plan == 2 then newP.points = points2 end 
        if plan == 3 then newP.points = points3 end
        print(newP.name .. " has plan " .. plan) 
        newP.posX = newP.points[1][1]
        newP.posY = newP.points[1][2]
    end

    newP.target = newP.points[2]
    newP.ind = 1
    newP.isVisible = true
    newP.isAnim = false
    newP.giveDamage = 1
    newP.collisions = 0
    newP.badTemper = false
    print("create new personnage: " .. newP.name)
    
    if img then 
        newP.image = img
    else
        newP.image = love.graphics.newImage("assets/persoInit.png")
    end
    
    function newP:draw()
        if self.isVisible then
            --love.graphics.setColor(1, 1, 1)
            if self.badTemper then love.graphics.draw(self.madimg, self.posX, self.posY, 0, 2, 2)
            else love.graphics.draw(self.image, self.posX, self.posY, 0, 2, 2) end
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
            local speed = 50
            local moveX = dx / distance * speed * newP.speed * love.timer.getDelta()
            local moveY = dy / distance * speed * newP.speed * love.timer.getDelta()

            self.posX = self.posX + moveX
            self.posY = self.posY + moveY
        else -- Arrivé à la cible
            sfxComida:play()
            self.posX = pointX
            self.posY = pointY --next target
            self.ind = self.ind % #newP.points + 1
            self.target = newP.points[self.ind]
        end
        --print(self.index)
    end


    function newP:update(dt)
        if self.hasPlan then
            self:moveToPoint(self.target[1], self.target[2])                      
        end
        if newP.isAnim then self.animate() end
        --[[ if self.collisions > 20 then 
            if self.badTemper then newP:goMad() 
                              else self.badTemper = true 
                            end 
        end  ]]                                   
    end

    function newP:animate()
        --print("animation ennemy")
        nextFrame = nextFrame + 6 * love.timer.getDelta()
        if math.floor(nextFrame) > currentFrame then currentFrame = math.floor(nextFrame) end
        if currentFrame > #framesBall then currentFrame = 1 nextFrame = 1 end
        newP.image = framesBall[currentFrame]

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

    function newP:goMad()
    newP.giveDamage = 5
    if newP.isAnim then else newP.img = newP.madImg end
    end

    table.insert(listePerso, newP)
    return newP
end

function perso:printListe()
    print("Liste des personnages:")
    for i, pers in ipairs(listePerso) do
        print(pers.name.." ")
    end
end



return perso