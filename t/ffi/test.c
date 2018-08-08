#include <t2t/simple.h>

int
myanswer()
{
  return 42;
}

void
test_diagnostics()
{
  note("this is debug information, may not be critical");
  /* this line is bad luck */
  diag("this is IMPORTANT, make sure we see it");
}
