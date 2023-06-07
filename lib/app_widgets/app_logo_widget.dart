import 'package:flutter/material.dart';

import '../ui_helper.dart';

class Applogo_Widget extends StatelessWidget {
  MediaQueryData mq;

  Applogo_Widget({required this.mq});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor:AppColor.BtnColor,
      radius: mq.size.width*0.07,
      child: Padding(
        padding:  EdgeInsets.all(mq.size.width*0.03),
        child: Image.asset('assets/images/icon_filled.png',color: Colors.white,),
      ),
    );
  }
}
