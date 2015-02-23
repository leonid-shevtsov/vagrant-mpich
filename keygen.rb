HOST_COUNT = 4

# Generate SSH host and client keys for every host in the cluster

require 'json'
require 'fileutils'

keys =(0..HOST_COUNT-1).map do |i|
  `ssh-keygen -f host_key -h -t rsa -N ''`
  `ssh-keygen -f client_key -t rsa -N ''`
  keys = {
    host: File.read('host_key'),
    host_pub: File.read('host_key.pub'),
    client: File.read('client_key'),
    client_pub: File.read('client_key.pub')
  }
  %w(host_key host_key.pub client_key client_key.pub).each do |name|
    File.unlink(name)
  end
  keys
end

FileUtils.mkdir_p('data_bags/ssh')

File.open('data_bags/ssh/keys.json', 'w') do |f|
  f.puts({
    id: 'keys',
    keys: keys
  }.to_json)
end
