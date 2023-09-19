import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as loc;
import '../../Custom/CustomTextFormField.dart';
import '../Groomer.dart';
import '../MyAppointmentsUser.dart';

class PetCare extends StatefulWidget {
  const PetCare({Key? key}) : super(key: key);

  @override
  State<PetCare> createState() => _PetCareState();
}

class _PetCareState extends State<PetCare> {
  loc.LocationData? locationData;
  bool isLoading = false;
  List<Placemark>? placemark;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPermission();
    // getAddress();
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

  List s1 = [
    {"img": "assets/images/logo/Group 169.png", "name": "Stay Home \nGet Discount"},
    {"img": "assets/images/logo/Group 170.png", "name": "Get 50% \nOff Medicine"},
  ];

  List speciList = [
    {"img": "assets/images/logo/Group 169.png", "name": "TRAINERS"},
    {"img": "assets/images/logo/Group 171.png", "name": "DOCTORS"},
    {"img": "assets/images/logo/Group 172.png", "name": "GROOMERS"},
    {"img": "assets/images/logo/Group 169.png", "name": "PET FOOD"}
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            // Row(
            //   children: [
            //     InkWell(
            //         onTap: () {
            //           // getAddress();
            //         },
            //         child: Icon(
            //           Icons.location_pin,
            //           color: Colors.blue,
            //         )),
            //     SizedBox(
            //       width: MediaQuery.of(context).size.width / 30,
            //     ),
            //     Text(
            //       placemark != null
            //           ? "Address:${placemark![0].street} ${placemark![0].locality} ${placemark![0].country}"
            //           : "Address : Not Available",
            //       style: TextStyle(fontWeight: FontWeight.bold),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30,
            ),
            Text(
              "Hello, Sam Smith",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 60,
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyAppointment()));
              },
              child: const Text(
                "Find Pet Care",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              name: 'textform',
              width: double.infinity,
              Icon: Icons.search,
              hint: "Search",
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Find by Specialities",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>Grid()));
                    },
                    child: Text(
                      "View all",
                      style: TextStyle(color: Colors.blue),
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 6.5,

                    // width: MediaQuery.of(context).size.width / 17,

                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,

                        //physics: NeverScrollableScrollPhysics(),

                        itemCount: speciList.length,
                        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //     crossAxisCount: 1,
                        //     crossAxisSpacing: 5,
                        //     mainAxisSpacing: 1,
                        //     mainAxisExtent: 100),

                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 15,
                          );
                        },
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>AllProduct()));
                            },
                            child: Container(
                              // height:30,

                              //  MediaQuery.of(context).size.height * 50,

                              child: Stack(
                                children: [
                                  Image(
                                    image: AssetImage(
                                      speciList[index]["img"],
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 10, left: 5),
                                    child: Text(
                                      speciList[index]["name"],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Sponsors ad",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery.of(context).size.height / 7.5,

              // width: MediaQuery.of(context).size.width / 17,

              child: ListView.separated(
                  scrollDirection: Axis.horizontal,

                  //physics: NeverScrollableScrollPhysics(),

                  itemCount: s1.length,
                  // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 1,
                  //     crossAxisSpacing: 5,
                  //     mainAxisSpacing: 1,
                  //     mainAxisExtent: 100),

                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 15,
                    );
                  },
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>AllProduct()));
                      },
                      child: Container(
                        // height:30,

                        //  MediaQuery.of(context).size.height * 50,

                        child: Stack(
                          children: [
                            Image(
                              image: AssetImage(
                                "assets/images/logo/Group 173.png",
                              ),
                              fit: BoxFit.fill,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Center(
                                child: Text(
                                  s1[index]["name"],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            // CustomGridView(
            //   itemcount: '5',
            //   mainaxis: "280",
            //   imgPath: "assets/images/s1.png",
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            Text(
              "Near you",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
               );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white60,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        // width: MediaQuery.of(context).size.width / 6.5,
                        // height: MediaQuery.of(context).size.height / 14,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(9),
                              child: Image.asset(
                                "assets/images/logo/Group 169.png",
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
                              "Dr. Joseph Williamson",
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Groomer at Woof n Purr",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Exp 22 Year  Fees \$30",
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
