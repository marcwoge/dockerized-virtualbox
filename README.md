# docker_virtualbox
dockerize Virtualbox for ubuntu

# Some errors occurred 
WARNING: The character device /dev/vboxdrv does not exist.

	 Please install the virtualbox-dkms package and the appropriate
	 headers, most likely linux-headers-generic.

	 You will not be able to start VMs until this problem is fixed.

Qt WARNING: QStandardPaths: XDG_RUNTIME_DIR not set, defaulting to '/tmp/runtime-root'
Qt WARNING: QXcbConnection: Could not connect to display 
Qt CRITICAL: Could not connect to any X display.

Create a VirtualBox VM from the command line
I assume that the VirtualBox' VM directory is located in "~/VirtualBox\ VMs".

# creating a headless VM
First create a VM. The name of the VM is "testvm" in this example.

	 $ VBoxManage createvm --name "testvm" --register
Specify the hardware configurations of the VM (e.g., Ubuntu OS type, 1024MB memory, bridged networking, DVD booting).

	 $ VBoxManage modifyvm "testvm" --memory 1024 --acpi on --boot1 dvd --nic1 bridged --bridgeadapter1 eth0 --ostype Ubuntu
Create a disk image (with size of 10000 MB). Optionally, you can specify disk image format by using "--format [VDI|VMDK|VHD]" option. Without this option, VDI image format will be used by default.

	 $ VBoxManage createvdi --filename ~/VirtualBox\ VMs/testvm/testvm-disk01.vdi --size 10000
Add an IDE controller to the VM.

	 $ VBoxManage storagectl "testvm" --name "IDE Controller" --add ide
Attach the previously created disk image as well as CD/DVD drive to the IDE controller. Ubuntu installation ISO image (found in /iso/ubuntu-12.04.1-server-i386.iso) is then inserted to the CD/DVD drive.

	 $ VBoxManage storageattach "testvm" --storagectl "IDE Controller" --port 0 --device 0 --type hdd --medium ~/VirtualBox\ VMs/testvm/testvm-disk01.vdi
	 $ VBoxManage storageattach "testvm" --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium /iso/ubuntu-12.04.1-server-i386.iso
Start VirtualBox VM from the command line
Once a new VM is created, you can start the VM headless (i.e., without VirtualBox console GUI) as follows.

	 $ VBoxHeadless --startvm "testvm" &
The above command will launch the VM, as well as VRDE remote desktop server. The remote desktop server is needed to access the headless VM's console.

By default, the VRDE server is listening on TCP port 3389. If you want to change the default port number, use "-e" option as follows.

	 $ VBoxHeadless --startvm "testvm" -e "TCP/Ports=4444" &

If you don't need remote desktop support, launch a VM with "--vrde off" option.

	 $ VBoxHeadless --startvm "testvm" --vrde off &

# Thanks

How to create a headless VM: http://xmodulo.com/how-to-create-and-start-virtualbox-vm-without-gui.html  thanks to Dan Nanni

The Starting Point with the Dockerfile Jérémy DECOOL https://github.com/jdecool/dockerfiles/tree/master/virtualbox
