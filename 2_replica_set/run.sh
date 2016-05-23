#! /bin/bash 

docker run --name mongo32mug  -v /data/mongo/mug -d -p 27017:27017 -p 27018:27018 -p 27019:27019 --add-host="services.local:127.0.0.1"  mongo32mug
docker logs -f mongo32mug

