#ifndef T2T_SIMPLE_H
#define T2T_SIMPLE_H

void t2t_note(const char *message);
void t2t_diag(const char *message);
void t2t_set_location(const char *language, const char *filename, int linenumber, const char *function);
void t2t_clear_location();

#define note(message) { t2t_set_location("c", __FILE__, __LINE__, __func__); \
                        t2t_note(message); \
                        t2t_clear_location(); }
#define diag(message) { t2t_set_location("c", __FILE__, __LINE__, __func__); \
                        t2t_diag(message); \
                        t2t_clear_location(); }

#endif
