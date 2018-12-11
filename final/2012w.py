#2
img1=[[ 11,  0, 12],
      [  0,  0,  0],
      [ 13,  0, 14],
      [ 15, 16, 17]]

#a
def square_img(img):
	return [[x*x for x in row] for row in img]

#b
def crop_img(img,x1,y1,x2,y2):
	return [row[x1:x2] for row in img[y1:y2]]

#c
def zip(l1,l2):
	return [(l1[i],l2[i]) for i in range(min(len(l1),len(l2)))]

#d
def add_imgs(img1, img2):
     return [[x + y for x,y in zip(l1,l2)] for (l1,l2) in zip(img1,img2)]

#3
def derivative(delta):
	def decorator(f):
		def decorateed(x):
			return round((f(x+delta)-f(x))/delta,2)
		return decorateed
	return decorator

def derivate(delta):
	class Decorator:
		def __init__(self,f):
			self.f = f
		def __call__(self, x):
			return round((self.f(x+delta)-self.f(x))/delta,2) 

