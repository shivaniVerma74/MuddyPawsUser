import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:muddypawsuser/Api.path.dart';
import 'package:muddypawsuser/Screens/FindPets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Colors.dart';
import '../Models/GetPetsModel.dart';
import '../Models/MyBookingModel.dart';
import 'BottomNavigationScreens/AppointmentDetailsUser.dart';
import 'Groomer.dart';
import 'WalletScreen.dart';

class MyAppointment extends StatefulWidget {
  const MyAppointment({super.key});

  @override
  State<MyAppointment> createState() => _MyAppointmentState();
}

class _MyAppointmentState extends State<MyAppointment> {
  @override
  void initState() {
    super.initState();
    myBooking();
  }

  MyBookingModel? myBookingModel;
  myBooking() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('user_id');
    var headers = {
      'Cookie': 'ci_session=458ff185d8ae9dc1bae3ce1c2938a3eee4c53905'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.getBooking));
    request.fields.addAll({'user_id': "$userId"});
    print("user id is my apppp ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = MyBookingModel.fromJson(json.decode(finalResponse));
      setState(() {
        myBookingModel = jsonResponse;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  var whatsNumber;
  final whatsapppBoxKey = GlobalKey();

  openwhatsapp(number) async {
    var whatsapp = "$number";
    var whatsappURl_android = "whatsapp://send?phone=" +
        whatsapp +
        "&text=Hello, I am messaging from Muddy,  Can we have chat? ";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";

    // for iOS phone only
    if (await canLaunch(whatappURL_ios)) {
      await launch(whatappURL_ios, forceSafariVC: false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: new Text("Whatsapp does not exist in this device")));
    }
    //   else {
    //   // android , web
    //   if (await canLaunch(whatsappURl_android)) {
    //     await launch(whatsappURl_android);
    //   } else {
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text("Whatsapp does not exist in this device")));
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
  //    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   systemNavigationBarColor: Color(0xfff5f6fb), // navigation bar color
  //   statusBarColor: Color(0xfff5f6fb), // status bar color
  // ));
 return Material(
      child: SafeArea(
          // appBar: AppBar(
          //   elevation: 0,
          //   backgroundColor: Colors.white,
          //   centerTitle: true,
          //   leading: IconButton(
          //       onPressed: () {
          //         Navigator.pop(context);
          //       },
          //       icon: const Icon(
          //         Icons.arrow_back_ios,
          //         color: Colors.black,
          //       ),
          //   ),
          //   title: const Text(
          //     'My Appointment',
          //     style: TextStyle(color: Colors.black, fontSize: 17),
          //   ),
          // ),
          child: SingleChildScrollView(
            child: Column(
              children: [
               Container(
                 // color: Color(0xfff5f6fb),
                 child: Padding(
                   padding: const EdgeInsets.all(15.0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => FindPetStuff()));
                              },
                                child: const Icon(Icons.arrow_back_ios),
                            ),
                          const SizedBox(width: 80),
                          const Text(
                           "My Appointments",
                           style: TextStyle(
                             fontSize: 15,
                             fontWeight: FontWeight.bold,
                             fontFamily: "Montserrat",
                           ),
                         ),
                        ],
                        ),
                       SizedBox(
                         height: MediaQuery.of(context).size.height/79,
                       ),
                     ],
                   ),
                 ),
               ),
               const SizedBox(height: 10),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: myBookingModel?.error == true
                     ? const Center(
                         child: Text(
                           "No Appointments",
                           style: TextStyle(
                               fontSize: 15,
                               color: Colors.black,
                               fontWeight: FontWeight.w500,
                               fontFamily: "Montserrat"),
                         ),
                       )
                      : myBookingModel?.data?.length == null || myBookingModel?.data?.length == ""
                         ? const Center(
                             child: CircularProgressIndicator(
                               color: colors.primary,
                             ),
                           )
                         : Container(
                              // height: MediaQuery.of(context).size.height,
                           child: ListView.builder(
                               physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                              // physics: const NeverScrollableScrollPhysics(),
                               itemCount: myBookingModel?.data?.length,
                               itemBuilder: (context, index) {
                                 return Card(
                                   elevation: 5,
                                   shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(15.0),
                                   ),
                                   child: Container(
                                     padding: const EdgeInsets.symmetric(
                                         horizontal: 10, vertical: 10),
                                     decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(10),
                                         color: colors.white),
                                     width: MediaQuery.of(context).size.width,
                                     child: Row(
                                       crossAxisAlignment:
                                           CrossAxisAlignment.center,
                                       children: [
                                         Expanded(
                                           child: Container(
                                             decoration: BoxDecoration(
                                               borderRadius:
                                                   BorderRadius.circular(10),
                                             ),
                                             child: ClipRRect(
                                               borderRadius:
                                                   BorderRadius.circular(9),
                                               child: myBookingModel?.data?[index].image == null || myBookingModel?.data?[index].image == ""
                                                   ? Image.asset(
                                                       "assets/doctorone.png",
                                                       fit: BoxFit.fill,
                                                     )
                                                   : Image.network(
                                                       "${ApiServicves.imageUrl}${myBookingModel?.data?[index].image}",
                                                       // height: 200,
                                                       fit: BoxFit.fill,
                                                     ),
                                             ),
                                           ),
                                         ),
                                         Container(
                                           padding: EdgeInsets.only(left: 10),
                                           child: Column(
                                             mainAxisAlignment:
                                                 MainAxisAlignment.center,
                                             crossAxisAlignment:
                                                 CrossAxisAlignment.start,
                                             children: [
                                               Row(
                                                 children: [
                                                   const Text("Vet's Name: ",
                                                       style: TextStyle(
                                                           fontSize: 12,
                                                           fontWeight:
                                                               FontWeight.bold,
                                                           fontFamily:
                                                               "Montserrat")),
                                                   Text(
                                                     myBookingModel?.data?[index].doctorName == "" || myBookingModel?.data?[index].doctorName == null
                                                         ? "Not Available"
                                                         : "${myBookingModel?.data?[index].doctorName}",
                                                     style: const TextStyle(
                                                         fontSize: 12,
                                                         fontWeight:
                                                             FontWeight.w400,
                                                         fontFamily: "Montserrat"),
                                                   ),
                                                 ],
                                               ),
                                               const SizedBox(
                                                 height: 5,
                                               ),
                                               Row(
                                                 children: [
                                                   const Text("Pet Type: ",
                                                       style: TextStyle(
                                                           fontSize: 12,
                                                           fontWeight:
                                                               FontWeight.bold,
                                                           fontFamily:
                                                               "Montserrat"),
                                                   ),
                                                   Text(
                                                     myBookingModel?.data?[index].petType == "" || myBookingModel?.data?[index].petType == null
                                                         ? "Not Available"
                                                         : "${myBookingModel?.data?[index].petType}",
                                                     style: const TextStyle(
                                                         fontSize: 12,
                                                         fontWeight:
                                                             FontWeight.w400,
                                                         fontFamily: "Montserrat"),
                                                   ),
                                                 ],
                                               ),
                                               const SizedBox(
                                                 height: 5,
                                               ),
                                               Row(
                                                 children: [
                                                   const Text(
                                                     "Pet Name: ",
                                                     style: TextStyle(
                                                         fontSize: 12,
                                                         fontWeight:
                                                             FontWeight.bold,
                                                         fontFamily: "Montserrat"),
                                                   ),
                                                   Text(
                                                     myBookingModel?.data?[index].petName == "" || myBookingModel?.data?[index].petName == null
                                                         ? "Not Available"
                                                         : "${myBookingModel?.data?[index].petName}",
                                                     style: const TextStyle(
                                                         fontSize: 12,
                                                         fontWeight:
                                                             FontWeight.w400,
                                                         fontFamily: "Montserrat"),
                                                   ),
                                                 ],
                                               ),
                                               const SizedBox(
                                                 height: 5,
                                               ),
                                               Row(
                                                 children: const [
                                                   Text(
                                                     "Reason for Consultation: ",
                                                     style: TextStyle(
                                                         fontSize: 12,
                                                         fontWeight:
                                                             FontWeight.bold,
                                                         fontFamily: "Montserrat"),
                                                   ),
                                                   Text(
                                                     "Not Available",
                                                     style: TextStyle(
                                                         fontSize: 12,
                                                         fontWeight:
                                                             FontWeight.w400,
                                                         fontFamily: "Montserrat"),
                                                   ),
                                                 ],
                                               ),
                                               const SizedBox(
                                                 height: 5,
                                               ),
                                                   Row(
                                                     children: [
                                                   const Text("Date: ",
                                               style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Montserrat")),
                                                       Text(
                                            myBookingModel?.data?[index].date == "" || myBookingModel?.data?[index].date == null
                                           ? "Not Available"
                                           : "${myBookingModel?.data?[index].date}",
                                          style: const TextStyle(
                                           fontSize: 12,
                                           fontWeight: FontWeight.w400,
                                           fontFamily: "Montserrat"),
                                     ),
                                   ],
                                 ),
                                               const SizedBox(
                                                 height: 5,
                                               ),

                                               Row(
                                                 children: [
                                                   const Text("Appointment Type: ",
                                                       style: TextStyle(
                                                           fontSize: 12,
                                                           fontWeight: FontWeight.bold,
                                                           fontFamily: "Montserrat")),
                                                   myBookingModel?.data?[index].serviceType == '2' ?
                                                   Text(
                                                     myBookingModel?.data?[index].serviceType == "" || myBookingModel?.data?[index].serviceType == null
                                                         ? "Not Available"
                                                         : "Inclinic",
                                                     style: const TextStyle(
                                                         fontSize: 12,
                                                         fontWeight: FontWeight.w400,
                                                         fontFamily: "Montserrat"),
                                                   ): Text(
                                                     myBookingModel?.data?[index].serviceType == "" || myBookingModel?.data?[index].serviceType == null
                                                         ? "Not Available"
                                                         : "Online",
                                                     style: const TextStyle(
                                                         fontSize: 12,
                                                         fontWeight: FontWeight.w400,
                                                         fontFamily: "Montserrat"),
                                                   )
                                                 ],
                                               ),
                                 const SizedBox(
                                   height: 8,
                                 ),
                                 Row(
                                   children: [
                                     const Text("Time: ",
                                         style: TextStyle(
                                             fontSize: 12,
                                             fontWeight: FontWeight.bold,
                                             fontFamily: "Montserrat")),
                                     Text(
                                       myBookingModel?.data?[index].timeSlot ==
                                                   "" ||
                                              myBookingModel
                                                       ?.data?[index].timeSlot ==
                                                   null
                                           ? "Not Available"
                                           : "${myBookingModel?.data?[index].timeSlot}",
                                       style: const TextStyle(
                                           fontSize: 12,
                                           fontWeight: FontWeight.w400,
                                           fontFamily: "Montserrat"),
                                     ),
                                     ],
                                    ),
                                     const SizedBox(
                                    height: 5,
                                    ),
                                               // Row(
                                               //   children: [
                                               //     const Text(
                                               //       "Date/Time: ",
                                               //       style: TextStyle(
                                               //           fontSize: 12,
                                               //           fontWeight:
                                               //               FontWeight.bold,
                                               //           fontFamily: "Montserrat"),
                                               //     ),
                                               //     Text(
                                               //       "${myBookingModel?.data?[index].date} ${myBookingModel?.data?[index].timeSlot}",
                                               //       style: const TextStyle(
                                               //           fontSize: 12,
                                               //           fontWeight:
                                               //               FontWeight.w400,
                                               //           fontFamily: "Montserrat"),
                                               //     ),
                                               //   ],
                                               // ),
                                               // const SizedBox(
                                               //   height: 5,
                                               // ),
                                               Row(
                                                 mainAxisAlignment:
                                                     MainAxisAlignment
                                                         .spaceBetween,
                                                 children: [
                                                   myBookingModel?.data?[index].status == "1"
                                                       ? Container(
                                                           height: 30,
                                                           width: 90,
                                                           decoration: BoxDecoration(
                                                               borderRadius:
                                                                   BorderRadius
                                                                       .circular(
                                                                           5),
                                                               color:
                                                                   colors.primary),
                                                           child: const Center(
                                                             child: Text(
                                                               "Completed",
                                                               style: TextStyle(
                                                                   fontSize: 12,
                                                                   color: colors
                                                                       .white,
                                                                   fontWeight:
                                                                       FontWeight
                                                                           .w400,
                                                                   fontFamily:
                                                                       "Montserrat"),
                                                             ),
                                                           ),
                                                         )
                                                       : myBookingModel
                                                                   ?.data?[index]
                                                                   .status ==
                                                               "2"
                                                           ? Container(
                                                               height: 30,
                                                               width: 90,
                                                               decoration: BoxDecoration(
                                                                   borderRadius:
                                                                       BorderRadius
                                                                           .circular(
                                                                               5),
                                                                   color: colors.primary),
                                                               child: const Center(
                                                                 child: Text(
                                                                   "Rejected",
                                                                   style: TextStyle(
                                                                       fontSize:
                                                                           12,
                                                                       color: colors
                                                                           .white,
                                                                       fontWeight:
                                                                           FontWeight
                                                                               .w400,
                                                                       fontFamily:
                                                                           "Montserrat"),
                                                                 ),
                                                               ),
                                                             )
                                                           : SizedBox(),
                                                   myBookingModel?.data?[index]
                                                               .status ==
                                                           "0"
                                                       ? Container(
                                                           height: 30,
                                                           width: 90,
                                                           decoration: BoxDecoration(
                                                               borderRadius: BorderRadius.circular(5),
                                                               color: colors.primary),
                                                           child: const Center(
                                                             child: Text(
                                                               "Scheduled",
                                                               style: TextStyle(
                                                                   fontSize: 12,
                                                                   color: colors.white,
                                                                   fontWeight: FontWeight.w400,
                                                                   fontFamily: "Montserrat"),
                                                             ),
                                                           ),
                                                         )
                                                       : SizedBox(),
                                                   SizedBox(
                                                     width: MediaQuery.of(context).size.width/3.2,
                                                   ),
                                                   myBookingModel?.data?[index].serviceType == '3' ?
                                                   InkWell(
                                                     onTap: () {
                                                       openwhatsapp(myBookingModel?.data?[index].doctorMobile);
                                                     },
                                                     child: Padding(
                                                       padding: const EdgeInsets.only(top: 5, right: 5),
                                                       child: Image.asset(
                                                         "assets/images/whatsup.png",
                                                         height: 40,
                                                         width: 40,
                                                       ),
                                                     ),
                                                   ): SizedBox()
                                                 ],
                                               ),
                                             ],
                                           ),
                                         ),
                                       ],
                                     ),
                                   ),
                                 );
                               },
                             ),
                 ),
               ),
             ],
         )),
      ),
    );
  }
}