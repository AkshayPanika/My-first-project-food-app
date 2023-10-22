import 'package:flutter/material.dart';
import 'package:my_first_app/view_page/login_view/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../reusable_widget/text_field_widget.dart';
import '../home_view/PageViewList.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical:70.0,horizontal: 20),
                    child: Text("Welcome", style: TextStyle(fontSize:20, fontWeight: FontWeight.w600),),
                  ),

              Container(
                decoration:const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                  boxShadow:  [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius:1,
                      blurRadius:3,
                    )
                  ]
                ),
                height:MediaQuery.of(context).size.height,

                child:  Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Form(
                      key: _formKey,
                      child:Column(
                        children: [
                          const SizedBox(height:30,),
                          Center(
                            child: Card(
                                shape: OutlineInputBorder(borderRadius: BorderRadius.circular(8),
                                    borderSide:const BorderSide(color: Colors.grey)),
                                child:const Padding(
                                  padding:  EdgeInsets.all(10.0),
                                  child: Icon(Icons.person,size:38,),
                                )),
                          ),
                          const SizedBox(height:40,),

                          ///___ Enter user id
                          TextFormFieldWidget(
                            controller: nameController,
                            hintText: "Enter name",
                            iconData: Icons.person,
                            validator: "Please enter your name",
                          ),


                          ///___ Enter email id
                          TextFormFieldWidget(
                            controller: emailController,
                            hintText: "Enter email id",
                            iconData: Icons.email,
                            validator: "Please enter email id",
                          ),

                          ///___ Enter password
                          TextFormFieldWidget(
                            controller: passwordController,
                            hintText: "Enter password",
                            iconData: Icons.lock,
                            validator: "Please enter your password",
                          ),
                          const SizedBox(height:40,),

                          Consumer(builder: (context, value, child) {
                            return InkWell(
                              child:const Card(
                                color: Colors.black87,
                                elevation: 2,margin: EdgeInsets.symmetric(horizontal:35),
                                shape:OutlineInputBorder(),
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(vertical:10.0),
                                  child: Center(child: Text("Login",style: TextStyle(fontSize:22,fontWeight: FontWeight.w600,color:Colors.white),)),
                                ),
                              ),
                              onTap: ()async{
                                if(_formKey.currentState!.validate()){
                                  var sharedPref = await SharedPreferences.getInstance();
                                  sharedPref.setBool(SplashScreenState.LOGINKEY,true);
                                  sharedPref.setString("name", nameController.text.toString());
                                  sharedPref.setString("email", emailController.text.toString());

                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const PageViewList()));
                                }
                              },
                            );
                          },)
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
