#!/usr/bin/python3
"""reducer4.py"""
import sys
from collections import defaultdict

issue_weights = defaultdict(list)

for line in sys.stdin:
    issues, weight = line.strip().split(',')
    try:
        issues = int(issues)
        weight = float(weight)
        if issues > 0:
            issue_weights[issues].append(weight)
    except ValueError:
        continue

issue_weights = dict(sorted(issue_weights.items(), key=lambda x: x[0]))

for si in issue_weights:
    weights = issue_weights[si]
    total_weight = sum(weights)
    average_weight = total_weight / len(weights)
    print(f"{si}\t{average_weight:.2f}\t{total_weight:.2f}")

