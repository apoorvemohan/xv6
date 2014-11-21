#include "types.h"
#include "qthread.h"
#include "user.h"

#define THREADSTACKSIZE 4096

void wrapper(qthread_func_ptr_t func, void *arg) {

    func(arg);
    exit();
}

int qthread_create(qthread_t *thread, qthread_func_ptr_t my_func, void *arg) {

#ifdef DEBUG2
    void *p = malloc(sizeof(struct qthread));
    *thread = (qthread_t)p;
#else
    *thread = (qthread_t)malloc(sizeof(struct qthread));
#endif
    int t_id = kthread_create((int)malloc(THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
    (*thread)->tid = t_id;
#ifdef DEBUG2
    printf(1, "[%s:%d]: p: %p, TID: %p\n", __FUNCTION__, __LINE__,  p, (*thread), (*thread)->tid);
#else
    //printf(1, "[%s:%d]: %p: TID: %d\n", __FUNCTION__, __LINE__, (*thread), (*thread)->tid);
#endif
    return t_id;
}

int qthread_join(qthread_t thread, void **retval){

    int val = kthread_join(thread->tid, (int)retval);
    return val;
}


/*
int qthread_mutex_init(qthread_mutex_t *mutex){

}

int qthread_mutex_destroy(qthread_mutex_t *mutex){
    
}

int qthread_mutex_lock(qthread_mutex_t *mutex){
    
}

int qthread_mutex_unlock(qthread_mutex_t *mutex){
    
}

int qthread_cond_init(qthread_cond_t *cond){

}

int qthread_cond_destroy(qthread_cond_t *cond){
    
}

int qthread_cond_signal(qthread_cond_t *cond){
    
}

int qthread_cond_broadcast(qthread_cond_t *cond){
    
}

int qthread_cond_wait(qthread_cond_t *cond, qthread_mutex_t *mutex){
    
}

int qthread_exit(){

}
*/
