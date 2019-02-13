#ifndef T2T_SIMPLE_H
#define T2T_SIMPLE_H

void t2t_simple_note(const char *, const char *, const char *, int, const char *);
void t2t_simple_diag(const char *, const char *, const char *, int, const char *);
int t2t_simple_pass(const char *, const char *, const char *, int, const char *);
int t2t_simple_fail(const char *, const char *, const char *, int, const char *);

#define note(message) t2t_simple_note(message, "c", __FILE__, __LINE__, __func__)
#define diag(message) t2t_simple_diag(message, "c", __FILE__, __LINE__, __func__)
#define pass(message) t2t_simple_pass(message, "c", __FILE__, __LINE__, __func__)
#define fail(message) t2t_simple_fail(message, "c", __FILE__, __LINE__, __func__)
#define ok(expression, message) expression ? t2t_simple_pass(message, "c", __FILE__, __LINE__, __func__) : t2t_simple_fail(message, "c", __FILE__, __LINE__, __func__)

#endif
