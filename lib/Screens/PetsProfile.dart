import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Api.path.dart';
import '../Colors.dart';
import '../Models/GetPetsModel.dart';
import 'PetsHistoryScreen.dart';

class PetsDetails extends StatefulWidget {
  final PetsData? model;
  const PetsDetails({Key? key, this.model}) : super(key: key);

  @override
  State<PetsDetails> createState() => _PetsDetailsState();
}

class _PetsDetailsState extends State<PetsDetails> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPets();
  }

  GetPetsModel? getpetsmodel;
  getPets() async {
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

  // deletePets() async{
  //   var headers = {
  //     'Cookie': 'ci_session=f6fff50f24331e0bb1ed898cc8becc67b092089f'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.deleteProfile));
  //   request.fields.addAll({
  //     'id': '${getpetsmodel?.data?[index].id}'
  //   });
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     print(await response.stream.bytesToString());
  //     await getPets();
  //     Fluttertoast.showToast(msg: "Profile deleted success");
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xffFFFFFF), // navigation bar color
    statusBarColor: Color(0xffFFFFFF), // status bar color
  ));
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: const Text(
            'Pets Details',
            style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "Montserrat"),
          ),
        ),
        body:
        Column(
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.model == null || widget.model == "" ? Center(child: CircularProgressIndicator(color: colors.primary)):
              InkWell(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => PetsHistoryScreen(id: getpetsmodel?.data?[index])));
                },
                child: Card(
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.width/1.1,
                      width: MediaQuery.of(context).size.width/1,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // image: DecorationImage(image: AssetImage('assets/images/img.png'),fit: BoxFit.fill)
                              ),
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              child:
                              // Image.asset('assets/images/img.png'),
                              ClipRRect(
                                  child: Image.network("${ApiServicves.imageUrl}${widget.model?.image}", )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(padding: EdgeInsets.only(top: 55)),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: MediaQuery.of(context).size.width/2.2,
                                        child: Row(
                                          children: const [
                                            Text("Pet Name:",textAlign: TextAlign.right, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: "Montserrat"),)
                                          ],
                                        )),
                                    Row(
                                    children: [
                                    Text("${widget.model?.username}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600,fontFamily: "Montserrat"),)
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 7),
                                Row(
                                  children: [
                                    SizedBox(
                                        width: MediaQuery.of(context).size.width/2.2,

                                        child: Row(
                                          children: const [
                                            Text("Pet Type:",textAlign: TextAlign.right, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,fontFamily: "Montserrat"),)
                                          ],
                                        )),
                                    Row(
                                      children: [
                                        Text("${widget.model?.petType}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,fontFamily: "Montserrat"),)
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 7),
                                Row(
                                  children: [
                                    SizedBox(
                                        width: MediaQuery.of(context).size.width/2.2,
                                        child: Row(
                                          children: const [
                                            Text("Pet Age:", textAlign: TextAlign.right, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,fontFamily: "Montserrat"),),
                                          ],
                                        ),
                                    ),
                                     Text("${widget.model?.age}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,fontFamily: "Montserrat"),)
                                  ],
                                ),
                                SizedBox(height: 7),
                                // Row(
                                //   children: [
                                //     Container(
                                //         width: MediaQuery.of(context).size.width/2.2,
                                //
                                //         child: Row(
                                //           children: [
                                //             Text("Event Name:",textAlign: TextAlign.right),
                                //           ],
                                //         )),
                                //     Container(child: Row(
                                //       children: [
                                //         Text("${getEnquiryModel?.data?[index].eventName}"),
                                //       ],
                                //     ))
                                //   ],
                                // ),
                                // SizedBox(height: 7),
                                // Row(
                                //   children: [
                                //     Container(
                                //         width: MediaQuery.of(context).size.width/2.2,
                                //
                                //         child: Row(
                                //           children: [
                                //             Text("Description:",textAlign: TextAlign.right),
                                //           ],
                                //         )),
                                //     Container(child: Row(
                                //       children: [
                                //         Text("${getEnquiryModel?.data?[index].description}"),
                                //       ],
                                //     )),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}
