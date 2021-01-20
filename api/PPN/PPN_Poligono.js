const express = require('express');
const poligono = express.Router();
const PPN_Poligono = require('../../models/PPN/PPN_Poligono');

//consultar a poligonos
poligono.get('/poligonos', async (req, res)=>{
    try {
        const resPoligono = await PPN_Poligono.find({});
        res.status(200).json({
            resPoligono
        })
    } catch (error) {
        res.status(500).json({
            statusError: error
        })
    }
})


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