file "#{node['workdir']}/machinefile" do
  content (0..node['hostcount']-1).map{|i| "192.168.50.#{100+node}"}.join("\n")
  owner 'vagrant'
  group 'vagrant'
end
