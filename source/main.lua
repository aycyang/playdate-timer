import "CoreLibs/graphics"

local maxSeconds <const> = 30

local angle = 0
local timerIsRunning = false
local currentTimer = 0

function clamp(n, lower, upper)
  return math.min(math.max(n, lower), upper)
end

function playdate.downButtonDown()
  print("down pressed")
  if not timerIsRunning then
    timerIsRunning = true
  end
end

function playdate.update()
  local deltaTime = playdate.getElapsedTime()
  playdate.resetElapsedTime()

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
    playdate.graphics.drawArc(200, 120, 100, 0, angle)
  end

  -- draw the circle at the end of the arc
  local rad = angle / 180 * math.pi
  playdate.graphics.fillCircleAtPoint(
    200 + 100 * math.sin(rad),
    120 - 100 * math.cos(rad),
    5)

end
