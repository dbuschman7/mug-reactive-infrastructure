#! /bin/bash 

docker run --name mongo-v33 -p 27018:27017 -v /data/mongo/v33:/data/db -d mongo:3.3


