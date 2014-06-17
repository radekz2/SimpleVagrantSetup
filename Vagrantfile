Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu-precise12042-x64-vbox43"
  config.vm.box_url = "http://box.puphpet.com/ubuntu-precise12042-x64-vbox43.box"
  #config.vm.hostname = "vagrantbasebox"
  config.vm.network "private_network", ip: "192.168.56.100"
  #config.vm.synced_folder ".", "/vagrant", :mount_options => ["dmode=777,fmode=777"]
  config.vm.synced_folder ".", "/vagrant", :nfs => { :mount_options => ["dmode=777","fmode=777"] }
  config.vm.provision :shell, :path => "vagrant-shell/bootstrap.sh"
  config.vm.provision "shell", inline: "service apache2 restart", run: "always"
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 1
  end
end
