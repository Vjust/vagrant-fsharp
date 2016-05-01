# vagrant-fsharp

Provides [Vagrant][vagrant] VM descriptors for quickly obtaining
virtual machines set up for [F#][fsharp] development.

Code below assumes you have [Vagrant][vagrant] set up.

* [Issue tracker](https://github.com/intellifactory/vagrant-fsharp/issues)
* [GitHub Git repo](http://github.com/intellifactory/vagrant-fsharp)

## Boxes


## ubuntu-trusty

| Software      | Version            |
| ------------- |-------------------:|
| os            | Ubuntu Trusty x64  |
| mono          | 3.4.1              |
| monodevelop   | 4.2.3              |
| f#            | 3.0 (official pkg) |
| f# plugin     | TODO               |

Instructions:

    cd ubuntu-trusty
    vagrant up
    vagrant ssh
    sudo startxfce4 # TODO: enable X for default user

[fsharp]: http://fsharp.org/
[vagrant]: http://www.vagrantup.com/
