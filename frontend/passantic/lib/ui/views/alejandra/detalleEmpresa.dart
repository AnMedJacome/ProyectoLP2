// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());
class AppColors {
  static MaterialColor mainColor = const MaterialColor(
    0xFFF3CC44,
    <int, Color>{
      50: Color(0xFFF3CC44),
      100: Color(0xFFF3CC44),
      200: Color(0xFFF3CC44),
      300: Color(0xFFF3CC44),
      400: Color(0xFFF3CC44),
      500: Color(0xFFF3CC44),
      600: Color(0xFFF3CC44),
      700: Color(0xFFF3CC44),
      800: Color(0xFFF3CC44),
      900: Color(0xFFF3CC44),
    },
  );

  //static const PrimaryColor = Color(0xFF0C4B8D);
  static const primaryColor = Color(0xFFF3CC44);

  static const Color yellow = Color(0xFFEEC415);
  static const Color green = Color(0xFF61BF33);
  static const Color orange = Color(0xFFE96B1A);
  static const Color red = Color(0xFFDF1919);
  static const Color background = Colors.white24;

  static const Color textlight = Colors.black87;
  static const Color textDark = Colors.white;

  // Shimmer Colors
  static final Color shimmerBackground = Colors.grey.shade300;
  static final Color shimmerBaseColor = Colors.grey.shade300;
  static final Color shimmerHighlightColor = Colors.grey.shade100;
}


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
      controller: ScrollController(keepScrollOffset: false),
      mainAxisSpacing: 10,
      crossAxisCount: 1,
      children: <Widget>[Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          children: <Widget>[
            InkWell (onTap: () {_mostrarAlerta("Información de la oferta","Se detalla la información de la oferta"); },
              child: Image.network('//upload.wikimedia.org/wikipedia/commons/thumb/2/20/13-04-05-Skoda_Museum_Mlad%C3%A1_Boleslav_by_RalfR-233.png/195px-13-04-05-Skoda_Museum_Mlad%C3%A1_Boleslav_by_RalfR-233.png',
                width: 100, height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 30,),
            const Text("SKODA",textAlign: TextAlign.center,),
            const SizedBox(width: 30,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[ElevatedButton(onPressed:() {}, child: const Text('Postular'),)],
            ),
          ],
        ),
        color: Colors.grey[100],
      ), Container(
        alignment: Alignment.centerLeft,
        child: const Text("Informacion"),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.25,),
        padding: const EdgeInsets.all(8.0),
        color: Colors.yellow[100],
      ), Container(
        alignment: Alignment.centerLeft,
        child: const Text("SOLIDA EXPERIENCIA A CARGO DE UNA JEFATURA EN EMPRESAS DE MANUFACTURA (DE PREFERENCIA AUTOMOTRICES) \n\nSOLIDOS CONOCIMIENTOS DE SISTEMAS DE GESTION DE CALIDAD Y SEGURIDAD INDUSTRIAL\n\nLIDERAZGO Y DESARROLLO DE EQUIPOS DE TRABAJO"),
        padding: const EdgeInsets.all(8.0),
        color: Colors.grey[100],
      ),Container(
        alignment: Alignment.centerLeft,
        child: const Text("Detalles"),
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
                  const SizedBox(width: 30,),
                ],
              )],
            ),
          ],
        ),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.25,),
        padding: const EdgeInsets.all(8.0),
      )],

    );
  }
}