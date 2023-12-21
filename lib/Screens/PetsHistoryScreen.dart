import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api.path.dart';
import '../Colors.dart';
import '../Models/GetPetsModel.dart';
import '../Models/PetsHistoryModel.dart';
import 'BottomNavigationScreens/StoreScreen.dart';
import 'HistoryDetails.dart';

class PetsHistoryScreen extends StatefulWidget {
  final PetsData? model;
  PetsHistoryScreen({Key? key, this.model}) : super(key: key);

  @override
  State<PetsHistoryScreen> createState() => _PetsHistoryScreenState();
}

class _PetsHistoryScreenState extends State<PetsHistoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPetsHistory();
  }

  PetsHistoryModel? petsHistoryModel;
  getPetsHistory() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('user_id');
    var headers = {
      'Cookie': 'ci_session=cbfd3e39fd9fa52d0c4c335651ceab90ee507400'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.getBooking));
    request.fields
        .addAll({'pet_id': '${widget.model?.id}', 'user_id': '$userId'});
    print("pets history para ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse =
          PetsHistoryModel.fromJson(json.decode(finalResponse));
      setState(() {
        petsHistoryModel = jsonResponse;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  petsHistory(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: petsHistoryModel?.data?.length == null ||
              petsHistoryModel?.data?.length == ""
          ? const Center(
              child: CircularProgressIndicator(color: colors.primary))
          : ListView.builder(
             physics: BouncingScrollPhysics(),
            //  physics: const NeverScrollableScrollPhysics(),
              itemCount: petsHistoryModel?.data?.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Card(

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5,
                  child: Container(
                    //height: 110,
                  //  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: colors.white),
                    width: MediaQuery.of(context).size.width,
                    child:

                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                         crossAxisAlignment: CrossAxisAlignment.end,
                        children: [


                          // Container(
                          //   padding: EdgeInsets.all(5),
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(5),
                          //   ),
                          //   child: ClipRRect(
                          //     borderRadius: BorderRadius.circular(5),
                          //     child: petsHistoryModel?.data?[index].image ==
                          //                 null ||
                          //             petsHistoryModel?.data?[index].image == ""
                          //         ? Image.asset(
                          //             "assets/doctorone.png",
                          //             fit: BoxFit.fill,
                          //           )
                          //         : Image.network(
                          //             "${ApiServicves.imageUrl}${petsHistoryModel?.data?[index].image}",
                          //             // width: 100,
                          //             fit: BoxFit.fill,
                          //           ),
                          //   ),
                          // ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Vet's name: ",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Montserrat"),
                                  ),
                                  Text(
                                    petsHistoryModel?.data?[index].doctorName ==
                                                "" ||
                                            petsHistoryModel
                                                    ?.data?[index].doctorName ==
                                                null
                                        ? "Not Avaliable"
                                        : "${petsHistoryModel?.data?[index].doctorName}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Montserrat"),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  const Text("Date: ",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Montserrat")),
                                  Text(
                                    petsHistoryModel?.data?[index].date == "" ||
                                            petsHistoryModel
                                                    ?.data?[index].date ==
                                                null
                                        ? "Not Avaliable"
                                        : "${petsHistoryModel?.data?[index].date}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Montserrat"),
                                  ),
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
                                    petsHistoryModel?.data?[index].timeSlot ==
                                                "" ||
                                            petsHistoryModel
                                                    ?.data?[index].timeSlot ==
                                                null
                                        ? "Not Avaliable"
                                        : "${petsHistoryModel?.data?[index].timeSlot}",
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

                              // const SizedBox(
                              //   height: 8,
                              // ),
                              // Row(
                              //   children: [
                              //     const Text("Consultation Type: ", style: TextStyle(
                              //         fontSize: 14,
                              //         fontWeight: FontWeight.bold,fontFamily: "Montserrat"),
                              //     ),
                              //     petsHistoryModel?.data?[index].serviceType == "1" ?
                              //     const Text(
                              //       "Online",
                              //       style: TextStyle(
                              //           fontSize: 12,
                              //           fontWeight: FontWeight.w400,fontFamily: "Montserrat"),
                              //     ): Text("In Clinic")
                              //   ],
                              // ),
                              // const SizedBox(
                              //   height: 8,
                              // ),
                              // Row(
                              //   children: [
                              //     const Text("Clinic: ", style: TextStyle(
                              //         fontSize: 12,
                              //         fontWeight: FontWeight.bold,fontFamily: "Montserrat")),
                              //     Text(
                              //       "${petsHistoryModel?.data?[index].clinicName}",
                              //       style: const TextStyle(
                              //           fontSize: 12,
                              //           fontWeight: FontWeight.w400,fontFamily: "Montserrat"),
                              //     ),
                              //   ],
                              // ),
                              // const SizedBox(
                              //   height: 8,
                              // ),
                              // Row(
                              //   children: [
                              //     const Text("Date: ", style: TextStyle(
                              //         fontSize: 12,
                              //         fontWeight: FontWeight.bold, fontFamily: "Montserrat"),
                              //     ),
                              //     Text(
                              //       "${petsHistoryModel?.data?[index].createdAt}",
                              //       style: const TextStyle(
                              //           fontSize: 12,
                              //           fontWeight: FontWeight.w400, fontFamily: "Montserrat"),
                              //     ),
                              //   ],
                              // ),
                              // const SizedBox(
                              //   height: 5,
                              // ),




                            ],
                          ),
Column(
mainAxisAlignment: MainAxisAlignment.end,
  children: [


    Row(

      children: [

        SizedBox(width: MediaQuery.of(context).size.width/6,),
        Container(
         // width: MediaQuery.of(context).size.width * 0.6,
          //alignment: Alignment.bottomRight,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                            HistoryDetails(
                                model: petsHistoryModel
                                    ?.data?[index])));
            },
            child: Container(
              height: 30,
              width: 90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: colors.primary),
              child: const Center(
                child: Text("View Details",
                    style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                          fontFamily: "Montserrat",
                          color: colors.white)),
              ),
            ),
          ),
        ),
      ],
    )


  ],
)

                        ],



                      ),
                    ),
                  ),
                );
              }),
    );
  }

  @override
  Widget build(BuildContext context) {
     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xffFFFFFF), // navigation bar color
    statusBarColor: Color(0xffFFFFFF), // status bar color
  ));
    return Scaffold(
      backgroundColor: Color(0xfff5f6fb),
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Appointment History for ${widget.model?.username}",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: colors.black,
              fontSize: 15,
              fontFamily: "Montserrat"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [petsHistory(context)],
        ),
      ),
    );
  }
}