import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeEmpresa extends StatefulWidget {
  _HomeEmpresa createState() => _HomeEmpresa();
}

class _HomeEmpresa extends State<HomeEmpresa> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textName = const TextStyle(fontSize: 35);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: Text("HOME"),
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
        drawer: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFF3CC44),
              ),
              child: Text('Empresa La favorita',
                  style: TextStyle(color: Colors.white, fontSize: 20))),
          ListTile(
              leading: const Icon(Icons.assessment_outlined),
              title: const Text('Crear postulación'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Postulación creada',
                        textAlign: TextAlign.right)));
              }),
          ListTile(
              leading: const Icon(Icons.assignment_turned_in_outlined),
              title: const Text('Revisar postulaciones'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content:
                        Text('Pasante aceptado', textAlign: TextAlign.right)));
              }),
          ListTile(
              leading: const Icon(Icons.message),
              title: const Text('Mensajes'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content:
                        Text('Mensaje enviado', textAlign: TextAlign.right)));
              }),
          ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed("/login");
              }),
        ])),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundColor: Colors.black,
                radius: 78.0,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg'),
                  radius: 75.0,
                ),
              ),
              Text(
                'Jonathan Andrade Ramirez',
                style: GoogleFonts.oswald(textStyle: textName),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 35),
              const Text(
                'Cargo: Administrador de base de datos',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 25),
              const Text(
                'Envío: Diciembre-13-2021',
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.green)))),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Pasante aceptado')));
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.red)))),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Pasante negado')));
                    })
              ]),
              SizedBox(height: 45),
              ElevatedButton(
                  child: Text("Revisar otros postulantes".toUpperCase(),
                      style: TextStyle(fontSize: 14)),
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFFF3CC44)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Color(0xFFF3CC44))))),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Cambiando de pasante...')));
                  })
            ],
          )
        ));
  }
}
