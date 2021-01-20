const mongoose = require('mongoose');
require('dotenv').config();

    var db = mongoose.connect(process.env.DB, {
        useNewUrlParser: true,
        useUnifiedTopology: true,
        useFindAndModify: false,
        useCreateIndex: true
    }).then(db => console.log('DB is connected')).catch(err => console.error(err));
    
module.exports = db;