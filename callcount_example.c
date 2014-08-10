#include <stdio.h>

unsigned long i = 0;
int main() {
    syscall(314, &i);	
	printf("You've called me %lu times.\n", i);
	return 0;
}
