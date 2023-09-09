# title:   game title
# author:  game developers, email, etc.
# desc:    short description
# site:    website link
# license: MIT License (change this to your license of choice)
# version: 0.1
# script:  python
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

F=0

def logo(x,y):
 global F
 rect(x+25,y+12+math.sin(F/15+7)*3,14,14,2)
 spr(0,x,y+math.sin(F/15)*2,0,8)

def TIC():
 cls(0)
 logo(240/2-4*8,136/2-8*4)
 global F
 F+=1

# <TILES>
# 000:d000000dd000000dd000000d0d0000d00d0000d000d00d0000d00d00000dd000
# 016:dd000000dd000000dd000000dd000000dd000000dd00000000dd000000dd0000
# 017:000000ee000000ee000000ee000000ee000000ee000000ee0000ee000000ee00
# 032:00dd000000dd00000000dd000000dd000000dd000000dd00000000dd000000dd
# 033:0000ee000000ee0000ee000000ee000000ee000000ee0000fe000000fe000000
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

