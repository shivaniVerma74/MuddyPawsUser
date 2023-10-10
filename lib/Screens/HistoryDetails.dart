import 'package:flutter/material.dart';

import '../Api.path.dart';
import '../Colors.dart';
import '../Models/PetsHistoryModel.dart';

class HistoryDetails extends StatefulWidget {
  final HistoryData? model;
   HistoryDetails({Key? key, this.model}) : super(key: key);

  @override
  State<HistoryDetails> createState() => _HistoryDetailsState();
}

class _HistoryDetailsState extends State<HistoryDetails> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color(0xfff5f6fb),
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Details",
          style: TextStyle(fontWeight: FontWeight.w500, color: colors.black, fontSize: 15, fontFamily: "Montserrat"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.model == null || widget.model == "" ? Center(child: CircularProgressIndicator(color: colors.primary)):
              Card(
                elevation: 5,
                child: Container(
                  height: MediaQuery.of(context).size.height/2,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: colors.white),
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child:
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(9),
                                  child: widget.model?.image == null ||  widget.model?.image == "" ? Image.asset("assets/images/doctor2.jpg", height: 150, width: 50,):
                                  Container(
                                    height: 80,
                                    width: 80,
                                    child: Image.network(
                                      "${ApiServicves.imageUrl}${widget.model?.image}",
                                      // fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(9),
                                  child: widget.model?.report == null || widget.model?.report == "" ? Image.asset("assets/images/doctor2.jpg", height: 150, width: 50,):
                                  Container(height: 80,
                                  width: 80,
                                    child: Image.network(
                                      "${ApiServicves.imageUrl}${widget.model?.report}",
                                      // fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(9),
                                  child: widget.model?.prescription == null ||  widget.model?.prescription == "" ? Image.asset("assets/images/doctor2.jpg", height: 150, width: 50,):
                                  Container(
                                    height: 80,
                                    width: 80,
                                    child: Image.network(
                                      "${ApiServicves.imageUrl}${widget.model?.prescription}",
                                      // fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.only(left: 30,right: 30),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [

                                  const Text("Pet name", style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,fontFamily: "Montserrat"),
                                  ),


                                  Text(
                                    "${widget.model?.petName}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400, fontFamily: "Montserrat"),
                                  ),
                                ],),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [
                                  const Text("Pet Type", style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold, fontFamily: "Montserrat")),

                                  Text(
                                    "${widget.model?.petType}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,fontFamily: "Montserrat"),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [
                                  const Text("Vet Name", style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold, fontFamily: "Montserrat")),
                                  Text(
                                    "${widget.model?.doctorName}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,fontFamily: "Montserrat"),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [
                                  const Text("Clinic", style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,fontFamily: "Montserrat")),
                                  Text(
                                    "${widget.model?.clinicName}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,fontFamily: "Montserrat"),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [
                                  const Text("Consultation", style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,fontFamily: "Montserrat"),
                                  ),
                                  Text(
                                    "${widget.model?.serviceType}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,fontFamily: "Montserrat"),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [
                                  const Text("Date", style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold, fontFamily: "Montserrat"),
                                  ),
                                  Text(
                                    "${widget.model?.createdAt}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400, fontFamily: "Montserrat"),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
