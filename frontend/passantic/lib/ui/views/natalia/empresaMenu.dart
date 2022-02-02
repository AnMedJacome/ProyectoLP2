import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passantic/constants/colors.dart';

class MenuEmpresa extends StatefulWidget {
  _MenuEmpresa createState() => _MenuEmpresa();
}

class _MenuEmpresa extends State<MenuEmpresa> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.logout),
        ),
        title: Text("MENU"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(80),
        margin: const EdgeInsets.only(left: 80,right: 80),
        child:Column(
          children: [
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("/registerPuesto");
                },
                label: const Text('Nueva postulacion'),
                icon: const Icon(Icons.fiber_new_outlined)),
            SizedBox(
              height: 75,
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed("/filtro");
              },
              label: const Text('Revisar postulaciones'),
              icon: const Icon(Icons.view_list_outlined),
            )
          ]))
,
    );
  }
}
