import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view_page/account_view/account_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height:50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(onPressed: (){}, icon:Icon(Icons.home,size:27,)),
          IconButton(onPressed: (){}, icon:Icon(Icons.search,size: 27,)),
          IconButton(onPressed: (){}, icon:Icon(Icons.notifications_active,size: 27,)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const AccountScreen()));
          }, icon:Icon(Icons.account_circle,size: 27,)),
        ],
      ),
    );
  }
}
