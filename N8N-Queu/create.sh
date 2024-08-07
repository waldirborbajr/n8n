#!/usr/bin/env sh

multipass delete manager
multipass delete reachable
multipass delete worker1
multipass delete worker2
multipass delete worker3

multipass purge

multipass launch docker --name manager
multipass launch docker --name reachable
multipass launch docker --name worker1
multipass launch docker --name worker2
multipass launch docker --name worker3

multipass exec manager -- sudo apt update
multipass exec manager -- sudo apt upgrade -y
multipass exec reachable -- sudo apt update
multipass exec reachable -- sudo apt upgrade -y
multipass exec worker1 -- sudo apt update
multipass exec worker1 -- sudo apt upgrade -y
multipass exec worker2 -- sudo apt update
multipass exec worker2 -- sudo apt upgrade -y
multipass exec worker3 -- sudo apt update
multipass exec worker3 -- sudo apt upgrade -y
