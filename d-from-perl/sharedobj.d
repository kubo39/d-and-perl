extern(C):
nothrow:
@nogc:
@system:

version(LDC)
pragma(LDC_no_moduleinfo);

int addOne(int x)
{
  return x + 1;
}
