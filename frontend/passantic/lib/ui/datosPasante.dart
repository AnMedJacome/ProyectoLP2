import 'package:flutter/material.dart';
class datosPasante extends StatefulWidget {
  final String title;
  const datosPasante({
    Key? key,
    required this.title,
  }) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<datosPasante> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed("/login");
          },
          icon: Icon(Icons.logout),
        ),
        title: Row(children:[const Text("Datos previos")]),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Column(children:[Text("Cedula"), const TextField(obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Cedula del candidato',
              )),
            Text("Universidad"),
            const TextField(obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Universidad',
                )),
            Text("Expectativa"),
            const TextField(obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '\$',
                )),
            Text("Ultimo ingreso"),
            const TextField(obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '\$',
                )),
            Text("Fecha de nacimiento"),
            const TextField(obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '01/09/1998',
                )),
            ElevatedButton(

              onPressed: null,
              child: const Text('Avanzar'),
            ),],),
          ],
        ),
      ),

    );
  }
}