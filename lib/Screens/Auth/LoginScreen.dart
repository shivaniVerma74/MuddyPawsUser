import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:muddypawsuser/Api.path.dart';
import 'package:muddypawsuser/Screens/Auth/VerifyOtp.dart';
import '../../Custom/CustomButton.dart';
import '../../Custom/CustomTextFormField.dart';
import '../PillRemainders.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController mobileController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  userLogin() async {
    var headers = {
      'Cookie': 'ci_session=ee0b68ed91f87074378ac788cf7e9297a4c76f3e'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.sendOtpUser));
    request.fields.addAll({
      'mobile': mobileController.text,
    });
    print("login parammeter ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("worikng#####");
      var finalResponse = await response.stream.bytesToString();
      final jsonresponse = json.decode(finalResponse);
      if (jsonresponse['error'] == false) {
        int otp = jsonresponse['data']['otp'];
        String mobile = jsonresponse['data']['mobile'];
        print('____App_________${mobile}__${otp}___');
        Fluttertoast.showToast(msg: '${jsonresponse['message']}');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => VerifyScreen(
                  OTP: otp,
                  MOBILE: mobile,
                ),
            ),
        );
      } else {
        Fluttertoast.showToast(msg: "${jsonresponse['message']}");
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
        child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 12,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 100,
                  width: 100,
                  child: Image.asset('assets/images/Group 165.png'),
                ),
              ),
              // const Text(
              //   "Care Provider App",
              //   style: TextStyle(fontSize: 15, color: Colors.grey),
              // ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 19,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 1,
                child: Image.asset('assets/images/Group 423.png'),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 39,
              ),
              Card(
                elevation: 3,
                child: Container(
                  height: MediaQuery.of(context).size.height/12.7,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),),
                  child: Center(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: mobileController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.call),
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
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height/69,
              ),
             InkWell(
                 onTap: (){
                   if (_formKey.currentState!.validate()) {
                     userLogin();
                   } else {
                     const snackBar = SnackBar(
                       content: Text('Enter Mobile No.'),
                     );
                     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                     //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                   }
                 },
                 child: CustomButton(name: "Continue")),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height/19,
              // ),
              // const Text("Quick Continue With",
              //     style: TextStyle(
              //       fontSize: 15,
              //     )),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height/69,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     Container(
              //       height: MediaQuery.of(context).size.height/15,
              //       width: MediaQuery.of(context).size.width/2.2,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(8),
              //         color: Colors.blue,
              //       ),
              //       child: Row(
              //         children: [
              //           SizedBox(
              //             width: MediaQuery.of(context).size.width/45,
              //           ),
              //           const Icon(
              //             Icons.facebook,
              //             color: Colors.white,
              //           ),
              //           SizedBox(
              //             width: MediaQuery.of(context).size.width/17,
              //           ),
              //           const Text(
              //             "Facebook",
              //             style: TextStyle(fontSize: 17, color: Colors.white),
              //           ),
              //         ],
              //       ),
              //     ),
              //     Container(
              //       height: MediaQuery.of(context).size.height/15,
              //       width: MediaQuery.of(context).size.width/2.2,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(8),
              //         color: Colors.white,
              //       ),
              //       child: Row(
              //         children: [
              //           SizedBox(
              //             width: MediaQuery.of(context).size.width / 45,
              //           ),
              //           Container(
              //               height: 26,
              //               width: 26,
              //               child: Image.asset(
              //                   "assets/images/icons8-google-48.png")),
              //           SizedBox(
              //             width: MediaQuery.of(context).size.width / 17,
              //           ),
              //           const Text("Gmail"),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: MediaQuery.of(context).size.height / 39,
              // ),
              SizedBox(height: 10,),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "register");
                  },
                  child: const Text(
                    "Not a registered user? Register with us",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black, fontFamily: "Montserrat"),
                  ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
