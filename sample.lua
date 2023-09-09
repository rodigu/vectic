-- title:   Lua Vectic Sample
-- author:  game developer, email, etc.
-- desc:    short description
-- site:    website link
-- license: MIT License (change this to your license of choice)
-- version: 0.1
-- script:  lua

local Vectic={}
Vectic.zero=function()return{x=0,y=0}end
Vectic.new=function(x,y)
 local v={}
 v.x=x
 v.y=y
 v.add=function(v2)return Vectic.new(v.x+v2.x,v.y+v2.y)end
 v.iadd=function(v2)
  v.x=v.x+v2.x
  v.y=v.y+v2.y
  return v
 end
 v.sub=function(v2)return Vectic.new(v.x-v2.x,v.y-v2.y)end
 v.isub=function(v2)
  v.x=v.x-v2.x
  v.y=v.y-v2.y
  return v
 end
 v.mul=function(s)return Vectic.new(v.x*s,v.y*s)end
 v.imul=function (s)
  v.x=v.x*s
  v.y=v.y*s
  return v
 end
 v.repr=function() return "Vectic.new("..v.x..", "..{v.y}..")"end
 v.div=function(s)
  if type(s)=="number" then return Vectic.new(v.x/s,v.y/s) end
  return Vectic.new(v.x/s.x,v.y/s.y)
 end
 v.idiv=function(s)
  if type(s)=="number" then 
   v.x=v.x/s
   v.y=v.y/s
   return v
  end
  v.x=v.x/s.x
  v.y=v.y/s.y
  return v
 end
 v.floordiv=function(s)
  if type(s)=="number"then return Vectic.new(v.x//s,v.y//s)end
  return Vectic.new(v.x//s.x,v.y//s.y)
 end
 v.floor=function()return v.floordiv(1)end
 v.dist2=function(v2)return(v.x-v2.x)^2+(v.y-v2.y)^2 end
 v.dist=function(v2)return math.sqrt(v.dist2(v2))end
 v.norm=function()return v.dist(Vectic.zero())end
 v.len=v.norm
 v.eq=function(v2)return v.x==v2.x and v.y==v2.y end
 v.normalized=function()return v.div(v.norm())end
 v.normalize=function()
  v=v.normalized()
  return v
 end
 function rotate(t)return Vectic.new(v.x*math.cos(t)-v.x*math.sin(t),v.y*math.sin(t)+v.y*math.cos(t))end
 function copy()return Vectic.new(v.x,v.y)end
 return v
end

v = Vectic.new(240/2,136/2)

function TIC()
  cls(0)
  local x,y=mouse()
  local mv=Vectic.new(x,y)
  
  v2=mv.sub(v)
 
  v2=v2.normalized()
 
  v2.imul(50)
  v2.iadd(v)

	circ(v.x,v.y,50,14)
	circb(v.x,v.y,50,15)
	if mv.dist2(v) > v2.dist2(v) then
  	line(v.x,v.y,v2.x,v2.y,5)
	else
		line(v.x,v.y,mv.x,mv.y,10)
	end
end

-- <TILES>
-- 001:eccccccccc888888caaaaaaaca888888cacccccccacc0ccccacc0ccccacc0ccc
-- 002:ccccceee8888cceeaaaa0cee888a0ceeccca0ccc0cca0c0c0cca0c0c0cca0c0c
-- 003:eccccccccc888888caaaaaaaca888888cacccccccacccccccacc0ccccacc0ccc
-- 004:ccccceee8888cceeaaaa0cee888a0ceeccca0cccccca0c0c0cca0c0c0cca0c0c
-- 017:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
-- 018:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
-- 019:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
-- 020:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
-- </TILES>

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <SFX>
-- 000:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000304000000000
-- </SFX>

-- <TRACKS>
-- 000:100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- </TRACKS>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

