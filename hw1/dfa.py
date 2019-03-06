#!/usr/bin/env python3

import re

def main():
	input()
	input()
	input()
	begin_rules = True
	stdin = input()
	rules = {}
	while begin_rules:
		try:
			if(stdin == 'end_rules'):
				begin_rules = False
			else:
				rule_list = stdin.split()
				rules[(rule_list[0], rule_list[4])] = rule_list[2]
			stdin = input()
		except EOFError:
			return
	start = stdin.split()[1]
	stdin = input()
	final = stdin.split()[1:]
	while(True):
		try:
			x = input()
			current = start
			for i in x:
				current = rules.get((current, i))
			if current in final:
				print("accepted")
			else:
				print("rejected")
		except:
			return

if __name__ == '__main__':
	main()
