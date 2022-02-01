var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var cors = require('cors')
const multer=require('multer')

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var pasanteRouter = require('./routes/pasante');
var postulacionRouter = require('./routes/postulacion');
var empresaRouter = require('./routes/empresa');
var puestoRouter = require('./routes/puesto');
var app = express();

app.use(cors());

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/pasante', pasanteRouter);
app.use('/postulacion', postulacionRouter);
app.use('/empresa', empresaRouter);
app.use('/puestos', puestoRouter);
app.use('/users', usersRouter);

module.exports = app;
