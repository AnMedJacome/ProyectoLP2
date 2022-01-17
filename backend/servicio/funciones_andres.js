const mysql = require("mysql2");

function obtenerDatos(pool, query, mensaje){
    pool.getConnection((err, conexion) =>{
        if(err) throw err;
        conexion.query(query, (errr, resultado) =>{
            if(errr) throw errr;
            mensaje(resultado);
        });
    });
}

module.exports = {obtenerDatos};