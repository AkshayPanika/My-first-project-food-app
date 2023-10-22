import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/view_page/favorite_view/favorite_screen.dart';
import 'package:provider/provider.dart';
import '../../reusable_widget/reusable_button.dart';
import '../../reusable_widget/reusable_text.dart';
import '../../reusable_widget/text_styles.dart';
import '../../utils/card_model.dart';
import '../../utils/card_provider.dart';
import '../../utils/db_helper.dart';
import '../../utils/favorite_provider.dart';
import '../../utils/show_dialog_widget.dart';

class cart_screen extends StatefulWidget {
  const cart_screen({super.key,});

  @override
  State<cart_screen> createState() => _cart_screenState();
}

class _cart_screenState extends State<cart_screen> {
  DBHelper? dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    final cartProvider =Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black87),
        toolbarHeight:70,elevation: 0,
        title:const Text("My Cart"),
        titleTextStyle:headLineText,
        actions: [
          Consumer<CartProvider>(
            builder: (context, value, child) {
              return  ReusableButton(
                title: value.getCounter().toString(),
                iconData:Icons.shopping_cart,
                onTap: (){},
              );
            },
          ),
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
      body: Column(
        children: [
          Consumer<CartProvider>(builder: (context, value, child) {
            return FutureBuilder(
              future:value.getData(),
              builder: (context,AsyncSnapshot<List<CardModel>> snapshot){
                if(snapshot.hasData){
                  if(snapshot.data!.isEmpty){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height:135,),

                        ///______ Cart is Empty
                        Center(
                          child: SizedBox(
                              height: 250,
                              child: Image.asset("assets/images/Empty.png")),
                        ),
                        Text("Cart is Empty",style: headLineText,)
                      ],
                    );
                  }
                  else{
                    return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index){
                            return Card(
                              elevation:4,
                              shape:const OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
                              margin:const EdgeInsets.all(8),
                              //shadowColor: Colors.black,
                              child:Stack(
                                children: [
                                  Row(
                                    children: [
                                      CachedNetworkImage(
                                        height:180, width:180,
                                        imageUrl:snapshot.data![index].projectImage.toString(),fit: BoxFit.fill,
                                        errorWidget: (context, url, error) =>const Icon(Icons.image_not_supported_outlined,color: Colors.red,),
                                        placeholder: (context, url) => const CircularProgressIndicator(color: Colors.black87,),
                                      ),
                                      const SizedBox(width:10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(snapshot.data![index].productName.toString(),style:headLineText2,),
                                          const SizedBox(height:5,),
                                          Row(
                                            children: [
                                              Text("Price."+snapshot.data![index].initialPrice.toString()+" ₹  ",style: titleText,),
                                              Text(snapshot.data![index].productTag.toString(),style: titleText,),
                                            ],
                                          ),
                                          const SizedBox(height:5,),
                                          Row(
                                            children: [
                                              Text(snapshot.data![index].ratting.toString(),style: titleText,),
                                              const Icon(Icons.star,color: Colors.amber,size: 20,)
                                            ],
                                          ),

                                          const SizedBox(height:30,),
                                        ],
                                      ),
                                    ],
                                  ),

                                  ///____ Delete Button
                                  Consumer<CartProvider>(builder: (context, value, child) {
                                    return Positioned(
                                        right: 10,
                                        top: 10,
                                        child: IconButton(
                                          onPressed: (){
                                            dbHelper!.delete(snapshot.data![index].id!);
                                            value.removeCounter();
                                            value.removeTotalPrice(double.parse(snapshot.data![index].productPrice.toString()));

                                            ///___ SnackBar
                                            const snackBar = SnackBar(
                                              content: Text("Product is removed to card",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 19)),
                                              duration: Duration(seconds:2),
                                              backgroundColor: Colors.black87,
                                              behavior: SnackBarBehavior.fixed,
                                            );
                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                          },
                                          icon:const Icon(Icons.delete,size:30,),
                                        ));
                                  },),

                                  ///____ Count Button
                                  Consumer<CartProvider>(builder: (context, value, child) {
                                    return Positioned(
                                      right: 0,
                                      bottom:3,
                                      child: Card(
                                        elevation: 1,
                                        shape:const OutlineInputBorder(),
                                        child: Row(
                                          children: [
                                            IconButton(onPressed:(){
                                              int quantity = snapshot.data![index].quantity!;
                                              int price = snapshot.data![index].initialPrice!;
                                              quantity--;
                                              int? newPrice = price * quantity;

                                              if(quantity>0){
                                                dbHelper!.updateQuantity(
                                                    CardModel(
                                                        id: snapshot.data![index].id!,
                                                        productName: snapshot.data![index].productName!,
                                                        productTag: snapshot.data![index].productTag!,
                                                        projectImage: snapshot.data![index].projectImage!,
                                                        initialPrice: snapshot.data![index].initialPrice!,
                                                        productPrice: newPrice,
                                                        quantity: quantity,
                                                        ratting: snapshot.data![index].ratting!)
                                                ).then((value) {
                                                  newPrice=0;
                                                  quantity=0;
                                                  cartProvider.removeTotalPrice(double.parse(snapshot.data![index].initialPrice!.toString(),));
                                                }).onError((error, stackTrace){
                                                  print(error.toString());
                                                });
                                              }

                                            }, icon:const Icon(Icons.remove,size:30,)),
                                            const SizedBox(width: 20,),
                                            Text(snapshot.data![index].quantity.toString(),style: headLineText2,),
                                            const SizedBox(width: 20,),
                                            IconButton(onPressed:(){
                                              int quantity = snapshot.data![index].quantity!;
                                              int price = snapshot.data![index].initialPrice!;
                                              quantity++;
                                              int? newPrice = price * quantity;

                                              if(quantity>0){
                                                dbHelper!.updateQuantity(
                                                    CardModel(
                                                        id: snapshot.data![index].id!,
                                                        productName: snapshot.data![index].productName!,
                                                        productTag: snapshot.data![index].productTag!,
                                                        projectImage: snapshot.data![index].projectImage!,
                                                        initialPrice: snapshot.data![index].initialPrice!,
                                                        productPrice: newPrice,
                                                        quantity: quantity,
                                                        ratting: snapshot.data![index].ratting!)
                                                ).then((value) {
                                                  newPrice=0;
                                                  quantity=0;
                                                  cartProvider.addTotalPrice(double.parse(snapshot.data![index].initialPrice!.toString(),));
                                                }).onError((error, stackTrace){
                                                  print(error.toString());
                                                });
                                              }
                                            }, icon:const Icon(Icons.add,size:30,)),
                                          ],
                                        ),
                                      ),
                                    );
                                  },)
                                ],
                              ),
                            );
                          },
                        ));
                  }
                }
                return const Text('Added Cart');
              },
            );
          },),

          ///___ReusableText
         Card(
           //shape:const OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
           child: Consumer<CartProvider>(builder: (context, value, child) {
             return  Visibility(
               visible: value.getTotalPrice().toStringAsFixed(2)=="0.00"?false:true,
               child: Column(
                 children: [
                   const SizedBox(height:25,),
                   Text("Do you have an discount code ?",style: headLineText,),
                   const SizedBox(height:35,),
                   ReusableText(title: 'Total Items', value: value.getCounter().toString()),
                   const SizedBox(height:10,),
                   const ReusableText(title: 'Discount 5%', value: '0',),
                   const SizedBox(height:10,),
                   ReusableText(title: 'Total Price', value: value.getTotalPrice().toString()+" ₹",),
                   const SizedBox(height:20,),
                   InkWell(
                     child:const  Card(
                       color: Colors.black87,
                       child: Padding(
                         padding: EdgeInsets.symmetric(vertical:8),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Icon(Icons.credit_card_sharp,color: Colors.white,size:20,),
                             SizedBox(width:8),
                             Text("Go To Pay",style: TextStyle(color: Colors.white,fontSize:17,fontWeight: FontWeight.w500),),

                           ],
                         ),
                       ),
                     ),
                     onTap: (){
                       showDialog(
                         context: context,
                         builder: (context) => const ShowDialogWidget(),
                         );
                     },
                   ),

                 ],
               ),
             );
           },),
         ),
        ],
      ),
    );
  }
  }


