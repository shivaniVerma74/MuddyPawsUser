import 'dart:async';

import 'package:flutter/material.dart';
import 'package:muddypawsuser/Screens/FindPets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Auth/LoginScreen.dart';
import 'BottomNavigationScreens/StoreScreen.dart';

// import 'Auth/LoginScreen.dart';
String? finalOtp;
class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    //  Timer(Duration(seconds: 3), () {
    //   Navigator.pushNamed(context, "login");
    // });
     getValidation();
    super.initState();
  }


  Future getValidation() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? user_id = sharedPreferences.getString('user_id');
    print("user id in  splash screen ${user_id}");
    finalOtp = user_id;
    _navigateToHome();
  }

  _navigateToHome() {
    Future.delayed(const Duration(milliseconds:  0),() {
      if (finalOtp == null || finalOtp ==  '') {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Login()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const FindPetStuff()));
      }
    },);
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
