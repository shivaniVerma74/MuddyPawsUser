import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Custom/CustomButton.dart';
import '../Custom/CustomTextFormField.dart';

class Support extends StatefulWidget {
  const Support({Key? key}) : super(key: key);

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xffFFFFFF), // navigation bar color
    statusBarColor: Color(0xffFFFFFF), // status bar color
  ));
    return Scaffold(
      backgroundColor: Color(0xfff5f6fb),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 12,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 15,
                // width: MediaQuery.of(context).size.width / 1.3,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
                      width: MediaQuery.of(context).size.width / 3,
                    ),
                    Text(
                      "Support",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 50,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text("How may we",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 120,
                      ),
                    Text("help you?",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),

                      SizedBox(
                        height: MediaQuery.of(context).size.height / 120,
                      ),
                      Text("Let us know your queries and feedbacks",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 50,
                      ),
                      CustomTextFormField(
                        name: 'textform',
                        width: double.infinity,
                        Icon: Icons.mail,
                        hint: "Email Address",
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 80,
                      ),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Card(
                      color: Colors.white,
                      elevation: 0,
                      child: Container(
                        color: Colors.indigo[100],
                        height: MediaQuery.of(context).size.height/7,
                        width: double.infinity,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.edit),
                            // fillColor: Color(0x25888888),
                           // filled: true,
                            hintText: "Write your message",
                          ),
                        ),
                      ),
                    ),
                  ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 40,
                      ),
                      InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, "appointmentDetails");
                          },
                          child: CustomButton(name: "Submit")),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height/3,
                        width: MediaQuery.of(context).size.width/1,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black, // Set the border color
                            width: 0.5, // Set the border width
                          ),
                        ),
                        child: Image.asset("assets/images/Group 423.png"),
                      ),
                    ],),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
