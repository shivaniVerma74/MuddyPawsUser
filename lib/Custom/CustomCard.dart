import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String title2;
  final String title3;
  final String image;
  IconData? icon;

  // final String subtitle;
  // final IconData icon;

  CustomCard(
      {required this.title,
      this.icon,
      required this.title2,
      required this.title3,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/8,
      color: Colors.white,
      padding: const EdgeInsets.all(14.0),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height/10,
            width: MediaQuery.of(context).size.height/10,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),

            child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(image,fit: BoxFit.cover)),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 23,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 150,
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 14.5,
                      //  color: colors.blacktextColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 150,
                ),
                Text(
                  title2,
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 150,
                ),
                Text(
                  overflow: TextOverflow.ellipsis,
                  title3,
                  style: TextStyle(
                      fontSize: 12,
                      //  color: colors.blacktextColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 12,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 22,
            width: MediaQuery.of(context).size.width / 11,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.blue[100],
            ),
            child: Icon(Icons.close),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 27,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 22,
            width: MediaQuery.of(context).size.width / 11,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.blue,
            ),
            child: Icon(
              Icons.check,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCard2 extends StatelessWidget {
  final String title;
  final String title2;
  IconData?icon;

  // final String subtitle;
  // final IconData icon;

  CustomCard2({
    required this.title,
    required this.title2,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width / 2.15,
      height: MediaQuery.of(context).size.height / 8.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 45,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  title2,
                  style: TextStyle(color: Colors.grey,fontSize: 11),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 22,
              ),
              Icon(icon,color: Colors.grey[200],size: 30,),
            ],
          ),
        ],
      ),
    );
  }
}


class CustomCard3 extends StatelessWidget {
  final String title;


  // final String subtitle;
  // final IconData icon;

  CustomCard3({
    required this.title,

  });

  @override
  Widget build(BuildContext context) {
    return  Container(padding: EdgeInsets.all(14),
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 15,
      // width: MediaQuery.of(context).size.width / 1.3,
      decoration:
      BoxDecoration(borderRadius: BorderRadius.circular(4),color: Colors.white),
      child: Text(
        title,
        style:
        TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
    );
  }
}


class CustomCard4 extends StatelessWidget {
  final String title;
  final String title2;
   final String title3;
   String? image;
  final Color? color;
  IconData? icon;

  // final String subtitle;
  // final IconData icon;

  CustomCard4(
      {required this.title,
        this.icon,
        required this.title2,
        required this.title3,
         this.image,
      required this.color
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/8,
      color: Colors.white,
      padding: const EdgeInsets.all(14.0),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height/12,
            width: MediaQuery.of(context).size.height/12,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(60),color: color),

            child: Icon(icon,color: Colors.blue[700],size: 27,),
            // child: ClipRRect(
            //     borderRadius: BorderRadius.circular(10.0),
            //     child: Image.asset(image,fit: BoxFit.cover)),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 23,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 150,
                ),
                Text(
                  overflow: TextOverflow.ellipsis,

                  title,
                  style: TextStyle(
                      fontSize: 14.5,
                      //  color: colors.blacktextColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 150,
                ),
                Text(
                  overflow: TextOverflow.ellipsis,

                  title2,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 150,
                ),
                Text(
                  overflow: TextOverflow.ellipsis,
                  title3,
                  style: TextStyle(
                      fontSize: 12,
                      //  color: colors.blacktextColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // SizedBox(
          //   width: MediaQuery.of(context).size.width / 12,
          // ),
          // Container(
          //   height: MediaQuery.of(context).size.height / 22,
          //   width: MediaQuery.of(context).size.width / 11,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(6),
          //     color: Colors.blue[100],
          //   ),
          //   child: Icon(Icons.close),
          // ),
          // SizedBox(
          //   width: MediaQuery.of(context).size.width / 27,
          // ),
          // Container(
          //   height: MediaQuery.of(context).size.height / 22,
          //   width: MediaQuery.of(context).size.width / 11,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(6),
          //     color: Colors.blue,
          //   ),
          //   child: Icon(
          //     Icons.check,
          //     color: Colors.white,
          //   ),
          // ),
        ],
      ),
    );
  }
}


class CustomCard5 extends StatelessWidget {
  final String title;
  final String title2;
  final String title3;
  final String title4;


  // final String subtitle;
  // final IconData icon;

  CustomCard5(
      {required this.title,
        required this.title2,
        required this.title3,
        required this.title4,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/8,
      color: Colors.white,
      padding: const EdgeInsets.all(14.0),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          SizedBox(
            width: MediaQuery.of(context).size.width / 23,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                color: Colors.yellow,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height / 150,
                    // ),
                    Text(
                      overflow: TextOverflow.ellipsis,

                      title,
                      style: TextStyle(
                          fontSize: 14.5,
                          //  color: colors.blacktextColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 150,
                    ),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      title2,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),

                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
              ),
              Container(
                child: Column(
                  children: [
                    Text(
                      overflow: TextOverflow.ellipsis,
                      title3,
                      style: TextStyle(
                          fontSize: 12,
                          //  color: colors.blacktextColor,
                          fontWeight: FontWeight.bold),
                    ),

                    Text(
                      overflow: TextOverflow.ellipsis,
                      title4,
                      style: TextStyle(
                          fontSize: 12,
                          //  color: colors.blacktextColor,
                          fontWeight: FontWeight.bold),
                    ),

                  ],
                ),
              ),
            ],
          ),
          // SizedBox(
          //   width: MediaQuery.of(context).size.width / 12,
          // ),
          // Container(
          //   height: MediaQuery.of(context).size.height / 22,
          //   width: MediaQuery.of(context).size.width / 11,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(6),
          //     color: Colors.blue[100],
          //   ),
          //   child: Icon(Icons.close),
          // ),
          // SizedBox(
          //   width: MediaQuery.of(context).size.width / 27,
          // ),
          // Container(
          //   height: MediaQuery.of(context).size.height / 22,
          //   width: MediaQuery.of(context).size.width / 11,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(6),
          //     color: Colors.blue,
          //   ),
          //   child: Icon(
          //     Icons.check,
          //     color: Colors.white,
          //   ),
          // ),
        ],
      ),
    );
  }
}