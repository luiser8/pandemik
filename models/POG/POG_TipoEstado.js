const mongoose = require('mongoose');
const Schema = mongoose.Schema;
 
const POG_TipoEstado = new Schema({
    state_id: {type: Schema.Types.ObjectId, ref: "POG_Estado"},
    type: {type: Number, required: true, max: 1},
    order: {type: Number, required: true, max: 1},
    status: {type: Boolean, required: true, default: true},
    created_at: { type: Date, default: Date.now }
});
 
module.exports = mongoose.model('POG_TipoEstado', POG_TipoEstado);