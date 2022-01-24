import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passantic/constants/colors.dart';

class Registerview extends StatefulWidget {
  const Registerview({Key? key}) : super(key: key);

  @override
  _Registerview createState() => _Registerview();
}

class _Registerview extends State<Registerview> {
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black87,),
          onPressed: () => Navigator.of(context).pushReplacementNamed("/login"),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          "Registrar empresa",
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
                  ? () {Navigator.of(context).pushReplacementNamed("/home");
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
      title: const Text("Usuario de la empresa"),
      isActive: _currentStep >= 0,
      content: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20, top: 20),
            child: TextField(
              key: ValueKey("usuario"),
              controller: TextEditingController(text: ""),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_rounded),
                  labelText: "Usuario",
                  contentPadding:
                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Ingrese un usuario unico para usar la app",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0))),
            ),
          )
        ],
      ),
    ),
    Step(
      title: const Text("Contraseña"),
      isActive: _currentStep >= 0,
      content: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20, top: 20),
            child: TextField(
              key: ValueKey("clave"),
              controller: TextEditingController(text: ""),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  labelText: "Clave",
                  contentPadding:
                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Ingrese la contraseña",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0))),
            ),
          )
        ],
      ),
    ),
    Step(
      title: const Text("RUC de la empresa"),
      isActive: _currentStep >= 0,
      content: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20, top: 20),
            child: TextField(
              key: ValueKey("ruc"),
              controller: TextEditingController(text: ""),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.home_work),
                  labelText: "RUC",
                  contentPadding:
                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Ingrese el RUC de la empresa",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0))),
            ),
          )
        ],
      ),
    ),
    Step(
      title: const Text("Nombre de la empresa"),
      isActive: _currentStep >= 0,
      content: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20, top: 20),
            child: TextField(
              key: ValueKey("nombre"),
              controller: TextEditingController(text: ""),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.home_work),
                  labelText: "Nombre",
                  contentPadding:
                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Ingrese el nombre completo de la empresa",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0))),
            ),
          )
        ],
      ),
    ),

    Step(
      title: const Text("Correo"),
      isActive: _currentStep >= 0,
      content: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20, top: 20),
            child: TextField(
              key: ValueKey("correo"),
              controller: TextEditingController(text: ""),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: "Correo",
                  contentPadding:
                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Ingrese su correo",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0))),
            ),
          )
        ],
      ),
    ),
    Step(
      title: const Text("Telefono"),
      isActive: _currentStep >= 0,
      content: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20, top: 20),
            child: TextField(
              key: ValueKey("telefono"),
              controller: TextEditingController(text: ""),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  labelText: "Telefono",
                  contentPadding:
                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Ingrese su telefono",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0))),
            ),
          )
        ],
      ),
    ),
     Step(
      title: const Text("Descripción"),
      isActive: _currentStep >= 0,
      content: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20, top: 20),
            child: TextField(
              key: ValueKey("e_descripcion"),
              controller: TextEditingController(text: ""),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.fence_sharp),
                  labelText: "Descripción",
                  contentPadding:
                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Ingrese la descripción de la empresa",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0))),
            ),
          )
        ],
      ),
    ),
    Step(
      title: const Text("Dirección"),
      isActive: _currentStep >= 0,
      content: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20, top: 20),
            child: TextField(
              key: ValueKey("direccion"),
              controller: TextEditingController(text: ""),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.fence_sharp),
                  labelText: "Dirección",
                  contentPadding:
                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Ingrese la Dirección de la empresa",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0))),
            ),
          )
        ],
      ),
    ),
      Step(
      title: const Text("Página web"),
      isActive: _currentStep >= 0,
      content: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20, top: 20),
            child: TextField(
              key: ValueKey("sitio_web"),
              controller: TextEditingController(text: ""),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.fence_sharp),
                  labelText: "Sitio web",
                  contentPadding:
                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Ingrese el sitio web de la empresa",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0))),
            ),
          )
        ],
      ),
    )
  ];
}