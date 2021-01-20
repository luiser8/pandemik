const mongoose = require('mongoose');
const Schema = mongoose.Schema;
 
const PPG_Persona = new Schema({
    cedula: {type: String, required: true},
    first_name: {type: String, required: true, max: 115},
    last_name: {type: String, required: true, max: 115},
    username: {type: String, required: true, max: 155},
    email: {type: String, required: true, max: 155},
    password: {type: String, required: true, max: 255},
    phone: {type: String, required: true, max: 115},
    address: {type: String, required: true, max: 255},
    sexo: {type: Number, required: true, max: 1},
    status: {type: Boolean, required: true, default: true},
    created_at: { type: Date, default: Date.now }
});
 
module.exports = mongoose.model('PPG_Persona', PPG_Persona);