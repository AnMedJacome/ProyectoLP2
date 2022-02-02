import 'package:flutter/material.dart';
import 'package:passantic/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:passantic/utils/globals.dart' as globals;

class LoginBottomSheet extends StatefulWidget {
  @override
  _LoginBottomSheet createState() => _LoginBottomSheet();
}

class _LoginBottomSheet extends State<LoginBottomSheet> {
  final TextEditingController _controllerUser = TextEditingController();
  final PasswordInput _passwordInput = PasswordInput();
  makeAuth(String usuario, String clave) async {
    try {
      http.Response response = await http.post(
          Uri.parse('http://localhost:3001/users/auth'),
          body: {"usuario": usuario, "clave": clave});
      debugPrint(response.body);
      if (response.body == "Pasante") {
        globals.isLoggedIn = true;
        globals.usuario = usuario;
        Navigator.of(context).pushReplacementNamed("/homePasante");
      } else if (response.body == "Empresa") {
        globals.isLoggedIn = true;
        globals.usuario = usuario;
        Navigator.of(context).pushReplacementNamed("/home");
      } 
      else {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('ALERTA'),
            content: const Text('NO EXISTE EL USUARIO'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        /* ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                Text('NO EXISTE EL USUARIO', textAlign: TextAlign.center)));*/
      }
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
    return _content(context);
  }

  _content(context) {
    return Container(
      margin: EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 60),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "Iniciar sesión",
            style: TextStyle(
              fontSize: 22,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 16,
          ),
          TextField(
            controller: _controllerUser,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_rounded),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Ingrese su Usuario",
                labelText: "Usuario",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0))),
          ),
          SizedBox(
            height: 16,
          ),
          _passwordInput,
          SizedBox(
            height: 16,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 8, right: 8),
            child: ElevatedButton(
              onPressed: () {
                makeAuth(_controllerUser.text, _passwordInput.controller.text);
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.only(top: 16, bottom: 16),
                  textStyle: TextStyle(fontSize: 16, color: Colors.white),
                  primary: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              child: Text(
                "Ingresar",
                style: TextStyle(color: AppColors.text_dark),
              ),
            ),
          ),
        ],
      ),
    );
  }
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
