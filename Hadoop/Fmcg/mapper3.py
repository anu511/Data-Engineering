#!/usr/bin/python3
"""mapper4.py"""
import sys
for line in sys.stdin:
	line = line.strip().split(",")
	if line[7] != "transport_issue_l1y" or line[22] != "product_wg_ton":
		issue = line[7]
		weight= line[22]
		print('%s,%s' % (issue,weight))



