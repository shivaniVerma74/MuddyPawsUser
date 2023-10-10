import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:muddypawsuser/Api.path.dart';
import '../Colors.dart';
import '../Custom/CustomCard.dart';
import '../Models/FaqModel.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFaq();
  }
  var question;
  var answer;

  FaqModel? faqModel;
  getFaq() async {
    var headers = {
      'Cookie': 'ci_session=6fd7c3e95e743bd1f504f8094ecacf6456324007'
    };
    var request = http.Request('POST', Uri.parse(ApiServicves.getFaqs));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final finalResult = FaqModel.fromJson(json.decode(finalResponse));
      setState(() {
        faqModel = finalResult;
      });
    }
    else {
      print(response.reasonPhrase);
    }

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
            child: const Icon(Icons.arrow_back_ios, color: colors.black)),
        elevation: 0,
        backgroundColor: colors.white,
        centerTitle: true,
        title: const Text("Faqs", style: TextStyle(fontSize: 15, color: colors.black,fontFamily: "Montserrat"), ),),
      body: SingleChildScrollView(
        child:  Column(
          children: [
            ListView.builder(
              itemCount: faqModel?.data?.length ?? 0,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child:
                                  Text(
                                    faqModel?.data?[index].question ?? "",
                                    style: const TextStyle(
                                        color: Colors.black,
                                      fontWeight: FontWeight.w500,fontFamily: "Montserrat"
                                    ),
                                  ),
                              ),
                                 const SizedBox(height: 6,),
                                 Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15.0),
                                            child: Text(
                                              faqModel?.data?[index].answer ?? "",
                                              style: const TextStyle(
                                                  color: Colors.black, fontFamily: "Montserrat"
                                              ),
                                            ),
                                        ),
                                    ),
                                  ]),
                            ]),
                      )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
