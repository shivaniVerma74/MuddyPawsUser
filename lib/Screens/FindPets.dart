import 'package:flutter/material.dart';

import 'BottomNavigationScreens/AppointmentDetailsUser.dart';
import 'BottomNavigationScreens/MoreScreen.dart';
import 'BottomNavigationScreens/PetCareScreen.dart';
import 'BottomNavigationScreens/StoreScreen.dart';

class FindPetStuff extends StatefulWidget {
  const FindPetStuff({Key? key}) : super(key: key);

  @override
  State<FindPetStuff> createState() => _FindPetStuffState();
}

class _FindPetStuffState extends State<FindPetStuff> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    Store(),
     // PetCare(),
    PetCare(),
     ThirdPage(),
    // AppointmentDetailsUser(),
   // AppointmentScreen(),
     FourthPage(),
    More(),

    // PetCare(),
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
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_information),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Pet Care',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'My Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'More',
          ),
        ],
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("jjddjdjdjdjjdwjdidkdnadknasdhasdn");
  }}
class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Center(child: Text("My Orders is empty",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
               ],
      ),
    );
  }}
class FourthPage extends StatefulWidget {
  @override
  State<FourthPage> createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Column(
        children: [
          Center(child: Text("Appointment is empty",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
        ],
      ),
    );
    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   body: SingleChildScrollView(
    //     child: Column(
    //       children: [
    //         SafeArea(
    //           child: Padding(
    //             padding: const EdgeInsets.all(12.0),
    //             child: Column(crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   // SizedBox(
    //                   //   height: MediaQuery.of(context).size.height / 12,
    //                   // ),
    //                   Container(
    //                     // padding: EdgeInsets.all(10),
    //                     // height: MediaQuery.of(context).size.height / 15,
    //                     // width: MediaQuery.of(context).size.width / 1.3,
    //                     decoration: BoxDecoration(
    //                         borderRadius: BorderRadius.circular(4), color: Colors.white),
    //                     child: Column(
    //                       children: [
    //                         SizedBox(
    //                           height: MediaQuery.of(context).size.height / 18,
    //                         ),
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.start,
    //                           children: [
    //                             InkWell(
    //                               onTap: () {
    //                                 Navigator.pop(context);
    //                               },
    //                               child: Icon(
    //                                 Icons.arrow_back_ios_new,
    //                                 size: 18,
    //                               ),
    //                             ),
    //                             SizedBox(
    //                               width: MediaQuery.of(context).size.width / 4,
    //                             ),
    //                             Text(
    //                               "Appointment Details",
    //                               style: TextStyle(
    //                                   fontSize: 17, fontWeight: FontWeight.bold),
    //                             ),
    //                           ],
    //                         ),
    //                         SizedBox(
    //                           height: MediaQuery.of(context).size.height / 18,
    //                         ),
    //                         Row(
    //                           children: [
    //                             Container(
    //                                 height: 170,
    //                                 width: 170,
    //                                 decoration: BoxDecoration(
    //                                   borderRadius: BorderRadius.circular(8),
    //                                 ),
    //                                 child: ClipRRect(
    //                                   borderRadius: BorderRadius.circular(14),
    //                                   child: Image.asset(
    //                                     "assets/images/doctor.jpg",
    //                                     fit: BoxFit.cover,
    //                                   ),
    //                                 )),
    //                             SizedBox(
    //                               width: MediaQuery.of(context).size.width / 22,
    //                             ),
    //                             Column(
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               children: [
    //                                 SizedBox(
    //                                   height: MediaQuery.of(context).size.height / 8,
    //                                 ),
    //                                 Text("Samantha",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
    //                                 Text("Smith",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
    //                               ],
    //                             ),
    //                           ],
    //                         ),
    //                         SizedBox(
    //                           height: MediaQuery.of(context).size.height / 40,
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //
    //                   Container(
    //                     child: Column(crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Text("Appointment on",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
    //                         SizedBox(
    //                           height: MediaQuery.of(context).size.height / 120,
    //                         ),
    //                         Text("12 June 2020 | 12:00 pm",style:TextStyle(fontWeight: FontWeight.w500)),
    //                         SizedBox(
    //                           height: MediaQuery.of(context).size.height / 20,
    //                         ),
    //                         Text("Appointment for",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
    //                         SizedBox(
    //                           height: MediaQuery.of(context).size.height / 120,
    //                         ),
    //                         Text("Pet Vaccination",style:TextStyle(fontWeight: FontWeight.w500)),
    //
    //                         SizedBox(
    //                           height: MediaQuery.of(context).size.height / 20,
    //                         ),
    //                         Text("Attachment",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
    //                         SizedBox(
    //                           height: MediaQuery.of(context).size.height / 120,
    //                         ),
    //                         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                           children: [
    //                             Text("report221220.pdf",style:TextStyle(fontWeight: FontWeight.w500)),
    //                             // SizedBox(
    //                             //   width: MediaQuery.of(context).size.width / 3,
    //                             // ),
    //                             Container(child: Row(
    //                               children: [
    //                                 Icon(Icons.visibility,color: Colors.blue,),
    //                                 Text("View",style: TextStyle(color: Colors.blue),),
    //                               ],
    //                             )),
    //
    //                           ],
    //                         ),
    //                       ],),
    //                   ),
    //
    //
    //                 ]),
    //           ),
    //         ),
    //         SizedBox(
    //           height: MediaQuery.of(context).size.height / 3.7,
    //         ),
    //         Row(
    //           children: [
    //             Expanded(
    //               child: Container(
    //                 width:  MediaQuery.of(context).size.width / 3,
    //                 height: MediaQuery.of(context).size.height / 14,
    //                 color: Colors.blue[100],
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                   children: [
    //                     Icon(Icons.close),
    //                     Text("Cancel"),
    //                   ],),
    //               ),
    //             ),
    //             // SizedBox(
    //             //   width: MediaQuery.of(context).size.width / 90,
    //             // ),
    //             Expanded(
    //               child: Container(
    //                 width:  MediaQuery.of(context).size.width / 3,
    //                 height: MediaQuery.of(context).size.height / 14,
    //                 color: Colors.blue,
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                   children: [
    //                     Icon(Icons.check),
    //                     Text("Accept"),
    //                   ],),
    //               ),
    //             ),
    //           ],
    //         ),
    //
    //       ],
    //     ),
    //   ),
    // );
  }}
class FifthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("fifth");
  }}