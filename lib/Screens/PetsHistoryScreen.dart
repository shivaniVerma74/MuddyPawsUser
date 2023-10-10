import 'dart:convert';
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
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.getBooking));
    request.fields.addAll({
      'pet_id': '${widget.model?.id}',
      'user_id': '$userId'
    });
    print("pets history para ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = PetsHistoryModel.fromJson(json.decode(finalResponse));
      setState(() {
        petsHistoryModel = jsonResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  petsHistory(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: petsHistoryModel?.data?.length == null || petsHistoryModel?.data?.length == "" ? const Center(child: CircularProgressIndicator(color: colors.primary)):
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
          itemCount: petsHistoryModel?.data?.length ?? 0,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              child: Container(
                height: 110,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: colors.white),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child:
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(9),
                          child: petsHistoryModel?.data?[index].image == null || petsHistoryModel?.data?[index].image == "" ? Image.asset("assets/doctorone.png", fit: BoxFit.fill,):
                          Image.network(
                            "${ApiServicves.imageUrl}${petsHistoryModel?.data?[index].image}",
                            // width: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text("Pet name: ", style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,fontFamily: "Montserrat"),
                                ),
                                Text(
                                  "${petsHistoryModel?.data?[index].petName}",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400, fontFamily: "Montserrat"),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                const Text("Pet Type: ", style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold, fontFamily: "Montserrat")),
                                Text(
                                  "${petsHistoryModel?.data?[index].petType}",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,fontFamily: "Montserrat"),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                const Text("Vet Name: ", style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold, fontFamily: "Montserrat")),
                                Text(
                                  "${petsHistoryModel?.data?[index].doctorName}",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,fontFamily: "Montserrat"),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5,),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryDetails(model: petsHistoryModel?.data?[index])));
                              },
                              child: Container(
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.primary),
                                  child: const Center(
                                      child: Text("View Details",
                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200, fontFamily: "Montserrat", color: colors.white)
                                      ),
                                  ),
                              ),
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
                      ),
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
        elevation : 0,
        backgroundColor: Colors.white,
        title: const Text("Pets History",
          style: TextStyle(fontWeight: FontWeight.w500, color: colors.black, fontSize: 15, fontFamily: "Montserrat"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            petsHistory(context)
          ],
        ),
      ),
    );
  }
}
