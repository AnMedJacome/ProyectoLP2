import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passantic/constants/colors.dart';
import 'package:http/http.dart' as http;

class RegisterPasanteview extends StatefulWidget {
  const RegisterPasanteview({Key? key}) : super(key: key);

  @override
  _RegisterPasanteview createState() => _RegisterPasanteview();
}

class _RegisterPasanteview extends State<RegisterPasanteview> {
  int _currentStep = 0;
  final TextEditingController _controllerUser = TextEditingController();
  final TextEditingController _controllerCedula = TextEditingController();
  final TextEditingController _controllerCarrera = TextEditingController();
  final TextEditingController _controllerCorreo = TextEditingController();
  final PasswordInput _passwordInput = PasswordInput();

  register(String usuario, String clave, String correo, String cedula,
      String carrera) async {
    try {
      http.Response response = await http.post(
          Uri.parse('http://localhost:3001/users'),
          body: {"usuario": usuario, "clave": clave, "correo": correo});
      if(response.body=="Usuario creado"){
          http.Response holaa = await http.post(
          Uri.parse('http://localhost:3001/pasante'),
          body: {"usuario": usuario, "cedula": cedula, "carrera": carrera, "estado":"1"});
          if(holaa.body=="Creado"){
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
            title: const Text('NOTIFICACION'),
            content: const Text('USUARIO CREADO CON EXITO'),
            actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pushReplacementNamed("/login"),
              child: const Text('OK'),
            ),
          ],
        ),
      );
       
          }else{
         showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('ALERTA'),
          content: const Text('ERROR AL CREAR EL USUARIO'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
          }

      }else{
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('ALERTA'),
          content: const Text('ERROR AL CREAR EL USUARIO'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      }
      /* ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                Text('NO EXISTE EL USUARIO', textAlign: TextAlign.center)));*/
    } catch (e) {
        debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
          onPressed: () => Navigator.of(context).pushReplacementNamed("/login"),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          "Registrar pasante",
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
                     register(_controllerUser.text, _passwordInput.controller.text, _controllerCorreo.text,_controllerCedula.text,
      _controllerCarrera.text);
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
          title: const Text("Usuario"),
          isActive: _currentStep >= 0,
          content: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20, top: 20),
                child: TextFormField(
                  key: ValueKey("usuario"),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 1) {
                      return 'Please enter name';
                    }
                  },
                  controller: _controllerUser,
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
                  child: _passwordInput)
            ],
          ),
        ),
        Step(
          title: const Text("Cedula"),
          isActive: _currentStep >= 0,
          content: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20, top: 20),
                child: TextField(
                  key: ValueKey("cedula"),
                  controller: _controllerCedula,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.home_work),
                      labelText: "Cedula",
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Ingrese su cedula",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0))),
                ),
              )
            ],
          ),
        ),
        Step(
          title: const Text("Carrrera"),
          isActive: _currentStep >= 0,
          content: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20, top: 20),
                child: TextField(
                  key: ValueKey("carrera"),
                  controller: _controllerCarrera,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.home_work),
                      labelText: "Carrera",
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Ingrese su carrera",
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
                  controller: _controllerCorreo,
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
      ];
}

class PasswordInput extends StatefulWidget {
  final TextEditingController controller = TextEditingController();

  String hint;
  String label;

  PasswordInput({
    this.hint = "Ingrese su Contraseña",
    this.label = "Contraseña",
  });

  @override
  _PasswordInput createState() => _PasswordInput();
}

class _PasswordInput extends State<PasswordInput> {
  bool _hiddenPassword = true;
  IconData _currentVisibility = Icons.visibility_off;

  @override
  void initState() {
    super.initState();
  }

  void _onTapVisibility() {
    setState(() {
      _hiddenPassword = !_hiddenPassword;
      _currentVisibility =
          (_hiddenPassword) ? Icons.visibility_off : Icons.visibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _hiddenPassword,
      controller: widget.controller,
      decoration: InputDecoration(
          prefixIcon: Icon(
            (_hiddenPassword) ? Icons.lock_rounded : Icons.lock_open_rounded,
          ),
          suffixIcon: IconButton(
            icon: Icon(_currentVisibility),
            onPressed: _onTapVisibility,
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: widget.hint,
          labelText: widget.label,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
  }
}
