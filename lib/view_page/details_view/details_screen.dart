import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/utils/card_model.dart';
import 'package:my_first_app/view_page/details_view/readmore_text.dart';
import 'package:provider/provider.dart';
import '../../reusable_widget/reusable_button.dart';
import '../../reusable_widget/text_styles.dart';
import '../../utils/card_provider.dart';
import '../../utils/db_helper.dart';
import '../../utils/favorite_provider.dart';
import '../cart_view/cart_screen.dart';
import '../favorite_view/favorite_screen.dart';
import 'add_topping.dart';
import 'favorite_icon_widget.dart';


class DetailsScreen extends StatefulWidget {
  final int index;
  final String productName;
  final String productTag;
  final String projectImage;
  final int initialPrice;
  final double ratting;
  const DetailsScreen({super.key, required this.index, required this.productName, required this.productTag, required this.projectImage, required this.initialPrice,  required this.ratting, });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  DBHelper? dbHelper = DBHelper();


  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      ///___ AppBar
      appBar: AppBar(
        backgroundColor:Colors.transparent,
        iconTheme:const IconThemeData(color: Colors.black87),
        elevation: 0,
        title: Text(widget.productName.toString(),style: headLineText,),
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
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const FavoriteScreen()));
                },
              );
            },
          ),
          const SizedBox(width:20,),
        ],
      ),
      ///___ Body
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ///___ Image container
            Stack(
              children: [
                CachedNetworkImage(
                  height: 330,
                  width: double.infinity,
                  imageUrl:widget.projectImage.toString(),fit: BoxFit.fill,
                  placeholder: (context, url) =>const CircularProgressIndicator(color: Colors.black87,),
                  errorWidget: (context, url, error) =>const Icon(Icons.image_not_supported_outlined,size:31,),
                ),

                ///___ Favorite icon
                Positioned(
                    bottom:10,right:15,
                  child: FavoriteIconWidget(
                    index:widget.index,
                  ),
                )
              ],
            ),

            ///___ Details container
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius:const BorderRadius.only(topLeft: Radius.circular(30)),
                  border: Border.all(color: Colors.black87)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:10.0,vertical:21),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///___ Name ratting text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(widget.productName.toString(),style:headLineText2),
                            const SizedBox(width:10,),
                            Text("- "+widget.productTag.toString(),style:headLineText2),
                          ],
                        ),
                        Row(
                          children: [
                            Text("${widget.ratting}",style:headLineText2),
                            const Icon(Icons.star,color: Colors.amber,size: 25,),
                          ],
                        )
                      ],
                    ),
                    Container(
                      margin:const EdgeInsets.symmetric(vertical:1),
                      height:1.6,width: 110,color: Colors.black,),
                    const SizedBox(height:15,),

                    ///___ Read more text
                    const ReadMoreTextWidget(),


                    ///___ Add topping
                     const AddToppingWidget(),
                    const  SizedBox(height:35,),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height:60,
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(width: 10,),
                Text("Price",style:headLineText),
                SizedBox(width: 10,),
                Text("${widget.initialPrice}"+".00 ₹",style: headLineText),
              ],
            ),
            SizedBox(width:30,),
            InkWell(
              onTap: (){
                dbHelper!.insert(
                    CardModel(
                        id: widget.index,
                        productName: widget.productName,
                        productTag: widget.productTag,
                        projectImage: widget.projectImage,
                        initialPrice: widget.initialPrice,
                        productPrice: widget.initialPrice,
                        quantity: 1,
                        ratting: widget.ratting)
                ).then((value) {
                  cartProvider.addTotalPrice(double.parse(widget.initialPrice.toString()));
                  cartProvider.addCounter();
                  print("Product is added to cart");
                }).onError((error, stackTrace) {
                  print(error.toString());
                });


                const snackBar = SnackBar(
                  content: Text("Product is added to card",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 19)),
                  duration: Duration(seconds:2),
                  backgroundColor: Colors.black87,
                  behavior: SnackBarBehavior.fixed,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child:const  Card(
                color: Colors.black87,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal:25.0,vertical:8),
                  child: Row(
                    children: [
                      Icon(Icons.local_grocery_store_outlined,color: Colors.white,size:20,),
                      SizedBox(width:8),
                      Text("Add To Cart",style: TextStyle(color: Colors.white,fontSize:17,fontWeight: FontWeight.w500),),

                    ],
                  ),
                ),
              ),
            )
          ],
        ) ,
      ),
    );
  }
}
