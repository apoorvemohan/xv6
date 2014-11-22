#include "types.h"
#include "x86.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  proc->ctflag = 0;
  return fork((char*)0, 0, 0, 0);
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait(0);
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return proc->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = proc->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;
  
  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

int sys_getppid(void) {

	if(proc->parent == 0)
		return 0;
	return proc->parent->pid;
}

int sys_kthread_create(void){

	int ustack = 0;
	int wrapper = 0;
	int arg1 = 0;
	int arg2 = 0;

	argint(0, &ustack);
	argint(1, &wrapper);
	argint(2, &arg1);
	argint(3, &arg2);

	proc->ctflag = 1;
	return fork((char*)ustack, (uint)wrapper, (uint)arg1, (uint)arg2);
}

int sys_kthread_join(void){

	int tid = 0;
	argint(0, &tid);
	return wait(tid);

}

int sys_kthread_init(void){

	int i,  flag = -1;

	for(i=0;i<NMUTX;i++){

		if(proc->mutexlist[i].id != -1){

			proc->mutexlist[i].id = (i+1);
			proc->mutexlist[i].state = 0;
			proc->mutexlist[i].lockingthread = 0;
			flag = proc->mutexlist[i].id;
			break;
		}
	}	
	
	return flag;
}

int sys_kthread_destroy(void){

	int mutex;
	argint(0, &mutex);

	if(proc->mutexlist[mutex-1].id != mutex)
		return -1;
		
	proc->mutexlist[mutex-1].id = -1;
	proc->mutexlist[mutex-1].state = -1;
	proc->mutexlist[mutex-1].lockingthread = -1;
	return 0;		
}

int sys_kthread_lock(void){

	int mutex = 0;
	argint(0, &mutex);

	if((mutex > 0) && (proc->mutexlist[mutex-1].id == mutex)){
		while(proc->mutexlist[mutex-1].state);
		proc->mutexlist[mutex-1].state = 1;
		proc->mutexlist[mutex-1].lockingthread = mutex;	
		return mutex;
	}
	
	return -1;
}

int sys_kthread_unlock(void){

	int mutex = 0;
	argint(0, &mutex);

	if((mutex > 0) && (proc->mutexlist[mutex-1].id == mutex)){
		proc->mutexlist[mutex-1].state = 0;
		proc->mutexlist[mutex-1].lockingthread = 0;
		return mutex;
	}

	return -1;
}

