function love.load()
    -- New Sprites
    animalSprite = love.graphics.newImage("owl.png")
    powerupSprite = love.graphics.newImage("star.png")
    background = love.graphics.newImage("sky.png")

    math.randomseed(os.time())

    -- Game Settings
    gameSpeed = 100
    animalCount = 7
    animals = {}

    for i = 1, animalCount do
        table.insert(animals, {
            x = math.random(0, love.graphics.getWidth() - animalSprite:getWidth()),
            y = 0 - math.random(animalSprite:getHeight(), animalSprite:getHeight() * 4)
        })
    end

    -- Powerup Setup (Static Position)
    powerup = {
        x = math.random(100, love.graphics.getWidth() - 100),
        y = math.random(100, love.graphics.getHeight() - 200),
        active = true
    }
end

function love.mousepressed(x, y, button, istouch)
    if button == 1 then
        -- Check Animal Clicks
        for i, a in ipairs(animals) do
            if x >= a.x and x <= a.x + animalSprite:getWidth() and
                y >= a.y and y <= a.y + animalSprite:getHeight() then
                a.y = -math.random(100, 300)
                a.x = math.random(0, love.graphics.getWidth() - animalSprite:getWidth())
            end
        end

        -- Check Powerup Click
        if powerup.active and x >= powerup.x and x <= powerup.x + powerupSprite:getWidth() and
            y >= powerup.y and y <= powerup.y + powerupSprite:getHeight() then
            powerup.active = false
            gameSpeed = 40 -- Slow down gravity

            -- Send everyone back to the top
            for _, a in ipairs(animals) do
                a.y = -math.random(100, 500)
            end
        end
    end
end

function love.update(dt)
    for i, a in ipairs(animals) do
        -- Move Down
        a.y = a.y + gameSpeed * dt

        -- Lose Condition
        if a.y + animalSprite:getHeight() >= love.graphics.getHeight() then
            love.event.quit()
        end
    end
end

function love.draw()
    love.graphics.draw(background, 0, 0)

    -- Draw Powerup
    if powerup.active then
        love.graphics.draw(powerupSprite, powerup.x, powerup.y)
    end

    -- Draw Animals
    for _, a in ipairs(animals) do
        love.graphics.draw(animalSprite, a.x, a.y)
    end
end
