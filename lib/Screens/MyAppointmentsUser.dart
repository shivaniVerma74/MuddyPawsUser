import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:muddypawsuser/Api.path.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  myBooking()  async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('user_id');
    var headers = {
      'Cookie': 'ci_session=458ff185d8ae9dc1bae3ce1c2938a3eee4c53905'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.getBooking));
    request.fields.addAll({
      'user_id': "$userId"
    });
    print("user id is my apppp ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = MyBookingModel.fromJson(json.decode(finalResponse));
      setState(() {
        myBookingModel = jsonResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
          ),
          title: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const SearchScreen()));
            },
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const WalletScreen()));
              },
              child: const Text(
                'My Appointment',
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: myBookingModel?.error == true ? Center(child: Text("No Booking", style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500),),):
              Expanded(
                child: myBookingModel?.data?.length == null || myBookingModel?.data?.length == "" ? Center(child: CircularProgressIndicator(color: colors.primary,),):
                ListView.builder(
                  shrinkWrap: true,
                  // physics: AlwaysScrollableScrollPhysics(),
                  itemCount: myBookingModel?.data?.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: colors.white),
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child:
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(9),
                                    child: myBookingModel?.data?[index].image == null || myBookingModel?.data?[index].image == "" ? Image.asset("assets/doctorone.png", fit: BoxFit.fill,):
                                    Image.network(
                                      "${ApiServicves.imageUrl}${myBookingModel?.data?[index].image}",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(children: [
                                        const Text("Doctor Name: ", style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                        Text(
                                          "${myBookingModel?.data?[index].doctorName}",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          const Text("Pet Type: ", style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                          Text(
                                            "${myBookingModel?.data?[index].petType}",
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          const Text("Pet Name: ", style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "${myBookingModel?.data?[index].petName}",
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          const Text("Date Time: ", style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "${myBookingModel?.data?[index].date} ${myBookingModel?.data?[index].timeSlot}",
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight:FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          const Text("Payment Type: ", style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            height: 25,
                                            width: 80,
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.primary),
                                            child: Center(
                                              child: Text(
                                                "${myBookingModel?.data?[index].paymentType}",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: colors.white,
                                                    fontWeight:FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                // Card(
                //   elevation: 5,
                //   child: Container(
                //     child: ListView.builder(
                //       shrinkWrap: true,
                //       padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                //       itemCount: myBookingModel?.data?.length,
                //       itemBuilder: (context, index) {
                //         return Container(
                //           width: MediaQuery.of(context).size.width,
                //           height: MediaQuery.of(context).size.height * 0.2,
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(2),
                //             color: Colors.white,
                //           ),
                //           child: Row(
                //             crossAxisAlignment: CrossAxisAlignment.end,
                //             children: [
                //               Expanded(
                //                 flex: 2,
                //                 child: Container(
                //                     padding: EdgeInsets.all(5),
                //                     decoration: BoxDecoration(
                //                       borderRadius: BorderRadius.circular(10),
                //                     ),
                //                     child: ClipRRect(
                //                         borderRadius: BorderRadius.circular(9),
                //                         child: Image.network(
                //                           "${myBookingModel?.data?[index].image}",
                //                           fit: BoxFit.fill,
                //                         ),
                //                     ),
                //                 ),
                //               ),
                //               Expanded(
                //                 flex: 5,
                //                 child: Padding(
                //                   padding: const EdgeInsets.only(left: 5),
                //                   child: Column(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     crossAxisAlignment: CrossAxisAlignment.start,
                //                     children: [
                //                       Row(children: [
                //                         const Text("Doctor Name: ", style: TextStyle(
                //                             fontSize: 14,
                //                             fontWeight: FontWeight.bold)),
                //                         Text(
                //                           "${myBookingModel?.data?[index].doctorName}",
                //                           style: const TextStyle(
                //                               fontSize: 12,
                //                               fontWeight: FontWeight.w400),
                //                         ),
                //                       ],),
                //                       const SizedBox(
                //                         height: 5,
                //                       ),
                //                     Row(
                //                       children: [
                //                       const Text("Pet Type: ", style: TextStyle(
                //                           fontSize: 14,
                //                           fontWeight: FontWeight.bold)),
                //                       Text(
                //                         "${myBookingModel?.data?[index].petType}",
                //                         style: const TextStyle(
                //                             fontSize: 12,
                //                             fontWeight: FontWeight.w400),
                //                       ),
                //                     ],
                //                     ),
                //                       const SizedBox(
                //                         height: 5,
                //                       ),
                //                       Row(
                //                         children: [
                //                           const Text("Pet Name: ", style: TextStyle(
                //                               fontSize: 14,
                //                               fontWeight: FontWeight.bold),
                //                           ),
                //                           Text(
                //                             "${myBookingModel?.data?[index].petName}",
                //                             style: const TextStyle(
                //                                 fontSize: 12,
                //                                 fontWeight: FontWeight.w400),
                //                           ),
                //                         ],
                //                       ),
                //                       const SizedBox(
                //                         height: 5,
                //                       ),
                //                       Row(
                //                         children: [
                //                           const Text("Date Time: ", style: TextStyle(
                //                               fontSize: 14,
                //                               fontWeight: FontWeight.bold),
                //                           ),
                //                           Text(
                //                             "${myBookingModel?.data?[index].date} ${myBookingModel?.data?[index].timeSlot}",
                //                             style: const TextStyle(
                //                                 fontSize: 12,
                //                                 fontWeight:FontWeight.w400),
                //                           ),
                //                         ],
                //                       ),
                //                       const SizedBox(
                //                         height: 5,
                //                       ),
                //                       Row(
                //                         children: [
                //                           const Text("Payment Type: ", style: TextStyle(
                //                               fontSize: 14,
                //                               fontWeight: FontWeight.bold),
                //                           ),
                //                           Container(
                //                             height: 25,
                //                             width: 80,
                //                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.primary),
                //                             child: Center(
                //                               child: Text(
                //                                 "${myBookingModel?.data?[index].paymentType}",
                //                                 style: const TextStyle(
                //                                     fontSize: 12,
                //                                     color: colors.white,
                //                                     fontWeight:FontWeight.w400),
                //                               ),
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //
                //             ],
                //           ),
                //         );
                //       },
                //     ),
                //   ),
                // ),
              ),
            ),
          ],
        ));
  }
}