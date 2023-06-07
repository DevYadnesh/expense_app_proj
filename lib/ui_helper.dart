import 'package:flutter/material.dart';

class AppColor {
 ////////// Light Theme //////////
  static const BtnColor = Color(0xff111727);
  static const TxtColor = Color(0xff111727);
  static const AppBgColor =Color(0xffffffff);
///////// Dark Theme ////////////
  static const AppDarkbgColor = Color(0xff111727);
  static const AppDarkBtnColor =Color(0xffffffff);
}


class AppTheme{
  static ThemeData darkTheme () {

    return ThemeData(
      brightness:  Brightness.dark,
  textTheme: TextTheme(
  displayLarge: mTextStyle43(mColor: Colors.white,mFWeight: FontWeight.w800),
  titleSmall: mTextStyle16(mColor: Colors.white),
  displayMedium: mTextStyle34(mColor: Colors.white,mFWeight: FontWeight.w600),
  displaySmall: mTextStyle18(mColor: Colors.white,mFWeight: FontWeight.w300)
  ),
  scaffoldBackgroundColor: Colors.black
  );
}
  static ThemeData lightTheme (){

    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.light,
      textTheme: TextTheme(
          displayLarge: mTextStyle43(mColor: Colors.black,mFWeight: FontWeight.w800),
          displayMedium: mTextStyle34(mColor: Colors.black,mFWeight: FontWeight.w600),
          displaySmall: mTextStyle18(mColor: Colors.black,mFWeight: FontWeight.w300),
        titleSmall: mTextStyle16(mColor: Colors.black),
      ),
    );
}
}










Widget mWidthSpacer ({
   double mWidth = 10,
}){
  return SizedBox(width: mWidth,);
}

Widget mHeightSpacer ({
  double mHeight = 10,
}){
  return SizedBox(height: mHeight,);
}

InputDecoration mInputDec({
 required String mhint ,
 required String mlable,
  Color mColor = const Color(0xFFD7D1D1),
  IconData? mPrefixIcon,
  IconData? mSuffixIcon,
}){
  return InputDecoration(
    prefixIcon:mPrefixIcon!=null ? Icon(mPrefixIcon) : null,
    suffixIcon:mSuffixIcon!=null ? Icon(mSuffixIcon):null,
    hintText:mhint ,
    label: Text(mlable),
    filled: true,
    fillColor:mColor ,
    enabledBorder: mOutBorder(mColor: Colors.white),
    focusedBorder: mOutBorder()
  );
}

OutlineInputBorder mOutBorder ({
  double radius = 20,
  Color mColor = AppColor.TxtColor
}){
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(radius),
    borderSide: BorderSide(
      color: mColor,
      width: 2,
    ),
  );
}












TextStyle mTextStyle43({
  FontWeight  mFWeight = FontWeight.normal,
  Color mColor = AppColor.TxtColor
}){
  return TextStyle(
    fontFamily: ' Poppins',
    color: mColor,
    fontSize: 43,
    fontWeight: mFWeight
  );
}
TextStyle mTextStyle34({
  FontWeight  mFWeight = FontWeight.normal,
  Color mColor = AppColor.TxtColor
}){
  return TextStyle(
      fontFamily: ' Poppins',
      color: mColor,
      fontSize: 34,
      fontWeight: mFWeight
  );
}
TextStyle mTextStyle20({
  FontWeight  mFWeight = FontWeight.normal,
  Color mColor = AppColor.TxtColor
}){
  return TextStyle(
      fontFamily: ' Poppins',
      color: mColor,
      fontSize: 20,
      fontWeight: mFWeight
  );
}
TextStyle mTextStyle12({
  FontWeight  mFWeight = FontWeight.normal,
  Color mColor = AppColor.TxtColor
}){
  return TextStyle(
      fontFamily: ' Poppins',
      color: mColor,
      fontSize: 12,
      fontWeight: mFWeight
  );
}
TextStyle mTextStyle18({
  FontWeight  mFWeight = FontWeight.normal,
  Color mColor = AppColor.TxtColor
}){
  return TextStyle(
      fontFamily: 'Poppins',
      color: mColor,
      fontSize: 18,
      fontWeight: mFWeight
  );
}
TextStyle mTextStyle24({
  FontWeight  mFWeight = FontWeight.normal,
  Color mColor = AppColor.TxtColor
}){
  return TextStyle(
      fontFamily: ' Poppins',
      color: mColor,
      fontSize: 24,
      fontWeight: mFWeight
  );
}
TextStyle mTextStyle16({
  FontWeight  mFWeight = FontWeight.normal,
  Color mColor = AppColor.TxtColor
}){
  return TextStyle(
      fontFamily: ' Poppins',
      color: mColor,
      fontSize: 16,
      fontWeight: mFWeight
  );
}