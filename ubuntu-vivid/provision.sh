#!/bin/bash

# the following 3 lines are old stuff.
#sudo add-apt-repository --yes ppa:inizan-yannick/mono
#sudo apt-get -y update
#sudo apt-get -y install mono-complete monodevelop fsharp xfce4-session xinit

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list
sudo apt-get update

#The package mono-devel should be installed to compile code.
sudo apt-get -y install mono-devel

#The package mono-complete should be installed to install everything - this should cover most cases of “assembly not found” errors.
sudo apt-get -y install mono-complete

#The package referenceassemblies-pcl should be installed for
#PCL compilation support -
#this will resolve most cases of “Framework not installed: .NETPortable”
#errors during software compilation.
sudo apt-get -y install referenceassemblies-pcl

#The package ca-certificates-mono should be installed to get SSL
#certificates for HTTPS connections.
#Install this package if you run into trouble making HTTPS connections.
sudo apt-get -y install ca-certificates-mono

# Finally install Fsharp
sudo apt-get -y install fsharp

# install a few of my favorite things
sudo apt-get -y install tmux tree git wget curl
sudo apt-get -y install emacs24 zsh
sudo apt-get -y install build-essential
sudo apt-get -y instal lg++

# install startup files
sudo su vagrant
cd
cp /vagrant/provision-files/.emacs ~vagrant/.emacs.d/.emacs
cp /vagrant/provision-files/*.el ~vagrant/.emacs.d/
cp /vagrant/provision-files/.zshrc ~vagrant
chown vagrant:vagrant ~vagrant/.zshrc
chown vagrant:vagrant ~vagrant/.emacs.d/.emacs
chown vagrant:vagrant ~vagrant/.emacs.d/*.el

