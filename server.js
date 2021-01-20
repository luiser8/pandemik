var express = require('express');
var createError = require('http-errors');
var body_parser = require('body-parser');
var morgan = require('morgan');
var cors = require('cors');
var path = require('path');
const swaggerUi = require('swagger-ui-express');
const swaggerDocument = require('./public/documentation/swagger.json');

var app = express();
require('./db');
app.use(morgan('combined'));

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(cors())
app.use(body_parser.json());
app.use(body_parser.urlencoded({
    extended: true 
}));
app.use(morgan('dev'));

// Static Files
app.use(express.static(path.join(__dirname, '/public')));

//Routes
app.use(require('./routes/routes'));

//Swagger
app.use('/api/documentation', swaggerUi.serve, swaggerUi.setup(swaggerDocument));

//catch 404 and forward to error handler
app.use((req, res, next) => {
    next(createError(404));
});

//error handler
app.use((err, req, res, next) => {
    // set locals, only providing error in development
    res.locals.message = err.message;
    res.locals.error = req.app.get('env') === 'development' ? err : {};
  
    // render the error page
    res.status(err.status || 500);
    res.render('error');
});

//set port
app.listen(9000, () => {
    console.log('Node port 9000');
});

module.exports = app;