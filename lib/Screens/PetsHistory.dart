import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Api.path.dart';
import '../Colors.dart';
import '../Models/GetPetsModel.dart';
import '../Models/PetsHistoryModel.dart';
import 'BottomNavigationScreens/StoreScreen.dart';
import 'FindPets.dart';
import 'PetsHistoryScreen.dart';
import 'PetsProfile.dart';

class PetsHistory extends StatefulWidget {
  final PetsData? model;
  const PetsHistory({Key? key, this.model}) : super(key: key);

  @override
  State<PetsHistory> createState() => _PetsHistoryState();
}

class _PetsHistoryState extends State<PetsHistory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPetsHistory();
    getPets();
  }

  PetsHistoryModel? petsHistoryModel;
  getPetsHistory() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('user_id');
    var headers = {
      'Cookie': 'ci_session=cbfd3e39fd9fa52d0c4c335651ceab90ee507400'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://developmentalphawizz.com/dr_vet_app/app/v1/api/get_booking'));
    request.fields.addAll({'pet_id': '$pet_id', 'user_id': '$userId'});
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

  GetPetsModel? getpetsmodel;

  getPets() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('user_id');
    var headers = {
      'Cookie': 'ci_session=2b56b25790a6b3730de399acf97f00e2136c0f20'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.petProfiles));
    request.fields.addAll({'user_id': "${userId}"});
    print("get pets user id ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = GetPetsModel.fromJson(json.decode(finalResponse));
      setState(() {
        getpetsmodel = jsonResponse;
      });
      for (var i = 0; i < getpetsmodel!.data!.length; i++) {
        pet_id = getpetsmodel?.data?[i].id;
        print('---states---id${pet_id}');
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  bool isLoading = false;

  deletePets(index) async {
    setState(() {
      isLoading = true;
    });
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
      setState(() {
        isLoading = false;
      });
      await getPets();
      Fluttertoast.showToast(msg: "Profile deleted success");
    }
    else {
      print(response.reasonPhrase);
    }
  }

  Widget petProfile(BuildContext context) {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xffFFFFFF), // navigation bar color
    statusBarColor: Color(0xffFFFFFF), // status bar color
  ));
    return SingleChildScrollView(
      child:  getpetsmodel?.error == true
          ? const Center(
        child: Text(
          "No Pets",
          style: TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontFamily: "Montserrat"),
             ),
           )
          : getpetsmodel?.data?.length == null || getpetsmodel?.data?.length == ""
          ? const Center(
        child: CircularProgressIndicator(
          color: colors.primary,
        ),
      )
          :
      ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
       // physics: BouncingScrollPhysics()
      // physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        itemCount: getpetsmodel?.data?.length ?? 0,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 3,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: Image.network(
                        "${ApiServicves.imageUrl}${getpetsmodel?.data?[index].image}",
                        width: 110,
                        // fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Pet Name: ",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Montserrat"),
                            ),
                            Text(
                              "${getpetsmodel?.data?[index].username}",
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
                            const Text("Pet Type: ",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Montserrat")),
                            Text(
                              "${getpetsmodel?.data?[index].petType}",
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
                            const Text(
                              "Pet Age: ",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Montserrat"),
                            ),
                            Text(
                              "${getpetsmodel?.data?[index].age}",
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
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PetsHistoryScreen(
                                            model: getpetsmodel?.data?[index])));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: colors.primary),
                                child: const Text(
                                  "View Appointment History",
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Montserrat"),
                                ),
                              ),
                            ),
                            SizedBox(width: 17,),
                            InkWell(
                              onTap: () {
                                deletePets(index);
                              },
                                child: Icon(Icons.delete, size: 25,))
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
    );
  }

  petsHistory(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: petsHistoryModel?.data?.length == null ||
              petsHistoryModel?.data?.length == ""
          ? Center(child: CircularProgressIndicator(color: colors.primary))
          : ListView.builder(
              itemCount: petsHistoryModel?.data?.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colors.white),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(9),
                              child: petsHistoryModel?.data?[index].image ==
                                          null ||
                                      widget.model?.image == ""
                                  ? Image.asset(
                                      "assets/doctorone.png",
                                      fit: BoxFit.fill,
                                    )
                                  : Image.network(
                                      "${ApiServicves.imageUrl}${petsHistoryModel?.data?[index].image}",
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
                                    const Text(
                                      "Name: ",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${petsHistoryModel?.data?[index].petName}",
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Text("Pet Type: ",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      "${petsHistoryModel?.data?[index].petType}",
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Date: ",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${petsHistoryModel?.data?[index].createdAt}",
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
                        ],
                      ),
                    ),
                  ),
                );
              }),
    );
  }

  int currentIndex = 1;
  customTabbar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = 1;
                  });
                },
                child: Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: [
                      const SizedBox(height: 6),
                      Text(
                        "My Pet's History",
                        style: TextStyle(
                            color: currentIndex == 1
                                ? colors.primary
                                : colors.black,
                            fontSize: 15,
                            fontFamily: "Montserrat"),
                      ),
                      Divider(
                        thickness: 4,
                        color: currentIndex == 1
                            ? colors.primary
                            : Colors.white.withOpacity(0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // InkWell(
            //   onTap: () {
            //     setState(() {
            //       // Navigator.of(context).push(MaterialPageRoute(
            //       //   builder: (context) => NextPage(),
            //       // ));
            //       currentIndex = 2;
            //     });
            //   },
            //   child: Container(
            //     height: 90,
            //     width: MediaQuery.of(context).size.width/3,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(5)),
            //     child: Padding(
            //       padding: const EdgeInsets.only(top: 1, left: 30, right: 10),
            //       child: Column(
            //         children: [
            //           const SizedBox(height: 5),
            //           Text(
            //             'Pets History',
            //             style: TextStyle(
            //               color: currentIndex == 2
            //                   ? colors.primary
            //                   : colors.black,
            //               fontSize: 16,
            //             ),
            //           ),
            //           Divider(
            //             thickness: 4,
            //             color: currentIndex == 2
            //                 ? colors.primary
            //                 : Colors.white.withOpacity(0),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
        currentIndex == 1 ? petProfile(context) : petsHistory(context)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: const Color(0xfff5f6fb),
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children:  [
                      InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FindPetStuff()));
                          },
                          child: const Icon(Icons.arrow_back_ios),
                      ),
                      const SizedBox(width: 85),
                      const Text(
                        "My Pet's History",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: colors.black,
                            fontFamily: "Montserrat"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                petProfile(context),
                // customTabbar(),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}