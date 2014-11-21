#include "types.h"
#include "stat.h"
#include "user.h"
#include "qthread.h"


void *f1(void *arg) { 

	printf(1, "My PID: %d\n", *(int*)arg);
	return arg; 
}

void *f2(void *arg){
	printf(1,"i am thread 5\n");
	return arg;
}
void test1(void)
{
    qthread_t t[5];
    int i;
    for (i = 0; i < 4; i++){
	printf(1, "f1: %d\n", f1);
        qthread_create(&t[i], f1, (void*)&i);
    }
	printf(1,"f2: %d\n", f2);
	qthread_create(&t[4] ,f2, (void*)&i+1);

//    for (i = 0; i < 5; i++) {
//        qthread_join(t[i], (void**)&j);
//        assert(i == j);
//    }


    printf(1, "test 1 OK\n");
}


int main(void){

//ct();
//exit();

test1();
exit();

}
