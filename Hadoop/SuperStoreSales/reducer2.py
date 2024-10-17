#!/usr/bin/python3
"""reducer.py"""
import sys

current_prod = None
current_rate = 0
prod = None
c=0
for line in sys.stdin:

    line = line.strip()
    prod, rate = line.split(',')
    try:
        rate = float(rate)
    except ValueError:
        continue
    if current_prod == prod:
        current_rate += rate
        c+=1
    else:
        if current_prod:
            print ('%s\t%s' % (current_prod, current_rate/c))
        current_rate = rate
        current_prod = prod

if current_prod==prod:
	print ('%s\t%s' % (current_prod, current_rate/c))
