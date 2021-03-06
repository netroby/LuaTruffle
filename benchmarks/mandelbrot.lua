-- The Computer Language Shootout
-- http://shootout.alioth.debian.org/
-- contributed by Mike Pall

function mandelbro(width)
  local height, wscale = width, 2/width
  local m, limit2 = 50, 4.0
  local iter = 0

  for y=0,height-1 do
    local Ci = 2*y / height - 1
    for xb=0,width-1,8 do
      local bits = 0
      local xbb = xb+7
      local loopend
      if xbb < width then loopend = xbb else loopend = width - 1 end
      for x=xb,loopend do
        bits = bits + bits
        local Zr, Zi, Zrq, Ziq = 0.0, 0.0, 0.0, 0.0
        local Cr = x * wscale - 1.5
        for i=1,m do
          local Zri = Zr*Zi
          Zr = Zrq - Ziq + Cr
          Zi = Zri + Zri + Ci
          Zrq = Zr*Zr
          Ziq = Zi*Zi
          iter = iter + 1
          if Zrq + Ziq > limit2 then
            bits = bits + 1
            break
          end
        end
      end
      if xbb >= width then
        for x=width,xbb do bits = bits + bits + 1 end
      end
    end
  end
  return iter
end

while true do
  local t1 = os.clock()
  mandelbro(1000)
  print(os.clock()-t1)
end
