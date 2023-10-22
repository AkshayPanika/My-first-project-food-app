import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Track"),
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 19,color: Colors.black87,fontWeight: FontWeight.w500),
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width:MediaQuery.of(context).size.width,
              decoration:const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://i.pcmag.com/imagery/articles/01IB0rgNa4lGMBlmLyi0VP6-6..v1611346416.png",),fit: BoxFit.cover,
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(onPressed: (){
                    showModalBottomSheet(context: context,
                      builder: (context) {
                        return SizedBox(
                          height: 300,
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child:const Icon(Icons.keyboard_arrow_down,color: Colors.black87,size: 35,),
                              ),
                              const SizedBox(height: 20,),
                                ///___ Name text
                                Row(
                                children: [
                                  const SizedBox(width:20,),
                                 Card(
                                   color: Colors.grey[400],
                                   shape: Border.all(color: Colors.black87),
                                   child:const SizedBox(
                                     height:45,
                                     width:45,
                                     child: Center(child:Icon(Icons.person,size: 35,)),
                                   ),
                                 ),
                                  const SizedBox(width:10,),
                                  const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Hasbi Rahaman",style:TextStyle(fontSize:19),),
                                      Text("91 0000 0000 00",style:TextStyle(fontSize:16,color: Colors.black54),),
                                    ],
                                  ),
                                  const SizedBox(width:60,),
                                  const  Card(
                                    color: Colors.black87,
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Icon(Icons.chat,color: Colors.white,),
                                    ),
                                  ),
                                  const SizedBox(width:5,),
                                  const Card(
                                    color: Colors.black87,
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Icon(Icons.call,color: Colors.white,),
                                    ),
                                  ),
                                  const SizedBox(width:0,),
                                ],
                              ),

                              const SizedBox(height: 20,),
                              ///___ Address text
                              Row(
                                children: [
                                  const SizedBox(width:20,),
                                  Card(
                                     color: Colors.grey[400],
                                    shape: Border.all(color: Colors.black87),
                                    child:const SizedBox(
                                      height:45,
                                      width:45,
                                      child: Center(child:Icon(Icons.location_on,size: 35,)),
                                    ),
                                  ),
                                  const SizedBox(width:10,),
                                  const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("On way 25 Mins",style:TextStyle(fontSize:19),),
                                      Text("Your address",style:TextStyle(fontSize:18,color: Colors.black54),),
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(height:40,),
                              const Card(
                                shadowColor: Colors.black87,
                                margin: EdgeInsets.symmetric(horizontal:30),
                                  color: Colors.black87,
                                  child: Padding(
                                    padding:  EdgeInsets.symmetric(vertical:15.0),
                                    child: Center(child: Text("Order Received",style:TextStyle(fontSize:19,fontWeight: FontWeight.w500,color: Colors.white),)),
                                  ))
                            ],
                          ),
                        );
                      },);
                  }, icon: Icon(Icons.keyboard_double_arrow_up,color: Colors.black,size: 35,shadows: [BoxShadow(color: Colors.black,spreadRadius: 15,blurRadius: 15)]),)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
