#!/bin/bash

if [ ! -e serverOperation ]; then
eval "$(docker-machine env --swarm swarm-master)"

export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://45.55.170.25:3376"
export DOCKER_CERT_PATH="/home/core/.docker/machine/certs"
export DOCKER_MACHINE_NAME="swarm-master"


  mitja=$(docker stats --no-stream=true $(docker ps -q) | awk -f mitja.awk)
 
  echo $mitja
  var=$(awk -v mitja=$mitja 'BEGIN{ if ( mitja > 5 ) {print 1} else {print 0} }')

  echo "var1 " $var
  if [ "$var" -eq 1 ]; then
    echo "StartContainer"
   date >> server.log   
   sh startContainer.sh >> server.log & 
  fi

  var=$(awk -v mitja=$mitja 'BEGIN{ if ( mitja < 2 ) {print 1} else {print 0} }')
  echo "var2 " $var
  if [ "$var" -eq 1 ]; then
    serverNum=`etcdctl get /GLOBAL/SERVER_NUM`
    echo "Comprobem quants servidors tenim: " $serverNum
    if [ "$serverNum" -gt "1" ]; then
      echo "Destruim Servidor"
#      date >> server.log
#      sh destroyServer.sh >> server.log &
    fi
  fi
fi
