#!/usr/bin/python3
"""reducer1.py"""
import sys
from collections import defaultdict

zone = None
regional_zone = None
zonal_weights = defaultdict(lambda: defaultdict(list))

# Read input from stdin
for line in sys.stdin:
    zone, regional_zone, weight = line.strip().split(',')
    try:
        weight = float(weight)
        zonal_weights[zone][regional_zone].append(weight)
    except ValueError:
        continue


for zone, WH in zonal_weights.items():
    for region, weights in WH.items():
        total = sum(weights)
        print(f"{zone}\t{region}\t{total:.2f}")

