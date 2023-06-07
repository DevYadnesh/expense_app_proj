import 'dart:html';

import 'package:expense_proj/provider/switch_theme_provider.dart';
import 'package:expense_proj/screens/user_onboard/login_page.dart';
import 'package:expense_proj/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      MultiProvider(
          providers: [
    ChangeNotifierProvider(create: (context) => Switch_Theme_Provider(),

    )
  ],
        child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<Switch_Theme_Provider>(builder: (ctx, provider, child) {
      return MaterialApp(
        title: 'Flutter Demo',
        darkTheme:AppTheme.darkTheme(),
        theme:AppTheme.lightTheme(),
        themeMode: provider.getThemeMode() ? ThemeMode.dark : ThemeMode.light,
        home:Login_Page() ,
      );
    },);
  }
}

