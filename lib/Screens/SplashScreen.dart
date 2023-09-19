import 'dart:async';

import 'package:flutter/material.dart';

// import 'Auth/LoginScreen.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 3), () {
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));});
      Navigator.pushNamed(context, "login");
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height/1,
        width: MediaQuery.of(context).size.width/1,
        child: Image.asset('assets/images/Group 165.png'),
      ),
    );
  }
}
