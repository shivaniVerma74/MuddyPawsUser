import 'package:flutter/material.dart';
class DoctorDetails extends StatefulWidget {
  const DoctorDetails({Key? key}) : super(key: key);

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child:Padding(
            padding: const EdgeInsets.only(left: 8,right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox( height: MediaQuery.of(context).size.height/15,),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          child: Icon(Icons.arrow_back_ios_new),
                          onTap: (){
                            Navigator.pop(context);
                          }
                      ),
                      GestureDetector(
                        child: Icon(Icons.bookmark_border_outlined),
                      )
                    ],
                    ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/15,
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 150,
                            width: 150,
                            child:Image.asset('assets/images/doctor3.jpg',fit: BoxFit.fill,) ,
                          ),
                          Padding(padding: EdgeInsets.only(left: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Experience',style: TextStyle(color: Colors.grey,fontSize: 16),),
                                SizedBox(height: 8,),
                                Text('18 years',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                                SizedBox(height: 20,),
                                Text('Consultancy fee',overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.grey,fontSize: 16),),
                                SizedBox(height: 8,),
                                Text('\$28',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500)),
                              ],
                            ),
                          )
                          // Image(image: ""),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text('Dr. Joseph\n Williamson',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Feedbacks',style: TextStyle(color: Colors.grey,fontSize: 15),),
                              SizedBox(height: 10,),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.star,color: Colors.amber,),
                                        Text(' 4.5',style: TextStyle(color:Colors.amber),),
                                           Text(' (124)',style: TextStyle(color:Colors.grey),),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(width: 30,),
                                         Icon(Icons.arrow_forward_ios,color: Colors.grey,)
                                      ],
                                    )
                                  ]),
                              SizedBox(height:30,),
                              Row(
                                children: [
                                  Container(
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Availibilty',style: TextStyle(color: Colors.grey,fontSize: 15),),
                                          SizedBox(height: 10,),
                                          Text('12:00 to 13:00',style: TextStyle(color: Colors.black,fontSize: 15),),
                                        ],
                                      )),
                                  SizedBox(width: 20,),
                                  Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                                ],
                              ),

                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('About',style: TextStyle(color: Colors.grey,fontSize: 15),),
                      SizedBox(height: 10,),
                      SizedBox(height:70,
                        child: Text(" managed to advance somewhat in solving the problem, but still there are questions. Here is the text of main.dart. By clicking on the canvas, the showPopupMenu3 (context) function is called from handleTapDown (...). The menu does appear, I can catch option, but after selecting the menu isn't closed. To close menu need to press the BACK button or click on the canvas.",style: TextStyle(),overflow: TextOverflow.ellipsis,maxLines: 3,),
                      )
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
                      Text('Service at',style: TextStyle(color: Colors.grey,fontSize: 15),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15,),
                              Text('Apple Hospital',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 16)),
                              SizedBox(height: 8,),
                              Text('JJ Towers, Johnson street,Hemilton')
                            ],
                          ),
                          SizedBox(width: 30,),
                          Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 20,)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 25,),
                              Text('Seven Star Clinic',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 16),),
                              SizedBox(height: 8,),
                              Text('Hemilton bridge City Point,Hemilton')
                            ],
                          ),
                          SizedBox(width: 30,),
                          Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 20,)
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}