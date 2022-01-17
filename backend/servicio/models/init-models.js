var DataTypes = require("sequelize").DataTypes;
var _cuenta = require("./cuenta");
var _curriculum = require("./curriculum");
var _educacion = require("./educacion");
var _empleo = require("./empleo");
var _empresa = require("./empresa");
var _institucion = require("./institucion");
var _pasante = require("./pasante");
var _perfil = require("./perfil");
var _postulacion = require("./postulacion");
var _puesto = require("./puesto");
var _universidad = require("./universidad");

function initModels(sequelize) {
  var cuenta = _cuenta(sequelize, DataTypes);
  var curriculum = _curriculum(sequelize, DataTypes);
  var educacion = _educacion(sequelize, DataTypes);
  var empleo = _empleo(sequelize, DataTypes);
  var empresa = _empresa(sequelize, DataTypes);
  var institucion = _institucion(sequelize, DataTypes);
  var pasante = _pasante(sequelize, DataTypes);
  var perfil = _perfil(sequelize, DataTypes);
  var postulacion = _postulacion(sequelize, DataTypes);
  var puesto = _puesto(sequelize, DataTypes);
  var universidad = _universidad(sequelize, DataTypes);


  return {
    cuenta,
    curriculum,
    educacion,
    empleo,
    empresa,
    institucion,
    pasante,
    perfil,
    postulacion,
    puesto,
    universidad,
  };
}
module.exports = initModels;
module.exports.initModels = initModels;
module.exports.default = initModels;
