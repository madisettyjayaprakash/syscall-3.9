#!/usr/bin/env bash

##
# This script will download a kernel, apply patches, then compile it using 
# the same settings as your current kernel, and add it to grub2, grub, or burg 
# if possible.
##

set -e

KERNEL_VERSION=3.9.11
KERNEL_SRC_DIR=/usr/local/src

# ALl of the patches in this directory will be applied prior to compilation
KERNEL_PATCH_DIR=/vagrant/patches-$KERNEL_VERSION

mkdir -p $KERNEL_SRC_DIR
cd $KERNEL_SRC_DIR

if [ ! -e linux-$KERNEL_VERSION ]; then
    wget -nc https://www.kernel.org/pub/linux/kernel/v3.x/linux-$KERNEL_VERSION.tar.gz
    tar xvzf linux-$KERNEL_VERSION.tar.gz
fi

if [ -e linux-$KERNEL_VERSION ]; then
    echo "kernel source is in $KERNEL_SRC_DIR/linux-$KERNEL_VERSION, starting build process..."
    cd linux-$KERNEL_VERSION

    # Apply patches
    for file in $KERNEL_PATCH_DIR/*
    do
        if [ -e $file ]; then patch -p1 <$file; fi
    done
    
    if [ -e /vagrant/.config ]; then
        # copy over a pre-exising config file, vagrant provisioning fails
        # without this since it can't handle interactive prompts
        cp /vagrant/.config .
    else
        # use our existing config, this may not be the most optimal thing
        # editing here is recommended
        cp /boot/config-`uname -r` .config
        # make oldconfig will prompt us for any options not set in our
        # existing config file
        make oldconfig
        make localmodconfig
    fi

    # j<num_of_processors + 1>
    make -j2
    # Now that the kernel is built we can take advantage of existing
    # helper scripts to handle installing drivers, settings up ramdisk,
    # and adding the image to /boot
    make modules_install
    make install
    
    # Make boot loader aware of the new version so it shows in the boot menu
    update-grub2 || update-grub || update-burg
    echo "Kernel $KERNEL_VERSION has been installed.  Reboot the system to try it out."
    exit 0
else
    echo "failed to fetch kernel source"
    exit 1
fi
