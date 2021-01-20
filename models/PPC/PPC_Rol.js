const mongoose = require('mongoose');
const Schema = mongoose.Schema;
 
const PPC_Rol = new Schema({
    name: {type: Schema.Types.ObjectId, ref: "POG_Estado"},
    hierarchy: {type: Number, required: true, max: 1},
    description: {type: String, required: true, max: 255},
    status: {type: Boolean, required: true, default: true},
    created_at: { type: Date, default: Date.now }
});
 
module.exports = mongoose.model('PPC_Rol', PPC_Rol);