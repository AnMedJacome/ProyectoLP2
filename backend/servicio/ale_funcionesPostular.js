require("dotenv").config();

var express = require('express');
var app = express();
const mysql = require('mysql2');

router.put("/:cedula",function (req, res, next){
	console.log(req.body);
	console.log(req.params);
	conexion.query(`UPDATE perfil SET ? WHERE ?`, [req.body,req.params], function(err, rows) {
	  if(err) {
		console.log(err.message);
		// do some stuff here
	  } else {
		console.log(rows);
		res.send("Actualizado")
	  }
	});

})

