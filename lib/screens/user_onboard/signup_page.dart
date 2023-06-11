import 'package:expense_proj/database/models/user_model.dart';
import 'package:expense_proj/database/my_db_helper.dart';
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

  var formKey = GlobalKey<FormState>();


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
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(mq.size.width*0.02),
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom ),
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
                  TextFormField(
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'please fill the required blanks';
                      }
                    },
                    controller: firstNameController,
                    decoration: mInputDec(mhint: 'enter your first name', mlable: 'First Name'),
                  ),
                  mHeightSpacer(mHeight: mq.size.height*0.01),
                  TextFormField(
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'please fill the required blanks';
                      }
                    },
                    controller: lastNameController,
                    decoration: mInputDec(mhint: 'enter your last name', mlable: 'Last Name'),
                  ),
                  mHeightSpacer(mHeight: mq.size.height*0.01),
                  TextFormField(
                    validator: (value) {
                      if(value!.isEmpty){
                        return 'please fill the required blanks';
                      }
                    },
                    controller: emailController,
                    decoration: mInputDec(mhint: 'enter your email', mlable: 'E-mail',mPrefixIcon: Icons.email_outlined),
                  ),
                  mHeightSpacer(mHeight: mq.size.height*0.01),
                  TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'please fill the required blanks';
                      }
                    },
                    controller: passController,
                    decoration: mInputDec(mhint: 'enter your password', mlable: 'Password',mPrefixIcon: Icons.password_outlined,mSuffixIcon: Icons.visibility),
                  ),
                  mHeightSpacer(mHeight: mq.size.height*0.04),
                  Rounded_Btn(title: 'Create account', onPress: () async {
                    if(formKey.currentState!.validate()){
                      print('Signup done');
                    }
                   int check = await My_Db_Helper().SignUp(User_Model(
                      user_fname: firstNameController.text.toString(),
                      user_lname: lastNameController.text.toString(),
                      user_email: emailController.text.toString(),
                      user_pass: passController.text.toString(),

                    ));
                    if(check>0){
                      print('ac created sucessfully');
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login_Page(),));
                    }else if( check == 0){
                      print('db error');
                    }else if(check == -1){
                      print('already  existing ac');
                    }




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
            ),
          ),
        ),
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
