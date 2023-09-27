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
class VerifyScreen extends StatefulWidget {
  final OTP;
  final MOBILE;
  const VerifyScreen({Key? key, this.OTP, this.MOBILE}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {

  var verifie;
  verifyOtp() async{
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
      final jsonresponse = json.decode(finalResponse);
      String? user_id = jsonresponse['data'][0]['id'];
      preferences.setString("user_id", user_id ?? "");
      user_name = jsonresponse['data'][0]['username'];
      preferences.setString('user_name', user_name ?? "");
      print("userr nameee iss ${user_name}");
      print("Userrrr Id Is ${user_id.toString()}");
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  FindPetStuff()));
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
    return  Scaffold(
      backgroundColor: colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Verify", style: TextStyle(fontSize: 17, color: colors.primary)),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back_ios_new, color: colors.primary,)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 58.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Code has sent to",
                  style: TextStyle(
                    fontSize: 25,
                    color: colors.black,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Text(
                  "${widget.MOBILE}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,letterSpacing: 1.5),
                ),
              ),
              Text("OTP:${widget.OTP}"),
              OtpTextField(
                numberOfFields: 4,
                borderColor: Colors.red,
                focusedBorderColor: Colors.blue,
                showFieldAsBox: false,
                borderWidth: 2.0,
                //runs when a code is typed in
                onCodeChanged: (String code) {
                  print(code);
                  // pinCodeController.text=code;
                  //  controller=code;
                  //handle validation or checks here if necessary
                },
                //runs when every textfield is filled
                onSubmit: (String verificationCode) {
                  // controller = verificationCode;
                },),

              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 5),
                child: Text(
                  "Haven't received the verification code?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ),
              InkWell(
                onTap: (){
                  // postData(context);
                },
                child: const Text("Resend",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
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
                    verifyOtp();
                    //mobileNumber = mobile;
                    //  final SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
                    // sharedPreferences.setString('otp1', pinCodeController.text);
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>B2BHome()));
                    // print("$mobileController.text");

                  },
                  child: Container(
                    width: 310,
                    height: 48,
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                        child: Text(
                          "Verify Authentication Code",
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
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
