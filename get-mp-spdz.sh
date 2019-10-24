#!/bin/bash

wget -O - https://github.com/data61/MP-SPDZ/releases/download/v0.1.2/mp-spdz-0.1.2.tar.xz | tar xJ
rmdir src
mv mp-spdz-0.1.2 src
cd src
Scripts/tldr.sh
