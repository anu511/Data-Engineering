#!/usr/bin/python3
"""reducer.py"""
import sys

current_day = None
current_total = 0
records=[]
for line in sys.stdin:

    line = line.strip()
    day,total = line.split(',')
    try:
        total = float(total)
    except ValueError:
        continue
    if current_day == day:
        current_total += total
    else:
        if current_day:
            records.append((current_day,current_total))
        current_day = day
        current_total = total

if current_day==day:
	records.append((current_day,current_total))

records.sort(key = lambda x: x[1], reverse=True)

for i in records:
	print("%s,%s"%(i[0],i[1]))

