#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

MODULE = Hello          PACKAGE = Hello

void
xs_fibonacci(...)
  PPCODE:
{
  SV* item = ST(0);
  IV input = SvIV(item);
  int ret = fibonacci(input);
  XPUSHs(sv_2mortal(newSViv(ret)));
  XSRETURN(1);
}
