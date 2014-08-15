#include <linux/linkage.h>
#include <asm/uaccess.h>
static unsigned long count = 0;
asmlinkage long sys_callcount(unsigned long * num)
{
    count++;
    if (copy_to_user(num, &count, sizeof(count)))
        return -EFAULT;
    return 1;
}
