#!/bin/bash

docker-machine create -d virtualbox mother-0

eval "$(docker-machine env mother-0)"

docker $(docker-machine config mother-0) run -d \
    -p "8500:8500" \
    -h "consul" \
    progrium/consul -server -bootstrap

sleep 1s

# web
docker-machine create \
	-d virtualbox \
	--swarm --swarm-image="swarm" --swarm-master \
	--swarm-discovery="consul://$(docker-machine ip mother-0):8500" \
	--engine-opt="cluster-store=consul://$(docker-machine ip mother-0):8500" \
	--engine-opt="cluster-advertise=eth1:2376" \
	father-0

sleep 1s

# php
docker-machine create -d virtualbox \
	--swarm --swarm-image="swarm:1.0.0" \
	--swarm-discovery="consul://$(docker-machine ip mother-0):8500" \
	--engine-opt="cluster-store=consul://$(docker-machine ip mother-0):8500" \
	--engine-opt="cluster-advertise=eth1:2376" \
	child-0

sleep 1s

# sql
docker-machine create -d virtualbox \
	--swarm --swarm-image="swarm:1.0.0" \
	--swarm-discovery="consul://$(docker-machine ip mother-0):8500" \
	--engine-opt="cluster-store=consul://$(docker-machine ip mother-0):8500" \
	--engine-opt="cluster-advertise=eth1:2376" \
	child-1

sleep 1s

eval $(docker-machine env --swarm father-0)

docker network create --driver overlay family

docker-machine ls

docker network ls 