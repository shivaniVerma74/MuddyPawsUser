import 'package:flutter/material.dart';

class CustomGridView extends StatefulWidget {

  final String itemcount;
  final String mainaxis;
  const CustomGridView({Key? key, required this.itemcount, required this.mainaxis}) : super(key: key);
  @override
  State<CustomGridView> createState() => _CustomGridViewState();
}

class _CustomGridViewState extends State<CustomGridView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 7,
              // width: MediaQuery.of(context).size.width / 17,
              child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  //physics: NeverScrollableScrollPhysics(),
                  itemCount: int.parse(widget.itemcount),
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 1,mainAxisExtent: double.parse(widget.mainaxis)
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.all(4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: InkWell(
                        onTap: (){
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>AllProduct()));
                        },
                        child: Container(
                          width: 20,
                          // height:30,
                          //  MediaQuery.of(context).size.height * 50,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset("assets/images/logo/Group 170.png",fit: BoxFit.cover,)),
                        ),
                      ),
                    );
                  }),
            ),

          ],
        ),
      );
  }
}
