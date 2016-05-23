#!/bin/bash
set -x

if [ -f ${PASSWORD_ALREADY_SET} ]; then
  echo "MongoDB password already set!"
  exit 0
fi

PASS=${MONGODB_PASS:-$(pwgen -s 12 1)}
_word=$( [ ${MONGODB_PASS} ] && echo "preset" || echo "random" )

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MongoDB service startup"
    sleep 5
    mongo admin --eval "help" >/dev/null 2>&1
    RET=$?
done

echo "=> Standing up Replica Set in MongoDB"
mongo < /setup_replica.js

sleep 10
mongo < /rs_status.js

sleep 10
mongo < /rs_status.js

echo "=> Creating an admin user with a ${_word} password in MongoDB"

mongo < /setup_auth.js
sleep 5 

echo "=> MongoImport  data"
/fixture.sh

sleep 5

echo "=> Done!"
touch ${PASSWORD_ALREADY_SET}

echo "========================================================================"
echo "You can now connect to this MongoDB server"
echo "========================================================================"