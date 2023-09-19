import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muddypawsuser/Screens/MyAppointmentsUser.dart';
import 'package:muddypawsuser/Screens/Support.dart';
import 'package:muddypawsuser/Screens/Terms&Condition.dart';

import '../../Custom/CustomCard.dart';
import '../FaqScreen.dart';
import '../PillRemainders.dart';
import '../SavedAddress.dart';
import '../SendToBank.dart';
import '../WalletScreen.dart';

class More extends StatefulWidget {
  const More({Key? key}) : super(key: key);

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //   SizedBox(
            //   height: MediaQuery.of(context).size.height / 12,
            // ),
            Container(
              //  height: MediaQuery.of(context).size.height / 7,
              // width: MediaQuery.of(context).size.width / 1.3,

              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    Center(
                      child: Text(
                        "Account",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 29,
                    ),
                    Row(
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.height/6.5,
                            width: MediaQuery.of(context).size.width/3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                "assets/images/doctor3.jpg",
                                fit: BoxFit.cover,
                              ),
                            )),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 22,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            SizedBox(
                              height: MediaQuery.of(context).size.height / 190,
                            ),
                            Text(
                              "Samantha",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 190,
                            ),
                            Text(
                              "Smith",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 30,
                            ),

                            Text("+19876543210",style: TextStyle(fontSize: 16,color: Colors.grey),),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height / 80,

            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      InkWell(
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MyAppointment()));
                          },
                          child: CustomCard2(title: "Appointments", title2: "Doctor Appointments", icon: CupertinoIcons.profile_circled,)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 80,
                      ),
                      CustomCard2(title: "My Orders", title2: "Order Status", icon:Icons.cyclone),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 80,
                      ),
                      InkWell(
                          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>SavedAddress()));},
                          child: CustomCard2(title: "My Address", title2: "Save Address", icon: CupertinoIcons.location_solid,)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 80,
                      ),
                      CustomCard2(title: "Change Language", title2: "Change Language", icon: CupertinoIcons.globe,),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 80,
                      ),
                      CustomCard2(title: "Contact us", title2: "Let us help you", icon: CupertinoIcons.chat_bubble_text,),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 80,
                      ),
                      InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>FaqScreen()));
                          },
                          child: CustomCard2(title: "FAQs", title2: "Quick Answers", icon: CupertinoIcons.arrow_down_left_square_fill,)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 80,
                      ),
                      InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Support()));
                          },
                          child: CustomCard2(title: "Support", title2: "Support", icon: CupertinoIcons.arrow_down_left_square_fill,)),

                    ],
                  ),

                  SizedBox(width: MediaQuery.of(context).size.width / 50,),
                  Column(
                    children: [
                      InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>WalletScreen()));
                          },
                          child: CustomCard2(title: "Wallet", title2: "Quick Payments", icon: Icons.account_balance_wallet,)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 80,
                      ),
                      InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>PillRemainders()));
                          },
                          child: CustomCard2(title: "Pill Remainders", title2: "Take Pill on time", icon: CupertinoIcons.clock,)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 80,
                      ),
                      CustomCard2(title: "Saved", title2: "Meds & Doctors", icon: CupertinoIcons.bookmark_fill,),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 80,
                      ),
                      CustomCard2(title: "Change Theme", title2: "Change Theme", icon: CupertinoIcons.paintbrush_fill,),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 80,
                      ),
                      InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Terms()));
                          },
                          child: CustomCard2(title: "T&C", title2: "Company Policies", icon: CupertinoIcons.book,)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 80,
                      ),
                      CustomCard2(title: "Logout", title2: "Logout", icon: Icons.logout_outlined,),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 80,
                      ),
                      InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SendToBankPage()));
                          },
                          child: CustomCard2(title: "Send to Bank", title2: "Send to Bank", icon: CupertinoIcons.arrow_down_left_square_fill,)),


                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 80,
            ),
            Container(

              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 80,
                    ),
                    Text("Developed by :",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 80,
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 50,
                          width: 160,

                          child: ElevatedButton(onPressed: (){},style: ElevatedButton.styleFrom(primary: Colors.deepOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80), // Adjust the radius as needed
                            ),
                          ), child: Text("Buy this app")),
                        )),
                  ],),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
