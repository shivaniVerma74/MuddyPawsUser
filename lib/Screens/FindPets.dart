import 'package:flutter/material.dart';

import 'BottomNavigationScreens/AppointmentDetailsUser.dart';
import 'BottomNavigationScreens/Account.dart';
import 'BottomNavigationScreens/PetCareScreen.dart';
import 'BottomNavigationScreens/StoreScreen.dart';
import 'MyAppointmentsUser.dart';

class FindPetStuff extends StatefulWidget {
  const FindPetStuff({Key? key}) : super(key: key);

  @override
  State<FindPetStuff> createState() => _FindPetStuffState();
}

class _FindPetStuffState extends State<FindPetStuff> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
      Store(),
    PetCare(),
    // MyAppointment(),
    // PetCare(),
    Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(child: _pages[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            print(index);
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_information),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Pet Care',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.calendar_today),
          //   label: 'Appointments',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
