import 'dart:html';

import 'package:expense_proj/provider/switch_theme_provider.dart';
import 'package:expense_proj/screens/home/bloc/category/cat_bloc.dart';
import 'package:expense_proj/screens/home/bloc/expense/expense_bloc.dart';
import 'package:expense_proj/screens/home/repo/expense_repo.dart';
import 'package:expense_proj/screens/user_onboard/login_page.dart';
import 'package:expense_proj/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'database/my_db_helper.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Switch_Theme_Provider(),
        )
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider(
          create: (_) =>
              ExpenseBloc(repo: Expense_Repo(mdbHelper: My_Db_Helper())),
        ),
        BlocProvider(
          create: (context) =>
              CatBloc(repo: Expense_Repo(mdbHelper: My_Db_Helper())),
        )
      ], child: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<Switch_Theme_Provider>(
      builder: (ctx, provider, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          darkTheme: AppTheme.darkTheme(),
          theme: AppTheme.lightTheme(),
          themeMode: provider.getThemeMode() ? ThemeMode.dark : ThemeMode.light,
          home: Login_Page(),
        );
      },
    );
  }
}
