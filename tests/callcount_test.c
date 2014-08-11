unsigned long i = 0;
unsigned long j = 0;
int main() {
    // ensures that syscall 314 is incrementing
    syscall(314, &i);	
    j = i;
    syscall(314, &i);	
    if (i = j + 1) {
        return 0;
    }
    return 1;
}
