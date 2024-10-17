#!/usr/bin/python3
"""mapper.py"""
import sys
for line in sys.stdin:
	line = line.strip().split(",")
	branch = line[1]
	prod= line[5]
	quan = line[7]
	print('%s,%s,%s' % (branch,prod, quan))



