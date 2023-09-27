import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:muddypawsuser/Api.path.dart';
import 'package:muddypawsuser/Custom/CustomCard.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Colors.dart';
import '../Models/TransactionModel.dart';
import 'SendToBank.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {


  @override
  void initState() {
    super.initState();
    getwalletamt();
    // walletTransactions();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  String? wallet_balance;
  String? wallet_balance_added;

  getwalletamt() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    wallet_balance = preferences.getString('wallet_balance');
    print("wallet balancee is hererer ${wallet_balance}");
  setState(() {});
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(msg: "Payment successfully");
    addWallet();
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment cancelled by user");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
  }

  Razorpay? _razorpay;
  int? pricerazorpayy;
  void openCheckout(amount) async {
    double res = double.parse(amount.toString());
    pricerazorpayy= int.parse(res.toStringAsFixed(0)) * 100;
    // Navigator.of(context).pop();
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': "${pricerazorpayy}",
      'name': 'Muddy',
      'image':'assets/images/Group 165.png',
      'description': 'Muddy',
    };
    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  addWallet() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('user_id');
    var headers = {
      'Cookie': 'ci_session=13e78ca17dd358a4dd97382f9e11944e10685a8c'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.addWallet));
    request.fields.addAll({
      'user_id': '${userId}',
      'amount': '${amtC.text}'
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonresponse = json.decode(finalResponse);
      if(jsonresponse["response_code"] == "1"){
        wallet_balance_added = jsonresponse["data"]["balance"];
        Fluttertoast.showToast(msg: "Wallet updated success");
        setState(() {
        });
      } else{
        Fluttertoast.showToast(msg: jsonresponse["message"]);
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  TransactionModel? transactionModel;
  walletTransactions() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('user_id');
    var headers = {
      'Cookie': 'ci_session=e3825b4be6db7ecb421f2db35bd0a2ab2c91e923'
    };
    var request = http.MultipartRequest('POST', Uri.parse(ApiServicves.walletTransactions));
    request.fields.addAll({
      'user_id': "$userId"
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = TransactionModel.fromJson(json.decode(finalResponse));
      setState(() {
        transactionModel = jsonResponse;
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController amtC = TextEditingController();

  dialogAnimate(BuildContext context, Widget dialge) {
    return showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: dialge,
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
    );
  }

  validateAmount(String? value, BuildContext context) {
    if (value!.length == 0)
      return Text("Amount Request");
    else
      return null;
  }

  StateSetter? dialogState;
  _showDialog() async {
    bool payWarn = false;
    await dialogAnimate(context,
        StatefulBuilder(builder: (BuildContext context, StateSetter setStater) {
          dialogState = setStater;
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0.0),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                    child: Text(
                      "Add Money",
                      style: Theme.of(this.context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: colors.black,),
                    ),
                  ),
                  const Divider(color: Colors.black),
                  Form(
                    key: _formkey,
                    child: Flexible(
                      child: SingleChildScrollView(
                          child:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      validator: (val) => validateAmount(val!, context),
                                      autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                      style: const TextStyle(
                                        color: colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Enter Amount",
                                        hintStyle: Theme.of(this.context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      controller: amtC,
                                    ),
                                ),
                              ]),
                      ),
                    ),
                  ),
                ]),
             actions: <Widget>[
               TextButton(
                  child: Text(
                    "Cancel",
                    style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
               TextButton(
                  child: Text(
                    "Add",
                    style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                        color: colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    final form = _formkey.currentState!;
                    if (form.validate() && amtC!.text!= '0') {
                      form.save();
                      double amount = double.parse(amtC!.text.toString());
                      openCheckout((amount));
                    }
                  })
            ],
          );
        }));
  }

  listItem(int index) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: colors.white,
            border: Border.all(color: colors.primary, width: 2),
            borderRadius: BorderRadius.circular(15)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
              decoration: const BoxDecoration(
                  color: colors.primary,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(13), topRight: Radius.circular(13))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('${transactionModel?.data?[index].dateCreated}',  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14, ),),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Image.asset('assets/images/transactions.png', height: 50, width: 50,),
                  // SizedBox(width: 15,),
                  SizedBox(
                    width: 200,
                    child: Text(
                      "${transactionModel?.data?[index].message.toString()}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: colors.black, fontWeight: FontWeight.normal, fontSize: 14),
                    ),
                  ),
                  SizedBox(width: 5,),
                  Text(
                      "₹ ${transactionModel?.data?[index].amount}",
                    style: TextStyle(color: colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Container(
            //       margin: EdgeInsets.only(right: 8, bottom: 8),
            //       padding: EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
            //       decoration: BoxDecoration(
            //         color: colors.black,
            //         borderRadius:  BorderRadius.all(
            //           const Radius.circular(4.0),
            //         ),
            //       ),
            //       child: walletTransactions[index].status == "1"
            //           ? Text("Completed",
            //         style: TextStyle(color: colors.white),
            //        )
            //           : Text(
            //         "Pending",
            //         style: TextStyle(color: colors.white),
            //       ),
            //     ),
            //   ],
            // )
          ],
        ),
      ),
      //     // walletTransactions[index].paymentAddress != null &&
      //     //     walletTransactions[index].paymentAddress!.isNotEmpty
      //     //     ? Text(getTranslated(context, "PaymentAddress")! +
      //     //         " : " +
      //     //         tranList[index].paymentAddress! +
      //     //         ".")
      //     //     : Container(),
      //     // tranList[index].paymentType != null &&
      //     //         tranList[index].paymentType!.isNotEmpty
      //     //     ? Text(getTranslated(context, "PaymentType")! +
      //     //         " : " +
      //     //         tranList[index].paymentType!)
      //     //     : Container(),
      //   ],
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
           children: [
            Stack(
              children:[
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 15,right: 15),
                    color:Colors.white,
                    height: MediaQuery.of(context).size.height /4,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20,),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                                child: const Icon(Icons.arrow_back_ios_new_sharp,size: 18, color: colors.black,)),
                            const Text("Wallet", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
                            // const Icon(Icons.more_vert),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                            child: Column(
                              children:  [
                                Text("AVAILABLE BALANCE",style: TextStyle(fontSize: 11,color: Colors.grey),),
                                const SizedBox(height: 3),
                                wallet_balance_added == null
                                    ?Text("₹"+ (wallet_balance ?? '0.0'),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                                    :Text("₹ $wallet_balance_added",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              ],
                            ),
                        ),
                      ],
                    ),
                  ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 130),
                  child: InkWell(
                    onTap: () {
                      _showDialog();
                    },
                    child: Center(
                      child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: colors.primary),
                          height: 45,
                          width: MediaQuery.of(context).size.width/3.5,
                          child: const Center(child: Text("Add Money", style: TextStyle(color: colors.white),),
                          ),
                      ),
                    ),
                  ),
                ),
            ],
            ),
          // SizedBox(height: 10,),
          //  Padding(
          //    padding: const EdgeInsets.only(left: 10),
          //    child: Text("Wallet Transaction", style: TextStyle(fontSize: 15, color: colors.black, fontWeight: FontWeight.w500),),
          //  ),
          // SizedBox(height: 20,),
          //    // transactionModel?.responseCode == "0"
          //    //     ? const Center(
          //    //   child: Text(
          //    //     "No Item", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          //    //   ),
          //    // )
          //    //     :
          //    ListView.builder(
          //      shrinkWrap: true,
          //      itemCount:  transactionModel?.data?.length,
          //      physics: NeverScrollableScrollPhysics(),
          //      itemBuilder: (context, index) {
          //        return listItem(index);
          //      },
          //    ),
      ],
    ))),
    );
  }
}
