#!/usr/bin/python3
"""reducer2.py"""
import sys
import numpy as np
from collections import defaultdict

capacity_sizes = []
refill_requests = []
capacity = defaultdict(list)
capacity_chart = {'Small': 1, 'Mid': 2, 'Large': 3}

# Collect data
for line in sys.stdin:
	capacity_size, refill_request = line.strip().split(',')

	try:
		refill_request = int(refill_request)
		if capacity_size in capacity_chart:
			capacity[capacity_chart.get(capacity_size)].append(refill_request)
			capacity_sizes.append(capacity_chart.get(capacity_size))
			refill_requests.append(refill_request)
	except ValueError:
        	continue

# capacity_sizes = np.array(capacity_sizes)
# refill_requests = np.array(refill_requests)

capacity_sizes = np.array(list(capacity.keys()))
refill_requests = np.array([sum(val)/len(val) for val in capacity.values()])

print("Warehouse Capacity Sizes:", capacity_sizes)
print("Avg. Refill Requests:", refill_requests)

correlation_matrix = np.corrcoef(capacity_sizes, refill_requests)
correlation = correlation_matrix[0, 1]
print(f"Correlation between warehouse capacity and refill requests: {correlation}")



