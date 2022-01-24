// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:passantic/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Postulantes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppColors.mainColor,
      ),
      home: const MyHomePage(title: 'Postulaciones'),
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
  late _GridView gv;

  getUsers() async{
    http.Response response = await http.get(Uri.http("localhost:3001", "/prioridad"));
    debugPrint(response.body);
  }

  @override
  void initState() {
    super.initState();
    gv = _GridView(context);
    //getUsers();
  }

  void _incrementCounter() {
    setState(() {
    });
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
                child: DropdownButton<String>(
                  iconEnabledColor: AppColors.mainColor,
                  value: dropdownValue,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                  underline: Container(
                    height: 2,
                    color: AppColors.mainColor,
                  ),
                  onChanged: (String? filtro) {
                    setState(() {
                      dropdownValue = filtro!;
                    });
                  },
                  items: <String>['Todos', 'Administrador(a) de base de datos', 'Contador(a)', 'Desarrollador(a) web']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left: 100, top: 20),
                      child: IconButton(
                        iconSize: 40,
                        onPressed: () => gv._mostrarAlerta("Priorizar Postulantes", "Este servicio orden según la prioridad escogida a los postulantes"),
                        icon: Icon(
                          Icons.assignment_late_sharp,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 190, top: 20),
                      child: IconButton(
                        iconSize: 40,
                        onPressed: () => {},
                        icon: Icon(
                          Icons.perm_contact_cal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              const Divider(color: Colors.grey,),
              const SizedBox(height: 10,),
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
              const SizedBox(height: 10,),
              const Divider(color: Colors.grey,),
            ],
          ),
          Expanded(
            child: gv.build(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}


class _GridView{
  final BuildContext context;

  const _GridView(this.context);
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

  GridView build(){
    return GridView.count(
      //scrollDirection: Axis.vertical,
      crossAxisSpacing: 10,
      childAspectRatio: 5,
      controller: new ScrollController(keepScrollOffset: false),
      mainAxisSpacing: 10,
      crossAxisCount: 1,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: <Widget>[
              Image.network(
                'https://media.istockphoto.com/photos/passport-picture-of-a-smiling-turkish-businesswoman-picture-id856599656?k=20&m=856599656&s=612x612&w=0&h=bIJ3aCa4vWB_-jFRTiPffYyUpw5uPpIHGDHEs4bjEqg=',
                width: 90,
                height: 90,
              ),
              const SizedBox(width: 30,),
              Text("Doménica\nEspín",textAlign: TextAlign.center,),
              const SizedBox(width: 30,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Cargo",textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic
                  ),),
                  Text("Contador(a)",textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),),
                ],
              ),
              const SizedBox(width: 30,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Envío de solicitud",textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic
                  ),),
                  Text("Dic-13-2021",textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),),
                ],
              ),
              const SizedBox(width: 20,),
              IconButton(onPressed: () => _mostrarAlerta("Información de postulante","Se detalla la información del postulante"), icon: const Icon(Icons.arrow_forward_ios))
            ],
          ),
          color: Colors.grey[100],
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: <Widget>[
              Image.network(
                'https://media.istockphoto.com/photos/portrait-of-a-young-professional-man-picture-id1086350530?k=20&m=1086350530&s=612x612&w=0&h=jm9UE1LXqdf5R8qEHqQO9Dfelztap08t78bZF6rloPg=',
                width: 90,
                height: 90,
              ),
              const SizedBox(width: 30,),
              Text("Jonathan\nAndrade",textAlign: TextAlign.center,),
              const SizedBox(width: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Cargo",textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic
                  ),),
                  Text("Administrador(a)\nde base de datos",textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),),
                ],
              ),
              const SizedBox(width: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Envío de solicitud",textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic
                  ),),
                  Text("Dic-24-2021",textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),),
                ],
              ),
              const SizedBox(width: 20,),
              IconButton(onPressed: () => _mostrarAlerta("Información de postulante","Se detalla la información del postulante"), icon: const Icon(Icons.arrow_forward_ios))
            ],
          ),
          color: Colors.grey[100],
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: <Widget>[
              Image.network(
                'https://media.istockphoto.com/photos/portrait-of-a-german-businessman-with-beard-picture-id480286744?k=20&m=480286744&s=612x612&w=0&h=5DDcUmTGneOREWsaL3p3AUypJa3Jk_-N9juIOhLW6XQ=',
                width: 90,
                height: 90,
              ),
              const SizedBox(width: 30,),
              Text("Jorge\nMartínez",textAlign: TextAlign.center,),
              const SizedBox(width: 30,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Cargo",textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic
                  ),),
                  Text("Contador(a)",textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),),
                ],
              ),
              const SizedBox(width: 30,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Envío de solicitud",textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic
                  ),),
                  Text("Dic-28-2021",textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),),
                ],
              ),
              const SizedBox(width: 20,),
              IconButton(onPressed: () => _mostrarAlerta("Información de postulante","Se detalla la información del postulante"), icon: const Icon(Icons.arrow_forward_ios))
            ],
          ),
          color: Colors.grey[100],
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: <Widget>[
              Image.network(
                'https://media.istockphoto.com/photos/passport-picture-of-a-woman-with-dark-hair-and-blouse-picture-id477815446?k=20&m=477815446&s=612x612&w=0&h=phiQ0HhhxnLdXlIXJ0xU5sd9IQ5lXERa84BmSCERpZQ=',
                width: 90,
                height: 90,
              ),
              const SizedBox(width: 30,),
              Text("Sabrina\nLópez",textAlign: TextAlign.center,),
              const SizedBox(width: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Cargo",textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic
                  ),),
                  Text("Desarrollador(a)\nweb",textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),),
                ],
              ),
              const SizedBox(width: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Envío de solicitud",textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic
                  ),),
                  Text("Ene-03-2021",textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),),
                ],
              ),
              const SizedBox(width: 20,),
              IconButton(onPressed: () => _mostrarAlerta("Información de postulante","Se detalla la información del postulante"), icon: const Icon(Icons.arrow_forward_ios))
            ],
          ),
          color: Colors.grey[100],
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: <Widget>[
              Image.network(
                'https://media.istockphoto.com/photos/passport-picture-businesswoman-with-brown-hair-picture-id856479974?k=20&m=856479974&s=612x612&w=0&h=2a6E9509zCKLZkC9FoaAwaiC0DlPXUoN_46P3Un_xKk=',
                width: 90,
                height: 90,
              ),
              const SizedBox(width: 30,),
              Text("Francisca\nBarahona",textAlign: TextAlign.center,),
              const SizedBox(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Cargo",textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic
                  ),),
                  Text("Administrador(a)\nde base de datos",textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),),
                ],
              ),
              const SizedBox(width: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Envío de solicitud",textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic
                  ),),
                  Text("Ene-05-2021",textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),),
                ],
              ),
              const SizedBox(width: 20,),
              IconButton(onPressed: () => _mostrarAlerta("Información de postulante","Se detalla la información del postulante"), icon: const Icon(Icons.arrow_forward_ios))
            ],
          ),
          color: Colors.grey[100],
        ),
      ],

    );
  }
}