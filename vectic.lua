---@alias VecOpr fun(s:Vectic,v:Vectic|number):Vectic
---@alias VecCalc fun(s:Vectic,v:Vectic|number):number
---@alias VecFun fun(s:Vectic):Vectic

---@class Vectic
---@field x number
---@field y number
---@field add VecOpr
---@field sub VecOpr
---@field mul VecOpr
---@field repr fun(s:Vectic):string
---@field div VecOpr
---@field floordiv VecOpr
---@field floor VecFun
---@field dist VecCalc
---@field dist2 VecCalc
---@field norm fun(s:Vectic):number
---@field eq fun(s:Vectic,v:Vectic):boolean
---@field normalize VecFun
---@field rotate fun(s:Vectic,t:number):Vectic
---@field copy VecFun
---@field zero VecFun
---@field xy fun(v:Vectic):number,number

---@type fun(x:number,y:number):Vectic
function NewVec(x,y)
	local toVec=function(v)
		if type(v)=='number' then
			return NewVec(v,v)
		end
		return v
	end
	---@type Vectic
	local v={
		x=x,
		y=y,
		add=function(v,v2)
			v2=toVec(v2)
			return NewVec(v.x+v2.x,v.y+v2.y)
		end,
		sub=function(v,v2)
			v2=toVec(v2)
			return NewVec(v.x-v2.x,v.y-v2.y)
		end,
		mul=function(v,v2)
			v2=toVec(v2)
			return NewVec(v.x*v2.x,v.y*v2.y)
		end,
		repr=function(v) return "NewVec("..v.x..", "..{v.y}..")"end,
		div=function(v,v2)
			v2=toVec(v2)
			return NewVec(v.x/v2.x,v.y/v2.y)
		end,
		floordiv=function(v,v2)
			v2=toVec(v2)
			return NewVec(v.x//v2.x,v.y//v2.y)
		end,
		floor=function(v)return v.floordiv(v,1)end,
		dist2=function(v,v2)
			v2=toVec(v2)
			return(v.x-v2.x)^2+(v.y-v2.y)^2
		end,
		dist=function(v,v2)
			v2=toVec(v2)
			return math.sqrt(v.dist2(v,v2))
		end,
		norm=function(v)return v.dist(v,NewVec(0,0))end,
		eq=function(v,v2)
			v2=toVec(v2)
			return v.x==v2.x and v.y==v2.y
		end,
		normalize=function(v)return v:div(v:norm()) end,
		rotate=function(v,t)return NewVec(v.x*math.cos(t)-v.x*math.sin(t),v.y*math.sin(t)+v.y*math.cos(t))end,
		copy=function(v)return NewVec(v.x,v.y)end,
		zero=function()return NewVec(0,0)end,
		xy=function(v)return v.x,v.y end
	}
	return v
end