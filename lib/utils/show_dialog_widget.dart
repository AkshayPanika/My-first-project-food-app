import 'package:flutter/material.dart';

import '../reusable_widget/text_styles.dart';

class ShowDialogWidget extends StatelessWidget {
  const ShowDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Card(
              elevation: 2,
              child: Icon(Icons.person,size: 45,color: Colors.grey,))),
          Text("UPI Pay",style:TextStyle(fontSize: 20,fontWeight:FontWeight.w500,color: Colors.black87,)),
        ],
      ),
      titleTextStyle:headLineText,
      content:const TextField(
        decoration: InputDecoration(
            hintText: "Enter upi id"
        ),
      ),
      actions:const [
        Card(
            color: Colors.black87,
            child:Padding(
              padding:  EdgeInsets.symmetric(horizontal:25.0,vertical:5),
              child:  Text("Cancel",style: TextStyle(fontSize:15,fontWeight: FontWeight.w500,color: Colors.white)),
            )),
        Card(
            color: Colors.black87,
            child:Padding(
              padding:  EdgeInsets.symmetric(horizontal:25.0,vertical:5),
              child:  Text("Pay",style: TextStyle(fontSize:15,fontWeight: FontWeight.w500,color: Colors.white)),
            )),
      ],
    );
  }
}
