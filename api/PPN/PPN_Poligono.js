const express = require('express');
const poligono = express.Router();
const PPN_Poligono = require('../../models/PPN/PPN_Poligono');

//consultar a poligono

//agregar poligono
poligono.post('/agregarPoligono', async (req, res)=>{
    const { zonaId, localId, geo, coordinates} = req.body;
    const newPoligono = new PPN_Poligono({zonaId, localId, geo, coordinates});
    try {
        await newPoligono.save();
        res.status(200).json({
            status: "guardado"
        })
    } catch (error) {
        res.status(500).json({
            statusError: error
        })
    }
})

module.exports = poligono