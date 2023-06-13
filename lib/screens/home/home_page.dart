import 'package:expense_proj/ui_helper.dart';
import 'package:flutter/material.dart';

import 'frag_pages/stats_graph_page.dart';
import 'frag_pages/transcation_page.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {

  var selectedIndex =0;
  var isLight;


  var arrFrags = [
    Transcation_Page(),
    Satats_Graph_Page()

  ];


  @override
  Widget build(BuildContext context) {
    isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      body: arrFrags[selectedIndex],
      bottomNavigationBar:getBottomNav() ,

    );
  }

  Widget getBottomNav(){
    return  BottomNavigationBar(
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
    currentIndex: selectedIndex,
    selectedIconTheme: IconThemeData(
      size: 25
    ),
    unselectedIconTheme: IconThemeData(size: 19),
    onTap: (index){
        selectedIndex = index;
        setState(() {

        });
    },
      backgroundColor: isLight ? Colors.white : AppColor.BtnColor,
    items:[
    BottomNavigationBarItem(
    icon:Icon( Icons.account_balance_wallet_outlined,
      color: isLight ? Colors.black : Colors.white,),
    label: '',
    activeIcon: Icon( Icons.account_balance_wallet,
      color: isLight ? Colors.black : Colors.white,),
    ),
    BottomNavigationBarItem(
    icon:Icon( Icons.stacked_bar_chart_outlined,
      color: isLight ? Colors.black : Colors.white,),
    label: '',
    activeIcon: Icon( Icons.stacked_bar_chart,
      color: isLight ? Colors.black : Colors.white,),),
    ] );
  }

}
