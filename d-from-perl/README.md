```
$ dmd -shared -fPIC sharedobj.d
$ LD_LIBRARY_PATH=./ perl sharedobj.pl
```
