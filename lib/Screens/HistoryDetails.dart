import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();


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
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Appointment Details",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: colors.black,
              fontSize: 15,
              fontFamily: "Montserrat"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:

              // widget.model == null || widget.model == ""
              //     ? Center(
              //         child: CircularProgressIndicator(color: colors.primary))
              //     :

              Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 5,
                      child: Container(
                        padding: EdgeInsets.only(bottom: 25),
                        //  height: MediaQuery.of(context).size.height / 2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: colors.white),
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              SizedBox(height: 20,),
                              Container(
                                // padding: EdgeInsets.symmetric(
                                //     horizontal: 20, vertical: 20),
                                child: Text(
                                    "Documents/Images uploaded by you",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Montserrat")),
                              ),

                              Container(
                                // padding: EdgeInsets.symmetric(
                                //     horizontal: 20, vertical: 20),
                                child: Text(
                                    "and the Vet for this appointment",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Montserrat")),
                              ),


                              Container(
                                child:

                                widget.model == null || widget.model == ""?Center(child:  Text(
                                    "NA",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Montserrat")),):



                                Column( children: [



                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child:


                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(9),
                                        child: widget.model?.image == null ||
                                                widget.model?.image == ""
                                            ? Image.asset(
                                                "assets/images/doctor2.jpg",
                                                height: 150,
                                                width: 50,
                                              )
                                            : Container(
                                                height: 80,
                                                width: 80,
                                                child: Image.network(
                                                  "${ApiServicves.imageUrl}${widget.model?.image}",
                                                  // fit: BoxFit.fill,
                                                ),
                                              ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(9),
                                        child: widget.model?.report == null ||
                                                widget.model?.report == ""
                                            ? Image.asset(
                                                "assets/images/doctor2.jpg",
                                                height: 150,
                                                width: 50,
                                              )
                                            : Container(
                                                height: 80,
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
                                        child: widget.model?.prescription ==
                                                    null ||
                                                widget.model?.prescription == ""
                                            ? Image.asset(
                                                "assets/images/doctor2.jpg",
                                                height: 150,
                                                width: 50,
                                              )
                                            : Container(
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
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 30, right: 30),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Pet Name: ",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Montserrat"),
                                          ),
                                          Text(
                                            widget.model?.petName == "" ||
                                                    widget.model?.petName == null
                                                ? "Not Available"
                                                : "${widget.model?.petName}",
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Montserrat"),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Pet Type: ",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Montserrat")),
                                          Text(
                                            widget.model?.petType == "" ||
                                                    widget.model?.petType == null
                                                ? "Not Available"
                                                : "${widget.model?.petType}",
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Montserrat"),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Vet Name: ",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Montserrat")),
                                          Text(
                                            widget.model?.doctorName == "" ||
                                                    widget.model?.doctorName ==
                                                        null
                                                ? "Not Available"
                                                : "${widget.model?.doctorName}",
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Montserrat"),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Clinic: ",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Montserrat")),
                                          Text(
                                            widget.model?.clinicName == "" ||
                                                    widget.model?.clinicName ==
                                                        null
                                                ? "Not Available"
                                                : "${widget.model?.clinicName}",
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Montserrat"),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Reason for Consultation: ",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Montserrat"),
                                          ),
                                          Text(
                                            widget.model?.serviceType == "" ||
                                                    widget.model?.serviceType ==
                                                        null
                                                ? "Not Available"
                                                : "${widget.model?.serviceType}",
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Montserrat"),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Consultation Type: ",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Montserrat"),
                                          ),
                                          Text(
                                            "Online/In-Clinic",
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Montserrat"),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Date: ",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Montserrat"),
                                          ),
                                          Text(
                                            widget.model?.createdAt == "" ||
                                                    widget.model?.createdAt ==
                                                        null
                                                ? "Not Available"
                                                : "${widget.model?.createdAt}",
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Montserrat"),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Time: ",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Montserrat"),
                                          ),
                                          Text(
                                            widget.model?.timeSlot == "" ||
                                                    widget.model?.timeSlot == null
                                                ? "Not Available"
                                                : "${widget.model?.timeSlot}",
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Montserrat"),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Remark from Vet: ",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Montserrat"),
                                          ),
                                          Text(
                                            widget.model?.description == "" ||
                                                widget.model?.description == null
                                                ? "Not Available"
                                                : "${widget.model?.description}",
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Montserrat"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                        ]),
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