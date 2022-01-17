const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('puesto', {
    empresa: {
      type: DataTypes.BIGINT,
      allowNull: true
    },
    puesto_id: {
      autoIncrement: true,
      type: DataTypes.INTEGER.UNSIGNED,
      allowNull: false,
      primaryKey: true
    },
    cargo: {
      type: DataTypes.STRING(25),
      allowNull: true
    },
    p_descripcion: {
      type: DataTypes.STRING(500),
      allowNull: true
    },
    modalidad: {
      type: DataTypes.STRING(15),
      allowNull: true
    },
    conocimiento_requerido: {
      type: DataTypes.STRING(500),
      allowNull: true
    },
    formacion_requerida: {
      type: DataTypes.STRING(500),
      allowNull: true
    },
    vacantes: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    salario: {
      type: DataTypes.FLOAT,
      allowNull: true
    },
    area_de_trabajo: {
      type: DataTypes.STRING(50),
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'puesto',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "puesto_id" },
        ]
      },
    ]
  });
};
