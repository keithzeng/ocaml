#5
#a
def rev(l):
	return [l[i] for i in range(len(l) - 1,-1, -1)]

#b
from functools import reduce
def rev(l):
	def fold_fn(acc, elm): return [elm]+acc
	return reduce(fold_fn,l,[])


#6
def print_some(l):
	def decorator(f):
		def decorated(*args):
			for i in l:
				if i == -1: decorated.rv = True
				elif i >= 0 and i < len(args): print("Arg %s: %s"%(i,args[i]))
			rv = f(*args)
			if decorated.rv: print("Return: "+str(rv))
			return rv
		decorated.rv = False
		return decorated
	return decorator


@print_some([-1,1,0])
def plus(x,y):
	print("-- plus called --")
	return x+y


@print_some([-2,100])
def plus(x,y):
	print("-- plus called --")
	return x + y


@print_some([-1,0])
def fac(n):
	print("-- fac called --")
	if n is 0: return 1
	else: return n * fac(n-1)

#7
class Tree:
	def __init__(self, name, children):
		self.name = name
		self.children = children
	# Returns True if the Tree represents a prolog variable (e.g. X), and False otherwise
	def is_var(self):
		return isinstance(self.name,str) and self.children == []
	def __repr__(self):
		if self.children: return self.name+'(%s)'%(', '.join([repr(c) for c in self.children]))
		else: return str(self.name)

# Constructs a Tree representing a Prolog variable with name n
def var(n): return Tree(n, [])

# Constructs a Tree representing a non-variable term with name n and children c
def node(n, c): return Tree(n, c)


s = {}
s["X"] = node("foo", [node(5, []), node(6, [])])
s["Y"] = node("baz", [node(10, [])])
s


s["X"]


s["Y"]

#a
def apply_to_tree(s,t):
	if not t.is_var():
		return node(t.name,[apply_to_tree(s,c) for c in t.children])
	elif t.name in s:
		return node(s[t.name].name,[apply_to_tree(s,c) for c in s[t.name].children])
	else:
		return node(t.name, t.children)


s1 = {}
s1["X"] = node("foo", [node(5, [])])
s2 = s1.copy()
s2["Y"] = node("baz", [node(10, []), var("X")])
t1 = node("bat", [var("X")])
t2 = node("bat", [var("X"), var("Y")])


#b
def unify(a,b,s={}):
	a = apply_to_tree(s, a)
	b = apply_to_tree(s, b)
	result = s.copy()
	print("checking "+ repr(a) +", "+repr(b))
	if a.is_var() and b.is_var():
		result[a.name] = b
	elif a.is_var() and not b.is_var():
		if a.name in result: result=unify(result[a.name],b,result)
		else: result[a.name]=b
	elif not a.is_var() and b.is_var():
		return unify(b,a,s)
	elif not a.is_var() and not b.is_var():
		if a.name != b.name: return False
		if len(a.children) != len(b.children): return False
		for i in range(len(a.children)):
			result = unify(a.children[i],b.children[i],result)
	return result





t1 = node("foo", [var("X"),node(5,[])])
t2 = node("foo", [node(10,[]),var("Y")])
t3 = node("foo", [node(10,[]),var("X")])
t4 = node("bar", [var("X"),var("Y"),var("X")])
t5 = node("bar", [node("foo", [var("Y")]),node(3,[]),node("foo", [node(3,[])])])
t6 = node("bar", [node("foo", [var("Y")]),node(3,[]),node("foo", [node(4,[])])])


unify(t1,t2)
unify(t1,t3)
unify(t4,t5)
unify(t4,t6)

t7 = var("X")
t8 = var("Y")
unify(t7,t8)


t9 = node('foo',[var("A"),var('C'),var('A')])
t10 = node('foo',[var("C"),node(1,[]),node(2,[])])
unify(t9,t10)






