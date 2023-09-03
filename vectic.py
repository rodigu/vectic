import math

class Vector:
 def __init__(self, x:int, y:int):
  self.x=x
  self.y=y
 def __add__(self, v: "Vector"):
  return Vector(v.x+self.x, v.y+self.y)
 def __iadd__(self, v: "Vector"):
  self.x+=v.x
  self.y+=v.y
  return self
 def __sub__(self, v: "Vector"):
  return Vector(self.x-v.x,self.y-v.y)
 def __isub__(self, v: "Vector"):
  self.x-=v.x
  self.y-=v.y
  return self
 def __mul__(self, s: int|float):
  return Vector(self.x*s, self.y*s)
 def __imul__(self, s: int|float):
  self.x*=s
  self.y*=s
  return self
 def __repr__(self):
  return f"Vector({self.x}, {self.y})"
 def __truediv__(self, s):
  if isinstance(s,Vector):
   return Vector(self.x/s.x, self.y/s.y)
  return Vector(self.x/s,self.y/s)
 def __floordiv__(self, s):
  if isinstance(s,Vector):
   return Vector(self.x//s.x, self.y//s.y)
  return Vector(self.x//s,self.y//s)
 def __floor__(self):
  return self//1
 def __len__(self):
  return self.norm()
 def __eq__(self, v: "Vector"):
  return self.x==v.x and self.y==v.y
 def dist(self, v: "Vector"):
  return math.sqrt(self.dist2(v))
 def dist2(self, v: "Vector"):
  return (self.x-v.x)**2 +(self.y-v.y)**2
 def norm(self):
  return self.dist(Vector.zero())
 def normalized(self):
  return self / self.norm()
 def rot(self,t: int|float):
  return Vector(self.x*math.cos(t)-self.x*math.sin(t), self.y*math.sin(t)+self.y*math.cos(t))
 def zero():
  return Vector(0,0)
 

if __name__=='__main__':
 a=Vector(1,2)
 b=Vector(2,3)
 print(a+b)
 a+=b
 print(a)
 print(b*1.5)
 print(a*2)
 print(isinstance(a, Vector))
