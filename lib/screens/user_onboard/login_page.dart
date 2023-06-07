

import 'package:expense_proj/app_widgets/app_logo_widget.dart';
import 'package:expense_proj/app_widgets/bottom_onboard_stack_widget.dart';
import 'package:expense_proj/app_widgets/rounded_btn.dart';
import 'package:expense_proj/screens/user_onboard/signup_page.dart';
import 'package:expense_proj/ui_helper.dart';
import 'package:flutter/material.dart';

import '../home_page.dart';

class Login_Page extends StatelessWidget {

  var emailController = TextEditingController();
  var passController = TextEditingController();

  late MediaQueryData mq;


  @override
  Widget build(BuildContext context) {
     mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: AppColor.AppBgColor,
      body:mq.orientation == Orientation.portrait? _PortraitLay(context) : _LandscapeLay(context)  ,
    );
  }

  Widget _MainLay(context){
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: mq.size.width*0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Applogo_Widget(mq: mq),
          mHeightSpacer(mHeight: mq.size.height*0.05),

          Text('Hello again, ',style: mTextStyle43(mFWeight: FontWeight.w800),),
          Text('manage your expense in one click',style: mTextStyle18(mColor: Colors.grey),),
          mHeightSpacer(mHeight: mq.size.height*0.04),
          TextField(
            decoration: mInputDec(mhint: 'enter your email', mlable: 'E-mail',mPrefixIcon: Icons.email_outlined),
          ),
          mHeightSpacer(mHeight: mq.size.height*0.01),
          TextField(
            decoration: mInputDec(mhint: 'enter your email', mlable: 'Password',mPrefixIcon: Icons.password_outlined,mSuffixIcon: Icons.visibility),
          ),
          mHeightSpacer(mHeight: mq.size.height*0.04),
          Rounded_Btn(title: 'Login', onPress: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home_Page(),));
          }),
          mHeightSpacer(mHeight: mq.size.height*0.03),
          Container(
            width: double.infinity,
            color: Colors.grey,
            height: 1,
          ),
          mHeightSpacer(mHeight: mq.size.height*0.03),
          Btm_OnBoard_Stack(onPress: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp_Page(),));
          },title: 'Don\'t have account, ', subtile: 'create one', )
        ],


      ),
    );
  }

  Widget _PortraitLay(context){
    return LayoutBuilder(builder: (context, constraints) {
      return constraints.maxWidth > 300 ?
      _MainLay(context) : Container();

    },);
  }
  Widget _LandscapeLay(context){
    return Row(
      children: [
        Container(
            width: mq.size.width/2,
            child: _MainLay(context)),
        Container(
          width: mq.size.width/2,
        )
      ],
    );
  }
}
