#!/bin/bash
dmd -c -O -betterC -fPIC -ofdlangext.o dlangext.d
perl Makefile.PL
make
perl hoge.pl
