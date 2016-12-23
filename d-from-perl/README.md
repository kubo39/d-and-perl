# D言語 と FFI::Raw

- DMD

```console
$ dmd -shared -betterC -fPIC -oflibsharedobj.so sharedobj.d
$ perl sharedobj.pl
```

- LDC

```
$ ldc2 -shared -relocation-model=pic sharedobj.d
$ perl sharedobj.pl
```
