Vagrant.configure("2") do |config|

    config.vm.box = "generic/debian10"
    config.vm.provider "virtualbox" do |vb|
      vb.memory = 1024 
      vb.cpus = 1
    end

    config.vm.define "backend" do |backend|
      backend.vm.hostname = "backend"
      backend.vm.network "private_network", ip: "192.168.50.50"
      backend.vm.synced_folder ".", "/home/vagrant/nsa", type: "rsync", 
        rsync__exclude: ".git/"
    end

    config.vm.define "frontend" do |frontend|
      frontend.vm.network "private_network", ip: "192.168.60.60"
      frontend.vm.hostname = "frontend"
    end

    config.vm.define "mysql" do |mysql|
      mysql.vm.network "private_network", ip: "192.168.70.70"
      mysql.vm.hostname = "mysql"
    end

    config.vm.provision "shell" do |s|
      ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
      s.inline = <<-SHELL
        sudo apt-get install openssh-server
        echo "PermitRootLogin" >> /etc/ssh/sshd_config
        echo "PubkeyAuthentication" >> /etc/ssh/sshd_config
        mkdir -p /root/.ssh/
        touch /root/.ssh/authorized_keys
        echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
        echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
        sudo apt-get install -y python 
      SHELL
    end
  end