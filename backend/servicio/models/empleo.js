const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('empleo', {
    id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    empresa: {
      type: DataTypes.STRING(45),
      allowNull: true
    },
    actual: {
      type: DataTypes.BOOLEAN,
      allowNull: true
    },
    pais: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    inicio: {
      type: DataTypes.DATEONLY,
      allowNull: true
    },
    fin: {
      type: DataTypes.DATEONLY,
      allowNull: true
    },
    puesto: {
      type: DataTypes.STRING(25),
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'empleo',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "id" },
        ]
      },
    ]
  });
};
