SimpleVagrantSetup
==================

Fairy basic set of Vagrant scripts to get an Ubuntu box provisioned and running Apache with PHP. It uses Vagrants provisioning to startup a new ubuntu server mount project directory using VirtualBox shared folders or NFS and expose a website over HTTPS.

Does not contail MySQL database, but that can be added.

# How does it work?

Vagrant provides multiple ways of automatic setup of the virtual machine (provisioning). The key here is to configure components other than the machine itself into a working dev box. That means installing Apache, PHP etc.

This project and file set use Vagrant's built-in provisioning mechanism. That means two things: 

1. The configuration is more transparent and easier to customise quickly, without dependency on external tools or editors, you just need a text editor
2. You will get your hands more dirty and may come up against some limitations in more complex virtual machine builds. 

So far this setup has worked well to host Symfony2 projects that do not require database.

# Installation

Copy Vagrantfile and vagrant-shell into the root of your folder and run *vagrant up*

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





