import 'dart:convert';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:muddypawsuser/Api.path.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Colors.dart';
import '../../Custom/CustomCard.dart';
import '../../Models/GetCategoryModel.dart';
import '../../Models/GetPetsModel.dart';
import '../FindPets.dart';

class PetCare extends StatefulWidget {
  const PetCare({Key? key}) : super(key: key);

  @override
  State<PetCare> createState() => _PetCareState();
}

class _PetCareState extends State<PetCare> {
  TextEditingController petNameCtr = TextEditingController();
  TextEditingController ageCtr = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPets();
  }

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
        print("resonseee ${finalResponse}");
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  petProfile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('user_id');
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.createProfile));
    request.fields.addAll({
      'user_id': '$userId',
      'pet_type': dropdownvalue,
      'username': petNameCtr.text,
      'age': ageCtr.text,
      // 'id': '7'
    });

    print("pet profile parammeter ${request.fields}");
    request.files.add(await http.MultipartFile.fromPath('image', imageFile!.path.toString()));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("hjjjjjjjjjjjj");
      var Response = await response.stream.bytesToString();
      var finalResult = jsonDecode(Response);
      print("respinseee $finalResult");
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  const FindPetStuff()));
    }
    else {
      print(response.reasonPhrase);
    }
  }

  String dropdownvalue = "Dog";
  var items = [
    'Dog',
    'Cat',
    'Others'
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xffFFFFFF), // navigation bar color
    statusBarColor: Color(0xffFFFFFF), // status bar color
  ));
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Pets Profile",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Montserrat"),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height/79,
                    ),
                  ],
                ),
              ),
            ),
           Container(
             color: colors.white,
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                 const Text(
                   "Pet Name",
                   style: TextStyle(
                       fontSize: 14, fontWeight: FontWeight.w600, fontFamily: "Montserrat"),
                 ),
                 SizedBox(
                   height: MediaQuery.of(context).size.height * .01,
                 ),
                 TextFormField(
                   controller: petNameCtr,
                   decoration: InputDecoration(
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(10),
                       ),
                       counterText: "",
                       hintText: 'Pet Name',

                       hintStyle: TextStyle(fontSize: 13, fontFamily: "Montserrat"),
                       contentPadding: EdgeInsets.only(left: 10)
                   ),
                   validator: (v) {
                     if (v!.isEmpty) {
                       return "Pet Name is required";
                     }
                   },
                 ),
                   SizedBox(
                     height: MediaQuery.of(context).size.height * .01,
                   ),
                   const Text(
                     "Pet Age",
                     style: TextStyle(
                         fontSize: 14, fontWeight: FontWeight.w600,fontFamily: "Montserrat"),
                   ),
                   SizedBox(
                     height: MediaQuery.of(context).size.height * .01,
                   ),
                   TextFormField(
                     keyboardType: TextInputType.number,
                     controller: ageCtr,
                     decoration: InputDecoration(
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(10),
                         ),
                         counterText: "",
                         hintText: 'Pet Age',
                         hintStyle: TextStyle(fontSize: 13, fontFamily: "Montserrat"),
                         contentPadding: EdgeInsets.only(left: 10)
                     ),
                     validator: (v) {
                       if (v!.isEmpty) {
                         return "Age is required";
                       }
                     },
                   ),
                   SizedBox(
                     height: MediaQuery.of(context).size.height * .01,
                   ),
                   const Text(
                     "Pet Type",
                     style: TextStyle(
                         fontSize: 14, fontWeight: FontWeight.w600, fontFamily: "Montserrat"),
                   ),
                   SizedBox(
                     height: MediaQuery.of(context).size.height * .01,
                   ),
                 /*  Container(
                     height: 60,
                     child: DropdownButtonFormField<String>(
                       value: selectedpets,
                       validator: (value) {
                         if (value == null || value.isEmpty) {
                           return 'Please Select Pets';
                         } else {
                           return null;
                         }
                       },
                       onChanged: (newValue) {
                         setState(() {
                           selectedpets = newValue;
                         });
                       },
                       items: getpetsmodel?.data?.map((items) {
                         return DropdownMenuItem(
                           value: items.id.toString(),
                           child: Text(items.username.toString()),
                         );
                       }).toList(),
                       decoration: InputDecoration(
                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                           hintText: 'Select Pets',
                           label: Text('Select Pets',)
                       ),
                     ),
                   ),*/
                   Container(
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: colors.black.withOpacity(0.4))
                     ),
                     child:
                     DropdownButtonHideUnderline(
                       child: DropdownButton2(
                       isExpanded: true,
                         // Initial Value
                         value: dropdownvalue,
                         hint: Icon(Icons.arrow_drop_down_outlined),
                         items: items.map((String items) {
                           return DropdownMenuItem(
                             value: items,
                             child: Text(items, style: TextStyle(fontFamily: "Montserrat"),),
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
                     height: MediaQuery.of(context).size.height *.02,
                   ),
                   ElevatedButton(
                     style: ElevatedButton.styleFrom(primary: colors.primary),
                     onPressed: () {
                       showExitPopup();
                     },
                     child: const Text("Upload your Pet's photo", style: TextStyle(fontFamily: "Montserrat"),),
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
                     height: MediaQuery.of(context).size.height/7,
                   ),
                   InkWell(
                     onTap: () {
                       petProfile();
                     },
                     child: Center(
                       child: Container(
                         height: 40,
                         width: MediaQuery.of(context).size.width/1.5,
                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.primary),
                           child: const Center(child: Text("Create Profile", style: TextStyle(color: colors.white, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: "Montserrat"),))),
                     ),
                   ),
                   const SizedBox(height: 20)
               ],
               ),
             ),
           ),
          ],
        ),
      ),
    );
  }

  File? imageFile;
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
            const SizedBox(height: 15,),
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
                  Icon(Icons.photo,color: Colors.white),
                  SizedBox(width: 10,),
                  Text('Image from Gallery'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    // ??false; //if showDialouge had returned null, then return false
  }

}
