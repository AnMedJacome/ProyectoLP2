import 'package:flutter/material.dart';
import 'package:passantic/constants/colors.dart';
import 'package:passantic/ui/routes.dart';

class PassanticApp extends StatefulWidget {
  const PassanticApp({Key? key}) : super(key: key);

  @override
  State<PassanticApp> createState() => _PassanticApp();
}

class _PassanticApp extends State<PassanticApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: AppColors.mainColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.light),
      initialRoute: '/',
      onGenerateRoute: Routes.generateRoute,
    );
  }


}