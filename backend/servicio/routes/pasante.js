var express = require('express');
var router = express.Router();

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

module.exports = router;
