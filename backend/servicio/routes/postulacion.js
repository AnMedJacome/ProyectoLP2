var express = require('express');
var router = express.Router();

const sequelize = require('../models/index.js').sequelize;
var initModels = require("../models/init-models");
var models = initModels(sequelize); 


var pasante = '';

/* GET postulaciones listing. */
router.get('/', function(req, res, next) {
  /*res.send('respond with a resource');*/
   models.postulacion.findAll({ 
     attributes: { exclude: ["updatedAt"] }
   })
   .then(postulacion => {
      res.send(postulacion)
   })
   .catch(error => res.status(400).send(error))




});

router.get('/pasante/:pasante', (req, res) => {
    
  //req.params; // { userId: '42' }
  res.json(req.params);
});



module.exports = router;
