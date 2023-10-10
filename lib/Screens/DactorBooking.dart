import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:muddypawsuser/Api.path.dart';
import 'package:muddypawsuser/Models/GetPetsModel.dart';
import 'package:muddypawsuser/Models/GetPlansModel.dart';
import 'package:muddypawsuser/Screens/FindPets.dart';
import 'package:muddypawsuser/Screens/MyAppointmentsUser.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Colors.dart';
import 'package:http/http.dart'  as http;

import '../Models/GetTimeSlot.dart';
import 'Auth/VerifyOtp.dart';
import 'BottomNavigationScreens/StoreScreen.dart';

class DactorBooking extends StatefulWidget {
  final id;
  String? fees;
var pettName;
var petTypee;
var petIdd;
   DactorBooking({Key? key, this.id, this.fees, this.pettName,this.petTypee,this.petIdd}) : super(key: key);

  @override
  State<DactorBooking> createState() => _DactorBookingState();
}

class _DactorBookingState extends State<DactorBooking> {

  initState() {
    super.initState();
    print("pet name hererer ${widget.petTypee}");
    print("pet type hererer ${widget.pettName}");
    print("pet idd hererer ${widget.petIdd}");
    userName();
    userMobile();
    petName();
    petType();
    getPets();
    getSubscription();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    // getTimeSlot();
  }


  TextEditingController namecn = TextEditingController();
  TextEditingController petTypeCtr = TextEditingController();
  TextEditingController mobilecn = TextEditingController();
  TextEditingController petCtr = TextEditingController();
  TextEditingController addresscn = TextEditingController();
  TextEditingController descriptioncn = TextEditingController();
  TextEditingController gstCtr = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final picker = ImagePicker();

  File? imageFile;
  File? petImage;

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  _getFromGallery1() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        petImage = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  _getFromCamera1() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        petImage = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Image'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                _getFromCamera();
              },
              //return false when click on "NO"
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.camera_alt,color: Colors.white,),
                  SizedBox(width: 10,),
                  Text('Image from Camera'),
                ],
              ),
            ),
            SizedBox(height: 15,),
            ElevatedButton(
              onPressed: (){
                _getFromGallery();
                // Navigator.pop(context,true);
                // Navigator.pop(context,true);
              },
              //return true when click on "Yes"
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.photo,color: Colors.white,),
                  SizedBox(width: 10,),
                  Text('Image from Gallery'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> showExitPopup1() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Image'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                _getFromCamera1();
              },
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.camera_alt,color: Colors.white,),
                  SizedBox(width: 10,),
                  Text('Image from Camera'),
                ],
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: (){
                _getFromGallery1();
              },
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.photo,color: Colors.white,),
                  SizedBox(width: 10,),
                  Text('Image from Gallery'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  GetPlansModel? getPlansModel;
  getSubscription() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('user_id');
    var headers = {
      'Cookie': 'ci_session=d63d2b098e3e8855e223a24db49e06a263e677e6'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.getPlans));
    request.fields.addAll({
      'user_id': "${userId}"
    });
    print("get planss ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult = GetPlansModel.fromJson(json.decode(finalResponse));
      setState(() {
        getPlansModel = finalResult;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  String? selected_pets;
  bool isLoading = true;

  GetPetsModel? getpetsmodel;
  getPets() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('user_id');
    var headers = {
      'Cookie': 'ci_session=2b56b25790a6b3730de399acf97f00e2136c0f20'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.petProfiles));
    request.fields.addAll({
      'user_id': "${userId}"
    });
    print("get pets user id ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = GetPetsModel.fromJson(json.decode(finalResponse));
      setState(() {
        getpetsmodel = jsonResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  GetTimeSlot? getTimeslot;
  getTimeSlot() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('user_id');
    var headers = {
      'Cookie': 'ci_session=d797d115777c4c03069a2accf19146ebd9aa00e2'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.getTimeSlot));
    request.fields.addAll({
      'user_id': '$userId',
      'date': startDateController.text
    });
    print("get time slot paarar ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = GetTimeSlot.fromJson(json.decode(finalResponse));
      print("responseee ${finalResponse}");
     setState(() {
       getTimeslot = jsonResponse;
     });
     setState(() {
       isLoading = false;
     });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  bookAppoinmtment() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('user_id');
    var headers = {
      'Cookie': 'ci_session=6bd0ff14aa4ac547d58134fe26894dc6bb9a70af'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.bookAppointment));
    request.fields.addAll({
      'user_id': '$userId',
      'pet_id': widget.petIdd,
      'doctor_id': '${widget.id}',
      'description': descriptioncn.text,
      'date': startDateController.text,
      'time': selectedTime.toString(),
      'transaction_id': 'TXN1235455555',
      'payment_type': "online",
      'amount': "${widget.fees}"
    });
    print("bookinggg api parameter ${request.fields}");
    request.files.add(await http.MultipartFile.fromPath('report_image', userImage!.path.toString()));
    request.files.add(await http.MultipartFile.fromPath('pet_image', petsImage!.path.toString()));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonresponse = json.decode(finalResponse);
      Fluttertoast.showToast(msg: "Booking Successfully");
      //
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyAppointment()));
    }
    else {
      print(response.reasonPhrase);
    }
  }

  String? selectedTime;
  int selectedTimeIndex = -1;
  String? selectedSubscription = '';
  String? selectedWallet = '';
  String? selectedOnlinePayment = '';
  String _dateValue = '';
  var dateFormate;

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }
  Future _selectDateStart() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate:  DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                primaryColor: colors.primary,
                accentColor: Colors.black,
                colorScheme:  ColorScheme.light(primary:  colors.primary),
                // ColorScheme.light(primary: const Color(0xFFEB6C67)),
                buttonTheme:
                ButtonThemeData(textTheme: ButtonTextTheme.accent)),
            child: child!,
          );
        });
    if (picked != null)
      setState(() {
        String yourDate = picked.toString();
        _dateValue = convertDateTimeDisplay(yourDate);
        print(_dateValue);
        dateFormate = DateFormat("yyyy/MM/dd").format(DateTime.parse(_dateValue ?? ""));
        startDateController = TextEditingController(text: _dateValue);
      });
    getTimeSlot();
  }

  userName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_name = preferences.getString('user_name');
    namecn.text = user_name.toString();
    print("userr nameee isss $user_name");
  }

 userMobile() async {
   SharedPreferences preferences = await SharedPreferences.getInstance();
   user_mobile = preferences.getString('user_mobile');
   print("userr nameee isss $user_mobile");
   mobilecn.text = user_mobile.toString();
 }

 petName() async {
     petCtr.text = widget.pettName.toString();
 }

 petType() async {
    petTypeCtr.text = widget.petTypee.toString();

 }

  String dropdownvalue = "Dog";
  var items = [
    'Dog',
    'Cat',
  ];


  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(msg: "Payment successfully");
    bookAppoinmtment();
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment cancelled by user");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
  }

  Razorpay? _razorpay;
  int? pricerazorpayy;
  void openCheckout(amount) async {
    double res = double.parse(amount.toString());
    pricerazorpayy= int.parse(res.toStringAsFixed(0)) * 100;
    print("checking razorpay price ${pricerazorpayy.toString()}");
    print("aaaaaaaaaaaaaa${amount}");
    // Navigator.of(context).pop();
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': pricerazorpayy,
      'name': 'Muddy',
      'image':'assets/images/Group 165.png',
      'description': 'Muddy',
    };
    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

File? petsImage;
  File? userImage;
  Future<void> pickImage(ImageSource source, String type) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      maxHeight: 100,
      maxWidth: 100,
      imageQuality: 50, // You can adjust the image quality here
    );
    if (pickedFile != null) {
      setState(() {
        if (type == 'userImage') {
          userImage = File(pickedFile.path);
        } else if (type == 'petsImage') {
          petsImage = File(pickedFile.path);
        }
      });
    }
  }


  showAlertDialog(BuildContext context, String type) {
    AlertDialog alert = AlertDialog(
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Container(
            height: 250,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:  BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 5,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(75),
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Select Any One Option',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        print(type);
                        Navigator.of(context).pop();
                        // pickImage(ImageSource.gallery, type);
                        pickImage(ImageSource.gallery, type);
                      },
                      child: Card(
                        elevation: 5,
                        child: Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(child: Text('Select From Gallery')),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        print(type);
                        Navigator.of(context).pop();
                        pickImage(ImageSource.camera, type);
                      },
                      child: Card(
                        elevation: 5,
                        child: Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(child: Text('Select From Camera')),
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f6fb),
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios, color: colors.black),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: colors.white,
        title: const Text("Booking Appointment", style: TextStyle(fontSize: 15, color: colors.black, fontWeight: FontWeight.w500, fontFamily: "Montserrat")),
      ),
      body:
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Name",
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold, fontFamily: "Montserrat"),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height *.01,
                    ),
                    Container(
                      height: 50,
                      child: TextFormField(
                          readOnly: true,
                          keyboardType: TextInputType.text,
                          controller: namecn,
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'Please Enter Your Name';
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 17, left: 9),
                              hintText: '',
                              hintStyle: TextStyle(fontFamily: "Montserrat"),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                              ),
                          ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    // const Text(
                    //   "Email",
                    //   style: TextStyle(
                    //       fontSize: 14, fontWeight: FontWeight.bold),
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * .02,
                    // ),
                    // TextFormField(
                    //     keyboardType: TextInputType.emailAddress,
                    //     controller: emailcn,
                    //     validator: (value) {
                    //       if (value!.isEmpty) {
                    //         return 'Please Enter Your Email';
                    //       }
                    //       return null;
                    //     },
                    //     decoration: InputDecoration(
                    //         hintText: '',
                    //         border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(15)))),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * .02,
                    // ),
                    const Text(
                      "Mobile",
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold,fontFamily: "Montserrat"),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    Container(
                      height: 50,
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          // maxLength: 10,
                          controller: mobilecn,
                          // validator: (value) {
                          //   if (value!.isEmpty || value.length < 10) {
                          //     return 'Please Enter Your Mobile No';
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 19, left: 9),
                              hintText: '',
                              counterText: "",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),),),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    const Text(
                      "Pet Type",
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold,fontFamily: "Montserrat"),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    Container(
                      height: 50,
                      child: TextFormField(
                        textAlign: TextAlign.left,
                        readOnly: true,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          controller: petTypeCtr,
                          // validator: (value) {
                          //   if (value!.isEmpty || value.length < 10) {
                          //     return 'Please Enter Your Mobile No';
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 19, left: 9),
                              hintText: '',
                              counterText: "",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                              ),
                          ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*.01,
                    ),
                    const Text(
                      "Pet Name",
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold, fontFamily: "Montserrat"),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*.01,
                    ),
                    Container(
                      height: 50,
                      child: TextFormField(
                        readOnly: true,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          controller: petCtr,
                          // validator: (value) {
                          //   if (value!.isEmpty || value.length < 10) {
                          //     return 'Please Enter Your Mobile No';
                          //   }
                          //   return null;
                          // },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 19, left: 9),
                              hintText: '',
                              counterText: "",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    const Text(
                      "Reason For Consultation",
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold, fontFamily: "Montserrat"),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    Container(
                      height: 65,
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: descriptioncn,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Description';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 19, left: 9),
                              hintText: '',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*.01,
                    ),
                    const Text(
                      "Date",
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold, fontFamily: "Montserrat"),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    TextFormField(
                      onTap: () {
                        _selectDateStart();
                      },
                      controller: startDateController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          counterText: "",
                          hintText: 'Select Date',
                          hintStyle: const TextStyle(fontFamily: "Montserrat"),
                        contentPadding: const EdgeInsets.only(top: 19, left: 9),
                      ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Start Date is required";
                        }
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*.01,
                    ),
                    const Text("Select Time Slot", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: "Montserrat"),
                    ),
                    const SizedBox(height: 10),
                     Container(
                      height: 50,
                      child: getTimeslot?.data != null || getTimeslot?.data != "" ? ListView.builder(
                        itemCount: getTimeslot?.data?.length ?? 0,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedTime = getTimeslot?.data?[index].time;
                              selectedTimeIndex = index;
                            });
                            print('this is selected time $selectedTime');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedTimeIndex == index ? colors.primary: colors.white,
                                border: Border.all(color: colors.primary),
                                borderRadius: BorderRadius.circular(10),
                            ),
                            height: 40,
                            width: 100,
                            child: Center(
                              child: Text("${getTimeslot?.data?[index].time}",
                              style:  TextStyle(
                                  fontWeight: FontWeight.w600, fontSize:11,
                                  color: selectedTimeIndex == index ? colors.white: colors.primary,
                              ),
                            ),
                            ),
                          ),
                        );
                      }
                      ): const SizedBox.shrink(),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    //    const Text("Select Payment", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                 //    ),
                 // Column(
                 //   crossAxisAlignment: CrossAxisAlignment.start,
                 //    children: [
                 //      Row(
                 //        children: [
                 //          Row(
                 //            children: <Widget>[
                 //              Text('Subscription: ${getPlansModel?.data?[0].amount}', style: const TextStyle(fontSize: 12),),
                 //              Radio(
                 //                value: 'Subscription',
                 //                groupValue: selectedSubscription,
                 //                onChanged: (value) {
                 //                  setState(() {
                 //                    selectedSubscription = value;
                 //                  });
                 //                },
                 //              ),
                 //              const Text('Wallet', style: TextStyle(fontSize: 12)),
                 //              Radio(
                 //                value: 'Wallet',
                 //                groupValue: selectedWallet,
                 //                onChanged: (value) {
                 //                  setState(() {
                 //                    selectedWallet = value;
                 //                  });
                 //                },
                 //              ),
                 //            ],
                 //          ),
                 //          // Radio buttons for Wallet
                 //          // Row(
                 //          //   children: <Widget>[
                 //          //     Text('Online', style: TextStyle(fontSize: 12)),
                 //          //     Radio(
                 //          //       value: 'Online',
                 //          //       groupValue: selectedOnlinePayment,
                 //          //       onChanged: (value) {
                 //          //         setState(() {
                 //          //           selectedOnlinePayment = value;
                 //          //         });
                 //          //       },
                 //          //     ),
                 //          //   ],
                 //          // ),
                 //        ],
                 //      ),
                 // //     RadioListTile(
                 // //     title: const Text('Subscription', style: TextStyle(fontSize: 14)),
                 // //    value: 'Subscription',
                 // //    groupValue: selecteSubscription,
                 // //    onChanged: (value) {
                 // //     setState(() {
                 // //       selecteSubscription = value;
                 // //     });
                 // //   },
                 // // ),
                 // //      Text("${getPlansModel?.data?[0].amount}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: colors.black),
                 // //      ),
                 // // // RadioListTile(
                 // // //   title: Text('Wallet'),
                 // // //   value: 'Wallet',
                 // // //   groupValue: selecteWallet,
                 // // //   onChanged: (value) {
                 // // //     setState(() {
                 // // //       selecteWallet = value;
                 // // //     });
                 // // //   },
                 // // // ),
                 // // RadioListTile(
                 // //   title: Text('Online Payment'),
                 // //   value: 'Online Payment',
                 // //   groupValue: selecteOnline,
                 // //   onChanged: (value) {
                 // //     setState(() {
                 // //       selecteOnline = value;
                 // //     });
                 // //   },
                 // //     ),
                 //   ],
                 // ),
                 //    SizedBox(
                 //      height: MediaQuery.of(context).size.height *.02,
                 //    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: colors.primary),
                        onPressed: () {
                          showAlertDialog(context, "userImage");
                         // showExitPopup();
                        },
                        child: const Text("Upload Documents", style: TextStyle(fontSize: 15,fontFamily: "Montserrat")),
                    ),
                    const SizedBox(height: 10),
                    userImage == null ? const SizedBox.shrink(): InkWell(
                      onTap: () {
                        showAlertDialog(context, "userImage");
                      },
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: Image.file(userImage!,fit: BoxFit.fill,),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: colors.primary),
                        onPressed: () {
                          showAlertDialog(context, "petsImage");
                        },
                        child: const Text("Upload Pet's Image", style: TextStyle(fontSize: 15, fontFamily: "Montserrat"),)),
                    SizedBox(height: 10,),
                    petsImage == null ? SizedBox.shrink() :  InkWell(
                      onTap: () {
                        showAlertDialog(context, "petsImage");
                      },
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: Image.file(petsImage!,fit: BoxFit.fill,),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    // bookAppoinmtment();
                    // String? amount = (widget.fees * 100);
                    openCheckout(widget.fees);
                    print("amounttttttttt ${widget.fees}");
                  }
                  else{
                    Fluttertoast.showToast(msg: "All Fields Required");
                  }
                },
                child: Center(
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width/1.2,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.primary),
                      child: const Center(
                          child: Text("Book Appointment", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400, fontFamily: "Montserrat"))),)
                  // ElevatedButton(
                  //    style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                  //     onPressed: () {
                  //       if (_formKey.currentState!.validate()) {
                  //         addVendor();
                  //       }
                  //       else{
                  //         Fluttertoast.showToast(msg: "All Fields Required");
                  //       }
                  //     },
                  //     child: const Text("Submit")),
                ),
              ),
              SizedBox(height: 10,)
            ],
          ),
        ),
      ),
    );
  }
}
