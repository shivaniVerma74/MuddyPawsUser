import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:muddypawsuser/Api.path.dart';
import 'package:muddypawsuser/Models/GetDoctorModel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Colors.dart';
import '../../Models/GetCategoryModel.dart';
import '../../Models/GetPetsModel.dart';
import '../../Models/NearByDoctorModel.dart';
import '../../Models/SliderModel.dart';
import '../CommonSlider.dart';
import '../DoctorDetails.dart';
import '../PetsProfile.dart';
import 'PetCareScreen.dart';

String? pet_id;
class Store extends StatefulWidget {
  const Store({Key? key}) : super(key: key);

  @override
  State<Store> createState() => _StoreState();
}

var homelat;
var homeLong;

class _StoreState extends State<Store> {

  //loc.LocationData? locationData;
  bool isLoading = false;
  // List<Placemark>? placemark;
var select;
  String? user_name;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // init();
    // _determinePosition();
    // getLocation();
    userName();
    getSlider();
    getUserCurrentLocation();
    _getAddressFromLatLng();
    getPermission();
    getCat();
    getDoctors();
    nearByDoctor();
    getPets();
    // getAddress();
  }

  init() async {
    // currentLocation = await getUserCurrentPosition();
    // print("------------${currentLocation!.latitude}");
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      print("nowwwwwwwwwwwwwwwwww");
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
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
      for (var i = 0; i < getpetsmodel!.data!.length; i++) {
        pet_id = getpetsmodel?.data?[i].id;
        print('---states---id${pet_id}');
      }
    }
    else {
      print(response.reasonPhrase);
    }
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
      // Fluttertoast.showToast(msg: "${finalResult.message}");
      setState(() {
        getCategoryModel = finalResult;
      });
      if (finalResult.error == false) {
        String? cat_id = finalResult.data?[0].id;
        preferences.setString('cat_id', cat_id ?? "");
        print("category id is ${cat_id}");
        getDoctors();
      } else {
        // Fluttertoast.showToast(msg: "${finalResult.error}");
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }


  TextEditingController searchCtr = TextEditingController();

  GetDoctorModel? getDoctorModel;
  getDoctors() async {
    setState(() {
      isLoading = true;
    });
    var headers = {
      'Cookie': 'ci_session=a606f47d62f270c5c80b9415ef655e928d2d15fa'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.getDoctorByCatid));
    request.fields.addAll({
      'cat_id': currentIndex == 1 ? "1" : "2",
      // "latitude": homelat == null ?  "" :homelat.toString() ,
      // "longitude": homeLong == null ? "" :homeLong.toString(),
      'sort': orderBy,
      "experience": experiance ?? '',
      "availability": avaliablity?? '',
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
        doctorData = getDoctorModel?.data ?? [];
      });
    }
    else {
    print(response.reasonPhrase);
    }
    setState(() {
      isLoading = false;
    });
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
        // getLocation();
      });
    } else {
      Permission.location.request();
    }
  }

  double lat = 0.0;
  double long = 0.0;
  Position? currentLocation;
  String? _currentAddress;

   getUserCurrentLocation() async {
    var status = await Permission.location.request();
    print("location status ${status}");
    if(status.isDenied) {
      Fluttertoast.showToast(msg: "Permision is requiresd");
    }else if(status == PermissionStatus.granted){
      print("workingggggg");
      await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((position) {
        print("current location isss ${position.latitude}");
        if (mounted) {
          setState(() {
            currentLocation = position;
            print("current location isss ${currentLocation!.latitude}");
            homelat = currentLocation!.latitude;
            homeLong = currentLocation!.longitude;
            // if(fromInIt){
            //   homelat = currentLocation?.latitude.toString();
            //   homeLong = currentLocation?.longitude.toString();
            //   getDoctors();
            // }
          });
        }
        getDoctors();
      });
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
          print("current addresssss nowwwww$_currentAddress");
        });
      } catch (e) {
        print('errorrrrrrr $e');
      }
    });
  }

  // void getLocation() async {
  //   setState(() {
  //     getAddress();
  //     isLoading = true;
  //   });
  //   getAddress();
  //   locationData = await loc.Location.instance.getLocation();
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  // void getAddress() async {
  //   if (locationData != null) {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     placemark = await placemarkFromCoordinates(locationData!.latitude!, locationData!.longitude!);
  //     // homelat = placemark[0].
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  int _currentPost = 0;
  _CarouselSlider1() {
    return CarouselSlider(
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

  List<PetsData> selectedPets = [];

  String? petNmaee;
  String? petType;
  String? idd;

  List petValue = [
  {
    'PetName':  '',
    'PetType':  '',
  }
  ];


  Future<Null> _refresh() {
    return getDoctors();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =  GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Color(0xfff5f6fb),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: getCategoryModel?.data == null || getCategoryModel?.data == "" ? const Center(child: CircularProgressIndicator(),):
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // SizedBox(
                //   height: MediaQuery.of(context).size.height/50,
                // ),
                Center(child: Image.asset("assets/images/homelogo.png", height: 30, width: 200)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          // getAddress();
                        },
                        child: const Icon(
                          Icons.location_pin,
                          color: Colors.blue,
                        ),
                    ),
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
                          fontSize: 15, overflow: TextOverflow.ellipsis,fontFamily: "Montserrat"
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/30,
                ),
                user_name == null || user_name == ""? const Text("---"):
                Text(
                  "Welcome- $user_name",
                  style: const TextStyle(color: colors.black, fontWeight: FontWeight.bold, fontSize: 15, fontFamily: "Montserrat"),
                ),
                SizedBox(
                  height: 25
                ),
                // SizedBox(
                //   //height: 200,
                //   width: double.maxFinite,
                //   child: sliderModel == null
                //       ? const Center(
                //     child: CircularProgressIndicator(
                //       color: colors.primary,
                //     ),
                //   ): _CarouselSlider1(),
                // ),
                // SizedBox(height: 10),
                // CustomTextFormField(
                //   name: 'textform',
                //   width: double.infinity,
                //   Icon: Icons.search,
                //   hint: "Search Doctors",
                // ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height/20,
                // )
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text("My Pets", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: "Montserrat"),),
                ),
                const SizedBox(
                  height: 10
                ),
                Stack(
                  children: [
                    Container(
                      // decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.red),
                      width: MediaQuery.of(context).size.width/1.1,
                      height: getpetsmodel!.data!.length > 4 ?  MediaQuery.of(context).size.height/3:100,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 3,
                        child: GridView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 5.4/8,
                              crossAxisCount: 4,
                            ),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: getpetsmodel?.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // print('${getpetsmodel!.data![index].isSelected}');
                                  setState(() {
                                    select=index;
                                  });
                                  setState(() {
                                  petNmaee=getpetsmodel?.data?[index].username;
                                    petType=getpetsmodel?.data?[index].petType;
                                   idd=getpetsmodel?.data?[index].id;
                                  });
                                //  if(getpetsmodel!.data![index].isSelected ?? false){
                                    // petNameList.remove(getpetsmodel?.data?[index].username);
                                    // petNmaee=petNameList.join(",");
                                    // print('pet name${petNmaee}');
                                    // petTypeList.remove(getpetsmodel?.data?[index].petType);
                                    // petType=petTypeList.join(",");
                                    // print('pet type${petType}');
                                  //}

                                 // else{
                                    // petNameList.add(getpetsmodel?.data?[index].username);
                                    // petNmaee=petNameList.join(",");
                                    // print('pet name${petNmaee}');
                                    // petTypeList.add(getpetsmodel?.data?[index].petType);
                                    // petType=petTypeList.join(",");
                                    // print('pet type${petType}');
                                //  }
                                },
                                // onTap: () {
                                //   Navigator.push(context, MaterialPageRoute(builder: (context) => PetsDetails(model: getpetsmodel?.data?[index])));
                                // },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    children: [
                                      Column(
                                        children: [
                                          ClipRRect(
                                              borderRadius: BorderRadius.circular(100),
                                              child: Image.network("${ApiServicves.imageUrl}${getpetsmodel?.data?[index].image}",fit: BoxFit.fill, height: 60, width: 60,)),
                                          const SizedBox(height: 5),
                                          Text("${getpetsmodel?.data?[index].username}", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, fontFamily: "Montserrat"),),
                                        ],
                                      ),
                                      select==index ? const Positioned(child: Icon(Icons.check_circle, color: colors.primary)) : const SizedBox()
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PetCare()));
                        },
                        child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: colors.primary),
                            child: const Center(child: Text("Add", style: TextStyle(fontSize: 11, color: colors.white, fontFamily: "Montserrat")))),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/50,
                ),
                Card(
                  elevation: 4,
                  child: Container(
                    height:50,
                    // padding: EdgeInsets.only(left:3,right:3),
                    child: TextFormField(
                      onChanged: (value){
                        searchDoctor(value);
                      },
                      controller: searchCtr,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 16, left: 5),
                          suffixIcon: Container(
                              width: 20,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(0), color: colors.primary,),
                              child: const Icon(Icons.search, color: Colors.white)),
                          hintText: "Search vet or clinic here",
                          hintStyle: TextStyle(fontFamily: "Montserrat"),
                          border: InputBorder.none
                          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(0))
                      ),
                    ),
                  ),
                ),
               const SizedBox(height: 10),
               const Text("Book An Appointment", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: "Montserrat")),
                SizedBox(
                  height: MediaQuery.of(context).size.height/60,
                ),
                customTabbar(context),
                SizedBox(
                  height: MediaQuery.of(context).size.height/50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  List <DactorData> doctorData = [];
  searchDoctor(String value) {
    if (value.isEmpty) {
      getDoctors();
      setState(() {});
    }else{
      final suggestions = doctorData.where((element) {
        final doctorName = element.username.toString().toLowerCase();
        final clinicName = element.clinicName.toString().toLowerCase();
        // final leadsId = element.agreementid.toString().toLowerCase();
        final input = value.toLowerCase();
        return doctorName.contains(input) || clinicName.contains(input);
            // || leadsId.contains(input)  ;
      }).toList();
      doctorData = suggestions;
      setState(() {
      });
    }
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
                    height: 50,
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
                            fontWeight: FontWeight.w600,fontFamily: "Montserrat"
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
                    height: 50,
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
                              fontSize: 14, fontWeight: FontWeight.w600, fontFamily: "Montserrat"
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
          // Padding(
          //   padding: const EdgeInsets.only(left: 5, right: 5),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: const [
          //       // Text("Sorting", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),),
          //       Icon(Icons.filter_alt, color: colors.primary, size: 50,),
          //     ],
          //   ),
          // ),
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white,),
                width: MediaQuery.of(context).size.width/1.1,
                // padding: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: [
                    // if (widget.fromSeller!) Container() else _tags(),
                    filterOptions(),
                  ],
                ),
              ),
            ),
          ),
          currentIndex == 1 ? online() :currentIndex == 3 ?  inClinic() : SizedBox.shrink(),
        ],
      ),
    );
  }

  String sortBy = 'p.id', orderBy = "DESC";
  int offset = 0;
  int total = 0;
  double? deviceWidth;
  bool listType = false;

  void sortDialog() {
    showModalBottomSheet(
      backgroundColor: colors.white,
      context: context,
      enableDrag: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      builder: (builder) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                            padding:
                            EdgeInsetsDirectional.only(top: 19.0, bottom: 16.0),
                            child: Text(
                              "Sort By",
                              style: TextStyle(fontFamily: "Montserrat")
                            ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // sortBy = '';
                          // orderBy = 'DESC';
                          if (mounted) {
                            setState(() {
                              isLoading = true;
                              total = 0;
                              offset = 0;
                              // productList.clear();
                            });
                          }
                          getUserCurrentLocation();
                          // getProduct("1");
                          Navigator.pop(context, 'option 1');
                        },
                        child: Container(
                          width: deviceWidth,
                          // color: sortBy == ''
                          //     ? colors.primary
                          //     : colors.white,
                          padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          child: Text("Nearest",
                              style: TextStyle(fontFamily: "Montserrat")
                          ),
                        ),
                      ),
                      InkWell(
                          child: Container(
                              width: deviceWidth,
                              // color: sortBy == 'p.date_added' && orderBy == 'DESC'
                              //     ? colors.primary
                              //     : colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              child: Text("Experience",
                                  style: TextStyle(fontFamily: "Montserrat")
                              ),
                          ),
                          onTap: () {
                            print("workingggg");
                            experianceDialog();
                            // sortBy = 'p.date_added';
                            // orderBy = 'DESC';
                            // if (mounted) {
                            //   setState(() {
                            //     isLoading = true;
                            //     total = 0;
                            //     offset = 0;
                            //     // productList.clear();
                            //   });
                            // };
                            // getDoctors();
                            // getProduct("0");
                            // Navigator.pop(context, 'option 1');
                          }),
                      InkWell(
                          child: Container(
                              width: deviceWidth,
                              // color: sortBy == 'p.date_added' && orderBy == 'ASC'
                              //     ? colors.primary
                              //     : colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child: Text(
                                "Avaliability",
                                style: TextStyle(fontFamily: "Montserrat")
                              ),
                          ),
                          onTap: () {
                            avaliablityDialog();
                            // sortBy = 'p.date_added';
                            // orderBy = 'ASC';
                            // if (mounted) {
                            //   setState(() {
                            //     isLoading = true;
                            //     total = 0;
                            //     offset = 0;
                            //     // productList.clear();
                            //   });
                            // }
                            // // getProduct("0");
                            // Navigator.pop(context, 'option 2');
                          }),
                      InkWell(
                          child: Container(
                              width: deviceWidth,
                              // color: sortBy == 'pv.price' && orderBy == 'ASC'
                              //     ? colors.primary
                              //     :  colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              child:  Text(
                                "Fees- Low To High",
                                style: TextStyle(fontFamily: "Montserrat")
                              )),
                          onTap: () {
                            // sortBy = 'pv.price';
                             orderBy = 'ASC';
                            if (mounted) {
                              setState(() {
                                isLoading = true;
                                total = 0;
                                offset = 0;
                                // productList.clear();
                              });
                            }
                            getDoctors();
                            // getProduct("0");
                            Navigator.pop(context, 'option 3');
                          }),
                      InkWell(
                          child: Container(
                              width: deviceWidth,
                              // color: sortBy == 'pv.price' && orderBy == 'DESC'
                              //     ? colors.primary
                              //     :  colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              child:  Text(
                                "Fees- High To Low",
                                style: TextStyle(fontFamily: "Montserrat")
                              )),
                          onTap: () {
                            // sortBy = 'pv.price';
                             orderBy = 'DESC';
                            if (mounted) {
                              setState(() {
                                isLoading = true;
                                total = 0;
                                offset = 0;
                                // productList.clear();
                              });
                            }
                             getDoctors();
                            Navigator.pop(context, 'option 4');
                          }),
                      // InkWell(
                      //     child: Container(
                      //         width: deviceWidth,
                      //         color: sortBy == 'pv.price' && orderBy == 'DESC'
                      //             ? colors.primary
                      //             :  colors.white,
                      //         padding: const EdgeInsets.symmetric(
                      //             horizontal: 20, vertical: 15),
                      //         child:  Text(
                      //           "Avaliablity",
                      //           style: Theme.of(context)
                      //               .textTheme
                      //               .subtitle1!
                      //               .copyWith(
                      //               color: sortBy == 'pv.price' &&
                      //                   orderBy == 'DESC'
                      //                   ?  colors.white
                      //                   :  colors.black),
                      //         )),
                      //     onTap: () {
                      //       sortBy = 'pv.price';
                      //       orderBy = 'DESC';
                      //       if (mounted) {
                      //         setState(() {
                      //           isLoading = true;
                      //           total = 0;
                      //           offset = 0;
                      //           // productList.clear();
                      //         });
                      //       }
                      //       // getProduct("0");
                      //       Navigator.pop(context, 'option 5');
                      //     }),
                    ]),
              );
            });
      },
    );
  }

  String highLow = "";

  String? avaliablity;
  var avaliableitem = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  String? experiance;

  var selectedService;
  var items = [
    '1 year',
    '2 year',
    '3 year',
    '4 year',
    '5 year',
    '6 year',
    '7 year',
    '8 year',
    '9 year',
    '10 year',
    '11 year',
    '12 year',
    '13 year',
    '14 year',
    '15 year',
    '16 year',
    '17 year',
    '18 year',
    '19 year',
    '20 year',
    '21 year',
    '22 year',
    '23 year',
    '24 year',
    '25 year',
    '26 year',
    '27 year',
    '28 year',
    '29 year',
    '30 year',
    '31 year',
    '32 year',
    '33 year',
    '34 year',
    '35 year',
    '36 year',
    '37 year',
    '38 year',
    '39 year',
    '40 year',
    '41 year',
    '42 year',
    '43 year',
    '44 year',
    '45 year',
    '46 year',
    '47 year',
    '48 year',
    '49 year',
    '50 year',
  ];

avaliablityDialog() {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog( // <-- SEE HERE
        // title: const Text('Experiance'),
        content: SingleChildScrollView(
          child: ListBody(
            children:  <Widget>[
              Card(
                elevation: 3,
                child: DropdownButtonFormField<String>(
                  value: avaliablity,
                  // hint: Icon(Icons.arrow_drop_down_outlined),
                  onChanged: (String? newValue) {
                    setState(() {
                      avaliablity = newValue!;
                    });
                    // if(avaliablity == "online"){
                    //   setState(() {
                    //     selectedService = 1;
                    //   });
                    // } else if(avaliablity == "Inclinic"){
                    //   setState(() {
                    //     selectedService =2;
                    //   });
                    // } else{
                    //   setState(() {
                    //     selectedService = 3;
                    //   });
                    // }
                    // print("valuesss selectedd ${selectedService}");
                  },
                  items:avaliableitem.map((String avaliableitem) {
                    return DropdownMenuItem(
                      value: avaliableitem,
                      child: Text(avaliableitem.toString()),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText:
                    'Avaliablity',
                    filled: true,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Confirm'),
            onPressed: () {
              getDoctors();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


  experianceDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog( // <-- SEE HERE
          // title: const Text('Experiance'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Card(
                  elevation: 3,
                  child: DropdownButtonFormField<String>(
                    value: experiance,
                    // hint: Icon(Icons.arrow_drop_down_outlined),
                    onChanged: (String? newValue) {
                      setState(() {
                        experiance = newValue!;
                      });
                      // if(experiance == "online"){
                      //   setState(() {
                      //     selectedService = 1;
                      //   });
                      // } else if(experiance == "Inclinic"){
                      //   setState(() {
                      //     selectedService =2;
                      //   });
                      // } else{
                      //   setState(() {
                      //     selectedService = 3;
                      //   });
                      // }
                      print("valuesss selectedd ${selectedService}");
                    },
                    items:items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText:
                      'Experiance',
                      filled: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                getDoctors();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  filterOptions() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton.icon(
            onPressed: sortDialog,
            icon: const Icon(
              Icons.swap_vert,
              color: colors.primary,
            ),
            label: const Text(
              "Sort By",
              style: TextStyle(
                color: colors.black,
              ),
            ),
          ),
          // InkWell(
          //   child: Icon(
          //     listType ? Icons.grid_view : Icons.list,
          //     color: colors.primary,
          //   ),
          //   onTap: () {
          //     doctorData.length != 0
          //         ? setState(() {
          //       listType = !listType;
          //     }): null;
          //   },
          // ),
        ],
      ),
    );
  }


  online() {
    return
      SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: doctorData.length ?? 0,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                print(petNmaee.runtimeType);
                if(petNmaee==null) {
                  Fluttertoast.showToast(msg: "Please Select a Pet First");
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorDetails(model: getDoctorModel?.data?[index], petName: petNmaee,petType: petType,petIdd: idd,)));
                }
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                child: Container(
                  height: 170,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: colors.white),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          doctorData[index].image == null || doctorData[index].image ==  ""? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            height: 130,width:100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                  child: Image.asset("assets/images/doctor2.jpg", fit: BoxFit.fill,))) :Container(
                            height: 110,
                            width: 90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        '${doctorData[index].image}'), fit: BoxFit.cover)
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${doctorData[index].username}',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold, fontFamily: "Montserrat"),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                // SizedBox(
                                //     width:
                                //     MediaQuery.of(context).size.width/2,
                                //     child: Text(
                                //       '${doctorData?[index].address}',
                                //       maxLines: 3,
                                //       overflow: TextOverflow.ellipsis,
                                //       style: const TextStyle(
                                //           fontWeight: FontWeight.bold,
                                //           fontSize: 12),
                                //     ),
                                // ),
                                // const SizedBox(
                                //   height: 6,
                                // ),
                                Row(
                                  children: [
                                    const Text("Experiance: ", style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold, fontFamily: "Montserrat"
                                    ),
                                    ),
                                    Text(
                                      '${doctorData[index].experience}',
                                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, fontFamily: "Montserrat"),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  children:  [
                                    const Text("Clinic Name: ", style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold, fontFamily: "Montserrat")),
                                    Text(
                                      '${doctorData[index].clinicName}',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,fontFamily: "Montserrat"),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  children: [
                                    const Text("Qualification: ", style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold, fontFamily: "Montserrat")),
                                    Text(
                                      '${doctorData[index].qualification}',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold, fontFamily: "Montserrat")),
                                  ],
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  children: [
                                    const Text("Fees: ", style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold, fontFamily: "Montserrat"
                                       ),
                                    ),
                                    Text(
                                      '${doctorData[index].consultancyFees}',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold, fontFamily: "Montserrat"),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 0,
                                ),
                                Row(
                                  mainAxisAlignment:  MainAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Text("Avaliable Time: ", style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold, fontFamily: "Montserrat"
                                      ),
                                      ),
                                    ),
                                    Container(
                                      width: 110,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          '${doctorData[index].selectTimeSchedule}',
                                          style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold, fontFamily: "Montserrat"), overflow: TextOverflow.ellipsis, maxLines: 2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
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
        ),
      );
  }

  inClinic() {
    return doctorData.length == "" || doctorData.length == null ? Center(child: Text("No Doctor Avaliable", style:  TextStyle(fontWeight: FontWeight.w500, fontSize: 15),),):
      ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: doctorData.length ?? 0,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            print(petNmaee.runtimeType);
            print(petNmaee);
            if(petNmaee==null) {
              Fluttertoast.showToast(msg: "Please Select Pets First");
            } else {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorDetails(model: getDoctorModel?.data?[index], petName: petNmaee,petType: petType,petIdd: idd,)));
            }
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5,
            child: Container(
              height: 180,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: colors.white),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    doctorData[index].image == null || doctorData[index].image ==  ""? Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        height: 130,width:100,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset("assets/images/doctor2.jpg", fit: BoxFit.fill,))) :Container(
                      height: 110,
                      width: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: NetworkImage(
                                  '${doctorData[index].image}'), fit: BoxFit.cover)
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${doctorData[index].username}',
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              const Text("Address: ", style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold, fontFamily: "Montserrat"
                              ),
                              ),
                              Text(
                                '${doctorData[index].clinicAddress}',
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold, fontFamily: "Montserrat"),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              const Text("Experiance: ", style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold, fontFamily: "Montserrat"
                              ),
                              ),
                              Text(
                                '${doctorData[index].experience}',
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,fontFamily: "Montserrat"),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children:  [
                              const Text("Clinic Name: ", style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,fontFamily: "Montserrat"
                              ),
                              ),
                              Text(
                                '${doctorData[index].clinicName}',
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,fontFamily: "Montserrat"),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              const Text("Qualification: ", style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,fontFamily: "Montserrat"
                              ),
                              ),
                              Text(
                                '${doctorData[index].qualification}',
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,fontFamily: "Montserrat"),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              const Text("Fees: ", style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,fontFamily: "Montserrat"
                              ),
                              ),
                              Text(
                                '${doctorData[index].consultancyFees}',
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold, fontFamily: "Montserrat"),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 0,
                          ),
                          Row(
                            mainAxisAlignment:  MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Text("Avaliable Time: ", style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,fontFamily: "Montserrat"
                                ),
                                ),
                              ),
                              Container(
                                width: 110,
                                child: Text(
                                  '${doctorData[index].selectTimeSchedule}',
                                  style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,fontFamily: "Montserrat"), overflow: TextOverflow.ellipsis, maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          // Row(
                          //   children: [
                          //     const Text("Distance: ", style: TextStyle(
                          //         fontSize: 12,
                          //         fontWeight: FontWeight.bold
                          //     ),
                          //     ),
                          //     Text(
                          //       '${getDoctorModel?.data?[index].a}',
                          //       style: const TextStyle(
                          //           fontSize: 12,
                          //           fontWeight: FontWeight.bold),
                          //     ),
                          //   ],
                          // )
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
