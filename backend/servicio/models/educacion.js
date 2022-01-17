const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('educacion', {
    id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    estudiante: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    institucion_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    inicio: {
      type: DataTypes.DATEONLY,
      allowNull: true
    },
    graduacion: {
      type: DataTypes.DATEONLY,
      allowNull: true
    },
    promedio: {
      type: DataTypes.FLOAT,
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'educacion',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "id" },
          { name: "estudiante" },
          { name: "institucion_id" },
        ]
      },
    ]
  });
};
