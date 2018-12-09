#3
def print_first_k_args(k):
	def decorator(f):
		def decorateed(*args):
			for i in range(min(k,len(args))):
				print("Arg %s:(%s)"%(i+1,args[i]))
			rv=f(*args)
			print("Return: "+str(rv))
			return rv
		return decorateed
	return decorator


#4
img1=[[255,255,  0,  0,255,255],
      [255,255,  0,  0,255,255],
      [  0,  0,255,  0,  0,  0],
      [  0,  0,255,255,  0,  0],
      [255,  0,  0,  0,  0,255],
      [  0,255,255,255,255,  0]]
#a
def create_image(w,h,c):
	return [[c]*w for i in range(h)]
#b
def well_formed(img):
	w=None
	for row in img:
		if not w : w = len(row)
		elif w != len(row): return False
		for x in row:
			if x < 0 or x > 255: return False
	return True
#c
def fill_rect(img,x0,y0,x1,y1,c):
	if len(img) == 0: return
	x0,y0,x1,y1=max(0,x0),max(0,y0),min(x1,len(img[0])),min(y1,len(img))
	for row in img[y0:y1]:
		row[x0:x1]=[c]*(x1-x0)
#d
def fill_region(img,oldcolor,newcolor,x,y):
	#print("filling (%s,%s) = %s"%(y,x,img[y][x]))
	img[y][x] = newcolor
	for (x1,y1) in [(x-1,y),(x+1,y),(x,y-1),(x,y+1)]:
		try:
			if x1 >= 0 and y1 >= 0 and img[y1][x1] == oldcolor: fill_region(img,oldcolor,newcolor,x1,y1)
		except:
			pass

fill_region(img,0,10,1,2)





