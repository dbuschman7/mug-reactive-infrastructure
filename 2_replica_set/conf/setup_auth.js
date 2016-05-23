use admin
db.createUser( { user: 'root', pwd: 'password', roles: [ { role: 'root', db: 'admin' } ] });
db.auth("root", "password");
db.grantRolesToUser('root' , [ {role: 'dbAdmin', db:'test' } ]);

db.createUser( { user: 'userAdmin', pwd: 'password', roles: [ { role: 'userAdminAnyDatabase', db: 'admin' } ] });

use test
db.createUser({user:'user', pwd: 'password', roles: [ {role: 'dbOwner', db: 'test' }, {role: 'readWrite', db: 'test'  }]});
db.grantRolesToUser('user' , [ {role: 'readWrite', db:'test' }, { role: 'dbAdmin', db:'test' } ]);

