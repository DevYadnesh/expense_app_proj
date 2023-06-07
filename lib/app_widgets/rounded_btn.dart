import 'package:expense_proj/ui_helper.dart';
import 'package:flutter/material.dart';

class Rounded_Btn extends StatelessWidget {

  String title;
  double mWidth;
  double mHeight;
  VoidCallback onPress;
  Color mColor ;
  IconData? mIcon;
  Rounded_Btn({
    required this.title,
    required this.onPress,
    this.mWidth = double.infinity,
    this.mHeight = 50,
    this.mColor = AppColor.BtnColor,
    this.mIcon
});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: mHeight,
      width: mWidth,
      child: ElevatedButton(
          onPressed: onPress,
          child: mIcon!= null ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(mIcon),
              mWidthSpacer(),
              Text(title)
            ],
          ) :Text(title),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          backgroundColor: mColor,
        ),

      ),
    );
  }
}
