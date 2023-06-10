import 'package:expense_proj/Constants/Constants.dart';
import 'package:expense_proj/provider/switch_theme_provider.dart';
import 'package:expense_proj/screens/add_expense/add_expense_page.dart';
import 'package:expense_proj/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Transcation_Page extends StatefulWidget {
  const Transcation_Page({super.key});

  @override
  State<Transcation_Page> createState() => _Transcation_PageState();
}

class _Transcation_PageState extends State<Transcation_Page> {
  var isLight;
  var dumyData = Constants.arrTranscations;

  @override
  Widget build(BuildContext context) {
    isLight = Theme.of(context).brightness == Brightness.light;
    return SafeArea(
      child: Scaffold(
        body:Column(
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 12,top: 6,bottom: 2),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Add_Expense_Page(),));
                      },
                      child: CircleAvatar(
                        backgroundColor: isLight ? Colors.black : Colors.white ,
              child: Icon(Icons.add,color: isLight ? Colors.white : Colors.black,),
            ),
                    ),
                  ),
                ) ),
            Expanded(
              flex: 5,
                child:totalBalanceUi() ),
            Expanded(
                flex : 9 ,
                child:Container(

                  child: ListView.builder(
                    itemCount: dumyData.length,
                    itemBuilder: (context, index) {
                    return  getAllTransactionDateWise(dumyData[index]);
                  },),
                ) ),
          ],
        ),
      ),
    );
  }

  Widget getAllTransactionDateWise(Map<String,dynamic> dayWiseData){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(dayWiseData['day'],style: mTextStyle12(mColor: Colors.grey),),
              Text('\₹${dayWiseData['amt']}',style: mTextStyle12(mColor: Colors.grey),)
            ],
          ),
         Container(
           height: 1,
           width: double.infinity,
           color: Colors.grey,
         ),
          mHeightSpacer(),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: (dayWiseData['Transcations']as List).length,
            itemBuilder: (context, index) {
            return getListOfAllTranscationAccToDate(dayWiseData['Transcations'][index]);
          },)
        ],
      ),
    );
  }
  Widget getListOfAllTranscationAccToDate(Map<String,dynamic>dateWiseTransaction){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [

          ListTile(
            leading: Image.asset('${dateWiseTransaction['image']}',height: 35,width: 35,),
            title:Text('${ dateWiseTransaction['title']}'),
            subtitle: Text('${dateWiseTransaction['desc']}'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\₹${dateWiseTransaction['amt']}'),
                Text('\₹${dateWiseTransaction['balance']}')

              ],

            ),

          ),


        ],
      ),
    );
  }


  Widget totalBalanceUi(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Spent Till Now',style: mTextStyle12(mColor: isLight ? Colors.black : Colors.white), ),
        mHeightSpacer(),
        RichText(text: TextSpan(
          children: [
            TextSpan(
              text: '\₹ ',
              style: mTextStyle24(mColor: isLight ? Colors.black : Colors.white,mFWeight: FontWeight.bold),
            ),
            TextSpan(
              text: '584',
              style: mTextStyle43(mColor: isLight ? Colors.black : Colors.white,mFWeight: FontWeight.bold),
            ),
            TextSpan(
              text: '\.40',
              style: mTextStyle24(mColor: isLight ? Colors.black : Colors.white,mFWeight: FontWeight.bold),
            )
          ]
        ))
      ],
    );
  }
}
