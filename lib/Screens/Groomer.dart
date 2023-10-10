import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:muddypawsuser/Screens/DoctorDetails.dart';

import '../Custom/CustomTextFormField.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List listDetails = [
    {"name": "Dr. Joseph Williamson", "des": "Groomer at Woof n Purr"},
    {"name": "Dr. Anglina Taylor", "des": "Groomer at Woof n Purr"},
    {"name": "Dr. Anthony Peterson", "des": "Groomer at Woof n Purr"},
    {"name": "Dr. Eline George", "des": "Groomer at Woof n Purr"},
    {"name": "Dr. Joseph Williamson", "des": "Groomer at Woof n Purr"},
    {"name": "Dr. Anglina Taylor", "des": "Groomer at Woof n Purr"},
    {"name": "Dr. Anthony Peterson", "des": "Groomer at Woof n Purr"},
    {"name": "Dr. Eline George", "des": "Groomer at Woof n Purr"},
    {"name": "Dr. Joseph Williamson", "des": "Groomer at Woof n Purr"},
    {"name": "Dr. Anglina Taylor", "des": "Groomer at Woof n Purr"},
    {"name": "Dr. Anthony Peterson", "des": "Groomer at Woof n Purr"},
    {"name": "Dr. Eline George", "des": "Groomer at Woof n Purr"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomTextFormField(
                  name: 'Groomer',
                  width: double.infinity,
                  Icon: Icons.search,
                  hint: "Groomer",
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade200,
                child: const Text(
                  "27 Results found",
                  style: TextStyle(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    itemCount: listDetails.length,
                    separatorBuilder: (context, index) {
                      return Container(
                        height: 5,
                        color: Colors.grey.shade100,
                      );
                    },
                    itemBuilder: (context, index) {
                      return InkWell(
                        // onTap: () {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(builder: (context) => DoctorDetails()),
                        //  );
                        // },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.white,
                          ),
                          child:
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                    padding: EdgeInsets.all(5),
                                    // width: MediaQuery.of(context).size.width / 6.5,
                                    // height: MediaQuery.of(context).size.height / 14,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(9),
                                        child: Image.asset(
                                          "assets/images/doctor3.jpg",
                                          fit: BoxFit.fill,
                                        ))),
                              ),
                              Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        listDetails[index]['name'],
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        listDetails[index]['des'],
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Exp 22 Year  Fees \$30",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 5, bottom: 10),
                                child: Row(
                                  children: [
                                    RatingBar.builder(
                                      initialRating: 3,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 13,
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        size: 5,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                    Text(
                                      '(120)',
                                      style: TextStyle(fontSize: 10),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
