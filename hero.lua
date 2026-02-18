hero = {}

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
        self:move(dX, dY)
    end

   --[[  function newHero:updateHero()
        newHero:move()  
    end ]]
    newHero.draw = function()
        love.graphics.setColor(0.5, 1, 0.5)
        love.graphics.draw(newHero.image, newHero.posX, newHero.posY)
    end

    return newHero
end

return hero