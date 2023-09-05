
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
 v.eq=function(v2)return v.x==v2.x and v.y==v2.y
 v.normalized=function()return v.div(v.norm())end
 v.normalize=function()
  v=v.normalized()
  return v
 end
 function rotate(t)return Vectic.new(v.x*math.cos(t)-v.x*math.sin(t),v.y*math.sin(t)+v.y*math.cos(t))end
 function copy()return Vectic.new(v.x,v.y)end
 return v
end