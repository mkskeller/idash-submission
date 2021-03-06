#!/usr/bin/python

import sys, re

files = [open(x) for x in sys.argv[1:]]

output = open('src/Player-Data/Input-P0-0', 'w')

n_examples = None
delim = None

i = 0
for lines in zip(*files):
    if delim is None:
        if ',' in lines[0]:
            delim = ','
        else:
            delim = '\t'
        continue
    i += 1
    values = [re.split(delim, line.strip())[1:] for line in lines]
    if n_examples is None:
        n_examples = [len(x) for x in values]
    else:
        assert n_examples == [len(x) for x in values]
    for x in values:
        for y in x:
            output.write(re.sub('null', '0', y))
            output.write(' ')
    output.write('\n')

print ' '.join(str(x) for x in n_examples), i
