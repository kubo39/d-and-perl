extern(C):
nothrow:
@nogc:
@system:

pragma(LDC_no_moduleinfo);

int fibonacci(int n) pure
{
    return n < 2 ? n : fibonacci(n-1) + fibonacci(n-2);
}
