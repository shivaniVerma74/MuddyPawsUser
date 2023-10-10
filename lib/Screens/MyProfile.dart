import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:image_picker/image_picker.dart';
import 'package:muddypawsuser/Screens/BottomNavigationScreens/Account.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Colors.dart';
import '../Custom/CustomButton.dart';
import '../Models/GetUserDataModel.dart';
import 'myprofile.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  final picker=ImagePicker();
  File? _imageFile;

  // Future<void> _pickImage(ImageSource source) async {
  //   final picker = ImagePicker();
  //   final pickedImage = await picker.pickImage(source: source);
  //   if (pickedImage != null) {
  //     setState(() {
  //       _imageFile = File(pickedImage.path);
  //       // image=_imageFile?.path;
  //       // print('//////////////////${image.path}');
  //     });
  //   }
  // }


  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }


  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      Navigator.pop(context);
    }
  }
  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  _getFromGallery();
                  // _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () {
                  _getFromCamera();
                  // _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
  final TextEditingController phonecn=TextEditingController();
  final TextEditingController namecn=TextEditingController();
  final  TextEditingController emailcn=TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isloading=true;
  @override
  void initState(){
    super.initState();
    getIdData();

    setState(() {
      isloading = true;
    });
    Future.delayed(const Duration(seconds: 3),(){
      setState(() {
        isloading = false;
      });
    });
  }

  var userId;
  Future<void> getIdData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId= preferences.getString('docIdd');
    getdata();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(

      body:isloading?Center(child: CircularProgressIndicator()): SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Color(0xfff5f6fb),
          child: SafeArea(
            child: Column(
                children: [
              Container(padding: EdgeInsets.all(10),
                height: 100,
                // width: MediaQuery.of(context).size.width / 1.3,
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(4),color: Colors.white),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 18,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width/3,
                        ),
                        const Text(
                          "My Profile",
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, fontFamily: "Montserrat"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height/20,
                    ),
                    // Row(
                    //   children: [
                    //     Container(
                    //         height: 170,
                    //         width: 170,
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(8),
                    //         ),
                    //         child: ClipRRect(
                    //           borderRadius: BorderRadius.circular(8),
                    //           child:_imageFile!=null? Image.file(_imageFile!.absolute,fit: BoxFit.cover,):Image.asset("assets/images/doctor.jpg",fit: BoxFit.cover,),
                    //           // Image.asset(
                    //           //   "assets/images/doctor.jpg",
                    //           //   fit: BoxFit.cover,
                    //           // ),
                    //         )),
                    //     SizedBox(
                    //       width: MediaQuery.of(context).size.width / 22,
                    //     ),
                    //     Align(
                    //       alignment: Alignment.bottomLeft,
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           SizedBox(
                    //             height: MediaQuery.of(context).size.height / 9,
                    //           ),
                    //           InkWell(onTap: (){_showImagePicker(context);},
                    //               child: Icon(Icons.camera_alt,color: Colors.blue,)),
                    //           SizedBox(
                    //             height: MediaQuery.of(context).size.height / 102,
                    //           ),
                    //           Text("Change Profile Picture",style: TextStyle(color: Colors.blue,fontSize: 13,fontWeight: FontWeight.bold),),
                    //
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height / 40,
                    // ),
                  ],
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height / 90,
              ),
              Container(padding: EdgeInsets.all(10),
                // height: MediaQuery.of(context).size.height / 15,
                // width: MediaQuery.of(context).size.width / 1.3,
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(4),color: Colors.white),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 50,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Card(
                            elevation: 3,
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: colors.white),
                              child: TextFormField(
                                controller: namecn,
                                decoration: const InputDecoration(
                                  //   hintText: "${getData?.data[0]['username'].toString()}",
                                  //   fillColor: Colors.indigo[100] ,
                                    filled: true,
                                    prefixIcon:  Icon(Icons.person),
                                    border: InputBorder.none
                                    // border: OutlineInputBorder(
                                    //     borderRadius: BorderRadius.circular(10), ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Enter name";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 60,
                          ),
                          Card(
                            elevation: 3,
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: colors.white),
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                controller: phonecn,
                                maxLength: 10,
                                decoration: const InputDecoration(
                                  //  hintText: "${getData?.data[0]['mobile'].toString()}",
                                  //   fillColor: Colors.indigo[100] ,
                                    filled: true,
                                    counterText: '',
                                    prefixIcon:  Icon(Icons.phone),
                                    border: InputBorder.none
                                    // border: OutlineInputBorder(
                                    //     borderRadius: BorderRadius.circular(8))
                                ),
                                validator: (value) {
                                  if ( value!.isEmpty||value.length<10) {
                                    return "Please Enter Mobile no";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 60,
                          ),
                          Card(
                            elevation: 3,
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: colors.white),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: emailcn,
                                decoration: const InputDecoration(
                                  // hintText: "${getData?.data[0]['email'].toString()}",
                                  //   fillColor: Colors.indigo[100] ,
                                    filled: true,
                                    counterText: '',
                                    prefixIcon:  Icon(Icons.email),
                                    border: InputBorder.none
                                ),
                                validator: (value) {
                                  if ( value!.isEmpty) {
                                    return "Please Enter email";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 60,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 60,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height/50,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/1.2,
                      child: InkWell(onTap: (){
                        if(_formKey.currentState!.validate()){
                          updatedata();
                        }
                      },
                          child: CustomButton(name: 'Update',)),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 90,),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Future<void> updatedata()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('user_id');
    var headers = {
      'Cookie': 'ci_session=2a73dd574d02a00b8a320187d145c228722b5421'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/dr_vet_app/app/v1/api/update_user'));
    request.fields.addAll({
      'username': namecn.text,
      'email': emailcn.text,
      'mobile': phonecn.text,
      'user_id': userId.toString(),
    });
    request.files.add(await http.MultipartFile.fromPath('image', _imageFile?.path ?? "",));
//  print('///////////////${request.files}');
//  print('///////////////${request.fields}');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      var result=await response.stream.bytesToString();
      var finalresult=jsonDecode(result);
      if(finalresult['error']== false) {
        var name=finalresult['data'][0]['username'].toString();
        var mobile=finalresult['data'][0]['mobile'].toString();
        var email=finalresult['data'][0]['email'].toString();
        var image=finalresult['data'][0]['image'].toString();
        print('----------${image}');
        Fluttertoast.showToast(msg: "${finalresult['message']}");
        await Navigator.push(context, MaterialPageRoute(builder: (context) =>
            Account(Name:name,Mobile:mobile,Email:email,imagepath:image),));
      }
      else{
        Fluttertoast.showToast(msg: "${finalresult['message']}",);
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  GetUserDataModel? getData;
  Future<void> getdata()async
  {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('user_id');
    var headers = {
      'Cookie': 'ci_session=ff134e543f4868d8d94ffd3e079ae3a6691a7fed'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/dr_vet_app/seller/app/v1/api/get_user_data'));
    request.fields.addAll({
      'user_id': userId.toString(),
    });
    print("get user data parar ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var data=await response.stream.bytesToString();
      var finalresult=GetUserDataModel.fromJson(json.decode(data));
      setState(() {
        getData = finalresult;
        namecn.text= "${getData?.data?.first.username.toString()}";
        phonecn.text="${getData?.data?.first.mobile.toString()}";
        emailcn.text="${getData?.data?.first.email.toString()}";
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }
}
