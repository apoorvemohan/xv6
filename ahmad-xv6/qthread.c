#include "types.h"
#include "qthread.h"
#include "user.h"

#define THREADSTACKSIZE 4096

void wrapper(qthread_func_ptr_t func, void *arg) {

    func(arg);
    exit();
}

int qthread_create(qthread_t *thread,qthread_attr_t *attr, qthread_func_ptr_t my_func, void *arg) {

    //*thread = (qthread_t)malloc(sizeof(struct qthread));
    //int t_id = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE), (int)wrapper, (int)my_func, *(int*)arg);
    //(*thread)->tid = t_id;

    *thread = (qthread_t)malloc(sizeof(int));
    *thread = kthread_create((int)((char*)malloc(THREADSTACKSIZE) + THREADSTACKSIZE),attr, (int)wrapper, (int)my_func, *(int*)arg);
    return *thread;
}

int qthread_join(qthread_t thread, void **retval){

    //int val = kthread_join(thread->tid, (int)retval);
    int val = kthread_join((int)thread, (int)retval);
    return val;
}

int qthread_mutex_init(qthread_mutex_t *mutex, qthread_mutexattr_t *attr){
	*mutex = kthread_mutex_init();
	if (*mutex > 0){
		return 0;
	}
	return *mutex;
}

int qthread_mutex_destroy(qthread_mutex_t *mutex){
    int val = kthread_mutex_destroy((int)mutex);
    if (val < 0){
    	return -1;
    }
    return 0;
}

int qthread_mutex_lock(qthread_mutex_t *mutex){
    int val = kthread_mutex_lock((int)mutex);
    if (val < 0){
    	return -1;
    }
    return 0;
}

int qthread_mutex_unlock(qthread_mutex_t *mutex){
    int val = kthread_mutex_unlock((int)mutex);
    if (val < 0){
    	return -1;
    }
    return 0;
}

int qthread_cond_init(qthread_cond_t *cond, qthread_condattr_t *attr){
    *cond = kthread_cond_init();
    if (*cond > 0){
        return 0;
    }
    return *cond;
}

int qthread_cond_destroy(qthread_cond_t *cond){
    int val = kthread_cond_destroy((int)cond);
    if (val < 0){
        return -1;
    }
    return 0;
}

int qthread_cond_signal(qthread_cond_t *cond){
    int val = kthread_cond_signal((int)cond);
    if (val < 0){
        return -1;
    }
    return 0;
}

int qthread_cond_broadcast(qthread_cond_t *cond){
    int val = kthread_cond_broadcast((int)cond);
	if (val < 0){
        return -1;
    }
    return 0;
    
}

int qthread_cond_wait(qthread_cond_t *cond, qthread_mutex_t *mutex){
    int val = kthread_cond_wait((int)cond, (int)mutex);
	if (val < 0){
        return -1;
    }
    return 0;
    
}

int qthread_exit(){
	return 0;
}
