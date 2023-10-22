import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier{
  ThemeData _themeData = ThemeData.light();
  ThemeData get themeData => _themeData;

  void toggleTheme(){
    final isLight = _themeData == ThemeData.dark();
    if(isLight){
      _themeData =ThemeData.light();
    }
    else{
      _themeData = ThemeData.dark();
    }
    notifyListeners();
  }
}