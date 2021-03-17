--love.graphics.setDefaultFilter("nearest") -- pas d'aliasing pour la 2D old scool
local screenWidth, screenHeight

local lstSprites = {}
local pad

local ball = {}
ball.radius = 20
ball.vX = 200
ball.vY = 200


function CreateSprites(pImgName, pX, pY)
  local sprite = {}
  sprite.image = love.graphics.newImage("images/".. pImgName ..".png")
  sprite.width = sprite.image:getWidth()
  sprite.height = sprite.image:getHeight()
  sprite.x = pX
  sprite.y = pY


  table.insert(lstSprites, sprite)

  return sprite

end

function love.load()
  love.window.setTitle("PongPong (by Wile)")
  --love.window.setMode(1280, 768)
  love.graphics.setBackgroundColor( 255,255, 255)
  screenWidth = love.graphics.getWidth()
  screenHeight = love.graphics.getHeight()

  pad = CreateSprites("controller")
  print(pad.width)
  pad.x = 0
  pad.y = screenHeight/2 - pad.height /2
  pad.speed = 500

  ball.x =  screenWidth /2
  ball.y =  screenHeight /2

end

function love.update(dt)

  if love.keyboard.isDown("z") and pad.y > 0 then
    pad.y = pad.y - (pad.speed *dt)
  end

  if love.keyboard.isDown("s") and pad.y < screenHeight - pad.height  then
    pad.y = pad.y + (pad.speed *dt)
  end



  ball.x = ball.x - (ball.vX * dt)
  ball.y = ball.y - (ball.vY * dt)

  if ball.y < ball.radius then
    ball.vY = -ball.vY
  end

  if ball.y > screenHeight - ball.radius then
    ball.vY = -ball.vY
  end

  if ball.x <= pad.x + 40 then
    -- ball.x =  pad.x + pad.imageWidth
    if ball.y > pad.y and ball.y < pad.y + pad.height then
      ball.vX = -ball.vX
      -- ball.x = pad.x + pad.width
    end
   
  end

end

function love.draw()
  love.graphics.setColor(0,0,0,0.9)
  love.graphics.circle("fill", ball.x, ball.y, ball.radius)
  love.graphics.setColor(255,255,255)
  love.graphics.draw(pad.image, pad.x,pad.y, 0)
end

function love.keypressed(key)
  if key=="escape" then love.event.quit() end
  print(key)
end
