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
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Colors.dart';
import 'package:http/http.dart'  as http;

import '../Models/GetTimeSlot.dart';
import 'BottomNavigationScreens/StoreScreen.dart';

class DactorBooking extends StatefulWidget {
  final id;
  String? fees;
   DactorBooking({Key? key, this.id, this.fees}) : super(key: key);

  @override
  State<DactorBooking> createState() => _DactorBookingState();
}

class _DactorBookingState extends State<DactorBooking> {

  TextEditingController namecn = TextEditingController();
  TextEditingController emailcn = TextEditingController();
  TextEditingController mobilecn = TextEditingController();
  TextEditingController eventcn = TextEditingController();
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


  initState() {
    super.initState();
    print("feessss ${widget.fees}");
    getPets();
    getSubscription();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    // getTimeSlot();
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
      'user_id': '${userId}',
      'date': '${startDateController.text}'
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
      'user_id': '${userId}',
      'pet_id': dropdownvalue,
      'doctor_id': '${widget.id}',
      'description': '${descriptioncn.text}',
      'date': "${startDateController.text}",
      'time': selectedTime.toString(),
      'transaction_id': 'TXN1235455555',
      'payment_type': "online",
      'amount': "${widget.fees}"
    });
    print("bookinggg api parameter ${request.fields}");
    request.files.add(await http.MultipartFile.fromPath('report_image', imageFile!.path.toString()));
    request.files.add(await http.MultipartFile.fromPath('pet_image', petImage!.path.toString()));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonresponse = json.decode(finalResponse);
      Fluttertoast.showToast(msg: "Booking Successfully");
      //
      // Navigator.push(context, MaterialPageRoute(builder: (context) => Store()));
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
    String res = amount.toString();
    // Navigator.of(context).pop();
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': "${amount}",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.white,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios, color: colors.black)),
        elevation: 0,
        centerTitle: true,
        backgroundColor: colors.white,
        title: const Text("Booking", style: TextStyle(fontSize: 18, color: colors.black, fontWeight: FontWeight.w500),),
      ),
      body: SingleChildScrollView(
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
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    Container(
                      height: 50,
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: namecn,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: '',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)))),
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
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    Container(
                      height: 50,
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          controller: mobilecn,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 10) {
                              return 'Please Enter Your Mobile No';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: '',
                              counterText: "",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)))),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    // const Text(
                    //   "Service Name",
                    //   style: TextStyle(
                    //       fontSize: 14, fontWeight: FontWeight.bold),
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * .02,
                    // ),
                    // TextFormField(
                    //     keyboardType: TextInputType.text,
                    //     controller: eventcn,
                    //     validator: (value) {
                    //       if (value!.isEmpty) {
                    //         return 'Please Enter Your Event';
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
                      "Pets",
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    // Container(
                    //   height: 60,
                    //   child: DropdownButtonFormField<String>(
                    //     value: selected_pets,
                    //     validator: (value) {
                    //       if (value == null || value.isEmpty) {
                    //         return 'Please Select Pets';
                    //       } else {
                    //         return null;
                    //       }
                    //     },
                    //     onChanged: (newValue) {
                    //       setState(() {
                    //         selected_pets = newValue;
                    //       });
                    //     },
                    //     items: getpetsmodel?.data?.map((items) {
                    //       return DropdownMenuItem(
                    //         value: items.id.toString(),
                    //         child: Text(items.username.toString()),
                    //       );
                    //     }).toList(),
                    //     decoration: InputDecoration(
                    //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    //         hintText: 'Select Pets',
                    //         label: Text('Select Pets',)
                    //     ),
                    //   ),
                    // ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: colors.black.withOpacity(0.4))
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          value: dropdownvalue,
                          hint: Icon(Icons.arrow_drop_down_outlined),
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    const Text(
                      "Description",
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    Container(
                      height: 50,
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
                          fontSize: 14, fontWeight: FontWeight.bold),
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
                          contentPadding: EdgeInsets.only(left: 10)
                      ),
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Start Date is required";
                        }
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    const Text("Booking Time", style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                     Container(
                      height: 50,
                      child: getTimeslot?.data != null || getTimeslot?.data != "" ? ListView.builder(
                        itemCount: getTimeslot?.data?.length ?? 0,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
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
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.circular(10),
                            ),
                            height: 40,
                            width: 100,
                            child: Center(
                              child: Text("${getTimeslot?.data?[index].time}",
                              style:  TextStyle(
                                  fontWeight: FontWeight.w600,fontSize:11,
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
                         showExitPopup();
                        },
                        child: const Text("Upload Report"),
                    ),
                    SizedBox(height: 10),
                    imageFile == null ? SizedBox.shrink():InkWell(
                      onTap: () {
                        showExitPopup();
                      },
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: Image.file(imageFile!,fit: BoxFit.fill,),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: colors.primary),
                        onPressed: () {
                          showExitPopup1();
                        },
                        child: const Text("Upload Pet Image")),
                    SizedBox(height: 10,),
                    petImage == null ? SizedBox.shrink() :  InkWell(
                      onTap: (){
                        showExitPopup1();
                      },
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: Image.file(petImage!,fit: BoxFit.fill,),
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
                      child: const Center(child: Text("Book Appointment", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400))),)
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
