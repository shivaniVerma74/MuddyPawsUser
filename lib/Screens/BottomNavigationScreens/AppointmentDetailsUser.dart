
import 'package:flutter/material.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  @override
  int index1=0;int index2=0;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointment Details",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),
        centerTitle: true,
        leading:GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child:  Icon(Icons.arrow_back_ios_new,size: 20,color: Colors.black,),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child:  Icon(Icons.more_vert,color: Colors.blue,),
          ),          SizedBox(width: 20,),
        ],
        backgroundColor: Colors.white,
        elevation: 0,

      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(

        child: Padding(padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                      height: 180,
                      width: 160,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset('assets/images/doctor4.jpg', height: 180,
                          width: 160,fit: BoxFit.cover,),
                      )
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        width: MediaQuery.of(context).size.width/2.5,
                        // height: 40,
                        child:Text('Dr. Joseph Williamson',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: 40,),
                      Container(
                        padding: EdgeInsets.all(15),
                        width: MediaQuery.of(context).size.width/2.3,
                        child:Text('Cardiac Surgeon at Apple Hospital',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.grey),),
                      ),
                    ],
                  )
                ],
              )  ,
              const SizedBox(
                height: 40,
              ),
              const Text('Appointment on',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.grey),),
              const SizedBox(height: 15,),
              const Text('12 June 2020 | 12:20 pm',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black),),
              const SizedBox(height: 40,),
              const Text('Location',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.grey),),
              const SizedBox(height: 15,),
              const Text('Apple Hospital',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black),),
              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Walter street, New York',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.grey),),
                  GestureDetector(
                      onTap: (){
                      },
                      child: Padding(padding: EdgeInsets.only(right: 10),child:  Icon(Icons.location_on,size: 20,color: Colors.blue,),)
                  ),
                ],
              ),
              const SizedBox(height:40,),
              const Text('Attachment for',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.grey),),
              const SizedBox(height:15,),
              const Text('Chest Pain',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black),),
              const SizedBox(height:40,),
              const Text('Attachment ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.grey),),
              const SizedBox(height:15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width/2,
                    child: InkWell(
                      onTap: (){
                        // _openFileExplorer();
                      },
                      child:(_filePath==null)?
                      Text('Pick File'):
                      Text("${_filePath}"),
                    ),
                  ),
                  TextButton(onPressed: (){}, child:
                  Container(
                    child: Row(
                      children: const [
                        Icon(Icons.download,color: Colors.blue,),
                        Text('  Download',style: TextStyle(color: Colors.blue),),
                      ],
                    ),
                  )
                  )
                ],
              ),
              SizedBox(height: 80,),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Row(
        children: [
          InkWell(onTap: (){
            setState(() {
              index1=0;
            });
          },
            child: Container(
                color: index1==0?Colors.blue:Colors.blue.shade50,
                height: MediaQuery.of(context).size.height/11,
                width: MediaQuery.of(context).size.width/2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.call,size: 20,color: index1==1?Colors.blue:Colors.white,),
                    Text(' Call',style: TextStyle(color: index1==1?Colors.blue:Colors.white),)
                  ],
                )

            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                index1=1;
              });
            },
            child:
            Container(
                color: index1==0?Colors.blue.shade50:Colors.blue,
                width: MediaQuery.of(context).size.width/2,
                height: MediaQuery.of(context).size.height/11,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.chat,size: 20,color: index1==0?Colors.blue:Colors.white),
                    Text(' Chat',style: TextStyle(color: index1==0?Colors.blue:Colors.white),)
                  ],
                ),
            ),
          ),
        ],
      ),
    );
  }

  String? _filePath;
  // Future<void> _openFileExplorer() async {
  //   try {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowedExtensions: ['pdf','docs'],
  //     );
  //
  //     if (result != null) {
  //       setState(() {
  //         _filePath = result.files.single.path;
  //       });
  //     }
  //   } catch (e) {
  //     // Handle the file picker exception, if any.
  //     print('Error: $e');
  //   }
  // }

}
