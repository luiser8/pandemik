var express = require('express');
var country = express.Router();
const CountryModel = require('../models/Country');

//get country
country.get('/countries', async (req, res) => {
    let message = '';
    CountryModel.find((err, countries) => {
        if(countries === undefined || countries.length == 0)
            message = `Countries table is empty ${err}`
        else
            message = 'Successfully'
        return res.send({error: false, data: countries, message: message})
      })
})

module.exports = country;