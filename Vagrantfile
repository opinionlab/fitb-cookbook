require 'socket'
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu-12.04"
  config.vm.hostname = Socket.gethostname
  config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box"

  config.berkshelf.enabled = true
  
  config.omnibus.chef_version = :latest

  config.vm.network :forwarded_port, guest: 80, host: 8080

  # config.vm.network :private_network, ip: "192.168.33.10"

  # config.ssh.forward_agent = true

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  config.vm.provision :chef_solo do |chef|
    chef.add_recipe "fitb::default"
  end
end

