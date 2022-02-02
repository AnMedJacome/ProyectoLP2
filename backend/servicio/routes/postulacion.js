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



router.get('/pasante/:pasante', (req, res) => {
    
  //req.params; // { userId: '42' }
  res.json(req.params);
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

module.exports = router;
