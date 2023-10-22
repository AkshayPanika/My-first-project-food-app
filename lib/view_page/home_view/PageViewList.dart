import 'package:flutter/material.dart';

import '../account_view/account_screen.dart';
import '../google_view/order_tracking.dart';
import 'home_screen.dart';

class PageViewList extends StatefulWidget {
  const PageViewList({super.key});

  @override
  State<PageViewList> createState() => _PageViewListState();
}
class _PageViewListState extends State<PageViewList> {
  int  selectedBottomNavigationBar = 0;
  var PageViewList = [const HomeScreen(),const OrderScreen(),const AccountScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:Center(child: PageViewList[selectedBottomNavigationBar],) ,

      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(label: "Home",icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "Location",icon: Icon(Icons.location_on)),
          BottomNavigationBarItem(label: "Account",icon: Icon(Icons.account_box)),
        ],
        selectedItemColor: Colors.black,
        currentIndex: selectedBottomNavigationBar,
        onTap: (isValue){
          setState(() {
            selectedBottomNavigationBar= isValue;
          });
        },
      ),

    );
  }
}
