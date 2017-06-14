# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.
  config.ssh.forward_agent = true

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "bento/ubuntu-16.04"


  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
   config.vm.network "forwarded_port", guest: 22, host: 2200

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  config.vm.provider "virtualbox" do |vb|
    vb.name = "swift-dev-ubuntu16.04"
    # Building swift requires significant resources
    vb.memory = "6144"
    vb.cpus = 4
  end

  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
   # config.vm.provision "shell", inline: <<-SHELL
   # echo "export PATH=/home/vagrant/.swiftenv/bin:/vagrant/swift-3.0.2-RELEASE-ubuntu16.04/usr/bin:\"${PATH}\"" > /home/vagrant/.profile
   # SHELL

  config.vm.provision "fix-no-tty", type: "shell" do |s|
    s.privileged = false
    s.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
  end

  config.vm.provision "shell", inline: <<-SHELL
    echo "Updating virtual machine..."
    sudo DEBIAN_FRONTEND=noninteractive apt-get update
    echo "Installing swift prerequisites..."
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y git
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y cmake
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y ninja-build
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y clang
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y python
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y uuid-dev
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y libicu-dev
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y icu-devtools
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y libbsd-dev
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y libedit-dev
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y libxml2-dev
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y libsqlite3-dev
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y swig
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y libpython-dev
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y libncurses5-dev
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y pkg-config
    
    echo "Installing libdispatch prerequisites..."
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y autoconf
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y libtool
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y pkg-config
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y libblocksruntime-dev
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y libkqueue-dev
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y libbsd-dev
    SHELL

 config.vm.provision "acmeair", type: "shell", privileged: false, inline: <<-SHELL 
    export PATH=/home/vagrant/.swiftenv/bin:/vagrant/swift-3.0.2-RELEASE-ubuntu16.04/usr/bin:/home/vagrant/node/node-v6.11.0-linux-x64/bin:/home/vagrant/acmeair/mongo3/bin:/home/vagrant/acmeair/apache-jmeter-2.13/bin:\"${PATH}\"
    echo "PATH=/home/vagrant/.swiftenv/bin:/vagrant/swift-3.0.2-RELEASE-ubuntu16.04/usr/bin:/home/vagrant/node/node-v6.11.0-linux-x64/bin:/home/vagrant/acmeair/mongo3/bin:/home/vagrant/acmeair/apache-jmeter-2.13/bin:\"${PATH}\"" >> /home/vagrant/.profile
   # Install node
    mkdir /home/vagrant/node
    (cd /home/vagrant/node && tar -xf /vagrant/node-v6.11.0-linux-x64.tar)
   # Manage required AcmeAir repos
    mkdir /home/vagrant/acmeair
    (cd /home/vagrant/acmeair && git clone https://github.com/acmeair/acmeair-nodejs.git)
    (cd /home/vagrant/acmeair && git clone https://github.com/djones6/acmeair-driver.git)
    (cd /home/vagrant/acmeair && git clone https://github.com/alexwishart/acmeair-scripts.git)
   # Install dependencies for node project
    (cd /home/vagrant/acmeair/acmeair-nodejs && npm install)

   # Install mongoDB
    (cd /home/vagrant/acmeair && tar -xf /vagrant/mongo.tar.gz)
    sed -i '/DB_AFFINITY=/ s/="[^"][^"]*"/=""/' /home/vagrant/acmeair/acmeair-scripts/mongo_ramdisk.sh
    sed -i '/"MAX_DAYS_TO_SCHEDULE_FLIGHTS" :/ s/5/30/' /home/vagrant/acmeair/acmeair-nodejs/loader/loader-settings.json
    sed -i s/"-i .bak"/"-i.bak"/ /home/vagrant/acmeair/acmeair-scripts/runnode_cache.sh
    (cd /home/vagrant/acmeair/acmeair-scripts && ./mongo_ramdisk.sh start)
    (cd /home/vagrant/acmeair/acmeair-scripts && ./loaddb-nodejs.sh)
  # Install jmeter
    (cd /home/vagrant/acmeair && tar -xzf /vagrant/apache-jmeter-2.13.tgz)
    (cp home/vagrant/acmeair/acmeair-scripts/user.properties /home/vagrant/acmeair/acmeair-driver/acmeair-jmeter/scripts/user.properties)
    (cp home/vagrant/acmeair/acmeair-scripts/system.properties /home/vagrant/acmeair/acmeair-driver/acmeair-jmeter/scripts/system.properties)
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-8-jdk
    (cd /home/vagrant/acmeair/acmeair-driver && ./gradlew build)
    (cp /home/vagrant/acmeair/acmeair-driver/acmeair-jmeter/build/libs/acmeair-jmeter-1.1.0-SNAPSHOT.jar /home/vagrant/acmeair/apache-jmeter-2.13/lib/ext)
    (cp /vagrant/json-simple-1.1.1.jar /home/vagrant/acmeair/apache-jmeter-2.13/lib/ext)
  # Clone acmeair-swift
   (cd /home/vagrant/acmeair && git clone https://github.ibm.com/IBM-Swift/acmeair.git)


  #Add ssh key for enterprise github
   # cat /vagrant/vagrant_git_id_rsa >> ~vagrant/.ssh/authorized_keys

 
 SHELL
end