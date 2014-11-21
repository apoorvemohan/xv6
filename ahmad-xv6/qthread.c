#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <assert.h>
#include <sys/time.h>
#include <fcntl.h>
#include "qthread.h"
#include "user.h"

#define THREADSTACKSIZE 4096

void *wrapper(qthread_func_ptr_t func, void *arg) {
    func(arg);
}

int qthread_create(qthread_t *thread, qthread_func_ptr_t my_func, void *arg) {

    int SP = (int)malloc(THREADSTACKSIZE);
    int t_id = kthread_create(SP,(int)wrapper,(int)my_func,(int)arg);
    (*thread)->tid = t_id;
    return 0;
}

int qthread_join(qthread_t thread, void **retval){

    int val = kthread_join((thread->tid, retval);
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