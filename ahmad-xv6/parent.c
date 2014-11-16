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
