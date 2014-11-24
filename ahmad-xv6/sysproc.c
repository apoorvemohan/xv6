#include "types.h"
#include "x86.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "spinlock.h"
#include "proc.h"
int
sys_fork(void)
{
  proc->ctflag = 0;
  return fork((char*)0, 0, 0, 0, 0);
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
	int thrdattr = 0;
	int wrapper = 0;
	int arg1 = 0;
	int arg2 = 0;

	argint(0, &ustack);
	argint(1, &thrdattr);
	argint(2, &wrapper);
	argint(3, &arg1);
	argint(4, &arg2);

	proc->ctflag = 1;
	return fork((char*)ustack, thrdattr, (uint)wrapper, (uint)arg1, (uint)arg2);
}

int sys_kthread_join(void){

	int tid = 0;
	argint(0, &tid);
	return wait(tid);

}

int sys_kthread_mutex_init(void){

	int i;

	for(i=0;i<NMUTX;i++){

		if(proc->mutexlist[i].lock.id == (i+1)){
			proc->mutexlist[i].lock.id = (i+1);
			initlock(&proc->mutexlist[i].lock, (char*)(i+1));
			proc->mutexlist[i].lockingthread = 0;
			return (i+1);
		}
	}	
	
	return -1;
}

int sys_kthread_mutex_destroy(void){

	int mutex;
	argint(0, &mutex);

	if((mutex <= 0) || (mutex > NMUTX) || (proc->mutexlist[mutex-1].lock.id != mutex))
		return -1;
		
	proc->mutexlist[mutex-1].lock.id = -1;
	initlock(&proc->mutexlist[mutex-1].lock, (char*)-1);
	proc->mutexlist[mutex-1].lockingthread = -1;
	return mutex;		
}

int sys_kthread_mutex_lock(void){

	int mutex = 0;
	argint(0, &mutex);

	if((proc->type) && (mutex > 0) && (mutex <= NMUTX) && (proc->parent->mutexlist[mutex-1].lock.id == mutex)){
		while(proc->parent->mutexlist[mutex-1].lock.locked);
		acquire(&proc->parent->mutexlist[mutex-1].lock);
		proc->parent->mutexlist[mutex-1].lockingthread = mutex;	
		return mutex;
	}
	
	return -1;
}

int sys_kthread_mutex_unlock(void){

	int mutex = 0;
	argint(0, &mutex);

	if((proc->type)&& (mutex > 0) && (mutex <= NMUTX) && (proc->parent->mutexlist[mutex-1].lock.id == mutex)){
		release(&proc->parent->mutexlist[mutex-1].lock);
		proc->parent->mutexlist[mutex-1].lockingthread = 0;
		return mutex;
	}

	return -1;
}


int sys_kthread_cond_init(void){

	int i, flag = -1;
	
	for(i=0;i<NCONDVAR;i++){
		if(proc->condvarlist[i].id == -1){
			 flag = (i+1);
			proc->condvarlist[i].id = (i+1);
			int j;
			for(j=0;i<MAXTHRDS;j++)
				proc->condvarlist[i].waitingthreadlist[j] = 0;
			break;
		}
	}

	return flag;
}

int sys_kthread_cond_destroy(void){

	int condvar = 0;
	
	argint(0, &condvar);

	if((condvar <= 0) || (condvar > NCONDVAR) || (proc->condvarlist[condvar-1].id != condvar))
		return -1;

	proc->condvarlist[condvar-1].id = -1;
	int j;
	for(j=0;j<MAXTHRDS;j++)
		proc->condvarlist[condvar-1].waitingthreadlist[j] = -1;	

	return 0;	
}

int sys_kthread_cond_wait(void){

	int mutex = 0 , condvar = 0; 

	argint(0, &condvar);
	argint(1, &mutex);

	if((condvar > 0) && (condvar <= NMUTX) && (mutex > 0) && (condvar <= NCONDVAR)){
		int i;
		for(i=0;i<MAXTHRDS;i++){
			if(proc->parent->condvarlist[condvar-1].waitingthreadlist[i] == -1){
				proc->parent->condvarlist[condvar-1].waitingthreadlist[i] = proc->pid;
				sleep((void*)proc->pid, &proc->parent->mutexlist[mutex-1].lock);
				return 0;
			}
		}
	}

	return -1;
}

int sys_kthread_cond_signal(void){

	int i, condvar = 0;

	argint(0, &condvar);

	if((condvar < 1) || (condvar > NCONDVAR))
		return -1;

	for(i=0;i<MAXTHRDS;i++){
		if(proc->parent->condvarlist[condvar-1].waitingthreadlist[i] != -1){
			proc->parent->condvarlist[condvar-1].waitingthreadlist[i] = -1;
			wakeup((void*)proc->parent->condvarlist[condvar-1].waitingthreadlist[i]);
			break;
		}
	}

	return 0;
}

int sys_kthread_cond_broadcast(void){

	int i, condvar = 0;
	
	argint(0, &condvar);
	
	if((condvar < 1) || (condvar > NCONDVAR))
             return -1;

	for(i=0;i<MAXTHRDS;i++){
               	if(proc->parent->condvarlist[condvar-1].waitingthreadlist[i] != -1){
                       	proc->parent->condvarlist[condvar-1].waitingthreadlist[i] = -1;
                       	wakeup((void*)proc->parent->condvarlist[condvar-1].waitingthreadlist[i]);
               	}
        }
		

	return 0;
}

int sys_kthread_exit(void){
	return 0;
}
