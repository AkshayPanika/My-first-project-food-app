

import 'package:flutter/material.dart';

class CardModel{

 late final int? id;
 final String? productName;
 final String? productTag;
 final String? projectImage;
 final int? initialPrice;
 final int? productPrice;
 final int? quantity;
 final double? ratting;

 CardModel({
  required this.id,
  required this.productName,
  required this.productTag,
  required this.projectImage,
  required this.initialPrice,
  required this.productPrice,
  required this.quantity,
  required this.ratting,
});

 CardModel.fromMap(Map<dynamic,dynamic>res)
 :id= res['id'],
      productName=res['productName'],
      productTag=res['productTag'],
      projectImage=res['projectImage'],
      initialPrice=res['initialPrice'],
      productPrice=res['productPrice'],
      quantity=res['quantity'],
      ratting=res['ratting'];

 Map<String, Object?> toMap(){
  return {
   'id':id,
   'productName':productName,
   'productTag':productTag,
   'projectImage':projectImage,
   'initialPrice':initialPrice,
   'productPrice':productPrice,
   'quantity':quantity,
   'ratting':ratting,
  };
 }
}