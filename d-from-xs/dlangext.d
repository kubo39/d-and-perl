extern(C):
nothrow:
@nogc:
@system:

version(DigitalMars)
{
    __gshared void _d_dso_registry() {}
    __gshared void* __dmd_personality_v0;
}
version(LDC)
pragma(LDC_no_moduleinfo);

int fibonacci(int n) pure
{
    return n < 2 ? n : fibonacci(n-1) + fibonacci(n-2);
}
