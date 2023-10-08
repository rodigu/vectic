Vectic={}
Vectic={
	new=function(x,y)return{x=x,y=y}end,
	add=function(v,v2)return Vectic.new(v.x+v2.x,v.y+v2.y)end,
	sub=function(v,v2)return Vectic.new(v.x-v2.x,v.y-v2.y)end,
	mul=function(v,s)return Vectic.new(v.x*s,v.y*s)end,
	repr=function(v) return "Vectic.new("..v.x..", "..{v.y}..")"end,
	div=function(v,s)
	 if type(s)=="number" then return Vectic.new(v.x/s,v.y/s) end
	 return Vectic.new(v.x/s.x,v.y/s.y)
	end,
	floordiv=function(v,s)
	 if type(s)=="number"then return Vectic.new(v.x//s,v.y//s)end
	 return Vectic.new(v.x//s.x,v.y//s.y)
	end,
	floor=function(v)return Vectic.floordiv(v,1)end,
	dist2=function(v,v2)return(v.x-v2.x)^2+(v.y-v2.y)^2 end,
	dist=function(v,v2)return math.sqrt(v.dist2(v2))end,
	norm=function(v)return Vectic.dist(v,Vectic.zero())end,
	len=Vectic.norm,
	eq=function(v,v2)return v.x==v2.x and v.y==v2.y end,
	normalize=function(v)return Vectic.div(v,Vectic.norm(v))end,
	rotate=function(v,t)return Vectic.new(v.x*math.cos(t)-v.x*math.sin(t),v.y*math.sin(t)+v.y*math.cos(t))end,
	copy=function(v)return Vectic.new(v.x,v.y)end,
	zero=function()return Vectic.new(0,0)end,
	xy=function(v)return v.x,v.y end
}