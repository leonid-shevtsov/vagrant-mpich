# MPICH cluster configuration script for Vagrant

This script rolls out an [MPICH](http://www.mpich.org/) parallel computation cluster. It uses Vagrant for machine setup and Chef for configuration.

I used it to set up a virtual machine cluster on my laptop, but I bet it can be used to set up [AWS machines with Vagrant](https://github.com/mitchellh/vagrant-aws) with minimal modifications.

## Installation

The script was written for OS X, but I don't see why it wouldn't work on Linux or even on Windows if you get an ssh-keygen for windows.

Prerequisites: [Vagrant](https://www.vagrantup.com/), [chef-dk](https://downloads.chef.io/chef-dk/), Ruby, `ssh-keygen`.

* Run `ruby keygen.rb`. This will generate a set of host and client keys for each machine in the cluster. These keys are for internal communication, and they shouldn't be publically available for good measure.

* Run `vagrant up`. This will create, boot, and provision the cluster.

## Usage

`vagrant ssh mpihost0` will get you into the master machine. From there,

    cd /vagrant/workdir
    mpicc helloworld.c
    mpiexec -f machinefile ./a.out

By the way, `workdir` is the mounted to the host `workdir` directory, so you can write your code on the host machine, and compile and run in the cluster.


## Limitations / TODO

The script has hardcoded static IPs, and is hardcoded to set up 4 hosts.

* * *

Released under the WTFPL license.

(c) [Leonid Shevtsov](http://leonid.shevtsov.me/)
