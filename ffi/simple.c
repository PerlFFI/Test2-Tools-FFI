#include <stdlib.h>
#include <stdio.h>
#include <t2t/simple.h>
#undef diag
#undef note
#undef pass
#undef fail

struct {
  t2t_simple_message_cb note;
  t2t_simple_message_cb diag;
  t2t_simple_message_cb pass;
  t2t_simple_message_cb fail;
} cb;

#define do_abort() {                          \
  fprintf(stderr, "t2t is not initalized\n"); \
  abort();                                    \
}

void
t2t_simple_note(const char *language, const char *filename, int linenumber, const char *function, const char *message)
{
  if(cb.note)
    cb.note(message, language, filename, linenumber, function);
  else
    do_abort();
}

void
t2t_simple_diag(const char *language, const char *filename, int linenumber, const char *function, const char *message)
{
  if(cb.diag)
    cb.diag(message, language, filename, linenumber, function);
  else
    do_abort();
}

int
t2t_simple_pass(const char *language, const char *filename, int linenumber, const char *function, const char *name)
{
  if(cb.pass)
  {
    cb.pass(name, language, filename, linenumber, function);
    return 1;
  }
  else
    do_abort();
}

int
t2t_simple_fail(const char *language, const char *filename, int linenumber, const char *function, const char *name)
{
  if(cb.fail)
  {
    cb.fail(name, language, filename, linenumber, function);
    return 0;
  }
  else
    do_abort();
}

void
t2t_simple_init(t2t_simple_message_cb note, t2t_simple_message_cb diag, t2t_simple_message_cb pass, t2t_simple_message_cb fail)
{
  cb.note = note;
  cb.diag = diag;
  cb.pass = pass;
  cb.fail = fail;
}

void
t2t_simple_deinit()
{
  cb.note = cb.diag = cb.pass = cb.fail = NULL;
}
