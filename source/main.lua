import "CoreLibs/graphics"

local maxSeconds <const> = 120

local angle = 0
local timerIsRunning = false
local currentTimer = 0

function init()
  playdate.graphics.setLineWidth(4)
end

init()

function trunc(f)
  return f // 1
end

function clamp(n, lower, upper)
  return math.min(math.max(n, lower), upper)
end

function playdate.downButtonDown()
  timerIsRunning = not timerIsRunning
end

function playdate.update()
  local deltaTime = playdate.getElapsedTime()
  playdate.resetElapsedTime()

  if timerIsRunning then
    playdate.graphics.setBackgroundColor(playdate.graphics.kColorBlack)
    playdate.graphics.setColor(playdate.graphics.kColorWhite)
    playdate.graphics.setImageDrawMode(playdate.graphics.kDrawModeFillWhite)
  else
    playdate.graphics.setBackgroundColor(playdate.graphics.kColorWhite)
    playdate.graphics.setColor(playdate.graphics.kColorBlack)
    playdate.graphics.setImageDrawMode(playdate.graphics.kDrawModeFillBlack)
  end

  playdate.graphics.clear()

  if timerIsRunning then
    -- timer is driving angle
    currentTimer -= deltaTime
    if currentTimer < 0 then
      currentTimer = 0
      timerIsRunning = false
    end
    angle = currentTimer / maxSeconds * 360
  else
    -- angle is driving timer
    local change, _ = playdate.getCrankChange()
    angle = clamp(angle + change, 0, 360)

    -- update the timer
    currentTimer = angle / 360 * maxSeconds
  end

  -- draw the arc
  if angle == 0 then
  else
    playdate.graphics.drawArc(
      playdate.geometry.arc.new(200, 120, 100, 0, angle))
  end

  -- draw the circle at the end of the arc
  local rad = angle / 180 * math.pi
  playdate.graphics.fillCircleAtPoint(
    200 + 100 * math.sin(rad),
    120 - 100 * math.cos(rad),
    6)

  -- draw text
  playdate.graphics.drawText(string.format("%d", trunc(currentTimer)), 200, 120)
end
