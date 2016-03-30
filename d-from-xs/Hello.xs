#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "hello.h"

MODULE = Hello          PACKAGE = Hello

void hello(...)
  PPCODE:
{
  char* str;
  str = hello_from_d();
  PerlIO_printf(PerlIO_stdout(), str);
  XSRETURN(0);
};


void createCounterFromXS(...)
  PPCODE:
{
  createCounter();
  XSRETURN(0);
}


void incrementFromXS(...)
  PPCODE:
{
  increment();
  XSRETURN(0);
}


SV* getCountFromXS(...)
  CODE:
    int ret = getCount();
    RETVAL = newSVuv(ret);
  OUTPUT:
    RETVAL

void initializeD(...)
  PPCODE:
{
  rt_init();
  XSRETURN(0);
};


void finalizeD(...)
  PPCODE:
{
  rt_term();
  XSRETURN(0);
};
