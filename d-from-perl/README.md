```
$ dmd -c -fPIC sharedobj.d
$ gcc sharedobj.o -shared -o sharedobj.so -m64 -Xlinker --export-dynamic -Xlinker -lphobos2 -Xlinker -Bdynamic -lpthread -lm -lrt -ldl
$ LD_PRELOAD=/home/kubo39/dev/dlang/d-and-perl/d-from-perl/sharedobj.so perl sharedobj.pl
```
