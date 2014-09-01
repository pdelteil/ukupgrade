#!/bin/sh

# "kernupgrade": *buntu kernel upgrade script
# In order to start upgrade proccess give the file executable permission with the following command;
# chmod +x ./kernupgrade
# 
# In order to touch
# Mustafa Hasturk
# @mail hello@mustafahasturk.com
# @link http://github.com/muhasturk

new_kernel_version='3.16.1'
new_kernel_release='3.16.1-031601-generic'

common_headers="http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.16.1-utopic/linux-headers-3.16.1-031601_3.16.1-031601.201408140014_all.deb"
linux_headers_i386="http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.16.1-utopic/linux-headers-3.16.1-031601-generic_3.16.1-031601.201408140014_i386.deb"
linux_image_i386="http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.16.1-utopic/linux-image-3.16.1-031601-generic_3.16.1-031601.201408140014_i386.deb"
linux_headers_amd64="http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.16.1-utopic/linux-headers-3.16.1-031601-generic_3.16.1-031601.201408140014_amd64.deb"
linux_image_amd64="http://kernel.ubuntu.com/~kernel-ppa/mainline/v3.16.1-utopic/linux-image-3.16.1-031601-generic_3.16.1-031601.201408140014_amd64.deb"

old_kernel_release=`uname -a`  #check twice!
kernel_directory="/tmp/new_kernel.d"

lsb_infos="
`lsb_release -i`
`lsb_release -d`
`lsb_release -r`
`lsb_release -c`
"
architecture=`uname -i`

echo "provide us root privilege when asked"
echo "Checking new kernel available..."
sleep 0.5


if [ ${old_kernel_release} = ${new_kernel_release} ]; then

echo "$old_kernel_release is already latest version.\nExit..."
exit
fi

en_US_string="$(tput setaf 3)* Kernel $new_kernel_version will be installed following system
$lsb_infos
Architecture: $architecture
oldKernel: $old_kernel_release 
$(tput sgr0)"

#tr_TR_string="Will be upgrade"
#if [ $sys_language = en_US ]; then
#echo "$en_US_string"
#else
#echo "tr_TR_string"
#fi

echo "$en_US_string"
sleep 0.5

read -p "Press Enter to continue, or abort by pressing CTRL+C" nothing

if  [ ${architecture} = 'i686' ] || [ ${architecture} = 'i386' ]; then
echo "i386 process started"
sleep 0.5
mkdir -p ${kernel_directory}
echo "kernel_directory created"
cd ${kernel_directory}

wget -c ${common_headers}
wget -c ${linux_headers_i386}
wget -c ${linux_image_i386}
sudo dpkg -i *.deb

echo ".deb packages have been installed"t

elif [ ${architecture} = "x86_64" ]; then
echo "amd64 process started"
mkdir -p ${kernel_directory}
echo "removed new_kernel.d directory and kernel images"
cd ${kernel_directory}

wget -c ${common_headers}
wget -c ${linux_headers_amd64}
wget -c ${linux_image_amd64}
sudo dpkg -i *.deb
echo ".deb packages have been installed"

else
	echo "Unsupported architecture"
fi

echo "Kernel $new_kernel_version has been installed successfully.
We have to restart system"
sudo reboot