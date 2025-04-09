import 'dart:async';

import 'package:bloodintern/view/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login/applogin.dart';

class Splash extends StatefulWidget {

  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext){
        return Loginscreen();
      }));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body: Center(
          child:Image.asset("assets/images/bloodsplash.png",width: 500,height: 500, )

      ),

    );
  }
}
