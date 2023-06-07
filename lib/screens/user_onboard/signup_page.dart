import 'package:expense_proj/screens/user_onboard/login_page.dart';
import 'package:flutter/material.dart';

import '../../app_widgets/app_logo_widget.dart';
import '../../app_widgets/bottom_onboard_stack_widget.dart';
import '../../app_widgets/rounded_btn.dart';
import '../../ui_helper.dart';

class SignUp_Page extends StatelessWidget {
  late MediaQueryData mq;

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var mobnoController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    print(mq.size.height);
    return Scaffold(
      backgroundColor: AppColor.AppBgColor,
      body:mq.orientation == Orientation.portrait? _PortraitLay(context) : _LandscapeLay(context)  ,
    );
  }

  Widget _MainLay(context){
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: mq.size.width*0.02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Applogo_Widget(mq: mq),
          mHeightSpacer(mHeight: mq.size.height*0.05),

          FittedBox(
              fit: BoxFit.scaleDown,
              child: Text('Hey Let\'s Get Started!, ',style: mTextStyle34(mFWeight: FontWeight.w800),)),
          FittedBox(
              fit : BoxFit.scaleDown,
              child: Text('start managing your expense with us ',style: mTextStyle18(mColor: Colors.grey),)),
          mHeightSpacer(mHeight: mq.size.height*0.04),
          TextField(
            controller: firstNameController,
            decoration: mInputDec(mhint: 'enter your first name', mlable: 'First Name'),
          ),
          mHeightSpacer(mHeight: mq.size.height*0.01),
          TextField(
            controller: lastNameController,
            decoration: mInputDec(mhint: 'enter your last name', mlable: 'Last Name'),
          ),
          mHeightSpacer(mHeight: mq.size.height*0.01),
          TextField(
            controller: emailController,
            decoration: mInputDec(mhint: 'enter your email', mlable: 'E-mail',mPrefixIcon: Icons.email_outlined),
          ),
          mHeightSpacer(mHeight: mq.size.height*0.01),
          TextField(
            controller: passController,
            decoration: mInputDec(mhint: 'enter your password', mlable: 'Password',mPrefixIcon: Icons.password_outlined,mSuffixIcon: Icons.visibility),
          ),
          mHeightSpacer(mHeight: mq.size.height*0.04),
          Rounded_Btn(title: 'Create account', onPress: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login_Page(),));
          }),
          mHeightSpacer(mHeight: mq.size.height*0.03),
          Container(
            width: double.infinity,
            color: Colors.grey,
            height: 1,
          ),
          mHeightSpacer(mHeight: mq.size.height*0.03),
          Btm_OnBoard_Stack(onPress: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login_Page(),));
          },title: 'Already a user , ', subtile: 'Login now', )
        ],


      ),
    );
  }

  Widget _PortraitLay(context){
    return LayoutBuilder(builder: (context, constraints) {
      return constraints.maxWidth > 300 ?
      _MainLay(context) : SingleChildScrollView(child: _MainLay(context),);

    },);
  }
  Widget _LandscapeLay(context){
    return Row(
      children: [
        Expanded(
            child: mq.size.height>550  ? _MainLay(context) : SingleChildScrollView(child: _MainLay(context))),
        Expanded(
          child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Image.asset('assets/images/login_landscape_bg.png')),
        )
      ],
    );
  }
}
