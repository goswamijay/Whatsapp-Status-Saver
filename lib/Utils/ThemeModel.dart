import 'package:flutter/cupertino.dart';
import 'package:whatsapp_status_saver/Utils/theme_shared_prefrences.dart';

class ThemeModel extends ChangeNotifier{
  late bool _isDark;
  late ThemeSharePrefrences themeSharePrefrences;
  bool get isDark => _isDark;


  ThemeModel(){
    _isDark = false;
    themeSharePrefrences = ThemeSharePrefrences();
    getThemePrefrences();
  }
  set _isDarks(bool value){
    _isDark = value;
    themeSharePrefrences.setTheme(value);
    notifyListeners();
  }
  getThemePrefrences() async{
    _isDark = await themeSharePrefrences.getTheme();
    notifyListeners();
  }
}