SimpleVagrantSetup
==================

Fairy basic set of Vagrant scripts to get an Ubuntu box provisioned and running Apache with PHP. It uses Vagrants provisioning to startup a new ubuntu server mount project directory using VirtualBox shared folders or NFS and expose a website over HTTPS.

This setup assumes that you are using [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

Does not contail MySQL database, but that can be added.

# How does it work?

Vagrant provides multiple ways of automatically setting up virtual machines (provisioning). The key here is to configure components other than the machine itself into a working dev box. That means installing Apache, PHP etc.

This project and file set use Vagrant's built-in provisioning mechanism. That means two things: 

1. The configuration is more transparent and easier to customise quickly, without dependency on external tools or editors, you just need a text editor
2. You will get your hands more dirty and may come up against some limitations in more complex virtual machine builds. 

So far this setup has worked well to host Symfony2 projects that do not require database.

# Installation

1. Copy Vagrantfile and vagrant-shell into the root of your folder and run *vagrant up*
2. Open Vagrantfile and modify (if needed) following lines
..1. **config.vm.network** - change to IP of your choice of leave as is. By default VirtualBox will allow you assign IP in 192.168.56.x range. 
..2. **config.vm.synced_folder** - this tells Vagrant to tell VirtualBox that shared folder between the VM and your machine will be the one Vagrantfile lives in and on the VM it will show up under /vagrant, leave this part as is, unless you want the VM to use a different path than /vagrant.
..3. By default this VM will use NFS for file sharing. This is the fastest way to share to work and will have noticeable performance benefits if you are using frameworks like Symfony2. If you are sharing this Vagrant setup between Windows and other platforms like OSX and Linux, you will not be able to use NFS without having different configurations between Windows and OSX/Linux machines. See the commented out line above :nfs line is you are deploying your VM on Windows.
..4. See **v.memory** and **v.cpu** and adjust to your needs. Defaults are pretty sensible for development purposes.
3. Open **vagrant-shell/apache/project-www.conf**
..1. Change apache settings to suit your project
5. Open **vagrant-shell/bootstrap.sh** and check if you need any additional packages installed

**Tip:** If you or other devs are not allowed to modify their hosts file you can try and create DNS entries with your VM's IP using any DNS service, that includes local DNS servers or DNS server hosted by domain name retailers. This can help if you want to use real URLs for development, but are unable to modify host file. 

# About files and folders

## Vagrantfile

This is the configuration file Vagrant needs to start up. This one assumes use of built in nework interface which on the your development maching should have the IP of 192.168.56.1. See file comments for more details on what does what.

## vagrant-shell (dir)

This directory contains all support files needed during first boot of the machine. 

**boostrap.sh:** all commands to be executed when building (Provisioning) the VM, see comments inside the file for more details.

**50-vagrant-mount.rules:** this is a reference file, the actual command is execued in boostrap.sh. It creates an event listener which will start apache whenever vagrant mounts shared folders (when using VirtualBox shared folders method). Withouth this Apache will fail to start as it will try to run before /vagrant directory is available. It is based on this article [link](http://razius.com/articles/launching-services-after-vagrant-mount/) 

**apache (dir):** contains Virtual Server configuration needed to run your project. Some additional xdebug.ini config and a self signed SSL certificate (that you will need to replace with your own)

## What if I need to add my own custom actions or files?

If you need something executed then adding it to boostsrap.sh is one option. In case you need to store any support files, libs etc. that you want copied to the VM, just place them in *vagrant-shell* directory and reference it in *boostrap.sh* via path */vagrant/vagrant-shell/your-file*





