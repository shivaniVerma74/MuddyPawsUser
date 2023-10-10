import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:muddypawsuser/Api.path.dart';
import 'package:http/http.dart' as http;

import '../Colors.dart';
class Terms extends StatefulWidget {
  const Terms({Key? key}) : super(key: key);

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {

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

  var termsConditions;
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
      print('______asdsadsa____${result}');
      setState(() {
        termsConditions = jsonResponse['data']['terms_conditions'][0];
        print("termmmmm ${termsConditions}");
      });
    }
    else {
    print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
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
          title: const Text("Terms & Condition", style: TextStyle(fontWeight: FontWeight.w600, color: colors.black, fontFamily: "Montserrat"),),
        ),
        body: ListView(
          children: [
            termsConditions == null || termsConditions == "" ? const Center(child: CircularProgressIndicator(color: colors.primary))
                : Html(
                data: termsConditions
            ),
          ],
        ),
      ),
    );
  }
}
