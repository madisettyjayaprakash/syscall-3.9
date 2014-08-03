syscall-3.9
===============

Vagrantfile - A ubuntu 14.04 vagrant machine which will spin up, compile a kernel with the patch in this directory, replace it's own kernel with the new custom one, and reboot.

provision.sh - The provisioning script that vagrant will use to perform the actions listed above.

syscall-3.9.diff - Our kernel patch

src/ - A directory with the source files for our system call.
