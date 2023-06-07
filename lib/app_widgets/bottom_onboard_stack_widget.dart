import 'package:flutter/material.dart';


import '../ui_helper.dart';

class Btm_OnBoard_Stack extends StatelessWidget {
  String? title;
  String? subtile;
  VoidCallback onPress;

   Btm_OnBoard_Stack({
    required this.onPress,
    this.title,
    this.subtile
});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title!,style: mTextStyle18(mColor: Colors.grey),),
        InkWell(
            onTap: onPress,
            child: Text(subtile!,style: mTextStyle18(mColor: Colors.blue),))
      ],
    );
  }
}
