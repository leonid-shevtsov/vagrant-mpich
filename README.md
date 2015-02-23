download and install Vagrant
download and install chef-dk
install vagrant berkshelf plugin
make sure you have `ruby` and `ssh-keygen`

run `ruby keygen.rb` to produce keys for all hosts
run `vagrant up` to set up the cluster

## outdated

to build MPICH:

 ./configure --disable-f77 --disable-fc --disable-fortran --disable-cxx
