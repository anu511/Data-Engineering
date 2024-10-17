#!/usr/bin/python3
"""reducer.py"""
import sys
from collections import defaultdict

current_word = None
current_count = 0
word = None
countries = []
# input comes from STDIN
for line in sys.stdin:

    line = line.strip()
    # parse the input we got from mapper.py
    # word & count are seperated by <tab> delimited
    # 1 -> No of splits
    word, count = line.split(',', 1)

    # convert count (currently a string) to integer data
    try:
        count = int(count)
    except ValueError:
        # count was not a number, so silently
        # ignore/discard this line
        continue

    # this IF-switch only works because Hadoop sorts map output
    # by key (here key is word) before it is passed to the reducer
    if current_word == word:
        current_count += count
    else:
        if current_word:
            # write result to stdoutput seperated by tab
            # print ('%s\t%s' % (current_word, current_count))
            countries.append((current_word, current_count))
# making current_word = word
        current_count = count
        current_word = word

# do not forget to output the last word if needed!
if current_word == word:
    countries.append((current_word, current_count))
#    print ('%s\t%s' % (current_word, current_count))

countries.sort(key = lambda x: x[1], reverse=True)
for country in countries:
	print("%s\t%s" % country)
