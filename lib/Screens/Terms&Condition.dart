import 'package:flutter/material.dart';

class Terms extends StatefulWidget {
  const Terms({Key? key}) : super(key: key);

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(children: [
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
                    width: MediaQuery.of(context).size.width / 5.7,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, "faq");
                    },
                    child: Text(
                      "Terms & Conditions",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 23,
            ),
            RichText(
                  text: TextSpan(
              style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              height: 1.5,fontWeight: FontWeight.w500 // Adjust this value to change line spacing
            ),
              children:<TextSpan> [
                TextSpan(text:"Lorem ipsum dolor sit amet,consectetur adipiscing elit,sed do eiusmod tempor incididunt"
                    " eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                    "Ut enim ad minim veniam, quis nostrud exercitation ullamco "
                    "laboris nisi ut aliquip ex ea commodo consequat. DUis aute irure dolor eu fugiat "
                    "nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit "
                    "anim id est laborum."),

              ]
            )),
            SizedBox(height: MediaQuery.of(context).size.height/30,),
            RichText(
                text: TextSpan(
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      height: 1.5,fontWeight: FontWeight.w500 // Adjust this value to change line spacing
                    ),
                    children:<TextSpan> [
                      TextSpan(text:"Lorem ipsum dolor sit amet,consectetur adipiscing elit,sed do eiusmod tempor incididunt"
                          " eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                          "Ut enim ad minim veniam, quis nostrud exercitation ullamco "
                          "laboris nisi ut aliquip ex ea commodo consequat. DUis aute irure dolor eu fugiat "
                          "nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit "
                          "anim id est laborum."),

                    ]
                )),
            SizedBox(height: MediaQuery.of(context).size.height/30,),
            RichText(
                text: TextSpan(
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      height: 1.5,fontWeight: FontWeight.w500 // Adjust this value to change line spacing
                    ),
                    children:<TextSpan> [
                      TextSpan(text:"Lorem ipsum dolor sit amet,consectetur adipiscing elit,sed do eiusmod tempor incididunt"
                          " eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                          "Ut enim ad minim veniam, quis nostrud exercitation ullamco "
                          "laboris nisi ut aliquip ex ea commodo consequat. DUis aute irure dolor eu fugiat "
                          "nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit "
                          "anim id est laborum."),

                    ]
                )),
          ]),
        ),
      ),
    );
  }
}
