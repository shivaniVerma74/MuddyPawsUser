import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart'as http;
import '../Colors.dart';
import '../Models/GetCommunity.dart';

class Community extends StatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {

@override
void initState() {
  super.initState();
  community();
}

  GetCommunity? communityData;
  community() async {
    var headers = {
      'Cookie': 'ci_session=8a0a33eeba28f9f8c27a6edd02b45b9e59000048'
    };
    var request = http.Request('POST', Uri.parse('https://developmentalphawizz.com/dr_vet_app/app/v1/api/get_community'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = GetCommunity.fromJson(json.decode(finalResponse));
      setState(() {
        communityData = jsonResponse;
        print("termmmmm ${jsonResponse}");
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xffFFFFFF), // navigation bar color
    statusBarColor: Color(0xffFFFFFF), // status bar color
  ));
    return Scaffold(
      backgroundColor: Color(0xfff5f6fb),
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
            child: const Icon(Icons.arrow_back_ios, color: colors.black),
        ),
        backgroundColor: colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text("Community", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: colors.black),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("${communityData?.data?.value}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, fontFamily: "Montserrat"),),
          ),
        ],
      ),
    );
  }
}
