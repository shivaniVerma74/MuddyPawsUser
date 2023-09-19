import 'package:flutter/material.dart';

import 'Screens/Auth/LoginScreen.dart';
import 'Screens/Auth/RegisterScreen.dart';
import 'Screens/FindPets.dart';
import 'Screens/SplashScreen.dart';
import 'Screens/Support.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'splash',
      routes: {
        // 'new' : (context) => New(),
        'splash' : (context) => splashScreen(),
        'login' : (context) => Login(),
        'register' : (context) => Register(),
        // 'myAppointments' : (context) => MyAppointments(),
        // 'terms' : (context) => Terms(),
        // 'faq' : (context) => FaqScreen(),
        // 'myprofile' : (context) => MyProfile(),
         'support' : (context) => Support(),
        //'appointmentDetails' : (context) => AppointmentDetails(),
        'findPetStuff' : (context)=> FindPetStuff(),
      },
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
