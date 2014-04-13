# [vagrant 1.5.2][vb 4.2.24]
Vagrant.configure("2") do |config|

  # Ubuntu 13.04
  config.vm.box = "raring64"
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-amd64-vagrant-disk1.box"

 # Allocate host resources
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--cpus", "4"] 
  end

  # Network
  config.vm.network "private_network", ip: "10.10.10.10" #host-only network required for nfs
  config.vm.network "forwarded_port", guest: 8080, host: 8080 #Python
  config.vm.network "forwarded_port", guest: 3306, host: 3306 #MySQL

  # Vagrant Cachier
  # vagrant plugin install vagrant-cachier
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  config.cache.synced_folder_opts = {
      type: :nfs,
      mount_options: ['rw', 'vers=3', 'tcp', 'nolock']
  }
  end

  config.vm.provision "shell", path: "scripts/install.sh"

end

