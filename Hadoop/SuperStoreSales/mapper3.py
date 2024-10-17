#!/usr/bin/python3
"""mapper3.py"""
import sys
for line in sys.stdin:
	line = line.strip().split(",")
	city= line[2]
	payment = line[12]
	print('%s,%s,%s' % (city, payment,1))



