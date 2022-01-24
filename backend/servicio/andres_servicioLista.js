require("dotenv").config();

var express = require('express');
var app = express();
const mysql = require('mysql2');

const {obtenerDatos} = require('./funciones_andres');

app.use(express.json());

// .env con información para acceder a la base de datos
const conexion = mysql.createPool({
    host: process.env.HOST,
    user: process.env.USER,
    password: null,
    database: process.env.DATABASE,
});

var empresa;

app.listen(3001, () =>{
    let qy = "select e.nombre, pus.cargo from empresa e inner join puesto pus on e.ruc = pus.empresa where e.ruc = 0905050505001"
    obtenerDatos(conexion, qy, (resultado) => {
        empresa = resultado[0]["nombre"];
        console.log("Pantalla - LISTA DE POSTULANTES PARA LA "+empresa);
        console.log("Ingrese a uno de los links para poder ver:\n"+
        "\t\t> Orden por prioridad (localhost:3001/prioridad)\n"+
        "\t\t> Filtrar los postulantes (localhost:3001/filtro)")
    });
});


var query = "select nombre, apellido_materno,cargo from ("+
"select pos.puesto_id, p.nombre, p.apellido_materno "+
"from postulacion pos "+
"inner join perfil p " +
"on pos.pasante=p.cedula) ps "+
"inner join puesto p on ps.puesto_id = p.puesto_id";

var prioquery = "select nombre, apellido_materno,cargo from ("+
"select pos.cedula, pos.promedio, pos.fecha, pos.puesto_id, p.nombre, p.apellido_materno "+
"from ("+
"select u.promedio, post.fecha, post.puesto_id, c.cedula from curriculum c "+
"inner join (postulacion post, universidad u) "+
"on (post.pasante=c.cedula and c.universidad_id=u.universidad_id) "+
") pos "+
"inner join perfil p "+
"on pos.cedula=p.cedula"+
") pox "+
"inner join puesto p on pox.puesto_id = p.puesto_id";

app.get('/', (req, res) =>{
    res.send("Pantalla principal -> Ingrese a uno de los links para poder ver: orden"+
    "por prioridad (localhost:3001/prioridad) o filtrar los postulantes (localhost:3001/filtro)");
});

app.get('/filtro', (req, res) =>{
    res.send("Pantalla principal -> Revisar en la terminal la lista de los postulantes para la empresa "+empresa+". Para regresar, solo vaya al link  'localhost:3001'");
    var stdin = process.openStdin();
    stdin.addListener("data", (d) => {
        var str = parseInt(d.toString());
        if(str){
            switch (str){
                case 1:
                    obtenerDatos(conexion, query, (resultado) => {
                        console.log("X----------------------------------------------------------------X\n");
                        console.log("  Escribir un número para ver los respectivos filtros:\n"+
                        "\t\t1. Todos                             <<<\n"+
                        "\t\t2. Administradores de base de datos\n"+
                        "\t\t3. Contadores\n"+
                        "\t\t4. Desarrolladores web\n");
                        var contador = 0;
                        resultado.forEach(element => {
                            console.log("Nombre: "+element["nombre"]+"\t- Apellidos: "+element["apellido_materno"]+"\t - Cargo: "+element["cargo"]);
                            contador++;
                        });
                        if(contador == 0) console.log("No hay postulantes en general.\nVuelva luego.");
                        console.log("\nX----------------------------------------------------------------X");
                        console.log("Su número:");
                    });
                    break;
                case 2:
                    obtenerDatos(conexion, query+" where cargo = 'ADMINISTRADOR(A) BD'", (resultado) => {
                        console.log("X----------------------------------------------------------------X\n");
                        console.log("  Escribir un número para ver los respectivos filtros:\n"+
                        "\t\t1. Todos\n"+
                        "\t\t2. Administradores de base de datos  <<<\n"+
                        "\t\t3. Contadores\n"+
                        "\t\t4. Desarrolladores web\n");
                        var contador = 0;
                        resultado.forEach(element => {
                            console.log("Nombre: "+element["nombre"]+"\t- Apellidos: "+element["apellido_materno"]+"\t - Cargo: "+element["cargo"]);
                            contador++;
                        });
                        if(contador == 0) console.log("No hay postulantes en general.\nVuelva luego.");
                        console.log("\nX----------------------------------------------------------------X");
                        console.log("Su número:");
                    });
                    break;
                case 3:
                    obtenerDatos(conexion, query+" where cargo = 'CONTADOR(A)'", (resultado) => {
                        console.log("X----------------------------------------------------------------X\n");
                        console.log("  Escribir un número para ver los respectivos filtros:\n"+
                        "\t\t1. Todos\n"+
                        "\t\t2. Administradores de base de datos\n"+
                        "\t\t3. Contadores                        <<<\n"+
                        "\t\t4. Desarrolladores web\n");
                        var contador = 0;
                        resultado.forEach(element => {
                            console.log("Nombre: "+element["nombre"]+"\t- Apellidos: "+element["apellido_materno"]+"\t - Cargo: "+element["cargo"]);
                            contador++;
                        });
                        if(contador == 0) console.log("No hay postulantes en general.\nVuelva luego.");
                        console.log("\nX----------------------------------------------------------------X");
                        console.log("Su número:");
                    });
                    break;
                case 4:
                    obtenerDatos(conexion, query+" where cargo = 'DESARROLLADOR(A) WEB'", (resultado) => {
                        console.log("X----------------------------------------------------------------X\n");
                        console.log("  Escribir un número para ver los respectivos filtros:\n"+
                        "\t\t1. Todos\n"+
                        "\t\t2. Administradores de base de datos\n"+
                        "\t\t3. Contadores\n"+
                        "\t\t4. Desarrolladores web               <<<\n");
                        var contador = 0;
                        resultado.forEach(element => {
                            console.log("Nombre: "+element["nombre"]+"\t- Apellidos: "+element["apellido_materno"]+"\t - Cargo: "+element["cargo"]);
                            contador++;
                        });
                        if(contador == 0) console.log("No hay postulantes para este cargo.\nVuelva luego.");
                        console.log("\nX----------------------------------------------------------------X");
                        console.log("Su número:");
                    });
                    break;
                default:
                    console.log("X----------------------------------------------------------------X");
                    console.log("  Ingrese uno de los números en pantalla\n");
                    console.log("  Escribir un número para ver los respectivos filtros:\n"+
                        "\t\t1. Todos\n"+
                        "\t\t2. Administradores de base de datos\n"+
                        "\t\t3. Contadores\n"+
                        "\t\t4. Desarrolladores web\n");
                    console.log("X----------------------------------------------------------------X");
                    console.log("Su número:");
                    break;
            }
        } else {
            console.log("X----------------------------------------------------------------X");
            console.log("  No ha ingresado un número\n");
            console.log("  Escribir un número para ver los respectivos filtros:\n"+
                "\t\t1. Todos\n"+
                "\t\t2. Administradores de base de datos\n"+
                "\t\t3. Contadores\n"+
                "\t\t4. Desarrolladores web\n");
            console.log("X----------------------------------------------------------------X");
            console.log("Su número:");
        }
    });
});

app.get('/prioridad', (req, res) =>{
    res.send("Pantalla principal -> Revisar en la terminal la lista de los postulantes para la empresa "+empresa+". Debe elegir su orden de prioridad. Para regresar, solo vaya al link  'localhost:3001'");
    var stdin = process.openStdin();
    stdin.addListener("data", (d) => {
        var str = parseInt(d.toString());
        if(str){
            switch (str){
                case 1:
                    obtenerDatos(conexion, prioquery+" order by fecha asc", (resultado) => {
                        console.log("X----------------------------------------------------------------X\n");
                        console.log("  Escribir un número para ordenar por prioridad a los postulantes:\n"+
                        "\t\t1. Fecha de envío de solicitud     <<<\n"+
                        "\t\t2. Promedio universitario actual\n"+
                        "\t\t3. Sin prioridad\n");
                        var contador = 0;
                        resultado.forEach(element => {
                            console.log("Nombre: "+element["nombre"]+"\t- Apellidos: "+element["apellido_materno"]+"\t - Cargo: "+element["cargo"]);
                            contador++;
                        });
                        if(contador == 0) console.log("No hay postulantes en general.\nVuelva luego.");
                        console.log("\nX----------------------------------------------------------------X");
                        console.log("Su número:");
                    });
                    break;
                case 2:
                    obtenerDatos(conexion, prioquery+" order by promedio desc", (resultado) => {
                        console.log("X----------------------------------------------------------------X\n");
                        console.log("  Escribir un número para ver los respectivos filtros:\n"+
                        "\t\t1. Fecha de envío de solicitud\n"+
                        "\t\t2. Promedio universitario actual   <<<\n"+
                        "\t\t3. Sin prioridad\n");
                        var contador = 0;
                        resultado.forEach(element => {
                            console.log("Nombre: "+element["nombre"]+"\t- Apellidos: "+element["apellido_materno"]+"\t - Cargo: "+element["cargo"]);
                            contador++;
                        });
                        if(contador == 0) console.log("No hay postulantes en general.\nVuelva luego.");
                        console.log("\nX----------------------------------------------------------------X");
                        console.log("Su número:");
                    });
                    break;
                case 3:
                    obtenerDatos(conexion, prioquery, (resultado) => {
                        console.log("X----------------------------------------------------------------X\n");
                        console.log("  Escribir un número para ver los respectivos filtros:\n"+
                        "\t\t1. Fecha de envío de solicitud\n"+
                        "\t\t2. Promedio universitario actual\n"+
                        "\t\t3. Sin prioridad                   <<<\n");
                        var contador = 0;
                        resultado.forEach(element => {
                            console.log("Nombre: "+element["nombre"]+"\t- Apellidos: "+element["apellido_materno"]+"\t - Cargo: "+element["cargo"]);
                            contador++;
                        });
                        if(contador == 0) console.log("No hay postulantes para este cargo.\nVuelva luego.");
                        console.log("\nX----------------------------------------------------------------X");
                        console.log("Su número:");
                    });
                    break;
                default:
                    console.log("X----------------------------------------------------------------X");
                    console.log("  Ingrese uno de los números en pantalla\n");
                    console.log("  Escribir un número para ver los respectivos filtros:\n"+
                    "\t\t1. Fecha de envío de solicitud\n"+
                    "\t\t2. Promedio universitario actual\n"+
                    "\t\t3. Sin prioridad\n");
                    console.log("X----------------------------------------------------------------X");
                    console.log("Su número:");
                    break;
            }
        } else {
            console.log("X----------------------------------------------------------------X");
            console.log("  No ha ingresado un número\n");
            console.log("  Escribir un número para ver los respectivos filtros:\n"+
            "\t\t1. Fecha de envío de solicitud\n"+
            "\t\t2. Promedio universitario actual\n"+
            "\t\t3. Sin prioridad\n");
            console.log("X----------------------------------------------------------------X");
            console.log("Su número:");
        }
    });
});
