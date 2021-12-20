#!/usr/bin/env bash
#remove all images
docker rmi $(docker images -a -q)

