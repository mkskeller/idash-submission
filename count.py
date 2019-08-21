#!/usr/bin/python

import glob, re

for filename in glob.glob('src/logs/idash_predict*'):
    for line in open(filename):
        m = re.match('predictions: (.*)', line)
        if m:
            print filename, sum(int(x) for x in m.group(1))

