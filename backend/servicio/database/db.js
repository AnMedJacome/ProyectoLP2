const mysql = require('mysql2');
require('dotenv').config();

const conexion = mysql.createConnection({
    host: process.env.HOST,
    user: process.env.USER,
    password: process.env.PASSWORD,
    database: process.env.DATABASE,
  });

  conexion.connect((err) => {
      if(err){
          console.log(err);
          return;
      }else{
          console.log("Conectado a la base de datos");
      }
  })

  module.exports = conexion;