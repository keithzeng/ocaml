#6(a)
a = 10
def f(a,x):
	a = a + x
	return a
x = f(a,10)
ans = a + x
print("6(a) ans = " + str(ans))

#(b)
a = [10]
def f(a,x):
	a[0] = a[0] + x
	return a[0]
x = f(a,10)
ans = a[0] + x
print("6(b) ans = " + str(ans))

#(c)
class Vector:
	data = []
	def __init__(self,v,n):
		for i in range(n):
			self.data.append(v)
x = Vector(2,2)
y = Vector(3,3)
ans = (x.data,y.data)
print("6(c) ans = " + str(ans))

#(d)
c = [0]
def f(x):
	c[0] += 1
	if x == 0: raise Exception(0)
	r = g(x-1)
	c[0] -= 1
	return g(x-1)
def g(x):
	c[0] += 1
	if x == 0: raise Exception(1)
	r = f(x-1)
	c[0] -= 1
	return r
def do(x):
	try: f(x)
	except Exception as e: return str(e)
r = list(map(do,[0,1,2,3,4,5,6,7,8,9]))
ans = (c[0],r)
print("6(d) ans = " + str(ans))

#(e)
class A:
	def __init__(self):
		pass
	def f(self):
		return "A," + self.g()
class B(A):
	def g(self):
		return ("B")
class C(A):
	y=0
def do(y):
	try: return y.f()
	except: pass
b = B()
c = C()
ans = (do(b),do(c))
print("6(e) ans = " + str(ans))

#7(a)
print("7(a) Python decorator can refers to the decorated fun while SML cannot")

#(b)
def streamify(f):
	def g(s):
		for x in s:
			for y in f(x):
				yield y
	return g

@streamify
def g(x):
	return range(x)
print("7(b) no idea")


