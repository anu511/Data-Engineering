#!/usr/bin/python3
"""mapper8.py"""
import sys
from datetime import datetime

for line in sys.stdin:
	line = line.strip().split(",")
	if line[10]!='Date' and line[5]!='Product line' and line[7]!='Quantity':
		date= line[10]
		product_line = line[5]
		quantity = line[7]
		day_of_week = datetime.strptime(date,"%m/%d/%Y").strftime("%Y-%U")
		print('%s,%s,%s' % (product_line,day_of_week,quantity))



