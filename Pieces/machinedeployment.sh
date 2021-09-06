#!/bin/bash

vmname="elk01"
domainname="teststack.com"
fullhostname=$(echo $vmname "." $domainname | tr -d ' ')

read -p "Confirm hostname of machine to be deployed: $fullhostname -- Y/N?" -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
	then
		echo "Please make the required changes and run the script again"
		exit
fi

#get ISO
if [ ! -f ./debian.iso ]; then
    wget https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.0.0-amd64-netinst.iso -O debian.iso
fi

#Create VM
VBoxManage createvm --name $vmname --ostype Debian_64 --register --basefolder `pwd`

#Set CPU count, memory and network
VBoxManage modifyvm $vmname --cpus 2
VBoxManage modifyvm $vmname --ioapic on
VBoxManage modifyvm $vmname --memory 2048 --vram 128
VBoxManage modifyvm $vmname --nic1 bridged

#Create storage and boot order
VBoxManage createhd --filename `pwd`/$vmname/$vmname_disk.vdi --size 80000 --format VDI
VBoxManage storagectl $vmname --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach $vmname --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium  `pwd`/$vmname/$vmname_disk.vdi
VBoxManage storagectl $vmname --name "IDE Controller" --add ide --controller PIIX4
VBoxManage storageattach $vmname --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium `pwd`/debian.iso 
VBoxManage modifyvm $vmname --boot1 dvd --boot2 disk --boot3 none --boot4 none

#Enable RDP
VBoxManage modifyvm $vmname --vrde on
VBoxManage modifyvm $vmname --vrdemulticon on --vrdeport 10001

#Unattended install prep
VBoxManage unattended install $vmname --iso=./debian.iso --hostname $fullhostname  --script-template /usr/lib/virtualbox/UnattendedTemplates/debian_preseed.cfg --post-install-template /usr/lib/virtualbox/UnattendedTemplates/debian_postinstall.sh

read -p "Check isolinux-txt.cfg and make changes before continuing (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
	then
		echo "Once changes to isolinux have been made start VM Manually (VBoxHeadless --startvm <vmname>"
		exit
fi

#Start VM
VBoxHeadless --startvm $vmname
