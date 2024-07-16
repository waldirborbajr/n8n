#!/usr/bin/env sh

multipass delete master
multipass delete worker

multipass purge

multipass launch docker --name master
multipass launch docker --name worker
