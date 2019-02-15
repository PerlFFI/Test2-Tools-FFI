#include <t2t/simple.h>
#undef diag
#undef note
#undef pass
#undef fail

typedef void (*message_cb)(const char *, const char *, const char *, int, const char *);

struct {
  message_cb note;
  message_cb diag;
  message_cb pass;
  message_cb fail;
} cb;

void
t2t_simple_note(const char *language, const char *filename, int linenumber, const char *function, const char *message)
{
  cb.note(message, language, filename, linenumber, function);
}

void
t2t_simple_diag(const char *language, const char *filename, int linenumber, const char *function, const char *message)
{
  cb.diag(message, language, filename, linenumber, function);
}

int
t2t_simple_pass(const char *language, const char *filename, int linenumber, const char *function, const char *name)
{
  cb.pass(name, language, filename, linenumber, function);
  return 1;
}

int
t2t_simple_fail(const char *language, const char *filename, int linenumber, const char *function, const char *name)
{
  cb.fail(name, language, filename, linenumber, function);
  return 0;
}

void
t2t_simple_init(message_cb note, message_cb diag, message_cb pass, message_cb fail)
{
  cb.note = note;
  cb.diag = diag;
  cb.pass = pass;
  cb.fail = fail;
}
