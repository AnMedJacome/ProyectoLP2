var express = require('express');
var router = express.Router();
const conexion=require('../database/db')
const sequelize = require('../models/index.js').sequelize;
var initModels = require("../models/init-models");
var models = initModels(sequelize); 


var pasante = '';

/* GET postulaciones listing. */
router.get('/', function(req, res, next) {
  conexion.query('SELECT * FROM puesto INNER JOIN empresa ON puesto.empresa=empresa.ruc',(errors,result)=>{
		if(errors){
			console.log(errors);
			res.send(errors)
		  }else{
			res.send(result)
		  }
	}) 
});



router.get('/:pasante', (req, res) => {
	conexion.query('SELECT * FROM postulacion INNER JOIN puesto ON postulacion.puesto_id=puesto.puesto_id WHERE pasante=?',[req.params.pasante],(errors,result)=>{
		if(errors){
			console.log(errors);
			res.send(errors)
		  }else{
			res.send(result)
		  }
	}) 
});


router.post('/', function (req, res, next) {
	let pasante = req.body.pasante;
	let puesto_id = req.body.puesto_id;
	let estado = 1;
	let fecha = req.body.fecha;
	models.postulacion.create({
		pasante: pasante,
		puesto_id: puesto_id,
		estado: estado,
		fecha: fecha
	  })
	  .then(postulacion => {
		res.send(postulacion)
	})
	  .catch(error => res.status(400).send(error));
});

router.put("/aceptar/:id",function (req, res, next){
	conexion.query(`UPDATE postulacion SET estado=2 WHERE id=?`, [req.params.id], function(err, rows) {
	  if(err) {
		console.log(err.message);
		// do some stuff here
	  } else {
		console.log(rows);
		res.send("Aceptado")
	  }
	});
})

router.put("/negar/:id",function (req, res, next){
	conexion.query(`UPDATE postulacion SET estado=0 WHERE id=?`, [req.params.id], function(err, rows) {
	  if(err) {
		console.log(err.message);
		// do some stuff here
	  } else {
		console.log(rows);
		res.send("Negado")
	  }
	});
})
module.exports = router;
