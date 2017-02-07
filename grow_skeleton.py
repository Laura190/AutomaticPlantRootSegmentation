#Takes skeleton and end points of skeleton as image sequenecs.
#will output a new skeleton of which is grwon in the direction of travel
#This is achuieved by using two types of convolution. First to check the direction of growth, this second to grow in that direction

from PIL import Image
import os, glob
import numpy as np
import os.path
import sys
import math
import itertools
import time
import functions as DIL


def up(i,j,k):
	return i,j,k-1

def down(i,j,k):
	return i,j,k+1

def right(i,j,k):
	return i,j+1,k

def left(i,j,k):
	return i,j-1,k

def front(i,j,k):
	return i+1,j,k

def back(i,j,k):
	return i-1,j,k

def iden(i,j,k):
	return i,j,k

def get_nbhs_no_bounds(i,j,k):
	#will return list of nbhs not including itself to this index
	return [up(i,j,k), down(i,j,k), right(i,j,k), left(i,j,k), front(i,j,k), back(i,j,k), up(*front(*right(i,j,k))), up(*front(*left(i,j,k))), up(*back(*right(i,j,k))), up(*back(*left(i,j,k))), down(*front(*right(i,j,k))), down(*front(*left(i,j,k))), down(*back(*right(i,j,k))), down(*back(*left(i,j,k)))]	
		
def remove_bad_nbhs(list_of_nbhs,X_max,Y_max,Z_max):
	#throughs away nbhs. assumes lower bounds atre always zero
	good_list=[]
	for triple in list_of_nbhs:
		if triple[0]>=0 and triple[0]<X_max and triple[1]>=0 and triple[1]<Y_max and triple[2]>=0 and triple[2] < Z_max:
			good_list.append(triple)

	return good_list

def get_nbhs(i,j,k,X_max,Y_max,Z_max):
	return remove_bad_nbhs(get_nbhs_no_bounds(i,j,k),X_max,Y_max,Z_max)

def compose3(f,g,h):
	return lambda x1,x2,x3:f(*g(*h(x1,x2,x3)))

def find_direction(end,pen):
	if up(pen[0],[1],pen[2]) == end:
		return up
	elif down(pen[0],pen[1],pen[2]) ==end:
		return down
	elif right(pen[0],pen[1],pen[2]) == end:
		return right
	elif left(pen[0],pen[1],pen[2]) == end:
		return left
	elif front(pen[0],pen[1],pen[2]) == end:
		return front
	elif back(pen[0],pen[1],pen[2]) ==end:
		return back
	elif up(*front(*right(pen[0],pen[1],pen[2]))) == end:
		return compose3(up,front,right)
	elif up(*front(*left(pen[0],pen[1],pen[2]))) == end:
		return compose3(up,front,left)
	elif up(*back(*right(pen[0],pen[1],pen[2]))) == end:
		return compose3(up,back,right)
	elif up(*back(*left(pen[0],pen[1],pen[2]))) == end:
		return compose3(up,back,left)
	elif down(*front(*right(pen[0],pen[1],pen[2]))) == end:
		return compose3(down,front,right)
	elif down(*front(*left(pen[0],pen[1],pen[2]))) == end:
		return compose3(down,front,left)
	elif down(*back(*right(pen[0],pen[1],pen[2]))) ==end:
		return compose3(down,back,right)
	elif down(*back(*left(pen[0],pen[1],pen[2]))) == end:
		return compose3(down,back,left)
	elif iden(pen[0],pen[1],pen[2]) == end:
		return iden
	else:
		raise ValueError("End point and penultament point are not within one pixel")
		

def get_list_of_end_points(end_points):
	l = np.nonzero(end_points)
	end_points_list=[]
	for i in range(len(l[0])):
		x=l[0][i]
		y=l[1][i]
		z=l[2][i]
		end_points_list.append((x,y,z))

	return end_points_list

def get_penults(end,skeleton,iso=255):
	X_max,Y_max,Z_max = np.shape(skeleton)
	nbhs = get_nbhs(end[0],end[1],end[2],X_max,Y_max,Z_max)
	penults =[]
	for triple in nbhs:
		if skeleton[triple[0],triple[1],triple[2]] == iso:
			penults.append(triple)	
	return penults


class end_point:
	def __init__(self,end,skeleton,iso=255):
		self.end = end #the end point location
		self.iso = iso #iso to look for in the skeleton
		self.penults = get_penults(end,skeleton,iso) #list of points in skeleton joined to en_point
		self.directions = "call self.get_directions() to fill" #will be list of directions in which we need to grow
		
	def get_directions(self):
		dirs = []
		for pen in self.penults:
			dirs.append(find_direction(self.end,pen))
		self.directions = dirs
		
	def grow(self): #will return list of pixels to fill to grow this end point --- finish off



if __name__=="__main__":
	END_POINT_DIR ="./end_points/"
	SKELETON_DIR = "./skeleton/"

	end_points = DIL.load_image_sequence(END_POINT_DIR)
	skeleton = DIL.load_image_sequence(SKELETON_DIR)
	X_max,Y_max,Z_max = np.shape(skeleton)
	end_point_list =get_list_of_end_points(end_points)

	test=end_point(end_point_list[10],skeleton)
	test.get_directions()
	
				
	
	
	

