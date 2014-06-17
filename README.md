SimpleVagrantSetup
==================

Fairy basic set of Vagrant scripts to get an Ubuntu box provisioned and running Apache with PHP. It uses Vagrants provisioning to startup a new ubuntu server mount project directory using VirtualBox shared folders or NFS and expose a website over HTTPS.

Does not contail MySQL database, but that can be added.

# About files and folders

## Vagrantfile

This is the configuration file Vagrant needs to start up. This one assumes use of built in nework interface which on the your development maching should have the IP of 192.168.56.1. See file comments for more details on what does what.

## vagrant-shell (dir)

This directory contains all support files needed during first boot of the machine. 

boostrap.sh: all commands to be executed when building (Provisioning) the VM 
50-vagrant-mount.rules: this is a reference file, the actual command is execued in boostrap.sh. It creates an event listener which will start apache whenever vagrant mounts shared folders (when using VirtualBox shared fodlers method). Withouth this apache will fail to start as it will try to run before /vagrant direcotry is available.
apache (dir): contains Virtual Server configuration needed to run your project. Some additional xdebug.ini config and a self signed SSL certificate (that you will need to replace with your own)

