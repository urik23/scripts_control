#!/bin/bash

NUM_SERVER=`etcdctl get /GLOBAL/SERVER_NUM`
((NUM_SERVER--))
etcdctl set /GLOBAL/SERVER_NUM $NUM_SERVER

docker-machine stop swarm-node-`etcdctl get /GLOBAL/SERVER_NUM`
docker-machine rm swarm-node-`etcdctl get /GLOBAL/SERVER_NUM`
