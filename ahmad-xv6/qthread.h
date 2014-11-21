#ifndef __QTHREAD_H__
#define __QTHREAD_H__

#include <sys/types.h>

struct qthread;
struct qthread_mutex;
struct qthread_cond;
struct qthreadList;

/* function pointer w/ signature 'void *f(void*)'
 */
typedef void *(*qthread_func_ptr_t)(void*);  

typedef struct qthread *qthread_t;
typedef struct qthread_mutex qthread_mutex_t;
typedef struct qthread_cond qthread_cond_t;

int  qthread_create(qthread_t *thread, qthread_func_ptr_t start, void *arg);
int  qthread_join(qthread_t thread, void **retval);
int qthread_exit(void *val);

int qthread_mutex_init(qthread_mutex_t *mutex);
int qthread_mutex_destroy(qthread_mutex_t *mutex);
int qthread_mutex_lock(qthread_mutex_t *mutex);
int qthread_mutex_unlock(qthread_mutex_t *mutex);

int qthread_cond_init(qthread_cond_t *cond);
int qthread_cond_destroy(qthread_cond_t *cond);
int qthread_cond_wait(qthread_cond_t *cond, qthread_mutex_t *mutex);
int qthread_cond_signal(qthread_cond_t *cond);
int qthread_cond_broadcast(qthread_cond_t *cond);



struct qthread {
    int tid;
};

struct qthread_mutex {
        short state;
};

struct qthread_cond {
    struct qthreadList *waitingList;
};


struct qthreadList {
    qthread_t thread;
    struct qthreadList *next;
};

#endif /* __QTHREAD_H__ */