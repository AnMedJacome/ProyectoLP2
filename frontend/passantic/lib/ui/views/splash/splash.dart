import 'dart:async';

import 'package:flutter/material.dart';
import 'package:passantic/utils/util.dart';
import 'package:passantic/constants/colors.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashView createState() => _SplashView();
}

class _SplashView extends State<SplashView> {
  Timer? _delaySplash;

  @override
  void initState() {
    super.initState();
    _delaySplash = Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed("/login");
    });
  }

  @override
  void dispose() {
    super.dispose();
    _delaySplash!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Util.sizeScreen(context: context).width * 0.40,
              height: Util.sizeScreen(context: context).width * 0.40,
              child: Icon(Icons.group_work, color: AppColors.text_light,size: 150,),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "PASSANTIC APP",
              style: TextStyle(
                  fontSize: 32,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
