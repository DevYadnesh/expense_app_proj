import 'package:flutter/cupertino.dart';

class Switch_Theme_Provider extends ChangeNotifier {
  /// true for dark mode  ///
  /// false for light mode ///
  bool _isDarkTheme =  false;

  bool getThemeMode(){
    return _isDarkTheme;
  }

  void changeTheme (bool darkModeOn){
    _isDarkTheme = darkModeOn;
    notifyListeners();
  }
}