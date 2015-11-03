#!/bin/bash

touch serverOperation

eval "$(docker-machine env --swarm swarm-master)"

VERSION=`etcdctl get /GLOBAL/VERSION`
VHOST=`etcdctl get /GLOBAL/VHOST`

RESULTAT=$(docker run -d -p 80 -m 200M --env VHOST=$VHOST urik/apache-uoc:$VERSION)

if [ -z "$RESULTAT" ]; 
then 
  nodesSwarmObj=$(docker info | grep Nodes | awk '{print $2}')
  nodesSwarm=$nodesSwarmObj
  sh ./startServer.sh &
  segons=0
  echo $nodesSwarmObj
  echo $nodesSwarm
      while [ "$nodesSwarm" -eq "$nodesSwarmObj" ] && [ $segons -lt 300 ]; do
         sleep 5
         ((segons=segons+5))
         nodesSwarm=$(docker info | grep Nodes | awk '{print $2}')
         echo $segons "secs. -" $nodesSwarm "nodes swarm"
      done
  if [ "$nodesSwarm" -ne "$nodesSwarmObj" ]; then
  sh ./startContainer.sh
  fi
fi

rm -rf serverOperation
