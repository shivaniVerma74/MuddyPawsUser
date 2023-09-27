import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
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
import '../../Models/NearByDoctorModel.dart';
import '../../Models/SliderModel.dart';
import '../CommonSlider.dart';
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

  String? user_name;
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    userName();
    getSlider();
    getUserCurrentLocation();
    _getAddressFromLatLng();
    getPermission();
    getCat();
    getDoctors();
    nearByDoctor();
    // getAddress();
  }

  userName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_name = preferences.getString('user_name');
    print("userr nameee isss ${user_name}");
  }

  SliderModel? sliderModel;
  getSlider() async {
    var headers = {
      'Cookie': 'ci_session=0cf63e88dc9696a9e530c2d1044d3a508b661523'
    };
    var request = http.Request('POST', Uri.parse(ApiServicves.getSliderImages));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print("this is a response===========>${result}");
      final finalResult = SliderModel.fromJson(json.decode(result));
      print("this is a response===========>${finalResult}");
      setState(() {
        sliderModel = finalResult;
      });
    } else {
      print(response.reasonPhrase);
    }
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
        getDoctors();
      } else {
        Fluttertoast.showToast(msg: "${finalResult.error}");
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  GetDoctorModel? getDoctorModel;
  getDoctors() async {
    var headers = {
      'Cookie': 'ci_session=a606f47d62f270c5c80b9415ef655e928d2d15fa'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.getDoctorByCatid));
    request.fields.addAll({
      'cat_id': currentIndex == 1 ? "1" : "2",
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

  NearByDoctorModel? nearByDoctorModel;
  nearByDoctor() async {
    var headers = {
      'Cookie': 'ci_session=a606f47d62f270c5c80b9415ef655e928d2d15fa'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.getDoctorByCatid));
    request.fields.addAll({
      "latitude": homelat.toString(),
      "longitude": homeLong.toString()
    });
    print("category id in doctor api ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult = NearByDoctorModel.fromJson(json.decode(finalResponse));
      print("responsee ${finalResult}");
      setState(() {
        nearByDoctorModel = finalResult;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }
  void getPermission() async {
    if (await Permission.location.isGranted) {
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

  int _currentPost = 0;
  _CarouselSlider1() {
    return
      CarouselSlider(
      options: CarouselOptions(
          onPageChanged: (index, result) {
            setState(() {
              _currentPost = index;
            });
          },
          viewportFraction: 1.0,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          autoPlayAnimationDuration: const Duration(milliseconds: 500),
          enlargeCenterPage: false,
          scrollDirection: Axis.horizontal,
          height: 150.0),
        items: sliderModel?.data?.map((item) {
        return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: CommonSlider(
              file: item.image.toString(),
            ),
        );
      }).toList(),
    );
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
                  width: MediaQuery.of(context).size.width/30,
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
              height: MediaQuery.of(context).size.height/30,
            ),
            user_name == null || user_name == ""? const Text("---"):
            Text(
              "$user_name",
              style: const TextStyle(color: colors.black, fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height/60,
            ),
            SizedBox(
              //height: 200,
              width: double.maxFinite,
              child: sliderModel == null
                  ? const Center(
                child: CircularProgressIndicator(
                  color: colors.primary,
                ),
              ): _CarouselSlider1(),
            ),
            SizedBox(height: 10),
            // CustomTextFormField(
            //   name: 'textform',
            //   width: double.infinity,
            //   Icon: Icons.search,
            //   hint: "Search Doctors",
            // ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height/20,
            // ),
            customTabbar(context),
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
              height: MediaQuery.of(context).size.height/50,
            ),
            const Text(
              "Near By Doctors",
              style: TextStyle(
                  color: colors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height/50,
            ),
            nearByDoctorModel?.data?.length == null || nearByDoctorModel?.data?.length == "" ? const Center(child: CircularProgressIndicator(color: colors.white,),):
            Container(
              height: MediaQuery.of(context).size.height/1,
              child:
              ListView.builder(
                shrinkWrap: true,
                // physics: AlwaysScrollableScrollPhysics(),
                itemCount: nearByDoctorModel?.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: colors.white),
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          '${nearByDoctorModel?.data?[index].image}'),
                                      fit: BoxFit.cover),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15, left: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${nearByDoctorModel?.data?[index].username}',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                 Row(
                                   children: [
                                     Icon(Icons.location_on, color: colors.black, size: 15,),
                                     SizedBox(
                                       width:
                                       MediaQuery.of(context).size.width/2,
                                       child: Text(
                                         '${nearByDoctorModel?.data?[index].address}',
                                         maxLines: 3,
                                         overflow: TextOverflow.ellipsis,
                                         style: const TextStyle(
                                             fontWeight: FontWeight.bold,
                                             fontSize: 10),
                                       ),
                                     ),
                                   ],
                                 ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                 Row(
                                   children: [
                                     Text("Gender: ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                     Text(
                                       '${nearByDoctorModel?.data?[index].gender}',
                                       style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                     ),
                                   ],
                                 ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  int currentIndex = 1;
  customTabbar(BuildContext) {
    return Padding(
      padding: const EdgeInsets.only(left: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      print("jhhhhh########hh");
                      currentIndex = 1;
                       getDoctors();
                    });
                  },
                  child: Container(
                    height: 100,
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
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    print("jhhhhhhhhhhhhhhh");
                    setState(() {
                      currentIndex = 3;
                      getDoctors();
                    });
                  },
                  child: Container(
                    height: 110,
                    width: MediaQuery.of(context).size.width/4,
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
              ),
            ],
          ),
          currentIndex == 1 ? online() :currentIndex == 3 ? inClinic() : SizedBox.shrink(),

        ],
      ),
    );
  }


  online() {
    return
      ListView.builder(
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: getDoctorModel?.data?.length ?? 0,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorDetails(model: getDoctorModel?.data?[index])));
            },
            child: Card(
              elevation: 5,
              child: Container(
                height: 100,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: colors.white),
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      '${getDoctorModel?.data?[index].image}'),
                                  fit: BoxFit.cover)),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${getDoctorModel?.data?[index].username}',
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              SizedBox(
                                  width:
                                  MediaQuery.of(context).size.width/2,
                                  child: Text(
                                    '${getDoctorModel?.data?[index].address}',
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Row(
                                children: [
                                  Text("Gender: ", style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold
                                  ),),
                                  Text(
                                    '${getDoctorModel?.data?[index].gender}',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ),
          );
        },
      );
    //   Card(
    //   elevation: 5,
    //   child: Container(
    //     height: MediaQuery.of(context).size.height/7.0,
    //     child: ListView.builder(
    //       shrinkWrap: true,
    //       physics: const ScrollPhysics(),
    //       itemCount: getDoctorModel?.data?.length,
    //         itemBuilder: (c,index){
    //           return  InkWell(
    //             onTap: () {
    //               Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorDetails(model: getDoctorModel?.data?[index])));
    //             },
    //             child: Container(
    //               width: MediaQuery.of(context).size.width,
    //               height: MediaQuery.of(context).size.height * 0.1,
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(2),
    //                 color: Colors.white,
    //               ),
    //               child: Row(
    //                 crossAxisAlignment: CrossAxisAlignment.end,
    //                 children: [
    //                   Expanded(
    //                     flex: 2,
    //                     child: Container(
    //                       padding: const EdgeInsets.all(5),
    //                       // width: MediaQuery.of(context).size.width / 6.5,
    //                       // height: MediaQuery.of(context).size.height / 14,
    //                       decoration: BoxDecoration(
    //                         borderRadius: BorderRadius.circular(10),
    //                       ),
    //                       child: ClipRRect(
    //                         borderRadius: BorderRadius.circular(9),
    //                         child: Image.asset(
    //                           "${getDoctorModel?.data?[index].image}",
    //                           fit: BoxFit.fill,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   Expanded(
    //                     flex: 5,
    //                     child: Padding(
    //                       padding: const EdgeInsets.only(left: 5),
    //                       child: Column(
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           Text(
    //                             "${getDoctorModel?.data?[index].username}"
    //                                 "",
    //                             style: const TextStyle(fontSize: 14),
    //                           ),
    //                           const SizedBox(height: 3),
    //                           Row(children: [
    //                             const Text("Address: ", style: TextStyle(fontSize: 13),),
    //                             Text("${getDoctorModel?.data?[index].address}", style: TextStyle(fontSize: 13),)
    //                           ],)
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           );
    //         }
    //         ),
    //   ),
    // );
      // Container(
      //   // height: MediaQuery.of(context).size.height * 0.7,
      //   child: ListView.builder(
      //     //scrollDirection: Axis.vertical,
      //     shrinkWrap: true,
      //     itemCount: getDoctorModel?.data?.length,
      //     itemBuilder: (context, index) {
      //       return InkWell(
      //         onTap: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => DoctorDetails(model: getDoctorModel?.data?[index])),
      //           );
      //         },
      //         child: Container(
      //           // width: MediaQuery.of(context).size.width,
      //           // height: MediaQuery.of(context).size.height * 0.1,
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(2),
      //             color: Colors.white,
      //           ),
      //           child:
      //           Row(
      //             crossAxisAlignment: CrossAxisAlignment.end,
      //             children: [
      //               Expanded(
      //                 flex: 2,
      //                 child: Container(
      //                     padding: const EdgeInsets.all(5),
      //                     // width: MediaQuery.of(context).size.width / 6.5,
      //                     // height: MediaQuery.of(context).size.height / 14,
      //                     decoration: BoxDecoration(
      //                       borderRadius: BorderRadius.circular(10),
      //                     ),
      //                     child: ClipRRect(
      //                         borderRadius: BorderRadius.circular(9),
      //                         child: Image.asset(
      //                           "${getDoctorModel?.data?[index].image}",
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
      //                       Text(
      //                         "${getDoctorModel?.data?[index].username}"
      //                             "",
      //                         style: const TextStyle(fontSize: 14),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //               // Padding(
      //               //   padding: const EdgeInsets.only(right: 5, bottom: 10),
      //               //   child: Row(
      //               //     children: [
      //               //       RatingBar.builder(
      //               //         initialRating: 3,
      //               //         minRating: 1,
      //               //         direction: Axis.horizontal,
      //               //         allowHalfRating: true,
      //               //         itemCount: 5,
      //               //         itemSize: 13,
      //               //         itemBuilder: (context, _) => Icon(
      //               //           Icons.star,
      //               //           size: 5,
      //               //           color: Colors.amber,
      //               //         ),
      //               //         onRatingUpdate: (rating) {
      //               //           print(rating);
      //               //         },
      //               //       ),
      //               //       Text(
      //               //         '(120)',
      //               //         style: TextStyle(fontSize: 10),
      //               //       )
      //               //     ],
      //               //   ),
      //               // )
      //             ],
      //           ),
      //         ),
      //       );
      //     },
      //   ),
      // );
  }

  inClinic() {
    return ListView.builder(
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: getDoctorModel?.data?.length ?? 0,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorDetails(model: getDoctorModel?.data?[index])));
          },
          child: Card(
            elevation: 5,
            child: Container(
              height: 100,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: colors.white),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: NetworkImage(
                                  '${getDoctorModel?.data?[index].image}'),
                              fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${getDoctorModel?.data?[index].username}',
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        SizedBox(
                            width:
                            MediaQuery.of(context).size.width/2,
                            child: Text(
                              '${getDoctorModel?.data?[index].address}',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                            )),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            const Text("Gender: ", style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold
                            ),
                            ),
                            Text(
                              '${getDoctorModel?.data?[index].gender}',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                        // Text(
                        //   'Quantity : ${qty}',
                        //   style: TextStyle(
                        //     fontSize: 10,
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 6,
                        // ),
                        // SizedBox(
                        //   width: 10,
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
