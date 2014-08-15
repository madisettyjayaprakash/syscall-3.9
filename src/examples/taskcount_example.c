#include <stdio.h>

unsigned long task_count;
int main() {
    syscall(315, &task_count);
    printf("The system has %lu processes.\n", task_count); 
    return 0;
}
