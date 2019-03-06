#!/usr/bin/env python3

import re

class Tree:
	def __init__(self, x):
		self.data = x
		self.l = None
		self.r = None
		
	def insert_node(self, x):
		if self.data:
			if self.data > x:
				if self.l:
					self.l.insert_node(x)
					return(x)
				else:
					self.l = Tree(x)
					return(x)
			elif self.data < x:
				if self.r:
					self.r.insert_node(x)
					return(x)
				else:
					self.r = Tree(x)
					return(x)
			else:
				return(None)
		else:
			self.data = x
			
	def find_node(self, x, string=""):
		if self.data:
			if x == self.data:
				if string:
					print(string)
				else:
					print('found: root')
			elif x < self.data:
				if self.l:
					if string:
						self.l.find_node(x, string + ' l')
					else:
						self.l.find_node(x, 'found: l')
				else:
					print('not found')
			else:
				if self.r:
					if string:
						self.r.find_node(x, string + ' r')
					else:
						self.r.find_node(x, 'found: r')
				else:
					print('not found')
		else:
			print('not found')
			
def main():
	BST = Tree(None)
	while True:
		try:
			stdin = input()
		except EOFError:
			return
		num = int(re.search(r'\d+', stdin).group())
		if stdin[0] == 'i':
			BST.insert_node(num)
		elif stdin[0] == 'q':
			BST.find_node(num)
		else:
			print('invalid input')

if __name__=="__main__":
	main()
