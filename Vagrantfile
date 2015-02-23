HOST_COUNT = 4

Vagrant.configure("2") do |config|
  # FIXME need this to be fixed to make vagrant-berkshelf work properly
  # https://github.com/berkshelf/vagrant-berkshelf/pull/266
  config.berkshelf.enabled = false

  HOST_COUNT.times do |hostno|
    config.vm.define "mpihost#{hostno}" do |host|
      host.vm.box = "ubuntu/trusty64"
      host.vm.hostname = "mpihost#{hostno}"
      host.vm.network 'private_network',
                      virtualbox__intnet: 'mpicluster',
                      ip: "192.168.50.#{100 + hostno}"
      host.vm.provision 'chef_solo' do |chef|
        chef.cookbooks_path = ['berks-cookbooks', 'site-cookbooks']
        chef.data_bags_path = ['data_bags']
        chef.add_recipe 'mpi::mpi_base'
        chef.add_recipe (hostno == 0) ? 'mpi::mpi_master' : 'mpi::mpi_worker'
        chef.json = { hostno: hostno, hostcount: HOST_COUNT, workdir: '/vagrant/workdir' }
      end
    end
  end
end
