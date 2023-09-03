import math
class Vectic:
  def __init__(A,x,y):A.x=x;A.y=y        
  def __add__(A,v):return Vectic(v.x+A.x,v.y+A.y)
  def __iadd__(A,v):A.x+=v.x;A.y+=v.y;return A
  def __sub__(A,v):return Vectic(A.x-v.x,A.y-v.y)
  def __isub__(A,v):A.x-=v.x;A.y-=v.y;return A
  def __mul__(A,s):return Vectic(A.x*s,A.y*s)
  def __imul__(A,s):A.x*=s;A.y*=s;return A
  def __repr__(A):return f"Vectic({A.x}, {A.y})"
  def __truediv__(A,s):
    if isinstance(s,Vectic):return Vectic(A.x/s.x,A.y/s.y)
    return Vectic(A.x/s,A.y/s)
  def __floordiv__(A,s):
    if isinstance(s,Vectic):return Vectic(A.x//s.x,A.y//s.y)
    return Vectic(A.x//s,A.y//s)
  def __floor__(A):return A//1
  def __len__(A):return A.norm()
  def __eq__(A,v):return A.x==v.x and A.y==v.y
  def dist(A,v):return math.sqrt(A.dist2(v))
  def dist2(A,v):return(A.x-v.x)**2+(A.y-v.y)**2
  def norm(A):return A.dist(Vectic.zero())
  def normalized(A):return A/A.norm()
  def rot(A,t):return Vectic(A.x*math.cos(t)-A.x*math.sin(t),A.y*math.sin(t)+A.y*math.cos(t))
  def zero():return Vectic(0,0)