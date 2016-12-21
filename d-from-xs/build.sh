#!/bin/bash
ldc2 -c -O -relocation-model=pic -ofdhello.o hello.d
perl Makefile.PL
make
perl hoge.pl
