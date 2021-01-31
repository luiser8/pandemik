var express = require('express');
var local = express.Router();
const PPN_Local = require('../../models/PPN/PPN_Local');

//GET PPN_Local
local.get('/ppn_local', async (req, res) => {
    res.json({'ok': 200});
})
//POST PPN_Local
local.post('/ppn_local', async (req, res) => {
    const { cadena_id, name, latitude, longitude, status } = req.body;
    const newLocal = new PPN_Local({cadena_id, name, latitude, longitude, status});
    try {
        await newLocal.save();
    } catch (error) {
        console.error(error)
    }
})

module.exports = local;