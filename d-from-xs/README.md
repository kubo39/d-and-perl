# D from XS

```
% dmd -c -fPIC -ofdhello.o hello.d
% perl Makefile.PL
% make
```

## Try it.

```
% LD_PRELOAD=$HOME/dmd2/linux/lib64/libphobos2.so perl hoge.pl
```
