import 'package:flutter/material.dart';
import 'package:passantic/models/postulacion.dart';
import 'package:passantic/ui/views/alejandra/opcionesPosulacion.dart';
import 'package:passantic/ui/views/andres/serviciosLista.dart';
import 'package:passantic/ui/views/login/login.dart';
import 'package:passantic/ui/views/natalia/homeEmpresa.dart';
import 'package:passantic/ui/views/natalia/homeEmpresaView.dart';
import 'package:passantic/ui/views/natalia/homePasanteView.dart';
import 'package:passantic/ui/views/natalia/puestoRegister.dart';
import 'package:passantic/ui/views/register/register_pasante_view.dart';
import 'package:passantic/ui/views/register/register_view.dart';
import 'package:passantic/ui/views/splash/splash.dart';

import 'datosPasante.dart';
class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashView());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginView());
      case '/register':
        return MaterialPageRoute(builder: (_) => Registerview());
      case '/registerPasante':
        return MaterialPageRoute(builder: (_) => RegisterPasanteview());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeView());
      case '/homePasante':
        return MaterialPageRoute(builder: (_) => HomePasanteView());
      case '/datosPasante':
        return MaterialPageRoute(builder: (_) => datosPasante());
      case '/pasante-view':
        Postulacion _postulacion = args as Postulacion;
        return MaterialPageRoute(builder: (_) => HomeEmpresa(_postulacion));
      case '/postulaciones':
        return MaterialPageRoute(builder: (_) => OpcionesPostulacion());
      default:
        return _errorRoute();
    }
  }
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Error"),
          centerTitle: true,
        ),
        body: const Center(
          child: Text("ERROR"),
        ),
      );
    });
  }
}