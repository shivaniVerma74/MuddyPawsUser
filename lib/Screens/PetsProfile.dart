import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Api.path.dart';
import '../Colors.dart';
import '../Models/GetPetsModel.dart';

class PetsProfile extends StatefulWidget {
  const PetsProfile({Key? key}) : super(key: key);

  @override
  State<PetsProfile> createState() => _PetsProfileState();
}

class _PetsProfileState extends State<PetsProfile> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPets();
  }

  GetPetsModel? getpetsmodel;
  getPets() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('user_id');
    var headers = {
      'Cookie': 'ci_session=2b56b25790a6b3730de399acf97f00e2136c0f20'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.petProfiles));
    request.fields.addAll({
      'user_id': "${userId}"
    });
    print("get pets user id ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = GetPetsModel.fromJson(json.decode(finalResponse));
      setState(() {
        getpetsmodel = jsonResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  deletePets(index) async{
    var headers = {
      'Cookie': 'ci_session=f6fff50f24331e0bb1ed898cc8becc67b092089f'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.deleteProfile));
    request.fields.addAll({
      'id': '${getpetsmodel?.data?[index].id}'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      await getPets();
      Fluttertoast.showToast(msg: "Profile deleted success");
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
          title: const Text(
            'Pets Profile',
            style: TextStyle(color: Colors.black, fontSize: 17),
          ),
        ),
        body:
        Column(
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                child: getpetsmodel?.data?.length == null || getpetsmodel?.data?.length == "" ? Center(child: CircularProgressIndicator(color: colors.primary)):
                ListView.builder(
                  shrinkWrap: true,
                  // physics: AlwaysScrollableScrollPhysics(),
                  itemCount: getpetsmodel?.data?.length,
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
                                    child: getpetsmodel?.data?[index].image == null || getpetsmodel?.data?[index].image == "" ? Image.asset("assets/doctorone.png", fit: BoxFit.fill,):
                                    Image.network(
                                      "${ApiServicves.imageUrl}${getpetsmodel?.data?[index].image}",
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
                                        const Text("Name: ", style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                        Text(
                                          "${getpetsmodel?.data?[index].username}",
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
                                            "${getpetsmodel?.data?[index].petType}",
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
                                          const Text("Age: ", style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "${getpetsmodel?.data?[index].age}",
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  deletePets(index);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Expanded(child: Icon(Icons.delete, color: colors.black,)),
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
        ),
    );

  }
}
