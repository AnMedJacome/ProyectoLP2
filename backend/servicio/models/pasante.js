const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('pasante', {
    usuario: {
      type: DataTypes.STRING(20),
      allowNull: false
    },
    cedula: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    carrera: {
      type: DataTypes.STRING(35),
      allowNull: true
    },  
    estado: {
      type: DataTypes.SMALLINT,
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'pasante',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "cedula" },
        ]
      },
    ]
  });
};
