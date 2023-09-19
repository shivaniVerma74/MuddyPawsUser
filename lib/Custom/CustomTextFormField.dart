import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {


   CustomTextFormField({Key? key, required this.name, required this.width, this.hint, this.controller,
     this.validString,this.Icon,this.validator}) : super(key: key);
  final String name;
   final String? Function(String?)? validator;
   final double width;
  final String? hint;
  IconData? Icon;
  final TextEditingController? controller;
  final String? validString;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode.unfocus();
  }
  FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return  Container(
       height: MediaQuery.of(context).size.height/14.7,
      width: widget.width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.indigo[100]),
      child: Center(
        child: TextFormField(
          validator: widget.validator,
          // enabled: false,
          focusNode: _focusNode,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(widget.Icon),
            // fillColor: Color(0x25888888),
           // filled: true,
            hintText: widget.hint,
          ),
        ),
      ),
    );
  }
}
