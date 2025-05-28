clockHandDirection = -1
center = {0,0}

function init()
  animator.setAnimationState("movement", "idle")
  local currentDirection = object.direction() or 0
  local flipDirections = config.getParameter("flipClockHandsDirections") or {}
  for _, v in ipairs(flipDirections) do
	if currentDirection == v then
		clockHandDirection = 1
	end
  end
  center = config.getParameter("clockFaceCenter", {0,0})
end

function update(dt)
  
  --testing
  --local seconds = (os.time{year=2000, month=1, day=1, hour=5, sec=0}) % 86400
  
  local seconds = (os.time() - os.time{year=2000, month=1, day=1, hour=0, sec=0}) % 86400
  local hour = (math.floor(seconds / 3600) % 12) + 1
  local minute = (math.floor(seconds / 60) % 60)
  
  local hourAngle = ((math.pi * 2) / 12) * hour
  local minuteAngle = ((math.pi * 2) / 60) * minute
  
  --adjust hour hand in small increments between hours as minute hand increments
  local ittybitty = minuteAngle / 12
  hourAngle = hourAngle + ittybitty
  
  local desiredHourAngle = hourAngle * clockHandDirection
  local desiredMinuteAngle = minuteAngle * clockHandDirection
  
  animator.resetTransformationGroup("hour")
  animator.translateTransformationGroup("hour", center)
  animator.rotateTransformationGroup("hour", desiredHourAngle, center)
  animator.resetTransformationGroup("minute")
  animator.translateTransformationGroup("minute", center)
  animator.rotateTransformationGroup("minute", desiredMinuteAngle, center)
end