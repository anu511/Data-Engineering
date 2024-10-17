#!/usr/bin/python3
"""mapper6.py"""
import sys
from datetime import datetime

for line in sys.stdin:
	line = line.strip().split(",")
	if line[10]!='Date' and line[9]!='Total':
		date= line[10]
		total = line[9]
		day_of_week = datetime.strptime(date,"%m/%d/%Y").strftime("%A")
		print('%s,%s' % (day_of_week,total))



