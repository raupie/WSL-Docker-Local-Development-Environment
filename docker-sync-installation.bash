#!/bin/bash
# Docker-Sync + Unison Install

# Install ruby
sudo apt-get install ruby ruby-dev

# Install docker-sync
sudo gem install docker-sync

# Install unison
sudo apt-get install ocaml make emacs
wget https://github.com/bcpierce00/unison/archive/2.48.4.tar.gz
tar xvf 2.48.4.tar.gz
cd unison-2.48.4
make UISTYLE=text
sudo cp src/unison /usr/local/bin/unison
sudo cp src/unison-fsmonitor /usr/local/bin/unison-fsmonitor
