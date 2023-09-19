import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'BottomNavigationScreens/AppointmentDetailsUser.dart';
import 'Groomer.dart';
import 'WalletScreen.dart';
class MyAppointment extends StatefulWidget {
  const MyAppointment({super.key});

  @override
  State<MyAppointment> createState() => _MyAppointmentState();
}

class _MyAppointmentState extends State<MyAppointment> {
  List listDetails = [
    {"name": "Dr. Joseph Williamson", "des": "Groomer at Woof n Purr"},
    {"name": "Dr. Anglina Taylor", "des": "Groomer at Woof n Purr"},
    {"name": "Dr. Anthony Peterson", "des": "Groomer at Woof n Purr"},
    {"name": "Dr. Eline George", "des": "Groomer at Woof n Purr"},
    {"name": "Dr. Joseph Williamson", "des": "Groomer at Woof n Purr"},
    {"name": "Dr. Anglina Taylor", "des": "Groomer at Woof n Purr"},
    {"name": "Dr. Anthony Peterson", "des": "Groomer at Woof n Purr"},
    {"name": "Dr. Eline George", "des": "Groomer at Woof n Purr"},
    {"name": "Dr. Joseph Williamson", "des": "Groomer at Woof n Purr"},
    {"name": "Dr. Anglina Taylor", "des": "Groomer at Woof n Purr"},
    {"name": "Dr. Anthony Peterson", "des": "Groomer at Woof n Purr"},
    {"name": "Dr. Eline George", "des": "Groomer at Woof n Purr"},
  ];
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
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
              )),
          title: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
            },
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>WalletScreen()));
              },
              child: Text(
                'My appointment',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade200,
                child: Text(
                  "Upcoming",
                  style: TextStyle(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AppointmentScreen()));
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.21,
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    itemCount: 2,
                    separatorBuilder: (context, index) {
                      return Container(
                        height: 5,
                        color: Colors.grey.shade100,
                      );
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Colors.white,
                        ),
                        child: Row(
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
                                        "assets/images/doctor3.jpg",
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
                                      listDetails[index]['name'],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      listDetails[index]['des'],
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "12 june 2020 |12:00pm",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Icon(
                                    Icons.more_vert,
                                    size: 24,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15, bottom: 10),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        size: 16,
                                        color: Colors.blueAccent,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.message,
                                        size: 16,
                                        color: Colors.blueAccent,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade200,
                child: Text(
                  "Past",
                  style: TextStyle(),
                ),
              ),
              Expanded(
                child: Container(
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    itemCount: listDetails.length,
                    separatorBuilder: (context, index) {
                      return Container(
                        height: 5,
                        color: Colors.grey.shade100,
                      );
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Colors.white,
                        ),
                        child: Row(
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
                                        "assets/images/doctor3.jpg",
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
                                      listDetails[index]['name'],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      listDetails[index]['des'],
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "12 june 2020 |12:00pm",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Icon(
                                    Icons.more_vert,
                                    size: 24,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15, bottom: 10),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        size: 16,
                                        color: Colors.blueAccent,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.message,
                                        size: 16,
                                        color: Colors.blueAccent,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}