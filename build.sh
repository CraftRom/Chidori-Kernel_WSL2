#!/bin/bash

#Set Color
blue='\033[0;34m'
grn='\033[0;32m'
yellow='\033[0;33m'
red='\033[0;31m'
nocol='\033[0m'
txtbld=$(tput bold)
txtrst=$(tput sgr0)  

echo -e " "
echo -e " "
echo -e "$blue░▐█▀█░▐█░▐█░▐██░▐█▀█▄▒▐█▀▀█▌▒▐█▀▀▄░▐██"
echo -e "░▐█──░▐████─░█▌░▐█▌▐█▒▐█▄▒█▌▒▐█▒▐█─░█▌"
echo -e "░▐█▄█░▐█░▐█░▐██░▐█▄█▀▒▐██▄█▌▒▐█▀▄▄░▐██$nocol"
echo -e " "

cd $(dirname $0)
KERN_VER=$(echo "$(make kernelversion)")

export KBUILD_BUILD_USER=melles1991
export KBUILD_BUILD_HOST=CraftRom-build
export KCONFIG_CONFIG=Microsoft/config-chidori
export ARCH=x86_64
export SUBARCH=x86_64
export KBUILD_CFLAGS="-Wno-maybe-uninitialized -Wno-memset-elt-size -Wno-duplicate-decl-specifier"

echo -e "${txtbld}Config:${txtrst} $KCONFIG_CONFIG"
echo -e "${txtbld}ARCH:${txtrst} $ARCH"
echo -e "${txtbld}Linux:${txtrst} $KERN_VER"
echo -e "${txtbld}Username:${txtrst} $KBUILD_BUILD_USER"
echo -e " "

echo -e "$blue    \nStarting kernel compilation...\n $nocol"
mkdir -p out

nice make -j$(nproc --all) O=out | tee build.log
echo -e "$grn \n(i)          Completed build$nocol $red$((SECONDS / 60))$nocol $grn minute(s) and$nocol $red$((SECONDS % 60))$nocol $grn second(s) !$nocol"
echo -e "$blue    \n             Install kernel.\n $nocol"
cp -rf out/arch/x86/boot/bzImage /mnt/c/wsl_kernel
