#!/bin/bash

NUM_SERVER=`etcdctl get /GLOBAL/SERVER_NUM`
export DIGITAL_OCEAN_TOKEN=`etcdctl get /GLOBAL/DIGITAL_OCEAN_TOKEN`
export SWARM_TOKEN=`etcdctl get /GLOBAL/SWARM_TOKEN`

docker-machine create -d digitalocean --digitalocean-region lon1 --digitalocean-access-token $DIGITAL_OCEAN_TOKEN --swarm --swarm-discovery $SWARM_TOKEN swarm-node-`etcdctl get /GLOBAL/SERVER_NUM`

NUM_SERVER=`etcdctl get /GLOBAL/SERVER_NUM`
((NUM_SERVER++))
etcdctl set /GLOBAL/SERVER_NUM $NUM_SERVER
