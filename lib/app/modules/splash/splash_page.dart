import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app/modules/splash/splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  final SplashController _splash$ = Modular.get<SplashController>();

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      _splash$.getUserData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(size: 150.0),
      ),
    );
  }
}
