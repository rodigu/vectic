import numpy as np

def random_pts(k:int,vec_size:int,dims:np.matrix):
  k_pts=np.empty((k,vec_size))
  for i in range(k):
    for j in range(vec_size):
      k_pts[i][j]=np.random.uniform(dims[j][0],dims[j][1])
  return k_pts

def dimension_ranges(m:np.matrix,vec_size:int):
  dims=np.empty((vec_size,2))
  for i in range(vec_size):
    dims[i][0]=min(m[::,i])
    dims[i][1]=max(m[::,i])
  return dims

def group_pts(m:np.matrix,ks:np.matrix):
  groupings=np.empty((len(m),1))
  for i,v in enumerate(m):
    min_dist=np.inf
    for j,k in enumerate(ks):
      d=dist(v,k)
      if d<min_dist:
        min_dist=d
        groupings[i]=j
  return groupings.astype(int)

def mean_pts(m:np.matrix,gs:np.matrix,k:int):
  means=np.empty((k,len(m[0])))
  for i in range(k):
    in_gs=np.append(gs==i,gs==i,axis=1)
    pts_count=np.count_nonzero(in_gs)//2
    reshaped=np.reshape(m[in_gs],(pts_count,len(m[0])))
    means[i]=reshaped.mean()
  return means

def kmeans(m:np.matrix,k:int,max_iters=100):
  vec_size=len(m[0])
  dims=dimension_ranges(m,vec_size)
  ks=random_pts(k,vec_size,dims)
  prev_grouping=group_pts(m,ks)
  new_grouping=np.empty(prev_grouping.shape)
  for _ in range(max_iters):
    pts=mean_pts(m,prev_grouping,k)
    new_grouping=prev_grouping.copy()
    new_grouping=group_pts(m,pts)
    if np.array_equal(new_grouping,prev_grouping): break
  return new_grouping

def dist(a:np.matrix,b:np.matrix):
  return np.linalg.norm(a-b)