perso = {}

function perso:newPerso(name, posX, posY)
    local newP = {}
    newP.name = name

    newP.posX = posX
    newP.posY = posY
    newP.speed = 0
    newP.isVisible = true
    newP.image = love.graphics.newImage("assets/persoInit.png")



    function newP:draw()
        if self.isVisible then
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(self.image, self.posX, self.posY, 0, 1, 1)
            print(self.name .. "drawn at " .. self.posX .. " , " .. self.posY)
        end
    end


    return newP
end

return perso
