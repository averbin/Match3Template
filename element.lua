local element = {}

function element.new(group, x, y, rectSize)
  set = {}
  setmetatable(set, { rectField })
  set.rectField = display.newRect(group, x, y, rectSize, rectSize)
  return set
end

return element
