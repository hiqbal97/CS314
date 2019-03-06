#!/usr/bin/env python3

def main():
	dim1 = input()
	size1 = [int(x) for x in dim1.split() if x.isdigit()]
	mat1 = []
	for i in range(size1[0]):
		rows = input()
		row = []
		for num in rows.split():
			row.append(float(num))
		mat1.append(row)
	dim2 = input()
	size2 = [int(x) for x in dim2.split() if x.isdigit()]
	mat2 = []
	for i in range(size2[0]):
		rows = input()
		row = []
		for num in rows.split():
			row.append(float(num))
		mat2.append(row)
	if size1[1] != size2[0]:
		print('invalid input')
	else:
		result_mat = []
		for i in range(size1[0]):
			rows = []
			for j in range(size2[1]):
				rows.append(0)
			result_mat.append(rows)
		for i in range(len(mat1)):
			for j in range(len(mat2[0])):
				for k in range(len(mat2)):
					result_mat[i][j] += mat1[i][k] * mat2[k][j]
		for i in range(size1[0]):
			for j in range(size2[1]):
				if j == (size2[1] - 1):
					print(result_mat[i][j])
				else:
					print(result_mat[i][j], '', end = '')

if __name__ == '__main__':
	main()
