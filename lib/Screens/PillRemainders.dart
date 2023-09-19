import 'package:flutter/material.dart';

import '../Custom/CustomCard.dart';
import 'SavedAddress.dart';


class PillRemainders extends StatefulWidget {
  const PillRemainders({Key? key}) : super(key: key);

  @override
  State<PillRemainders> createState() => _PillRemaindersState();
}

class _PillRemaindersState extends State<PillRemainders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 10,
                // width: MediaQuery.of(context).size.width / 1.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "myprofile");
                      },
                      child: Text(
                        "Pill Remainders",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

        SizedBox(height: 6,),
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SavedAddress()));
          },
          child: CustomCard4(
            title: "Multi Vitamins",
            icon: Icons.access_alarm,
            title2: 'Mon,Tue,Wed',
            title3: '12:00 am, 02:00 pm', image: 'assets/images/doctor.jpg', color: Colors.blue[200]
          ),
        ),
              SizedBox(height: 6,),
              CustomCard4(
                title: "Diabetes Pills",
                icon: Icons.access_alarm,
                title2: 'Mon,Tue,Wed,Thurs,Fri,Sat,Sun',
                title3: '08:00 am, 02:00 pm, 08:00 pm', image: 'assets/images/doctor.jpg', color: Colors.blue[200],
              ),
              SizedBox(height: 6,),
              CustomCard4(
                title: "Multi Vitamins",
                icon: Icons.access_alarm,
                title2: 'Mon,Tue,Wed',
                title3: '08:00 am, 02:00 pm', image: 'assets/images/doctor.jpg', color: Colors.blue[200],
              ),
              SizedBox(height: 6,),
              CustomCard4(
                title: "Diabetes Pills",
                icon: Icons.access_alarm,
                title2: 'Mon,Tue,Wed',
                title3: '08:00 am, 02:00 pm', image: 'assets/images/doctor.jpg', color: Colors.blue[200],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
