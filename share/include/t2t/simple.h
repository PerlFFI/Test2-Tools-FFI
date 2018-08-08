#ifndef T2T_SIMPLE_H
#define T2T_SIMPLE_H

void t2t_simple_set_location(const char *, const char *, int, const char *);
void t2t_simple_clear_location();
void t2t_simple_note(const char *);
void t2t_simple_diag(const char *);
void t2t_simple_pass(const char *);
void t2t_simple_fail(const char *);

#define note(message) { t2t_simple_set_location("c", __FILE__, __LINE__, __func__); \
                        t2t_simple_note(message); \
                        t2t_simple_clear_location(); }
#define diag(message) { t2t_simple_set_location("c", __FILE__, __LINE__, __func__); \
                        t2t_simple_diag(message); \
                        t2t_simple_clear_location(); }
#define pass(name)    { t2t_simple_set_location("c", __FILE__, __LINE__, __func__); \
                        t2t_simple_pass(name); \
                        t2t_simple_clear_location(); }
#define fail(name)    { t2t_simple_set_location("c", __FILE__, __LINE__, __func__); \
                        t2t_simple_fail(name); \
                        t2t_simple_clear_location(); }

#endif
