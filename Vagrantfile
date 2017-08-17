hostname = 'ubuntu-pi'

Vagrant.configure('2') do |config|
  config.vm.box = 'ubuntu/xenial64'
  config.vm.hostname = hostname

  config.vm.provider 'virtualbox' do |vb|
    vb.name = hostname
    vb.cpus = 4
    vb.memory = 4096
  end

  config.vm.provision 'shell', path: 'provision.sh'
end
