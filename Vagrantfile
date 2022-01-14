Vagrant.configure("2") do |config|
    config.vm.define "backend" do |backend|
      backend.vm.box = "generic/debian10"

      backend.vm.hostname = "backend"
      backend.vm.network "private_network", ip: "192.168.50.50"

      backend.vm.provider "virtualbox" do |vb|
        vb.memory = 512 
        vb.cpus = 1
      end
    end

    config.vm.define "frontend" do |frontend|
      frontend.vm.box = "generic/debian10"

      frontend.vm.network "private_network", ip: "192.168.60.60"
      frontend.vm.hostname = "frontend"

      frontend.vm.provider "virtualbox" do |vb|
        vb.memory = 512
        vb.cpus = 1
      end
    end

    config.vm.define "mysql" do |mysql|
      mysql.vm.box = "generic/debian10"

      mysql.vm.network "private_network", ip: "192.168.70.70"
      mysql.vm.hostname = "mysql"

      mysql.vm.provider "virtualbox" do |vb|
        vb.memory = 512
        vb.cpus = 1
      end
    end

    config.vm.provision "shell" do |s|
      ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
      s.inline = <<-SHELL
        sudo apt-get update 
        sudo apt-get install openssh-server
        echo "PermitRootLogin" >> /etc/ssh/sshd_config
        echo "PubkeyAuthentication" >> /etc/ssh/sshd_config
        mkdir -p /root/.ssh/
        touch /root/.ssh/authorized_keys
        echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
        echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
        sudo apt-get install -y htop python avahi-daemon avahi-utils libnss-mdns
        # mkdir -p /home/vagrant/.ssh/
        # chmod 700 /home/vagrant/.ssh
        # touch /home/vagrant/.ssh/authorized_keys
        # chmod -R 600 /home/vagrant/.ssh/authorized_keys
        # chown -R vagrant:vagrant /home/vagrant
      SHELL
    end
  end