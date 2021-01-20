const mongoose = require('mongoose');
const Schema = mongoose.Schema;
 
const PPN_Local = new Schema({
    cadena_id: {type: Schema.Types.ObjectId, ref: "PPC_Cadena"},
    name: {type: String, required: true, max: 155},
    latitude: {type: Number, required: true},
    longitude: {type: Number, required: true, max: 1},
    status: {type: Boolean, required: true, default: true},
    created_at: { type: Date, default: Date.now }
});
 
module.exports = mongoose.model('PPN_Local', PPN_Local);