name 'mpi'

maintainer "Leonid Shevtsov"
maintainer_email "leonid@shevtsov.me"

%w{ ubuntu debian }.each do |os|
  supports os
end

depends 'ssh_known_hosts'
