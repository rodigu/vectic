-- title:   game title
-- author:  game developer, email, etc.
-- desc:    short description
-- site:    website link
-- license: MIT License (change this to your license of choice)
-- version: 0.1
-- script:  lua

W=240
H=136
F=0

local Vectic={}
Vectic.__index=Vectic

---@type fun(a:number,b:number): Vectic
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
	return Vectic.new(math.floor(a.x/b.x),math.floor(a.y/b.y))
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
function Vectic.apply(a,f) return Vectic.new(f(a.x),f(a.y)) end
function Vectic.rnd(rx,ry)
	return Vectic.new(math.random(rx.x,rx.y),math.random(ry.x,ry.y))
end

---@type Vectic[]
local points={}
local p_n=500
local pad=10
local rx=Vectic.new(pad,W-pad)
local ry=Vectic.new(pad,H-pad)

for _=1,p_n do
	table.insert(points,Vectic.rnd(rx,ry))
end

---@type Vectic[]
local ks={}
local K=6

for _=1,K do
	table.insert(ks,Vectic.rnd(rx,ry))
end

---@type fun(pts:Vectic[],ks:Vectic[]):number[]
function groupPts(pts,ks)
	---@type number[]
	local gs={}
	for i,a in pairs(pts) do
		local min_dist=W*W+H*H
		for k,b in pairs(ks) do
			local d=a:dist(b)
			if d<min_dist then
				min_dist=d
				gs[i]=k
			end
		end
	end
	return gs
end

local groupings=groupPts(points,ks)
local colors={2,4,6,9,11,12}

---@type fun(pts:Vectic[],gs:number[],g:number):Vectic[]
function ptsInGroup(pts,gs,g)
	local inG={}
	for i,v in ipairs(pts) do
		if gs[i]==g then table.insert(inG,v) end
	end
	return inG
end

---@type fun(pts:Vectic[],gs:Vectic[],k:number):number[]
function mean_pts(pts,gs,k)
	local means={}
	for i=1,k do
		local inG=ptsInGroup(pts,gs,i)
		local sum=Vectic.new(0,0)
		for _,v in pairs(inG) do
			sum=sum+v
		end
		table.insert(means,sum/#inG)
	end
	return means
end

local original_pts=ks

function TIC()
	F=F+1
	cls(0)
	for i,c in pairs(ks) do
		for _,p in pairs(points) do
			if groupings[_]==i then
				line(c.x,c.y,p.x,p.y,15)
			end
		end
		circ(c.x,c.y,2,colors[i])
	end
	for _,p in pairs(points) do
		circ(p.x,p.y,1,colors[groupings[_]])
	end
	if F%1==0 then
		ks=mean_pts(points,groupings,K)
		groupings=groupPts(points,ks)
	end
	for _,v in pairs(original_pts) do
		circ(v.x,v.y,2,13)
		local c=ks[_]
		line(c.x,c.y,v.x,v.y,13)
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

