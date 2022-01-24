const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('cuenta', {
    usuario: {
      type: DataTypes.STRING(20),
      allowNull: false,
      primaryKey: true
    },
    clave: {
      type: DataTypes.STRING(16),
      allowNull: true
    },
    correo: {
      type: DataTypes.STRING(40),
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'cuenta',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "usuario" },
        ]
      },
      {
        name: "clave",
        using: "BTREE",
        fields: [
          { name: "clave" },
          { name: "correo" },
        ]
      },
    ]
  });
};
