const mongoose = require('mongoose');
const Schema = mongoose.Schema;
 
const PPC_Cadena = new Schema({
    email: {type: String, required: true, max: 115},
    website: {type: String, required: true, max: 255},
    address: {type: String, required: true, max: 255},
    description: {type: String, required: true, max: 255},
    status: {type: Boolean, required: true, default: true},
    created_at: { type: Date, default: Date.now }
});
 
module.exports = mongoose.model('PPC_Cadena', PPC_Cadena);