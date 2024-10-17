#!/usr/bin/python3
"""reducer3.py"""
import sys
from collections import defaultdict

issues = None
issue_weights = defaultdict(list)
issue_count = defaultdict(int)

for line in sys.stdin:
    issues, weight = line.strip().split(',')
    try:
        weight = float(weight)
        if int(issues) > 0:
            issue_weights[issues].append(weight)
            issue_count[issues] += 1
    except ValueError:
        continue

issue_weights = dict(sorted(issue_weights.items(), key=lambda x: x[0]))


for ti in issue_weights:
    weights = issue_weights[ti]
    total_weight = sum(weights)
    average_weight = total_weight / len(weights)
    print(f"{ti}\t{average_weight:.2f}\t{total_weight}")

