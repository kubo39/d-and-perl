dmd -c -fPIC -ofdhello.o hello.d
perl Makefile.PL
make
LD_PRELOAD=$HOME/dlang/dmd-2.070.2/linux/lib64/libphobos2.so perl hoge.pl
