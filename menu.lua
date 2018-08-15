-----------------------------------------------------------------------------------------
--
-- Match3 template menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local element = require( "element" )
local widget = require( "widget" )
local gameData = require( "gameData" )
local scene = composer.newScene()

local function handlePlayButtonEvent( event )
  if "ended" == event.phase then
    composer.removeScene("menu", false)
    composer.gotoScene("levels", { effects = "crossFade", time = 333})
  end
end

local function handleSoundButtonEvent( event )
  if "ended" == event.phase then
    if gameData.settings.sound == "on" then
      gameData.settings.sound = "off"
    else
      gameData.settings.sound = "on"
    end
    print("Sount tourn: " .. gameData.settings.sound)
  end
end

local function handleMusicButtonEvent( event )
  if "ended" == event.phase then
    if gameData.settings.music == "on" then
      gameData.settings.music = "off"
    else
      gameData.settings.music = "on"
    end
    print("Music tourn: " .. gameData.settings.music)
  end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
    local sceneGroup = self.view
    local background = display.newImage(sceneGroup, "res/Images/beach.jpg")
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    background:scale(0.7, 0.8)

    playButton = widget.newButton(
      {
          label = "Play",
          onEvent = handlePlayButtonEvent,
          emboss = false,
          shape = "Circle",
          radius = 40,
          fillColor = { default = {1, 0, 0, 1}, over = {1, 0.1, 0.7, 0.4}},
          strokeColor = { default = {1, 0.4, 0,1}, over={0.8, 0.8, 1,1}},
          labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
          strokeWidth = 4
      }
    )

    playButton.x = display.contentCenterX
    playButton.y = display.contentCenterY

    soundButton = widget.newButton(
      {
        label = "Sound",
        onEvent = handleSoundButtonEvent,
        shape = "Circle",
        radius = 25,
        fillColor = { default = {0, 0, 1, 1}, over = {0.1, 0.7, 1.0, 0.4}},
        strokeColor = { default = {1, 0.4, 0,1}, over={0.8, 0.8, 1,1}},
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
        strokeWidth = 4
      }
    )

    soundButton.x = display.contentCenterX + 120
    soundButton.y = display.contentCenterY - 220

    musicButton = widget.newButton(
      {
        label = "Music",
        onEvent = handleMusicButtonEvent,
        shape = "Circle",
        radius = 25,
        fillColor = { default = {0, 0, 1, 1}, over = {0.1, 0.7, 1.0, 0.4}},
        strokeColor = { default = {1, 0.4, 0,1}, over={0.8, 0.8, 1,1}},
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
        strokeWidth = 4
      }
    )

    musicButton.x = soundButton.x - 70
    musicButton.y = display.contentCenterY - 220
end

-- show()
function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
    elseif ( phase == "did" ) then
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
      timer.cancel( gameLoopTimer )
    end
end

-- destroy()
function scene:destroy( event )
    local sceneGroup = self.view
    playButton:removeSelf()
    soundButton:removeSelf()
    musicButton:removeSelf()
    -- Code here runs prior to the removal of scene's view
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
