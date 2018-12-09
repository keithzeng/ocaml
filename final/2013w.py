#3
A=[[ 1,  2, 3],
   [ 4,  5, 6]]

def transpose(m):
	height = len(m)
	width = len(m[0])
	return [[ m[i][j] for i in range(height) ] for j in range(width)]


#4
def access(g,x,y):
	try: return g[y][x]
	except: return 0


#a
def count_live_neighbours(g, x, y):
	live = 0
	for x_delta in [x-1,x,x+1]:
		for y_delta in [y-1,y,y+1]:
			if y_delta==y and x_delta==x: continue
			if x_delta>=0 and y_delta>=0  and access(g,x_delta,y_delta)==1:
				live+=1
	return live


#b
def new_val(g, x, y):
	count=count_live_neighbours(g,x,y)
	if count < 2 or count > 3: return 0
	elif count==3: return 1
	else: return access(g,x,y)


#c
def step(g):
	height = len(g)
	width = len(g[0])
	return [[new_val(g,x,y) for x in range(width)] for y in range(height)]


#5
#a
def lift_1(f):
	def decorated(x):
		return [f(i) for i in x]
	return decorated

#b
def lift_2(f):
	def decorated(x,y):
		return [f(x[i],y[i]) for i in range(min(len(x),len(y)))]
	return decorated


@lift_1
def inc(x): return x+1


@lift_1
def sqr(x): return x*x


@lift_2
def plus(x,y): return x + y


@lift_2
def mul(x,y): return x * y


@lift_2
@lift_2
def plus(x,y): return x + y

#c
m=[[1,2,3],[4,5,6]]
n=[[1,2,3],[4,5,6]]
plus(m,n)


#d
def lift(f):
	def decorated(*args):
		return [f(*x) for x in transpose(args)]
	return decorated


@lift
def inc(x): 
	return x+1

@lift
def sqr(x): return x*x


@lift
def plus(x,y): return x + y


@lift
def mul(x,y): return x * y


@lift
@lift
def plus(x,y): return x + y



