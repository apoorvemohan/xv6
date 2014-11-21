#include "types.h"
#include "stat.h"
#include "user.h"
#include "qthread.h"

int main(void){

//ct();
//exit();

void *f1(void *arg) { return arg; }
void test1(void)
{
    qthread_t t[10];
    int i, j;
    for (i = 0; i < 10; i++)
        qthread_create(&t[i], NULL, f1, (void*)i);
    for (i = 0; i < 10; i++) {
        qthread_join(t[i], (void**)&j);
        assert(i == j);
    }
    printf("test 1 OK\n");
}

test1();
exit();

}
