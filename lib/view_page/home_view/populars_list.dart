import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../reusable_widget/my_stores.dart';
import '../../reusable_widget/text_styles.dart';
import '../../utils/favorite_provider.dart';
import '../details_view/details_screen.dart';

class PopularsList extends StatelessWidget {
  const PopularsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const  EdgeInsets.only(top: 15,bottom: 10,left: 5),
          child:  Text("Populars list",style:headLineText2),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height*1.6,
          width: 500,
          child: GridView.builder(
            itemCount:MyStore.length,
            physics:const NeverScrollableScrollPhysics(),
            gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing:10,
              mainAxisSpacing:15,
              childAspectRatio: 2/2.5,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailsScreen(
                    index:index,
                    productName:MyStore[index]["productName"].toString() ,
                    projectImage:MyStore[index]["projectImage"].toString() ,
                    productTag: MyStore[index]["productTag"].toString(),
                    initialPrice:MyStore[index]["initialPrice"] ,
                    ratting:MyStore[index]["ratting"] ,
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
                            child: CachedNetworkImage(imageUrl:MyStore[index]["projectImage"].toString(),fit: BoxFit.fill,
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
                                Text(MyStore[index]["productName"].toString(),style:titleText),
                                Row(
                                  children: [
                                    Text(MyStore[index]["ratting"].toString(),style:titleText),
                                    const Icon(Icons.star,size:18,color: Colors.amber,),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin:const EdgeInsets.symmetric(horizontal:5),
                            child: Row(
                              children: [
                                Text("Price "+MyStore[index]["initialPrice"].toString()+" ₹",style:titleText),
                                const SizedBox(width:10,),
                                Text(MyStore[index]["productTag"].toString(),style:titleText),
                              ],
                            ),
                          ),
                          const SizedBox(height:10,)
                        ],
                      ),
                    ),

                    /// ___ Favorite icon
                    Positioned(
                        top:2,right:2,
                        child:Consumer<FavoriteProvider>(builder: (context, value, child) {
                         return IconButton(
                            onPressed: (){
                              value.toggleFavoriteItem(index);
                            },
                            icon:Icon(
                              value.selectedFavoriteItem.contains(index)?
                              Icons.favorite:
                              Icons.favorite_border,size:28,color: Colors.red,),
                          );
                        },)
                    )
                  ],
                ),
              );
            },),
        ),
      ],
    );
  }
}
