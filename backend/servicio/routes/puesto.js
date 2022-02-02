var express = require('express');
var router = express.Router();
const sequelize = require('../models/index.js').sequelize;
var initModels = require("../models/init-models");
var models = initModels(sequelize); 
const conexion=require('../database/db')

router.use((req, res, next) => {
	res.header('Access-Control-Allow-Origin', '*');
	res.header('Access-Control-Allow-Headers', 'Authorization, X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Allow-Request-Method');
	res.header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, DELETE');
	res.header('Allow', 'GET, POST, OPTIONS, PUT, DELETE');
	next();
});

router.get('/', function (req, res, next) {
	models.puesto.findAll({

	})
		.then(puestos => {
			res.send(puestos)
		})
		.catch(error => {res.status(400).send(error)
		console.log(error)})
});


router.get('/todos', async (req, res) =>{
	conexion.query('SELECT * FROM puesto INNER JOIN empresa ON puesto.empresa=empresa.ruc',(errors,result)=>{
		if(errors){
			console.log(errors);
			res.send(errors)
		  }else{
			res.send(result)
		  }
	})
});

router.post('/', function (req, res, next) {
	let empresa = req.body.empresa;
	let puesto_id = req.body.puesto_id;
	let cargo = req.body.cargo;
	let p_descripcion = req.body.p_descripcion;
	let modalidad = req.body.modalidad;
	let conocimiento_requerido = req.body.conocimiento_requerido;
	let formacion_requerida = req.body.formacion_requerida;
    let vacantes = req.body.vacantes;
    let salario = req.body.salario;
    let area_de_trabajo = req.body.area_de_trabajo;
	models.puesto.create({
		empresa: empresa,
		puesto_id: puesto_id,
		cargo: cargo,
		p_descripcion: p_descripcion,
		modalidad: modalidad,
		conocimiento_requerido: conocimiento_requerido,
		formacion_requerida: formacion_requerida,
        vacantes: vacantes,
		salario: salario,
		area_de_trabajo: area_de_trabajo
	  })
	  .then(puesto => {
		res.send(puesto)
	})
	  .catch(error => res.status(400).send(error));
});

/* GET ordenes listing. */
router.get('/:puesto_id', function(req, res, next) {
	models.puesto.findAll({
		  attributes: { },
		  where: {
			puesto_id: req.params.puesto_id
		  }
	  })
	  .then(puesto => {
		  res.json(puesto)
	  })
	  .catch(error => res.status(400).send(error))
  });


module.exports = router;