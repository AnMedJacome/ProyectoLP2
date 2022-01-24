import 'package:flutter/material.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        //brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'Principal'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children:[const Icon(Icons.arrow_back_ios), const Text("Datos previos")]),
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            label: 'Mensajes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Perfil',
          ),
        ],
        selectedItemColor: Colors.amber[800],
      ),
    );
  }
}