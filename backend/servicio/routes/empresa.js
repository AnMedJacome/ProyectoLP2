var express = require('express');
var router = express.Router();
const sequelize = require('../models/index.js').sequelize;
var initModels = require("../models/init-models");
var models = initModels(sequelize); 

router.use((req, res, next) => {
	res.header('Access-Control-Allow-Origin', '*');
	res.header('Access-Control-Allow-Headers', 'Authorization, X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Allow-Request-Method');
	res.header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, DELETE');
	res.header('Allow', 'GET, POST, OPTIONS, PUT, DELETE');
	next();
});

router.get('/', function (req, res, next) {
	models.empresa.findAll({
		attributes: {}
	})
		.then(empresas => {
			res.send(empresas)
		})
		.catch(error => res.status(400).send(error))
});


router.post('/', function (req, res, next) {
	let usuario = req.body.usuario;
	let ruc = req.body.ruc;
	let nombre = req.body.nombre;
	let e_descripcion = req.body.e_descripcion;
	let direccion = req.body.direccion;
	let telefono = req.body.telefono;
	let sitio_web = req.body.sitio_web;
	models.empresa.create({
		usuario: usuario,
		ruc: ruc,
		nombre: nombre,
		e_descripcion: e_descripcion,
		direccion: direccion,
		telefono: telefono,
		sitio_web: sitio_web
	  })
	  .then(empresa => {
		res.send(empresa)
	})
	  .catch(error => res.status(400).send(error));
});

/* GET ordenes listing. */
router.get('/:usuario', function(req, res, next) {
	models.empresa.findAll({
		  attributes: { },
		  where: {
			usuario: req.params.usuario
		  }
	  })
	  .then(empresa => {
		  res.json(empresa)
	  })
	  .catch(error => res.status(400).send(error))
  });

module.exports = router;