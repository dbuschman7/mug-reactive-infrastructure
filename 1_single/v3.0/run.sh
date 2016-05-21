#! /bin/bash 

docker run --name mongo-v30 -p 27018:27017 -v /data/mongo/v30:/data/db -d mongo:3.0


