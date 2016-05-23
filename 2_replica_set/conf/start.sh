#!/bin/bash
set -ex

startMongo() { 
    echo "Starting MongoDB server node $1"
   	if [  -f /data/db/rs/$1/mongod.lock ];
	then
	  echo "Removing mongod.lock for node $1"
	  rm /data/db/rs/$1/mongod.lock
	fi	
	
	echo "Starting node $1"
	gosu mongodb mongod --replSet "${MONGODB_REPLICA_SET}" --port $2  --smallfiles --syslog --journal --httpinterface --rest --notablescan --dbpath /data/db/rs/$1 --fork --directoryperdb  --keyFile /.keyfile
}

startMongoStandAlone() {
    echo "Starting MongoDB server node $1"
        if [  -f /data/db/$1/mongod.lock ];
        then
          echo "Removing mongod.lock for node $1"
          rm /data/db/$1/mongod.lock
        fi

        echo "Starting node $1"
        gosu mongodb mongod --port $2  --smallfiles --syslog --journal --httpinterface --rest --notablescan --dbpath /data/db/$1 --fork --directoryperdb 
}


# Create database directories
mkdir -p /data/db/rs/1
mkdir -p /data/db/rs/2
mkdir -p /data/db/rs/3

chmod -R go+rwx /data/db
chown -R mongodb /data/db
sleep 1

# Run mongo replica sets using config files
# startMongoStandAlone standalone 27016

startMongo 1 27017
sleep 4
startMongo 2 27018
startMongo 3 27019
sleep 4

# Setup auth config
export PASSWORD_ALREADY_SET="/data/db/.mongodb_password_set"
if [ ! -f ${PASSWORD_ALREADY_SET} ]; then
    /configure.sh
    sleep 2
fi
echo "Initial configuration complete"


echo "All nodes started, pausing for replica set sync ..."
sleep 5

netstat -na | grep LISTEN

# Run infinite loop, this is required to keep the docker process running
while true 
do
#   echo "Sleeping ..."
   sleep 10
done

# DONE   
