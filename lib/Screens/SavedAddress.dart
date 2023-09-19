import 'package:flutter/material.dart';

import '../Custom/CustomCard.dart';

class SavedAddress extends StatefulWidget {
  const SavedAddress({Key? key}) : super(key: key);

  @override
  State<SavedAddress> createState() => _SavedAddressState();
}

class _SavedAddressState extends State<SavedAddress> {
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
                        "Saved Address",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 6,),
              CustomCard4(
                title: "Home",
                icon: Icons.home,
                title2: '1024, Central Residency, Hemilton Park,',
                title3: 'New York, USA', image: 'assets/images/doctor.jpg', color: null,
              ),
              SizedBox(height: 6,),
              CustomCard4(
                title: "Office",
                icon: Icons.ad_units,
                title2: '1024, Central Residency, Hemilton Park,',
                title3: 'New York, USA', image: 'assets/images/doctor.jpg', color: null,
              ),
              SizedBox(height: 6,),
              CustomCard4(
                title: "Other",
                icon: Icons.assistant,
                title2: 'Flat Num 114, First Floor, Central Residency,USA',
                 color: null, title3: '',
              ),


            ],
          ),
        ),
      ),
    );
  }
}
