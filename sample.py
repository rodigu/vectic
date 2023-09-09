# title:   Vectic sample use
# author:  https://cohost.org/digo
# desc:    code example for vectic
# site:    website link
# license: MIT License (change this to your license of choice)
# version: 0.1
# script:  python

def TIC():
 cls(0)
 global v
 mv=Vectic(mouse()[0],mouse()[1])
 
 v2=mv-v

 v2=v2.normalized()
 d=v.dist(mv)

 circb(v.x,v.y,d,2)
 v2*=20
 v2+=v
 circ(v2.x,v2.y,3,3)


import math
class Vectic:
 def __init__(A,x,y):
  A.x=x
  A.y=y
 def __add__(A,v):return Vectic(v.x+A.x,v.y+A.y)
 def __iadd__(A,v):
  A.x+=v.x
  A.y+=v.y
  return A
 def __sub__(A,v):return Vectic(A.x-v.x,A.y-v.y)
 def __isub__(A,v):
  A.x-=v.x
  A.y-=v.y
  return A
 def __mul__(A,s):return Vectic(A.x*s,A.y*s)
 def __imul__(A,s):
  A.x*=s
  A.y*=s
  return A
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
 def copy(A):return Vectic(A.x,A.y)
 def zero():return Vectic(0,0)

v=Vectic(256/2,136/2)


# <TILES>
# 001:eccccccccc888888caaaaaaaca888888cacccccccacc0ccccacc0ccccacc0ccc
# 002:ccccceee8888cceeaaaa0cee888a0ceeccca0ccc0cca0c0c0cca0c0c0cca0c0c
# 003:eccccccccc888888caaaaaaaca888888cacccccccacccccccacc0ccccacc0ccc
# 004:ccccceee8888cceeaaaa0cee888a0ceeccca0cccccca0c0c0cca0c0c0cca0c0c
# 017:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
# 018:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
# 019:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
# 020:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
# </TILES>

# <WAVES>
# 000:00000000ffffffff00000000ffffffff
# 001:0123456789abcdeffedcba9876543210
# 002:0123456789abcdef0123456789abcdef
# </WAVES>

# <SFX>
# 000:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000304000000000
# </SFX>

# <TRACKS>
# 000:100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
# </TRACKS>

# <PALETTE>
# 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
# </PALETTE>

