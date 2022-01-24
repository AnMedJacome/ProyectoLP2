import 'package:flutter/material.dart';
import 'package:passantic/constants/colors.dart';
import 'package:passantic/utils/util.dart';

import 'login_bottom_sheet_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginView createState() => _LoginView();
}

class _LoginView extends State<LoginView> {
  String _imageBackground = "backgroundImage.jpeg";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.55), BlendMode.darken),
                  image: AssetImage("assets/images/" + _imageBackground),
                  fit: BoxFit.fitHeight),
            ),
            child: _bodyLogin()));
  }

  Widget _bodyLogin() {
    return SingleChildScrollView(
      child: Container(
          height: Util.sizeScreen(context: context).height,
          child: Padding(
            padding:
            const EdgeInsets.only(left: 16, right: 16, top: 48, bottom: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(height: 300),
                const Text(
                  "PassanticApp",
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Container(height: 16),
                const Text(
                  "Aplicación de pasantías",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Container(height: 8),
                const Text(
                  "Encuentra tu trabajo ideal",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                Spacer(flex: 1),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _onLoginTap,
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.only(top: 16, bottom: 16),
                        textStyle: TextStyle(fontSize: 16, color: Colors.white),
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    child: Text(
                      "Iniciar Sesión",
                      style: TextStyle(color: AppColors.text_light),
                    ),
                  ),
                ),
                Container(height: 20),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed("/register");
                      /*ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('FALTA')));*/
                    },
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.only(top: 16, bottom: 16),
                        textStyle: TextStyle(fontSize: 16, color: Colors.white),
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    child: Text(
                      "Registrarse",
                      style: TextStyle(color: AppColors.text_light),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void _onLoginTap() {
    Util.showBottomSheet(context: context, bottomSheet: LoginBottomSheet());
  }
}
