package 'mpich2'

keys = data_bag_item('ssh', 'keys')['keys']
our_key = keys[node['hostno']]

file '/etc/ssh/ssh_host_rsa_key' do
  content our_key['host']
  owner 'root'
  group 'root'
  mode 0600
end

directory '/home/vagrant/.ssh' do
  owner 'vagrant'
  group 'vagrant'
  mode 0700
end

file '/home/vagrant/.ssh/id_rsa' do
  content our_key['client']
  owner 'vagrant'
  group 'vagrant'
  mode 0600
end

file '/home/vagrant/.ssh/authorized_keys' do
  owner 'vagrant'
  group 'vagrant'
  mode 0600
  action :create_if_missing
end

bash "append_mpikeys" do
  code <<-EOS
    echo '#{"\n# MPIKEYS\n" + keys.map{|k| k['client_pub']}.join("\n")}' >>/home/vagrant/.ssh/authorized_keys
  EOS
  not_if "grep -q MPIKEYS /home/vagrant/.ssh/authorized_keys"
end

keys.each_with_index do |host, index|
  ssh_known_hosts_entry "mpihost#{index}" do
    key host['host_pub'].split(' ', 2)[1]
    key_type 'rsa'
  end

  bash "append_mpihost" do
    user "root"
    code <<-EOS
    echo "192.168.50.#{100+index} mpihost#{index}" >> /etc/hosts
    EOS
    not_if "grep -q mpihost#{index} /etc/hosts"
  end
end
