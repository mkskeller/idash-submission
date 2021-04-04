#!/usr/bin/python

import glob, re
import sys

if len(sys.argv) > 1:
    filenames = sys.argv[1:]
else:
    filenames = glob.glob('src/logs/idash_predict*')

for filename in filenames:
    for line in open(filename):
        m = re.match('predictions: (.*)', line)
        if m:
            print filename, sum(int(x) for x in m.group(1))

