#!/bin/bash
eval "$(docker-machine env --swarm swarm-master)"
docker exec --interactive=false $1 curl -s http://localhost:8080/metrics | sed 's/^.*systemload.average":\(.*\),"heap.committed".*/\1/'
