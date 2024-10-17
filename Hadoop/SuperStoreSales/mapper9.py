#!/usr/bin/python3
"""mapper6.py"""
import sys

for line in sys.stdin:
	line = line.strip().split(",")
	income= line[-2]
	rating = line[-1]
	print('%s,%s' % (income,rating))



