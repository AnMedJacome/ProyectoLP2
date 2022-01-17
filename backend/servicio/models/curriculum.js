const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('curriculum', {
    cedula: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    universidad_id: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    expectativa: {
      type: DataTypes.DOUBLE,
      allowNull: true
    },
    ultimo_ingreso: {
      type: DataTypes.DOUBLE,
      allowNull: true
    },
    empleo_id: {
      type: DataTypes.INTEGER,
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'curriculum',
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
