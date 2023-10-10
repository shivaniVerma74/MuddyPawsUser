import 'package:flutter/material.dart';

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
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height/55,
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          height: 150,
                          width: 150,
                          child:Image.network('${widget.model?.image}',fit: BoxFit.fill,) ,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              Text('Experience',style: TextStyle(color: Colors.grey,fontSize: 12, fontFamily: "Montserrat"),),
                              SizedBox(height: 8),
                              Text('${widget.model?.experience}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500, fontFamily: "Montserrat"),),
                              SizedBox(height: 20),
                              Text('Consultancy fee',overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.grey,fontSize: 14, fontFamily: "Montserrat"),),
                              SizedBox(height: 8),
                              Text('${widget.model?.consultancyFees}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500, fontFamily: "Montserrat")),
                              SizedBox(height: 8),
                              Text('Qualification',overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.grey,fontSize: 14, fontFamily: "Montserrat"),),
                              SizedBox(height: 8),
                              Text('${widget.model?.qualification}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500, fontFamily: "Montserrat")),
                              SizedBox(height: 8),
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
                          child: Text('${widget.model?.username}', style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20, fontFamily: "Montserrat"),overflow: TextOverflow.ellipsis,),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Rating',style: TextStyle(color: Colors.white,fontSize: 14, fontFamily: "Montserrat"),),
                            SizedBox(height: 10,),
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
              const SizedBox(height: 5,),
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
              const SizedBox(height: 5,),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('About',style: TextStyle(color: Colors.grey,fontSize: 15, fontFamily: "Montserrat"),),
                    SizedBox(height: 10,),
                    SizedBox(height:70,
                      child: Text("${widget.model?.storeDescription}",style: TextStyle(fontFamily: "Montserrat"),overflow: TextOverflow.ellipsis,maxLines: 3,),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(10),
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
                          children:  [
                            SizedBox(height: 15),
                            Text('${widget.model?.clinicAddress}',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 16, fontFamily: "Montserrat")),
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