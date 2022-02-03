import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passantic/models/postulacion.dart';
import 'package:http/http.dart' as http;

class HomeEmpresa extends StatelessWidget {
  final Postulacion postulacion;
  HomeEmpresa(this.postulacion);
  String getDate() {
    List<String> fecha = postulacion.fecha.split("T")[0].split("-");
    return fecha[2] + "-" + fecha[1] + "-" + fecha[0];
  }
  @override
  Widget build(BuildContext context) {
    aceptarPasante() async {
      try {
        http.Response response = await http.put(Uri.parse(
            'http://localhost:3001/postulacion/aceptar/' +
                postulacion.id.toString()));
        http.Response response3 = await http.put(Uri.parse(
            'http://localhost:3001/puestos/aceptar/' +
                postulacion.puestoid.toString()));
        if (response.body == "Aceptado" && response3.body == "Aceptado") {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('NOTIFICACION'),
              content: const Text('PASANTE ACEPTADO'),
              actions: <Widget>[
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed("/home"),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('ALERTA'),
              content: const Text('ERROR AL ACEPTAR AL PASANTE'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } catch (e) {}
    }

    negarPasante() async {
      try {
        http.Response response = await http.put(Uri.parse(
            'http://localhost:3001/postulacion/negar/' +
                postulacion.id.toString()));
        if (response.body == "Negado") {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('NOTIFICACION'),
              content: const Text('PASANTE NEGADO'),
              actions: <Widget>[
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed("/home"),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('ALERTA'),
              content: const Text('ERROR AL NEGAR AL PASANTE'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } catch (e) {}
    }

    TextStyle textName = const TextStyle(fontSize: 35);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: Text("Revisar pasante"),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
            backgroundColor: const Color(0xFFF3CC44),
            actions: <Widget>[
              IconButton(
                  icon: const Icon(Icons.update),
                  tooltip: 'Actualizando',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Actualizando ventana')));
                  }),
            ]),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                  image: _convertirBlobAImagen(this.postulacion.pasante.foto)
                      .image,
                ),
              ),
            ),
            Text(
              this.postulacion.pasante.nombre +
                  " " +
                  this.postulacion.pasante.apellido_paterno +
                  " " +
                  this.postulacion.pasante.apellido_materno,
              style: GoogleFonts.oswald(textStyle: textName),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 35),
            Text(
              "Cargo: " + this.postulacion.cargo,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 25),
            Text(
              'Envío: ' + getDate(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 25),
            Container(
                width: MediaQuery.of(context).size.width * 0.75,
                color: Colors.blue[100],
                child: Column(children: [
                  Container(
                      //download_done
                      width: MediaQuery.of(context).size.width * 0.50,
                      color: Color(0xFFF3CC44),
                      child: Column(children: [
                        const Text(
                          'Revisión de pruebas',
                          textAlign: TextAlign.center,
                        )
                      ])),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Revisar hoja de vida",
                        ),
                        WidgetSpan(
                          child: Icon(Icons.download_done,
                              size: 20, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Revisar entrevista",
                        ),
                        WidgetSpan(
                          child: Icon(Icons.do_not_disturb,
                              size: 20, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "Revisar pruebas",
                        ),
                        WidgetSpan(
                          child: Icon(Icons.do_not_disturb,
                              size: 20, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ])),
            SizedBox(height: 45),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                  child: Text("Aceptar".toUpperCase(),
                      style: TextStyle(fontSize: 14)),
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.green)))),
                  onPressed: () {
                    aceptarPasante();
                  }),
              SizedBox(width: 25),
              ElevatedButton(
                  child: Text("Negar".toUpperCase(),
                      style: TextStyle(fontSize: 14)),
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red)))),
                  onPressed: () {
                    negarPasante();
                  })
            ]),
          ],
        )));
  }

  Image _convertirBlobAImagen(var blob) {
    List<int> pic = blob["data"].cast<int>();
    Uint8List picBytes = Uint8List.fromList(pic);
    String picBase64 = new String.fromCharCodes(picBytes);
    var foto = base64.decode(picBase64);
    return Image(
      image: Image.memory(foto).image,
      fit: BoxFit.fitWidth,
    );
  }
}
