const mongoose = require('mongoose');
const Schema = mongoose.Schema;
 
const PPN_Zona = new Schema({
    zona_id: {type: Schema.Types.ObjectId, ref: "PPN_Local"},
    name: {type: String, required: true, max: 155},
    description: {type: String, required: true, max: 255},
    status: {type: Boolean, required: true, default: true},
    created_at: { type: Date, default: Date.now }
});
 
module.exports = mongoose.model('PPN_Zona', PPN_Zona);