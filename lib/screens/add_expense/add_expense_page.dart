import 'package:expense_proj/app_widgets/rounded_btn.dart';
import 'package:expense_proj/database/models/expense_model.dart';
import 'package:expense_proj/screens/home/bloc/category/cat_bloc.dart';
import 'package:expense_proj/screens/home/bloc/expense/expense_bloc.dart';
import 'package:expense_proj/screens/home/home_page.dart';
import 'package:expense_proj/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../database/models/expense_cat_model.dart';

class Add_Expense_Page extends StatefulWidget {
  @override
  State<Add_Expense_Page> createState() => _Add_Expense_PageState();
}

class _Add_Expense_PageState extends State<Add_Expense_Page> {
  var selectedIndex = -1;

  var titleController = TextEditingController();
  var descController = TextEditingController();
  var amountController = TextEditingController();
  bool isLoading = false;

  var listDropDownItems = ['Debit', 'Credit'];
  late String selectedDropDownValue;
 late List<Category_Model>? categoryData;

  @override
  void initState() {
    super.initState();
    selectedDropDownValue = listDropDownItems[0];
    BlocProvider.of<CatBloc>(context).add(GetCatEvent());
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
        children: [
            TextField(
              controller: titleController,
              decoration: mInputDec(mhint: 'Enter your title', mlable: 'Title'),
            ),
            mHeightSpacer(),
            TextField(
              controller: descController,
              decoration: mInputDec(mhint: 'Enter your desc', mlable: 'Desc'),
            ),
            mHeightSpacer(),
            TextField(
              controller: amountController,
              decoration: mInputDec(mhint: 'Enter your amount', mlable: 'Amount'),
            ),
            mHeightSpacer(),
            BlocBuilder<CatBloc, CatState>(
              builder: (context, state) {
                if (state is CatLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CatLoadedState) {
                  categoryData = state.listCat;
                  return Center(
                      child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(21))),
                        builder: (context) {

                          return Container(
                            height: mq.size.height * 0.7,
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,


                                  ),
                              itemCount: categoryData!.length,
                              itemBuilder: (ctx, index) {
                                return InkWell(
                                  onTap: () {
                                    selectedIndex = index;
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        "${categoryData![index].path}",
                                        height: 65,
                                        width: 65,
                                      ),
                                      mHeightSpacer(),
                                      Text("${categoryData![index].title}")
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                    child: selectedIndex == -1
                        ? (Text("Choose expense type"))
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(categoryData![selectedIndex].path!,height: 50,
                                width: 50,),
                              mWidthSpacer(),
                              Text(categoryData![selectedIndex].title!)
                            ],
                          ),
                  ));
                } else if (state is CatErrorState) {
                  return Center(
                    child: Text("error"),
                  );
                } else {
                  return Container();
                }
              },
            ),
            DropdownButton(
              value: selectedDropDownValue,
                items: listDropDownItems
                    .map((expenseType) => DropdownMenuItem(
                        value: expenseType, child: Text(expenseType)))
                    .toList(),
                onChanged: (value) {
                  selectedDropDownValue = value!;
                setState(() {

                });
                }),
            BlocBuilder<ExpenseBloc,ExpenseState>(
              builder: (context, state) {
                if(state is ExpenseLoadingState){
                  isLoading = true;


                }else if(state is ExpenseLoadedState){
                  isLoading = false;


                }else if(state is ExpenseErrorState){
                  isLoading = false;

                }
                return Rounded_Btn(

                    title: isLoading ? 'Expense Adding..' : 'Add Expense',
                    isLoading : isLoading,
                    onPress: () async {
                      if(selectedIndex!=-1 && categoryData!=null ){
                        var balanceTillNow = 0;
                        int amt = int.parse(amountController.text.toString());
                        var prefs = await SharedPreferences.getInstance();

                        var newExpense = Expense_Model(
                          user_id:  prefs.getInt('u_id'),
                          expense_title: titleController.text.toString(),
                          expense_desc: descController.text.toString(),
                          expense_amount: amt,
                          expense_balance: selectedDropDownValue == 'Debit' ? balanceTillNow-amt : balanceTillNow+amt,
                          expense_cat: categoryData![selectedIndex].id,
                          expense_type: selectedDropDownValue == 'Debit' ? 1 :2,
                          expense_date: DateTime.now().toString(),
                        );
                        BlocProvider.of<ExpenseBloc>(context).add(AddExpenseEvent(newExpense: newExpense));
                      }
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home_Page(),));
                    });

            }, )

        ],
      ),
          )),
    );
  }
}
