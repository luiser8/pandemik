var express = require('express');
const router = express.Router();
//var countriesRouter = require('../api/country');
var localRouter = require('../api/PPN_Local');

//Home
router.get('/', (req, res) => {
    return res.render('index', { error: false, message:'API REST NODE' })
});
//Countries
//router.use('/api', countriesRouter);

router.use('/api', localRouter);

module.exports = router;