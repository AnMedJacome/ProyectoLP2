require("dotenv").config();

var express = require('express');
var app = express();
const mysql = require('mysql2');

const {obtenerDatos} = require('./funciones_andres');

app.use(express.json());
app.use((req, res, next) => {
	res.header('Access-Control-Allow-Origin', '*');
	res.header('Access-Control-Allow-Headers', 'Authorization, X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Allow-Request-Method');
	res.header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
	res.header('Allow', 'GET, POST, OPTIONS');
	next();
});
// .env con información para acceder a la base de datos
const conexion = mysql.createPool({
    host: process.env.HOST,
    user: process.env.USER,
    password: process.env.PASSWORD,
    database: process.env.DATABASE,
});

var empresa;

app.listen(3002, () =>{
    console.log("CONEXIÓN ESTABLECIDA!!");
});


var query = "select cedula, nombre, apellido_paterno, apellido_materno, cargo, foto, fecha from ( "+
"select pos.puesto_id, p.nombre, p.apellido_materno, p.apellido_paterno, p.foto, pos.fecha, p.cedula "+
"from postulacion pos "+
"inner join (perfil p, puesto pues, pasante pas) " +
"on pos.pasante=p.cedula and pos.puesto_id=pues.puesto_id and p.cedula = pas.cedula "+
"where pos.estado != 2 and pas.estado != 2 and pues.vacantes > 0 "+
") ps "+
"inner join puesto p on ps.puesto_id = p.puesto_id ";

var prioquery = "select nombre, apellido_materno, cargo, promedio, fecha, foto, cedula from ( "+
"select u.promedio, post.fecha, post.puesto_id, c.cedula, p.nombre, p.apellido_paterno, "+
"p.apellido_materno, p.foto from curriculum c "+
"inner join (postulacion post, universidad u, perfil p, puesto pues) "+
"on (post.pasante=c.cedula and c.cedula=u.cedula and c.cedula=p.cedula "+
"and p.cedula = pas.cedula and post.puesto_id=pues.puesto_id) "+
"where post.estado != 2 and pas.estado != 2 and pues.vacantes > 0 "+
") pox "+
"inner join puesto p on pox.puesto_id = p.puesto_id ";



app.get('/', (req, res) =>{
    res.json("Pantalla principal -> Ingrese a uno de los links para poder ver: orden"+
    "por prioridad (localhost:3001/prioridad) o filtrar los postulantes (localhost:3001/filtro)");
});

app.get('/info', (req, res) =>{
    var infqy = "select p.*, u.promedio, u.ingreso, i.nombre as nombre_i, i.direccion as direccion_i, i.telefono as telefono_i, c.expectativa, c.ultimo_ingreso from perfil p "+
    "inner join (curriculum c, universidad u, institucion i) "+
    "on (p.cedula = c.cedula and p.cedula = u.cedula and u.universidad_id = i.institucion_id) "+
    "where p.cedula = " + req.query.cargo;
    obtenerDatos(conexion, infqy, (resultado) => {
        res.json(resultado);
    });
});

app.post('/info', (req, res, next) =>{
    var infqy = "select p.*, u.promedio, u.ingreso, i.nombre as nombre_i, i.direccion as direccion_i, i.telefono as telefono_i, c.expectativa, c.ultimo_ingreso from perfil p "+
    "inner join (curriculum c, universidad u, institucion i) "+
    "on (p.cedula = c.cedula and p.cedula = u.cedula and u.universidad_id = i.institucion_id) "+
    "where p.cedula = " + req.query.cargo;
    obtenerDatos(conexion, infqy, (resultado) => {
        res.json(resultado);
    });
});

app.get('/filtro', (req, res) =>{
    var qy;
    switch (req.query.cargo){
        case 'BD':
            qy = query + " where cargo = 'ADMINISTRADOR(A) DE BASE DE DATOS'";
            break;
        case 'DW':
            qy = query + " where cargo = 'DESARROLLADOR(A) WEB'";
            break;
        case 'CONT':
            qy = query + " where cargo = 'CONTADOR(A)'";
            break;
        default:
            qy = query;
            break;
    }
    obtenerDatos(conexion, qy, (resultado) => {
        res.json(resultado);
    });
});

app.post('/filtro', (req, res, next) =>{
    var qy;
    switch (req.query.cargo){
        case 'BD':
            qy = query + " where cargo = 'ADMINISTRADOR(A) DE BASE DE DATOS'";
            break;
        case 'DW':
            qy = query + " where cargo = 'DESARROLLADOR(A) WEB'";
            break;
        case 'CONT':
            qy = query + " where cargo = 'CONTADOR(A)'";
            break;
        default:
            qy = query;
            break;
    }
    obtenerDatos(conexion, qy, (resultado) => {
        res.json(resultado);
    });
});

app.post('/prioridad', (req, res, next) =>{
    var qy;
    switch (req.query.cargo){
        case 'BDP1':
            qy = prioquery  + " where cargo = 'ADMINISTRADOR(A) DE BASE DE DATOS' order by fecha asc";
            break;
        case 'DWP1':
            qy = prioquery  + " where cargo = 'DESARROLLADOR(A) WEB' order by fecha asc";
            break;
        case 'CONTP1':
            qy = prioquery  + " where cargo = 'CONTADOR(A)' order by fecha asc";
            break;
        case 'TP1':
            qy = prioquery  + " order by fecha asc";
            break;
        case 'BDP2':
            qy = prioquery  + " where cargo = 'ADMINISTRADOR(A) DE BASE DE DATOS' order by promedio desc";
            break;
        case 'DWP2':
            qy = prioquery  + " where cargo = 'DESARROLLADOR(A) WEB' order by promedio desc";
            break;
        case 'CONTP2':
            qy = prioquery  + " where cargo = 'CONTADOR(A)' order by promedio desc";
            break;
        case 'TP2':
            qy = prioquery  + " order by promedio desc";
            break;
        case 'BDP':
            qy = prioquery  + " where cargo = 'ADMINISTRADOR(A) DE BASE DE DATOS' order by promedio desc";
            break;
        case 'DWP':
            qy = prioquery  + " where cargo = 'DESARROLLADOR(A) WEB' order by promedio desc";
            break;
        case 'CONTP':
            qy = prioquery  + " where cargo = 'CONTADOR(A)' order by promedio desc";
            break;
        default:
            qy = prioquery ;
            break;
    }
    obtenerDatos(conexion, qy, (resultado) => {
        res.json(resultado);
    });
});

app.get('/prioridad', (req, res) =>{
    var qy;
    switch (req.query.cargo){
        case 'BDP1':
            qy = prioquery  + " where cargo = 'ADMINISTRADOR(A) DE BASE DE DATOS' order by fecha asc";
            break;
        case 'DWP1':
            qy = prioquery  + " where cargo = 'DESARROLLADOR(A) WEB' order by fecha asc";
            break;
        case 'CONTP1':
            qy = prioquery  + " where cargo = 'CONTADOR(A)' order by fecha asc";
            break;
        case 'TP1':
            qy = prioquery  + " order by fecha asc";
            break;
        case 'BDP2':
            qy = prioquery  + " where cargo = 'ADMINISTRADOR(A) DE BASE DE DATOS' order by promedio desc";
            break;
        case 'DWP2':
            qy = prioquery  + " where cargo = 'DESARROLLADOR(A) WEB' order by promedio desc";
            break;
        case 'CONTP2':
            qy = prioquery  + " where cargo = 'CONTADOR(A)' order by promedio desc";
            break;
        case 'TP2':
            qy = prioquery  + " order by promedio desc";
            break;
        case 'BDP':
            qy = prioquery  + " where cargo = 'ADMINISTRADOR(A) DE BASE DE DATOS' order by promedio desc";
            break;
        case 'DWP':
            qy = prioquery  + " where cargo = 'DESARROLLADOR(A) WEB' order by promedio desc";
            break;
        case 'CONTP':
            qy = prioquery  + " where cargo = 'CONTADOR(A)' order by promedio desc";
            break;
        default:
            qy = prioquery ;
            break;
    }
    obtenerDatos(conexion, qy, (resultado) => {
        res.json(resultado);
    });
});
