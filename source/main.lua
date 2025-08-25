import "CoreLibs/graphics"

angle = 0

function clamp(n, lower, upper)
  return math.min(math.max(n, lower), upper)
end

function playdate.update()
  playdate.graphics.clear()

  local change, _ = playdate.getCrankChange()
  angle = clamp(angle + change, 0, 360)

  if angle == 0 then
  else
    playdate.graphics.drawArc(200, 120, 100, 0, angle)
  end

  local rad = angle / 180 * math.pi
  playdate.graphics.fillCircleAtPoint(
    200 + 100 * math.sin(rad),
    120 - 100 * math.cos(rad),
    5)
end
