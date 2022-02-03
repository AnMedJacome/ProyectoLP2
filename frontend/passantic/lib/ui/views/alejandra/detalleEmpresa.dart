// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:passantic/constants/colors.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oferta',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppColors.mainColor,
      ),
      home: const MyHomePage(title: 'Postulacion'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dropdownValue = 'Todos';  

  getUsers() async{
    http.Response response = await http.get(Uri.http("localhost:3001", "/prioridad"));
    debugPrint(response.body);
  }

  @override
  void initState() {
    super.initState();    
    //getUsers();
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

  void _mostrarAlerta(titulo, contenido){
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
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: const <Widget>[
          IconButton(onPressed: null, icon: Icon(Icons.help, size: 25,color: Colors.black45,),)
        ],
      ),
      body: Column(
        children: <Widget>[Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child:Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          children: <Widget>[
            InkWell (onTap: () {_mostrarAlerta("Información de la oferta","Se detalla la información de la oferta"); },
              child: Image.network('//upload.wikimedia.org/wikipedia/commons/thumb/2/20/13-04-05-Skoda_Museum_Mlad%C3%A1_Boleslav_by_RalfR-233.png/195px-13-04-05-Skoda_Museum_Mlad%C3%A1_Boleslav_by_RalfR-233.png',
                width: 100, height: 100,
                fit: BoxFit.cover,
              ),
            ),
            //const SizedBox(width: 30,),
            const Text("SKODA",textAlign: TextAlign.center,),
            //const SizedBox(width: 30,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[ElevatedButton(onPressed:() {}, child: const Text('Postular'),)],
            ),
          Container(
        alignment: Alignment.centerLeft,
        child: _createTitle("Informacion",15,TextAlign.left),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.25,),
        padding: const EdgeInsets.all(8.0),
        color: Colors.yellow[100],
      ),Container(
        alignment: Alignment.centerLeft,
        child: const Text("SOLIDA EXPERIENCIA A CARGO DE UNA JEFATURA EN EMPRESAS DE MANUFACTURA (DE PREFERENCIA AUTOMOTRICES) \n\nSOLIDOS CONOCIMIENTOS DE SISTEMAS DE GESTION DE CALIDAD Y SEGURIDAD INDUSTRIAL\n\nLIDERAZGO Y DESARROLLO DE EQUIPOS DE TRABAJO"),
        padding: const EdgeInsets.all(8.0),
            height: 100,
        color: Colors.grey[100],
      ),Container(
        alignment: Alignment.centerLeft,
        child: _createTitle("Detalles",15,TextAlign.left),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.25,),
        padding: const EdgeInsets.all(8.0),
        color: Colors.yellow[100],
      ),Container(
        alignment: Alignment.centerLeft,
        child: Column(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const <Widget>[Icon(Icons.access_time_outlined), Text("Publicado el 10/12/2021")],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const <Widget>[Icon(Icons.monetization_on_sharp), Text("Salario: \$500")],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const <Widget>[Icon(Icons.monitor), Text("Modalidad: Presencial")],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const <Widget>[Icon(Icons.grading_sharp ), Text("Experiencia: 1 año")],
                  ),                 
                ],
              )],
            ),
          ],
        ),
        
        padding: const EdgeInsets.all(8.0),
      )],
        ),
        color: Colors.grey[100],
      )),
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


