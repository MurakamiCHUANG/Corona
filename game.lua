-----------------------------------------------------------------------------------------
---- Project: SaturnInvader
-- Description: A simple shooting game for beginner in learning Corona game engine
--
-- Version: 1.0
-- Used by the course : "Learning English by Making Mobile Game - Advanced"
--
-- Created by Dr. Twobears (Chi-Hsiung Liang.)
-- SaturnInvader  game.lua
-- -----------------------------------------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE unless "composer.removeScene()" is called.
-- -----------------------------------------------------------------------------------------------------------------

-- local forward references should go here
-- Unit5.1
--這章會將整個結構幾乎大改,我們先將需要的函式庫以及自字型檔之類的直接放到最前端
-----------------------------------------------------------------------------------------

--呼叫composer函式庫
local composer=require ("composer")

local scene=composer.newScene()
--加入物理引擎
local physics = require("physics")
physics.start()
physics.setGravity(0, 0)
physics.setDrawMode( "hybrid" ) -- 顯示碰撞範圍
-- -------------------------------------------------------------------------------
local centerX = display.contentCenterX
local centerY = display.contentCenterY
local tPrevious = system.getTimer()
local backgroundGroup = display.newGroup()

local layerGroup = display.newGroup()
local ship
local fireTimer
local bulletGroup=display.newGroup()
local enemies = display.newGroup()
--爆炸群組
local explosionGroup = display.newGroup()
local checkMemoryTimer

local numEnemy = 0
local enemyArray = {}
-- "scene:create()"
function scene:create( event )

    local sceneGroup = self.view

    -- Initialize the scene here.
    -- Example: add display objects to "sceneGroup", add touch listeners, etc.
    --背景
    local bg = display.newImageRect( "background_Red_480x320.png", 480, 320 )
    local bg1 = display.newImageRect( "background_Red_480x320.png", 480, 320 )
       bg.anchorX = 0
       bg.x = 0
       bg.y = centerY
       bg.speed = 1
       bg1.anchorX = 0
     bg1.x = 480
     bg1.y=centerY
     bg1.speed = 1
       backgroundGroup:insert(display.newGroup(bg,bg1))
       sceneGroup:insert(backgroundGroup)
       
    local layer1 = display.newImageRect( "spaceLayer1.png", 480, 320 )
    local layer2 = display.newImageRect( "spaceLayer2.png", 480, 320 )
       layer1.anchorX = 0
       layer1.x = 0
       layer1.y = centerY
       layer1.speed = 1.5
       layer2.anchorX = 0
     layer2.x = 480
     layer2.y=centerY
     layer2.speed = 2
       layerGroup:insert(display.newGroup(layer1,layer2))
       sceneGroup:insert(layerGroup)  

  
  --ship
  local shipOptions =
  { 
      width = 177,
      height = 177,
      numFrames = 1,
      sheetContentWidth = 177,  
      sheetContentHeight = 177,  
  }
  
  sceneGroup:insert(bulletGroup)
  
  local shipSheet = graphics.newImageSheet( "ship.png", shipOptions )
  ship = display.newSprite( shipSheet, { name="ship", start=1, count=4, time=1000 } )
  ship.x=centerX*0.2
  ship.y=centerY
  ship:play ( )
  sceneGroup:insert(ship)

  --enemy
 function createEnemy()
  numEnemy = numEnemy +1 

  print(numEnemy)
  local enemyOptions =
  { 
      width = 66,
      height = 24,
      numFrames = 3,
      sheetContentWidth = 198,  
      sheetContentHeight = 24  
  }

  local enemySheet = graphics.newImageSheet( "enemy.png", enemyOptions )
  enemies:toFront()
  
  
  enemyArray[numEnemy]  = display.newSprite(enemySheet, { name="enemy", start=1, count=3, time=1000 } )
          enemyArray[numEnemy] :play() 
      physics.addBody ( enemyArray[numEnemy] , { isSensor = true,bounce = 0})--加入物理鋼體
      enemyArray[numEnemy].name = "enemy" 
      -- startlocationX = math.random (0, display.contentWidth)
      startlocationX = centerX*1.7
      enemyArray[numEnemy] .x = startlocationX
      --startlocationY = math.random (-500, -100)
      startlocationY  = math.random (0, display.contentHeight)
      enemyArray[numEnemy] .y = startlocationY
    
      transition.to ( enemyArray[numEnemy] , { time = math.random (6000, 10000), x= -50, y=enemyArray[numEnemy] .y } )

      enemies:insert(enemyArray[numEnemy] )
          
 end
 
local i
for i =1, 5 do
createEnemy()
end
  
end

local function move(event)
  local tDelta = event.time - tPrevious
  tPrevious = event.time
    
    local i
    for i = 1, backgroundGroup.numChildren do
      backgroundGroup[i][1].x = backgroundGroup[i][1].x - backgroundGroup[i][1].speed / 10*tDelta
        backgroundGroup[i][2].x = backgroundGroup[i][2].x - backgroundGroup[i][2].speed / 10*tDelta
        if (backgroundGroup[i][1].x +backgroundGroup[i][1].contentWidth) < 0 then
      backgroundGroup[i][1]:translate( 480 * 2, 0)
    end
     if (backgroundGroup[i][2].x +backgroundGroup[i][2].contentWidth) < 0 then
      backgroundGroup[i][2]:translate( 480 * 2, 0)
    end   
  end

  for i = 1, layerGroup.numChildren do
    layerGroup[i][1].x =layerGroup[i][1].x-layerGroup[i][1].speed /10*tDelta
    layerGroup[i][2].x =layerGroup[i][2].x-layerGroup[i][2].speed /10*tDelta
    if (layerGroup[i][1].x +layerGroup[i][1].contentWidth) < 0 then
      layerGroup[i][1]:translate( 480 * 2, 0)

    end
    if (layerGroup[i][2].x +layerGroup[i][2].contentWidth) < 0 then
      layerGroup[i][2]:translate( 480 * 2, 0)

    end
  end


end

local function removeBullet( obj )
  --print("removeObject")
  transition.cancel( obj )
  -- bulletGroup:remove( obj )
  obj:removeSelf()
  obj=nil
  --print("bulletGroup numChildren".. bulletGroup.numChildren)
end

local function fire(  )
  print( "fire" )
  local bullet = display.newImage( "laser.png",ship.x+30,ship.y)
  transition.to(bullet,  {time = 750, x = display.viewableContentWidth+bullet.contentWidth/2,onComplete =removeBullet})
  physics.addBody(bullet, "dynamic", {bounce = 0})--加入物理鋼體
  bullet.name = "bullet"
  bulletGroup:insert(bullet)
  print("bulletGroup numChildren".. bulletGroup.numChildren)
end


local function shipTouch(event)
  if event.phase=="began" then
    
    print("shipTouch_began")
    fireTimer=timer.performWithDelay( 100, fire,0)
    display.getCurrentStage():setFocus(event.target)
  elseif ( event.phase == "moved" ) then
    --讓飛船位置＝點擊位置
      
        if  event.x >= ship.contentWidth/2 and event.x <= display.viewableContentWidth - ship.contentWidth/2 then
            ship.x=event.x

     end
     if  event.y >= ship.contentHeight/2 and event.y <= display.viewableContentHeight - ship.contentHeight/2 then
            ship.y=event.y
     end
        --print( "touch location in content coordinates = "..event.x..","..event.y )
    elseif ( event.phase == "ended" ) then
        display.getCurrentStage():setFocus(nil)
        print("shipTouch_ended")
        timer.cancel ( fireTimer )
        fireTimer=nil
  end
end


--[[local function changeScene(event)
  print("touch")
  print("changeScene")
  if (event.phase=="began") then
    
    composer.gotoScene("menu",{effect ="fade",time=400})
  end
end]]
--移除爆炸
local function removExplode( obj )
    return function()
    obj:removeSelf() 
    obj=nil
    --print("explosionGroup numChildren".. explosionGroup.numChildren)
end 
end
--加入爆炸
local function explode( x,y )
  local explosionOptions =
  { 
      width = 55,
      height = 55,
      numFrames = 15,
      sheetContentWidth = 825,  
      sheetContentHeight = 55  
  }
  local explosionSheet = graphics.newImageSheet( "explosion1.png", explosionOptions )
  local explosion = display.newSprite( explosionSheet, { name="explosion", start=1, count=15, time=1000 ,loopCount = 1 } )
  explosion.blendMode = "add"
  explosion.x=x
  explosion.y=y
  explosion:play()
  explosionGroup:insert(explosion)
  --print("explosionGroup numChildren".. explosionGroup.numChildren)
  --audio.play( sounds.explosion )
math.random (-500, -100)
end


--加入物理碰撞偵測
local function onCollision( event )
    if ( event.phase == "began" ) then
      if  event.object1.name == "enemy" and event.object2.name == "bullet"  then
        --子彈碰到敵人,敵人消失
        print( "began: " .. event.object1.name .. " and " .. event.object2.name )
        removeBullet(event.object1)
        --消失同時呼叫爆炸，爆炸位置=敵人消失位置
        local x,y =event.object1.x,event.object1.y
        explode(x,y)
      end
    end
end

local function checkMemory()
   collectgarbage( "collect" )
   local memUsage_str = string.format( "MEMORY = %.3f KB", collectgarbage( "count" ) )
   print( memUsage_str, "TEXTURE = "..(system.getInfo("textureMemoryUsed") / (1024 * 1024) ) )
end


-- "scene:show()"
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is still off screen (but is about to come on screen).
        Runtime:addEventListener( "enterFrame", move );
    
    elseif ( phase == "did" ) then
        -- Called when the scene is now on screen.
        -- Insert code here to make the scene come alive.
        -- Example: start timers, begin animation, play audio, etc.
        print("game")
        composer.removeScene("menu")
        ship:addEventListener( "touch",  shipTouch );
        Runtime:addEventListener( "collision", onCollision )
        --checkMemoryTimer = timer.performWithDelay( 1000, checkMemory, 0 )
    end
end


-- "scene:hide()"
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.
         Runtime:removeEventListener( "enterFrame", move );
         ship:removeEventListener( "touch",  changeScene );
         --Runtime:removeEventListener( "collision", onCollision )
         --timer.cancel ( checkMemoryTimer )
         --checkMemoryTimer=nil
    elseif ( phase == "did" ) then
        -- Called immediately after scene goes off screen.
    end
end


-- "scene:destroy()"
function scene:destroy( event )

    local sceneGroup = self.view
  print("destroy_game")
    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
    
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-- -------------------------------------------------------------------------------

return scene