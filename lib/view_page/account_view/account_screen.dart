import 'package:flutter/material.dart';
import 'package:my_first_app/view_page/login_view/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/theme_provider.dart';
import '../login_view/login_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var nameValue= "";
  var emailValue= "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getName();
    getPassword();
  }
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    print("Account page ");
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color:isSwitched? Colors.white:Colors.black87),
        backgroundColor: Colors.transparent,elevation: 0,
      ),
      body:  Padding(
        padding:const EdgeInsets.symmetric(horizontal: 28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height:30,),
            const Center(
              child: CircleAvatar(
                radius:60,
                child: Icon(Icons.person,size: 55,),
              ),
            ),

            const SizedBox(height:30,),
             Text("Name.  "+nameValue,style:const TextStyle(fontSize:19,fontWeight: FontWeight.w500),),
            const SizedBox(height:5,),
            Text("Pass/No.  "+emailValue,style:const TextStyle(fontSize:19,fontWeight: FontWeight.w500),),
            const SizedBox(height:30,),
            Row(
              children: [
                const Text("[ Light/Dark ]",style: TextStyle(fontSize:19,fontWeight: FontWeight.w400),),
                Consumer<ThemeProvider>(builder: (context, value, child) {
                  return Switch(
                    value:isSwitched,
                    onChanged: (value) {
                      themeProvider.toggleTheme();
                      setState(() {
                        isSwitched= value;
                      });
                    },);
                },),
              ],
            ),
            const  SizedBox(height:100,),
            Center(
              child: InkWell(
                child: Container(
                  height:45,
                  width: 200,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                      color: Colors.black87,
                      border: Border.all(color:isSwitched? Colors.white: Colors.black87,width:1)),
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child:const  Center(
                    child: Text("LogOut",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.w600),),
                  ),
                ),
                onTap: ()async{
                  var sharedPref = await SharedPreferences.getInstance();
                  sharedPref.setBool(SplashScreenState.LOGINKEY, false);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  LoginScreen()));

                },
              ),
            )
          ],
        ),
      ),
    );
  }


  void getName()async{
    var sharedPref = await SharedPreferences.getInstance();
     var getName = sharedPref.getString("name");
     nameValue = getName ?? "User Name";
     setState(() {

     });
  }
  void getPassword()async{
    var sharedPref = await SharedPreferences.getInstance();
     var getPassword = sharedPref.getString("email");
     emailValue = getPassword ?? "User email";
     setState(() {

     });
  }
}
