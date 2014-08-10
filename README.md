syscall-3.9
===============

A Vagrantfile which upgrades its kernel on boot.  A new [toy] system call is added in the process.

<img src=".images/linux-compile.gif"></img>

## Usage

`` vagrant up `` Then, once it finishes compiling the kernel run `` vagrant reload `` to have access to any features added from the patches directory. 

## kernel patches applied

#### callcount.diff
This patch creates a system call (number 314) which increments an unsigned long each time it's called and copies its value to the address passed in.
   
   ``long sys_callcount(unsigned long * num);``

To try out the system call compile /vagrant/callcount_example.c:

    $ gcc /vagrant/callcount_example.c -o callcount_example
    $ ./callcount_example``
    $ You've called me 1 times.``
    $ ./callcount_example``
    $ You've called me 2 times.``
