import 'package:flutter/material.dart';
import 'package:muddypawsuser/Custom/CustomCard.dart';

import 'SendToBank.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}



class _WalletScreenState extends State<WalletScreen> {

  List listDetails = [
    {"name": "Well Life Store", "des": "30 Jun 2018, 11:59 am"},
    {"name": "Silver Soul Medical", "des": "30 Jun 2018, 10:23 am"},
    {"name": "Money Added", "des": "29 Jun 2018, 9:12 am"},
    {"name": "Operum Medical", "des": "29 Jun 2018, 11:59 am"},
    {"name": "24*7 Medical Shop", "des": "29 Jun 2018, 11:59 am"},
    {"name": "Relief Medicals", "des": "29 Jun 2018, 11:59 am"},
    {"name": "Silver Soul Medical", "des": "29 Jun 2018, 11:59 am"},
    {"name": "Dr. Eline George", "des": "Groomer at Woof n Purr"},
    {"name": "Dr. Joseph Williamson", "des": "Groomer at Woof n Purr"},
    {"name": "Dr. Anglina Taylor", "des": "Groomer at Woof n Purr"},
    {"name": "Dr. Anthony Peterson", "des": "Groomer at Woof n Purr"},
    {"name": "Dr. Eline George", "des": "Groomer at Woof n Purr"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

      children: [


            Stack(
              children:[


                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 15,right: 15),
                    color:Colors.white,
                    height: MediaQuery.of(context).size.height / 6,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.arrow_back_ios_new_sharp,size: 16,),
                            InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SendToBankPage()));
                                },
                                child: Text("Wallet",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)),
                            Icon(Icons.more_vert),
                          ],
                        ),

                        SizedBox(height: 20,),
                        Container(
                            child: Column(
                              children: [
                                Text("AVAILABLE BALANCE",style: TextStyle(fontSize: 11,color: Colors.grey),),
                                SizedBox(height: 3,),
                                Text("\$ 520.50",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
                              ],
                            )),
                        SizedBox(height: 10,),
                      ],
                    ),

              ),

                    SizedBox(height: 20,)

                  ],
                ),


                Positioned(
                  // top:0,
                  right: 0,
                  bottom: 0,
                  child: InkWell(
                    onTap: (){

                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width/3.5,
                      color: Colors.indigo[300],
                      child: Center(child: Text("Add Money")),),
                  ),
                ),
            ]
            ),
          Text("Recent"),

          SizedBox(height: 20,),
          // SingleChildScrollView(
          //   child: Expanded(
          //     child: Container(
          //        height: 800,
          //       width: double.infinity,
          //       child: ListView.separated(
          //         shrinkWrap: true,
          //       physics: NeverScrollableScrollPhysics(),
          //       // padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          //       itemCount: 8,
          //       separatorBuilder: (context, index) {
          //         return Container(
          //           height: 5,
          //           color: Colors.grey.shade100,
          //         );
          //       },
          //       itemBuilder: (context, index) {
          //         return Container(
          //           padding: EdgeInsets.all(10),
          //            width: MediaQuery.of(context).size.width,
          //           height: MediaQuery.of(context).size.height * 0.1,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(2),
          //             color: Colors.white,
          //           ),
          //           child: Row(
          //             crossAxisAlignment: CrossAxisAlignment.end,
          //             children: [
          //               // Expanded(
          //               //   flex: 2,
          //               //   child: Container(
          //               //       padding: EdgeInsets.all(5),
          //               //       // width: MediaQuery.of(context).size.width / 6.5,
          //               //       // height: MediaQuery.of(context).size.height / 14,
          //               //       decoration: BoxDecoration(
          //               //         borderRadius: BorderRadius.circular(10),
          //               //       ),
          //               //       child: ClipRRect(
          //               //           borderRadius: BorderRadius.circular(9),
          //               //           child: Image.asset(
          //               //             "assets/images/doctor3.jpg",
          //               //             fit: BoxFit.fill,
          //               //           ))),
          //               // ),
          //               Expanded(
          //                 flex: 5,
          //                 child: Padding(
          //                   padding: const EdgeInsets.only(left: 5),
          //                   child: Column(
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: [
          //                       Text(
          //                         listDetails[index]['name'],
          //                         style: TextStyle(
          //                             fontSize: 14,
          //                             fontWeight: FontWeight.bold),
          //                       ),
          //                       SizedBox(
          //                         height: 12,
          //                       ),
          //                       Text(
          //                         listDetails[index]['des'],
          //                         style: TextStyle(fontSize: 12),
          //                       ),
          //                       // SizedBox(
          //                       //   height: 10,
          //                       // ),
          //                       // Text(
          //                       //   "12 june 2020 |12:00pm",
          //                       //   style: TextStyle(
          //                       //       fontSize: 12,
          //                       //       fontWeight: FontWeight.bold),
          //                       // ),
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //               Column(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 crossAxisAlignment: CrossAxisAlignment.end,
          //                 children: [
          //                   Padding(
          //                     padding: const EdgeInsets.only(top: 5.0),
          //                     child: Text("-\$80.00",style: TextStyle(color: Colors.red),),
          //                   ),
          //                   Text("3 Items | COD")
          //                 ],
          //               )
          //             ],
          //           ),
          //         );
          //       },
          //       ),
          //     ),
          //   ),
          // ),

CustomCard5(title: "title", title2: "title2", title3: "title3", title4: "Colors.red"),
      ],
    ),
          ),
        ));
  }
}
