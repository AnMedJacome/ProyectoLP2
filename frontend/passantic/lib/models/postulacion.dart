import 'package:flutter/material.dart';
import 'package:passantic/models/pasante.dart';

class Postulacion {
  final int id, estado,puestoid;
  final String fecha;
  final Pasante pasante;
  final String cargo;
  Postulacion(this.id, this.cargo, this.pasante, this.estado, this.fecha,this.puestoid);

}
