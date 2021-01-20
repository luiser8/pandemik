var express = require('express');
var local = express.Router();
const PPN_Local = require('../models/PPN/PPN_Local');

//post PPN_Local
local.post('/ppn_local', async (req, res) => {
    const { cadena_id, name, latitude, longitude, status } = req.body;
    const newLocal = new PPN_Local({cadena_id, name, latitude, longitude, status});
    try {
        await newLocal.save();
    } catch (error) {
        console.log(error)
    }
})

module.exports = local;