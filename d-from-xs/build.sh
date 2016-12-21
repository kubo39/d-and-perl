#!/bin/bash
ldc2 -c -O -relocation-model=pic -ofdlangext.o dlangext.d
perl Makefile.PL
make
perl hoge.pl
