import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:muddypawsuser/Api.path.dart';
import 'package:muddypawsuser/Models/GetDoctorModel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as loc;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Colors.dart';
import '../../Custom/CustomGridView.dart';
import '../../Custom/CustomTextFormField.dart';
import '../../Models/GetCategoryModel.dart';
import '../DoctorDetails.dart';


class Store extends StatefulWidget {
  const Store({Key? key}) : super(key: key);

  @override
  State<Store> createState() => _StoreState();
}

var homelat;
var homeLong;

class _StoreState extends State<Store> {

  loc.LocationData? locationData;
  bool isLoading = false;
  List<Placemark>? placemark;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserCurrentLocation();
    _getAddressFromLatLng();
    getPermission();
    getCat();
    // getAddress();
  }

  GetCategoryModel? getCategoryModel;
 Future<GetCategoryModel?> getCat() async {
   SharedPreferences preferences = await SharedPreferences.getInstance();
    var headers = {
      'Cookie': 'ci_session=ad0f058f31400c2ae671314de31a221d9fa3cd7d'
    };
    var request = http.Request('POST', Uri.parse(ApiServicves.getCat));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult = GetCategoryModel.fromJson(json.decode(finalResponse));
      Fluttertoast.showToast(msg: "${finalResult.message}");
      setState(() {
        getCategoryModel = finalResult;
      });
      if (finalResult.error == false) {
        String? cat_id = finalResult.data?[0].id;
        preferences.setString('cat_id', cat_id ?? "");
        print("category id is ${cat_id}");

      } else {
        Fluttertoast.showToast(msg: "${finalResult.error}");
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  GetDoctorModel? getDoctorModel;
  getDoctors(String? catId) async {
    var headers = {
      'Cookie': 'ci_session=a606f47d62f270c5c80b9415ef655e928d2d15fa'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.getDoctorByCatid));
    request.fields.addAll({
      'cat_id': catId ?? "",
      "latitude": homelat.toString(),
      "longitude": homeLong.toString()
    });
    print("category id in doctor api ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult = GetDoctorModel.fromJson(json.decode(finalResponse));
      print("responsee ${finalResult}");
      setState(() {
        getDoctorModel = finalResult;
      });
    }
    else {
    print(response.reasonPhrase);
    }
  }

  void getPermission() async {
    if (await Permission.location.isGranted) {
      //get Location
      // getLocation();
      setState(() {
        getLocation();
      });
    } else {
      Permission.location.request();
    }
  }

  double lat = 0.0;
  double long = 0.0;
  Position? currentLocation;
  String? _currentAddress;

  Future getUserCurrentLocation() async {
    var status = await Permission.location.request();
    if(status.isDenied) {
      Fluttertoast.showToast(msg: "Permision is requiresd");
    }else if(status.isGranted){
      await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((position) {
        if (mounted)
          setState(() {
            currentLocation = position;
            homelat = currentLocation?.latitude;
            homeLong = currentLocation?.longitude;
          });
      });
      print("LOCATION===" +currentLocation.toString());
    } else if(status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  _getAddressFromLatLng() async {
    await getUserCurrentLocation().then((_) async {
      try {
        print("Addressss function");
        List<Placemark> p = await placemarkFromCoordinates(currentLocation!.latitude, currentLocation!.longitude);
        Placemark place = p[0];
        setState(() {
          _currentAddress = "${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}";
          //"${place.name}, ${place.locality},${place.administrativeArea},${place.country}";
          print("current addresssss nowwwww${_currentAddress}");
        });
      } catch (e) {
        print('errorrrrrrr ${e}');
      }
    });
  }

  void getLocation() async {
    setState(() {
      getAddress();
      isLoading = true;
    });
    getAddress();
    locationData = await loc.Location.instance.getLocation();
    setState(() {
      isLoading = false;
    });
  }

  void getAddress() async {
    if (locationData != null) {
      setState(() {
        isLoading = true;
      });
      placemark = await placemarkFromCoordinates(
          locationData!.latitude!, locationData!.longitude!);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height/50,
            ),
            Row(
              children: [
                InkWell(
                    onTap: () {
                      getAddress();
                    },
                    child: const Icon(
                      Icons.location_pin,
                      color: Colors.blue,
                    )),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 30,
                ),
                Text(
                  _currentAddress != null
                      ? _currentAddress!
                      : "please wait..",overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: colors.black,
                      fontSize: 15, overflow: TextOverflow.ellipsis
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            const Text(
              "Hello, Sam Smith",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 60,
            ),
            CustomTextFormField(
              name: 'textform',
              width: double.infinity,
              Icon: Icons.search,
              hint: "Search medicines",
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height/20,
            ),
            customTabbar(context, 1),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     const Text(
            //       "Shop by Category",
            //       style: TextStyle(
            //           color: Colors.grey, fontWeight: FontWeight.bold),
            //     ),
            //     TextButton(
            //         onPressed: () {
            //           // Navigator.push(context, MaterialPageRoute(builder: (context)=>Grid()));
            //         },
            //         child: const Text(
            //           "View all",
            //           style: TextStyle(color: Colors.blue),
            //         )),
            //   ],
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 10, right: 10),
            //   child: Column(
            //     children: [
            //       Container(
            //         height: MediaQuery.of(context).size.height / 7,
            //         // width: MediaQuery.of(context).size.width / 17,
            //         child: GridView.builder(
            //             scrollDirection: Axis.horizontal,
            //
            //             //physics: NeverScrollableScrollPhysics(),
            //
            //             itemCount: 18,
            //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //                 crossAxisCount: 1,
            //                 crossAxisSpacing: 5,
            //                 mainAxisSpacing: 1,
            //                 mainAxisExtent: 100),
            //             itemBuilder: (context, index) {
            //               return Card(
            //                 margin: EdgeInsets.all(4),
            //                 shape: RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.circular(30)),
            //                 child: InkWell(
            //                   onTap: () {
            //                     // Navigator.push(context, MaterialPageRoute(builder: (context)=>AllProduct()));
            //                   },
            //                   child: Container(
            //                     width: 20,
            //
            //                     // height:30,
            //
            //                     //  MediaQuery.of(context).size.height * 50,
            //
            //                     child: ClipRRect(
            //                         borderRadius: BorderRadius.circular(15),
            //                         child: Image.asset(
            //                           "assets/images/doctor.jpg",
            //                           fit: BoxFit.cover,
            //                         )),
            //                   ),
            //                 ),
            //               );
            //             }),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            const Text(
              "Doctors Near By",
              style: TextStyle(
                  color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.8,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white60,),
                    child: Row(
                      children: [
                        Container(
                            width:MediaQuery.of(context).size.width/6.5,
                            height:MediaQuery.of(context).size.height/14,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(9), color: Colors.white60,),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(9),
                                child: Image.asset("assets/images/doctor3.jpg",fit: BoxFit.cover,))),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Well Life Store",style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 90,
                            ),
                            Row(
                              children: const [
                                Icon(Icons.location_pin,size: 15,),
                                Text("Well Life Store",style: TextStyle(color:Colors.grey),),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 70,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.8,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white60,),

                    child: Row(
                      children: [
                        Container(

                            width:MediaQuery.of(context).size.width/6.5,
                            height:MediaQuery.of(context).size.height/14,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(9), color: Colors.white60,),

                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(9),
                                child: Image.asset("assets/images/doctor3.jpg",fit: BoxFit.cover,))),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Well Life Store",style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 90,
                            ),
                            Row(
                              children: [
                                Icon(Icons.location_pin,size: 15,),

                                Text("Well Life Store",style: TextStyle(color:Colors.grey),),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 170,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.8,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white60,),

                    child: Row(
                      children: [
                        Container(
                            width:MediaQuery.of(context).size.width/6.5,
                            height:MediaQuery.of(context).size.height/14,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(9), color: Colors.white60,),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(9),
                                child: Image.asset("assets/images/doctor3.jpg",fit: BoxFit.cover,))),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Well Life Store",style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: MediaQuery.of(context).size.height/90,
                            ),
                            Row(
                              children: const [
                                Icon(Icons.location_pin,size: 15),
                                Text("Well Life Store",style: TextStyle(color:Colors.grey),),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 70,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.8,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white60,),
                    child: Row(
                      children: [
                        Container(
                            width:MediaQuery.of(context).size.width/6.5,
                            height:MediaQuery.of(context).size.height/14,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(9), color: Colors.white60,),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(9),
                                child: Image.asset("assets/images/doctor3.jpg",fit: BoxFit.cover,))),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Well Life Store",style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 90,
                            ),
                            Row(
                              children: const [
                                Icon(Icons.location_pin,size: 15),
                                Text("Well Life Store",style: TextStyle(color:Colors.grey),),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  int currentIndex = 1;
  customTabbar(BuildContext, int) {
    return Padding(
      padding: const EdgeInsets.only(left: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = 1;
                    getDoctors(getCategoryModel?.data?[int].id);
                  });
                },
                child: Container(
                  height: 110,
                  width: MediaQuery.of(context).size.width/3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: [
                      const SizedBox(height: 6),
                      Text(
                        '${getCategoryModel?.data?[0].name}',
                        style: TextStyle(
                          color: currentIndex == 1
                              ? colors.primary
                              : colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                        ),
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
              InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = 3;
                    getDoctors(getCategoryModel?.data?[int].id);
                  });
                },
                child: Container(
                  height: 110,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    // color: currentIndex == 2
                    //     ? colors.primary
                    //     : Colors.white,
                    // border: Border.all(color: colors.primary),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 1, left: 30, right: 10),
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        Text(
                          '${getCategoryModel?.data?[1].name}',
                          style: TextStyle(
                            color: currentIndex == 3
                                ? colors.primary
                                : colors.black,
                            fontSize: 14, fontWeight: FontWeight.w600
                          ),
                        ),
                        Divider(
                          thickness: 4,
                          color: currentIndex == 3
                              ? colors.primary
                              : Colors.white.withOpacity(0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          currentIndex == 1
              ? online()
              : currentIndex == 3
              ? inClinic(): SizedBox()
        ],
      ),
    );
  }

  online(){
    return
      Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          itemCount: getDoctorModel?.data?.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DoctorDetails()),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.white,
                ),
                child:
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                          padding: EdgeInsets.all(5),
                          // width: MediaQuery.of(context).size.width / 6.5,
                          // height: MediaQuery.of(context).size.height / 14,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(9),
                              child: Image.asset(
                                "${getDoctorModel?.data?[index].image}",
                                fit: BoxFit.fill,
                              ))),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${getDoctorModel?.data?[index].username}",
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 5, bottom: 10),
                    //   child: Row(
                    //     children: [
                    //       RatingBar.builder(
                    //         initialRating: 3,
                    //         minRating: 1,
                    //         direction: Axis.horizontal,
                    //         allowHalfRating: true,
                    //         itemCount: 5,
                    //         itemSize: 13,
                    //         itemBuilder: (context, _) => Icon(
                    //           Icons.star,
                    //           size: 5,
                    //           color: Colors.amber,
                    //         ),
                    //         onRatingUpdate: (rating) {
                    //           print(rating);
                    //         },
                    //       ),
                    //       Text(
                    //         '(120)',
                    //         style: TextStyle(fontSize: 10),
                    //       )
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            );
          },
        ),
      );
  }

  inClinic() {
    return Text("innnnnnn");
  }
}
