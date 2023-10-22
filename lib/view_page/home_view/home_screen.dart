import 'package:flutter/material.dart';
import 'package:my_first_app/view_page/favorite_view/favorite_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../../reusable_widget/reusable_button.dart';
import '../../reusable_widget/text_styles.dart';
import '../../utils/card_provider.dart';
import '../../utils/favorite_provider.dart';
import '../cart_view/cart_screen.dart';
import 'carousel_slider.dart';
import 'categories_list.dart';
import 'populars_list.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var nameValue= "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getName();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight:60,
        backgroundColor:Colors.transparent,
        iconTheme:const IconThemeData(color: Colors.black87),
        elevation: 0,
        title:Row(
         children: [
           const Card(child: Icon(Icons.person,size: 20,),),
           const SizedBox(width:5,),
            Text("Hi, "+nameValue,style: const TextStyle(color: Colors.red,fontSize:15,fontWeight: FontWeight.w500,fontStyle:FontStyle.italic),),
         ],
            ),
        actions: [
          ///___ Shopping_cart
          Consumer<CartProvider>(
            builder: (context, value, child) {
              return  ReusableButton(
                title: value.getCounter().toString(),
                iconData:Icons.shopping_cart,
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const cart_screen()));
                },
              );
            },
          ),
          ///___ Favorite cart
          const SizedBox(width:15),
          Consumer<FavoriteProvider>(
            builder: (context, value, child) {
              return  ReusableButton(
                title:value.selectedFavoriteItem.length.toString(),
                iconData:Icons.favorite,
                onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>const FavoriteScreen()));
                },
              );
            },
          ),
          const SizedBox(width:20,),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///___ * Image CarouselSlider
              const SizedBox(height:10,),
              const CarouselSliderWidget(),

              ///___ * Categories headline
               Padding(
                padding: const EdgeInsets.only(top: 25,bottom: 10,left: 5),
                child:  Text("Categories",style: headLineText2,),
              ),
              StickyHeader(

                ///___ * Categories
                  header:const CategoriesList(),

                  ///___ * Populars list
                  content:const PopularsList(),
              ),

            ],
          ),
        ),
      ),
    );
  }

  void getName()async{
    var sharedPref = await SharedPreferences.getInstance();
    var getName = sharedPref.getString("name");
    nameValue = getName ?? "User Name";
    setState(() {});
  }
}
