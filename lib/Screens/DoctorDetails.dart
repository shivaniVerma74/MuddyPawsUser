import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Colors.dart';
import '../Models/GetDoctorModel.dart';
import '../Models/GetPetsModel.dart';
import 'DactorBooking.dart';
class DoctorDetails extends StatefulWidget {
  final DactorData? model;
var petName;
var petType;
var petIdd;
  DoctorDetails({Key? key, this.model,this.petType,this.petName,this.petIdd}) : super(key: key);

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("pet type ${widget.petType}");
    print("pet nameee ${widget.petName}");
    print("pet id ${widget.petIdd}");
  }
  List<PetsData> selectedPets = [];
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
            child: const Icon(Icons.arrow_back_ios, color: colors.black)),
        elevation: 0,
        centerTitle: true,
        backgroundColor: colors.white,
        title: const Text("Vet's Details", style: TextStyle(fontSize: 15, color: colors.black, fontWeight: FontWeight.w500,fontFamily: "Montserrat"),),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8,right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // color: Colors.white,
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height/75,
                    ),
                    Row(
                      children: [
                        widget.model?.image == null || widget.model?.image == ""
                    ? Container(
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)),
                          height: 165,
                          width: 150,
                    child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                      "assets/images/doctor2.jpg",
                         fit: BoxFit.fill,
                            ),
                        ),
                       ):
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          // height: 145,
                          // width: 150,
                          child:ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network('${widget.model?.image}',fit: BoxFit.fill, height: 130,
                                width: 130,)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              const Text('Experience',style: TextStyle(color: Colors.grey,fontSize: 12, fontFamily: "Montserrat"),),
                              const SizedBox(height: 8),
                              Text( widget.model?.experience == "" || widget.model?.experience == null
                                  ? "Not Avaliable":'${widget.model?.experience}s',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w500, fontFamily: "Montserrat"),),
                              const SizedBox(height: 20),
                              const Text('Fees',overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.grey,fontSize: 14, fontFamily: "Montserrat"),),
                              const SizedBox(height: 8),
                              Text(widget.model?.consultancyFees == "" || widget.model?.consultancyFees == null
                                  ? "Not Avaliable":'${widget.model?.consultancyFees}',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w500, fontFamily: "Montserrat")),
                              const SizedBox(height: 20),
                              const Text('Qualification',overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.grey,fontSize: 14, fontFamily: "Montserrat"),),
                              const SizedBox(height: 8),
                              Text(widget.model?.qualification == "" || widget.model?.qualification == null
                                  ? "Not Avaliable":'${widget.model?.qualification}',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w500, fontFamily: "Montserrat")),
                              const SizedBox(height: 20),
                                const Text('Clinic Name',overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.grey,fontSize: 14, fontFamily: "Montserrat"),),
                              const SizedBox(height: 8),
                              Container(
                                width: 100,
                                child: Text(widget.model?.clinicName == "" || widget.model?.clinicName == null
                                    ? "Not Avaliable":'${widget.model?.clinicName}',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w500, fontFamily: "Montserrat"), overflow: TextOverflow.ellipsis,),
                              ),
                              // Text('${widget.model?.}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 190,
                          padding: const EdgeInsets.all(10),
                          child: Text('${widget.model?.username}', style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 20, fontFamily: "Montserrat"),overflow: TextOverflow.ellipsis,),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Rating',style: TextStyle(color: Colors.white,fontSize: 14, fontFamily: "Montserrat"),),
                            SizedBox(height: 10),
                            // Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       // Row(
                            //       //   children: [
                            //       //     Icon(Icons.star,color: Colors.amber,),
                            //       //     Text('${widget.model?.rating}',style: TextStyle(color:Colors.amber),),
                            //       //   ],
                            //       // ),
                            //     ]),
                            // const SizedBox(height:30),
                            // Row(
                            //   children: [
                            //     Container(
                            //         child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            //           children:  [
                            //             const Text('Availibilty',style: TextStyle(color: Colors.grey,fontSize: 14),),
                            //             const SizedBox(height: 10,),
                            //             Text('${widget.model?.createdAt}',style: TextStyle(color: Colors.black,fontSize: 13),),
                            //           ],
                            //         ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      const Text('Availibilty',style: TextStyle(color: Colors.grey,fontSize: 14, fontFamily: "Montserrat"),),
                      const SizedBox(height: 10,),
                      Text('${widget.model?.selectTimeSchedule}',style: TextStyle(color: Colors.black,fontSize: 13, fontFamily: "Montserrat"),),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('About',style: TextStyle(color: Colors.grey,fontSize: 15, fontFamily: "Montserrat"),),
                    const SizedBox(height: 10),
                    SizedBox(height:70,
                      child: widget.model?.storeDescription == null || widget.model?.storeDescription == "" ? const Text("Not Avaliable"):
                      Text("${widget.model?.storeDescription}",style: const TextStyle(fontFamily: "Montserrat"),overflow: TextOverflow.ellipsis,maxLines: 3,),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Location',style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: "Montserrat"),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 15),
                            Text('${widget.model?.clinicAddress}',style: const TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 16, fontFamily: "Montserrat")),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DactorBooking(id: widget.model?.id, fees: widget.model?.consultancyFees ?? "",
                     petTypee: widget.petType, pettName: widget.petName,
                     petIdd: widget.petIdd
                  )));
                },
                child: Center(
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width/2,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: colors.primary),
                      child: const Center(child: Text("Book Appointment", style: TextStyle(fontSize: 15, color: colors.white, fontWeight: FontWeight.w500, fontFamily: "Montserrat"),))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}