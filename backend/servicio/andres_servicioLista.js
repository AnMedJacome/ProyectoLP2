require("dotenv").config();

var express = require('express');
var app = express();
const mysql = require('mysql2');

app.use(express.json());

// .env con información para acceder a la base de datos
const conexion = mysql.createConnection({
    host: process.env.HOST,
    user: process.env.USER,
    password: process.env.PASSWORD,
    database: process.env.DATABASE,
});

app.get('/', (req, res) =>{
    res.send("Hello world 2");
});

app.listen(3001,() => {
    console.log("Servidor en puerto 3001...");
});