import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_first_app/reusable_widget/text_styles.dart';

import '../../reusable_widget/my_stores.dart';

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount:adsList.length,
      options: CarouselOptions(
          autoPlay: true,
          disableCenter: true,
          viewportFraction:1
      ),
      itemBuilder: (context, index, realIndex) {
        return  Card(
          elevation:4,
          shape:const OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
          child:Stack(
            children: [
              CachedNetworkImage(
                width: double.infinity,
                imageUrl:adsList[index]["image"],fit: BoxFit.fill,
                placeholder: (context, url) =>const Center(child:  CircularProgressIndicator()),
                errorWidget: (context, url, error) =>const Center(child: Icon(Icons.image_not_supported_outlined,size: 21,)),
              ),
               Positioned(
                  bottom: 20,left:15,
                  child: Card(
                      elevation: 1,
                      child: Padding(
                        padding:const EdgeInsets.symmetric(vertical:5,horizontal: 25),
                        child: Text(adsList[index]['headLine'],style:headLineText2),
                      )))
            ],
          ),
        );
      },
    );
  }
}
