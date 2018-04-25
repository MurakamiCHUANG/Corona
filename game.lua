-----------------------------------------------------------------------------------------
--
-- Unit5.1
--這章會將整個結構幾乎大改,我們先將需要的函式庫以及自字型檔之類的直接放到最前端
-----------------------------------------------------------------------------------------

--呼叫composer函式庫
local composer = require( "composer" )

--創建新場景
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
-- 然後將一些公共參數先打出來
-- -----------------------------------------------------------------------------------
--設定Ｘ中心點
local centerX = display.contentCenterX
--設定Ｙ中心點
local centerY = display.contentCenterY
--建立background群組
local backgroundGroup = display.newGroup()
--建立layer群組
local layerGroup = display.newGroup()
--定義計時器
local tPrevious = system.getTimer()

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
-- -----------------------------------------------------------------------------------
-- 這里以下才是場景開始時要出現的畫面
-- -----------------------------------------------------------------------------------
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    local bg = display.newImageRect( "background_Red_480x320.png", 480, 320 )
    local bg1 = display.newImageRect( "background_Red_480x320.png", 480, 320 )
       bg.anchorX = 0
       bg.x = 0
       bg.y = centerY
       bg.speed = 1 --新增速度
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

end --這個end是scene:create的
-- -----------------------------------------------------------------------------------
-- 然後將移動function寫在場景以外的部分
-- -----------------------------------------------------------------------------------
--設置移動功能
local function move(event)
    local tDelta = event.time - tPrevious
    tPrevious = event.time
local i
--背景的移動功能,並檢測背景是否完全超出左側螢幕,如果是擇立即移動到畫面右側螢幕
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

-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        Runtime:addEventListener( "enterFrame", move )
    elseif ( phase == "did" ) then

        -- Code here runs when the scene is entirely on screen
        --記得移除上個場景
         composer.removeScene("menu")
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
      
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
    print("destroy_menu")
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene


