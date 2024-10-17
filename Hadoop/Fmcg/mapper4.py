#!/usr/bin/python3
"""mapper2.py"""
import sys
for line in sys.stdin:
	line = line.strip().split(",")
	if line[-6] != "storage_issue_reported_l3m," or line[22] != "product_wg_ton":
		issue = line[-6]
		weight= line[22]
		print('%s,%s' % (issue,weight))



