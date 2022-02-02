import 'package:flutter/material.dart';
import 'package:passantic/constants/colors.dart';

class MenuPasante extends StatefulWidget {
  _MenuPasante createState() => _MenuPasante();
}

class _MenuPasante extends State<MenuPasante> {
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
        title: Text("MENU Pasante"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(80),
        margin: const EdgeInsets.only(left: 80,right: 80),
        child:Column(
          children: [
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("/datosPasante");
                },
                label: const Text('Actualizar datos'),
                icon: const Icon(Icons.person_pin_circle)),
            SizedBox(
              height: 75,
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed("/postulaciones");
              },
              label: const Text('Revisar postulaciones'),
              icon: const Icon(Icons.view_list_outlined),
            )
          ]))
,
    );
  }
}
