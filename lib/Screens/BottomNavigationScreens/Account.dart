import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:muddypawsuser/Api.path.dart';
import 'package:muddypawsuser/Models/GetUserDataModel.dart';
import 'package:muddypawsuser/Screens/Auth/LoginScreen.dart';
import 'package:muddypawsuser/Screens/MyAppointmentsUser.dart';
import 'package:muddypawsuser/Screens/Support.dart';
import 'package:muddypawsuser/Screens/Terms&Condition.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Colors.dart';
import '../../Custom/CustomCard.dart';
import '../../Models/GetCategoryModel.dart';
import '../ContactUs.dart';
import '../FaqScreen.dart';
import '../PetsProfile.dart';
import '../PillRemainders.dart';
import '../SavedAddress.dart';
import '../SendToBank.dart';
import '../WalletScreen.dart';


String? wallet_balance;

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }


  GetUserDataModel? getUserDataModel;
  getData() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('user_id');
    var headers = {
      'Cookie': 'ci_session=4a63192353367f326b2f0977e9404877568d5d4e'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.getUserData));
    request.fields.addAll({
      'user_id': '${userId}'
    });
   print("user id in get user data ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult = GetUserDataModel.fromJson(json.decode(finalResponse));
      print("final respoenseee ${finalResult}");
      print("final&&&&&&&&&&&&& ${finalResponse}");
      Fluttertoast.showToast(msg: "${finalResult.message}");
      setState(() {
        getUserDataModel = finalResult;
        wallet_balance = getUserDataModel?.data?[0].balance;
        preferences.setString('wallet_balance', wallet_balance ?? "");
        print("wallet balanceee ${wallet_balance}");
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Account",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height/29,
                    ),
                    Row(
                      children: [
                        getUserDataModel?.data?.length == null || getUserDataModel?.data?.length == ""? Center(child: CircularProgressIndicator(color: colors.white,),):
                        Container(
                            height: MediaQuery.of(context).size.height/6.5,
                            width: MediaQuery.of(context).size.width/3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child:
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: getUserDataModel?.data?.first.image == null || getUserDataModel?.data?.first.image == "" ? Image.asset("assets/images/doctor2.jpg", fit: BoxFit.cover,):
                              Image.network(
                                "${getUserDataModel?.data?.first.image}",
                                fit: BoxFit.cover,
                              ),
                            )),
                        SizedBox(
                          width: MediaQuery.of(context).size.width/22,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height/190,
                            ),
                             Text(
                              "${getUserDataModel?.data?.first.username}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 190,
                            ),
                             Text(
                              "${getUserDataModel?.data?.first.email}",
                              style: const TextStyle(
                                  fontSize: 16,color: Colors.grey
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height/40,
                            ),
                            Text("${getUserDataModel?.data?.first.mobile}",style: TextStyle(fontSize: 16,color: Colors.grey),),
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
                          onTap:() {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> MyAppointment()));
                          },
                          child: CustomCard2(title: "Appointments", title2: "Doctor Appointments", icon: CupertinoIcons.profile_circled)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/80,
                      ),
                      // CustomCard2(title: "My Orders", title2: "Order Status", icon:Icons.cyclone),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height/80,
                      // ),
                      // InkWell(
                      //     onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>SavedAddress()));},
                      //     child: CustomCard2(title: "My Address", title2: "Save Address", icon: CupertinoIcons.location_solid,)),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height/80,
                      // ),
                      // CustomCard2(title: "Change Language", title2: "Change Language", icon: CupertinoIcons.globe,),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height/80,
                      // ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Contactus()));
                        },
                          child: CustomCard2(title: "Contact us", title2: "Let us help you", icon: CupertinoIcons.chat_bubble_text)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/80,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const FaqScreen()));
                          },
                          child: CustomCard2(title: "FAQs", title2: "Quick Answers", icon: CupertinoIcons.arrow_down_left_square_fill,)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/80,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Support()));
                          },
                          child: CustomCard2(title: "Support", title2: "Support", icon: CupertinoIcons.arrow_down_left_square_fill,)),
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width/50,),
                  Column(
                    children: [
                      InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>WalletScreen()));
                          },
                          child: CustomCard2(title: "Wallet", title2: "Quick Payments", icon: Icons.account_balance_wallet,)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/80,
                      ),
                      InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const PetsProfile()));
                          },
                          child: CustomCard2(title: "Pets", title2: "Pet Profile", icon: CupertinoIcons.clock,)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/80,
                      ),
                      // CustomCard2(title: "Saved", title2: "Meds & Doctors", icon: CupertinoIcons.bookmark_fill,),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height/80,
                      // ),
                      // CustomCard2(title: "Change Theme", title2: "Change Theme", icon: CupertinoIcons.paintbrush_fill,),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height/80,
                      // ),
                      InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const Terms()));
                          },
                          child: CustomCard2(title: "T&C", title2: "Company Policies", icon: CupertinoIcons.book)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/80,
                      ),
                      InkWell(
                          onTap: () async {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Confirm log out"),
                                    content: const Text("Are you sure you won't to log out"),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        style:
                                        ElevatedButton.styleFrom(primary: colors.primary),
                                        child: const Text("YES"),
                                        onPressed: () async {
                                          SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                          prefs.clear();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Login()),
                                          );
                                        },
                                      ),
                                      ElevatedButton(
                                        style:
                                        ElevatedButton.styleFrom(primary: colors.primary),
                                        child: const Text("NO"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: CustomCard2(title: "Logout", title2: "Logout", icon: Icons.logout_outlined,)),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/80,
                      ),
                      // InkWell(
                      //     onTap: () {
                      //       Navigator.push(context, MaterialPageRoute(builder: (context)=> const SendToBankPage()));
                      //     },
                      //     child: CustomCard2(title: "Send to Bank", title2: "Send to Bank", icon: CupertinoIcons.arrow_down_left_square_fill,)),
                    ],
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height / 80,
            // ),
            // Container(
            //   width: double.infinity,
            //   color: Colors.white,
            //   child: Padding(
            //     padding: const EdgeInsets.all(18.0),
            //     child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         SizedBox(
            //           height: MediaQuery.of(context).size.height / 80,
            //         ),
            //         Text("Developed by :",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),),
            //         SizedBox(
            //           height: MediaQuery.of(context).size.height / 80,
            //         ),
            //         Align(
            //             alignment: Alignment.bottomRight,
            //             child: Container(
            //               height: 50,
            //               width: 160,
            //               child: ElevatedButton(onPressed: (){},style: ElevatedButton.styleFrom(primary: Colors.deepOrange,
            //                 shape: RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(80), // Adjust the radius as needed
            //                 ),
            //               ), child: const Text("Buy this app")),
            //             ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
