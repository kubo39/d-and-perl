# D言語と  XS

- DMD

```console
dmd -c -O -betterC -fPIC -ofdlangext.o dlangext.d
perl Makefile.PL
make
perl hoge.pl
```

- LDC

```console
$ ldc2 -c -O -relocation-model=pic -ofdhello.o hello.d
$ perl Makefile.PL
$ make
$ perl hoge.pl
```
