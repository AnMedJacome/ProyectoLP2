var express = require('express');
var router = express.Router();
const conexion=require('../database/db')
const sequelize = require('../models/index.js').sequelize;
var initModels = require("../models/init-models");
var models = initModels(sequelize); 
/* GET users listing. */
router.use((req, res, next) => {
	res.header('Access-Control-Allow-Origin', '*');
	res.header('Access-Control-Allow-Headers', 'Authorization, X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Allow-Request-Method');
	res.header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, DELETE');
	res.header('Allow', 'GET, POST, OPTIONS, PUT, DELETE');
	next();
});

router.post('/', function (req, res,next) {
	const usuario = req.body.usuario;
	let clave = req.body.clave;
	let correo = req.body.correo;

  conexion.query('INSERT INTO cuenta SET ?',{usuario:usuario,clave:clave,correo:correo},async(errors,result) => {
    if(errors){
      console.log(errors);
      res.send(errors)
    }else{
      console.log("Se ha creado el usuario con éxito")
      res.send("Usuario creado")
    }
  })
 
});

router.post('/auth', async (req, res) => {
  const usuario= req.body.usuario;
  const clave= req.body.clave;
  if(usuario && clave) {
    conexion.query('SELECT * FROM cuenta WHERE usuario = ?',[usuario],async (errors, resul) => {
      if(resul.length==0 || clave!=resul[0].clave){
        res.send("usuario o clave incorrecto")
      }else{
        res.send("LOGIN")
      }
    })
  }
})

module.exports = router;
