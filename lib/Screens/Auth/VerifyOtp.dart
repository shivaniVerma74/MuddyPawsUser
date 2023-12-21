import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:muddypawsuser/Api.path.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Colors.dart';
import '../BottomNavigationScreens/PetCareScreen.dart';
import '../BottomNavigationScreens/StoreScreen.dart';
import '../FindPets.dart';

String? user_name;
String? user_mobile;
class VerifyScreen extends StatefulWidget {
  final OTP;
  final MOBILE;
  String? name;
  String? email;
   VerifyScreen({Key? key, this.OTP, this.MOBILE, this.email, this.name}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {

  TextEditingController pinController = TextEditingController();
  String? code;
  String? verifyCode;
  var verifie;

  void initState() {
    super.initState();
    print("otp iss ${widget.OTP}");
  }

  // verifyOtp() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   var headers = {
  //     'Cookie': 'ci_session=64ad8ba0caf5389a6543a8aef4b3241e6dd75f57'
  //   };
  //     var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.registerUser));
  //     request.fields.addAll({
  //       'name': widget.name.toString(),
  //       'email': widget.email.toString(),
  //       'mobile': widget.MOBILE,
  //       'country_code': '91'
  //     });
  //     print("verify Otp parameter ${request.fields}");
  //     request.headers.addAll(headers);
  //     http.StreamedResponse response = await request.send();
  //     if (response.statusCode == 200) {
  //       var finalResponse = await response.stream.bytesToString();
  //       final jsonresponse = json.decode(finalResponse);
  //       if (jsonresponse['error'] == false) {
  //         String? user_id = jsonresponse['data'][0]['id'];
  //         preferences.setString("user_id", user_id ?? "");
  //         user_name = jsonresponse['data'][0]['username'];
  //         user_mobile = jsonresponse['data'][0]['mobile'];
  //         preferences.setString('user_mobile', user_mobile ?? "");
  //         preferences.setString('user_name', user_name ?? "");
  //         print("userr nameee iss ${user_mobile}");
  //         print("userr nameee iss ${user_name}");
  //         print("Userrrr Id Is ${user_id.toString()}");
  //         Fluttertoast.showToast(msg: '${jsonresponse['message']}');
  //         Navigator.push(context,
  //             MaterialPageRoute(builder: (context) => const FindPetStuff()));
  //       }
  //       else {
  //         Fluttertoast.showToast(msg: "${jsonresponse['message']}");
  //       }
  //       // if(widget.OTP == verifie){
  //       //   Fluttertoast.showToast(msg: '${jsonresponse['message']}');
  //       //   Navigator.push(context, MaterialPageRoute(builder: (context) =>  FindPetStuff()));
  //       // }
  //       // else{
  //       //   Fluttertoast.showToast(msg: 'Enter correct otp');
  //       // }
  //       // Fluttertoast.showToast(msg: '${jsonresponse['message']}');
  //       // Navigator.push(context, MaterialPageRoute(builder: (context) => FindPetStuff()));
  //     }
  //     else {
  //       print(response.reasonPhrase);
  //     }
  // }

  verifyOtp() async {
    String? user_id;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var headers = {
      'Cookie': 'ci_session=64ad8ba0caf5389a6543a8aef4b3241e6dd75f57'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.verifyOtpUser));
    request.fields.addAll({
      'mobile': widget.MOBILE,
      'otp': widget.OTP.toString(),
      'device_token': ''
    });
    print("verify Otp parameter ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      print('=======================${finalResponse}');

      final jsonresponse = json.decode(finalResponse);
      print('=======================${jsonresponse['error']}');
      if (jsonresponse['error'] == false) {
        setState(() {
          user_id = jsonresponse['data'][0]['id'];
        });
        preferences.setString("user_id", user_id ?? "");
        user_name = jsonresponse['data'][0]['username'];
        user_mobile = jsonresponse['data'][0]['mobile'];
        preferences.setString('user_mobile', user_mobile ?? "");
        preferences.setString('user_name', user_name ?? "");
        print("userr nameee iss ${user_mobile}");
        print("userr nameee iss ${user_name}");
        print("Userrrr Id Is ${user_id.toString()}");
        Fluttertoast.showToast(msg: 'OTP Verified');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const FindPetStuff()));
      }
      else {

        Fluttertoast.showToast(msg: jsonresponse['message']);

        // Fluttertoast.showToast(msg: "${jsonresponse['message']}");
      }
      // if(widget.OTP == verifie){
      //   Fluttertoast.showToast(msg: '${jsonresponse['message']}');
      //   Navigator.push(context, MaterialPageRoute(builder: (context) =>  FindPetStuff()));
      // }
      // else{
      //   Fluttertoast.showToast(msg: 'Enter correct otp');
      // }
      // Fluttertoast.showToast(msg: '${jsonresponse['message']}');
      // Navigator.push(context, MaterialPageRoute(builder: (context) => FindPetStuff()));
    }
    else {
      print(response.reasonPhrase);
    }
  }


  @override
  Widget build(BuildContext context) {
    return

      Scaffold(
      backgroundColor: colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Verify Mobile Number", style: TextStyle(fontSize: 15, color: colors.primary, fontFamily: "Montserrat")),
        // leading: InkWell(
        //   onTap: () {
        //     Navigator.pop(context);
        //   },
        //     child: Icon(Icons.arrow_back_ios_new, color: colors.primary,)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "OTP Sent",
                  style: TextStyle(
                    fontSize: 20,
                    color: colors.black,
                    fontWeight: FontWeight.w500, fontFamily: "Montserrat"
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Text(
                  "Mobile: ${widget.MOBILE}",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,letterSpacing: 1.5),
                ),
              ),
              Text("OTP: ${widget.OTP}"),

              OtpTextField(
                numberOfFields: 4,
                borderColor: Colors.red,
                focusedBorderColor: Colors.blue,
                showFieldAsBox: false,
                borderWidth: 2.0,
                //runs when a code is typed in
                onCodeChanged: (code) {
                },
                //runs when every textfield is filled
                  onSubmit: (String verificationCode) {
                    pinController.text = verificationCode;
                    if(widget.OTP.toString() == pinController.text){
                      // Fluttertoast.showToast(msg: "Otp  is match ",backgroundColor: colors.primary);
                    }else{
                      // Fluttertoast.showToast(msg: "Otp Incorrect ",backgroundColor: colors.primary);
                    }
                  }
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 5),
                child: Text(
                  "Didn't receive OTP yet?",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, fontFamily: "Montserrat"),
                ),
              ),

              InkWell(
                onTap: () {
                  // postData(context);
                },
                child: const Text("Resend",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, fontFamily: "Montserrat")),
              ),

              Padding(
                padding: const EdgeInsets.only(
                  top: 48,
                ),
                // child: InkWell(
                //   onTap: () {
                //     verifyData();
                //     print("${widget.currentOtp}");
                //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>Sixth()));
                //   },
                child: InkWell(
                  onTap: () async{
                    if(pinController.text==widget.OTP.toString()){
                      verifyOtp();
                    } else {
                      Fluttertoast.showToast(msg: "Please enter valid otp!",backgroundColor: colors.primary);
                    }
                    //mobileNumber = mobile;
                    //  final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                    // sharedPreferences.setString('otp1', pinCodeController.text);
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>B2BHome()));
                    // print("$mobileController.text");
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width/1.2,
                    height: 48,
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                        child: Text(
                          "Submit OTP",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white, fontFamily: "Montserrat"),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
