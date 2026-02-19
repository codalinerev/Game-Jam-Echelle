
hero = {}

hero.txt = ""

function hero:newHero(name, posx, posy, img)
    local newHero = {}
    setmetatable(newHero, self)
    self.__index = self
    newHero.name = name
    newHero.posX = posx
    newHero.posY = posy
    newHero.image = img

    function newHero:move(dx, dy)
        self.posX = self.posX + dx
        self.posY = self.posY + dy
    end

    function newHero:updateHero(dt)
        dX, dY = 0, 0
        if love.keyboard.isDown("up") then dY = - 100*dt end
        if love.keyboard.isDown("down") then dY = 100*dt end
        if love.keyboard.isDown("left") then dX = - 100*dt end
        if love.keyboard.isDown("right") then dX = 100*dt end
        if love.keyboard.isDown("space") then print("space pressed") end
        if love.keyboard.isDown("j") then print("jump") end
        local nextPos = {self.posX + dX, self.posY + dY}
        self:checkCollision(self, nextPos[1], nextPos[2])
        self:move(dX, dY)
    end

   --[[  function newHero:updateHero()
        newHero:move()  
    end ]]
    newHero.draw = function()
        --love.graphics.setColor(0.5, 1, 0.5)

        love.graphics.draw(newHero.image, newHero.posX, newHero.posY)
    end

    function newHero.checkCollision(self, nextPosX, nextPosY)
        --print("checking collision for " .. self.name)
        local tileX = math.floor((self.posX + 16) / 32) + 1
        local tileY = math.floor((self.posY + 16) / 32) + 1
        local tileIndex = (tileY - 1) * 16 + tileX
        if map1[tileIndex] == 2 then
            --print(" collided with a wall at tile (" .. tileX .. ", " .. tileY .. ")")
            self.txt = "collided with a wall at tile (" .. tileX .. ", " .. tileY .. ")"
            -- Simple collision response: stop movement (you can improve this)
            self.posX = self.posX - (self.posX % 32 - 16)
            self.posY = self.posY - (self.posY % 32 - 16)
        end
    end

    return newHero
end

return hero