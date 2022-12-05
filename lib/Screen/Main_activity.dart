import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:switcher_button/switcher_button.dart';
import 'package:whatsapp_status_saver/Screen/BottomNavPage/Video/Video.dart';

import '../Provider/bottom_nav_provider.dart';
import '../Utils/ThemeModel.dart';
import 'BottomNavPage/Image/Image.dart';

class MainActivity extends StatefulWidget {
  const MainActivity({Key? key}) : super(key: key);

  @override
  State<MainActivity> createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  List<Widget> pages = [ImageHomePage(), VideoHomePage()];
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder: (context, nav, child) {
        return Scaffold(
          body: pages[nav.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              nav.ChangeIndex(value);
            },
            currentIndex: nav.currentIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.image), label: "Image"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.videocam), label: "Video"),
            ],
          ),
        );
      },
    );
  }
}
