import 'package:flutter/material.dart';
import 'package:passantic/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class RegisterBottomSheet extends StatefulWidget {
  @override
  _RegisterBottomSheet createState() => _RegisterBottomSheet();
}

class _RegisterBottomSheet extends State<RegisterBottomSheet> {

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
            "Registrarse como: ",
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
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 8, right: 8),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed("/registerPasante");
              },
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.only(top: 16, bottom: 16),
                  textStyle: TextStyle(fontSize: 16, color: Colors.white),
                  primary: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(Icons.business_center_rounded, size: 20,color: AppColors.text_dark),
                      ),
                      TextSpan(
                        text: "Pasante",
                        style: TextStyle(color: AppColors.text_dark),
                      )
                    ],
                  ),
                ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 8, right: 8),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("/register");
                },
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.only(top: 16, bottom: 16),
                    textStyle: TextStyle(fontSize: 16, color: Colors.white),
                    primary: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(Icons.business_rounded, size: 20,color: AppColors.text_dark),
                      ),
                      TextSpan(
                        text: "Empresa",
                        style: TextStyle(color: AppColors.text_dark),
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
