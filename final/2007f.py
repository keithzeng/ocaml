#5
#a
x = ["a","b","c"]
y = [1,2,3]

def f(a,b):
	a = ["p","q"]
	b[0] = "r"
f(x,y)
ans = (x,y)
print("5(a) = " + str(ans))

#b
def f(x):
	b = [x]
	def g(y):
		rv = y - a - b[0]
		b[0] = y
		return rv
	return g
a = 10
b = [100]
f1 = f(1000)
ans = (f1(10000),f1(10000))
print("5(b) = " + str(ans))

#c
def q(n,g):
	count = [n]
	def g1(x):
		#print("calling q " + str(count[0]))
		if count[0] > 0:
			count[0] -= 1
			return g(x)
		else:
			return 0
	return g1

def fac(k):
	#print("calling original "+str(k))
	if k <= 1: return 1
	else: return k*(fac(k-1))

fac = q(7,fac)
ans = (fac(5),fac(5))
print("5(c) = " + str(ans))

#6
#d
def tick():
	def g():
		g.count += 1
		return g.count
	g.count=0
	return g

#7
#a
def valid(es,c):
	for x,y in es:
		if c[x]==c[y]: return False
	return True
#b
def colorings(n,k):
	if n<=0: return [[]]
	else: return [[i]+c for i in range(k) for c in colorings(n-1,k)]

for c in colorings(3,2):
	print(c)

#c
def vertices(es):
	vs = []
	for (i,j) in es: vs += [i,j]
	return max(vs)

def colorable(es,k):
	for c in colorings(vertices(es),k):
		if valid(es,c): return True
	return False

class colorings:
	def __init__(self,n,k):
		self.colors = k
		self.vertices = n
		self.current = 0
	def next(self):
		if self.current == 0:
			self.current = initColoring(self.vertices)
		elif lastColoring(self.current,self.colors):
			raise StopIteration
		else:
			self.current = nextColoring(self.current,self.colors)
		return self.current
	def __iter__(self):
		return self


def initColoring(n):
	return [0]*n
def nextColoring(c,k):
	curid=-1
	while(curid>=-len(c)):
		if(c[curid]+1<k):
			c[curid]+=1
			break
		else:
			c[curid]=0
		curid-=1
	return c
def lastColoring(c,k):
	return c == [k-1]*len(c)

#8
#a
class C:
	def __init__(self,v):
		self.x = v


def tracked(C):
	tracked.count=0
	tracked.insts=[]
	class CC:
		def __init__(self,*args):
			inst=C(*args)
			tracked.insts.append(inst)
			self.id=tracked.count
			tracked.count+=1
		def instId(self):
			return self.id
		def getInst(self,id):
			return tracked.insts[id]
	return CC


C = tracked(C)
c1 = C("Jack")
c2 = C([0,1,2])
c3 = C(2004)
ids = [c1.instId(), c2.instId(), c3.instId()]
[c1.getInst(id).x for id in ids]


#b
def automap(f):
	def g(x):
		if type(x) == list:
			return [f(i) for i in x]
		else:
			return f(x)
	return g


@automap
def square(x):
	return x*x

#c
def automap(f):
	def g(x):
		if hasattr(x,"__iter__"):
			return [f(i) for i in x]
		else:
			return f(x)
	return g
