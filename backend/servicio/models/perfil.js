const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('perfil', {
    cedula: {
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    nombre: {
      type: DataTypes.STRING(45),
      allowNull: true
    },
    segundo_nombre: {
      type: DataTypes.STRING(25),
      allowNull: true
    },
    apellido_materno: {
      type: DataTypes.STRING(35),
      allowNull: true
    },
    apellido_paterno: {
      type: DataTypes.STRING(35),
      allowNull: true
    },
    sexo: {
      type: DataTypes.CHAR(1),
      allowNull: true
    },
    fechaNacimiento: {
      type: DataTypes.DATEONLY,
      allowNull: true
    },
    direccion: {
      type: DataTypes.STRING(50),
      allowNull: true
    },
    telefono: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    paisNacimiento: {
      type: DataTypes.CHAR(35),
      allowNull: true
    },
    nacionalidad: {
      type: DataTypes.STRING(35),
      allowNull: true
    },
    foto: {
      type: DataTypes.BLOB,
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'perfil',
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
      {
        name: "nombre",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "nombre" },
          { name: "apellido_paterno" },
          { name: "apellido_materno" },
        ]
      },
    ]
  });
};
