#ifndef T2T_SIMPLE_H
#define T2T_SIMPLE_H

void t2t_simple_note(const char *, const char *, int, const char *, const char *);
void t2t_simple_diag(const char *, const char *, int, const char *, const char *);
int t2t_simple_pass(const char *, const char *, int, const char *, const char *);
int t2t_simple_fail(const char *, const char *, int, const char *, const char *);

#define note(message) t2t_simple_note("c", __FILE__, __LINE__, __func__, message)
#define diag(message) t2t_simple_diag("c", __FILE__, __LINE__, __func__, message)
#define pass(message) t2t_simple_pass("c", __FILE__, __LINE__, __func__, message)
#define fail(message) t2t_simple_fail("c", __FILE__, __LINE__, __func__, message)
#define ok(expression, message) expression ? t2t_simple_pass("c", __FILE__, __LINE__, __func__, message) : t2t_simple_fail("c", __FILE__, __LINE__, __func__, message)

#endif
