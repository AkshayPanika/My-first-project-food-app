import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_first_app/view_page/login_view/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_view/PageViewList.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}
class SplashScreenState extends State<SplashScreen> {


  static const String LOGINKEY = 'login';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    whereToGo();
  }
  @override
  Widget build(BuildContext context) {
    return const  Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height:45,),
            Center(
              child: Text("Welcome", style: TextStyle(fontSize:30, fontWeight: FontWeight.w600),
              ),
            ),
            Column(
              children: [
                Center(
                  child: SizedBox(
                      height: 30,width: 30,
                      child: CircularProgressIndicator(color: Colors.black87,)),
                ),
                SizedBox(height:50,),
              ],
            ),

          ],
        ),
      ),
    );
  }

  void whereToGo()async{
  var sharedPref = await SharedPreferences.getInstance();
  var isLogin = sharedPref.getBool(LOGINKEY);

  Timer(const Duration(seconds:1),(){
   if(isLogin!=null){
     if(isLogin){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const PageViewList()));
     }
     else{
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
     }
   }
   else{
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
   }
  }
  );
  }
}
