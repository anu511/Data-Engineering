#!/usr/bin/python3
"""reducer3.py"""
import sys


current_city= None
current_payment = None
payment_count=0
city_payments={}

for line in sys.stdin:

    line = line.strip()
    city, payment_method,count = line.split(',')
    count=int(count)
    if current_city == city and current_payment==payment_method:
        payment_count += count
    else:
        if current_city and current_payment:
            if current_city not in city_payments:
                city_payments[current_city] = {}
            if current_city in city_payments[current_city]:
                city_payments[current_city][current_payment] +=payment_count
            else:
                city_payments[current_city][current_payment] = payment_count
            #print ('%s\t%s' % (current_prod, current_rate/c))
        current_city = city
        current_payment = payment_method
        payment_count = count

if current_city and current_payment:
    if current_city not in city_payments:
        city_payments[current_city] = {}
    if current_city in city_payments[current_city]:
        city_payments[current_city][current_payment] +=payment_count
    else:
        city_payments[current_city][current_payment] = payment_count

for city in city_payments:
    most_popular_payment = max(city_payments[city],key = city_payments[city].get)
    print(f"{city}\t{most_popular_payment}")
