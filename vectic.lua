---@class Vectic
---@field x number
---@field y number
local Vectic={}
Vectic.__index=Vectic

---@type fun(a:number,b:number): Vectic
Vectic.new=function(x,y)
  local v = {x = x or 0, y = y or 0}
  setmetatable(v, Vectic)
  return v
end

---@alias VecticOperation<OUT> fun(a:number|Vectic,b:number|Vectic):OUT
---@type VecticOperation<Vectic>
function Vectic.__add(a,b)
	a,b=Vectic.twoVec(a,b)
	return Vectic.new(a.x+b.x,a.y+b.y)
end
---@type VecticOperation<Vectic>
function Vectic.__sub(a, b)
	a,b=Vectic.twoVec(a,b)
  return Vectic.new(a.x - b.x, a.y - b.y)
end
---@type VecticOperation<Vectic>
function Vectic.__mul(a, b)
	a,b=Vectic.twoVec(a,b)
	return Vectic.new(a.x*b.x,a.y*b.y)
end
---@type VecticOperation<Vectic>
function Vectic.__div(a, b)
	a,b=Vectic.twoVec(a,b)
	return Vectic.new(a.x/b.x,a.y/b.y)
end
---@type VecticOperation<boolean>
function Vectic.__eq(a, b)
	a,b=Vectic.twoVec(a,b)
	return a.x==b.x and a.y==b.y
end
---@type VecticOperation<boolean>
function Vectic.__ne(a, b)
	a,b=Vectic.twoVec(a,b)
	return not Vectic.__eq(a, b)
end
---@type fun(a:Vectic):Vectic
function Vectic.__unm(a)
	return Vectic.new(-a.x, -a.y)
end
---@type VecticOperation<boolean>
function Vectic.__lt(a, b)
	a,b=Vectic.twoVec(a,b)
	 return a.x < b.x and a.y < b.y
end
---@type VecticOperation<boolean>
function Vectic.__le(a, b)
	a,b=Vectic.twoVec(a,b)
	 return a.x <= b.x and a.y <= b.y
end
---@type VecticOperation<string>
function Vectic.__tostring(v)
	 return "(" .. v.x .. ", " .. v.y .. ")"
end
---@type fun(a:Vectic|number,b:Vectic|number):Vectic,Vectic
function Vectic.twoVec(a,b)
	return Vectic.toVec(a),Vectic.toVec(b)
end
---@type fun(a:Vectic|number):Vectic
function Vectic.toVec(a)
	if type(a)=='number' then
		return Vectic.new(a,a)
	end
	return a
end
---@type VecticOperation<Vectic>
function Vectic.floordiv(a,b)
	b=Vectic.toVec(b)
	return Vectic.new(math.floor(a.x/b.x),math.floor(a.y/b.y))
end
---@type VecticOperation<number>
function Vectic.dist2(a,b)
	b=Vectic.toVec(b)
	return(a.x-b.x)^2+(a.y-b.y)^2
end
---@type VecticOperation<number>
function Vectic.dist(a,b)
	b=Vectic.toVec(b)
	return math.sqrt(a.dist2(a,b))
end

---@alias VecticFunction<OUT> fun(a:Vectic):OUT
---@type VecticFunction<Vectic>
function Vectic.floor(a)return a.floordiv(a,1)end
---@type VecticFunction<number>
function Vectic.norm(a)return a:dist(Vectic.new(0,0))end
---@type VecticFunction<Vectic>
function Vectic.normalize(a)return a/a:norm() end
---@type fun(a:Vectic,t:number):Vectic
function Vectic.rotate(a,t)return Vectic.new(a.x*math.cos(t)-a.x*math.sin(t),a.y*math.sin(t)+a.y*math.cos(t))end
---@type VecticFunction<Vectic>
function Vectic.copy(a)return Vectic.new(a.x,a.y)end
---@type fun(a:Vectic):number,number
function Vectic.xy(a) return a.x,a.y end

local v=Vectic.new(2,4)

return Vectic