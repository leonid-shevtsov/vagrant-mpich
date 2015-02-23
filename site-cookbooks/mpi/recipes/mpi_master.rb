file "#{node['workdir']}/machinefile" do
  content (1..node['hostcount']-1).map{|i| "mpihost#{i}"}.join("\n")
  owner 'vagrant'
  group 'vagrant'
end
