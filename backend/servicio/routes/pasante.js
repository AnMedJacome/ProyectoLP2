var express = require('express');
var router = express.Router();
const conexion=require('../database/db')

const sequelize = require('../models/index.js').sequelize;
var initModels = require("../models/init-models");
var models = initModels(sequelize); 

/* GET pasantes listing. */
router.get('/', function(req, res, next) {
  /*res.send('respond with a resource');*/
   models.pasante.findAll({ 
     attributes: { exclude: ["updatedAt"] }
   })
   .then(pasante => {
      res.send(pasante)
   })
   .catch(error => res.status(400).send(error))
});

models.pasante.belongsTo(models.perfil, {targetKey:'cedula',foreignKey: 'cedula'});
/* GET pasantes listing. */
router.get('/', function(req, res, next) {
  /res.send('respond with a resource');/
   models.pasante.findAll({
	include: [{
		model: models.perfil,
		required: true
	  }]
   })
   .then(pasante => {
      res.send(pasante)
   })
   .catch(error => res.status(400).send(error))
});

router.post('/', function (req, res, next) {
	let carrera = req.body.carrera;
	let cedula = req.body.cedula;
	let usuario = req.body.usuario;
	let estado = req.body.estado;
	models.pasante.create({
		carrera: carrera,
		usuario: usuario,
		cedula: cedula,
		estado: estado,
	  })
	  .then(pasante => {
		res.send("Creado")
	})
	  .catch(error => {res.status(400).send(error)
    console.log(error )}); 
});

/* GET ordenes listing. */
router.get('/:usuario', function(req, res, next) {
	models.pasante.findAll({
			include: [{
			model: models.perfil,
			required: true
		  }],
		  where: {
			usuario: req.params.usuario
		  }
	  })
	  .then(pasante => {
		  res.json(pasante)
	  })
	  .catch(error => res.status(400).send(error))
  });

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

module.exports = router;
