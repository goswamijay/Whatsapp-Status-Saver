import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:switcher_button/switcher_button.dart';

import 'ThemeModel.dart';

class DarkThemeMain extends StatefulWidget {
  const DarkThemeMain({Key? key}) : super(key: key);

  @override
  State<DarkThemeMain> createState() => _DarkThemeMainState();
}

class _DarkThemeMainState extends State<DarkThemeMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<ThemeModel>(
            builder: (context, ThemeModel themeNotifier, child) {
              return SwitcherButton(
                value: themeNotifier.isDark ? false : true,
                onChange: (value) {
                  themeNotifier.isDark
                      ? themeNotifier.isDark == false : themeNotifier.isDark ==
                      true;
                },
              );
            }
        ),
      ),
    );
  }
}
