import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_status_saver/Screen/Main_activity.dart';

class Sparce_screen extends StatefulWidget {
  const Sparce_screen({Key? key}) : super(key: key);

  @override
  State<Sparce_screen> createState() => _Sparce_screenState();
}

class _Sparce_screenState extends State<Sparce_screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Navigate();
  }

  void Navigate() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (_) => const MainActivity()),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color.fromRGBO(7,94,84,1),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('Assets/Logo.png',height: 200,width: 200,),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text("WHATSAPP STATUS SAVER",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: 'RobotoMono',fontWeight: FontWeight.bold),),
            )
          ],
        )
      ),
    );
  }
}
