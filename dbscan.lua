-- title:   dbscan
-- author:  https://cohost.org/digo
-- desc:    Visualization of DBSCAN algorithm, inspired by the awesome video https://www.youtube.com/watch?v=RDZUdRSDOok
-- site:    https://github.com/rodigu/vectic
-- license: MIT License (change this to your license of choice)
-- version: 0.1
-- script:  lua

W=240
H=136
F=0
pad=8

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
function Vectic.rnd(minx,maxx,miny,maxy)
	return Vectic.new(math.random(minx,maxx),math.random(miny,maxy))
end

---@class Point
---@field cluster number
---@field vec Vectic
---@field neighbors Point[]
---@field isCore boolean

---@type fun(v:Vectic):Point
function NewPoint(v)
	return {
		vec=v,
		cluster=-1,
		newighbors={},
		isCore=false
	}
end

---@type fun(idx:number,points:Point[], dist:number)
function setNeighbors(idx,points,dist)
	local point=points[idx]
	point.neighbors={}
	for i,p in pairs(points) do
		if i~=idx and point.vec:dist2(p.vec)<=dist*dist then
			table.insert(point.neighbors,p)
		end
	end
end

---@param points Point[]
---@param minPts number minimum number of neighbors to define a core point
function getCorePts(points,minPts)
	---@type Point[]
	local core={}
	for _,p in pairs(points) do
		if p.cluster==-1 and #p.neighbors>=minPts then
			table.insert(core,p)
			p.isCore=true
		end
	end
	return core
end

---@param point Point
---@param recursive? boolean
---@return Point[]
function expandCluster(point,recursive)
	---@type Point[]
	local frontier={}
	for _,p in pairs(point.neighbors) do
		if p.cluster==-1 then
			p.cluster=point.cluster
			if p.isCore then table.insert(frontier, p) end
			if recursive and p.isCore then expandCluster(p) end
		end
	end
	return frontier
end

---@type fun(len:number): Point[]
function rndPts(len)
	local pts={}
	for _=1,len do
		table.insert(pts,NewPoint(Vectic.rnd(pad,W-pad,pad,H-pad)))
	end
	return pts
	
end

N_PTS=400
MIN=5
E=10
POINTS=rndPts(N_PTS)
for i,_ in pairs(POINTS) do
	setNeighbors(i,POINTS,E)
end
CORE=getCorePts(POINTS,MIN)
---@type Point[]
FRONT={}
table.insert(FRONT,CORE[math.random(#CORE)])
FRONT[1].cluster=1
CLST=1
SPEED=2

-- DBSCAN(POINTS,10,3)

RESET=function()
	CLST=CLST+1
	CORE=getCorePts(POINTS,MIN)
	if #CORE>0 then
		table.insert(FRONT,CORE[math.random(#CORE)])
		FRONT[1].cluster=CLST
	end
end

FULL_RESET=function(reset_pts)
	if reset_pts then POINTS=rndPts(N_PTS)
	else
		for _,p in pairs(POINTS) do
			p.cluster=-1
			p.isCore=false
			p.neighbors={}
		end
	end

	for i,_ in pairs(POINTS) do
		setNeighbors(i,POINTS,E)
	end
	CORE=getCorePts(POINTS,MIN)
	---@type Point[]
	FRONT={}
	if #CORE>1 then
		table.insert(FRONT,CORE[math.random(#CORE)])
		FRONT[1].cluster=1
	end
	CLST=1
end

function TIC()
	F=F+1
	cls(0)
	for _,p in pairs(POINTS) do
		if p.cluster~=-1 then
			for _,n in pairs(p.neighbors) do
				if n.cluster==p.cluster then
					line(p.vec.x,p.vec.y,n.vec.x,n.vec.y,13)
				end
			end
		end
	end
	for _,p in pairs(POINTS) do
		circ(p.vec.x,p.vec.y,2,p.cluster)
		circb(p.vec.x,p.vec.y,2,15)
	end
	if F%SPEED==0 and #CORE>0 then
		local new_frontier={}
		for _,f in pairs(FRONT) do
			local temp_front=expandCluster(f,false)
			for _,nf in pairs(temp_front) do
				table.insert(new_frontier,nf)
			end
		end
		FRONT=new_frontier
		if #FRONT==0 then RESET() end
	end

	print('(left/right) e:'..E,0,0,12,false,1,true)
	if btnp(2) then
		if E>1 then
			E=E-1
		end
		FULL_RESET()
	elseif btnp(3) then
		E=E+1
		FULL_RESET()
	end
	
	print('(up/down) min:'..MIN,80,0,12,false,1,true)
	if btnp(0) then
		MIN=MIN+1
		FULL_RESET()
	elseif btnp(1) then
		if MIN>1 then
			MIN=MIN-1
		end
		FULL_RESET()
	end

	print('(z/x) pts:'..N_PTS,150,0,12,false,1,true)
	if btnp(5) then
		N_PTS=N_PTS+10
		FULL_RESET(true)
	elseif btnp(4) then
		N_PTS=N_PTS-10
		FULL_RESET(true)
	end

	print('e: distance, min: min neighbors to be core',0,H-6,12,false,1,true)
	print('speed:'..1/SPEED,200,H-6,12,false,1,true)
	if btnp(6) then
		SPEED=SPEED+1
	elseif btnp(7) then
		if SPEED>1 then SPEED=SPEED-1 end
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

