#!/usr/bin/env bash

#stop all container 
docker stop $(docker ps -a -q)

#remove all container
docker rm -f $(docker ps -a -q)

