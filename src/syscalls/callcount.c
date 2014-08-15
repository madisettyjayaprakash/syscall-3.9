#include <linux/linkage.h>
static unsigned long count = 0;
asmlinkage long sys_callcount(unsigned long * num)
{
    count++;
    *num = count;
    return 1;
}
