#5a
x = [1,2,3]
y = ['a','b','c']
def f(x):
	x=y
f(x)
ans=x[0]
print("5(a) ans="+str(ans))

#(b)
def f(x):
	def g(y):
		return a(x+y)
	return g
a = f(10)
try:
  ans = a(0)
  print("5(b) ans="+str(ans))
except:
  print("5(b) error")

#(c)
a = [0]
def f(x):
	a = [10]
	def g(y):
		a[0] = a[0] + x + y
		return a[0]
	return g
foo = f(10)
foo(1000)
ans = (a[0],foo(1))
print("5(c) ans="+str(ans))

#(d)
class A():
	def __init__(self):
		self.x = []
	def a(self):
		self.x += ["a"]
		self.d()
class B(A):
	def b(self):
		self.x += ["b"]
class C(A):
	def a(self):
		self.x += ["ca"]
	def c(self):
		self.x += ["c"]
class D(B,C):
	def d(self):
		self.x += ["d"]
		self.b()
		self.c()
o = D()
o.a()
ans = o.x
print("5(d) ans="+str(ans))

#(e)
def foo(n):
	i=1
	while (i <= n):
		i += i
		yield i
ans = 0
x = foo(10)
for i in x:
	ans += i
print("5(e) ans="+str(ans))


#6(a)
def element_and_rest(l):
	for i in range(len(l)):
		yield(l[i], l[0:i]+l[i+1:])

print("6(a)")
for t in element_and_rest([1,2,3,4,5]):
	print(t)


#6(b)
print("6(b)")
def permutations(l):
	if not l: yield []
	for x,y in element_and_rest(l):
		for p in permutations(y):
			yield [x]+p
for p in permutations([1,2,3]):
	print(p)
