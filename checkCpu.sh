#!/bin/bash

if [ ! -e serverOperation ]; then
eval "$(docker-machine env --swarm swarm-master)"


  mitja=$(docker stats --no-stream=true $(docker ps -q) | awk -f mitja.awk)
  echo $mitja
  var=$(awk 'BEGIN{ print "10"<"'$mitja'" }')

  echo "var1 " $var
  if [ "$var" -eq 1 ]; then
    echo "StartContainer"
    sh startContainer.sh &
  fi
  var=$(awk 'BEGIN{ print "'$mitja'"<"2" }')
  echo "var2 " $var
  if [ "$var" -eq 1 ]; then
    serverNum=`etcdctl get /GLOBAL/SERVER_NUM`
    echo "Comprobem quants servidors tenim: " $serverNum
    if [ "$serverNum" -gt "1" ]; then
      echo "Destruim Servidor"
      sh destroyServer.sh &
    fi
  fi
fi
