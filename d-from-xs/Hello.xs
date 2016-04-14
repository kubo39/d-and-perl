#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "hello.h"

MODULE = Hello          PACKAGE = Hello

void
d_fibonacci(...)
  PPCODE:
{
  SV* item = ST(0);
  IV input = SvIV(item);
  int ret = fibonacci(input);
  XPUSHs(sv_2mortal(newSViv(ret)));
  XSRETURN(1);
}
