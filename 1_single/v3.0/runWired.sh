#! /bin/bash 

docker run --name mongo-v30w -p 27018:27017 -v /data/mongo/v30w:/data/db -d mongo:3.0 --storageEngine wiredTiger


