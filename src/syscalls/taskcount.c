#include <linux/linkage.h>
#include <linux/kernel.h>
#include <linux/sched.h>
#include <asm/uaccess.h>

asmlinkage long sys_taskcount(unsigned long * num)
{
   unsigned long count = 0;
   struct task_struct * task;
   for_each_process(task) {
       printk("counting task: %s %d\n", task->comm, task->pid);
        count++; 
   }
   if (copy_to_user(num, &count, sizeof(count)))
       return -EFAULT;
   return 1;
}
