-- title:   Lua Vectic Sample
-- author:  https://github.com/rodigu
-- desc:    Tiny vector library demo
-- site:    https://github.com/rodigu/vectic
-- license: GPL
-- version: 1.0
-- script:  lua

W=240
H=136
F=0

local Vectic={}
Vectic.__index=Vectic

Vectic.new=function(x,y)
  local v = {x = x or 0, y = y or 0}
  setmetatable(v, Vectic)
  return v
end

function Vectic.__add(a,b)
	a,b=Vectic.twoVec(a,b)
	return Vectic.new(a.x+b.x,a.y+b.y)
end
function Vectic.__sub(a, b)
	a,b=Vectic.twoVec(a,b)
  return Vectic.new(a.x - b.x, a.y - b.y)
end
function Vectic.__mul(a, b)
	a,b=Vectic.twoVec(a,b)
	return Vectic.new(a.x*b.x,a.y*b.y)
end
function Vectic.__div(a, b)
	a,b=Vectic.twoVec(a,b)
	return Vectic.new(a.x/b.x,a.y/b.y)
end
function Vectic.__eq(a, b)
	a,b=Vectic.twoVec(a,b)
	return a.x==b.x and a.y==b.y
end
function Vectic.__ne(a, b)
	a,b=Vectic.twoVec(a,b)
	return not Vectic.__eq(a, b)
end
function Vectic.__unm(a)
	return Vectic.new(-a.x, -a.y)
end
function Vectic.__lt(a, b)
	a,b=Vectic.twoVec(a,b)
	 return a.x < b.x and a.y < b.y
end
function Vectic.__le(a, b)
	a,b=Vectic.twoVec(a,b)
	 return a.x <= b.x and a.y <= b.y
end
function Vectic.__tostring(v)
	 return "(" .. v.x .. ", " .. v.y .. ")"
end
function Vectic.twoVec(a,b)
	return Vectic.toVec(a),Vectic.toVec(b)
end
function Vectic.toVec(a)
	if type(a)=='number' then
		return Vectic.new(a,a)
	end
	return a
end
function Vectic.floordiv(a,b)
	b=Vectic.toVec(b)
	return Vectic.new(a.x//b.x,a.y//b.y)
end
function Vectic.dist2(a,b)
	b=Vectic.toVec(b)
	return(a.x-b.x)^2+(a.y-b.y)^2
end
function Vectic.dist(a,b)
	b=Vectic.toVec(b)
	return math.sqrt(a.dist2(a,b))
end
function Vectic.floor(a)return a.floordiv(a,1)end
function Vectic.norm(a)return a:dist(Vectic.new(0,0))end
function Vectic.normalize(a)return a/a:norm() end
function Vectic.rotate(a,t)return Vectic.new(a.x*math.cos(t)-a.x*math.sin(t),a.y*math.sin(t)+a.y*math.cos(t))end
function Vectic.copy(a)return Vectic.new(a.x,a.y)end
function Vectic.xy(a) return a.x,a.y end

---@class Body
---@field pos Vectic
---@field vel Vectic
---@field m number
---@field c number
---@field doMove boolean
---@field hist Vectic[]

local G=.7

---@class Bodies
Bodies={
	limDist=1,
	---@type Body[]
	bodies={},
	---@type fun(s:Bodies,x:number,y:number,m:number,c:number,dm:boolean)
	addBody=function(s,x,y,m,c,dm)
		table.insert(s.bodies,{
			pos=Vectic.new(x,y),
			vel=Vectic.new(0,0),
			m=m,
			c=c,
			doMove=dm,
			hist={}
		})
	end,
	center=1,
	---@type fun(s:Bodies)
	setup=function(s)
		local x=W/2
		local y=H/2-10
		local side=50
		local height=math.sqrt(side^2-(side/2)^2)
		
		-- s:addBody(30,0,1,9,true)
		-- s.bodies[#s.bodies].vel=Vectic.new(.7,2)
		s:addBody(-50,0,10,6,true)
		s.bodies[#s.bodies].vel=Vectic.new(0,2)
		s:addBody(1,-50,5,2,false)
		s.bodies[#s.bodies].vel=Vectic.new(-1,0)
		s:addBody(0,0,20,13,false)
	end,
	---@type fun(s:Bodies)
	run=function(s)
		local c=s.bodies[s.center].pos-Vectic.new(W/2,H/2)
		if btnp(1) and s.center>1 then
			s.center=s.center-1
		elseif btnp(0) and s.center<#s.bodies then
			s.center=s.center+1
		end
		for i,b in pairs(s.bodies) do
			s:attract(i)
		end
		for _,b in pairs(s.bodies) do
			for _,p in pairs(b.hist) do
				circ(p.x-c.x,p.y-c.y,.5,14)
			end
		end
		for _,b in pairs(s.bodies) do
			local px,py=(b.pos-c):xy()
			if b.doMove then
				if F%1==0 then
					table.insert(b.hist,b.pos)
				end
				b.pos=b.pos+b.vel
			end
			circ(px,py,b.m,b.c)
			rect(_*15,0,5,5,b.c)
			if b.doMove then
				print(math.floor(b.pos:dist(0)),10,_*10,b.c)
				local vel=(2*b.m*b.vel+b.pos-c)
				line(px,py,vel.x,vel.y,10)
				circ(vel.x,vel.y,2,10)
				print(_,px-2,py-2,12)
			end
		end
	end,
	---@type fun(s:Bodies,bidx:number)
	attract=function(s,bidx)
		for i,b2 in pairs(s.bodies) do
			if bidx~=i then
				local b1=s.bodies[bidx]
				if b1.pos:dist2(b2.pos) > s.limDist then
					s:applyForce(b2,s:force(b1,b2))
				end
				local x,y=b1.pos:xy()
				local c=s.bodies[s.center].pos-Vectic.new(W/2,H/2)
				line(x-c.x,y-c.y,b2.pos.x-c.x,b2.pos.y-c.y,b2.c)
			end
		end
	end,
	---@type fun(s:Bodies,b1:Body,b2:Body):Vectic
	force=function(s,b1,b2)
		local f=G*(b1.m*b2.m)/b1.pos:dist2(b2.pos)
		local sub=b1.pos-b2.pos
		return sub:normalize()*f
	end,
	---@type fun(s:Bodies,b:Body,f:Vectic)
	applyForce=function(s,b,f)
		b.vel=b.vel+f
	end
}

Bodies:setup()

function TIC()
  cls(0)
	Bodies:run()
	F=F+1
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

