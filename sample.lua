-- title:   Lua Vectic Sample
-- author:  game developer, email, etc.
-- desc:    short description
-- site:    website link
-- license: MIT License (change this to your license of choice)
-- version: 0.1
-- script:  lua

W=240
H=136

---@class Vec
---@field x number
---@field y number

---@class Vectic
Vectic={}
Vectic={
	---@param x number
	---@param y number
	---@return Vec
	new=function(x,y)return{x=x,y=y}end,
	---@param v Vec
	---@param v2 Vec
	---@return Vec
	add=function(v,v2)return Vectic.new(v.x+v2.x,v.y+v2.y)end,
	---@param v Vec
	---@param v2 Vec
	---@return Vec
	sub=function(v,v2)return Vectic.new(v.x-v2.x,v.y-v2.y)end,
	---@param v Vec
	---@param s Vec|number
	---@return Vec
	mul=function(v,s)return Vectic.new(v.x*s,v.y*s)end,
	---@param v Vec
	---@return string
	repr=function(v) return "Vectic.new("..v.x..", "..{v.y}..")"end,
	---@param v Vec
	---@param s Vec|number
	---@return Vec
	div=function(v,s)
	 if type(s)=="number" then return Vectic.new(v.x/s,v.y/s) end
	 return Vectic.new(v.x/s.x,v.y/s.y)
	end,
	---@param v Vec
	---@param s Vec|number
	---@return Vec
	floordiv=function(v,s)
	 if type(s)=="number"then return Vectic.new(v.x//s,v.y//s)end
	 return Vectic.new(v.x//s.x,v.y//s.y)
	end,
	---@param v Vec
	---@return Vec
	floor=function(v)return Vectic.floordiv(v,1)end,
	---@param v Vec
	---@param v2 Vec
	---@return number
	dist2=function(v,v2)return(v.x-v2.x)^2+(v.y-v2.y)^2 end,
	---@param v Vec
	---@param v2 Vec
	---@return number
	dist=function(v,v2)return math.sqrt(Vectic.dist2(v,v2))end,
	---@param v Vec
	---@return number
	norm=function(v)return Vectic.dist(v,Vectic.zero())end,
	len=Vectic.norm,
	---@param v Vec
	---@param v2 Vec
	---@return boolean
	eq=function(v,v2)return v.x==v2.x and v.y==v2.y end,
	---@param v Vec
	---@return Vec
	normalize=function(v)return Vectic.div(v,Vectic.norm(v))end,
	---@param v Vec
	---@param t number Angle Theta in radians
	---@return Vec
	rotate=function(v,t)return Vectic.new(v.x*math.cos(t)-v.x*math.sin(t),v.y*math.sin(t)+v.y*math.cos(t))end,
	---@param v Vec
	---@return Vec
	copy=function(v)return Vectic.new(v.x,v.y)end,
	---@return Vec
	zero=function()return Vectic.new(0,0)end,
	---@param v Vec
	---@return number,number
	xy=function(v)return v.x,v.y end
}

v = Vectic.new(240/2,136/2)

---@class Planet: Vec
---@field m number Mass
---@field c number Color
---@field v Vec Velocity

---@class Gravity
Gravity={
  G=.06,
  ---@type Planet[]
  planets={},
  ---@param s Gravity
  ---@param x number
  ---@param y number
  ---@param m number Mass
  ---@param c number Mass
  add_planet=function(s,x,y,m,c)
    table.insert(s.planets,{x=x,y=y,m=m,c=c,v=Vectic.zero()})
  end,
  ---@param s Gravity
  run=function(s)
    for a,p1 in pairs(s.planets) do
      s:apply(p1,a)
      circ(p1.x,p1.y,p1.m,p1.c)
      print(p1.x,10,a*10)
    end
  end,
  ---@param s Gravity
  setup=function(s)
    s:add_planet(W/4,2*H/3,3,2)
    s:add_planet(2*W/3,2*H/3,3,5)
    s:add_planet(W/2,H/4,3,10)
  end,
  ---@param s Gravity
  ---@param p1 Planet
  ---@param a number
  apply=function(s,p1,a)
    
    for b,p2 in pairs(s.planets) do
      if a~=b then
        local f=s:force(p1,p2)
        local move_vec=Vectic.mul(Vectic.normalize(Vectic.sub(p1,p2)),f)
        p2.v=Vectic.add(p2.v,move_vec)
        p2.x=p2.v.x+p2.x
        p2.y=p2.v.y+p2.y
      end
    end
  end,
  ---@param s Gravity
  ---@param p1 Planet
  ---@param p2 Planet
  force=function(s,p1,p2)
    local f=s.G*(p1.m*p2.m)/Vectic.dist2(p1,p2)
    if f>50 then f=70 end
    return f
  end
}

Gravity:setup()

function TIC()
  cls(0)
  Gravity:run()
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

