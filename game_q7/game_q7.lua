Q7Button = nil
Q7Window = nil

-- Global variables for the move function
Row = 1200
Col = 250


function init()
  connect(g_game, {onGameStart = move})
  -- Create window 600x600, set in game_q7.otui
  Q7Button = modules.client_topmenu.addRightToggleButton('Q7Button', tr('game_Q7'), '', closing)
  Q7Button:setOn(false)

  Q7Window = g_ui.displayUI('game_Q7')
  Q7Window:setVisible(false)

  allTabs = Q7Window:recursiveGetChildById('allTabs')
  allTabs:setContentWidget(Q7Window:getChildById('optionsTabContent'))

  --Create jump button
  jump = g_ui.createWidget('Button')
  jump:setOn(true)
  jump:setSize({width = 40, height = 30})
  jump:setText("Jump!")
  Q7Window:addChild(jump)

  if g_game.isOnline() then
    move()
  end
end

function terminate()
  -- Delete objects
  disconnect(g_game, {onGameStart = move })
  Q7Button:destroy()
  Q7Window:destroy()
end

function closing()
  if Q7Button:isOn() then
    Q7Window:setVisible(false)
    Q7Button:setOn(false)
  else
    Q7Window:setVisible(true)
    Q7Button:setOn(true)
  end
end

-- The Jump button moves from right to left of the window. Whenever it passes the leftEdgeThreshold position or the
-- button is pressed, the button will 'jump' to a random row within the window near the right border and continue
-- moving left
function move()

  local leftEdgeThreshold = 680 --leftEdgeThreshold controls the closest distance between the button and left border
  local topEdgeThreshold = 250 --topEdgeThreshold controls the highest Y position the button can jump too
  local bottomEdgeThreshold = 700 --bottomEdgeThreshold controls the lowest Y position the button can jump too
  local homeXposition = 1200

  if(jump:getX() < leftEdgeThreshold) then
    Col = math.floor(math.random(topEdgeThreshold, bottomEdgeThreshold ))
    Row = homeXposition
  else
    print(jump:getX(), jump:getY())
    Row = Row - 15
  end

  if(jump:isPressed()) then
    Col = math.floor(math.random(topEdgeThreshold, bottomEdgeThreshold ))
    Row = homeXposition
  end

  -- Set the position of the button
  jump:setPosition({x = Row, y = Col})
  scheduleEvent(move, 80)

end

function onMiniWindowClose()
  Q7Button:setOn(false)

end

