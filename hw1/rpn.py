#!/usr/bin/env python3

import re

class Stack:
	def __init__(self):
		self.data = []
	def push(self, x):
		self.data.append(x)
	def pop(self):
		return self.data.pop()
	def length(self):
		return len(self.data)
		
def main():
	RPN = Stack()
	while True:
		try:
			stdin = input()
		except EOFError:
			return
		try:
			x = int(stdin)
			print(stdin)
			RPN.push(x)
		except ValueError:
			if stdin == '+' and RPN.length() > 1:
				n = RPN.pop()
				n += RPN.pop()
				RPN.push(n)
				print(n)
			elif stdin == '-' and RPN.length() > 1:
				n = RPN.pop()
				x = RPN.pop()
				n = x - n
				RPN.push(n)
				print(n)
			elif stdin == '*' and RPN.length() > 1:
				n = 0
				n = RPN.pop()
				n *= RPN.pop()
				RPN.push(n)
				print(n)
			elif stdin == '~' and RPN.length() > 0:
				n = 0
				n = RPN.pop()
				n *= -1
				RPN.push(n)
				print(n)
			elif stdin == '/' and RPN.length() > 1:
				n = RPN.pop()
				x = RPN.pop()
				if n == 0:
					print('error: division by zero')
					RPN.push(x)
					RPN.push(n)
				else:
					n = x / n
					RPN.push(n)
					print(n)
			else:
				print('invalid operation')
				

if __name__=="__main__":
	main()
