import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;

import '../Api.path.dart';
import '../Colors.dart';
class Contactus extends StatefulWidget {
  const Contactus({Key? key}) : super(key: key);

  @override
  State<Contactus> createState() => _ContactusState();
}

class _ContactusState extends State<Contactus> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSetting();
  }

  Future<Null> _refresh() {
    return callApi();
  }

  Future<Null> callApi() async {
    getSetting();
  }

  var contactUS;
  getSetting() async {
    var headers = {
      'Cookie': 'ci_session=1895105d72f1bebfa6d3e255c4cbbbeda793981b'
    };
    var request = http.Request('POST', Uri.parse(ApiServicves.getSettings));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final result =  await response.stream.bytesToString();
      final jsonResponse = json.decode(result);
      print('______contactus____${result}');
      setState(() {
        contactUS = jsonResponse['data']['contact_us'][0];
        print("termmmmm ${contactUS}");
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
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Scaffold(
        backgroundColor: Color(0xfff5f6fb),
        appBar: AppBar(
          elevation: 0,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios, color: colors.black)),
          backgroundColor: colors.white,
          centerTitle: true,
          title: const Text("Support", style: TextStyle(fontWeight: FontWeight.w600, color: colors.black),),
        ),
        body: ListView(
          children: [
            contactUS == null || contactUS == "" ? Center(child: CircularProgressIndicator(color: colors.primary))
                : Html(
                data: contactUS
            ),
          ],
        ),
      ),
    );
  }
}
