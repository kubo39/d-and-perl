extern(C):
nothrow:
@nogc:
@system:

pragma(LDC_no_moduleinfo);

int addOne(int x)
{
  return x + 1;
}
