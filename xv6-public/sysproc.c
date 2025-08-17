#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  return fork();
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
  return wait();
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
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
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
    if(myproc()->killed){
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

//Task 2a
int sys_worldpeace(void){
  cprintf("Systems are vital to world peace !!");
  return 0;
}

//Task 2b
int sys_numberofprocesses(void){
  return numprocess();
}


//Task 2c
int sys_spawn(void){
  
  int n;
  int k=0;
  int *pids;

  argint(0, &n);
  argptr(1, (void*)&pids, n*sizeof(pids[0]));

  for(int i=0; i<n; i++){
    pids[i] = fork();
    if(pids[i]==0){
      return 0;
    }
    if(pids[i] >0){
      k++;  
    }

  }
  return k;
}

//Task 3a
int sys_getvasize(void){
  int id;
  // uint sz;
  argint(0, &id);
  return vasize(id);
  
}

//Task 3b
int sys_va_to_pa(void){
  int loc;
  argint(0, &loc);
  pde_t *pde;
  pte_t *pgtab;

  struct proc *curproc = myproc();
  pde = &curproc->pgdir[PDX(loc)];
  pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  
  pte_t pte = pgtab[PTX(loc)];
  loc = (loc & 0xFFF);
  return (loc+PTE_ADDR(pte));

}

//Task 3c
int sys_get_pgtb_size(void){
  struct proc *curproc = myproc();
  // pde_t *pde = &curproc->pgdir[PDX()];
  // pde_t *pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  int count = 0;
  pde_t *pid;
  for(int i=0; i<1024; i++){
    pid = &curproc->pgdir[i];
    if(*pid & PTE_P){
      count++;
    }
  }

  return count;

}

int sys_get_usr_pgtb_size(void){
  struct proc *curproc = myproc();
  int count = 0;
  pde_t *pid;
  for(int i=0; i<1024; i++){
    pid = &curproc->pgdir[i];
    if(*pid & PTE_P){
      if(i<(KERNBASE>>22))
        count++;
    }
  }

  return count;

}

int sys_get_kernel_pgtb_size(void){
  struct proc *curproc = myproc();
  int count = 0;
  pde_t *pid;
  for(int i=0; i<1024; i++){
    pid = &curproc->pgdir[i];
    if(*pid & PTE_P){
      if(i>=(KERNBASE>>22))
        count++;
    }
  }

  return count;

}

//Task 3d
int sys_getpasize(void){
  int pid;
  argint(0, &pid);
  return pasize(pid);
}

//Task 4b
int sys_mmap(void){
  int inc;
  // char *mem;
  struct proc *curproc = myproc();
  argint(0, &inc);
  if((uint) inc % PGSIZE != 0){
      panic("loaduvm: addr must be page aligned");
      exit();
  }
  int addr = curproc->sz;
  curproc->sz = addr+inc;
  return addr;

}