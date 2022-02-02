// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:passantic/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Postulantes',
      theme: ThemeData(
        primarySwatch: AppColors.mainColor,
      ),
      home: MyHomePage(title: 'Postulaciones'),
    );
  }
}

  void _mostrarAlerta(titulo, contenido, BuildContext context){
    showCupertinoDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(titulo),
        content: Text(contenido),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Ok',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dropdownFiltro = 'TODOS';
  String dropdownPriori = 'NINGUNO';
  List postulantes = [];

  getUsers(String page) async{
    http.Response response = await http.get(Uri.http("192.168.200.10:3001", page));
    var data = json.decode(response.body);
    setState(() {
      postulantes = data;
    });
  }

  getUsersFilter(String filtro) async {
    http.Response response = await http.post(Uri.parse("http://192.168.200.10:3001/filtro?cargo="+filtro));
    var data = json.decode(response.body);
    setState(() {
      postulantes = data;
    });
  }

  getUsersPriori(String filtro) async {
    http.Response response = await http.post(Uri.parse("http://192.168.200.10:3001/prioridad?cargo="+filtro));
    var data = json.decode(response.body);
    setState(() {
      postulantes = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getUsers("/filtro");
  }

  void _mostrarInformacion(postulante){
    showCupertinoDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Perfil de postulante"),
        content: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(bottom: 25.0),
                width: 120,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, style: BorderStyle.solid),
                  image: DecorationImage(
                    image: _convertirBlobAImagen(postulante["foto"]).image,
                    fit: BoxFit.fill
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _createTitle("Número de cédula:", 14, TextAlign.left),
                  _createText("0"+postulante["cedula"].toString(), 14, TextAlign.left, FontStyle.normal),
                  _createTitle("Nombre:", 14, TextAlign.left),
                  _createText(postulante["nombre"], 14, TextAlign.left, FontStyle.normal),
                  _createTitle("Apellido Paterno:", 14, TextAlign.left),
                  _createText(postulante["apellido_paterno"], 14, TextAlign.left, FontStyle.normal),
                  _createTitle("Apellido Materno:", 14, TextAlign.left),
                  _createText(postulante["apellido_materno"], 14, TextAlign.left, FontStyle.normal),
                  _createTitle("Puesto solicitado:", 14, TextAlign.left),
                  _createText(postulante["cargo"], 14, TextAlign.left, FontStyle.normal),
                ],
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Ok',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 20,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }

  Text _createText(String str, double size,TextAlign al, FontStyle fst){
    return Text(
      str,
      style: TextStyle(
        fontSize: size,
        fontStyle: fst,
      ),
      textAlign: al,
    );
  }

  Text _createTitle(String str, double size,TextAlign al){
    return Text(
      str,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
      textAlign: al,
    );
  }

  Image _convertirBlobAImagen(var blob){
    List<int> pic = blob["data"].cast<int>();
    Uint8List picBytes = Uint8List.fromList(pic);
    String picBase64 = new String.fromCharCodes(picBytes);
    var foto = base64.decode(picBase64);
    return Image(
      image: Image.memory(foto).image,
      fit: BoxFit.fitWidth,
    );
  }

  String getDate(int indice){
    List<String> fecha = postulantes[indice]["fecha"].split("T")[0].split("-");
    return fecha[2]+"-"+fecha[1]+"-"+fecha[0];
  }

  ListView _mostrarLista(){
    return ListView.builder(
      itemCount: postulantes.length,
      itemBuilder: (BuildContext context, int indice) {
        return Card(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: _convertirBlobAImagen(postulantes[indice]["foto"]).image,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "PASANTE:",
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: Text(
                        "${postulantes[indice]["nombre"]}\n${postulantes[indice]["apellido_paterno"]}\n${postulantes[indice]["apellido_materno"]}",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 80.0,
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "CARGO:",
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: 80.0,
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: Text(
                        //mostrarPuesto(indice),
                        postulantes[indice]["cargo"],
                        style: TextStyle(
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                        //overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "FECHA DE SOLICITUD:",
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: Text(
                        getDate(indice),
                        style: TextStyle(
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                        //overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () => _mostrarInformacion(postulantes[indice]),
                  icon: const Icon(Icons.arrow_forward_ios),
                )
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(onPressed: null, icon: const Icon(Icons.help, size: 25,color: Colors.black45,),)
        ],
      ),
      body: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 25.0),
                child: DropdownButton<String>(
                  iconEnabledColor: Colors.black,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 25,
                  value: dropdownFiltro,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                  focusColor: AppColors.mainColor,
                  onChanged: (String? filtro) {
                    setState(() {
                      dropdownFiltro = filtro!;
                      switch (filtro){
                        case "ADMINISTRADOR(A) DE BASE DE DATOS":
                          getUsersFilter("BD");
                          break;
                        case "CONTADOR(A)":
                          getUsersFilter("CONT");
                          break;
                        case "DESARROLLADOR(A) WEB":
                          getUsersFilter("DW");
                          break;
                        default:
                          getUsersFilter("T");
                          break;
                      }
                    });
                  },
                  items: <String>['TODOS', 'ADMINISTRADOR(A) DE BASE DE DATOS', 'CONTADOR(A)', 'DESARROLLADOR(A) WEB']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  isExpanded: true,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 25.0),
                child: DropdownButton<String>(
                  iconEnabledColor: Colors.black,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 25,
                  value: dropdownPriori,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                  focusColor: AppColors.mainColor,
                  onChanged: (String? filtro) {
                    setState(() {
                      dropdownPriori = filtro!;
                      switch (filtro+"-"+dropdownFiltro){
                        case "FECHA DE SOLICITUD-ADMINISTRADOR(A) DE BASE DE DATOS":
                         getUsersPriori("BDP1");
                          break;
                        case "FECHA DE SOLICITUD-CONTADOR(A)":
                         getUsersPriori("CONTP1");
                          break;
                        case "FECHA DE SOLICITUD-DESARROLLADOR(A) WEB":
                         getUsersPriori("DWP1");
                          break;
                        case "FECHA DE SOLICITUD-TODOS":
                         getUsersPriori("TP1");
                          break;
                        case "PROMEDIO ACTUAL DE UNIVERSIDAD-ADMINISTRADOR(A) DE BASE DE DATOS":
                         getUsersPriori("BDP2");
                          break;
                        case "PROMEDIO ACTUAL DE UNIVERSIDAD-CONTADOR(A)":
                         getUsersPriori("CONTP2");
                          break;
                        case "PROMEDIO ACTUAL DE UNIVERSIDAD-DESARROLLADOR(A) WEB":
                         getUsersPriori("DWP2");
                          break;
                        case "PROMEDIO ACTUAL DE UNIVERSIDAD-TODOS":
                         getUsersPriori("TP2");
                          break;
                        case "NINGUNO-ADMINISTRADOR(A) DE BASE DE DATOS":
                         getUsersPriori("BDP");
                          break;
                        case "NINGUNO-CONTADOR(A)":
                         getUsersPriori("CONTP");
                          break;
                        case "NINGUNO-DESARROLLADOR(A) WEB":
                         getUsersPriori("DWP");
                          break;
                        case "NINGUNO-TODOS":
                         getUsersPriori("N");
                          break;
                      }
                    });
                  },
                  items: <String>['NINGUNO', 'FECHA DE SOLICITUD', 'PROMEDIO ACTUAL DE UNIVERSIDAD']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  isExpanded: true,
                ),
              ),
              const Divider(color: Colors.grey,),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                    "Postulantes",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                ),
              ),
              const Divider(color: Colors.grey,),
            ],
          ),
          Expanded(
            child: _mostrarLista(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Inicio",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "Mensajería"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Perfil",
          ),
        ],
      ),
    );
  }
}