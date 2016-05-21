#! /bin/bash 

docker run --name mongo-v26 -p 27018:27017 -v /data/mongo/v26:/data/db -d mongo:2.6


