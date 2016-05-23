config = {
    _id: "timeli",
    members: [{
        _id: 0,
        priority: 10,
        host: "services.local:27017"
    }, {
        _id: 1,
        priority: 1,
        host: "services.local:27018"
    }, {
        _id: 3,
        priority: 0,
        arbiterOnly : true,
        host: "services.local:27019"
    }]
};
rs.initiate(config);