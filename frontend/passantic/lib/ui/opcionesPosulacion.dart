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
        title: const Text("Postula"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Expanded(child: Center(child: GridView.count(padding: const EdgeInsets.all(10.0),
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,crossAxisCount: 2,
            children: [Column(children: [Image.network('//upload.wikimedia.org/wikipedia/commons/thumb/2/20/13-04-05-Skoda_Museum_Mlad%C3%A1_Boleslav_by_RalfR-233.png/195px-13-04-05-Skoda_Museum_Mlad%C3%A1_Boleslav_by_RalfR-233.png', height: 150,fit:BoxFit.fill),
              const Text("Jefe de ensambles Automotrices\n"),
              const Text("SOLIDA EXPERIENCIA A CARGO DE UNA JEFATURA EN EMPRESAS DE MANUFACTURA (DE PREFERENCIA AUTOMOTRICES)"),
              const ElevatedButton(onPressed: null,child: Text('Postular'),)
            ]),
              Column(children: [Image.network('//upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Volkswagen_logo_2019.svg/120px-Volkswagen_logo_2019.svg.png', height: 150,fit:BoxFit.fill),
                const Text("Operador de ensambles Automotrices\n"),
                const Text("En Indura, Grupo Air Products nos encontramos en búsqueda de un Operador de Mantenimiento de Cilindros."),
                const ElevatedButton(onPressed: null, child: Text('Postular'),)]),
            ],
          ))),],
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