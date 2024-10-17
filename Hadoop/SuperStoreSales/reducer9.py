#!/usr/bin/python3
"""reducer9.py"""
import sys
import numpy as np
inc=[]
rat=[]
for line in sys.stdin:

    line = line.strip()
    income,rating = line.split(',')
    try:
        rating = float(rating)
        income = float(income)
        inc.append(income)
        rat.append(rating)
    except ValueError:
        continue


inc=np.array(inc)
rat=np.array(rat)

result=np.corrcoef(inc,rat)
print("Correlation between Gross Income and Ratings: %f" % (result[0,1]))

