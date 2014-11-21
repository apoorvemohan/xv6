#include "types.h"
#include "stat.h"
#include "user.h"
#include "qthread.h"


void *f1(void *arg) { return arg; }
void test1(void)
{
    qthread_t t[10];
    int i, j;
    for (i = 0; i < 10; i++)
        qthread_create(&t[i], f1, (void*)i);
    for (i = 0; i < 10; i++) {
        qthread_join(t[i], (void**)&j);
//        assert(i == j);
    }
    printf(1, "test 1 OK\n");
}


int main(void){

//ct();
//exit();

test1();
exit();

}
