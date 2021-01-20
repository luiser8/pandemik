var express = require('express');
const router = express.Router();
var localRouter = require('../api/PPN/PPN_Local');

//Home
router.get('/', (req, res) => {
    return res.render('index', { error: false, message:'API REST NODE' })
});

//PPN_Local
router.use('/api', localRouter);

module.exports = router;