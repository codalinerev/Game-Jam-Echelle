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


    return newP
end

return perso
