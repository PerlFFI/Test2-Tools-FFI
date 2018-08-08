#include <t2t/simple.h>
#undef diag
#undef note
#undef pass
#undef fail

typedef void (*message_cb)(const char *);
typedef void (*set_location_cb)(const char *, const char *, int, const char *);
typedef void (*void_cb)(void);

struct {
  message_cb note;
  message_cb diag;
  set_location_cb set_location;
  void_cb clear_location;
  message_cb pass;
  message_cb fail;
} cb;

void
t2t_simple_note(const char *message)
{
  cb.note(message);
}

void
t2t_simple_diag(const char *message)
{
  cb.diag(message);
}

void
t2t_simple_pass(const char *name)
{
  cb.pass(name);
}

void
t2t_simple_fail(const char *name)
{
  cb.fail(name);
}

void
t2t_simple_set_location(const char *language, const char *filename, int linenumber, const char *function)
{
  cb.set_location(language, filename, linenumber, function);
}

void
t2t_simple_clear_location()
{
  cb.clear_location();
}

void
t2t_simple_init(message_cb note, message_cb diag, set_location_cb set_location, void_cb clear_location, message_cb pass, message_cb fail)
{
  cb.note = note;
  cb.diag = diag;
  cb.set_location = set_location;
  cb.clear_location = clear_location;
  cb.pass = pass;
  cb.fail = fail;
}
