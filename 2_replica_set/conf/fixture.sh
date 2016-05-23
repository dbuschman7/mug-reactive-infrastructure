#! /bin/sh
set -x 

FIXTURE_DIR="/etc/mongodb/fixture"

mongoimport  --db test -u user -p password    --collection laptop  < ${FIXTURE_DIR}/laptop.json 

