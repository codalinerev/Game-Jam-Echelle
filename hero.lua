
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
    newHero.currentFrame = 1
    newHero.txt = "Salut"
    newHero.nextPos = {posx, posy}
    newHero.hasPlan = false 
    newHero.state = "GoLeft" -- "Jump", "Stand", "Falling", "Dance", "Wave", "Climb", "Sit", "Talk", "Emote", "GoUp", "GoDown", "GoLeft", "GoRight"
    newHero.nextState = "Stand"

    

    function newHero:WhichTile(posX, posY)
        local tileX = math.floor((posX + 16) / 32) + 1
        --print(tileX)
        local tileY = math.floor((posY + 16) / 32) + 1
        --print(tileY)
        local tileIndex = (tileY - 1) * 16 + tileX
        return tileIndex
    end

    tuileUp = map1[newHero:WhichTile(newHero.posX, newHero.posY - 32)]
    tuileDown = map1[newHero:WhichTile(newHero.posX, newHero.posY + 32)]
    tuileLeft = map1[newHero:WhichTile(newHero.posX - 32, newHero.posY)]
    tuileRight = map1[newHero:WhichTile(newHero.posX + 32, newHero.posY)]

    newHero.speed = 100
    print(newHero.posX .."," ..newHero.posY)
    newHero.tileIndex = newHero:WhichTile(newHero.posX, newHero.posY)
    newHero.nextTileIndex = newHero:WhichTile(newHero.nextPos[1], newHero.nextPos[2])
    OnLadder = map1[newHero.tileIndex] == 4
    newHero.isGrounded = true   --map1[newHero.tileIndex]==2 or map1[newHero.tileIndex]==4

    -----newHero.
    function isGrounded(posX, posY)
        local tuileDown = map1[WhichTile(posX, posY + 32)]
        return tuileDown == 2 or tuileDown == 4
    end

    function newHero:move(dx, dy)
        self.posX = self.posX + dx
        self.posY = self.posY + dy
    end

    function newHero:Possible(posx, posy)
        --test si on map
        --test si pas d'obstacle
        --test si p

    end

    function newHero:updateHero(dt)
        tuileUp = map1[newHero:WhichTile(newHero.posX, newHero.posY - 32)]
        tuileDown = map1[newHero:WhichTile(newHero.posX, newHero.posY + 32)]
        tuileLeft = map1[newHero:WhichTile(newHero.posX - 32, newHero.posY)]
        tuileRight = map1[newHero:WhichTile(newHero.posX + 32, newHero.posY)]
        dX, dY = 0, 0
        newHero.isGrounded = tuileDown == 2 or tuileDown == 4
        self.tileIndex = self:WhichTile(self.posX, self.posY)
        OnLadder = map1[self.tileIndex] == 4
        if love.keyboard.isDown("up") then self.nextState = "GoUp" dY = -self.speed * love.timer.getDelta() end
        if love.keyboard.isDown("down") then self.nextState = "GoDown" dY = self.speed * love.timer.getDelta() end
        if love.keyboard.isDown("left") then self.nextState = "GoLeft" dX = -self.speed * love.timer.getDelta() end
        if love.keyboard.isDown("right") then self.nextState = "GoRight" dX = self.speed * love.timer.getDelta() end
        if love.keyboard.isDown("space") then self.txt = "space pressed" end
        if love.keyboard.isDown("j") then self.nextState = "Jump" end
        self.nextPos = {self.posX + dX, self.posY + dY}
        if isGrounded(self.nextPos[1], self.nextPos[2]) 
            then self.isGrounded = true 
            else self.isGrounded = false 
                 self.nextState = "Falling" 
            end
        CheckNextAction(self)
        --self:checkCollision(self, nextPos[1], nextPos[2])
        --self:move(dX, dY)
    end

    function CheckNextAction(self)
        if not IsOnMap(self.nextPos[1], self.nextPos[2]) then
            self.txt = "Can't move outside the map!"
            return
        elseif self.nextState == "GoUp" then 
            if OnLadder then self:move(0, -self.speed * love.timer.getDelta())
            else self.txt = "Can't go up without a ladder!" end
        elseif self.nextState == "GoDown" then 
            if OnLadder then self:move(0, self.speed * love.timer.getDelta())
            else self.txt = "Can't go down without a ladder!" end
        elseif self.nextState == "GoLeft" then 
            if (self.isGrounded or OnLadder) and (isGrounded(self.nextPos[1], self.nextPos[2])) then self:move(-self.speed * love.timer.getDelta(), 0) end
        elseif self.nextState == "GoRight" then 
            if (self.isGrounded or OnLadder) and (isGrounded(self.nextPos[1], self.nextPos[2])) then self:move(self.speed * love.timer.getDelta(), 0) end
        elseif self.nextState == "Jump" then 
            if self.isGrounded then self.txt = "Jumping!" self:move(0, -self.speed * 10 * love.timer.getDelta())end
        elseif self.nextState == "Stand" then 
            self.txt = "Standing still."
        elseif self.nextState == "Falling" then self:move(0, self.speed * 10 * love.timer.getDelta())
            self.txt = "Falling"
        end


        self.tileIndex = self:WhichTile(self.posX, self.posY)
        self.nextState = "Stand"
    end 
    newHero.draw = function()
        --love.graphics.setColor(0.5, 1, 0.5)

        love.graphics.draw(newHero.image, newHero.posX, newHero.posY)
    end

    function newHero.checkCollision(self, nextPosX, nextPosY)
        --print("checking collision for " .. self.name)
        local tileIndex = WhichTile(nextPosX, nextPosY)
        if map1[tileIndex] == 2 then
            self.txt = "collided with a wall at tile (" .. tileX .. ", " .. tileY .. ")"
            self.posX = self.posX - (self.posX % 32 - 16)
            self.posY = self.posY - (self.posY % 32 - 16)
        end
    end   

    function IsOnMap(posX, posY)
        local tileIndex = newHero:WhichTile(posX, posY)
        return tileIndex >= 1 and tileIndex <= #map1
    end
    
    function newHero:drawGUIHero()
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("Hero: " .. self.name, 10, 10)
        love.graphics.print("Position: (" .. math.floor(self.posX) .. ", " .. math.floor(self.posY) .. ")", 10, 30)
        love.graphics.print("Tile: " .. self.tileIndex, 10, 50)
        love.graphics.print("State: " .. self.state, 10, 70)
        love.graphics.print("Next State: " .. self.nextState, 10, 90)
        if tuileUp then love.graphics.print("Up: " .. tuileUp, 210, 110) end
        if tuileDown then love.graphics.print("Down: " .. tuileDown, 210, 130) end
        if tuileLeft then love.graphics.print("Left: " .. tuileLeft, 210, 150) end
        if tuileRight then love.graphics.print("Right: " .. tuileRight, 210, 170) end
        love.graphics.print("is grounded: " .. tostring(self.isGrounded), 210, 190)
        love.graphics.print("On ladder: " .. tostring(OnLadder), 210, 210)
    end

    return newHero
end

return hero