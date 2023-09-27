import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:muddypawsuser/Api.path.dart';
import '../../Custom/CustomButton.dart';
import '../../Custom/CustomTextFormField.dart';
import '../FindPets.dart';
import 'LoginScreen.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  bool isLoading = false;
  userRegister() async {
    setState(() {
      isLoading == true;
    });
    var headers = {
      'Cookie': 'ci_session=277e7c6647d643aab2656347c63577a2dac329e2'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.registerUser));
    request.fields.addAll({
      'name': nameCtr.text,
      'email': emailCtr.text,
      'mobile': mobileCtr.text,
      'country_code': '91'
    });
    print("register parameteer ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      Fluttertoast.showToast(msg: "Register Successfull");
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }
    else {
      print(response.reasonPhrase);
    }
    setState(() {
      isLoading = false;
    });
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameCtr = TextEditingController();
  TextEditingController emailCtr =  TextEditingController();
  TextEditingController mobileCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
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
                          FocusScope.of(context).unfocus();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 18,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                      ),
                      const Text(
                        "Register Now",
                        style:
                            TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 17,
                ),
                const Text(
                  "Your phone number is not registered yet.",
                  style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Let us know basic details for registration.",
                  style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 17,
                ),
            Container(
              height: MediaQuery.of(context).size.height/12.7,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.indigo[100]),
              child: Center(
                child: TextFormField(
                  controller: nameCtr,
                  // enabled: false,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.person),
                    // fillColor: Color(0x25888888),
                    // filled: true,
                    hintText: "Full Name",

                  ),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "name is required";
                    }
                  },
                ),
              ),
            ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/60,
                ),
                Container(
                  height: MediaQuery.of(context).size.height/12.7,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.indigo[100]),
                  child: Center(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: mobileCtr,
                      // enabled: false,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.call),
                        // fillColor: Color(0x25888888),
                        // filled: true,
                        hintText: "Mobile",
                      ),
                      validator: (v) {
                        if (v!.length < 10) {
                          return "Enter Valid Mobile Number";
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/60,
                ),
                Container(
                  height: MediaQuery.of(context).size.height/12.7,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.indigo[100]),
                  child: Center(
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailCtr,
                      // enabled: false,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.email),
                        // fillColor: Color(0x25888888),
                        // filled: true,
                        hintText: "Email",
                      ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "";
                        }
                        if (!v.contains("@")) {
                          return "Enter Valid Email Id";
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/60,
                ),
                InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        userRegister();
                      } else {
                        const snackBar = SnackBar(
                          content: Text('All Fields are required!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                      }
                      ///1st UI
                     // Navigator.pushNamed(context, "myAppointments");
                      ///2nd UI
                      // Navigator.pushNamed(context, "findPetStuff");
                    },
                    child: const CustomButton(name: "Continue")),
                SizedBox(
                  height: MediaQuery.of(context).size.height/20,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Back to sign in",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black))),
                SizedBox(
                  height: MediaQuery.of(context).size.height/20,
                ),
                const Text(
                  "We'll send an OTP on above",
                  style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
                ),
                const Text(
                  "given phone number",
                  style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
