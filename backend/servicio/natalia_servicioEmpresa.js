require("dotenv").config();

var express = require('express');
var app = express();
const mysql = require('mysql2');

app.use(express.json());

const conexion = mysql.createPool({
    host: process.env.HOST,
    user: process.env.USER,
    password: process.env.PASSWORD,
    database: process.env.DATABASE,
});

app.use('/empresa', empresaRouter);
app.use('/puesto', puestoRouter);