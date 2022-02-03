// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:passantic/constants/colors.dart';
import 'package:passantic/utils/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:passantic/ui/views/natalia/homeEmpresaView.dart';
import 'package:passantic/ui/views/natalia/homePasanteView.dart';
import 'dart:convert';
import 'dart:core';

class ServicioAndres extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Postulantes',
      debugShowCheckedModeBanner: false,
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
  String _dropdownFiltro = 'TODOS';
  String _dropdownPriori = 'NINGUNO';
  int _index = 0;
  List postulantes = [];

  getUsersFilter(String filtro) async {
    http.Response response = await http.post(Uri.parse("http://localhost:3002/filtro?cargo="+filtro+"&id="+globals.usuario));
    debugPrint(globals.usuario);
    var data = json.decode(response.body);
    setState(() {
      postulantes = data;
    });
  }

  getUsersPriori(String filtro) async {
    http.Response response = await http.post(Uri.parse("http://localhost:3002/prioridad?cargo="+filtro+"&id="+globals.usuario));
    var data = json.decode(response.body);
    setState(() {
      postulantes = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getUsersFilter("T");
  }

  void _mostrarInformacion(cedula) async{
    http.Response response = await http.post(Uri.parse("http://localhost:3002/info?cargo="+cedula.toString()));
    List postulante = json.decode(response.body);
    if(!postulante.isEmpty){
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
                      image: _convertirBlobAImagen(postulante[0]["foto"]).image,
                      fit: BoxFit.fill
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _createTitle("Número de cédula:", 14, TextAlign.left),
                    _createText("0"+postulante[0]["cedula"].toString(), 14, TextAlign.left, FontStyle.normal),
                    _createTitle("Nombre:", 14, TextAlign.left),
                    _createText(postulante[0]["nombre"], 14, TextAlign.left, FontStyle.normal),
                    _createTitle("Segundo Nombre:", 14, TextAlign.left),
                    _createText(postulante[0]["segundo_nombre"], 14, TextAlign.left, FontStyle.normal),
                    _createTitle("Apellido Paterno:", 14, TextAlign.left),
                    _createText(postulante[0]["apellido_paterno"], 14, TextAlign.left, FontStyle.normal),
                    _createTitle("Apellido Materno:", 14, TextAlign.left),
                    _createText(postulante[0]["apellido_materno"], 14, TextAlign.left, FontStyle.normal),
                    _createTitle("Sexo", 14, TextAlign.left),
                    _createText(postulante[0]["sexo"], 14, TextAlign.left, FontStyle.normal),
                    _createTitle("Fecha de Nacimiento", 14, TextAlign.left),
                    _createText(getDateInfo(postulante[0]["fechaNacimiento"]), 14, TextAlign.left, FontStyle.normal),
                    _createTitle("Dirección", 14, TextAlign.left),
                    _createText(postulante[0]["direccion"], 14, TextAlign.left, FontStyle.normal),
                    _createTitle("Teléfono", 14, TextAlign.left),
                    _createText("0"+postulante[0]["telefono"].toString(), 14, TextAlign.left, FontStyle.normal),
                    _createTitle("País de Nacimiento", 14, TextAlign.left),
                    _createText(postulante[0]["paisNacimiento"], 14, TextAlign.left, FontStyle.normal),
                    _createTitle("Nacionalidad", 14, TextAlign.left),
                    _createText(postulante[0]["nacionalidad"], 14, TextAlign.left, FontStyle.normal),
                    _createTitle("Promedio", 14, TextAlign.left),
                    _createText(postulante[0]["promedio"].toString(), 14, TextAlign.left, FontStyle.normal),
                    _createTitle("Ingreso", 14, TextAlign.left),
                    _createText(getDateInfo(postulante[0]["ingreso"]), 14, TextAlign.left, FontStyle.normal),
                    _createTitle("Nombre de Instituto", 14, TextAlign.left),
                    _createText(postulante[0]["nombre_i"], 14, TextAlign.left, FontStyle.normal),
                    _createTitle("Dirección de Instituto", 14, TextAlign.left),
                    _createText(postulante[0]["direccion_i"], 14, TextAlign.left, FontStyle.normal),
                    _createTitle("Teléfono de Instituto", 14, TextAlign.left),
                    _createText("0"+postulante[0]["telefono_i"].toString(), 14, TextAlign.left, FontStyle.normal),
                    _createTitle("Expectativa", 14, TextAlign.left),
                    _createText("0"+postulante[0]["expectativa"].toString(), 14, TextAlign.left, FontStyle.normal),
                    _createTitle("Último ingreso", 14, TextAlign.left),
                    _createText("0"+postulante[0]["ultimo_ingreso"].toString(), 14, TextAlign.left, FontStyle.normal),
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
  }
  
  String getDateInfo(String fecha){
    List<String> lfecha = fecha.split("T")[0].split("-");
    return lfecha[2]+"-"+lfecha[1]+"-"+lfecha[0];
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
          borderOnForeground: true,
          color: AppColors.mainColor,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    shape: BoxShape.circle,
                    color: Colors.white,
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
                  onPressed: () => _mostrarInformacion(postulantes[indice]["cedula"]),
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
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black87,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
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
                  value: _dropdownFiltro,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                  focusColor: AppColors.mainColor,
                  underline: Container(
                    height: 2,
                    color: AppColors.primaryColor,
                  ),
                  onChanged: (String? filtro) {
                    setState(() {
                      _dropdownFiltro = filtro!;
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
                  value: _dropdownPriori,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                  focusColor: AppColors.mainColor,
                  underline: Container(
                    height: 2,
                    color: AppColors.primaryColor,
                  ),
                  onChanged: (String? filtro) {
                    setState(() {
                      _dropdownPriori = filtro!;
                      switch (filtro+"-"+_dropdownFiltro){
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
              const Divider(color: Colors.black,),
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
              const Divider(color: Colors.black,),
            ],
          ),
          Expanded(
            child: _mostrarLista(),
          ),
        ],
      ),
    );
  }
}