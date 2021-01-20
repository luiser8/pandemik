var express = require('express');
const router = express.Router();
var localRouter = require('../api/PPN/PPN_Local');
var polyonRouter = require('../api/PPN/PPN_Poligono');

//Home
router.get('/', (req, res) => {
    return res.render('index', { error: false, message:'API Pandemik' })
});

//PPN_Local
router.use('/api', localRouter);
router.use('/api', polyonRouter);

module.exports = router;