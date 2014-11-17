#include "types.h"
#include "stat.h"
#include "user.h"

void parent(void) {

	int retval;

        if((retval = fork()) < 0){
                printf(1, "FORK FAILED!!!");
        }else if(retval > 0){
                printf(1, "Me: %d MyChild: %d\n", getpid(), retval);
                wait();
        } else {
                printf(1, "Me: %d MyParent: %d\n", getpid(), getppid());
        }

}

void hello(){
	
	printf(1, "Hello World!!!\n");

}

void ct(void){

	int retval = createThread();

	if(retval == 0){
	
		hello();	
		printf(1, "In Child\n");
		sleep(200);
		exit();

	} else if(retval > 0) {

		printf(1, "In Parent!!!\n");
		printf(1, "My Child: %d\n", retval);
		wait();
		printf(1, "All my children finished their execution\n");
	}

}

/*int main(void){

	int retval;

	if((retval = fork()) < 0){
		printf(1, "FORK FAILED!!!");
	}else if(retval > 0){
		printf(1, "Me: %d MyChild: %d\n", getpid(), retval);
		wait();
	} else {
		printf(1, "Me: %d MyParent: %d\n", getpid(), getppid());
	}

	exit();
}*/
