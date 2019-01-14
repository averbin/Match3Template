----------------------------
-- Game levels.
----------------------------

local composer = require "composer"
local gameData = require "gameData"
local widget = require "widget"
local scene = composer.newScene()

local starVertices = {
                        0,      -8,     1.763,  -2.427, 7.608,
                        -2.472, 2.853,  0.927,  4.702,  6.472,
                        0.0,    3.0,    -4.702, 6.472,  -2.853,
                        0.927,  -7.608, -2.472, -1.763, -2.427
                      }

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function handleCancelButtonEvent( event )
  if "ended" == event.phase then
    composer.removeScene("levels")
    composer.gotoScene("menu", { effects = "crossFade", time = 333})
  end
end

local function handleLevelSelect( event )
  if "ended" == event.phase then
    gameData.settings.currentLevel = event.target.id
    composer.removeScene("levels")
    composer.gotoScene("game", { effects = "crossFade", time = 333})
  end
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    --display.setDefault( "background", 0.2, 0.4, 1)
    local background = display.newRect(0, 0, display.contentWidth, display.contentHeight)
    background:setFillColor( 1 )
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    sceneGroup:insert(background)

    -- Scroll Area
    -- Use a scrollView to contain the level buttons (for support of more than one full screen).
    -- Since this will only scroll vertically, lock horizontal scrolling.
    local levelSelectGroup = widget.newScrollView(
    {
      width = 300,
      height = 460,
      scrollWidth = 300,
      scrollHeight = 800,
      horizontalScrollDisabled = true
    })

    -- 'xOffset', 'yOffset' and 'cellCount' are used to position the buttons in the grid.
    local xOffset = 32
    local yOffset = 24
    local cellCount = 1

    -- Define the array to hold the buttons
    local buttons = {}
    -- Read 'maxLevels' from the 'myData' table. Loop over them and generating one button for each.
    for i = 1, gameData.maxLevels do
      --Create a button
      buttons[i] = widget.newButton({
        label = tostring( i ),
        id = tostring( i ),
        onEvent = handleLevelSelect,
        emboss = false,
        shape = "roundedRect",
        width = 48,
        height = 32,
        font = native.systemFontBold,
        fontSize = 18,
        labelColor = { default = { 1, 1, 1}, over = { 0.5, 0.5, 0.5} },
        cornerRadius = 8,
        labelYOffset = -6,
        fillColor = { default = { 0, 0.5, 1, 1 }, over = { 0.5, 0.75, 1, 1}},
        strokeColor = { default = { 0, 0, 1, 1 }, over = { 0.333, 0.667, 1, 1}},
        strokeWidth = 2
      })
      -- Position the button in the grid and add it to the scrollView
      buttons[i].x = xOffset
      buttons[i].y = yOffset
      levelSelectGroup:insert(buttons[i])

      -- Check to see if the player has achieved (completed) this level.
      -- The '.unlockedLevels' value tracks the maximum unlocked level.
      -- First, however, check to make sure that this value has been set.
      -- If not set (new user), this value should be 1.

      -- If the level is locked, disable the button and fade it out.

      if(gameData.settings.unlockedLevels == nil) then
        gameData.settings.unlockedLevels = 1
      end
      if( i <= gameData.settings.unlockedLevels) then
        buttons[i]:setEnabled(true)
        buttons[i].alpha = 1.0
      else
        buttons[i]:setEnabled(false)
        buttons[i].alpha = 0.5
      end

      -- Generate stars earned for each level, but only if:
      -- a. The 'levels' table exists
      -- b. There is a 'stars' value inside of the 'levels' table
      -- c. The number of stars is greater than 0 (no need to draw zero stars).

      local star = {}
      if( gameData.settings.levels[i]
        and gameData.settings.levels[i].stars
        and gameData.settings.levels[i].stars > 0) then
          for j = i, gameData.settings.level[i].stars do
            star[j] = display.newPolygon(0, 0, starVertices)
            star[j]:setFillColor( 1, 0.9, 0)
            star[j].strokeWidth = 1
            star[j]:setStrokeColor(1, 0.8, 0)
            star[j].x = buttons[i].x + (j * 16) - 32
            star[j].y = buttons[i].y + 8
            levelSelectGroup:insert( star[j] )
          end
      end

      -- Compute the position of the next button.
      -- This tutorial draws 5 buttons across.
      -- It also spaces based on the button width and height + initial offset from the left.

      xOffset = xOffset + 75
      cellCount = cellCount + 1
      if( cellCount > 4) then
        cellCount = 1
        xOffset = 32
        yOffset = yOffset + 45
      end
    end
    -- Place the scrollView into the scene and center it.
    sceneGroup:insert( levelSelectGroup )
    levelSelectGroup.x = display.contentCenterX
    levelSelectGroup.y = display.contentCenterY

    local cancelButton = widget.newButton({
      id = "cancel",
      label = "Cancel",
      onEvent = handleCancelButtonEvent
    })
    cancelButton.x = display.contentCenterX
    cancelButton.y = display.contentHeight - 20

    sceneGroup:insert( cancelButton )
end

-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

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
