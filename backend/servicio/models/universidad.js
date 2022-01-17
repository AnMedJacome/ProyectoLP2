const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('universidad', {
    universidad_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    promedio: {
      type: DataTypes.FLOAT,
      allowNull: true
    },
    ingreso: {
      type: DataTypes.DATEONLY,
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'universidad',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "universidad_id" },
        ]
      },
    ]
  });
};
