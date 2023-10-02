
---@alias Vec {x: number, y:number}
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
	dist=function(v,v2)return math.sqrt(v.dist2(v2))end,
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