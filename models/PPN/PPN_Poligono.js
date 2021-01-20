const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const PPN_Poligono = new Schema({
  zonaId: { type: Schema.Types.ObjectId, ref: "PPN_Zona" },
  localId: { type: Schema.Types.ObjectId, ref: "PPN_local" },
  fechaCreacion: { type: Date, default: Date.now },
  estado: { type: Boolean, default: true, required: true },
  geo: {
    type: {
      type: String,
      enum: ["Point", "LineString", "Polygon"],
    },
    coordinates: Array
  },
});

//2dsphere índice en el campo geográfico para trabajar con consultas geoespaciales
PPN_Poligono.index({ geo: "2dsphere" });

module.exports = mongoose.model("PPN_Poligono", PPN_Poligono);
