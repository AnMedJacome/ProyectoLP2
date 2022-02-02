import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passantic/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'package:passantic/utils/globals.dart' as globals;
import 'dart:convert';

class RegisterPuestoview extends StatefulWidget {
  const RegisterPuestoview({Key? key}) : super(key: key);

  @override
  _RegisterPuestoview createState() => _RegisterPuestoview();
}

class _RegisterPuestoview extends State<RegisterPuestoview> {
  final TextEditingController _controllerCargo = TextEditingController();
  final TextEditingController _controllerDescripcion = TextEditingController();
  final TextEditingController _controllerModalidad = TextEditingController();
  final TextEditingController _controllerConocimientos =
      TextEditingController();
  final TextEditingController _controllerFormacion = TextEditingController();
  final TextEditingController _controllerVacantes = TextEditingController();
  final TextEditingController _controllerSalario = TextEditingController();
  final TextEditingController _controllerArea = TextEditingController();
  int _currentStep = 0;
  List empresa=[];
  @override
  void initState() {
    getEmpresa();
    super.initState();
  }

  getEmpresa() async {
    try {
      http.Response response = await http
          .get(Uri.parse('http://localhost:3001/empresa/' + globals.usuario));
      setState(() {
        empresa = json.decode(response.body);
      });
      debugPrint(empresa[0]["ruc"]);
    } catch (e) {}
  }

  register() async {
    try {
      http.Response response =
          await http.post(Uri.parse('http://localhost:3001/puestos'), body: {
        "cargo": _controllerCargo.text,
        "empresa":empresa[0]["ruc"],
        "p_descripcion": _controllerCargo.text,
        "modalidad": _controllerDescripcion.text,
        "conocimiento_requerido": _controllerCargo.text,
        "formacion_requerida": _controllerDescripcion.text,
        "vacantes": _controllerCargo.text,
        "clave": _controllerDescripcion.text,
        "salario": _controllerCargo.text,
        "area_de_trabajo": _controllerDescripcion.text,
      });
      if (response.body == "creado") {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('NOTIFICACION'),
            content: const Text('PUESTO CREADO CON EXITO'),
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
            content: const Text('ERROR AL CREAR EL PUESTO'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          "Crear un nuevo puesto",
          style: TextStyle(color: AppColors.text_light),
        ),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: const Text(
              "Complete la siguiente información",
              style: TextStyle(
                  fontSize: 16,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Stepper(
              currentStep: _currentStep,
              type: StepperType.vertical,
              steps: _form(),
              onStepTapped: (step) => setState(() => _currentStep = step),
              onStepContinue: _currentStep == _form().length - 1
                  ? () {
                      register();
                    }
                  : () {
                      final isLastStep = _currentStep == _form().length - 1;
                      if (isLastStep) {
                        print("complete");
                      } else {
                        setState(() => _currentStep += 1);
                      }
                    },
              onStepCancel: _currentStep == 0
                  ? () {}
                  : () {
                      setState(() => _currentStep -= 1);
                    },
            ),
          ),
        ],
      ),
    );
  }

  List<Step> _form() => [
        Step(
          title: const Text("Cargo"),
          isActive: _currentStep >= 0,
          content: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20, top: 20),
                child: TextField(
                  key: ValueKey("cargo"),
                  controller: _controllerCargo,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_rounded),
                      labelText: "Cargo",
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Ingrese el cargo",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0))),
                ),
              )
            ],
          ),
        ),
        Step(
          title: const Text("Descripcion del puesto"),
          isActive: _currentStep >= 0,
          content: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20, top: 20),
                child: TextField(
                  key: ValueKey("p_descripcion"),
                  controller: _controllerDescripcion,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.home_work),
                      labelText: "Descripcion",
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Ingrese la descripcion del puesto",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0))),
                ),
              )
            ],
          ),
        ),
        Step(
          title: const Text("Modalidad"),
          isActive: _currentStep >= 0,
          content: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20, top: 20),
                child: TextField(
                  key: ValueKey("modalidad"),
                  controller: _controllerModalidad,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.home_work),
                      labelText: "Modalidad",
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Ingrese la modalidad",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0))),
                ),
              )
            ],
          ),
        ),
        Step(
          title: const Text("Conocimientos requeridos"),
          isActive: _currentStep >= 0,
          content: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20, top: 20),
                child: TextField(
                  key: ValueKey("conocimiento_requerido"),
                  controller: _controllerConocimientos,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: "Conocimientos requeridos",
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Ingrese los conocimientos requeridos",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0))),
                ),
              )
            ],
          ),
        ),
        Step(
          title: const Text("Formacion requerida"),
          isActive: _currentStep >= 0,
          content: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20, top: 20),
                child: TextField(
                  key: ValueKey("formacion_requerida"),
                  controller: _controllerFormacion,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      labelText: "Formacion requerida",
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Ingrese la formacion requerida",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0))),
                ),
              )
            ],
          ),
        ),
        Step(
          title: const Text("Vacantes"),
          isActive: _currentStep >= 0,
          content: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20, top: 20),
                child: TextField(
                  key: ValueKey("vacantes"),
                  controller: _controllerVacantes,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.fence_sharp),
                      labelText: "Vacantes",
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Ingrese el numero de vacantes",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0))),
                ),
              )
            ],
          ),
        ),
        Step(
          title: const Text("Salario"),
          isActive: _currentStep >= 0,
          content: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20, top: 20),
                child: TextField(
                  key: ValueKey("salario"),
                  controller: _controllerSalario,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.fence_sharp),
                      labelText: "Salario",
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Ingrese el salario, 0 si no aplica",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0))),
                ),
              )
            ],
          ),
        ),
        Step(
          title: const Text("Area de trabajo"),
          isActive: _currentStep >= 0,
          content: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20, top: 20),
                child: TextField(
                  key: ValueKey("area_de_trabajo"),
                  controller: _controllerArea,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.fence_sharp),
                      labelText: "Area de trabajo",
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Ingrese el area de trabajo",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0))),
                ),
              )
            ],
          ),
        )
      ];
}
