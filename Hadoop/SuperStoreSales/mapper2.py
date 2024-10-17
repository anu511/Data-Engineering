#!/usr/bin/python3
"""mapper2.py"""
import sys
for line in sys.stdin:
	line = line.strip().split(",")
	product_line = line[5]
	rating = line[-1]
	print('%s,%s' % (product_line, rating))



