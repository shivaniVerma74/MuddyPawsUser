import 'package:flutter/material.dart';

import 'BottomNavigationScreens/AppointmentDetailsUser.dart';

class SendToBankPage extends StatefulWidget {
  const SendToBankPage({super.key});

  @override
  State<SendToBankPage> createState() => _SendToBankPageState();
}

class _SendToBankPageState extends State<SendToBankPage> {
  TextEditingController holderName = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController branchCode = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  TextEditingController amount = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios_new_outlined,
          color: Colors.black,
        ),
        centerTitle: true,
        title: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AppointmentScreen()));
          },
          child: Text(
            'Send to Bank',
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: [
          Icon(
            Icons.more_vert,
            color: Colors.black,
          )
        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "AVAILABLE BALANCE",
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    '\$520.50',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Container(
              height: 5,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade200,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text('BANK INFO')),
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    shrinkWrap: true,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Account Holder Name',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: holderName,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          hintText: 'Enter Account Holder Name',
                          filled: true,
                          fillColor: Colors.blue.shade50,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Account Holder Name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Bank Name',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: bankName,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          hintText: 'Enter Bank Name',
                          filled: true,
                          fillColor: Colors.blue.shade50,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Bank Name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Branch Code',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: branchCode,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          hintText: 'Enter Branch Code',
                          filled: true,
                          fillColor: Colors.blue.shade50,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Branch Code';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Account Number',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: accountNumber,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          hintText: 'Enter Account Number',
                          filled: true,
                          fillColor: Colors.blue.shade50,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Account Number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Amount To Transfer',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: amount,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          hintText: 'Enter Amount To Transfer',
                          filled: true,
                          fillColor: Color.fromARGB(255, 5, 43, 71),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Amount To Transfer';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 80,
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
      bottomSheet: InkWell(
        onTap: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            // Process data or navigate to another screen
            print('Form is valid');
          } else {
            print('Form is invalid');
          }
        },
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 4, 93, 165),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Center(
              child: Text(
                'Send to Bank',
                style: TextStyle(color: Colors.white),
              )),
        ),
      ),
    );
  }
}