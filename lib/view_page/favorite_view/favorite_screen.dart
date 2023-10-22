import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../reusable_widget/my_stores.dart';
import '../../reusable_widget/reusable_button.dart';
import '../../reusable_widget/text_styles.dart';
import '../../utils/card_provider.dart';
import '../../utils/favorite_provider.dart';
import '../cart_view/cart_screen.dart';
import '../details_view/details_screen.dart';


class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight:60,
        backgroundColor:Colors.transparent,
        iconTheme:const IconThemeData(color: Colors.black87),
        elevation: 0,
        title:const Text("My Favorite"),
        titleTextStyle:headLineText,
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
                onTap: (){},
              );
            },
          ),
          const SizedBox(width:20,),
        ],
      ),

      body: Consumer<FavoriteProvider>(builder: (context, value, child) {
        return  Container(
          height:MediaQuery.of(context).size.height+0.9,
          width: 500,
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: GridView.builder(
            itemCount:value.selectedFavoriteItem.length,
            gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing:10,
              mainAxisSpacing:10,
              childAspectRatio: 2/2.5,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsScreen(
                    index:index,
                    productName:MyStore[value.selectedFavoriteItem[index]]["productName"].toString() ,
                    projectImage:MyStore[value.selectedFavoriteItem[index]]["projectImage"].toString() ,
                    productTag: MyStore[value.selectedFavoriteItem[index]]["productTag"].toString(),
                    initialPrice:MyStore[value.selectedFavoriteItem[index]]["initialPrice"] ,
                    ratting:MyStore[value.selectedFavoriteItem[index]]["ratting"] ,
                  )));
                },
                child: Stack(
                  children: [
                    Card(
                      elevation:4,
                      shape:const OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CachedNetworkImage(imageUrl:MyStore[value.selectedFavoriteItem[index]]["projectImage"].toString(),fit: BoxFit.fill,
                              width: double.infinity,
                              placeholder:(context, url) => const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(Icons.image_not_supported_outlined,size: 21,),
                            ),
                          ),
                          Container(
                            margin:const EdgeInsets.symmetric(horizontal:5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(MyStore[value.selectedFavoriteItem[index]]["productName"].toString(),style:titleText),
                                Row(
                                  children: [
                                    Text(MyStore[value.selectedFavoriteItem[index]]["ratting"].toString(),style:titleText),
                                    const Icon(Icons.star,size: 21,color: Colors.amber,),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin:const EdgeInsets.symmetric(horizontal:5),
                            child: Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Price "+MyStore[value.selectedFavoriteItem[index]]["initialPrice"].toString()+" ₹",style:titleText),
                                const SizedBox(width:10,),
                                Text(MyStore[value.selectedFavoriteItem[index]]["productTag"].toString(),style:titleText),
                              ],
                            ),
                          ),
                          const SizedBox(height:10,)
                        ],
                      ),
                    ),
                    Positioned(
                        top:2,right:2,
                      child: IconButton(
                        onPressed: (){
                          value.deleteForFavoritePage(index);
                        },
                        icon:const Icon(Icons.favorite,
                          size:28,color: Colors.red,),
                      ),
                    )
                  ],
                ),
              );
            },),
        );
      },)
    );
  }
}
