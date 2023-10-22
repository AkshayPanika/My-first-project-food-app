
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:my_first_app/reusable_widget/text_styles.dart';

class ReusableButton extends StatelessWidget {
  final String title;
  final IconData iconData;
  final VoidCallback onTap;
  const ReusableButton({super.key, required this.iconData, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child:InkWell(
          onTap: onTap,
          child:  Center(
            child: badges.Badge(
              badgeStyle:const badges.BadgeStyle(badgeColor: Colors.white,padding: EdgeInsets.all(5)),
              badgeContent:Text(title,style:headLineText),
              child: Icon(iconData,color: Colors.black87,size:25,),
            ),
          )) ,
    );
  }
}