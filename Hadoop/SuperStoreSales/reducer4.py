#!/usr/bin/python3
"""reducer4.py"""
import sys
from collections import defaultdict

current_branch = None
branch_product_quantities = defaultdict(lambda: defaultdict(int))


for line in sys.stdin:
    branch, product_line, quantity = line.strip().split(',')

    try:
        quantity = int(quantity)
    except ValueError:
        continue

    branch_product_quantities[branch][product_line] += quantity


for branch, products in branch_product_quantities.items():
    for product_line, total_quantity in products.items():
        print(f"{branch} - {product_line} - {total_quantity}")


