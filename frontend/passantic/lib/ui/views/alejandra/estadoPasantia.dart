import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:passantic/constants/colors.dart';
class ObservarPostulacion extends StatefulWidget {
  final String title;

  const ObservarPostulacion({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ObservarPostulacion> {
  String dropdownValue = 'Todos';
  late _GridView gv;

  getUsers() async{
    http.Response response = await http.get(Uri.http("localhost:3001", "/prioridad"));
    debugPrint(response.body);
  }

  @override
  void initState() {
    gv = _GridView(context);
    super.initState();
    //getUsers();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed("/login");
          },
          icon: Icon(Icons.logout),
        ),
        actions: const <Widget>[
          IconButton(onPressed: null, icon: Icon(Icons.help, size: 25,color: Colors.black45,),)
        ],
      ),
      body: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              DropdownButton<String>(
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
                items: <String>['Todos', 'Negadas','En proceso']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),

              const SizedBox(height: 10,),
              const Divider(color: Colors.grey,),
              const SizedBox(height: 10,),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20),
                child: const Text(
                  "Postulaciones realizadas",
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
    );
  }
}


class _GridView{
  final BuildContext context;
  SingleChildScrollView mostrarEnproceso(){
    return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20),
          child: Row(
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
                children: const <Widget>[
                  Text("Cargo",textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic
                  ),),
                  Text("Jefe de ensambles automotrices",textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),),
                ],
              ),
              const SizedBox(width: 30,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[Text('En proceso', style: TextStyle(fontSize: 15,
        color: Colors.green[300],))],
              ),
            ],
          ),
          color: Colors.grey[100],
        ));
  }
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
      children: <Widget>[
       mostrarEnproceso(),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: <Widget>[
              InkWell (onTap: () {_mostrarAlerta("Información de la oferta","Se detalla la información de la oferta"); },
                child: Image.network('https://image.shutterstock.com/image-vector/picture-vector-icon-no-image-600w-1732584299.jpg',
                  width: 100, height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 30,),
              const Text("Soluciones Tributarias y Contables",textAlign: TextAlign.center,),
              const SizedBox(width: 30,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Text("Cargo",textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic
                  ),),
                  Text("Contador",textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),),
                ],
              ),
              const SizedBox(width: 30,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[Text('Negada', style: TextStyle(fontSize: 15,
        color: Colors.red[300],))],
              ),
            ],
          ),
          color: Colors.grey[100],
        )),
      ],

    );
  }
}
