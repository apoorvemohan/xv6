#include "types.h"
#include "stat.h"
#include "user.h"
#include "qthread.h"

#define MAX_THREADS 10

//#ifndef NULL
//# warning "NULL not defined!"
//# define NULL (void*)0
//#else
//# warning "NULL defined!"
//#endif


void *f1(void *arg);
void *f2(void *v);

qthread_mutex_t m;
int mvar = 0;

#define THREADSTACKSIZE 4096

void test1(void){

	qthread_t t[MAX_THREADS];
    qthread_mutex_init(&m, NULL);

	int i,j;

    
	for(i = 0; i < MAX_THREADS; i++){
        	int tid = qthread_create(&t[i], f2, (void*)&i);
        	printf(1, "[%d : %d]\n", tid, t[i]->tid);
	}

	for (i = 0; i < MAX_THREADS; i++){
        	printf(1, "%d\n", t[i]->tid);
    	}

  	for (i = 0; i < MAX_THREADS; i++) {
        	qthread_join(t[i], (void**)&j);
		//        assert(i == j);
    	}
    
   printf("%d\n",mvar);
}


//extern void wrapper(qthread_func_ptr_t func, void *arg);

/*void test1(void)
{
    //qthread_t t[MAX_THREADS] = {0};
    struct qthread t[MAX_THREADS] = {};
    //char stacks[MAX_THREADS][THREADSTACKSIZE];
    int i, j, tid;

#ifndef TEST
    for (i = 0; i < MAX_THREADS; i++){
        //t[i] = malloc(sizeof(struct qthread));
        //tid = t[i]->tid = kthread_create((int)malloc(THREADSTACKSIZE), (int)wrapper, (int)f1, i);
        tid = t[i].tid = kthread_create((int)malloc(THREADSTACKSIZE), (int)wrapper, (int)f1, i);
	//printf(1, "[%s:%d]: tid: %d, %p: TID1: %d\n", __FUNCTION__, __LINE__, tid, t[i], t[i]->tid);
	printf(1, "[%s:%d]: tid: %d, %p: TID1: %d\n", __FUNCTION__, __LINE__, tid, t[i], t[i].tid);
    }
#endif

#ifdef ORIG
    for (i = 0; i < MAX_THREADS; i++){
	tid = qthread_create(&t[i], f1, (void*)&i);
	printf(1, "[%s:%d]: tid: %d, %p: TID1: %d\n", __FUNCTION__, __LINE__, tid, t[i], t[i]->tid);
    }
#endif

#ifdef DEBUG
    for(i=0;i<MAX_THREADS;i++) {
	printf(1, "[%s:%d]: tid: %d, %p: TID1: %d\n", __FUNCTION__, __LINE__, tid, t[i], t[i]->tid);
    }
#endif

    for (i = 0; i < MAX_THREADS; i++) {
	//printf(1,"[%s:%d]: %p: TID3: %d\n", __FUNCTION__, __LINE__, t[i], t[i]->tid);
	printf(1,"[%s:%d]: %p: TID3: %d\n", __FUNCTION__, __LINE__, t[i], t[i].tid);
        //qthread_join(t[i], (void**)&j);
        qthread_join(&t[i], (void**)&j);
//        assert(i == j);
    }

    printf(1, "test 1 OK\n");
}
*/

int main(void){

test1();
exit();

}

void *f1(void *arg) {

       // printf(1, "My PID: %d\n", getpid());
        return arg;
}

void *f2(void *v)
{
    qthread_mutex_lock(&m);
    mvar = 1;
    sleep(1);
    qthread_mutex_unlock(&m);

    return 0;
}