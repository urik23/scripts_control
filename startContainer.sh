#!/bin/bash

eval "$(docker-machine env --swarm swarm-master)"

VERSION=`etcdctl get /GLOBAL/VERSION`
VHOST=`etcdctl get /GLOBAL/VHOST`

RESULTAT=$(docker run -d -p 80 -m 200M --env VHOST=$VHOST urik/apache-uoc:$VERSION)

if [ -z "$RESULTAT" ]; 
then 
sh ./startServer.sh
#sh ./startContainer.sh
fi
