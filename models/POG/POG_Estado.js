const mongoose = require('mongoose');
const Schema = mongoose.Schema;
 
const POG_Estado = new Schema({
    name: {type: String, required: true, max: 115},
    abbreviation: {type: String, required: true, max: 115},
    description: {type: String, required: true, max: 155},
    status: {type: Boolean, required: true, default: true},
    created_at: { type: Date, default: Date.now }
});
 
module.exports = mongoose.model('POG_Estado', POG_Estado);