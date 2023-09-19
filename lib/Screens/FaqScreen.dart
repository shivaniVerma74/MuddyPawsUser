import 'package:flutter/material.dart';

import '../Custom/CustomCard.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [

              Container(padding: EdgeInsets.all(12),
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
                      width: MediaQuery.of(context).size.width / 3,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "myprofile");
                      },
                      child: Text(
                        "FAQs",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 240,
              ),
              CustomCard3(title: "1. How to Login to App?"),
              SizedBox(
                height: MediaQuery.of(context).size.height / 240,
              ),
          Container(padding: EdgeInsets.all(12),
            width: double.infinity,
          //  height: MediaQuery.of(context).size.height / 16,
            // width: MediaQuery.of(context).size.width / 1.3,
            decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(4),color: Colors.white),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "2. How to book an appointment?",
                  style:
                  TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 240,
                ),
                Container(padding: EdgeInsets.all(12),
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    "Lorem ipsum dolor sit amet,consectetur adipiscing elit,sed do eiusmod tempor incididunt"
                        " eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    style:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.w500,color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),

              SizedBox(
                height: MediaQuery.of(context).size.height / 240,
              ),
              CustomCard3(title: "3. How to cancel an appointment?"),
              SizedBox(
                height: MediaQuery.of(context).size.height / 240,
              ),
              CustomCard3(title: "4. What if I failed to book?"),
              SizedBox(
                height: MediaQuery.of(context).size.height / 240,
              ),
              CustomCard3(title: "5. How to Payment?"),
              SizedBox(
                height: MediaQuery.of(context).size.height / 240,
              ),
              CustomCard3(title: "6. Payment modes available?"),
              SizedBox(
                height: MediaQuery.of(context).size.height / 240,
              ),
              CustomCard3(title: "7. What if I failed to book?"),

              SizedBox(
                height: MediaQuery.of(context).size.height / 240,
              ),
              CustomCard3(title: "8. How to pay?"),
              SizedBox(
                height: MediaQuery.of(context).size.height / 240,
              ),
              CustomCard3(title: "9. Payment modes available?"),
              SizedBox(
                height: MediaQuery.of(context).size.height / 240,
              ),
              CustomCard3(title: "10. How to Payment?"),
              SizedBox(
                height: MediaQuery.of(context).size.height / 240,
              ),
              CustomCard3(title: "11. Payment modes available?"),
              SizedBox(
                height: MediaQuery.of(context).size.height / 240,
              ),
              CustomCard3(title: "12. What if I failed to book?"),
              SizedBox(
                height: MediaQuery.of(context).size.height / 240,
              ),
              CustomCard3(title: "13. How to pay"),
              SizedBox(
                height: MediaQuery.of(context).size.height / 240,
              ),
              CustomCard3(title: "14. Payment modes available?"),
            ],
          ),
        ),
      ),
    );
  }
}
