#!/usr/bin/python3
"""mapper2.py"""
import sys
for line in sys.stdin:
	line = line.strip().split(",")
	size = line[3]
	refill= line[6]
	print('%s,%s' % (size,refill))



