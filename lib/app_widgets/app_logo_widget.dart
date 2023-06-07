import 'package:flutter/material.dart';

import '../ui_helper.dart';

class Applogo_Widget extends StatelessWidget {
  MediaQueryData mq;
  Color? mIconColor;
  Color? mBgColor;

  Applogo_Widget({required this.mq,this.mBgColor,this.mIconColor});
  @override
  Widget build(BuildContext context) {
    var ThemeMode = Theme.of(context).brightness == Brightness.light ;
    return CircleAvatar(
      backgroundColor:mBgColor ?? (ThemeMode ? AppColor.AppDarkbgColor : Colors.white),
      radius: mq.size.width*0.05,
      child: Padding(
        padding:  EdgeInsets.all(mq.size.width*0.02),
        child: Image.asset('assets/images/icon_filled.png',color: ThemeMode ? Colors.white : AppColor.AppDarkbgColor,),
      ),
    );
  }
}
