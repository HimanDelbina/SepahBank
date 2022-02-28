import 'package:flutter/material.dart';

import 'login.dart';




class Logo extends StatefulWidget {
   const Logo({Key? key}) : super(key: key);
  @override
  _LogoState createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) =>const Login()));
    });
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: myHeight,
        width: myWidth,
        child: Center(
          child: Image.asset(
            "assets/logo1.png",
            height: 250.0,
          ),
        ),
      ),
    );
  }
}
